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

**reone:** not applicable for GDA wire ingestion on the KotOR fork (`meta.xref.reone_gda_consumer_note`).

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305">xoreos — `GDAFile::load`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L87-L93">xoreos — `GFF4File` stream ctor (type dispatch)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4fields.h#L1230-L1260">xoreos — G2DA column field ids (excerpt)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L136-L140">xoreos — `TwoDAFile(const GDAFile &)`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L343-L400">xoreos — `TwoDAFile::load(const GDAFile &)`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86">xoreos-tools — `main`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159">xoreos-tools — `get2DAGDA`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L167-L181">xoreos-tools — multi-file `GDAFile` merge</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L1466-L1472">PyKotor — `ResourceType.GDA`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf (GFF4 family; G2DA container)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf">xoreos-docs — CommonGFFStructs.pdf</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf">xoreos-docs — 2DA_Format.pdf (classic `.2da`; contrast with GDA)</a>
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

