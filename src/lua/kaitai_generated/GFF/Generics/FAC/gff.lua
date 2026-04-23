-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_common")
require("bioware_gff_common")
local str_decode = require("string_decode")

-- 
-- BioWare **GFF** (Generic File Format): hierarchical binary game data (KotOR/TSL and Aurora lineage; GFF4 for
-- DA / Eclipse-class payloads in this `.ksy`). Human-readable tables and tutorials: PyKotor wiki (**Further
-- reading**). Wire `gff_field_type` enum: `formats/Common/bioware_gff_common.ksy`.
-- 
-- **Aurora prefix (8 bytes):** `u4be` FourCC + `u4be` version (`AuroraFile::readHeader` — `meta.xref`
-- `xoreos_aurorafile_read_header`).
-- **GFF3:** Twelve LE `u32` counts/offsets as `gff_header_tail` under `gff3_after_aurora`, then lazy arena
-- `instances`.
-- **GFF4:** When version is `V4.0` / `V4.1`, the next field is `platform_id` (`u4be`), not GFF3 `struct_offset`
-- (`gff4_after_aurora`; partial GFF4 graph — `tail` blob still opaque).
-- 
-- **GFF3 wire summary:**
-- - Root `file` → `gff_union_file`; arenas addressed via `gff3.header` offsets.
-- - 12-byte struct rows (`struct_entry`), 12-byte field rows (`field_entry`); root struct index **0**; single-field
--   vs multi-field vs lists per wiki *Struct array* / *Field indices* / *List indices*.
-- 
-- **Observed behavior:** engine record names and addresses live on the `seq` / `types` nodes they justify, not in this blurb.
-- 
-- **Pinned URLs and tool history:** `meta.xref` (alphabetical keys). Coverage matrix: `docs/XOREOS_FORMAT_COVERAGE.md`.
-- See also: PyKotor wiki — GFF binary format (https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format)
-- See also: xoreos — GFF3File::Header::read (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63)
-- See also: xoreos — GFF3File load (post-header struct/field arena wiring) (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181)
-- See also: xoreos — GFF4File::Header::read (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72)
-- See also: xoreos — GFF4File::load entry (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L151-L164)
-- See also: PyKotor — GFFBinaryReader.load (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114)
-- See also: reone — GffReader (https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225)
-- See also: KotOR.js — GFFObject.parse (https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts#L152-L221)
-- See also: xoreos-tools — GFF3 load pipeline (shared with CLIs) (https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp#L86-L238)
-- See also: xoreos-tools — `gffdumper` (https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176)
-- See also: xoreos-tools — `gffcreator` (https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60)
-- See also: xoreos-docs — GFF_Format.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf)
Gff = class.class(KaitaiStruct)

function Gff:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Gff:_read()
  self.file = Gff.GffUnionFile(self._io, self, self._root)
end

-- 
-- Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
-- (`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
-- Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
-- mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
-- downstream `pos:` / `_root.file.gff3.header` paths.

-- 
-- Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
-- Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
Gff.FieldArray = class.class(KaitaiStruct)

function Gff.FieldArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.FieldArray:_read()
  self.entries = {}
  for i = 0, self._root.file.gff3.header.field_count - 1 do
    self.entries[i + 1] = Gff.FieldEntry(self._io, self, self._root)
  end
end

-- 
-- Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
-- Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).

-- 
-- Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
Gff.FieldData = class.class(KaitaiStruct)

function Gff.FieldData:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.FieldData:_read()
  self.raw_data = self._io:read_bytes(self._root.file.gff3.header.field_data_count)
end

-- 
-- Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
-- Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
-- Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
-- Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data

-- 
-- One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
-- `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
-- Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
Gff.FieldEntry = class.class(KaitaiStruct)

function Gff.FieldEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.FieldEntry:_read()
  self.field_type = BiowareGffCommon.GffFieldType(self._io:read_u4le())
  self.label_index = self._io:read_u4le()
  self.data_or_offset = self._io:read_u4le()
end

-- 
-- Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
Gff.FieldEntry.property.field_data_offset_value = {}
function Gff.FieldEntry.property.field_data_offset_value:get()
  if self._m_field_data_offset_value ~= nil then
    return self._m_field_data_offset_value
  end

  if self.is_complex_type then
    self._m_field_data_offset_value = self._root.file.gff3.header.field_data_offset + self.data_or_offset
  end
  return self._m_field_data_offset_value
end

-- 
-- Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
Gff.FieldEntry.property.is_complex_type = {}
function Gff.FieldEntry.property.is_complex_type:get()
  if self._m_is_complex_type ~= nil then
    return self._m_is_complex_type
  end

  self._m_is_complex_type =  ((self.field_type == BiowareGffCommon.GffFieldType.uint64) or (self.field_type == BiowareGffCommon.GffFieldType.int64) or (self.field_type == BiowareGffCommon.GffFieldType.double) or (self.field_type == BiowareGffCommon.GffFieldType.string) or (self.field_type == BiowareGffCommon.GffFieldType.resref) or (self.field_type == BiowareGffCommon.GffFieldType.localized_string) or (self.field_type == BiowareGffCommon.GffFieldType.binary) or (self.field_type == BiowareGffCommon.GffFieldType.vector4) or (self.field_type == BiowareGffCommon.GffFieldType.vector3)) 
  return self._m_is_complex_type
end

-- 
-- Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
Gff.FieldEntry.property.is_list_type = {}
function Gff.FieldEntry.property.is_list_type:get()
  if self._m_is_list_type ~= nil then
    return self._m_is_list_type
  end

  self._m_is_list_type = self.field_type == BiowareGffCommon.GffFieldType.list
  return self._m_is_list_type
end

-- 
-- Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
-- Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
-- **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
Gff.FieldEntry.property.is_simple_type = {}
function Gff.FieldEntry.property.is_simple_type:get()
  if self._m_is_simple_type ~= nil then
    return self._m_is_simple_type
  end

  self._m_is_simple_type =  ((self.field_type == BiowareGffCommon.GffFieldType.uint8) or (self.field_type == BiowareGffCommon.GffFieldType.int8) or (self.field_type == BiowareGffCommon.GffFieldType.uint16) or (self.field_type == BiowareGffCommon.GffFieldType.int16) or (self.field_type == BiowareGffCommon.GffFieldType.uint32) or (self.field_type == BiowareGffCommon.GffFieldType.int32) or (self.field_type == BiowareGffCommon.GffFieldType.single) or (self.field_type == BiowareGffCommon.GffFieldType.str_ref)) 
  return self._m_is_simple_type
end

-- 
-- Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
Gff.FieldEntry.property.is_struct_type = {}
function Gff.FieldEntry.property.is_struct_type:get()
  if self._m_is_struct_type ~= nil then
    return self._m_is_struct_type
  end

  self._m_is_struct_type = self.field_type == BiowareGffCommon.GffFieldType.struct
  return self._m_is_struct_type
end

-- 
-- Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.
Gff.FieldEntry.property.list_indices_offset_value = {}
function Gff.FieldEntry.property.list_indices_offset_value:get()
  if self._m_list_indices_offset_value ~= nil then
    return self._m_list_indices_offset_value
  end

  if self.is_list_type then
    self._m_list_indices_offset_value = self._root.file.gff3.header.list_indices_offset + self.data_or_offset
  end
  return self._m_list_indices_offset_value
end

-- 
-- Struct index (same numeric interpretation as `GFFStructData` row index).
Gff.FieldEntry.property.struct_index_value = {}
function Gff.FieldEntry.property.struct_index_value:get()
  if self._m_struct_index_value ~= nil then
    return self._m_struct_index_value
  end

  if self.is_struct_type then
    self._m_struct_index_value = self.data_or_offset
  end
  return self._m_struct_index_value
end

-- 
-- Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
-- (ID → storage: inline vs `field_data` vs struct/list indirection).
-- Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
-- Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
-- PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
-- 
-- Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.label_index` @ +0x4 (ulong).
-- 
-- Inline data (simple types) or offset/index (complex types):
-- - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
-- - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
-- - Struct (14): Struct index (index into struct_array)
-- - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.data_or_data_offset` @ +0x8.
-- `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types

-- 
-- Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
-- “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
Gff.FieldIndicesArray = class.class(KaitaiStruct)

function Gff.FieldIndicesArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.FieldIndicesArray:_read()
  self.indices = {}
  for i = 0, self._root.file.gff3.header.field_indices_count - 1 do
    self.indices[i + 1] = self._io:read_u4le()
  end
end

-- 
-- `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
-- `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
-- **Observed behavior**: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.

-- 
-- GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.
Gff.Gff3AfterAurora = class.class(KaitaiStruct)

function Gff.Gff3AfterAurora:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.Gff3AfterAurora:_read()
  self.header = Gff.GffHeaderTail(self._io, self, self._root)
end

-- 
-- Field dictionary: `header.field_count` × 12 B at `header.field_offset`. **Observed behavior**: `GFFFieldData`.
-- `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
-- Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
--     PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149
Gff.Gff3AfterAurora.property.field_array = {}
function Gff.Gff3AfterAurora.property.field_array:get()
  if self._m_field_array ~= nil then
    return self._m_field_array
  end

  if self.header.field_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.field_offset)
    self._m_field_array = Gff.FieldArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_field_array
end

-- 
-- Complex-type payload heap. **Observed behavior**: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
-- Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
--     PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216
Gff.Gff3AfterAurora.property.field_data = {}
function Gff.Gff3AfterAurora.property.field_data:get()
  if self._m_field_data ~= nil then
    return self._m_field_data
  end

  if self.header.field_data_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.field_data_offset)
    self._m_field_data = Gff.FieldData(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_field_data
end

-- 
-- Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
-- **Observed behavior**: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
-- Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
--     PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
Gff.Gff3AfterAurora.property.field_indices_array = {}
function Gff.Gff3AfterAurora.property.field_indices_array:get()
  if self._m_field_indices_array ~= nil then
    return self._m_field_indices_array
  end

  if self.header.field_indices_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.field_indices_offset)
    self._m_field_indices_array = Gff.FieldIndicesArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_field_indices_array
end

-- 
-- Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
-- **Observed behavior**: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
-- Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
--     PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154
Gff.Gff3AfterAurora.property.label_array = {}
function Gff.Gff3AfterAurora.property.label_array:get()
  if self._m_label_array ~= nil then
    return self._m_label_array
  end

  if self.header.label_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.label_offset)
    self._m_label_array = Gff.LabelArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_label_array
end

-- 
-- Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
-- **Observed behavior**: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
-- Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
--     PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
Gff.Gff3AfterAurora.property.list_indices_array = {}
function Gff.Gff3AfterAurora.property.list_indices_array:get()
  if self._m_list_indices_array ~= nil then
    return self._m_list_indices_array
  end

  if self.header.list_indices_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.list_indices_offset)
    self._m_list_indices_array = Gff.ListIndicesArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_list_indices_array
end

-- 
-- Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
-- Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
-- Implements the access pattern described in meta.doc (single-field vs multi-field structs).
Gff.Gff3AfterAurora.property.root_struct_resolved = {}
function Gff.Gff3AfterAurora.property.root_struct_resolved:get()
  if self._m_root_struct_resolved ~= nil then
    return self._m_root_struct_resolved
  end

  self._m_root_struct_resolved = Gff.ResolvedStruct(0, self._io, self, self._root)
  return self._m_root_struct_resolved
end

-- 
-- Struct table: `header.struct_count` × 12 B at `header.struct_offset`. **Observed behavior**: `GFFStructData` rows.
-- Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
--     PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65
Gff.Gff3AfterAurora.property.struct_array = {}
function Gff.Gff3AfterAurora.property.struct_array:get()
  if self._m_struct_array ~= nil then
    return self._m_struct_array
  end

  if self.header.struct_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.header.struct_offset)
    self._m_struct_array = Gff.StructArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_struct_array
end

-- 
-- Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
-- rows from Struct Array Offset through List Indices Count. **Observed behavior**: `GFFHeaderInfo` @ +0x8 … +0x34.

-- 
-- GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
-- PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
Gff.Gff4AfterAurora = class.class(KaitaiStruct)

function Gff.Gff4AfterAurora:_init(aurora_version, io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self.aurora_version = aurora_version
  self:_read()
end

function Gff.Gff4AfterAurora:_read()
  self.platform_id = self._io:read_u4be()
  self.file_type = self._io:read_u4be()
  self.type_version = self._io:read_u4be()
  self.num_struct_templates = self._io:read_u4le()
  if self.aurora_version == 1446260273 then
    self.string_count = self._io:read_u4le()
  end
  if self.aurora_version == 1446260273 then
    self.string_offset = self._io:read_u4le()
  end
  self.data_offset = self._io:read_u4le()
  self.struct_templates = {}
  for i = 0, self.num_struct_templates - 1 do
    self.struct_templates[i + 1] = Gff.Gff4StructTemplateHeader(self._io, self, self._root)
  end
  self.tail = self._io:read_bytes_full()
end

-- 
-- Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
-- `PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).
-- 
-- GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
-- `readUint32BE` on the endian-aware substream (`gff4file.cpp`).
-- 
-- Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).
-- 
-- Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
-- in typical DA assets). xoreos: `_header.structCount`.
-- 
-- V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).
-- 
-- V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).
-- 
-- Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
-- `readUint32` on the endian substream (`gff4file.cpp`).
-- 
-- Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).
-- 
-- Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
-- optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
-- GFF4 graph walker or defer to engine code.
-- 
-- Aurora version tag from the enclosing stream’s first 8 bytes (read on disk as `u4be`;
-- passed as `u4` for Kaitai param typing). Same value as `gff_union_file.aurora_version` / `gff4_file.aurora_version`.

-- 
-- Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
-- that expect a single user-type over the whole file.
Gff.Gff4File = class.class(KaitaiStruct)

function Gff.Gff4File:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.Gff4File:_read()
  self.aurora_magic = self._io:read_u4be()
  self.aurora_version = self._io:read_u4be()
  self.gff4 = Gff.Gff4AfterAurora(self.aurora_version, self._io, self, self._root)
end

-- 
-- Aurora container magic (`GFF ` as `u4be`).
-- 
-- GFF4 `V4.0` / `V4.1` on-disk tags.
-- 
-- GFF4 header tail + struct templates + opaque remainder.

Gff.Gff4StructTemplateHeader = class.class(KaitaiStruct)

function Gff.Gff4StructTemplateHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.Gff4StructTemplateHeader:_read()
  self.struct_label = self._io:read_u4be()
  self.field_count = self._io:read_u4le()
  self.field_offset = self._io:read_u4le()
  self.struct_size = self._io:read_u4le()
end

-- 
-- Template label (fourCC style, read `readUint32BE` in `loadStructs`).
-- 
-- Number of field declaration records for this template (may be 0).
-- 
-- Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
-- (xoreos `continue`s without reading declarations).
-- 
-- Declared on-disk struct size for instances of this template (`strct.size`).

-- 
-- **GFF3** header continuation: **48 bytes** (twelve LE `u32` dwords) at file offsets **0x08–0x37**, immediately
-- after the shared Aurora 8-byte prefix (`aurora_magic` / `aurora_version` on `gff_union_file`). Same layout as
-- wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) rows from “Struct Array
-- Offset” through “List Indices Count”. **Observed behavior** on `k1_win_gog_swkotor.exe`: `GFFHeaderInfo` @ +0x8 … +0x34.
-- 
-- Sources (same DWORD order on disk after the 8-byte signature):
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 (`file_type`/`file_version` L79–L80 then twelve header `u32`s L93–L106)
-- - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L44 (`GffReader::load` — skips 8-byte signature, reads twelve header `u32`s L30–L41)
-- - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
-- - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 (Aurora/GFF-family background; MultiMap wording)
Gff.GffHeaderTail = class.class(KaitaiStruct)

function Gff.GffHeaderTail:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.GffHeaderTail:_read()
  self.struct_offset = self._io:read_u4le()
  self.struct_count = self._io:read_u4le()
  self.field_offset = self._io:read_u4le()
  self.field_count = self._io:read_u4le()
  self.label_offset = self._io:read_u4le()
  self.label_count = self._io:read_u4le()
  self.field_data_offset = self._io:read_u4le()
  self.field_data_count = self._io:read_u4le()
  self.field_indices_offset = self._io:read_u4le()
  self.field_indices_count = self._io:read_u4le()
  self.list_indices_offset = self._io:read_u4le()
  self.list_indices_count = self._io:read_u4le()
end

-- 
-- Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30
-- 
-- Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_count` @ +0xC (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31
-- 
-- Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32
-- 
-- Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_count` @ +0x14 (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33
-- 
-- Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34
-- 
-- Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_count` @ +0x1C (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35
-- 
-- Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36
-- 
-- Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37
-- 
-- Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38
-- 
-- Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)
-- 
-- Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40
-- 
-- List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
-- Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
-- PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223

-- 
-- Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
-- (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
Gff.GffUnionFile = class.class(KaitaiStruct)

function Gff.GffUnionFile:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.GffUnionFile:_read()
  self.aurora_magic = self._io:read_u4be()
  self.aurora_version = self._io:read_u4be()
  if  ((self.aurora_version ~= 1446260272) and (self.aurora_version ~= 1446260273))  then
    self.gff3 = Gff.Gff3AfterAurora(self._io, self, self._root)
  end
  if  ((self.aurora_version == 1446260272) or (self.aurora_version == 1446260273))  then
    self.gff4 = Gff.Gff4AfterAurora(self.aurora_version, self._io, self, self._root)
  end
end

-- 
-- File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
-- legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.
-- 
-- Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
-- `0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.
-- 
-- **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.
-- 
-- **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.

-- 
-- Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
-- Indexed by `GFFFieldData.label_index` (×16). Not a separate struct in **observed behavior** — rows are `char[16]` in bulk.
-- Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
Gff.LabelArray = class.class(KaitaiStruct)

function Gff.LabelArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.LabelArray:_read()
  self.labels = {}
  for i = 0, self._root.file.gff3.header.label_count - 1 do
    self.labels[i + 1] = Gff.LabelEntry(self._io, self, self._root)
  end
end

-- 
-- Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
-- Index `i` is at file offset `label_offset + i*16`.

-- 
-- One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
Gff.LabelEntry = class.class(KaitaiStruct)

function Gff.LabelEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.LabelEntry:_read()
  self.name = str_decode.decode(self._io:read_bytes(16), "ASCII")
end

-- 
-- Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
-- Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
-- Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
-- Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array

-- 
-- Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
-- Not a separate engine-local datatype. Wire cite: `label_entry.name`.
Gff.LabelEntryTerminated = class.class(KaitaiStruct)

function Gff.LabelEntryTerminated:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.LabelEntryTerminated:_read()
  self.name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(16), 0, false), "ASCII")
end

-- 
-- Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.

-- 
-- One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
-- Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
Gff.ListEntry = class.class(KaitaiStruct)

function Gff.ListEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.ListEntry:_read()
  self.num_struct_indices = self._io:read_u4le()
  self.struct_indices = {}
  for i = 0, self.num_struct_indices - 1 do
    self.struct_indices[i + 1] = self._io:read_u4le()
  end
end

-- 
-- Little-endian count of following struct indices (list cardinality).
-- Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
-- 
-- Each value indexes `struct_array.entries[index]` (`GFFStructData` row).

-- 
-- Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
Gff.ListIndicesArray = class.class(KaitaiStruct)

function Gff.ListIndicesArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.ListIndicesArray:_read()
  self.raw_data = self._io:read_bytes(self._root.file.gff3.header.list_indices_count)
end

-- 
-- Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
-- Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
-- This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.

-- 
-- Kaitai composition: one `GFFFieldData` row + label + payload.
-- Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
-- Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
-- For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
Gff.ResolvedField = class.class(KaitaiStruct)

function Gff.ResolvedField:_init(field_index, io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self.field_index = field_index
  self:_read()
end

function Gff.ResolvedField:_read()
end

-- 
-- Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).
Gff.ResolvedField.property.entry = {}
function Gff.ResolvedField.property.entry:get()
  if self._m_entry ~= nil then
    return self._m_entry
  end

  local _pos = self._io:pos()
  self._io:seek(self._root.file.gff3.header.field_offset + self.field_index * 12)
  self._m_entry = Gff.FieldEntry(self._io, self, self._root)
  self._io:seek(_pos)
  return self._m_entry
end

-- 
-- Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).
Gff.ResolvedField.property.field_entry_pos = {}
function Gff.ResolvedField.property.field_entry_pos:get()
  if self._m_field_entry_pos ~= nil then
    return self._m_field_entry_pos
  end

  self._m_field_entry_pos = self._root.file.gff3.header.field_offset + self.field_index * 12
  return self._m_field_entry_pos
end

-- 
-- Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.
Gff.ResolvedField.property.label = {}
function Gff.ResolvedField.property.label:get()
  if self._m_label ~= nil then
    return self._m_label
  end

  local _pos = self._io:pos()
  self._io:seek(self._root.file.gff3.header.label_offset + self.entry.label_index * 16)
  self._m_label = Gff.LabelEntryTerminated(self._io, self, self._root)
  self._io:seek(_pos)
  return self._m_label
end

-- 
-- `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.
Gff.ResolvedField.property.list_entry = {}
function Gff.ResolvedField.property.list_entry:get()
  if self._m_list_entry ~= nil then
    return self._m_list_entry
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.list then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.list_indices_offset + self.entry.data_or_offset)
    self._m_list_entry = Gff.ListEntry(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_list_entry
end

-- 
-- Child structs for this list; indices from `list_entry.struct_indices`.
Gff.ResolvedField.property.list_structs = {}
function Gff.ResolvedField.property.list_structs:get()
  if self._m_list_structs ~= nil then
    return self._m_list_structs
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.list then
    self._m_list_structs = {}
    for i = 0, self.list_entry.num_struct_indices - 1 do
      self._m_list_structs[i + 1] = Gff.ResolvedStruct(self.list_entry.struct_indices[i + 1], self._io, self, self._root)
    end
  end
  return self._m_list_structs
end

-- 
-- `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
Gff.ResolvedField.property.value_binary = {}
function Gff.ResolvedField.property.value_binary:get()
  if self._m_value_binary ~= nil then
    return self._m_value_binary
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.binary then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_data_offset + self.entry.data_or_offset)
    self._m_value_binary = BiowareCommon.BiowareBinaryData(self._io)
    self._io:seek(_pos)
  end
  return self._m_value_binary
end

-- 
-- `GFFFieldTypes` 9 (double).
Gff.ResolvedField.property.value_double = {}
function Gff.ResolvedField.property.value_double:get()
  if self._m_value_double ~= nil then
    return self._m_value_double
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.double then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_data_offset + self.entry.data_or_offset)
    self._m_value_double = self._io:read_f8le()
    self._io:seek(_pos)
  end
  return self._m_value_double
end

-- 
-- `GFFFieldTypes` 3 (INT16 LE at +8).
Gff.ResolvedField.property.value_int16 = {}
function Gff.ResolvedField.property.value_int16:get()
  if self._m_value_int16 ~= nil then
    return self._m_value_int16
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.int16 then
    local _pos = self._io:pos()
    self._io:seek(self.field_entry_pos + 8)
    self._m_value_int16 = self._io:read_s2le()
    self._io:seek(_pos)
  end
  return self._m_value_int16
end

-- 
-- `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
Gff.ResolvedField.property.value_int32 = {}
function Gff.ResolvedField.property.value_int32:get()
  if self._m_value_int32 ~= nil then
    return self._m_value_int32
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.int32 then
    local _pos = self._io:pos()
    self._io:seek(self.field_entry_pos + 8)
    self._m_value_int32 = self._io:read_s4le()
    self._io:seek(_pos)
  end
  return self._m_value_int32
end

-- 
-- `GFFFieldTypes` 7 (INT64).
Gff.ResolvedField.property.value_int64 = {}
function Gff.ResolvedField.property.value_int64:get()
  if self._m_value_int64 ~= nil then
    return self._m_value_int64
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.int64 then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_data_offset + self.entry.data_or_offset)
    self._m_value_int64 = self._io:read_s8le()
    self._io:seek(_pos)
  end
  return self._m_value_int64
end

-- 
-- `GFFFieldTypes` 1 (INT8 in low byte of slot).
Gff.ResolvedField.property.value_int8 = {}
function Gff.ResolvedField.property.value_int8:get()
  if self._m_value_int8 ~= nil then
    return self._m_value_int8
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.int8 then
    local _pos = self._io:pos()
    self._io:seek(self.field_entry_pos + 8)
    self._m_value_int8 = self._io:read_s1()
    self._io:seek(_pos)
  end
  return self._m_value_int8
end

-- 
-- `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
Gff.ResolvedField.property.value_localized_string = {}
function Gff.ResolvedField.property.value_localized_string:get()
  if self._m_value_localized_string ~= nil then
    return self._m_value_localized_string
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.localized_string then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_data_offset + self.entry.data_or_offset)
    self._m_value_localized_string = BiowareCommon.BiowareLocstring(self._io)
    self._io:seek(_pos)
  end
  return self._m_value_localized_string
end

-- 
-- `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
Gff.ResolvedField.property.value_resref = {}
function Gff.ResolvedField.property.value_resref:get()
  if self._m_value_resref ~= nil then
    return self._m_value_resref
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.resref then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_data_offset + self.entry.data_or_offset)
    self._m_value_resref = BiowareCommon.BiowareResref(self._io)
    self._io:seek(_pos)
  end
  return self._m_value_resref
end

-- 
-- `GFFFieldTypes` 8 (32-bit float).
Gff.ResolvedField.property.value_single = {}
function Gff.ResolvedField.property.value_single:get()
  if self._m_value_single ~= nil then
    return self._m_value_single
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.single then
    local _pos = self._io:pos()
    self._io:seek(self.field_entry_pos + 8)
    self._m_value_single = self._io:read_f4le()
    self._io:seek(_pos)
  end
  return self._m_value_single
end

-- 
-- `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
-- `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
-- **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
-- Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
-- PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
Gff.ResolvedField.property.value_str_ref = {}
function Gff.ResolvedField.property.value_str_ref:get()
  if self._m_value_str_ref ~= nil then
    return self._m_value_str_ref
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.str_ref then
    local _pos = self._io:pos()
    self._io:seek(self.field_entry_pos + 8)
    self._m_value_str_ref = self._io:read_u4le()
    self._io:seek(_pos)
  end
  return self._m_value_str_ref
end

-- 
-- `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
Gff.ResolvedField.property.value_string = {}
function Gff.ResolvedField.property.value_string:get()
  if self._m_value_string ~= nil then
    return self._m_value_string
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.string then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_data_offset + self.entry.data_or_offset)
    self._m_value_string = BiowareCommon.BiowareCexoString(self._io)
    self._io:seek(_pos)
  end
  return self._m_value_string
end

-- 
-- `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.
Gff.ResolvedField.property.value_struct = {}
function Gff.ResolvedField.property.value_struct:get()
  if self._m_value_struct ~= nil then
    return self._m_value_struct
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.struct then
    self._m_value_struct = Gff.ResolvedStruct(self.entry.data_or_offset, self._io, self, self._root)
  end
  return self._m_value_struct
end

-- 
-- `GFFFieldTypes` 2 (UINT16 LE at +8).
Gff.ResolvedField.property.value_uint16 = {}
function Gff.ResolvedField.property.value_uint16:get()
  if self._m_value_uint16 ~= nil then
    return self._m_value_uint16
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.uint16 then
    local _pos = self._io:pos()
    self._io:seek(self.field_entry_pos + 8)
    self._m_value_uint16 = self._io:read_u2le()
    self._io:seek(_pos)
  end
  return self._m_value_uint16
end

-- 
-- `GFFFieldTypes` 4 (full inline DWORD).
Gff.ResolvedField.property.value_uint32 = {}
function Gff.ResolvedField.property.value_uint32:get()
  if self._m_value_uint32 ~= nil then
    return self._m_value_uint32
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.uint32 then
    local _pos = self._io:pos()
    self._io:seek(self.field_entry_pos + 8)
    self._m_value_uint32 = self._io:read_u4le()
    self._io:seek(_pos)
  end
  return self._m_value_uint32
end

-- 
-- `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
Gff.ResolvedField.property.value_uint64 = {}
function Gff.ResolvedField.property.value_uint64:get()
  if self._m_value_uint64 ~= nil then
    return self._m_value_uint64
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.uint64 then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_data_offset + self.entry.data_or_offset)
    self._m_value_uint64 = self._io:read_u8le()
    self._io:seek(_pos)
  end
  return self._m_value_uint64
end

-- 
-- `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
Gff.ResolvedField.property.value_uint8 = {}
function Gff.ResolvedField.property.value_uint8:get()
  if self._m_value_uint8 ~= nil then
    return self._m_value_uint8
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.uint8 then
    local _pos = self._io:pos()
    self._io:seek(self.field_entry_pos + 8)
    self._m_value_uint8 = self._io:read_u1()
    self._io:seek(_pos)
  end
  return self._m_value_uint8
end

-- 
-- `GFFFieldTypes` 17 — three floats (`bioware_vector3`).
Gff.ResolvedField.property.value_vector3 = {}
function Gff.ResolvedField.property.value_vector3:get()
  if self._m_value_vector3 ~= nil then
    return self._m_value_vector3
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.vector3 then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_data_offset + self.entry.data_or_offset)
    self._m_value_vector3 = BiowareCommon.BiowareVector3(self._io)
    self._io:seek(_pos)
  end
  return self._m_value_vector3
end

-- 
-- `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
Gff.ResolvedField.property.value_vector4 = {}
function Gff.ResolvedField.property.value_vector4:get()
  if self._m_value_vector4 ~= nil then
    return self._m_value_vector4
  end

  if self.entry.field_type == BiowareGffCommon.GffFieldType.vector4 then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_data_offset + self.entry.data_or_offset)
    self._m_value_vector4 = BiowareCommon.BiowareVector4(self._io)
    self._io:seek(_pos)
  end
  return self._m_value_vector4
end

-- 
-- Index into `field_array.entries`; require `field_index < field_count`.

-- 
-- Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
-- On-disk row remains at `struct_offset + struct_index * 12`.
Gff.ResolvedStruct = class.class(KaitaiStruct)

function Gff.ResolvedStruct:_init(struct_index, io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self.struct_index = struct_index
  self:_read()
end

function Gff.ResolvedStruct:_read()
end

-- 
-- Raw `GFFStructData` (12-byte layout in **observed behavior**).
Gff.ResolvedStruct.property.entry = {}
function Gff.ResolvedStruct.property.entry:get()
  if self._m_entry ~= nil then
    return self._m_entry
  end

  local _pos = self._io:pos()
  self._io:seek(self._root.file.gff3.header.struct_offset + self.struct_index * 12)
  self._m_entry = Gff.StructEntry(self._io, self, self._root)
  self._io:seek(_pos)
  return self._m_entry
end

-- 
-- Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
-- Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
Gff.ResolvedStruct.property.field_indices = {}
function Gff.ResolvedStruct.property.field_indices:get()
  if self._m_field_indices ~= nil then
    return self._m_field_indices
  end

  if self.entry.field_count > 1 then
    local _pos = self._io:pos()
    self._io:seek(self._root.file.gff3.header.field_indices_offset + self.entry.data_or_offset)
    self._m_field_indices = {}
    for i = 0, self.entry.field_count - 1 do
      self._m_field_indices[i + 1] = self._io:read_u4le()
    end
    self._io:seek(_pos)
  end
  return self._m_field_indices
end

-- 
-- One `resolved_field` per entry in `field_indices`.
Gff.ResolvedStruct.property.fields = {}
function Gff.ResolvedStruct.property.fields:get()
  if self._m_fields ~= nil then
    return self._m_fields
  end

  if self.entry.field_count > 1 then
    self._m_fields = {}
    for i = 0, self.entry.field_count - 1 do
      self._m_fields[i + 1] = Gff.ResolvedField(self.field_indices[i + 1], self._io, self, self._root)
    end
  end
  return self._m_fields
end

-- 
-- `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).
Gff.ResolvedStruct.property.single_field = {}
function Gff.ResolvedStruct.property.single_field:get()
  if self._m_single_field ~= nil then
    return self._m_single_field
  end

  if self.entry.field_count == 1 then
    self._m_single_field = Gff.ResolvedField(self.entry.data_or_offset, self._io, self, self._root)
  end
  return self._m_single_field
end

-- 
-- Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.

-- 
-- Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Name in **observed behavior**: `GFFStructData`.
-- Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
Gff.StructArray = class.class(KaitaiStruct)

function Gff.StructArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.StructArray:_read()
  self.entries = {}
  for i = 0, self._root.file.gff3.header.struct_count - 1 do
    self.entries[i + 1] = Gff.StructEntry(self._io, self, self._root)
  end
end

-- 
-- Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
-- Stride 12 bytes per struct (matches the component layout in **observed behavior**).

-- 
-- One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
Gff.StructEntry = class.class(KaitaiStruct)

function Gff.StructEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Gff.StructEntry:_read()
  self.struct_id = self._io:read_u4le()
  self.data_or_offset = self._io:read_u4le()
  self.field_count = self._io:read_u4le()
end

-- 
-- Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.
Gff.StructEntry.property.field_indices_offset = {}
function Gff.StructEntry.property.field_indices_offset:get()
  if self._m_field_indices_offset ~= nil then
    return self._m_field_indices_offset
  end

  if self.has_multiple_fields then
    self._m_field_indices_offset = self.data_or_offset
  end
  return self._m_field_indices_offset
end

-- 
-- Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
Gff.StructEntry.property.has_multiple_fields = {}
function Gff.StructEntry.property.has_multiple_fields:get()
  if self._m_has_multiple_fields ~= nil then
    return self._m_has_multiple_fields
  end

  self._m_has_multiple_fields = self.field_count > 1
  return self._m_has_multiple_fields
end

-- 
-- Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
-- Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
Gff.StructEntry.property.has_single_field = {}
function Gff.StructEntry.property.has_single_field:get()
  if self._m_has_single_field ~= nil then
    return self._m_has_single_field
  end

  self._m_has_single_field = self.field_count == 1
  return self._m_has_single_field
end

-- 
-- Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
Gff.StructEntry.property.single_field_index = {}
function Gff.StructEntry.property.single_field_index:get()
  if self._m_single_field_index ~= nil then
    return self._m_single_field_index
  end

  if self.has_single_field then
    self._m_single_field_index = self.data_or_offset
  end
  return self._m_single_field_index
end

-- 
-- Structure type identifier.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
-- Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
-- 0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.
-- 
-- Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
-- If field_count == 0, this value is unused.
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
-- 
-- Number of fields in this struct:
-- - 0: No fields
-- - 1: Single field, data_or_offset contains the field index directly
-- - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
-- **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.field_count` @ +0x8 (ulong).

