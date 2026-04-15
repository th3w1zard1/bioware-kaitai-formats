meta:
  id: mdx
  title: BioWare MDX (Model Extension) Format
  license: MIT
  endian: le
  file-extension: mdx
  imports:
    - ../Common/bioware_mdl_common
  xref:
    ghidra_odyssey_k1:
      note: "Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: MDX vertex streams pair with MDL; wire format per PyKotor wiki."
    pykotor_wiki_mdl: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format
    xoreos_types_kfiletype_mdx: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L184
    xoreos_model_kotor_mdx_reads: https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L885-L917
doc: |
  **MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
  Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
  opaque `size-eos` span — per-attribute layouts are MDL-driven.

  xoreos interleaved MDX reads: `meta.xref.xoreos_model_kotor_mdx_reads`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX"
  - "https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L885-L917 xoreos — Model_KotOR MDX reads"

seq:
  - id: vertex_data
    size-eos: true
    doc: |
      Raw vertex data bytes; layout follows the trimesh header in the paired MDL (`mdx_data_offset`, `mdx_vertex_size`,
      `mdx_data_flags`). Bit names for `mdx_data_flags`: `bioware_mdl_common::mdx_vertex_stream_flag` (bitmask on wire).

      See `meta.xref.pykotor_wiki_mdl` and `meta.xref.xoreos_model_kotor_mdx_reads`. Skinned meshes add bone weights
      and indices per vertex as described on the wiki.
