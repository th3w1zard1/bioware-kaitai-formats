-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
-- palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
-- that reference external palette files, enabling dynamic color customization for character models
-- (skin, hair, armor colors, etc.).
-- 
-- **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
-- resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
-- does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
-- including character models. This documentation is provided for reference only.
-- 
-- **reone:** the KotOR-focused fork does not ship a standalone PLT body reader; see `meta.xref.reone_resource_type_plt_note` for the numeric `Plt` type id only.
-- 
-- Binary Format Structure:
-- - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
-- - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)
-- 
-- Palette System:
-- PLT files work in conjunction with external palette files (.pal files) that contain the actual
-- color values. The PLT file itself stores:
-- 1. Palette Group index (0-9): Which palette group to use for each pixel
-- 2. Color index (0-255): Which color within the selected palette to use
-- 
-- At runtime, the game:
-- 1. Loads the appropriate palette file for the selected palette group
-- 2. Uses the palette index (supplied by the content creator) to select a row in the palette file
-- 3. Uses the color index from the PLT file to retrieve the final color value
-- 
-- Palette Groups (10 total):
-- 0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
-- 6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2
-- 
-- References:
-- - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L374-L380 PyKotor — `ResourceType.PLT`
-- - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
-- - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`
-- See also: PyKotor wiki — PLT (NWN legacy) (https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy)
-- See also: xoreos-docs — Torlack plt.html (https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html)
-- See also: xoreos — `PLTFile::load` (https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145)
-- See also: xoreos — `kFileTypePLT` (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L63)
-- See also: reone — `ResourceType::Plt` (id 6; no `.plt` wire reader on default branch) (https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L35)
Plt = class.class(KaitaiStruct)

function Plt:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Plt:_read()
  self.header = Plt.PltHeader(self._io, self, self._root)
  self.pixel_data = Plt.PixelDataSection(self._io, self, self._root)
end

-- 
-- PLT file header (24 bytes).
-- 
-- Array of pixel entries (width × height entries, 2 bytes each).

Plt.PixelDataSection = class.class(KaitaiStruct)

function Plt.PixelDataSection:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Plt.PixelDataSection:_read()
  self.pixels = {}
  for i = 0, self._root.header.width * self._root.header.height - 1 do
    self.pixels[i + 1] = Plt.PltPixel(self._io, self, self._root)
  end
end

-- 
-- Array of pixel entries, stored row by row, left to right, top to bottom.
-- Total size = width × height × 2 bytes.
-- Each pixel entry contains a color index and palette group index.

Plt.PltHeader = class.class(KaitaiStruct)

function Plt.PltHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Plt.PltHeader:_read()
  self.signature = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.signature == "PLT ") then
    error("not equal, expected " .. "PLT " .. ", but got " .. self.signature)
  end
  self.version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.version == "V1  ") then
    error("not equal, expected " .. "V1  " .. ", but got " .. self.version)
  end
  self.unknown1 = self._io:read_u4le()
  self.unknown2 = self._io:read_u4le()
  self.width = self._io:read_u4le()
  self.height = self._io:read_u4le()
end

-- 
-- File signature. Must be "PLT " (space-padded).
-- This identifies the file as a PLT palette texture.
-- 
-- File format version. Must be "V1  " (space-padded).
-- This is the only known version of the PLT format.
-- 
-- Unknown field (4 bytes).
-- Purpose is unknown, may be reserved for future use or internal engine flags.
-- 
-- Unknown field (4 bytes).
-- Purpose is unknown, may be reserved for future use or internal engine flags.
-- 
-- Texture width in pixels (uint32).
-- Used to calculate the number of pixel entries in the pixel data section.
-- 
-- Texture height in pixels (uint32).
-- Used to calculate the number of pixel entries in the pixel data section.
-- Total pixel count = width × height

Plt.PltPixel = class.class(KaitaiStruct)

function Plt.PltPixel:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Plt.PltPixel:_read()
  self.color_index = self._io:read_u1()
  self.palette_group_index = self._io:read_u1()
end

-- 
-- Color index (0-255) within the selected palette.
-- This value selects which color from the palette file row to use.
-- The palette file contains 256 rows (one for each palette index 0-255),
-- and each row contains 256 color values (one for each color index 0-255).
-- 
-- Palette group index (0-9) that determines which palette file to use.
-- Palette groups:
-- 0 = Skin (pal_skin01.jpg)
-- 1 = Hair (pal_hair01.jpg)
-- 2 = Metal 1 (pal_armor01.jpg)
-- 3 = Metal 2 (pal_armor02.jpg)
-- 4 = Cloth 1 (pal_cloth01.jpg)
-- 5 = Cloth 2 (pal_cloth01.jpg)
-- 6 = Leather 1 (pal_leath01.jpg)
-- 7 = Leather 2 (pal_leath01.jpg)
-- 8 = Tattoo 1 (pal_tattoo01.jpg)
-- 9 = Tattoo 2 (pal_tattoo01.jpg)

