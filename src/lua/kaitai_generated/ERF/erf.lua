-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_type_ids")
local str_decode = require("string_decode")

-- 
-- ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
-- texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
-- ERF files store both resource names (ResRefs) and data in the same file. They also support
-- localized strings for descriptions in multiple languages.
-- 
-- Format Variants:
-- - ERF: Generic encapsulated resource file (texture packs, etc.)
-- - HAK: Hak pak file (contains override resources). Used for mod content distribution
-- - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
-- - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`
-- 
-- All variants use the same binary format structure, differing only in the file type signature.
-- 
-- Archive `resource_type` values use the shared **`bioware_type_ids::xoreos_file_type_id`** enum (xoreos `FileType`); see `formats/Common/bioware_type_ids.ksy`.
-- 
-- Binary Format Structure:
-- - Header (160 bytes): File type, version, entry counts, offsets, build date, description
-- - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
--   include localized module names for the load screen. Each entry contains language_id (u4),
--   string_size (u4), and string_data (UTF-8 encoded text)
-- - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
--   - resref (16 bytes, ASCII, null-padded): Resource filename
--   - resource_id (u4): Index into resource_list
--   - resource_type (u2): Resource type identifier (`bioware_type_ids::xoreos_file_type_id`, xoreos `FileType`)
--   - unused (u2): Padding/unused field (typically 0)
-- - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
--   - offset_to_data (u4): Byte offset to resource data from beginning of file
--   - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
-- - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
--   in resource_list
-- 
-- File Access Pattern:
-- 1. Read header to get entry_count and offsets
-- 2. Read key_list to map ResRefs to resource_ids
-- 3. Use resource_id to index into resource_list
-- 4. Read resource data from offset_to_data with byte length len_data
-- 
-- Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_erf` / `erf_data`, xoreos `ERFFile`, xoreos-tools `unerf` / `erf`, reone `ErfReader`, KotOR.js `ERFObject`, NickHugi `Kotor.NET/Formats/KotorERF`).
-- See also: PyKotor wiki — ERF (https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf)
-- See also: PyKotor wiki — Aurora ERF notes (https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf)
-- See also: PyKotor — `io_erf` (Kaitai + legacy + `ERFBinaryWriter.write`) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py#L22-L316)
-- See also: PyKotor — `ERFType` + `ERF` model (opening) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L130)
-- See also: xoreos — ERF type tags + `ERFFile::load` + `readV10Header` start (https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L50-L335)
-- See also: xoreos-tools — `unerf` CLI (`main`) (https://github.com/xoreos/xoreos-tools/blob/master/src/unerf.cpp#L69-L106)
-- See also: xoreos-tools — `erf` packer CLI (`main`) (https://github.com/xoreos/xoreos-tools/blob/master/src/erf.cpp#L49-L96)
-- See also: xoreos-docs — Torlack mod.html (https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html)
-- See also: reone — `ErfReader` (https://github.com/modawan/reone/blob/master/src/libs/resource/format/erfreader.cpp#L26-L92)
-- See also: KotOR.js — `ERFObject` (https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/ERFObject.ts#L70-L115)
-- See also: NickHugi/Kotor.NET — `ERFBinaryStructure` (https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorERF/ERFBinaryStructure.cs)
-- See also: xoreos-docs — ERF_Format.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/ERF_Format.pdf)
-- See also: xoreos — `enum FileType` (numeric IDs in KEY/ERF/RIM tables) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394)
-- See also: PyKotor — `ResourceType` (tooling superset; overlaps FileType for KotOR rows) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py)
Erf = class.class(KaitaiStruct)

function Erf:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Erf:_read()
  self.header = Erf.ErfHeader(self._io, self, self._root)
end

-- 
-- Array of key entries mapping ResRefs to resource indices.
Erf.property.key_list = {}
function Erf.property.key_list:get()
  if self._m_key_list ~= nil then
    return self._m_key_list
  end

  local _pos = self._io:pos()
  self._io:seek(self.header.offset_to_key_list)
  self._m_key_list = Erf.KeyList(self._io, self, self._root)
  self._io:seek(_pos)
  return self._m_key_list
end

-- 
-- Optional localized string entries for multi-language descriptions.
Erf.property.localized_string_list = {}
function Erf.property.localized_string_list:get()
  if self._m_localized_string_list ~= nil then
    return self._m_localized_string_list
  end

  if self.header.language_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.offset_to_localized_string_list)
    self._m_localized_string_list = Erf.LocalizedStringList(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_localized_string_list
end

-- 
-- Array of resource entries containing offset and size information.
Erf.property.resource_list = {}
function Erf.property.resource_list:get()
  if self._m_resource_list ~= nil then
    return self._m_resource_list
  end

  local _pos = self._io:pos()
  self._io:seek(self.header.offset_to_resource_list)
  self._m_resource_list = Erf.ResourceList(self._io, self, self._root)
  self._io:seek(_pos)
  return self._m_resource_list
end

-- 
-- ERF file header (160 bytes).

Erf.ErfHeader = class.class(KaitaiStruct)

function Erf.ErfHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Erf.ErfHeader:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not( ((self.file_type == "ERF ") or (self.file_type == "MOD ") or (self.file_type == "SAV ") or (self.file_type == "HAK ")) ) then
    error("ValidationNotAnyOfError")
  end
  self.file_version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_version == "V1.0") then
    error("not equal, expected " .. "V1.0" .. ", but got " .. self.file_version)
  end
  self.language_count = self._io:read_u4le()
  self.localized_string_size = self._io:read_u4le()
  self.entry_count = self._io:read_u4le()
  self.offset_to_localized_string_list = self._io:read_u4le()
  self.offset_to_key_list = self._io:read_u4le()
  self.offset_to_resource_list = self._io:read_u4le()
  self.build_year = self._io:read_u4le()
  self.build_day = self._io:read_u4le()
  self.description_strref = self._io:read_s4le()
  self.reserved = self._io:read_bytes(116)
end

-- 
-- Heuristic to detect save game files.
-- Save games use MOD signature but typically have description_strref = 0.
Erf.ErfHeader.property.is_save_file = {}
function Erf.ErfHeader.property.is_save_file:get()
  if self._m_is_save_file ~= nil then
    return self._m_is_save_file
  end

  self._m_is_save_file =  ((self.file_type == "MOD ") and (self.description_strref == 0)) 
  return self._m_is_save_file
end

-- 
-- File type signature. Must be one of:
-- - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
-- - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
-- - "SAV " (0x53 0x41 0x56 0x20) - Save game file
-- - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
-- 
-- File format version. Always "V1.0" for KotOR ERF files.
-- Other versions may exist in Neverwinter Nights but are not supported in KotOR.
-- 
-- Number of localized string entries. Typically 0 for most ERF files.
-- MOD files may include localized module names for the load screen.
-- 
-- Total size of localized string data in bytes.
-- Includes all language entries (language_id + string_size + string_data for each).
-- 
-- Number of resources in the archive. This determines:
-- - Number of entries in key_list
-- - Number of entries in resource_list
-- - Number of resource data blocks stored at various offsets
-- 
-- Byte offset to the localized string list from the beginning of the file.
-- Typically 160 (right after header) if present, or 0 if not present.
-- 
-- Byte offset to the key list from the beginning of the file.
-- Typically 160 (right after header) if no localized strings, or after localized strings.
-- 
-- Byte offset to the resource list from the beginning of the file.
-- Located after the key list.
-- 
-- Build year (years since 1900).
-- Example: 103 = year 2003
-- Primarily informational, used by development tools to track module versions.
-- 
-- Build day (days since January 1, with January 1 = day 1).
-- Example: 247 = September 4th (the 247th day of the year)
-- Primarily informational, used by development tools to track module versions.
-- 
-- Description StrRef (TLK string reference) for the archive description.
-- Values vary by file type:
-- - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
-- - SAV files: 0 (typically no description)
-- - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
-- 
-- Reserved padding (usually zeros).
-- Total header size is 160 bytes:
-- file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
-- entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
-- offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
-- reserved (116) = 160 bytes

Erf.KeyEntry = class.class(KaitaiStruct)

function Erf.KeyEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Erf.KeyEntry:_read()
  self.resref = str_decode.decode(self._io:read_bytes(16), "ASCII")
  self.resource_id = self._io:read_u4le()
  self.resource_type = BiowareTypeIds.XoreosFileTypeId(self._io:read_u2le())
  self.unused = self._io:read_u2le()
end

-- 
-- Resource filename (ResRef), null-padded to 16 bytes.
-- Maximum 16 characters. If exactly 16 characters, no null terminator exists.
-- Resource names can be mixed case, though most are lowercase in practice.
-- 
-- Resource ID (index into resource_list).
-- Maps this key entry to the corresponding resource entry.
-- 
-- Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
-- Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
-- 
-- Padding/unused field (typically 0).

Erf.KeyList = class.class(KaitaiStruct)

function Erf.KeyList:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Erf.KeyList:_read()
  self.entries = {}
  for i = 0, self._root.header.entry_count - 1 do
    self.entries[i + 1] = Erf.KeyEntry(self._io, self, self._root)
  end
end

-- 
-- Array of key entries mapping ResRefs to resource indices.

Erf.LocalizedStringEntry = class.class(KaitaiStruct)

function Erf.LocalizedStringEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Erf.LocalizedStringEntry:_read()
  self.language_id = self._io:read_u4le()
  self.string_size = self._io:read_u4le()
  self.string_data = str_decode.decode(self._io:read_bytes(self.string_size), "UTF-8")
end

-- 
-- Language identifier:
-- - 0 = English
-- - 1 = French
-- - 2 = German
-- - 3 = Italian
-- - 4 = Spanish
-- - 5 = Polish
-- - Additional languages for Asian releases
-- 
-- Length of string data in bytes.
-- 
-- UTF-8 encoded text string.

Erf.LocalizedStringList = class.class(KaitaiStruct)

function Erf.LocalizedStringList:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Erf.LocalizedStringList:_read()
  self.entries = {}
  for i = 0, self._root.header.language_count - 1 do
    self.entries[i + 1] = Erf.LocalizedStringEntry(self._io, self, self._root)
  end
end

-- 
-- Array of localized string entries, one per language.

Erf.ResourceEntry = class.class(KaitaiStruct)

function Erf.ResourceEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Erf.ResourceEntry:_read()
  self.offset_to_data = self._io:read_u4le()
  self.len_data = self._io:read_u4le()
end

-- 
-- Raw binary data for this resource.
Erf.ResourceEntry.property.data = {}
function Erf.ResourceEntry.property.data:get()
  if self._m_data ~= nil then
    return self._m_data
  end

  local _pos = self._io:pos()
  self._io:seek(self.offset_to_data)
  self._m_data = self._io:read_bytes(self.len_data)
  self._io:seek(_pos)
  return self._m_data
end

-- 
-- Byte offset to resource data from the beginning of the file.
-- Points to the actual binary data for this resource.
-- 
-- Size of resource data in bytes.
-- Uncompressed size of the resource.

Erf.ResourceList = class.class(KaitaiStruct)

function Erf.ResourceList:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Erf.ResourceList:_read()
  self.entries = {}
  for i = 0, self._root.header.entry_count - 1 do
    self.entries[i + 1] = Erf.ResourceEntry(self._io, self, self._root)
  end
end

-- 
-- Array of resource entries containing offset and size information.

