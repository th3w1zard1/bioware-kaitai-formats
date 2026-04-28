import kaitai_struct_nim_runtime
import options

type
  BiowareGffCommon* = ref object of KaitaiStruct
    `parent`*: KaitaiStruct
  BiowareGffCommon_GffFieldType* = enum
    uint8 = 0
    int8 = 1
    uint16 = 2
    int16 = 3
    uint32 = 4
    int32 = 5
    uint64 = 6
    int64 = 7
    single = 8
    double = 9
    string = 10
    resref = 11
    localized_string = 12
    binary = 13
    struct = 14
    list = 15
    vector4 = 16
    vector3 = 17
    str_ref = 18

proc read*(_: typedesc[BiowareGffCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareGffCommon



##[
Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).

Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
(PyKotor / reone / wiki line anchors; `GFF.ksy` for per-field **observed behavior**.)

**GFF4** uses a different container/struct layout on disk (`GFF4File::Header::read` in `meta.xref.xoreos_gff4file_header_read`);
this enum remains the **GFF3** field-type table unless a future split spec proves wire-identical IDs across both.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types">PyKotor wiki — GFF data types</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367">PyKotor — `GFFFieldType` enum</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L197-L273">PyKotor — field read dispatch</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — `GFF3File::readHeader`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L59-L82">xoreos — `GFF4File::Header::read` (GFF4 container; distinct from GFF3 field tags above)</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225">reone — `GffReader`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176">xoreos-tools — `gffdumper` (identify / dump)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60">xoreos-tools — `gffcreator` (create)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf">xoreos-docs — CommonGFFStructs.pdf</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
]##
proc read*(_: typedesc[BiowareGffCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareGffCommon =
  template this: untyped = result
  this = new(BiowareGffCommon)
  let root = if root == nil: cast[BiowareGffCommon](this) else: cast[BiowareGffCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


proc fromFile*(_: typedesc[BiowareGffCommon], filename: string): BiowareGffCommon =
  BiowareGffCommon.read(newKaitaiFileStream(filename), nil, nil)

