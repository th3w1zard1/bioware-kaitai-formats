meta:
  id: txb2
  title: BioWare TXB2 Texture (TPC-shaped wire)
  license: MIT
  endian: le
  file-extension: txb2
  imports:
    - ../Common/bioware_type_ids
    - tpc
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos ↔ this spec; submodule section 0).
    xoreos_types_kfiletype_txb2: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192
    xoreos_tpc_cpp: https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66
    pykotor_tpc_tree: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc
    reone_tpcreader: https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105
doc: |
  **TXB2** (`kFileTypeTXB2` **3017**): second-generation TXB id in `types.h`; treated like **TXB** / **TPC** by engine
  texture stacks. This capsule mirrors `TXB.ksy` (TPC header + opaque tail) until a divergent wire is proven.

doc-ref:
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192 xoreos — `kFileTypeTXB2`"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — texture family"

seq:
  - id: header
    type: tpc::tpc_header
  - id: body
    size-eos: true
