meta:
  id: mdx
  title: BioWare MDX (Model Extension) Format
  license: MIT
  endian: le
  file-extension: mdx
  imports:
    - ../Common/bioware_mdl_common
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe--MDX vertex streams pair with MDL; wire format per PyKotor wiki.
    pykotor_wiki_mdl: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format
    pykotor_io_mdl_binary_reader: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408
    xoreos_types_kfiletype_mdx: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192
    xoreos_types_kfiletype_mdx2: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L201
    xoreos_model_kotor_trimesh_mdx_fields: https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L809-L842
    xoreos_model_kotor_mdx_interleaved_vertices: https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L864-L917
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html
    xoreos_docs_torlack_binmdl: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html
    reone_mdlmdxreader_read_mesh: https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L197-L487
    kotor_js_odyssey_model_node_mesh: https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModelNodeMesh.ts
    kotor_js_mdx_flags_enum: https://github.com/KobaltBlu/KotOR.js/blob/master/src/enums/odyssey/OdysseyModelMDXFlag.ts
    xoreos_tools_readme_inventory: https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43
doc: |
  **MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
  Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
  opaque `size-eos` span — per-attribute layouts are MDL-driven.

  Cross-implementations: xoreos reads trimesh MDX stride and interleaved streams in `meta.xref.xoreos_model_kotor_*`;
  reone parses mesh MDX in `meta.xref.reone_mdlmdxreader_read_mesh`; KotOR.js uses `OdysseyModelNodeMesh` and
  `OdysseyModelMDXFlag` (`meta.xref.kotor_js_*`). Shared bitmask names: imported `bioware_mdl_common::mdx_vertex_stream_flag`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408 PyKotor — `MDLBinaryReader` / MDX tail read path"
  - "https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L809-L842 xoreos — trimesh MDX header fields (mdxStructSize, UV offsets, counts)"
  - "https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L864-L917 xoreos — interleaved MDX vertex loop"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192 xoreos — `kFileTypeMDX` (3008)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L201 xoreos — `kFileTypeMDX2` (3016)"
  - "https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDX-specific tool)"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL/MDX overview"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (MDX-related controller / mesh background)"
  - "https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L197-L487 reone — MdlMdxReader::readMesh (MDX consumption)"
  - "https://github.com/KobaltBlu/KotOR.js/blob/master/src/enums/odyssey/OdysseyModelMDXFlag.ts KotOR.js — MDX stream flag enum"

seq:
  - id: vertex_data
    size-eos: true
    doc: |
      Raw vertex data bytes; layout follows the trimesh header in the paired MDL (`mdx_data_offset`, `mdx_vertex_size`,
      `mdx_data_flags`). Bit names for `mdx_data_flags`: `bioware_mdl_common::mdx_vertex_stream_flag` (bitmask on wire).

      See `meta.xref.pykotor_wiki_mdl`, `meta.xref.xoreos_model_kotor_trimesh_mdx_fields`, and
      `meta.xref.xoreos_model_kotor_mdx_interleaved_vertices`. Skinned meshes add bone weights
      and indices per vertex as described on the wiki.
