-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- **DA2S** (Dragon Age 2 save): Eclipse binary save — `DA2S` signature, `version==1`, length-prefixed strings + tagged
-- blocks (party/inventory/journal/etc.). **Not KotOR** — Andastra serializers under `Game/Games/Eclipse/DragonAge2/Save/` (`meta.xref`).
-- See also: xoreos — `GameID` (`kGameIDDragonAge2` = 8) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408)
-- See also: Andastra — `DragonAge2SaveSerializer` (https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAge2/Save/DragonAge2SaveSerializer.cs#L24-L180)
-- See also: Andastra — `EclipseSaveSerializer` helpers (https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126)
-- See also: xoreos-docs — BioWare specs tree (Dragon Age saves documented via Andastra + `GameID`; no DA2S-specific PDF here) (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
Da2s = class.class(KaitaiStruct)

function Da2s:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Da2s:_read()
  self.signature = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.signature == "DA2S") then
    error("not equal, expected " .. "DA2S" .. ", but got " .. self.signature)
  end
  self.version = self._io:read_s4le()
  if not(self.version == 1) then
    error("not equal, expected " .. 1 .. ", but got " .. self.version)
  end
  self.save_name = Da2s.LengthPrefixedString(self._io, self, self._root)
  self.module_name = Da2s.LengthPrefixedString(self._io, self, self._root)
  self.area_name = Da2s.LengthPrefixedString(self._io, self, self._root)
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
  self.player_name = Da2s.LengthPrefixedString(self._io, self, self._root)
  self.party_member_count = self._io:read_s4le()
  self.player_level = self._io:read_s4le()
end

-- 
-- File signature. Must be "DA2S" for Dragon Age 2 save files.
-- 
-- Save format version. Must be 1 for Dragon Age 2.
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

Da2s.LengthPrefixedString = class.class(KaitaiStruct)

function Da2s.LengthPrefixedString:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Da2s.LengthPrefixedString:_read()
  self.length = self._io:read_s4le()
  self.value = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(self.length), 0, false), "UTF-8")
end

-- 
-- String value.
-- Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
Da2s.LengthPrefixedString.property.value_trimmed = {}
function Da2s.LengthPrefixedString.property.value_trimmed:get()
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

