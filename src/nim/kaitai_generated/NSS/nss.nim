import kaitai_struct_nim_runtime
import options

type
  Nss* = ref object of KaitaiStruct
    `bom`*: uint16
    `sourceCode`*: string
    `parent`*: KaitaiStruct
  Nss_NssSource* = ref object of KaitaiStruct
    `content`*: string
    `parent`*: KaitaiStruct

proc read*(_: typedesc[Nss], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Nss
proc read*(_: typedesc[Nss_NssSource], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Nss_NssSource



##[
NSS (NWScript Source) files contain human-readable NWScript source code
that compiles to NCS bytecode. NWScript is the scripting language used
in KotOR, TSL, and Neverwinter Nights.

NSS files are plain text files (typically Windows-1252 or UTF-8 encoding)
containing NWScript source code. The nwscript.nss file defines all
engine-exposed functions and constants available to scripts.

Format:
- Plain text source code
- May include BOM (Byte Order Mark) for UTF-8 files
- Lines are typically terminated with CRLF (\r\n) or LF (\n)
- Comments: // for single-line, /* */ for multi-line
- Preprocessor directives: #include, #define, etc.

Authoritative links: `meta.doc-ref` (PyKotor wiki, xoreos `types.h` `kFileTypeNSS`, xoreos-tools `NCSFile`, reone `NssWriter`).

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/NSS-File-Format">PyKotor wiki — NSS</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L85-L86">xoreos — `kFileTypeNSS` / `kFileTypeNCS` (Aurora `FileType` IDs; NSS plaintext, NCS bytecode)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137">xoreos-tools — `NCSFile`</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/tools/script/format/nsswriter.cpp#L33-L45">reone — `NssWriter::save`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html">xoreos-docs — Torlack NCS (bytecode companion to plaintext NSS)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree</a>
]##
proc read*(_: typedesc[Nss], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Nss =
  template this: untyped = result
  this = new(Nss)
  let root = if root == nil: cast[Nss](this) else: cast[Nss](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Optional UTF-8 BOM (Byte Order Mark) at the start of the file.
If present, will be 0xFEFF (UTF-8 BOM).
Most NSS files do not include a BOM.

  ]##
  if this.io.pos == 0:
    let bomExpr = this.io.readU2le()
    this.bom = bomExpr

  ##[
  Complete NWScript source code.
Contains function definitions, variable declarations, control flow
statements, and engine function calls.

Common elements:
- Function definitions: void function_name() { ... }
- Variable declarations: int variable_name;
- Control flow: if, while, for, switch
- Engine function calls: GetFirstObject(), GetObjectByTag(), etc.
- Constants: OBJECT_SELF, OBJECT_INVALID, etc.

The source code is compiled to NCS bytecode by the NWScript compiler.

  ]##
  let sourceCodeExpr = encode(this.io.readBytesFull(), "UTF-8")
  this.sourceCode = sourceCodeExpr

proc fromFile*(_: typedesc[Nss], filename: string): Nss =
  Nss.read(newKaitaiFileStream(filename), nil, nil)


##[
NWScript source code structure.
This is primarily a text format, so the main content is the source_code string.

The source can be parsed into:
- Tokens (keywords, identifiers, operators, literals)
- Statements (declarations, assignments, control flow)
- Functions (definitions with parameters and body)
- Preprocessor directives (#include, #define)

]##
proc read*(_: typedesc[Nss_NssSource], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Nss_NssSource =
  template this: untyped = result
  this = new(Nss_NssSource)
  let root = if root == nil: cast[Nss](this) else: cast[Nss](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Complete source code content.
  ]##
  let contentExpr = encode(this.io.readBytesFull(), "UTF-8")
  this.content = contentExpr

proc fromFile*(_: typedesc[Nss_NssSource], filename: string): Nss_NssSource =
  Nss_NssSource.read(newKaitaiFileStream(filename), nil, nil)

