-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- **DAS** (Dragon Age: Origins save): Eclipse binary save — `DAS ` signature, `version==1`, length-prefixed strings +
-- tagged blocks. **Not KotOR** — reference serializers live under **Andastra** `Game/Games/Eclipse/...` on GitHub (`meta.xref`), not `Runtime/...`.
-- See also: xoreos — `GameID` (`kGameIDDragonAge` = 7) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408)
-- See also: Andastra — `DragonAgeOriginsSaveSerializer` (signature + nfo + archive entrypoints) (https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAgeOrigins/Save/DragonAgeOriginsSaveSerializer.cs#L23-L180)
-- See also: Andastra — `EclipseSaveSerializer` string + metadata helpers (https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126)
-- See also: xoreos-docs — BioWare specs tree (DAO saves via Andastra; no DAS-specific PDF here) (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
Das = class.class(KaitaiStruct)

function Das:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Das:_read()
  self.signature = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.signature == "DAS ") then
    error("not equal, expected " .. "DAS " .. ", but got " .. self.signature)
  end
  self.version = self._io:read_s4le()
  if not(self.version == 1) then
    error("not equal, expected " .. 1 .. ", but got " .. self.version)
  end
  self.save_name = Das.LengthPrefixedString(self._io, self, self._root)
  self.module_name = Das.LengthPrefixedString(self._io, self, self._root)
  self.area_name = Das.LengthPrefixedString(self._io, self, self._root)
  self.time_played_seconds = self._io:read_s4le()
  self.timestamp_filetime = self._io:read_s8le()
  self.num_screenshot_data = self._io:read_s4le()
  if self.num_screenshot_data > 0 then
    self.screenshot_data = {}
    for i = 0, self.num_screenshot_data - 1 do
      self.screenshot_data[i + 1] = self._io:read_u1()
    end
  end
  self.num_portrait_data = self._io:read_s4le()
  if self.num_portrait_data > 0 then
    self.portrait_data = {}
    for i = 0, self.num_portrait_data - 1 do
      self.portrait_data[i + 1] = self._io:read_u1()
    end
  end
  self.player_name = Das.LengthPrefixedString(self._io, self, self._root)
  self.party_member_count = self._io:read_s4le()
  self.player_level = self._io:read_s4le()
end

-- 
-- File signature. Must be "DAS " for Dragon Age: Origins save files.
-- 
-- Save format version. Must be 1 for Dragon Age: Origins.
-- 
-- User-entered save name displayed in UI.
-- 
-- Current module resource name.
-- 
-- Current area name for display.
-- 
-- Total play time in seconds.
-- 
-- Save creation timestamp as Windows FILETIME (int64).
-- Convert using DateTime.FromFileTime().
-- 
-- Length of screenshot data in bytes (0 if no screenshot).
-- 
-- Screenshot image data (typically TGA or DDS format).
-- 
-- Length of portrait data in bytes (0 if no portrait).
-- 
-- Portrait image data (typically TGA or DDS format).
-- 
-- Player character name.
-- 
-- Number of party members (from PartyState).
-- 
-- Player character level (from PartyState.PlayerCharacter).

Das.LengthPrefixedString = class.class(KaitaiStruct)

function Das.LengthPrefixedString:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Das.LengthPrefixedString:_read()
  self.length = self._io:read_s4le()
  self.value = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(self.length), 0, false), "UTF-8")
end

-- 
-- String value.
-- Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
Das.LengthPrefixedString.property.value_trimmed = {}
function Das.LengthPrefixedString.property.value_trimmed:get()
  if self._m_value_trimmed ~= nil then
    return self._m_value_trimmed
  end

  self._m_value_trimmed = self.value
  return self._m_value_trimmed
end

-- 
-- String length in bytes (UTF-8 encoding).
-- Must be >= 0 and <= 65536 (sanity check).
-- 
-- String value (UTF-8 encoded).

