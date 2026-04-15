-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_type_ids")
local str_decode = require("string_decode")

-- 
-- **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
-- the paired **KEY** (`KEY.ksy`), not in the BIF.
-- See also: PyKotor wiki — BIF (https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif)
-- See also: xoreos — BIFF::load (https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L82)
Bif = class.class(KaitaiStruct)

function Bif:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Bif:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_type == "BIFF") then
    error("not equal, expected " .. "BIFF" .. ", but got " .. self.file_type)
  end
  self.version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not( ((self.version == "V1  ") or (self.version == "V1.1")) ) then
    error("ValidationNotAnyOfError")
  end
  self.var_res_count = self._io:read_u4le()
  self.fixed_res_count = self._io:read_u4le()
  if not(self.fixed_res_count == 0) then
    error("not equal, expected " .. 0 .. ", but got " .. self.fixed_res_count)
  end
  self.var_table_offset = self._io:read_u4le()
end

-- 
-- Variable resource table containing entries for each resource.
Bif.property.var_resource_table = {}
function Bif.property.var_resource_table:get()
  if self._m_var_resource_table ~= nil then
    return self._m_var_resource_table
  end

  if self.var_res_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.var_table_offset)
    self._m_var_resource_table = Bif.VarResourceTable(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_var_resource_table
end

-- 
-- File type signature. Must be "BIFF" for BIF files.
-- 
-- File format version. Typically "V1  " or "V1.1".
-- 
-- Number of variable-size resources in this file.
-- 
-- Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
-- 
-- Byte offset to the variable resource table from the beginning of the file.

Bif.VarResourceEntry = class.class(KaitaiStruct)

function Bif.VarResourceEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bif.VarResourceEntry:_read()
  self.resource_id = self._io:read_u4le()
  self.offset = self._io:read_u4le()
  self.file_size = self._io:read_u4le()
  self.resource_type = BiowareTypeIds.XoreosFileTypeId(self._io:read_u4le())
end

-- 
-- Resource ID (matches KEY file entry).
-- Encodes BIF index (bits 31-20) and resource index (bits 19-0).
-- Formula: resource_id = (bif_index << 20) | resource_index
-- 
-- Byte offset to resource data in file (absolute file offset).
-- 
-- Uncompressed size of resource data in bytes.
-- 
-- Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
-- read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
-- `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.

Bif.VarResourceTable = class.class(KaitaiStruct)

function Bif.VarResourceTable:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bif.VarResourceTable:_read()
  self.entries = {}
  for i = 0, self._root.var_res_count - 1 do
    self.entries[i + 1] = Bif.VarResourceEntry(self._io, self, self._root)
  end
end

-- 
-- Array of variable resource entries.

