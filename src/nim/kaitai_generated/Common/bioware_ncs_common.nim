import kaitai_struct_nim_runtime
import options

type
  BiowareNcsCommon* = ref object of KaitaiStruct
    `parent`*: KaitaiStruct
  BiowareNcsCommon_NcsBytecode* = enum
    reserved_bc = 0
    cpdownsp = 1
    rsaddx = 2
    cptopsp = 3
    constx = 4
    action = 5
    logandxx = 6
    logorxx = 7
    incorxx = 8
    excorxx = 9
    boolandxx = 10
    equalxx = 11
    nequalxx = 12
    geqxx = 13
    gtxx = 14
    ltxx = 15
    leqxx = 16
    shleftxx = 17
    shrightxx = 18
    ushrightxx = 19
    addxx = 20
    subxx = 21
    mulxx = 22
    divxx = 23
    modxx = 24
    negx = 25
    compx = 26
    movsp = 27
    unused_gap = 28
    jmp = 29
    jsr = 30
    jz = 31
    retn = 32
    destruct = 33
    notx = 34
    decxsp = 35
    incxsp = 36
    jnz = 37
    cpdownbp = 38
    cptopbp = 39
    decxbp = 40
    incxbp = 41
    savebp = 42
    restorebp = 43
    store_state = 44
    nop = 45
  BiowareNcsCommon_NcsInstructionQualifier* = enum
    none = 0
    unary_operand_layout = 1
    int_type = 3
    float_type = 4
    string_type = 5
    object_type = 6
    effect_type = 16
    event_type = 17
    location_type = 18
    talent_type = 19
    int_int = 32
    float_float = 33
    object_object = 34
    string_string = 35
    struct_struct = 36
    int_float = 37
    float_int = 38
    effect_effect = 48
    event_event = 49
    location_location = 50
    talent_talent = 51
    vector_vector = 58
    vector_float = 59
    float_vector = 60
  BiowareNcsCommon_NcsProgramSizeMarker* = enum
    program_size_prefix = 66

proc read*(_: typedesc[BiowareNcsCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareNcsCommon



##[
Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).

- `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
  (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
- `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
  decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
- `ncs_program_size_marker` is the fixed header byte after `"V1.0"` in retail KotOR NCS blobs (`0x42`).

**Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
duplicating opcode lists.

@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L115">PyKotor — NCSByteCode</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L118-L140">PyKotor — NCSInstructionQualifier</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format">PyKotor wiki — NCS</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355">xoreos — NCSFile::load</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137">xoreos-tools — NCSFile::load</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html">xoreos-docs — Torlack ncs.html</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40">reone — NcsReader::load</a>
]##
proc read*(_: typedesc[BiowareNcsCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareNcsCommon =
  template this: untyped = result
  this = new(BiowareNcsCommon)
  let root = if root == nil: cast[BiowareNcsCommon](this) else: cast[BiowareNcsCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


proc fromFile*(_: typedesc[BiowareNcsCommon], filename: string): BiowareNcsCommon =
  BiowareNcsCommon.read(newKaitaiFileStream(filename), nil, nil)

