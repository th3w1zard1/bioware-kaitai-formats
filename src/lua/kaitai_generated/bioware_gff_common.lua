-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local enum = require("enum")

-- 
-- Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).
-- 
-- Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
-- (Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).
BiowareGffCommon = class.class(KaitaiStruct)

BiowareGffCommon.GffFieldType = enum.Enum {
  uint8 = 0,
  int8 = 1,
  uint16 = 2,
  int16 = 3,
  uint32 = 4,
  int32 = 5,
  uint64 = 6,
  int64 = 7,
  single = 8,
  double = 9,
  string = 10,
  resref = 11,
  localized_string = 12,
  binary = 13,
  struct = 14,
  list = 15,
  vector4 = 16,
  vector3 = 17,
  str_ref = 18,
}

function BiowareGffCommon:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function BiowareGffCommon:_read()
end


