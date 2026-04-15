import kaitai_struct_nim_runtime
import options

type
  Bzf* = ref object of KaitaiStruct
    `fileType`*: string
    `version`*: string
    `compressedData`*: seq[byte]
    `parent`*: KaitaiStruct

proc read*(_: typedesc[Bzf], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bzf



##[
**BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
mobile KotOR ports.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression">PyKotor wiki — BZF (LZMA BIF)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L26-L54">PyKotor — `_decompress_bzf_payload`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/bzffile.cpp#L41-L83">xoreos — `kBZFID` quirk + `BZFFile::load`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L207">xoreos-tools — `.bzf` → `BZFFile`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf">xoreos-docs — KeyBIF_Format.pdf</a>
]##
proc read*(_: typedesc[Bzf], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bzf =
  template this: untyped = result
  this = new(Bzf)
  let root = if root == nil: cast[Bzf](this) else: cast[Bzf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "BZF " for compressed BIF files.
  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Always "V1.0" for BZF files.
  ]##
  let versionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.version = versionExpr

  ##[
  LZMA-compressed BIF file data (single blob to EOF).
Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).

  ]##
  let compressedDataExpr = this.io.readBytesFull()
  this.compressedData = compressedDataExpr

proc fromFile*(_: typedesc[Bzf], filename: string): Bzf =
  Bzf.read(newKaitaiFileStream(filename), nil, nil)

