meta:
  id: gff_git
  title: BioWare GFF3 GIT (GIT template)
  license: MIT
  endian: le
  file-extension: git
  imports:
    - ../../../Common/bioware_type_ids
    - ../../gff
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (GFF3 capsule; submodule section 0).
    xoreos_types_file_type: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L56-L450
    xoreos_file_type_id_value: |
      Numeric id 2023 (`xoreos_file_type_id` in `formats/Common/bioware_type_ids.ksy`).
    xoreos_gff3file: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/gff3file.cpp#L50-L63
    pykotor_gff: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/gff
    xoreos_docs_gff_format_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/GFF_Format.pdf
    xoreos_docs_common_gff_structs_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/CommonGFFStructs.pdf
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  **GIT** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
  `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
  `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.

  FileType / restype id **2023** — see `bioware_type_ids::xoreos_file_type_id` enum member `git`.

doc-ref:
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/gff3file.cpp#L50-L63 xoreos — GFF3 header read"
  - "https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF binary"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (GFF3 wire)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs PDF tree"

seq:
  - id: contents
    type: gff::gff_union_file
    doc: Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per GIT template docs / PyKotor `gff_auto`.
