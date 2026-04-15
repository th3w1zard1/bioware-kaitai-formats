-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local enum = require("enum")

-- 
-- Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
-- per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
-- 
-- Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
TgaCommon = class.class(KaitaiStruct)

TgaCommon.TgaColorMapType = enum.Enum {
  none = 0,
  present = 1,
}

TgaCommon.TgaImageType = enum.Enum {
  no_image_data = 0,
  uncompressed_color_mapped = 1,
  uncompressed_rgb = 2,
  uncompressed_greyscale = 3,
  rle_color_mapped = 9,
  rle_rgb = 10,
  rle_greyscale = 11,
}

function TgaCommon:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function TgaCommon:_read()
end


