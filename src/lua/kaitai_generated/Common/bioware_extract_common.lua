-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local enum = require("enum")
local str_decode = require("string_decode")

-- 
-- Enums and small helper types used by installation/extraction tooling.
-- 
-- References:
-- - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/installation.py
-- See also: xoreos — `FileType` enum start (Aurora resource type IDs; no dedicated extraction-layout parser — this `.ksy` is tooling-side) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60)
-- See also: PyKotor — `SearchLocation` / `TexturePackNames` (maps to enums in this `.ksy`) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py#L67-L122)
-- See also: PyKotor — installation / search helpers (full module) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py)
-- See also: PyKotor — `extract/` package (https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/)
-- See also: Andastra — Eclipse extraction/installation model (https://github.com/OldRepublicDevs/Andastra/blob/master/src/andastra/parsing/extract/installation.cs)
-- See also: xoreos-docs — BioWare specs tree (tooling enums; no extraction-specific PDF) (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
BiowareExtractCommon = class.class(KaitaiStruct)

BiowareExtractCommon.BiowareSearchLocationId = enum.Enum {
  override = 0,
  modules = 1,
  chitin = 2,
  textures_tpa = 3,
  textures_tpb = 4,
  textures_tpc = 5,
  textures_gui = 6,
  music = 7,
  sound = 8,
  voice = 9,
  lips = 10,
  rims = 11,
  custom_modules = 12,
  custom_folders = 13,
}

function BiowareExtractCommon:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function BiowareExtractCommon:_read()
end


-- 
-- String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
BiowareExtractCommon.BiowareTexturePackNameStr = class.class(KaitaiStruct)

function BiowareExtractCommon.BiowareTexturePackNameStr:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareExtractCommon.BiowareTexturePackNameStr:_read()
  self.value = str_decode.decode(self._io:read_bytes_term(0, false, true, true), "ASCII")
  if not( ((self.value == "swpc_tex_tpa.erf") or (self.value == "swpc_tex_tpb.erf") or (self.value == "swpc_tex_tpc.erf") or (self.value == "swpc_tex_gui.erf")) ) then
    error("ValidationNotAnyOfError")
  end
end


