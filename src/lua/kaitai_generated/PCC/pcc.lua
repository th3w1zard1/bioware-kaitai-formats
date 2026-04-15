-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_common")
local str_decode = require("string_decode")
local utils = require("utils")

-- 
-- **PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
-- tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).
-- 
-- **Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.
-- See also: xoreos — `FileType` enum start (Aurora/BioWare family IDs; **PCC/Unreal packages are not in this table** — included only as canonical upstream anchor for “what this repo’s xoreos stack is”) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60)
-- See also: ME3Tweaks — PCC file format (https://github.com/ME3Tweaks/LegendaryExplorer/wiki/PCC-File-Format)
-- See also: ME3Tweaks — Package handling (export/import tables, UE3-era BioWare packages) (https://github.com/ME3Tweaks/LegendaryExplorer/wiki/Package-Handling)
-- See also: In-tree — coverage matrix (PCC is out-of-xoreos Aurora scope; see table) (https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/docs/XOREOS_FORMAT_COVERAGE.md)
-- See also: xoreos-docs — BioWare specs tree (KotOR-era PDFs; PCC is Mass Effect / UE3 — use LegendaryExplorer wiki as wire authority) (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
Pcc = class.class(KaitaiStruct)

function Pcc:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Pcc:_read()
  self.header = Pcc.FileHeader(self._io, self, self._root)
end

-- 
-- Compression algorithm used (0=None, 1=Zlib, 2=LZO).
Pcc.property.compression_type = {}
function Pcc.property.compression_type:get()
  if self._m_compression_type ~= nil then
    return self._m_compression_type
  end

  self._m_compression_type = self.header.compression_type
  return self._m_compression_type
end

-- 
-- Table containing all objects exported from this package.
Pcc.property.export_table = {}
function Pcc.property.export_table:get()
  if self._m_export_table ~= nil then
    return self._m_export_table
  end

  if self.header.export_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.export_table_offset)
    self._m_export_table = Pcc.ExportTable(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_export_table
end

-- 
-- Table containing references to external packages and classes.
Pcc.property.import_table = {}
function Pcc.property.import_table:get()
  if self._m_import_table ~= nil then
    return self._m_import_table
  end

  if self.header.import_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.import_table_offset)
    self._m_import_table = Pcc.ImportTable(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_import_table
end

-- 
-- True if package uses compressed chunks (bit 25 of package_flags).
Pcc.property.is_compressed = {}
function Pcc.property.is_compressed:get()
  if self._m_is_compressed ~= nil then
    return self._m_is_compressed
  end

  self._m_is_compressed = self.header.package_flags & 33554432 ~= 0
  return self._m_is_compressed
end

-- 
-- Table containing all string names used in the package.
Pcc.property.name_table = {}
function Pcc.property.name_table:get()
  if self._m_name_table ~= nil then
    return self._m_name_table
  end

  if self.header.name_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.name_table_offset)
    self._m_name_table = Pcc.NameTable(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_name_table
end

-- 
-- File header containing format metadata and table offsets.

Pcc.ExportEntry = class.class(KaitaiStruct)

function Pcc.ExportEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Pcc.ExportEntry:_read()
  self.class_index = self._io:read_s4le()
  self.super_class_index = self._io:read_s4le()
  self.link = self._io:read_s4le()
  self.object_name_index = self._io:read_s4le()
  self.object_name_number = self._io:read_s4le()
  self.archetype_index = self._io:read_s4le()
  self.object_flags = self._io:read_u8le()
  self.data_size = self._io:read_u4le()
  self.data_offset = self._io:read_u4le()
  self.unknown1 = self._io:read_u4le()
  self.num_components = self._io:read_s4le()
  self.unknown2 = self._io:read_u4le()
  self.guid = Pcc.Guid(self._io, self, self._root)
  if self.num_components > 0 then
    self.components = {}
    for i = 0, self.num_components - 1 do
      self.components[i + 1] = self._io:read_s4le()
    end
  end
end

-- 
-- Object index for the class.
-- Negative = import table index
-- Positive = export table index
-- Zero = no class
-- 
-- Object index for the super class.
-- Negative = import table index
-- Positive = export table index
-- Zero = no super class
-- 
-- Link to other objects (internal reference).
-- 
-- Index into name table for the object name.
-- 
-- Object name number (for duplicate names).
-- 
-- Object index for the archetype.
-- Negative = import table index
-- Positive = export table index
-- Zero = no archetype
-- 
-- Object flags bitfield (64-bit).
-- 
-- Size of the export data in bytes.
-- 
-- Byte offset to the export data from the beginning of the file.
-- 
-- Unknown field.
-- 
-- Number of component entries (can be negative).
-- 
-- Unknown field.
-- 
-- GUID for this export object.
-- 
-- Array of component indices.
-- Only present if num_components > 0.

Pcc.ExportTable = class.class(KaitaiStruct)

function Pcc.ExportTable:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Pcc.ExportTable:_read()
  self.entries = {}
  for i = 0, self._root.header.export_count - 1 do
    self.entries[i + 1] = Pcc.ExportEntry(self._io, self, self._root)
  end
end

-- 
-- Array of export entries.

Pcc.FileHeader = class.class(KaitaiStruct)

function Pcc.FileHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Pcc.FileHeader:_read()
  self.magic = self._io:read_u4le()
  if not(self.magic == 2653586369) then
    error("not equal, expected " .. 2653586369 .. ", but got " .. self.magic)
  end
  self.version = self._io:read_u4le()
  self.licensee_version = self._io:read_u4le()
  self.header_size = self._io:read_s4le()
  self.package_name = str_decode.decode(self._io:read_bytes(10), "UTF-16LE")
  self.package_flags = self._io:read_u4le()
  self.package_type = BiowareCommon.BiowarePccPackageKind(self._io:read_u4le())
  self.name_count = self._io:read_u4le()
  self.name_table_offset = self._io:read_u4le()
  self.export_count = self._io:read_u4le()
  self.export_table_offset = self._io:read_u4le()
  self.import_count = self._io:read_u4le()
  self.import_table_offset = self._io:read_u4le()
  self.depend_offset = self._io:read_u4le()
  self.depend_count = self._io:read_u4le()
  self.guid_part1 = self._io:read_u4le()
  self.guid_part2 = self._io:read_u4le()
  self.guid_part3 = self._io:read_u4le()
  self.guid_part4 = self._io:read_u4le()
  self.generations = self._io:read_u4le()
  self.export_count_dup = self._io:read_u4le()
  self.name_count_dup = self._io:read_u4le()
  self.unknown1 = self._io:read_u4le()
  self.engine_version = self._io:read_u4le()
  self.cooker_version = self._io:read_u4le()
  self.compression_flags = self._io:read_u4le()
  self.package_source = self._io:read_u4le()
  self.compression_type = BiowareCommon.BiowarePccCompressionCodec(self._io:read_u4le())
  self.chunk_count = self._io:read_u4le()
end

-- 
-- Magic number identifying PCC format. Must be 0x9E2A83C1.
-- 
-- File format version.
-- Encoded as: (major << 16) | (minor << 8) | patch
-- Example: 0xC202AC = 194/684 (major=194, minor=684)
-- 
-- Licensee-specific version field (typically 0x67C).
-- 
-- Header size field (typically -5 = 0xFFFFFFFB).
-- 
-- Package name (typically "None" = 0x4E006F006E006500).
-- 
-- Package flags bitfield.
-- Bit 25 (0x2000000): Compressed package
-- Bit 20 (0x100000): ME3Explorer edited format flag
-- Other bits: Various package attributes
-- 
-- Package type indicator (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_package_kind`
-- (LegendaryExplorer PCC wiki).
-- 
-- Number of entries in the name table.
-- 
-- Byte offset to the name table from the beginning of the file.
-- 
-- Number of entries in the export table.
-- 
-- Byte offset to the export table from the beginning of the file.
-- 
-- Number of entries in the import table.
-- 
-- Byte offset to the import table from the beginning of the file.
-- 
-- Offset to dependency table (typically 0x664).
-- 
-- Number of dependencies (typically 0x67C).
-- 
-- First 32 bits of package GUID.
-- 
-- Second 32 bits of package GUID.
-- 
-- Third 32 bits of package GUID.
-- 
-- Fourth 32 bits of package GUID.
-- 
-- Number of generation entries.
-- 
-- Duplicate export count (should match export_count).
-- 
-- Duplicate name count (should match name_count).
-- 
-- Unknown field (typically 0x0).
-- 
-- Engine version (typically 0x18EF = 6383).
-- 
-- Cooker version (typically 0x3006B = 196715).
-- 
-- Compression flags (typically 0x15330000).
-- 
-- Package source identifier (typically 0x8AA0000).
-- 
-- Compression codec when package is compressed (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_compression_codec`
-- (LegendaryExplorer PCC wiki). Unused / undefined when uncompressed.
-- 
-- Number of compressed chunks (0 for uncompressed, 1 for compressed).
-- If > 0, file uses compressed structure with chunks.

Pcc.Guid = class.class(KaitaiStruct)

function Pcc.Guid:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Pcc.Guid:_read()
  self.part1 = self._io:read_u4le()
  self.part2 = self._io:read_u4le()
  self.part3 = self._io:read_u4le()
  self.part4 = self._io:read_u4le()
end

-- 
-- First 32 bits of GUID.
-- 
-- Second 32 bits of GUID.
-- 
-- Third 32 bits of GUID.
-- 
-- Fourth 32 bits of GUID.

Pcc.ImportEntry = class.class(KaitaiStruct)

function Pcc.ImportEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Pcc.ImportEntry:_read()
  self.package_name_index = self._io:read_s8le()
  self.class_name_index = self._io:read_s4le()
  self.link = self._io:read_s8le()
  self.import_name_index = self._io:read_s8le()
end

-- 
-- Index into name table for package name.
-- Negative value indicates import from external package.
-- Positive value indicates import from this package.
-- 
-- Index into name table for class name.
-- 
-- Link to import/export table entry.
-- Used to resolve the actual object reference.
-- 
-- Index into name table for the imported object name.

Pcc.ImportTable = class.class(KaitaiStruct)

function Pcc.ImportTable:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Pcc.ImportTable:_read()
  self.entries = {}
  for i = 0, self._root.header.import_count - 1 do
    self.entries[i + 1] = Pcc.ImportEntry(self._io, self, self._root)
  end
end

-- 
-- Array of import entries.

Pcc.NameEntry = class.class(KaitaiStruct)

function Pcc.NameEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Pcc.NameEntry:_read()
  self.length = self._io:read_s4le()
  self.name = str_decode.decode(self._io:read_bytes(utils.box_unwrap((self.length < 0) and utils.box_wrap(-(self.length)) or (self.length)) * 2), "UTF-16LE")
end

-- 
-- Absolute value of length for size calculation.
Pcc.NameEntry.property.abs_length = {}
function Pcc.NameEntry.property.abs_length:get()
  if self._m_abs_length ~= nil then
    return self._m_abs_length
  end

  self._m_abs_length = utils.box_unwrap((self.length < 0) and utils.box_wrap(-(self.length)) or (self.length))
  return self._m_abs_length
end

-- 
-- Size of name string in bytes (absolute length * 2 bytes per WCHAR).
Pcc.NameEntry.property.name_size = {}
function Pcc.NameEntry.property.name_size:get()
  if self._m_name_size ~= nil then
    return self._m_name_size
  end

  self._m_name_size = self.abs_length * 2
  return self._m_name_size
end

-- 
-- Length of the name string in characters (signed).
-- Negative value indicates the number of WCHAR characters.
-- Positive value is also valid but less common.
-- 
-- Name string encoded as UTF-16LE (WCHAR).
-- Size is absolute value of length * 2 bytes per character.
-- Negative length indicates WCHAR count (use absolute value).

Pcc.NameTable = class.class(KaitaiStruct)

function Pcc.NameTable:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Pcc.NameTable:_read()
  self.entries = {}
  for i = 0, self._root.header.name_count - 1 do
    self.entries[i + 1] = Pcc.NameEntry(self._io, self, self._root)
  end
end

-- 
-- Array of name entries.

