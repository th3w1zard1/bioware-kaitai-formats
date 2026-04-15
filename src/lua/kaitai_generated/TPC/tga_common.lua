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
-- See also: PyKotor wiki — textures (TGA pipeline) (https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
-- See also: PyKotor — `tga.py` (reader core) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40)
-- See also: xoreos — `TGA::readHeader` (https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177)
-- See also: xoreos — `kFileTypeTGA` (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L61)
-- See also: xoreos-tools — `TGA::load` (https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L80)
-- See also: xoreos-docs — BioWare specs PDF tree (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
-- See also: xoreos-docs — KotOR MDL overview (texture context) (https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html)
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


