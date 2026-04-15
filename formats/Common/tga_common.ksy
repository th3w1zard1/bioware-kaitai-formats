meta:
  id: tga_common
  title: Truevision TGA shared enumerations
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: "Shared TGA header enums — Odyssey Ghidra program list on `formats/TPC/TGA.ksy` (`ghidra_mcp_odyssey_program_paths`); AGENTS.md."
    xoreos_tga_read_header: https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177
    xoreos_types_kfiletype_tga: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L61
    xoreos_tools_tga_load: https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L80
    pykotor_tga_reader: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40
    pykotor_wiki_tpc_tga_note: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html
doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — textures (TGA pipeline)"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40 PyKotor — `tga.py` (reader core)"
  - "https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177 xoreos — `TGA::readHeader`"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L61 xoreos — `kFileTypeTGA`"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L80 xoreos-tools — `TGA::load`"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture context)"
doc: |
  Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
  per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).

  Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.

enums:
  tga_color_map_type:
    0: none
    1: present

  tga_image_type:
    0: no_image_data
    1: uncompressed_color_mapped
    2: uncompressed_rgb
    3: uncompressed_greyscale
    9: rle_color_mapped
    10: rle_rgb
    11: rle_greyscale
