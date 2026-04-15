"""Smoke-compile every ``formats/**/*.ksy`` with the Kaitai Struct compiler (Python target).

Requires ``kaitai-struct-compiler`` or ``ksc`` on ``PATH``, or ``KAITAI_STRUCT_COMPILER`` pointing
to the compiler executable (same resolution rules as ``scripts/KscResolve.ps1``).
"""
from __future__ import annotations

import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

import pytest

REPO_ROOT = Path(__file__).resolve().parents[3]


def _resolve_ksc() -> str | None:
    env = os.environ.get("KAITAI_STRUCT_COMPILER")
    if env and os.path.isfile(env):
        return env
    for name in ("kaitai-struct-compiler", "ksc"):
        w = shutil.which(name)
        if w:
            return w
    common_win = os.path.join(
        os.environ.get("ProgramFiles(x86)", r"C:\Program Files (x86)"),
        "kaitai-struct-compiler",
        "bin",
        "kaitai-struct-compiler.bat",
    )
    if os.path.isfile(common_win):
        return common_win
    return None


KSC = _resolve_ksc()


def _all_ksy_files() -> list[Path]:
    return sorted((REPO_ROOT / "formats").rglob("*.ksy"))


@pytest.mark.skipif(not KSC, reason="kaitai-struct-compiler / ksc not found (set PATH or KAITAI_STRUCT_COMPILER)")
def test_every_ksy_compiles_to_python() -> None:
    ksy_files = _all_ksy_files()
    assert ksy_files, "expected formats/**/*.ksy under repo root"

    failures: list[str] = []
    with tempfile.TemporaryDirectory(prefix="kaitai_smoke_") as tmp:
        tmp_path = Path(tmp)
        for ksy in ksy_files:
            proc = subprocess.run(
                [KSC, "-t", "python", "-d", str(tmp_path), str(ksy)],
                cwd=str(REPO_ROOT),
                capture_output=True,
                text=True,
                check=False,
            )
            if proc.returncode != 0:
                msg = (proc.stderr or proc.stdout or "").strip()
                failures.append(f"{ksy.relative_to(REPO_ROOT)}: exit {proc.returncode}\n{msg}")

    if failures:
        pytest.fail(
            "Kaitai compile failures:\n" + "\n---\n".join(failures),
            pytrace=False,
        )
