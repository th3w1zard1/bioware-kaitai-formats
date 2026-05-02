import kaitai_struct_nim_runtime
import options
import gff

type
  GffCam* = ref object of KaitaiStruct
    `contents`*: Gff_GffUnionFile
    `parent`*: KaitaiStruct

proc read*(_: typedesc[GffCam], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): GffCam



##[
**CAM** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
`formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
`meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.

FileType / restype id **2104** — see `bioware_type_ids::xoreos_file_type_id` enum member `cam`.

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — GFF3 header read</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format">PyKotor wiki — GFF binary</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf (GFF3 wire)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf">xoreos-docs — CommonGFFStructs.pdf</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
]##
proc read*(_: typedesc[GffCam], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): GffCam =
  template this: untyped = result
  this = new(GffCam)
  let root = if root == nil: cast[GffCam](this) else: cast[GffCam](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per CAM template docs / PyKotor `gff_auto`.
  ]##
  let contentsExpr = Gff_GffUnionFile.read(this.io, nil, nil)
  this.contents = contentsExpr

proc fromFile*(_: typedesc[GffCam], filename: string): GffCam =
  GffCam.read(newKaitaiFileStream(filename), nil, nil)

