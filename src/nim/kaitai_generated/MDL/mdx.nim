import kaitai_struct_nim_runtime
import options

type
  Mdx* = ref object of KaitaiStruct
    `vertexData`*: seq[byte]
    `parent`*: KaitaiStruct

proc read*(_: typedesc[Mdx], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdx



##[
**MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
opaque `size-eos` span — per-attribute layouts are MDL-driven.

Cross-implementations: xoreos reads trimesh MDX stride and interleaved streams in `meta.xref.xoreos_model_kotor_*`;
reone parses mesh MDX in `meta.xref.reone_mdlmdxreader_read_mesh`; KotOR.js uses `OdysseyModelNodeMesh` and
`OdysseyModelMDXFlag` (`meta.xref.kotor_js_*`). Shared bitmask names: imported `bioware_mdl_common::mdx_vertex_stream_flag`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format">PyKotor wiki — MDL/MDX</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408">PyKotor — `MDLBinaryReader` / MDX tail read path</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L809-L842">xoreos — trimesh MDX header fields (mdxStructSize, UV offsets, counts)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L864-L917">xoreos — interleaved MDX vertex loop</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192">xoreos — `kFileTypeMDX` (3008)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L201">xoreos — `kFileTypeMDX2` (3016)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no MDX-specific tool)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL/MDX overview</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html">xoreos-docs — Torlack binmdl (MDX-related controller / mesh background)</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L197-L487">reone — MdlMdxReader::readMesh (MDX consumption)</a>
@see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/enums/odyssey/OdysseyModelMDXFlag.ts">KotOR.js — MDX stream flag enum</a>
]##
proc read*(_: typedesc[Mdx], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdx =
  template this: untyped = result
  this = new(Mdx)
  let root = if root == nil: cast[Mdx](this) else: cast[Mdx](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Raw vertex data bytes; layout follows the trimesh header in the paired MDL (`mdx_data_offset`, `mdx_vertex_size`,
`mdx_data_flags`). Bit names for `mdx_data_flags`: `bioware_mdl_common::mdx_vertex_stream_flag` (bitmask on wire).

See `meta.xref.pykotor_wiki_mdl`, `meta.xref.xoreos_model_kotor_trimesh_mdx_fields`, and
`meta.xref.xoreos_model_kotor_mdx_interleaved_vertices`. Skinned meshes add bone weights
and indices per vertex as described on the wiki.

  ]##
  let vertexDataExpr = this.io.readBytesFull()
  this.vertexData = vertexDataExpr

proc fromFile*(_: typedesc[Mdx], filename: string): Mdx =
  Mdx.read(newKaitaiFileStream(filename), nil, nil)

