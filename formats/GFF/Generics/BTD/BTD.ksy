meta:
  id: gff_btd
  title: BioWare GFF3 BTD (BTD template)
  license: MIT
  endian: le
  file-extension: btd
  imports:
    - ../../../Common/bioware_type_ids
    - ../../gff
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (GFF3 capsule; submodule section 0).
    xoreos_types_file_type: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L450
    xoreos_file_type_id_value: |
      Numeric id 2041 (`xoreos_file_type_id` in `formats/Common/bioware_type_ids.ksy`).
    xoreos_gff3file: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63
    pykotor_gff: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff
    xoreos_docs_gff_format_pdf: https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf
    xoreos_docs_common_gff_structs_pdf: https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
doc: |
  **BTD** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
  `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
  `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.

  FileType / restype id **2041** — see `bioware_type_ids::xoreos_file_type_id` enum member `btd`.

doc-ref:
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — GFF3 header read"
  - "https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF binary"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (GFF3 wire)"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree"

seq:
  - id: contents
    type: gff::gff_union_file
    doc: Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per BTD template docs / PyKotor `gff_auto`.
