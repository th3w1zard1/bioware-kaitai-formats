-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- TLK (Talk Table) files contain all text strings used in the game, both written and spoken.
-- They enable easy localization by providing a lookup table from string reference numbers (StrRef)
-- to localized text and associated voice-over audio files.
-- 
-- Binary Format Structure:
-- - File Header (20 bytes): File type signature, version, language ID, string count, entries offset
-- - String Data Table (40 bytes per entry): Metadata for each string entry (flags, sound ResRef, offsets, lengths)
-- - String Entries (variable size): Sequential null-terminated text strings starting at entries_offset
-- 
-- The format uses a two-level structure:
-- 1. String Data Table: Contains metadata (flags, sound filename, text offset/length) for each entry
-- 2. String Entries: Actual text data stored sequentially, referenced by offsets in the data table
-- 
-- String references (StrRef) are 0-based indices into the string_data_table array. StrRef 0 refers to
-- the first entry, StrRef 1 to the second, etc. StrRef -1 indicates no string reference.
-- 
-- Authoritative index: `meta.xref` and `doc-ref` (PyKotor, xoreos `talktable*` + `talktable_tlk`, xoreos-tools CLIs, reone, KotOR.js, NickHugi/Kotor.NET). Legacy Perl / archived community URLs are omitted when they no longer resolve on GitHub.
-- See also: PyKotor wiki — TLK (https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk)
-- See also: PyKotor — `io_tlk` (sizes, Kaitai + legacy + write) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk.py#L23-L196)
-- See also: xoreos — `TalkTable::load` (factory dispatch) (https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp#L35-L69)
-- See also: xoreos — TLK id/version + `TalkTable_TLK::load` + V3/V4 entry tables (https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L40-L114)
-- See also: xoreos — `kFileTypeTLK` (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L87)
-- See also: xoreos — `Language` / `LanguageGender` (TLK `language_id` / substring packing) (https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73)
-- See also: xoreos-tools — `tlk2xml` CLI (`main`) (https://github.com/xoreos/xoreos-tools/blob/master/src/tlk2xml.cpp#L56-L80)
-- See also: xoreos-tools — `xml2tlk` CLI (`main`) (https://github.com/xoreos/xoreos-tools/blob/master/src/xml2tlk.cpp#L58-L85)
-- See also: reone — `TlkReader` (https://github.com/modawan/reone/blob/master/src/libs/resource/format/tlkreader.cpp#L27-L67)
-- See also: KotOR.js — `TLKObject` (https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TLKObject.ts#L16-L77)
-- See also: NickHugi/Kotor.NET — `TLKBinaryReader` (https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorTLK/TLKBinaryReader.cs)
-- See also: xoreos-docs — TalkTable_Format.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/TalkTable_Format.pdf)
Tlk = class.class(KaitaiStruct)

function Tlk:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Tlk:_read()
  self.header = Tlk.TlkHeader(self._io, self, self._root)
  self.string_data_table = Tlk.StringDataTable(self._io, self, self._root)
end

-- 
-- TLK file header (20 bytes) - contains file signature, version, language, and counts.
-- 
-- Array of string data entries (metadata for each string) - 40 bytes per entry.

Tlk.StringDataEntry = class.class(KaitaiStruct)

function Tlk.StringDataEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Tlk.StringDataEntry:_read()
  self.flags = self._io:read_u4le()
  self.sound_resref = str_decode.decode(self._io:read_bytes(16), "ASCII")
  self.volume_variance = self._io:read_u4le()
  self.pitch_variance = self._io:read_u4le()
  self.text_offset = self._io:read_u4le()
  self.text_length = self._io:read_u4le()
  self.sound_length = self._io:read_f4le()
end

-- 
-- Size of each string_data_entry in bytes.
-- Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
-- text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.
Tlk.StringDataEntry.property.entry_size = {}
function Tlk.StringDataEntry.property.entry_size:get()
  if self._m_entry_size ~= nil then
    return self._m_entry_size
  end

  self._m_entry_size = 40
  return self._m_entry_size
end

-- 
-- Whether sound length is valid (bit 2 of flags).
Tlk.StringDataEntry.property.sound_length_present = {}
function Tlk.StringDataEntry.property.sound_length_present:get()
  if self._m_sound_length_present ~= nil then
    return self._m_sound_length_present
  end

  self._m_sound_length_present = self.flags & 4 ~= 0
  return self._m_sound_length_present
end

-- 
-- Whether voice-over audio exists (bit 1 of flags).
Tlk.StringDataEntry.property.sound_present = {}
function Tlk.StringDataEntry.property.sound_present:get()
  if self._m_sound_present ~= nil then
    return self._m_sound_present
  end

  self._m_sound_present = self.flags & 2 ~= 0
  return self._m_sound_present
end

-- 
-- Text string data as raw bytes (read as ASCII for byte-level access).
-- The actual encoding depends on the language_id in the header.
-- Common encodings:
-- - English/French/German/Italian/Spanish: Windows-1252 (cp1252)
-- - Polish: Windows-1250 (cp1250)
-- - Korean: EUC-KR (cp949)
-- - Chinese Traditional: Big5 (cp950)
-- - Chinese Simplified: GB2312 (cp936)
-- - Japanese: Shift-JIS (cp932)
-- 
-- Note: This field reads the raw bytes as ASCII string for byte-level access.
-- The application layer should decode based on the language_id field in the header.
-- To get raw bytes, access the underlying byte representation of this string.
-- 
-- In practice, strings are stored sequentially starting at entries_offset,
-- so text_offset values are relative to entries_offset (0, len1, len1+len2, etc.).
-- 
-- Strings may be null-terminated, but text_length includes the null terminator.
-- Application code should trim null bytes when decoding.
-- 
-- If text_present flag (bit 0) is not set, this field may contain garbage data
-- or be empty. Always check text_present before using this data.
Tlk.StringDataEntry.property.text_data = {}
function Tlk.StringDataEntry.property.text_data:get()
  if self._m_text_data ~= nil then
    return self._m_text_data
  end

  local _pos = self._io:pos()
  self._io:seek(self.text_file_offset)
  self._m_text_data = str_decode.decode(self._io:read_bytes(self.text_length), "ASCII")
  self._io:seek(_pos)
  return self._m_text_data
end

-- 
-- Absolute file offset to the text string.
-- Calculated as entries_offset (from header) + text_offset (from entry).
Tlk.StringDataEntry.property.text_file_offset = {}
function Tlk.StringDataEntry.property.text_file_offset:get()
  if self._m_text_file_offset ~= nil then
    return self._m_text_file_offset
  end

  self._m_text_file_offset = self._root.header.entries_offset + self.text_offset
  return self._m_text_file_offset
end

-- 
-- Whether text content exists (bit 0 of flags).
Tlk.StringDataEntry.property.text_present = {}
function Tlk.StringDataEntry.property.text_present:get()
  if self._m_text_present ~= nil then
    return self._m_text_present
  end

  self._m_text_present = self.flags & 1 ~= 0
  return self._m_text_present
end

-- 
-- Bit flags indicating what data is present:
-- - bit 0 (0x0001): Text present - string has text content
-- - bit 1 (0x0002): Sound present - string has associated voice-over audio
-- - bit 2 (0x0004): Sound length present - sound length field is valid
-- 
-- Common flag combinations:
-- - 0x0001: Text only (menu options, item descriptions)
-- - 0x0003: Text + Sound (voiced dialog lines)
-- - 0x0007: Text + Sound + Length (fully voiced with duration)
-- - 0x0000: Empty entry (unused StrRef slots)
-- 
-- Voice-over audio filename (ResRef), null-terminated ASCII, max 16 chars.
-- If the string is shorter than 16 bytes, it is null-padded.
-- Empty string (all nulls) indicates no voice-over audio.
-- 
-- Volume variance (unused in KotOR, always 0).
-- Legacy field from Neverwinter Nights, not used by KotOR engine.
-- 
-- Pitch variance (unused in KotOR, always 0).
-- Legacy field from Neverwinter Nights, not used by KotOR engine.
-- 
-- Offset to string text relative to entries_offset.
-- The actual file offset is: header.entries_offset + text_offset.
-- First string starts at offset 0, subsequent strings follow sequentially.
-- 
-- Length of string text in bytes (not characters).
-- For single-byte encodings (Windows-1252, etc.), byte length equals character count.
-- For multi-byte encodings (UTF-8, etc.), byte length may be greater than character count.
-- 
-- Duration of voice-over audio in seconds (float).
-- Only valid if sound_length_present flag (bit 2) is set.
-- Used by the engine to determine how long to wait before auto-advancing dialog.

Tlk.StringDataTable = class.class(KaitaiStruct)

function Tlk.StringDataTable:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Tlk.StringDataTable:_read()
  self.entries = {}
  for i = 0, self._root.header.string_count - 1 do
    self.entries[i + 1] = Tlk.StringDataEntry(self._io, self, self._root)
  end
end

-- 
-- Array of string data entries, one per string in the file.

Tlk.TlkHeader = class.class(KaitaiStruct)

function Tlk.TlkHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Tlk.TlkHeader:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.file_version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.language_id = self._io:read_u4le()
  self.string_count = self._io:read_u4le()
  self.entries_offset = self._io:read_u4le()
end

-- 
-- Expected offset to string entries (header + string data table).
-- Used for validation.
Tlk.TlkHeader.property.expected_entries_offset = {}
function Tlk.TlkHeader.property.expected_entries_offset:get()
  if self._m_expected_entries_offset ~= nil then
    return self._m_expected_entries_offset
  end

  self._m_expected_entries_offset = 20 + self.string_count * 40
  return self._m_expected_entries_offset
end

-- 
-- Size of the TLK header in bytes.
Tlk.TlkHeader.property.header_size = {}
function Tlk.TlkHeader.property.header_size:get()
  if self._m_header_size ~= nil then
    return self._m_header_size
  end

  self._m_header_size = 20
  return self._m_header_size
end

-- 
-- File type signature. Must be "TLK " (space-padded).
-- Validates that this is a TLK file.
-- Note: Validation removed temporarily due to Kaitai Struct parser issues.
-- 
-- File format version. "V3.0" for KotOR, "V4.0" for Jade Empire.
-- KotOR games use V3.0. Jade Empire uses V4.0.
-- Note: Validation removed due to Kaitai Struct parser limitations with period in string.
-- 
-- Language identifier:
-- - 0 = English
-- - 1 = French
-- - 2 = German
-- - 3 = Italian
-- - 4 = Spanish
-- - 5 = Polish
-- - 128 = Korean
-- - 129 = Chinese Traditional
-- - 130 = Chinese Simplified
-- - 131 = Japanese
-- See Language enum for complete list.
-- 
-- Number of string entries in the file.
-- Determines the number of entries in string_data_table.
-- 
-- Byte offset to string entries array from the beginning of the file.
-- Typically 20 + (string_count * 40) = header size + string data table size.
-- Points to where the actual text strings begin.

