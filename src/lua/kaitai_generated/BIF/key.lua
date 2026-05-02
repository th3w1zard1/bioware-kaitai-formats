-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_type_ids")
local str_decode = require("string_decode")

-- 
-- **KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
-- Resource types use `bioware_type_ids`.
-- See also: PyKotor wiki — KEY (https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key)
-- See also: PyKotor — `io_key` (Kaitai + legacy + header write) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/key/io_key.py#L26-L183)
-- See also: reone — `KeyReader` (https://github.com/modawan/reone/blob/master/src/libs/resource/format/keyreader.cpp#L26-L80)
-- See also: xoreos — `KEYFile::load` (https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp#L50-L88)
-- See also: xoreos-tools — `openKEYs` / `openKEYDataFiles` (https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L192-L210)
-- See also: xoreos-docs — KeyBIF_Format.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf)
-- See also: xoreos-docs — Torlack key.html (https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/key.html)
Key = class.class(KaitaiStruct)

function Key:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Key:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_type == "KEY ") then
    error("not equal, expected " .. "KEY " .. ", but got " .. self.file_type)
  end
  self.file_version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not( ((self.file_version == "V1  ") or (self.file_version == "V1.1")) ) then
    error("ValidationNotAnyOfError")
  end
  self.bif_count = self._io:read_u4le()
  self.key_count = self._io:read_u4le()
  self.file_table_offset = self._io:read_u4le()
  self.key_table_offset = self._io:read_u4le()
  self.build_year = self._io:read_u4le()
  self.build_day = self._io:read_u4le()
  self.reserved = self._io:read_bytes(32)
end

-- 
-- File table containing BIF file entries.
Key.property.file_table = {}
function Key.property.file_table:get()
  if self._m_file_table ~= nil then
    return self._m_file_table
  end

  if self.bif_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.file_table_offset)
    self._m_file_table = Key.FileTable(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_file_table
end

-- 
-- KEY table containing resource entries.
Key.property.key_table = {}
function Key.property.key_table:get()
  if self._m_key_table ~= nil then
    return self._m_key_table
  end

  if self.key_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.key_table_offset)
    self._m_key_table = Key.KeyTable(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_key_table
end

-- 
-- File type signature. Must be "KEY " (space-padded).
-- 
-- File format version. Typically "V1  " or "V1.1".
-- 
-- Number of BIF files referenced by this KEY file.
-- 
-- Number of resource entries in the KEY table.
-- 
-- Byte offset to the file table from the beginning of the file.
-- 
-- Byte offset to the KEY table from the beginning of the file.
-- 
-- Build year (years since 1900).
-- 
-- Build day (days since January 1).
-- 
-- Reserved padding (usually zeros).

Key.FileEntry = class.class(KaitaiStruct)

function Key.FileEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Key.FileEntry:_read()
  self.file_size = self._io:read_u4le()
  self.filename_offset = self._io:read_u4le()
  self.filename_size = self._io:read_u2le()
  self.drives = self._io:read_u2le()
end

-- 
-- BIF filename string at the absolute filename_offset in the KEY file.
Key.FileEntry.property.filename = {}
function Key.FileEntry.property.filename:get()
  if self._m_filename ~= nil then
    return self._m_filename
  end

  local _pos = self._io:pos()
  self._io:seek(self.filename_offset)
  self._m_filename = str_decode.decode(self._io:read_bytes(self.filename_size), "ASCII")
  self._io:seek(_pos)
  return self._m_filename
end

-- 
-- Size of the BIF file on disk in bytes.
-- 
-- Absolute byte offset from the start of the KEY file where this BIF's filename is stored
-- (seek(filename_offset), then read filename_size bytes).
-- This is not relative to the file table or to the end of the BIF entry array.
-- 
-- Length of the filename in bytes (including null terminator).
-- 
-- Drive flags indicating which media contains the BIF file.
-- Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
-- Modern distributions typically use 0x0001 (HD) for all files.

Key.FileTable = class.class(KaitaiStruct)

function Key.FileTable:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Key.FileTable:_read()
  self.entries = {}
  for i = 0, self._root.bif_count - 1 do
    self.entries[i + 1] = Key.FileEntry(self._io, self, self._root)
  end
end

-- 
-- Array of BIF file entries.

Key.FilenameTable = class.class(KaitaiStruct)

function Key.FilenameTable:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Key.FilenameTable:_read()
  self.filenames = str_decode.decode(self._io:read_bytes_full(), "ASCII")
end

-- 
-- Null-terminated BIF filenames concatenated together.
-- Each filename is read using the filename_offset and filename_size
-- from the corresponding file_entry.

Key.KeyEntry = class.class(KaitaiStruct)

function Key.KeyEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Key.KeyEntry:_read()
  self.resref = str_decode.decode(self._io:read_bytes(16), "ASCII")
  self.resource_type = BiowareTypeIds.XoreosFileTypeId(self._io:read_u2le())
  self.resource_id = self._io:read_u4le()
end

-- 
-- Resource filename (ResRef) without extension.
-- Null-padded, maximum 16 characters.
-- The game uses this name to access the resource.
-- 
-- Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
-- `formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).
-- 
-- Encoded resource location.
-- Bits 31-20: BIF index (top 12 bits) - index into file table
-- Bits 19-0: Resource index (bottom 20 bits) - index within the BIF file
-- 
-- Formula: resource_id = (bif_index << 20) | resource_index
-- 
-- Decoding:
-- - bif_index = (resource_id >> 20) & 0xFFF
-- - resource_index = resource_id & 0xFFFFF

Key.KeyTable = class.class(KaitaiStruct)

function Key.KeyTable:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Key.KeyTable:_read()
  self.entries = {}
  for i = 0, self._root.key_count - 1 do
    self.entries[i + 1] = Key.KeyEntry(self._io, self, self._root)
  end
end

-- 
-- Array of resource entries.

