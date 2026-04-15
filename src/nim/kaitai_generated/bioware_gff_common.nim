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
(Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).

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

