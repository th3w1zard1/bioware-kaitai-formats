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


# Every ``formats/**/*.ksy`` in this repo — compile check guards PATH/KSC regressions.
EXPECTED_PASSES = {
    Path("formats/BIF/KEY.ksy"),
    Path("formats/BIF/BIF.ksy"),
    Path("formats/BIF/BZF.ksy"),
    Path("formats/BWM/BWM.ksy"),
    Path("formats/DA2S/DA2S.ksy"),
    Path("formats/DAS/DAS.ksy"),
    Path("formats/Common/bioware_common.ksy"),
    Path("formats/Common/bioware_gff_common.ksy"),
    Path("formats/Common/bioware_type_ids.ksy"),
    Path("formats/Common/bioware_mdl_common.ksy"),
    Path("formats/Common/bioware_ncs_common.ksy"),
    Path("formats/Common/tga_common.ksy"),
    Path("formats/ERF/ERF.ksy"),
    Path("formats/GFF/GFF.ksy"),
    Path("formats/GFF/XML/GFF_XML.ksy"),
    Path("formats/GDA/GDA.ksy"),
    Path("formats/HERF/HERF.ksy"),
    Path("formats/LIP/LIP.ksy"),
    Path("formats/LTR/LTR.ksy"),
    Path("formats/PLT/PLT.ksy"),
    Path("formats/MDL/MDL.ksy"),
    Path("formats/MDL/MDX.ksy"),
    Path("formats/NSS/NCS.ksy"),
    Path("formats/NSS/NCS_minimal.ksy"),
    Path("formats/PCC/PCC.ksy"),
    Path("formats/RIM/RIM.ksy"),
    Path("formats/SSF/SSF.ksy"),
    Path("formats/TLK/TLK.ksy"),
    Path("formats/TPC/DDS.ksy"),
    Path("formats/TPC/TPC.ksy"),
    Path("formats/TPC/TGA.ksy"),
    Path("formats/TPC/TXB.ksy"),
    Path("formats/TwoDA/TwoDA.ksy"),
    Path("formats/WAV/WAV.ksy"),
}


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
