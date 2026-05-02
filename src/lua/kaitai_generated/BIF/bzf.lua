-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- **BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
-- mobile KotOR ports.
-- See also: PyKotor wiki — BZF (LZMA BIF) (https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression)
-- See also: PyKotor — `_decompress_bzf_payload` (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L26-L54)
-- See also: xoreos — `kBZFID` quirk + `BZFFile::load` (https://github.com/xoreos/xoreos/blob/master/src/aurora/bzffile.cpp#L41-L83)
-- See also: xoreos-tools — `.bzf` → `BZFFile` (https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L207)
-- See also: xoreos-docs — KeyBIF_Format.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf)
Bzf = class.class(KaitaiStruct)

function Bzf:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Bzf:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_type == "BZF ") then
    error("not equal, expected " .. "BZF " .. ", but got " .. self.file_type)
  end
  self.version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.version == "V1.0") then
    error("not equal, expected " .. "V1.0" .. ", but got " .. self.version)
  end
  self.compressed_data = self._io:read_bytes_full()
end

-- 
-- File type signature. Must be "BZF " for compressed BIF files.
-- 
-- File format version. Always "V1.0" for BZF files.
-- 
-- LZMA-compressed BIF file data (single blob to EOF).
-- Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).

