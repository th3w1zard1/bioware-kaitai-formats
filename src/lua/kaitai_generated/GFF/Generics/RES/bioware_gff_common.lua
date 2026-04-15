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
-- 
-- **GFF4** uses a different container/struct layout on disk (`GFF4File::Header::read` in `meta.xref.xoreos_gff4file_header_read`);
-- this enum remains the **GFF3** field-type table unless a future split spec proves wire-identical IDs across both.
-- See also: PyKotor wiki — GFF data types (https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types)
-- See also: PyKotor — `GFFFieldType` enum (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367)
-- See also: PyKotor — field read dispatch (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L197-L273)
-- See also: xoreos — `GFF3File::readHeader` (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63)
-- See also: xoreos — `GFF4File::Header::read` (GFF4 container; distinct from GFF3 field tags above) (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L59-L82)
-- See also: reone — `GffReader` (https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225)
-- See also: xoreos-tools — `gffdumper` (identify / dump) (https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176)
-- See also: xoreos-tools — `gffcreator` (create) (https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60)
-- See also: xoreos-docs — GFF_Format.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf)
-- See also: xoreos-docs — CommonGFFStructs.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf)
-- See also: xoreos-docs — BioWare specs PDF tree (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
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


