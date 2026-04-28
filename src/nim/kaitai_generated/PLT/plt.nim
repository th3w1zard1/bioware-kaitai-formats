import kaitai_struct_nim_runtime
import options

type
  Plt* = ref object of KaitaiStruct
    `header`*: Plt_PltHeader
    `pixelData`*: Plt_PixelDataSection
    `parent`*: KaitaiStruct
  Plt_PixelDataSection* = ref object of KaitaiStruct
    `pixels`*: seq[Plt_PltPixel]
    `parent`*: Plt
  Plt_PltHeader* = ref object of KaitaiStruct
    `signature`*: string
    `version`*: string
    `unknown1`*: uint32
    `unknown2`*: uint32
    `width`*: uint32
    `height`*: uint32
    `parent`*: Plt
  Plt_PltPixel* = ref object of KaitaiStruct
    `colorIndex`*: uint8
    `paletteGroupIndex`*: uint8
    `parent`*: Plt_PixelDataSection

proc read*(_: typedesc[Plt], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Plt
proc read*(_: typedesc[Plt_PixelDataSection], io: KaitaiStream, root: KaitaiStruct, parent: Plt): Plt_PixelDataSection
proc read*(_: typedesc[Plt_PltHeader], io: KaitaiStream, root: KaitaiStruct, parent: Plt): Plt_PltHeader
proc read*(_: typedesc[Plt_PltPixel], io: KaitaiStream, root: KaitaiStruct, parent: Plt_PixelDataSection): Plt_PltPixel



##[
PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
that reference external palette files, enabling dynamic color customization for character models
(skin, hair, armor colors, etc.).

**Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
including character models. This documentation is provided for reference only.

**reone:** the KotOR-focused fork does not ship a standalone PLT body reader; see `meta.xref.reone_resource_type_plt_note` for the numeric `Plt` type id only.

Binary Format Structure:
- Header (24 bytes): Signature, Version, Unknown fields, Width, Height
- Pixel Data: Array of 2-byte pixel entries (color index + palette group index)

Palette System:
PLT files work in conjunction with external palette files (.pal files) that contain the actual
color values. The PLT file itself stores:
1. Palette Group index (0-9): Which palette group to use for each pixel
2. Color index (0-255): Which color within the selected palette to use

At runtime, the game:
1. Loads the appropriate palette file for the selected palette group
2. Uses the palette index (supplied by the content creator) to select a row in the palette file
3. Uses the color index from the PLT file to retrieve the final color value

Palette Groups (10 total):
0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2

References:
- https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
- https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L374-L380 PyKotor — `ResourceType.PLT`
- https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
- https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy">PyKotor wiki — PLT (NWN legacy)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html">xoreos-docs — Torlack plt.html</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145">xoreos — `PLTFile::load`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L63">xoreos — `kFileTypePLT`</a>
@see <a href="https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L35">reone — `ResourceType::Plt` (id 6; no `.plt` wire reader on default branch)</a>
]##
proc read*(_: typedesc[Plt], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Plt =
  template this: untyped = result
  this = new(Plt)
  let root = if root == nil: cast[Plt](this) else: cast[Plt](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  PLT file header (24 bytes)
  ]##
  let headerExpr = Plt_PltHeader.read(this.io, this.root, this)
  this.header = headerExpr

  ##[
  Array of pixel entries (width × height entries, 2 bytes each)
  ]##
  let pixelDataExpr = Plt_PixelDataSection.read(this.io, this.root, this)
  this.pixelData = pixelDataExpr

proc fromFile*(_: typedesc[Plt], filename: string): Plt =
  Plt.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Plt_PixelDataSection], io: KaitaiStream, root: KaitaiStruct, parent: Plt): Plt_PixelDataSection =
  template this: untyped = result
  this = new(Plt_PixelDataSection)
  let root = if root == nil: cast[Plt](this) else: cast[Plt](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of pixel entries, stored row by row, left to right, top to bottom.
Total size = width × height × 2 bytes.
Each pixel entry contains a color index and palette group index.

  ]##
  for i in 0 ..< int(Plt(this.root).header.width * Plt(this.root).header.height):
    let it = Plt_PltPixel.read(this.io, this.root, this)
    this.pixels.add(it)

proc fromFile*(_: typedesc[Plt_PixelDataSection], filename: string): Plt_PixelDataSection =
  Plt_PixelDataSection.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Plt_PltHeader], io: KaitaiStream, root: KaitaiStruct, parent: Plt): Plt_PltHeader =
  template this: untyped = result
  this = new(Plt_PltHeader)
  let root = if root == nil: cast[Plt](this) else: cast[Plt](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File signature. Must be "PLT " (space-padded).
This identifies the file as a PLT palette texture.

  ]##
  let signatureExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.signature = signatureExpr

  ##[
  File format version. Must be "V1  " (space-padded).
This is the only known version of the PLT format.

  ]##
  let versionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.version = versionExpr

  ##[
  Unknown field (4 bytes).
Purpose is unknown, may be reserved for future use or internal engine flags.

  ]##
  let unknown1Expr = this.io.readU4le()
  this.unknown1 = unknown1Expr

  ##[
  Unknown field (4 bytes).
Purpose is unknown, may be reserved for future use or internal engine flags.

  ]##
  let unknown2Expr = this.io.readU4le()
  this.unknown2 = unknown2Expr

  ##[
  Texture width in pixels (uint32).
Used to calculate the number of pixel entries in the pixel data section.

  ]##
  let widthExpr = this.io.readU4le()
  this.width = widthExpr

  ##[
  Texture height in pixels (uint32).
Used to calculate the number of pixel entries in the pixel data section.
Total pixel count = width × height

  ]##
  let heightExpr = this.io.readU4le()
  this.height = heightExpr

proc fromFile*(_: typedesc[Plt_PltHeader], filename: string): Plt_PltHeader =
  Plt_PltHeader.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Plt_PltPixel], io: KaitaiStream, root: KaitaiStruct, parent: Plt_PixelDataSection): Plt_PltPixel =
  template this: untyped = result
  this = new(Plt_PltPixel)
  let root = if root == nil: cast[Plt](this) else: cast[Plt](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Color index (0-255) within the selected palette.
This value selects which color from the palette file row to use.
The palette file contains 256 rows (one for each palette index 0-255),
and each row contains 256 color values (one for each color index 0-255).

  ]##
  let colorIndexExpr = this.io.readU1()
  this.colorIndex = colorIndexExpr

  ##[
  Palette group index (0-9) that determines which palette file to use.
Palette groups:
0 = Skin (pal_skin01.jpg)
1 = Hair (pal_hair01.jpg)
2 = Metal 1 (pal_armor01.jpg)
3 = Metal 2 (pal_armor02.jpg)
4 = Cloth 1 (pal_cloth01.jpg)
5 = Cloth 2 (pal_cloth01.jpg)
6 = Leather 1 (pal_leath01.jpg)
7 = Leather 2 (pal_leath01.jpg)
8 = Tattoo 1 (pal_tattoo01.jpg)
9 = Tattoo 2 (pal_tattoo01.jpg)

  ]##
  let paletteGroupIndexExpr = this.io.readU1()
  this.paletteGroupIndex = paletteGroupIndexExpr

proc fromFile*(_: typedesc[Plt_PltPixel], filename: string): Plt_PltPixel =
  Plt_PltPixel.read(newKaitaiFileStream(filename), nil, nil)

