#!/usr/bin/env python3
"""Compile all .ksy files to Python and report results.

Emits into a **single** output directory (flat layout). The checked-in tree under
``src/python/kaitai_generated/<Format>/`` is produced by ``scripts/generate_code.ps1``;
do not run this script against that directory if you rely on subfolder imports.

Windows + uv: use ``uv run python scripts/compile_all_ksy.py`` (or ``uv run pwsh -File ...`` for ``.ps1`` helpers).
Plain ``uv run .\\scripts\\*.ps1`` hits Win32 error 193 — see ``AGENTS.md``.
"""

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path
from shutil import which
from typing import Dict, Tuple


def _resolve_ksc() -> str:
    env_path: str | None = (
        os.environ.get("KAITAI_STRUCT_COMPILER", None) or ""
    ).strip() or None
    if env_path:
        p = Path(env_path)
        if p.exists():
            return str(p)
    for candidate in ("ksc", "kaitai-struct-compiler", "kaitai-struct-compiler.bat"):
        found = which(candidate)
        if found:
            return found
    common_win = Path(
        r"C:\Program Files (x86)\kaitai-struct-compiler\bin\kaitai-struct-compiler.bat"
    )
    if common_win.exists():
        return str(common_win)
    raise FileNotFoundError(
        "Could not locate `kaitai-struct-compiler`. Add it to PATH or set env var `KAITAI_STRUCT_COMPILER` to its full path."
    )


def compile_ksy(ksy_file: Path, output_dir: Path, *, cwd: Path) -> Tuple[bool, str]:
    """Compile a single .ksy file to Python.

    Returns:
        (success, output) tuple
    """
    ksc = _resolve_ksc()
    cmd = [
        ksc,
        "-t",
        "python",
        "-d",
        str(output_dir),
        str(ksy_file),
    ]

    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=30,
            cwd=str(cwd),
        )
        output = result.stdout + result.stderr
        success = result.returncode == 0
        return (success, output)
    except Exception as e:
        return (False, str(e))


def main():
    """Compile all .ksy files and report results."""
    repo_root = Path(__file__).resolve().parent.parent
    formats_dir = repo_root / "formats"
    output_dir = repo_root / "src" / "python" / "kaitai_generated"
    output_dir.mkdir(parents=True, exist_ok=True)

    # Find all .ksy files
    ksy_files = sorted(formats_dir.rglob("*.ksy"))

    results: Dict[str, Tuple[bool, str]] = {}

    print(f"Found {len(ksy_files)} .ksy files")
    print("=" * 80)

    for ksy_file in ksy_files:
        rel_path = ksy_file.relative_to(formats_dir)
        print(f"Compiling: {rel_path}...", end=" ")

        success, output = compile_ksy(ksy_file, output_dir, cwd=repo_root)
        results[str(rel_path)] = (success, output)

        if success:
            if output.strip():
                print("OK (with warnings)")
            else:
                print("OK")
        else:
            print("FAILED")

    # Print summary
    print("=" * 80)
    successes = sum(1 for s, _ in results.values() if s)
    failures = len(results) - successes

    print(f"\nSummary: {successes} succeeded, {failures} failed")

    # Print failures
    if failures > 0:
        print("\n" + "=" * 80)
        print("FAILURES:")
        print("=" * 80)
        for file, (success, output) in results.items():
            if not success:
                print(f"\n{file}:")
                print(output)

    # Print warnings
    warnings = [(f, o) for f, (s, o) in results.items() if s and o.strip()]
    if warnings:
        print("\n" + "=" * 80)
        print("WARNINGS:")
        print("=" * 80)
        for file, output in warnings:
            print(f"\n{file}:")
            print(output)

    return 0 if failures == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
