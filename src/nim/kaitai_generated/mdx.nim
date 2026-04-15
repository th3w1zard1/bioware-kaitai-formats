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

xoreos interleaved MDX reads: `meta.xref.xoreos_model_kotor_mdx_reads`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format">PyKotor wiki — MDL/MDX</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L885-L917">xoreos — Model_KotOR MDX reads</a>
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

See `meta.xref.pykotor_wiki_mdl` and `meta.xref.xoreos_model_kotor_mdx_reads`. Skinned meshes add bone weights
and indices per vertex as described on the wiki.

  ]##
  let vertexDataExpr = this.io.readBytesFull()
  this.vertexData = vertexDataExpr

proc fromFile*(_: typedesc[Mdx], filename: string): Mdx =
  Mdx.read(newKaitaiFileStream(filename), nil, nil)

