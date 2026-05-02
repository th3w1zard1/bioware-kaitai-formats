#!/usr/bin/env python3
"""Fix all GFF XML variant .ksy files to have proper imports and xrefs."""

from __future__ import annotations

from pathlib import Path

# Map of format codes to full names
FORMAT_NAMES = {
    "are": "Area",
    "cnv": "Conversation",
    "dlg": "Dialogue",
    "fac": "Faction",
    "gam": "Game State",
    "git": "Game Instance Template",
    "gui": "Graphical User Interface",
    "gvt": "Global Variables Table",
    "ifo": "Module Information",
    "jrl": "Journal",
    "nfo": "Module Info",
    "pt": "Party Table",
    "pth": "Path/Pathfinding",
    "utc": "Creature Template",
    "utd": "Door Template",
    "ute": "Encounter Template",
    "uti": "Item Template",
    "utm": "Store/Merchant Template",
    "utp": "Placeable Template",
    "uts": "Sound Template",
    "utt": "Trigger Template",
    "utw": "Waypoint Template",
}


def fix_xml_variant(file_path: Path):
    """Fix a single XML variant .ksy file."""
    _content = file_path.read_text(encoding="utf-8")

    # Extract format code from filename (e.g., "ARE_XML.ksy" -> "are")
    format_code = file_path.stem.replace("_XML", "").lower()
    format_name = FORMAT_NAMES.get(format_code, format_code.upper())

    # Build new content
    lines = []
    lines.append("meta:")
    lines.append(f"  id: {format_code}_xml")
    lines.append(f"  title: BioWare {format_code.upper()} XML Format")
    lines.append("  license: MIT")
    lines.append("  endian: le")
    lines.append(f"  file-extension: {format_code}.xml")
    lines.append("  encoding: UTF-8")
    lines.append("  xref:")
    lines.append(f"    binary_format: ../{format_code}/{format_code}")
    lines.append("    gff_xml_schema: ../../xml/gff_xml")
    lines.append(
        f"    pykotor_wiki_gff_{format_code}: https://github.com/OldRepublicDevs/PyKotor/wiki/GFF-{format_code.upper()}.md"
    )
    lines.append(
        "    pykotor_wiki_gff_format: https://github.com/OldRepublicDevs/PyKotor/wiki/GFF-File-Format.md"
    )
    lines.append("  imports:")
    lines.append("    - ../../gff/gff")
    lines.append("    - ../../xml/gff_xml")
    lines.append("doc: |")
    lines.append(
        f"  Human-readable XML representation of {format_code.upper()} ({format_name}) binary files."
    )
    lines.append("  Uses GFF XML structure with <gff3> root element.")
    lines.append("  ")
    lines.append(f"  Binary format reference: ../{format_code}/{format_code}.ksy")
    lines.append("  ")
    lines.append("  References:")
    lines.append(f"  - PyKotor wiki (GFF-{format_code.upper()}.md, GFF-File-Format.md)")
    lines.append("")
    lines.append("seq:")
    lines.append("  - id: xml_content")
    lines.append("    type: str")
    lines.append("    size-eos: true")
    lines.append("    encoding: UTF-8")
    lines.append("    doc: XML document content as UTF-8 text")
    lines.append("")

    new_content = "\n".join(lines)
    file_path.write_text(new_content, encoding="utf-8")
    print(f"Fixed: {file_path}")


def main():
    """Fix all XML variant files."""
    formats_dir = Path("formats/GFF/Generics")

    for xml_file in formats_dir.rglob("*_XML.ksy"):
        # Skip RES_XML.ksy (special case)
        if xml_file.name == "RES_XML.ksy":
            continue

        try:
            fix_xml_variant(xml_file)
        except Exception as e:
            print(f"Error fixing {xml_file}: {e}")


if __name__ == "__main__":
    main()
