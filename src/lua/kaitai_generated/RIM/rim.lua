-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_type_ids")
local str_decode = require("string_decode")

-- 
-- RIM (Resource Information Manager) files are self-contained archives used for module templates.
-- RIM files are similar to ERF files but are read-only from the game's perspective. The game
-- loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
-- RIM files store all resources inline with metadata, making them self-contained archives.
-- 
-- Format Variants:
-- - Standard RIM: Basic module template files
-- - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
-- 
-- Binary Format (KotOR / PyKotor):
-- - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
-- - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
-- - Key / resource entry table (32 bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
-- - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
-- 
-- Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.
-- See also: PyKotor wiki — RIM (https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim)
-- See also: PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128)
-- See also: xoreos — `RIMFile::load` + `readResList` (https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L35-L91)
-- See also: xoreos-tools — `unrim` CLI (`main`) (https://github.com/xoreos/xoreos-tools/blob/master/src/unrim.cpp#L55-L85)
-- See also: xoreos-tools — `rim` packer CLI (`main`) (https://github.com/xoreos/xoreos-tools/blob/master/src/rim.cpp#L43-L84)
-- See also: xoreos-docs — Torlack mod.html (MOD/RIM family) (https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html)
-- See also: KotOR.js — `RIMObject` (https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/RIMObject.ts#L69-L93)
-- See also: NickHugi/Kotor.NET — `RIMBinaryStructure` (https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs)
-- See also: reone — `RimReader` (https://github.com/modawan/reone/blob/master/src/libs/resource/format/rimreader.cpp#L26-L58)
-- See also: xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394)
-- See also: PyKotor — `ResourceType` (tooling superset) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py)
Rim = class.class(KaitaiStruct)

function Rim:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Rim:_read()
  self.header = Rim.RimHeader(self._io, self, self._root)
  if self.header.offset_to_resource_table == 0 then
    self.gap_before_key_table_implicit = self._io:read_bytes(96)
  end
  if self.header.offset_to_resource_table ~= 0 then
    self.gap_before_key_table_explicit = self._io:read_bytes(self.header.offset_to_resource_table - 24)
  end
  if self.header.resource_count > 0 then
    self.resource_entry_table = Rim.ResourceEntryTable(self._io, self, self._root)
  end
end

-- 
-- RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit).
-- 
-- When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
-- After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
-- 
-- When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
-- Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
-- 
-- Array of resource entries mapping ResRefs to resource data.

Rim.ResourceEntry = class.class(KaitaiStruct)

function Rim.ResourceEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Rim.ResourceEntry:_read()
  self.resref = str_decode.decode(self._io:read_bytes(16), "ASCII")
  self.resource_type = BiowareTypeIds.XoreosFileTypeId(self._io:read_u4le())
  self.resource_id = self._io:read_u4le()
  self.offset_to_data = self._io:read_u4le()
  self.num_data = self._io:read_u4le()
end

-- 
-- Raw binary data for this resource (read at specified offset).
Rim.ResourceEntry.property.data = {}
function Rim.ResourceEntry.property.data:get()
  if self._m_data ~= nil then
    return self._m_data
  end

  local _pos = self._io:pos()
  self._io:seek(self.offset_to_data)
  self._m_data = {}
  for i = 0, self.num_data - 1 do
    self._m_data[i + 1] = self._io:read_u1()
  end
  self._io:seek(_pos)
  return self._m_data
end

-- 
-- Resource filename (ResRef), null-padded to 16 bytes.
-- Maximum 16 characters. If exactly 16 characters, no null terminator exists.
-- Resource names can be mixed case, though most are lowercase in practice.
-- The game engine typically lowercases ResRefs when loading.
-- 
-- Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
-- Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
-- 
-- Resource ID (index, usually sequential).
-- Typically matches the index of this entry in the resource_entry_table.
-- Used for internal reference, but not critical for parsing.
-- 
-- Byte offset to resource data from the beginning of the file.
-- Points to the actual binary data for this resource in resource_data_section.
-- 
-- Size of resource data in bytes (repeat count for raw `data` bytes).
-- Uncompressed size of the resource.

Rim.ResourceEntryTable = class.class(KaitaiStruct)

function Rim.ResourceEntryTable:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Rim.ResourceEntryTable:_read()
  self.entries = {}
  for i = 0, self._root.header.resource_count - 1 do
    self.entries[i + 1] = Rim.ResourceEntry(self._io, self, self._root)
  end
end

-- 
-- Array of resource entries, one per resource in the archive.

Rim.RimHeader = class.class(KaitaiStruct)

function Rim.RimHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Rim.RimHeader:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_type == "RIM ") then
    error("not equal, expected " .. "RIM " .. ", but got " .. self.file_type)
  end
  self.file_version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_version == "V1.0") then
    error("not equal, expected " .. "V1.0" .. ", but got " .. self.file_version)
  end
  self.reserved = self._io:read_u4le()
  self.resource_count = self._io:read_u4le()
  self.offset_to_resource_table = self._io:read_u4le()
  self.offset_to_resources = self._io:read_u4le()
end

-- 
-- Whether the RIM file contains any resources.
Rim.RimHeader.property.has_resources = {}
function Rim.RimHeader.property.has_resources:get()
  if self._m_has_resources ~= nil then
    return self._m_has_resources
  end

  self._m_has_resources = self.resource_count > 0
  return self._m_has_resources
end

-- 
-- File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
-- This identifies the file as a RIM archive.
-- 
-- File format version. Always "V1.0" for KotOR RIM files.
-- Other versions may exist in Neverwinter Nights but are not supported in KotOR.
-- 
-- Reserved field (typically 0x00000000).
-- Unknown purpose, but always set to 0 in practice.
-- 
-- Number of resources in the archive. This determines:
-- - Number of entries in resource_entry_table
-- - Number of resources in resource_data_section
-- 
-- Byte offset to the key / resource entry table from the beginning of the file.
-- 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
-- When non-zero, this offset is used directly (commonly 120).
-- 
-- Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
-- taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.

