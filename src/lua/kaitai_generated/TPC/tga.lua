-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("tga_common")
local str_decode = require("string_decode")

-- 
-- **TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
-- converts authoring TGAs to **TPC** for shipping.
-- 
-- Shared header enums: `formats/Common/tga_common.ksy`.
-- See also: PyKotor wiki — textures (TPC/TGA pipeline) (https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
-- See also: PyKotor — compact TGA reader (`tga.py`) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40)
-- See also: PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120)
-- See also: xoreos — `TGA::readHeader` (https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177)
-- See also: xoreos-tools — `TGA::load` through `readRLE` (tooling reader) (https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L241)
-- See also: xoreos-docs — BioWare specs PDF tree (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
-- See also: xoreos-docs — KotOR MDL overview (texture pipeline context) (https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html)
-- See also: lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`) (https://github.com/lachjames/NorthernLights)
Tga = class.class(KaitaiStruct)

function Tga:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Tga:_read()
  self.id_length = self._io:read_u1()
  self.color_map_type = TgaCommon.TgaColorMapType(self._io:read_u1())
  self.image_type = TgaCommon.TgaImageType(self._io:read_u1())
  if self.color_map_type == TgaCommon.TgaColorMapType.present then
    self.color_map_spec = Tga.ColorMapSpecification(self._io, self, self._root)
  end
  self.image_spec = Tga.ImageSpecification(self._io, self, self._root)
  if self.id_length > 0 then
    self.image_id = str_decode.decode(self._io:read_bytes(self.id_length), "ASCII")
  end
  if self.color_map_type == TgaCommon.TgaColorMapType.present then
    self.color_map_data = {}
    for i = 0, self.color_map_spec.length - 1 do
      self.color_map_data[i + 1] = self._io:read_u1()
    end
  end
  self.image_data = {}
  local i = 0
  while not self._io:is_eof() do
    self.image_data[i + 1] = self._io:read_u1()
    i = i + 1
  end
end

-- 
-- Length of image ID field (0-255 bytes).
-- 
-- Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.
-- 
-- Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.
-- 
-- Color map specification (only present if color_map_type == present).
-- 
-- Image specification (dimensions and pixel format).
-- 
-- Image identification field (optional ASCII string).
-- 
-- Color map data (palette entries).
-- 
-- Image pixel data (raw or RLE-compressed).
-- Size depends on image dimensions, pixel format, and compression.
-- For uncompressed formats: width × height × bytes_per_pixel
-- For RLE formats: Variable size depending on compression ratio

Tga.ColorMapSpecification = class.class(KaitaiStruct)

function Tga.ColorMapSpecification:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Tga.ColorMapSpecification:_read()
  self.first_entry_index = self._io:read_u2le()
  self.length = self._io:read_u2le()
  self.entry_size = self._io:read_u1()
end

-- 
-- Index of first color map entry.
-- 
-- Number of color map entries.
-- 
-- Size of each color map entry in bits (15, 16, 24, or 32).

Tga.ImageSpecification = class.class(KaitaiStruct)

function Tga.ImageSpecification:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Tga.ImageSpecification:_read()
  self.x_origin = self._io:read_u2le()
  self.y_origin = self._io:read_u2le()
  self.width = self._io:read_u2le()
  self.height = self._io:read_u2le()
  self.pixel_depth = self._io:read_u1()
  self.image_descriptor = self._io:read_u1()
end

-- 
-- X coordinate of lower-left corner of image.
-- 
-- Y coordinate of lower-left corner of image.
-- 
-- Image width in pixels.
-- 
-- Image height in pixels.
-- 
-- Bits per pixel:
-- - 8 = Greyscale or indexed
-- - 16 = RGB 5-5-5 or RGBA 1-5-5-5
-- - 24 = RGB
-- - 32 = RGBA
-- 
-- Image descriptor byte:
-- - Bits 0-3: Number of attribute bits per pixel (alpha channel)
-- - Bit 4: Reserved
-- - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
-- - Bits 6-7: Interleaving (usually 0)

