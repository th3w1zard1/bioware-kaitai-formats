import kaitai_struct_nim_runtime
import options
import tga_common

type
  Tga* = ref object of KaitaiStruct
    `idLength`*: uint8
    `colorMapType`*: TgaCommon_TgaColorMapType
    `imageType`*: TgaCommon_TgaImageType
    `colorMapSpec`*: Tga_ColorMapSpecification
    `imageSpec`*: Tga_ImageSpecification
    `imageId`*: string
    `colorMapData`*: seq[uint8]
    `imageData`*: seq[uint8]
    `parent`*: KaitaiStruct
  Tga_ColorMapSpecification* = ref object of KaitaiStruct
    `firstEntryIndex`*: uint16
    `length`*: uint16
    `entrySize`*: uint8
    `parent`*: Tga
  Tga_ImageSpecification* = ref object of KaitaiStruct
    `xOrigin`*: uint16
    `yOrigin`*: uint16
    `width`*: uint16
    `height`*: uint16
    `pixelDepth`*: uint8
    `imageDescriptor`*: uint8
    `parent`*: Tga

proc read*(_: typedesc[Tga], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Tga
proc read*(_: typedesc[Tga_ColorMapSpecification], io: KaitaiStream, root: KaitaiStruct, parent: Tga): Tga_ColorMapSpecification
proc read*(_: typedesc[Tga_ImageSpecification], io: KaitaiStream, root: KaitaiStruct, parent: Tga): Tga_ImageSpecification



##[
**TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
converts authoring TGAs to **TPC** for shipping.

Shared header enums: `formats/Common/tga_common.ksy`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — textures (TPC/TGA pipeline)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40">PyKotor — compact TGA reader (`tga.py`)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120">PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177">xoreos — `TGA::readHeader`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L241">xoreos-tools — `TGA::load` through `readRLE` (tooling reader)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture pipeline context)</a>
@see <a href="https://github.com/lachjames/NorthernLights">lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)</a>
]##
proc read*(_: typedesc[Tga], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Tga =
  template this: untyped = result
  this = new(Tga)
  let root = if root == nil: cast[Tga](this) else: cast[Tga](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Length of image ID field (0-255 bytes)
  ]##
  let idLengthExpr = this.io.readU1()
  this.idLength = idLengthExpr

  ##[
  Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.

  ]##
  let colorMapTypeExpr = TgaCommon_TgaColorMapType(this.io.readU1())
  this.colorMapType = colorMapTypeExpr

  ##[
  Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.

  ]##
  let imageTypeExpr = TgaCommon_TgaImageType(this.io.readU1())
  this.imageType = imageTypeExpr

  ##[
  Color map specification (only present if color_map_type == present)
  ]##
  if this.colorMapType == tga_common.present:
    let colorMapSpecExpr = Tga_ColorMapSpecification.read(this.io, this.root, this)
    this.colorMapSpec = colorMapSpecExpr

  ##[
  Image specification (dimensions and pixel format)
  ]##
  let imageSpecExpr = Tga_ImageSpecification.read(this.io, this.root, this)
  this.imageSpec = imageSpecExpr

  ##[
  Image identification field (optional ASCII string)
  ]##
  if this.idLength > 0:
    let imageIdExpr = encode(this.io.readBytes(int(this.idLength)), "ASCII")
    this.imageId = imageIdExpr

  ##[
  Color map data (palette entries)
  ]##
  if this.colorMapType == tga_common.present:
    for i in 0 ..< int(this.colorMapSpec.length):
      let it = this.io.readU1()
      this.colorMapData.add(it)

  ##[
  Image pixel data (raw or RLE-compressed).
Size depends on image dimensions, pixel format, and compression.
For uncompressed formats: width × height × bytes_per_pixel
For RLE formats: Variable size depending on compression ratio

  ]##
  block:
    var i: int
    while not this.io.isEof:
      let it = this.io.readU1()
      this.imageData.add(it)
      inc i

proc fromFile*(_: typedesc[Tga], filename: string): Tga =
  Tga.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Tga_ColorMapSpecification], io: KaitaiStream, root: KaitaiStruct, parent: Tga): Tga_ColorMapSpecification =
  template this: untyped = result
  this = new(Tga_ColorMapSpecification)
  let root = if root == nil: cast[Tga](this) else: cast[Tga](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Index of first color map entry
  ]##
  let firstEntryIndexExpr = this.io.readU2le()
  this.firstEntryIndex = firstEntryIndexExpr

  ##[
  Number of color map entries
  ]##
  let lengthExpr = this.io.readU2le()
  this.length = lengthExpr

  ##[
  Size of each color map entry in bits (15, 16, 24, or 32)
  ]##
  let entrySizeExpr = this.io.readU1()
  this.entrySize = entrySizeExpr

proc fromFile*(_: typedesc[Tga_ColorMapSpecification], filename: string): Tga_ColorMapSpecification =
  Tga_ColorMapSpecification.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Tga_ImageSpecification], io: KaitaiStream, root: KaitaiStruct, parent: Tga): Tga_ImageSpecification =
  template this: untyped = result
  this = new(Tga_ImageSpecification)
  let root = if root == nil: cast[Tga](this) else: cast[Tga](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  X coordinate of lower-left corner of image
  ]##
  let xOriginExpr = this.io.readU2le()
  this.xOrigin = xOriginExpr

  ##[
  Y coordinate of lower-left corner of image
  ]##
  let yOriginExpr = this.io.readU2le()
  this.yOrigin = yOriginExpr

  ##[
  Image width in pixels
  ]##
  let widthExpr = this.io.readU2le()
  this.width = widthExpr

  ##[
  Image height in pixels
  ]##
  let heightExpr = this.io.readU2le()
  this.height = heightExpr

  ##[
  Bits per pixel:
- 8 = Greyscale or indexed
- 16 = RGB 5-5-5 or RGBA 1-5-5-5
- 24 = RGB
- 32 = RGBA

  ]##
  let pixelDepthExpr = this.io.readU1()
  this.pixelDepth = pixelDepthExpr

  ##[
  Image descriptor byte:
- Bits 0-3: Number of attribute bits per pixel (alpha channel)
- Bit 4: Reserved
- Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
- Bits 6-7: Interleaving (usually 0)

  ]##
  let imageDescriptorExpr = this.io.readU1()
  this.imageDescriptor = imageDescriptorExpr

proc fromFile*(_: typedesc[Tga_ImageSpecification], filename: string): Tga_ImageSpecification =
  Tga_ImageSpecification.read(newKaitaiFileStream(filename), nil, nil)

