-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local enum = require("enum")
local str_decode = require("string_decode")

-- 
-- Shared enums and small helper types used by TSLPatcher-style tooling.
-- 
-- Notes:
-- - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
--   so string-valued enums are modeled here as small string wrapper types with `valid` constraints.
-- 
-- References:
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py
-- See also: xoreos — `FileType` enum start (engine archive IDs; TSLPatcher enums here are community patch metadata, not read from `swkotor.exe`) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60)
-- See also: PyKotor — `ModInstaller` (apply / backup entry band) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/patcher.py#L43-L120)
-- See also: PyKotor — `memory` (patch address space / token helpers) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/memory.py#L1-L80)
-- See also: PyKotor — `tslpatcher/` package (https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/tslpatcher/)
-- See also: PyKotor — TwoDA patch helpers (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py)
-- See also: PyKotor — NCS patch helpers (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py)
-- See also: PyKotor — TSLPatcher logging (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py)
-- See also: PyKotor — diff resource objects (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py)
-- See also: xoreos-docs — BioWare specs tree (TSLPatcher metadata; no dedicated PDF) (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
BiowareTslpatcherCommon = class.class(KaitaiStruct)

BiowareTslpatcherCommon.BiowareTslpatcherLogTypeId = enum.Enum {
  verbose = 0,
  note = 1,
  warning = 2,
  error = 3,
}

BiowareTslpatcherCommon.BiowareTslpatcherTargetTypeId = enum.Enum {
  row_index = 0,
  row_label = 1,
  label_column = 2,
}

function BiowareTslpatcherCommon:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function BiowareTslpatcherCommon:_read()
end


-- 
-- String-valued enum equivalent for DiffFormat (null-terminated ASCII).
BiowareTslpatcherCommon.BiowareDiffFormatStr = class.class(KaitaiStruct)

function BiowareTslpatcherCommon.BiowareDiffFormatStr:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareTslpatcherCommon.BiowareDiffFormatStr:_read()
  self.value = str_decode.decode(self._io:read_bytes_term(0, false, true, true), "ASCII")
  if not( ((self.value == "default") or (self.value == "unified") or (self.value == "context") or (self.value == "side_by_side")) ) then
    error("ValidationNotAnyOfError")
  end
end


-- 
-- String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
BiowareTslpatcherCommon.BiowareDiffResourceTypeStr = class.class(KaitaiStruct)

function BiowareTslpatcherCommon.BiowareDiffResourceTypeStr:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareTslpatcherCommon.BiowareDiffResourceTypeStr:_read()
  self.value = str_decode.decode(self._io:read_bytes_term(0, false, true, true), "ASCII")
  if not( ((self.value == "gff") or (self.value == "2da") or (self.value == "tlk") or (self.value == "lip") or (self.value == "bytes")) ) then
    error("ValidationNotAnyOfError")
  end
end


-- 
-- String-valued enum equivalent for DiffType (null-terminated ASCII).
BiowareTslpatcherCommon.BiowareDiffTypeStr = class.class(KaitaiStruct)

function BiowareTslpatcherCommon.BiowareDiffTypeStr:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareTslpatcherCommon.BiowareDiffTypeStr:_read()
  self.value = str_decode.decode(self._io:read_bytes_term(0, false, true, true), "ASCII")
  if not( ((self.value == "identical") or (self.value == "modified") or (self.value == "added") or (self.value == "removed") or (self.value == "error")) ) then
    error("ValidationNotAnyOfError")
  end
end


-- 
-- String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
BiowareTslpatcherCommon.BiowareNcsTokenTypeStr = class.class(KaitaiStruct)

function BiowareTslpatcherCommon.BiowareNcsTokenTypeStr:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareTslpatcherCommon.BiowareNcsTokenTypeStr:_read()
  self.value = str_decode.decode(self._io:read_bytes_term(0, false, true, true), "ASCII")
  if not( ((self.value == "strref") or (self.value == "strref32") or (self.value == "2damemory") or (self.value == "2damemory32") or (self.value == "uint32") or (self.value == "uint16") or (self.value == "uint8")) ) then
    error("ValidationNotAnyOfError")
  end
end


