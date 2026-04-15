from __future__ import annotations

import os
import shutil
import subprocess
import sys
import tempfile
from io import BytesIO
from pathlib import Path

import pytest
from kaitaistruct import KaitaiStream


def _repo_root() -> Path:
    return Path(__file__).resolve().parents[2]


def _mdlops_exe() -> Path:
    return _repo_root() / "vendor" / "MDLOps" / "mdlops.exe"


def _pykotor_src_dir() -> Path:
    return _repo_root() / "vendor" / "PyKotor" / "Libraries" / "PyKotor" / "src"


def _fixture_dir() -> Path:
    return (
        _repo_root()
        / "vendor"
        / "PyKotor"
        / "Libraries"
        / "PyKotor"
        / "tests"
        / "test_files"
        / "mdl"
    )


def _generated_kit_dir() -> Path:
    return (
        _repo_root()
        / "vendor"
        / "PyKotor"
        / "Libraries"
        / "PyKotor"
        / "tests"
        / "test_files"
        / "generated_kit"
    )


def _fixtures() -> list[tuple[Path, Path]]:
    # Default: small, fast fixture set.
    # Opt-in: include the much larger generated_kit corpus by setting BIOWARE_MDLOPS_FULL=1.
    d = _fixture_dir()
    out: list[tuple[Path, Path]] = []
    for mdl_path in sorted(d.glob("*.mdl")):
        mdx_path = mdl_path.with_suffix(".mdx")
        if mdx_path.exists():
            out.append((mdl_path, mdx_path))

    if os.environ.get("BIOWARE_MDLOPS_FULL", "").strip() in {
        "1",
        "true",
        "TRUE",
        "yes",
        "YES",
    }:
        gd = _generated_kit_dir()
        if gd.exists():
            for mdl_path in sorted(gd.rglob("*.mdl")):
                mdx_path = mdl_path.with_suffix(".mdx")
                if mdx_path.exists():
                    out.append((mdl_path, mdx_path))

    dedup: dict[tuple[str, str], tuple[Path, Path]] = {}
    for mdl_path, mdx_path in out:
        dedup[(str(mdl_path), str(mdx_path))] = (mdl_path, mdx_path)
    return list(dedup.values())


def _run(
    cmd: list[str], *, cwd: Path, timeout_s: int = 120
) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        cmd,
        cwd=str(cwd),
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        timeout=timeout_s,
        check=False,
    )


def _import_kaitai_module(name: str):
    root = _repo_root()
    kaitai_dir = root / "src" / "python" / "kaitai_generated"
    sys.path.insert(0, str(kaitai_dir))
    try:
        return __import__(name)
    finally:
        sys.path.pop(0)


@pytest.mark.parametrize("mdl_path,mdx_path", _fixtures(), ids=lambda p: Path(p).name)
def test_kaitai_parses_mdlops_ascii_from_fixture(
    mdl_path: Path, mdx_path: Path
) -> None:
    """
    "Roundtrip" (compat loop) for the Kaitai ASCII parser:

    fixture binary (MDL+MDX) -> MDLOps -> ASCII -> Kaitai `mdl_ascii` parses
    """
    mdlops = _mdlops_exe()
    if not mdlops.exists():
        pytest.skip("MDLOps not present at vendor/MDLOps/mdlops.exe")

    mdl_ascii = _import_kaitai_module("mdl_ascii")

    with tempfile.TemporaryDirectory(prefix="bioware-mdl-kaitai-ascii-") as td_s:
        td = Path(td_s)
        src_mdl = td / mdl_path.name
        src_mdx = td / mdx_path.name
        shutil.copyfile(mdl_path, src_mdl)
        shutil.copyfile(mdx_path, src_mdx)

        r = _run([str(mdlops), str(src_mdl)], cwd=td, timeout_s=120)
        assert r.returncode == 0, f"MDLOps failed decompiling fixture: {r.stdout}"

        ascii_path = td / f"{src_mdl.stem}-ascii.mdl"
        assert ascii_path.exists() and ascii_path.stat().st_size > 0
        ascii_bytes = ascii_path.read_bytes()

        parsed = mdl_ascii.MdlAscii(KaitaiStream(BytesIO(ascii_bytes)))
        assert len(parsed.lines) > 0
        # Kaitai python runtime returns `str` for `type: str` fields; treat as text.
        text = "".join(line.content for line in parsed.lines).lower()
        assert "newmodel" in text
        assert "beginmodelgeom" in text


@pytest.mark.parametrize("mdl_path,mdx_path", _fixtures(), ids=lambda p: Path(p).name)
def test_kaitai_parses_pykotor_binary_written_from_mdlops_ascii(
    mdl_path: Path, mdx_path: Path
) -> None:
    """
    "Roundtrip" (compat loop) spanning MDLOps + PyKotor + Kaitai:

    fixture binary -> MDLOps ASCII -> PyKotor (read ASCII, write binary) -> Kaitai `mdl` parses binary
    """
    mdlops = _mdlops_exe()
    if not mdlops.exists():
        pytest.skip("MDLOps not present at vendor/MDLOps/mdlops.exe")

    mdl = _import_kaitai_module("mdl")

    # Import PyKotor from vendored source tree.
    sys.path.insert(0, str(_pykotor_src_dir()))
    try:
        try:
            from pykotor.resource.formats.mdl.mdl_auto import read_mdl, write_mdl
            from pykotor.resource.type import ResourceType
        except ImportError as e:
            pytest.skip(f"PyKotor or its dependencies unavailable: {e}")
    finally:
        sys.path.pop(0)

    with tempfile.TemporaryDirectory(prefix="bioware-mdl-kaitai-bin-") as td_s:
        td = Path(td_s)
        src_mdl = td / mdl_path.name
        src_mdx = td / mdx_path.name
        shutil.copyfile(mdl_path, src_mdl)
        shutil.copyfile(mdx_path, src_mdx)

        # MDLOps: binary -> ascii
        r1 = _run([str(mdlops), str(src_mdl)], cwd=td, timeout_s=120)
        assert r1.returncode == 0, f"MDLOps failed decompiling fixture: {r1.stdout}"
        ascii_path = td / f"{src_mdl.stem}-ascii.mdl"
        assert ascii_path.exists() and ascii_path.stat().st_size > 0

        # PyKotor: ASCII -> binary
        mdl_obj = read_mdl(ascii_path, file_format=ResourceType.MDL_ASCII)
        assert mdl_obj is not None
        out_dir = td / "pykotor_out"
        out_dir.mkdir(parents=True, exist_ok=True)
        out_mdl = out_dir / src_mdl.name
        out_mdx = out_dir / src_mdx.name
        write_mdl(mdl_obj, out_mdl, ResourceType.MDL, target_ext=out_mdx)
        assert out_mdl.exists() and out_mdl.stat().st_size > 0
        assert out_mdx.exists()

        # Kaitai: parse PyKotor binary
        parsed = mdl.Mdl(KaitaiStream(BytesIO(out_mdl.read_bytes())))
        assert parsed.file_header.mdl_size > 0
        assert parsed.model_header.geometry.node_count >= 0
        assert parsed.model_header.geometry.model_name != ""
