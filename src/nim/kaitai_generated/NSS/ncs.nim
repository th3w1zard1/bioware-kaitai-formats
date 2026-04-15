import kaitai_struct_nim_runtime
import options
import bioware_ncs_common

type
  Ncs* = ref object of KaitaiStruct
    `fileType`*: string
    `fileVersion`*: string
    `sizeMarker`*: uint8
    `fileSize`*: uint32
    `instructions`*: seq[Ncs_Instruction]
    `parent`*: KaitaiStruct
  Ncs_Instruction* = ref object of KaitaiStruct
    `opcode`*: BiowareNcsCommon_NcsBytecode
    `qualifier`*: BiowareNcsCommon_NcsInstructionQualifier
    `arguments`*: seq[uint8]
    `parent`*: Ncs

proc read*(_: typedesc[Ncs], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Ncs
proc read*(_: typedesc[Ncs_Instruction], io: KaitaiStream, root: KaitaiStruct, parent: Ncs): Ncs_Instruction



##[
NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
Scripts run inside a stack-based virtual machine shared across Aurora engine games.

Format Structure:
- Header (13 bytes): Signature "NCS ", version "V1.0", size marker (0x42), file size
- Instruction Stream: Sequence of bytecode instructions

All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).

NWScript **source** (`.nss`) is plaintext tooling; it is intentionally not modeled as Kaitai in this repository
(see `AGENTS.md`). This spec covers the **binary** `.ncs` wire format only.

Opcode / qualifier enumerations: imported from `formats/Common/bioware_ncs_common.ksy` (mirrors PyKotor `ncs_data.py`).

Authoritative parsers and notes: `meta.xref` and `doc-ref` (PyKotor, xoreos, xoreos-tools, xoreos-docs Torlack, reone).

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format">PyKotor wiki — NCS</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/io_ncs.py#L60-L90">PyKotor — compiled script load path</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355">xoreos — NCSFile::load</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137">xoreos-tools — NCSFile::load</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html">xoreos-docs — Torlack ncs.html</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40">reone — NcsReader::load</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L140">PyKotor — NCSByteCode / NCSInstructionQualifier (shared .ksy enums)</a>
]##
proc read*(_: typedesc[Ncs], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Ncs =
  template this: untyped = result
  this = new(Ncs)
  let root = if root == nil: cast[Ncs](this) else: cast[Ncs](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "NCS " (0x4E 0x43 0x53 0x20).
  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Must be "V1.0" (0x56 0x31 0x2E 0x30).
  ]##
  let fileVersionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileVersion = fileVersionExpr

  ##[
  Program size marker opcode. Must be 0x42.
This is not a real instruction but a metadata field containing the total file size.
All implementations validate this marker before parsing instructions.

  ]##
  let sizeMarkerExpr = this.io.readU1()
  this.sizeMarker = sizeMarkerExpr

  ##[
  Total file size in bytes (big-endian).
This value should match the actual file size.

  ]##
  let fileSizeExpr = this.io.readU4be()
  this.fileSize = fileSizeExpr

  ##[
  Stream of bytecode instructions.
Execution begins at offset 13 (0x0D) after the header.
Instructions continue until end of file.

  ]##
  block:
    var i: int
    while true:
      let it = Ncs_Instruction.read(this.io, this.root, this)
      this.instructions.add(it)
      if this.io.pos >= this.fileSize:
        break
      inc i

proc fromFile*(_: typedesc[Ncs], filename: string): Ncs =
  Ncs.read(newKaitaiFileStream(filename), nil, nil)


##[
NWScript bytecode instruction.
Format: <opcode: uint8> <qualifier: uint8> <arguments: variable>

Instruction size varies by opcode:
- Base: 2 bytes (opcode + qualifier)
- Arguments: 0 to variable bytes depending on instruction type

Common instruction types:
- Constants: CONSTI (6B), CONSTF (6B), CONSTS (2+N B), CONSTO (6B)
- Stack ops: CPDOWNSP, CPTOPSP, MOVSP (variable size)
- Arithmetic: ADDxx, SUBxx, MULxx, DIVxx (2B)
- Control flow: JMP, JSR, JZ, JNZ (6B), RETN (2B)
- Function calls: ACTION (5B)
- And many more (see NCS format documentation)

]##
proc read*(_: typedesc[Ncs_Instruction], io: KaitaiStream, root: KaitaiStruct, parent: Ncs): Ncs_Instruction =
  template this: untyped = result
  this = new(Ncs_Instruction)
  let root = if root == nil: cast[Ncs](this) else: cast[Ncs](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Instruction opcode (0x01-0x2D, excluding 0x42 which is reserved for size marker).
Determines the instruction type and argument format.

  ]##
  let opcodeExpr = BiowareNcsCommon_NcsBytecode(this.io.readU1())
  this.opcode = opcodeExpr

  ##[
  Qualifier byte that refines the instruction to specific operand types.
Examples: 0x03=Int, 0x04=Float, 0x05=String, 0x06=Object, 0x24=Structure

  ]##
  let qualifierExpr = BiowareNcsCommon_NcsInstructionQualifier(this.io.readU1())
  this.qualifier = qualifierExpr

  ##[
  Instruction arguments (variable size).
Format depends on opcode:
- No args: None (total 2B)
- Int/Float/Object: 4 bytes (total 6B)
- String: 2B length + data (total 2+N B)
- Jump: 4B signed offset (total 6B)
- Stack copy: 4B offset + 2B size (total 8B)
- ACTION: 2B routine + 1B argCount (total 5B)
- DESTRUCT: 2B size + 2B offset + 2B sizeNoDestroy (total 8B)
- STORE_STATE: 4B size + 4B sizeLocals (total 10B)
- And others (see documentation)

  ]##
  block:
    var i: int
    while true:
      let it = this.io.readU1()
      this.arguments.add(it)
      if this.io.pos >= this.io.size:
        break
      inc i

proc fromFile*(_: typedesc[Ncs_Instruction], filename: string): Ncs_Instruction =
  Ncs_Instruction.read(newKaitaiFileStream(filename), nil, nil)

