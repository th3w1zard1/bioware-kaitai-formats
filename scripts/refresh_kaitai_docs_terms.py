#!/usr/bin/env python3
"""One-off bulk replace in generated kaitai emitters: align stale doc comments with current
`formats/**/*.ksy` policy (**observed behavior** wording; per-field evidence on `seq` / `types`)."""

from __future__ import annotations

import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
SRC = ROOT / "src"
EXTS = {".py", ".h", ".cpp", ".cc", ".cs", ".go", ".rs", ".java", ".js", ".mjs", ".rb", ".php", ".lua", ".pm", ".nim", ".html", ".md", ".c", ".hpp", ".cc"}

# Longest first where order matters
REPL: list[tuple[str, str]] = [
    (
        "In-tree — Ghidra `CResTPC::OnResourceServiced`",
        "In-tree — `CResTPC::OnResourceServiced` (**observed behavior**; see `DDS.ksy` `meta.xref`)",
    ),
    ("**Ghidra / VMA:**", "**Observed behavior:**"),
    ("Source: Ghidra ", "**Observed behavior** (k1_win_gog_swkotor.exe): "),
    ("(Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).", "(PyKotor / reone / wiki line anchors; `GFF.ksy` for per-field **observed behavior**.)",),
    ("(Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors)", "(PyKotor / reone / wiki line anchors; GFF.ksy for per-field **observed behavior**)",),
    ("Ghidra `/K1/k1_win_gog_swkotor.exe`:", "**Observed behavior** on `k1_win_gog_swkotor.exe`:"),
    ("Ghidra `/K1/k1_win_gog_swkotor.exe`", "**Observed behavior** on `k1_win_gog_swkotor.exe`",),
    ("Ghidra: ", "**Observed behavior**: "),
    ("Ghidra name `", "Name in **observed behavior**: `"),
    ("(Ghidra 12-byte layout)", "(12-byte layout in **observed behavior**)",),
    ("matches Ghidra component sizes", "matches the component layout in **observed behavior**",),
    ("Not a separate Ghidra struct", "Not a separate struct in **observed behavior**",),
    ("Not a separate Ghidra datatype", "Not a separate engine-local datatype",),
    (
        "variant diverges, split a dedicated header type and cite Ghidra / binary evidence",
        "variant diverges, split a dedicated header type and cite **observed behavior** / tooling evidence",
    ),
    (
        "KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.",
        "",
    ),
    ("KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) - see AGENTS.md.", "",),  # ascii hyphen variant
    ("k1_gog_swkotor_decomp", "k1_gog_swkotor_observed_behavior",),
    ("nwmain_aurora_decomp", "nwmain_aurora_observed_behavior",),
    ("k2_gog_aspyr_tsl_decomp", "k2_gog_aspyr_tsl_observed_behavior",),
    ("ghidra_k1_win_gog_swkotor_exe", "k1_gog_swkotor_observed_behavior",),  # legacy key name in old emits
    ("ghidra_nwmain_aurora_exe", "nwmain_aurora_observed_behavior",),
    ("ghidra_tsl_k2_win_gog_aspyr_swkotor2_exe", "k2_gog_aspyr_tsl_observed_behavior",),
    ("K1 (decompiler):", "**Observed behavior** (k1_win_gog_swkotor.exe):",),
    (
        "**TODO: VERIFY** full BIP layout against Odyssey Ghidra (`user-agdec-http`) and PyKotor; until then this spec",
        "**TODO: VERIFY** full BIP layout against a KotOR PC build and PyKotor; until then this spec",
    ),
    (
        "xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; placeholder wire — verify in Ghidra)",
        "xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; verify wire with PyKotor / **observed behavior** on shipped builds when possible)",
    ),
]


def main() -> int:
    changed = 0
    for path in sorted(SRC.rglob("*")):
        if not path.is_file() or path.suffix.lower() not in EXTS:
            continue
        if "kaitai_generated" not in path.parts:
            continue
        try:
            text = path.read_text(encoding="utf-8")
        except (UnicodeDecodeError, OSError):
            continue
        orig = text
        for old, new in REPL:
            text = text.replace(old, new)
        if text != orig:
            path.write_text(text, encoding="utf-8")
            changed += 1
    print(f"Updated {changed} files under {SRC}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
