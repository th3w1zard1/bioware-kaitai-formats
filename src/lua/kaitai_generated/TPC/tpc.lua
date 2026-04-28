-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_common")

-- 
-- **TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
-- (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
-- (`meta.xref`).
-- See also: PyKotor wiki — TPC (https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
-- See also: PyKotor — `TPCBinaryReader` + `load` (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303)
-- See also: PyKotor — `TPCTextureFormat` (opening) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120)
-- See also: PyKotor — `class TPC` (opening) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520)
-- See also: reone — `TpcReader` (body + TXI features) (https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105)
-- See also: xoreos — `kFileTypeTPC` (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L183)
-- See also: xoreos — `TPC::load` through `readTXI` entrypoints (https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L362)
-- See also: xoreos-tools — `TPC::load` (https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68)
-- See also: xoreos-tools — `TPC::readHeader` (https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224)
-- See also: xoreos-docs — BioWare specs PDF tree (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
-- See also: xoreos-docs — KotOR MDL overview (texture pipeline context) (https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html)
-- See also: KotOR.js — `TPCObject.readHeader` (https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts#L290-L380)
Tpc = class.class(KaitaiStruct)

function Tpc:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Tpc:_read()
  self.header = Tpc.TpcHeader(self._io, self, self._root)
  self.body = self._io:read_bytes_full()
end

-- 
-- TPC file header (128 bytes total).
-- 
-- Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).

Tpc.TpcHeader = class.class(KaitaiStruct)

function Tpc.TpcHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Tpc.TpcHeader:_read()
  self.data_size = self._io:read_u4le()
  self.alpha_test = self._io:read_f4le()
  self.width = self._io:read_u2le()
  self.height = self._io:read_u2le()
  self.pixel_encoding = BiowareCommon.BiowareTpcPixelFormatId(self._io:read_u1())
  self.mipmap_count = self._io:read_u1()
  self.reserved = {}
  for i = 0, 114 - 1 do
    self.reserved[i + 1] = self._io:read_u1()
  end
end

-- 
-- True if texture data is compressed (DXT format).
Tpc.TpcHeader.property.is_compressed = {}
function Tpc.TpcHeader.property.is_compressed:get()
  if self._m_is_compressed ~= nil then
    return self._m_is_compressed
  end

  self._m_is_compressed = self.data_size ~= 0
  return self._m_is_compressed
end

-- 
-- True if texture data is uncompressed (raw pixels).
Tpc.TpcHeader.property.is_uncompressed = {}
function Tpc.TpcHeader.property.is_uncompressed:get()
  if self._m_is_uncompressed ~= nil then
    return self._m_is_uncompressed
  end

  self._m_is_uncompressed = self.data_size == 0
  return self._m_is_uncompressed
end

-- 
-- Total compressed payload size. If non-zero, texture is compressed (DXT).
-- If zero, texture is uncompressed and size is derived from format/width/height.
-- 
-- Float threshold used by punch-through rendering.
-- Commonly 0.0 or 0.5.
-- 
-- Texture width in pixels (uint16).
-- Must be power-of-two for compressed formats.
-- 
-- Texture height in pixels (uint16).
-- For cube maps, this is 6x the face width.
-- Must be power-of-two for compressed formats.
-- 
-- Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
-- `bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).
-- 
-- Number of mip levels per layer (minimum 1).
-- Each mip level is half the size of the previous level.
-- 
-- Reserved/padding bytes (0x72 = 114 bytes).
-- KotOR stores platform hints here but all implementations skip them.

