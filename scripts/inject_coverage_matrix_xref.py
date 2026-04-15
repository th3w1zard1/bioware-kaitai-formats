#!/usr/bin/env python3
"""Insert meta.xref.repo_coverage_matrix into formats/**/*.ksy if missing."""
from __future__ import annotations

import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
FORMATS = ROOT / "formats"
MARKER = "repo_coverage_matrix:"
SNIPPET = f"""    {MARKER} |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule §0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
"""


def main() -> None:
    changed: list[pathlib.Path] = []
    for path in sorted(FORMATS.rglob("*.ksy")):
        text = path.read_text(encoding="utf-8")
        if MARKER in text:
            continue
        if "\n  xref:\n" not in text:
            continue
        needle = "\n  xref:\n"
        idx = text.index(needle) + len(needle)
        text = text[:idx] + SNIPPET + text[idx:]
        path.write_text(text, encoding="utf-8")
        changed.append(path)
    for p in changed:
        print(p.relative_to(ROOT))
    print(f"Updated {len(changed)} files")


if __name__ == "__main__":
    main()
