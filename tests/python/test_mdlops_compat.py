from __future__ import annotations

import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

import pytest


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

    if os.environ.get("BIOWARE_MDLOPS_FULL", "").strip() in (
        "1",
        "true",
        "TRUE",
        "yes",
        "YES",
    ):
        gd = _generated_kit_dir()
        if gd.exists():
            # Keep deterministic ordering.
            for mdl_path in sorted(gd.rglob("*.mdl")):
                mdx_path = mdl_path.with_suffix(".mdx")
                if mdx_path.exists():
                    out.append((mdl_path, mdx_path))

    # Avoid accidental duplicates if corpuses overlap.
    dedup: dict[tuple[str, str], tuple[Path, Path]] = {}
    for mdl_path, mdx_path in out:
        dedup[(str(mdl_path), str(mdx_path))] = (mdl_path, mdx_path)
    return list(dedup.values())


def _run(
    cmd: list[str],
    *,
    cwd: Path,
    timeout_s: int = 120,
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


def _first_diff(a: bytes, b: bytes) -> int | None:
    n = min(len(a), len(b))
    for i in range(n):
        if a[i] != b[i]:
            return i
    if len(a) != len(b):
        return n
    return None


def _bytes_context(blob: bytes, offset: int, window: int = 64) -> str:
    lo = max(0, offset - window)
    hi = min(len(blob), offset + window)
    return blob[lo:hi].decode("utf-8", errors="replace")


def _find_mdlops_ascii_output(
    *,
    cwd: Path,
    stem: str,
    extra_dirs: list[Path] | None = None,
) -> Path | None:
    """
    MDLOps output location can vary (some builds emit into CWD, others alongside the input path).
    Find the expected '<stem>-ascii.mdl' in either location, with a small fallback glob.
    """
    search_dirs: list[Path] = [cwd, *(extra_dirs or [])]

    # Preferred: exact expected filename in any candidate directory.
    for d in search_dirs:
        p = d / f"{stem}-ascii.mdl"
        if p.exists() and p.stat().st_size > 0:
            return p

    # Fallback: some edge builds might alter casing or add extra suffixes.
    for d in search_dirs:
        for p in d.glob(f"{stem}-ascii*.mdl"):
            if p.exists() and p.stat().st_size > 0:
                return p

    return None


@pytest.mark.parametrize("mdl_path,mdx_path", _fixtures(), ids=lambda p: Path(p).name)
def test_pykotor_can_read_mdlops_ascii_and_write_binary(
    mdl_path: Path,
    mdx_path: Path,
) -> None:
    """
    MDLOps is treated as a compatibility target ("source of truth") for practical interchange:

    1) Decompile fixture binary (MDL+MDX) to MDLOps ASCII
    2) Parse that MDLOps ASCII with PyKotor
    3) Write back to binary with PyKotor
    4) Ensure MDLOps can decompile the PyKotor-written binary again (i.e., MDLOps accepts it)
    """
    mdlops = _mdlops_exe()
    if not mdlops.exists():
        pytest.skip("MDLOps not present at vendor/MDLOps/mdlops.exe")

    # Import PyKotor from vendored source tree.
    sys.path.insert(0, str(_pykotor_src_dir()))
    try:
        try:
            from pykotor.resource.formats.mdl import read_mdl, write_mdl
            from pykotor.resource.type import ResourceType
        except ImportError as e:
            pytest.skip(f"PyKotor or its dependencies unavailable: {e}")
    finally:
        sys.path.pop(0)

    with tempfile.TemporaryDirectory(prefix="bioware-mdlops-") as td_s:
        td = Path(td_s)
        src_mdl = td / mdl_path.name
        src_mdx = td / mdx_path.name
        shutil.copyfile(mdl_path, src_mdl)
        shutil.copyfile(mdx_path, src_mdx)

        # 1) MDLOps: binary -> ascii
        r1 = _run([str(mdlops), str(src_mdl)], cwd=td, timeout_s=120)
        assert r1.returncode == 0, f"MDLOps failed decompiling fixture: {r1.stdout}"

        ascii_path = td / f"{src_mdl.stem}-ascii.mdl"
        assert ascii_path.exists() and ascii_path.stat().st_size > 0, f"MDLOps did not emit expected ASCII output for {src_mdl.stem}: {ascii_path}"
        ascii_orig = ascii_path.read_bytes()

        # 2) PyKotor: parse MDLOps ASCII
        mdl_obj = read_mdl(ascii_path, file_format=ResourceType.MDL_ASCII)
        assert mdl_obj is not None, f"Failed to parse MDLOps ASCII as model: {ascii_path}"

        # 3) PyKotor: write binary
        # IMPORTANT: MDLOps ASCII includes filename-derived metadata (e.g. filedependancy line).
        # To make MDLOps decompile output comparable, emit the PyKotor binary under the same stem.
        out_dir = td / "pykotor_out"
        out_dir.mkdir(parents=True, exist_ok=True)
        out_mdl = out_dir / src_mdl.name
        out_mdx = out_dir / src_mdx.name
        write_mdl(mdl_obj, out_mdl, ResourceType.MDL, target_ext=out_mdx)
        assert out_mdl.exists() and out_mdl.stat().st_size > 0, f"Failed to write PyKotor binary: {out_mdl}"
        # Some models (e.g. camera-only) can legitimately produce empty MDX output.
        assert out_mdx.exists(), f"Failed to write PyKotor binary: {out_mdx}"

        # 4) MDLOps: binary -> ascii (ensure MDLOps accepts PyKotor output)
        r2 = _run([str(mdlops), str(out_mdl)], cwd=td, timeout_s=120)
        assert r2.returncode == 0, f"MDLOps failed decompiling PyKotor binary: {r2.stdout}"

        out_ascii = td / f"{out_mdl.stem}-ascii.mdl"
        assert out_ascii.exists() and out_ascii.stat().st_size > 0, f"Failed to write PyKotor binary: {out_ascii}"
        ascii_round = out_ascii.read_bytes()

        # Component equality check: parse the roundtrip ASCII and compare with original parsed model
        mdl_obj_round = read_mdl(out_ascii, file_format=ResourceType.MDL_ASCII)
        assert mdl_obj_round is not None, f"Failed to parse PyKotor-written binary as ASCII: {out_ascii}"
        assert mdl_obj == mdl_obj_round, f"Model component mismatch after roundtrip for {mdl_path.name}.\nOriginal model parsed from MDLOps ASCII differs from model parsed from PyKotor-written binary."

        # Strongest check: compare MDLOps decompiles of (original binary) vs (PyKotor-written binary).
        # If PyKotor writing is truly compatible/idempotent under MDLOps, MDLOps should emit identical ASCII.
        diff = _first_diff(ascii_orig, ascii_round)
        if diff is not None:
            raise AssertionError(
                "MDLOps ASCII mismatch between original fixture and PyKotor-written binary.\n"
                f"fixture={mdl_path.name}\n"
                f"first_diff_offset={diff}\n"
                f"orig_len={len(ascii_orig)} round_len={len(ascii_round)}\n"
                f"orig_ctx:\n{_bytes_context(ascii_orig, diff)}\n"
                f"round_ctx:\n{_bytes_context(ascii_round, diff)}\n"
            )


@pytest.mark.parametrize("mdl_path,mdx_path", _fixtures(), ids=lambda p: Path(p).name)
def test_pykotor_can_read_binary_and_write_binary_mdlops_idempotent(
    mdl_path: Path,
    mdx_path: Path,
) -> None:
    """
    Complement the MDLOps-ASCII ingestion test by validating PyKotor's *binary* reader/writer pair
    against the same MDLOps "source of truth".

    NOTE:
    PyKotor's in-memory representation is often "canonicalized" through its ASCII form. In practice
    this is also the most interoperable interchange format with MDLOps.

    This test enforces a strict MDLOps-based *compatibility* contract for the binary pipeline:

    1) Read original fixture binary (MDL+MDX) with PyKotor
    2) Normalize through PyKotor ASCII (Binary -> ASCII -> Model) and write binary (Model -> Binary)
    3) Decompile that binary with MDLOps to ASCII (ascii_1)
    4) Ensure PyKotor can parse ascii_1 again (MDLOps acceptance + PyKotor re-parse)
    """
    mdlops = _mdlops_exe()
    if not mdlops.exists():
        pytest.skip("MDLOps not present at vendor/MDLOps/mdlops.exe")

    # Import PyKotor from vendored source tree.
    sys.path.insert(0, str(_pykotor_src_dir()))
    try:
        try:
            from pykotor.resource.formats.mdl import bytes_mdl, read_mdl, write_mdl
            from pykotor.resource.type import ResourceType
        except ImportError as e:
            pytest.skip(f"PyKotor or its dependencies unavailable: {e}")
    finally:
        sys.path.pop(0)

    with tempfile.TemporaryDirectory(prefix="bioware-mdlops-binary-") as td_s:
        td = Path(td_s)
        src_mdl = td / mdl_path.name
        src_mdx = td / mdx_path.name
        shutil.copyfile(mdl_path, src_mdl)
        shutil.copyfile(mdx_path, src_mdx)

        # 1) PyKotor: parse original binary (MDL+MDX)
        mdl_obj_bin = read_mdl(
            src_mdl,
            source_ext=src_mdx,
            file_format=ResourceType.MDL,
        )
        assert mdl_obj_bin is not None, f"Failed to parse original binary as model: {src_mdl}"

        # 2) Normalize through PyKotor ASCII and write binary (under identical stem/name)
        ascii_norm = bytes_mdl(mdl_obj_bin, ResourceType.MDL_ASCII)
        mdl_obj_norm = read_mdl(ascii_norm, file_format=ResourceType.MDL_ASCII)
        assert mdl_obj_norm is not None, f"Failed to parse PyKotor ASCII as model: {ascii_norm}"

        out_dir = td / "pykotor_out"
        out_dir.mkdir(parents=True, exist_ok=True)
        out_mdl = out_dir / src_mdl.name
        out_mdx = out_dir / src_mdx.name
        write_mdl(mdl_obj_norm, out_mdl, ResourceType.MDL, target_ext=out_mdx)
        assert out_mdl.exists() and out_mdl.stat().st_size > 0, f"Failed to write PyKotor binary: {out_mdl}"
        # Some models (e.g. camera-only) can legitimately produce empty MDX output.
        assert out_mdx.exists(), f"Failed to write PyKotor binary: {out_mdx}"

        # 3) MDLOps: decompile PyKotor-written binary -> ascii_1
        # Defensive: remove any stale output from earlier steps.
        for d in (td, out_dir):
            p = d / f"{out_mdl.stem}-ascii.mdl"
            if p.exists():
                p.unlink(missing_ok=True)
        r1 = _run([str(mdlops), str(out_mdl)], cwd=td, timeout_s=120)
        assert r1.returncode == 0, f"MDLOps failed decompiling PyKotor binary: {r1.stdout}"
        ascii_1_path = _find_mdlops_ascii_output(
            cwd=td,
            stem=out_mdl.stem,
            extra_dirs=[out_dir],
        )
        assert ascii_1_path is not None, f"MDLOps did not emit expected ASCII output for {out_mdl.stem}. stdout:\n{r1.stdout}"
        ascii_1 = ascii_1_path.read_bytes()

        # 4) PyKotor: ensure we can re-parse the MDLOps output (roundtrip interop signal)
        mdl_obj_2 = read_mdl(ascii_1, file_format=ResourceType.MDL_ASCII)
        assert mdl_obj_2 is not None, f"Failed to parse MDLOps ASCII as model: {ascii_1}"

        # Component equality check: compare normalized model with re-parsed model from MDLOps output
        # DO NOT remove this for any reason whatsoever. This assertion is the entire point of this test.
        assert mdl_obj_norm == mdl_obj_2, (
            f"Model component mismatch after binary roundtrip for {mdl_path.name}.\n"
            f"Normalized model (Binary -> ASCII -> Model) differs from model re-parsed from MDLOps output."
        )

        # Sanity-check some stable invariants in MDLOps ASCII.
        text_1 = ascii_1.decode("utf-8", errors="ignore").lower()
        assert "newmodel" in text_1, f"MDLOps ASCII does not contain 'newmodel': {text_1}"
        assert "beginmodelgeom" in text_1, f"MDLOps ASCII does not contain 'beginmodelgeom': {text_1}"
