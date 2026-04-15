-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- SSF (Sound Set File) files store sound string references (StrRefs) for character voice sets.
-- Each SSF file contains exactly 28 sound slots, mapping to different game events and actions.
-- 
-- Binary Format:
-- - Header (12 bytes): File type signature, version, and offset to sounds array (usually 12)
-- - Sounds Array (112 bytes at sounds_offset): 28 uint32 values representing StrRefs (0xFFFFFFFF = -1 = no sound)
-- 
-- Vanilla KotOR SSFs are typically 136 bytes total: after the 28 StrRefs, many files append 12 bytes
-- of 0xFFFFFFFF padding; that trailer is not part of the header and is not modeled here.
-- 
-- Sound Slots (in order):
-- 0-5: Battle Cry 1-6
-- 6-8: Select 1-3
-- 9-11: Attack Grunt 1-3
-- 12-13: Pain Grunt 1-2
-- 14: Low Health
-- 15: Dead
-- 16: Critical Hit
-- 17: Target Immune
-- 18: Lay Mine
-- 19: Disarm Mine
-- 20: Begin Stealth
-- 21: Begin Search
-- 22: Begin Unlock
-- 23: Unlock Failed
-- 24: Unlock Success
-- 25: Separated From Party
-- 26: Rejoined Party
-- 27: Poisoned
-- 
-- References:
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/ssf_binary_reader.py
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/ssf_binary_writer.py
Ssf = class.class(KaitaiStruct)

function Ssf:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Ssf:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_type == "SSF ") then
    error("not equal, expected " .. "SSF " .. ", but got " .. self.file_type)
  end
  self.file_version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_version == "V1.1") then
    error("not equal, expected " .. "V1.1" .. ", but got " .. self.file_version)
  end
  self.sounds_offset = self._io:read_u4le()
end

-- 
-- Array of 28 sound string references (StrRefs).
Ssf.property.sounds = {}
function Ssf.property.sounds:get()
  if self._m_sounds ~= nil then
    return self._m_sounds
  end

  local _pos = self._io:pos()
  self._io:seek(self.sounds_offset)
  self._m_sounds = Ssf.SoundArray(self._io, self, self._root)
  self._io:seek(_pos)
  return self._m_sounds
end

-- 
-- File type signature. Must be "SSF " (space-padded).
-- Bytes: 0x53 0x53 0x46 0x20
-- 
-- File format version. Always "V1.1" for KotOR SSF files.
-- Bytes: 0x56 0x31 0x2E 0x31
-- 
-- Byte offset to the sounds array from the beginning of the file.
-- KotOR files almost always use 12 (0x0C) so the table follows the header immediately, but the
-- field is a real offset; readers must seek here instead of assuming 12.

Ssf.SoundArray = class.class(KaitaiStruct)

function Ssf.SoundArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Ssf.SoundArray:_read()
  self.entries = {}
  for i = 0, 28 - 1 do
    self.entries[i + 1] = Ssf.SoundEntry(self._io, self, self._root)
  end
end

-- 
-- Array of exactly 28 sound entries, one for each SSFSound enum value.
-- Each entry is a uint32 representing a StrRef (string reference).
-- Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
-- 
-- Entry indices map to SSFSound enum:
-- - 0-5: Battle Cry 1-6
-- - 6-8: Select 1-3
-- - 9-11: Attack Grunt 1-3
-- - 12-13: Pain Grunt 1-2
-- - 14: Low Health
-- - 15: Dead
-- - 16: Critical Hit
-- - 17: Target Immune
-- - 18: Lay Mine
-- - 19: Disarm Mine
-- - 20: Begin Stealth
-- - 21: Begin Search
-- - 22: Begin Unlock
-- - 23: Unlock Failed
-- - 24: Unlock Success
-- - 25: Separated From Party
-- - 26: Rejoined Party
-- - 27: Poisoned

Ssf.SoundEntry = class.class(KaitaiStruct)

function Ssf.SoundEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Ssf.SoundEntry:_read()
  self.strref_raw = self._io:read_u4le()
end

-- 
-- True if this entry represents "no sound" (0xFFFFFFFF).
-- False if this entry contains a valid StrRef value.
Ssf.SoundEntry.property.is_no_sound = {}
function Ssf.SoundEntry.property.is_no_sound:get()
  if self._m_is_no_sound ~= nil then
    return self._m_is_no_sound
  end

  self._m_is_no_sound = self.strref_raw == 4294967295
  return self._m_is_no_sound
end

-- 
-- Raw uint32 value representing the StrRef.
-- Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
-- All other values are valid StrRefs (typically 0-999999).
-- The conversion from 0xFFFFFFFF to -1 is handled by SSFBinaryReader.ReadInt32MaxNeg1().

