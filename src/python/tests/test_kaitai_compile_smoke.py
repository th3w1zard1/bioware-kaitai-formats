from __future__ import annotations

import os
import subprocess
import tempfile
import unittest
from pathlib import Path
from shutil import which

REPO_ROOT = Path(__file__).resolve().parents[3]

def _resolve_ksc() -> str:
    # Prefer environment override for CI / custom installs.
    env_path = os.environ.get("KAITAI_STRUCT_COMPILER")
    if env_path:
        p = Path(env_path)
        if p.exists():
            return str(p)

    # Typical PATH resolution (Windows installer usually provides a .bat).
    for candidate in ("kaitai-struct-compiler", "kaitai-struct-compiler.bat"):
        found = which(candidate)
        if found:
            return found

    # Common Windows installer default.
    common_win = Path(r"C:\Program Files (x86)\kaitai-struct-compiler\bin\kaitai-struct-compiler.bat")
    if common_win.exists():
        return str(common_win)

    raise FileNotFoundError(
        "Could not locate `kaitai-struct-compiler`. "
        "Add it to PATH or set env var `KAITAI_STRUCT_COMPILER` to its full path."
    )


# Known-failing `.ksy` files under the current Kaitai Struct compiler (re-add paths here if ksc regresses).
EXPECTED_FAILURES: set[Path] = set()


def _discovered_format_ksy() -> set[Path]:
    """All ``formats/**/*.ksy`` paths relative to the repo root (POSIX-style segments for stable sorting)."""
    root = REPO_ROOT / "formats"
    out: set[Path] = set()
    for p in root.rglob("*.ksy"):
        rel = p.relative_to(REPO_ROOT)
        out.add(Path(rel.as_posix()))
    return out


# Every ``formats/**/*.ksy`` minus ``EXPECTED_FAILURES`` — avoids drift when new specs land.
EXPECTED_PASSES = _discovered_format_ksy() - EXPECTED_FAILURES


def _run_ksc(ksy_path: Path) -> subprocess.CompletedProcess[str]:
    ksc = _resolve_ksc()
    with tempfile.TemporaryDirectory(prefix="kaitai_py_") as tmp:
        out_dir = Path(tmp)
        # Always compile a single file per test: easier attribution and faster iteration.
        return subprocess.run(
            [
                ksc,
                "-t",
                "python",
                "-d",
                str(out_dir),
                str(ksy_path),
            ],
            cwd=str(REPO_ROOT),
            text=True,
            capture_output=True,
            check=False,
        )


class KaitaiCompilerSmokeTests(unittest.TestCase):
    def test_expected_passes_compile(self) -> None:
        for rel in sorted(EXPECTED_PASSES):
            with self.subTest(ksy=str(rel)):
                ksy = REPO_ROOT / rel
                self.assertTrue(ksy.exists(), f"Missing file: {rel}")
                proc = _run_ksc(ksy)
                if proc.returncode != 0:
                    self.fail(
                        "\n".join(
                            [
                                f"Expected compile success, got exit code {proc.returncode} for {rel}",
                                "--- stdout ---",
                                proc.stdout,
                                "--- stderr ---",
                                proc.stderr,
                            ]
                        )
                    )

    def test_expected_failures_do_not_compile(self) -> None:
        for rel in sorted(EXPECTED_FAILURES):
            with self.subTest(ksy=str(rel)):
                ksy = REPO_ROOT / rel
                self.assertTrue(ksy.exists(), f"Missing file: {rel}")
                proc = _run_ksc(ksy)
                if proc.returncode == 0:
                    self.fail(
                        "\n".join(
                            [
                                f"Expected compile failure, but compilation succeeded for {rel}",
                                "Remove it from EXPECTED_FAILURES and add it to EXPECTED_PASSES.",
                            ]
                        )
                    )


if __name__ == "__main__":
    unittest.main()
