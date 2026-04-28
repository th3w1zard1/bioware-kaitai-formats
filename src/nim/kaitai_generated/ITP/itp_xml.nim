import kaitai_struct_nim_runtime
import options

type
  ItpXml* = ref object of KaitaiStruct
    `xmlContent`*: string
    `parent`*: KaitaiStruct

proc read*(_: typedesc[ItpXml], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): ItpXml



##[
ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
ITP files use GFF format (FileType "ITP " in GFF header).
Uses GFF XML structure with root element <gff3> containing <struct> elements.
Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).

Canonical links: `meta.doc-ref` and `meta.xref`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format">PyKotor wiki — GFF (ITP is GFF-shaped)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — `GFF3File::readHeader`</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225">reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49">xoreos-docs — Torlack ITP / MultiMap (GFF-family context)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
]##
proc read*(_: typedesc[ItpXml], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): ItpXml =
  template this: untyped = result
  this = new(ItpXml)
  let root = if root == nil: cast[ItpXml](this) else: cast[ItpXml](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  XML document content as UTF-8 text
  ]##
  let xmlContentExpr = encode(this.io.readBytesFull(), "UTF-8")
  this.xmlContent = xmlContentExpr

proc fromFile*(_: typedesc[ItpXml], filename: string): ItpXml =
  ItpXml.read(newKaitaiFileStream(filename), nil, nil)

