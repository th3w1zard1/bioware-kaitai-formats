import kaitai_struct_nim_runtime
import options
import gff

type
  Gda* = ref object of KaitaiStruct
    `asGff4`*: Gff_Gff4File
    `parent`*: KaitaiStruct

proc read*(_: typedesc[Gda], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gda



##[
**GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
(`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.

G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305">xoreos — GDAFile::load</a>
]##
proc read*(_: typedesc[Gda], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gda =
  template this: untyped = result
  this = new(Gda)
  let root = if root == nil: cast[Gda](this) else: cast[Gda](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
(fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).

  ]##
  let asGff4Expr = Gff_Gff4File.read(this.io, nil, nil)
  this.asGff4 = asGff4Expr

proc fromFile*(_: typedesc[Gda], filename: string): Gda =
  Gda.read(newKaitaiFileStream(filename), nil, nil)

