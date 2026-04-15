import kaitai_struct_nim_runtime
import options
import bioware_common

type
  Tpc* = ref object of KaitaiStruct
    `header`*: Tpc_TpcHeader
    `body`*: seq[byte]
    `parent`*: KaitaiStruct
  Tpc_TpcHeader* = ref object of KaitaiStruct
    `dataSize`*: uint32
    `alphaTest`*: float32
    `width`*: uint16
    `height`*: uint16
    `pixelEncoding`*: BiowareCommon_BiowareTpcPixelFormatId
    `mipmapCount`*: uint8
    `reserved`*: seq[uint8]
    `parent`*: Tpc
    `isCompressedInst`: bool
    `isCompressedInstFlag`: bool
    `isUncompressedInst`: bool
    `isUncompressedInstFlag`: bool

proc read*(_: typedesc[Tpc], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Tpc
proc read*(_: typedesc[Tpc_TpcHeader], io: KaitaiStream, root: KaitaiStruct, parent: Tpc): Tpc_TpcHeader

proc isCompressed*(this: Tpc_TpcHeader): bool
proc isUncompressed*(this: Tpc_TpcHeader): bool


##[
**TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
(mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
(`meta.xref`).

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — TPC</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303">PyKotor — `TPCBinaryReader` + `load`</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120">PyKotor — `TPCTextureFormat` (opening)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520">PyKotor — `class TPC` (opening)</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105">reone — `TpcReader` (body + TXI features)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L183">xoreos — `kFileTypeTPC`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L362">xoreos — `TPC::load` through `readTXI` entrypoints</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68">xoreos-tools — `TPC::load`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224">xoreos-tools — `TPC::readHeader`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture pipeline context)</a>
@see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts#L290-L380">KotOR.js — `TPCObject.readHeader`</a>
]##
proc read*(_: typedesc[Tpc], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Tpc =
  template this: untyped = result
  this = new(Tpc)
  let root = if root == nil: cast[Tpc](this) else: cast[Tpc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  TPC file header (128 bytes total)
  ]##
  let headerExpr = Tpc_TpcHeader.read(this.io, this.root, this)
  this.header = headerExpr

  ##[
  Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).

  ]##
  let bodyExpr = this.io.readBytesFull()
  this.body = bodyExpr

proc fromFile*(_: typedesc[Tpc], filename: string): Tpc =
  Tpc.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Tpc_TpcHeader], io: KaitaiStream, root: KaitaiStruct, parent: Tpc): Tpc_TpcHeader =
  template this: untyped = result
  this = new(Tpc_TpcHeader)
  let root = if root == nil: cast[Tpc](this) else: cast[Tpc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Total compressed payload size. If non-zero, texture is compressed (DXT).
If zero, texture is uncompressed and size is derived from format/width/height.

  ]##
  let dataSizeExpr = this.io.readU4le()
  this.dataSize = dataSizeExpr

  ##[
  Float threshold used by punch-through rendering.
Commonly 0.0 or 0.5.

  ]##
  let alphaTestExpr = this.io.readF4le()
  this.alphaTest = alphaTestExpr

  ##[
  Texture width in pixels (uint16).
Must be power-of-two for compressed formats.

  ]##
  let widthExpr = this.io.readU2le()
  this.width = widthExpr

  ##[
  Texture height in pixels (uint16).
For cube maps, this is 6x the face width.
Must be power-of-two for compressed formats.

  ]##
  let heightExpr = this.io.readU2le()
  this.height = heightExpr

  ##[
  Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
`bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).

  ]##
  let pixelEncodingExpr = BiowareCommon_BiowareTpcPixelFormatId(this.io.readU1())
  this.pixelEncoding = pixelEncodingExpr

  ##[
  Number of mip levels per layer (minimum 1).
Each mip level is half the size of the previous level.

  ]##
  let mipmapCountExpr = this.io.readU1()
  this.mipmapCount = mipmapCountExpr

  ##[
  Reserved/padding bytes (0x72 = 114 bytes).
KotOR stores platform hints here but all implementations skip them.

  ]##
  for i in 0 ..< int(114):
    let it = this.io.readU1()
    this.reserved.add(it)

proc isCompressed(this: Tpc_TpcHeader): bool = 

  ##[
  True if texture data is compressed (DXT format)
  ]##
  if this.isCompressedInstFlag:
    return this.isCompressedInst
  let isCompressedInstExpr = bool(this.dataSize != 0)
  this.isCompressedInst = isCompressedInstExpr
  this.isCompressedInstFlag = true
  return this.isCompressedInst

proc isUncompressed(this: Tpc_TpcHeader): bool = 

  ##[
  True if texture data is uncompressed (raw pixels)
  ]##
  if this.isUncompressedInstFlag:
    return this.isUncompressedInst
  let isUncompressedInstExpr = bool(this.dataSize == 0)
  this.isUncompressedInst = isUncompressedInstExpr
  this.isUncompressedInstFlag = true
  return this.isUncompressedInst

proc fromFile*(_: typedesc[Tpc_TpcHeader], filename: string): Tpc_TpcHeader =
  Tpc_TpcHeader.read(newKaitaiFileStream(filename), nil, nil)

