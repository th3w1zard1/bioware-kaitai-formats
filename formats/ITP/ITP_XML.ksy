meta:
  id: itp_xml
  title: BioWare ITP XML Format
  license: MIT
  endian: le
  file-extension: itp.xml
  encoding: UTF-8
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (XML interchange; submodule section 0).
      Binary GFF / GFF3 wire: `formats/GFF/GFF.ksy`.
    ghidra_odyssey_k1: |
      - Tooling/XML for ITP (GFF family)
      - Binary GFF rules in GFF.ksy match k1_win_gog_swkotor.exe.
    pykotor_library_itp_binary: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/itp/itp.py
    pykotor_library_itp_xml: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py
    reone_upstream_note_itp: |
      modawan/reone `master` does not publish `src/libs/resource/parser/gff/itp.cpp` (404 on GitHub); older `seedhartha/reone` URLs for that path are dead.
      ITP on-disk is **GFF3** — use shared **`GffReader`** (`gffreader.cpp`) alongside per-template parsers under `parser/gff/` (`are.cpp`, `git.cpp`, …).
    reone_gffreader_gff3: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225
    pykotor_wiki_gff_format: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
    xoreos_gff3file_read_header: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    xoreos_docs_gff_format_pdf: https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf
    xoreos_docs_torlack_itp_html: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
doc: |
  ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
  ITP files use GFF format (FileType "ITP " in GFF header).
  Uses GFF XML structure with root element <gff3> containing <struct> elements.
  Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).

  Canonical links: `meta.doc-ref` and `meta.xref`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF (ITP is GFF-shaped)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — `GFF3File::readHeader`"
  - "https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225 reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`)"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP)"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 xoreos-docs — Torlack ITP / MultiMap (GFF-family context)"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree"

seq:
  - id: xml_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: XML document content as UTF-8 text

