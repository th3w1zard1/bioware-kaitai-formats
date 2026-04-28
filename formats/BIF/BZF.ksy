meta:
  id: bzf
  title: BioWare BZF (BioWare Zipped File) Format
  license: MIT
  endian: le
  file-extension: bzf
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/bif/
    github_openkotor_pykotor_bzf_lzma: |
      https://github.com/OpenKotOR/PyKotor — same package as BIF — `io_bif.py`:
      **`_decompress_bzf_payload`** **26–54** (LZMA **RAW** filters + fallbacks); legacy **`BZF `** branch inside **`_load_bif_legacy`** **102+**; **`BIFBinaryReader`** detects **`BZF `** prefix before legacy fallback **209–213**.
    github_openkotor_pykotor_bif_data_bzf_type: |
      https://github.com/OpenKotOR/PyKotor — `bif_data.py`: **`BIFType.BZF`** and mobile / LZMA notes **34–37**, **`BIFType`** enum **59–71**.
    pykotor_wiki_bif_file_format: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif
    pykotor_wiki_bif_bzf: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression
    xoreos_bzffile_cpp: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/bzffile.cpp#L41-L83
    github_xoreos_bzffile_note: |
      https://github.com/xoreos/xoreos — `bzffile.cpp`: **`BZFFile::load`** **55–83**; **`readVarResTable`** **85+**.
      Upstream names the checked tag **`kBZFID`** but defines it as **`MKTAG('B','I','F','F')`** **41** — this targets the **inner BIFF** layout after decompression/tooling glue, while **this `.ksy`** models the **outer** `BZF ` + `V1.0` + LZMA blob per PyKotor wiki.
    xoreos_types_kfiletype_bzf: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L368
    xoreos_bzf_load: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/bzffile.cpp#L55-L83
    github_xoreos_tools_unkeybif_bzf: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/unkeybif.cpp#L206-L207
    github_xoreos_docs_keybif_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/KeyBIF_Format.pdf
    reone_upstream_note_bzf: |
      No dedicated `*bzf*` reader under `modawan/reone` `src/libs/resource/format/` on current `master` — use PyKotor + xoreos + this capsule `.ksy`.
doc: |
  **BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
  mobile KotOR ports.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression PyKotor wiki — BZF (LZMA BIF)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L26-L54 PyKotor — `_decompress_bzf_payload`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/bzffile.cpp#L41-L83 xoreos — `kBZFID` quirk + `BZFFile::load`"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/unkeybif.cpp#L206-L207 xoreos-tools — `.bzf` → `BZFFile`"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf"

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
    doc: File type signature. Must be "BZF " for compressed BIF files.
    valid: "'BZF '"

  - id: version
    type: str
    encoding: ASCII
    size: 4
    doc: File format version. Always "V1.0" for BZF files.
    valid: "'V1.0'"

  - id: compressed_data
    size-eos: true
    doc: |
      LZMA-compressed BIF file data (single blob to EOF).
      Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).
