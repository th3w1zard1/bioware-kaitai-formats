#!/usr/bin/env python3
"""Normalize PyKotor GitHub wiki URLs under ``formats/**/*.ksy``.

- ``OldRepublicDevs/PyKotor/wiki/`` → ``OpenKotOR/PyKotor/wiki/``
- Strip erroneous ``.md`` suffix from wiki page paths (GitHub wiki slugs do not use ``.md``)
- Remap legacy slugs that resolve to the OpenKotOR wiki Home page

Idempotent — safe to re-run after hand-edits.
"""

from __future__ import annotations

import re
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
FORMATS = REPO / "formats"

_WIKI_MD = re.compile(
    r"(https://github\.com/OpenKotOR/PyKotor/wiki/[^#\s\)\>\"'`]+)\.md"
)

_REMAP = (
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/SSF-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-GFF",
        "https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#gff",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-ERF",
        "https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/BIF-BZF",
        "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression",
    ),
    # Legacy *-File-Format slugs that no longer exist as standalone wiki pages (resolve to Home).
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/BWM-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/ERF-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/ITP-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/LIP-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/LYT-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#lyt",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/PLT-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/RIM-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/TLK-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/TXI-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/TwoDA-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/2DA-File-Format",
    ),
    (
        "https://github.com/OpenKotOR/PyKotor/wiki/VIS-File-Format",
        "https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#vis",
    ),
)


def fix_text(s: str) -> str:
    s = s.replace(
        "https://github.com/OldRepublicDevs/PyKotor/wiki/",
        "https://github.com/OpenKotOR/PyKotor/wiki/",
    )
    s = _WIKI_MD.sub(r"\1", s)
    for a, b in _REMAP:
        s = s.replace(a, b)
    return s


def main() -> int:
    changed: list[Path] = []
    for path in sorted(FORMATS.rglob("*.ksy")):
        raw = path.read_text(encoding="utf-8")
        out = fix_text(raw)
        if out != raw:
            path.write_text(out, encoding="utf-8", newline="\n")
            changed.append(path)
    print(f"updated {len(changed)} file(s) under {FORMATS.relative_to(REPO)}")
    for p in changed:
        print(f"  {p.relative_to(REPO)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
