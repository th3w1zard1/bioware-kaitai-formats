-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")
local stringstream = require("string_stream")

-- 
-- TwoDA (2D Array) files store tabular data in a binary format used by BioWare games
-- including Knights of the Old Republic (KotOR) and The Sith Lords (TSL).
-- 
-- TwoDA files are essentially two-dimensional arrays (tables) with:
-- - Column headers (first row defines column names)
-- - Row labels (first column defines row identifiers)
-- - Cell values (data at row/column intersections)
-- 
-- Binary Format Structure:
-- - File Header (9 bytes): Magic "2DA " (space-padded), version "V2.b", and newline
-- - Column Headers Section: Tab-separated column names, terminated by null byte
-- - Row Count (4 bytes): uint32 indicating number of data rows
-- - Row Labels Section: Tab-separated row labels (one per row)
-- - Cell Offsets Array: Array of uint16 offsets (rowCount * columnCount entries)
-- - Data Size (2 bytes): uint16 indicating total size of cell data section
-- - Cell Values Section: Null-terminated strings at offsets specified in offsets array
-- 
-- The format uses an offset-based string table for cell values, allowing efficient
-- storage of duplicate values (shared strings are stored once and referenced by offset).
-- 
-- Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_twoda` / `twoda_data`, xoreos `TwoDAFile`, xoreos-tools `convert2da`, reone `TwoDAReader`, KotOR.js `TwoDAObject`).
-- See also: PyKotor wiki — TwoDA (https://github.com/OpenKotOR/PyKotor/wiki/2DA-File-Format)
-- See also: PyKotor — `io_twoda` (binary `V2.b` + writer) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py#L25-L238)
-- See also: PyKotor — `twoda_data` (model + ASCII/binary notes) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py#L8-L114)
-- See also: xoreos — `k2DAID` / `k2DAIDTab` + version tags (https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L48-L51)
-- See also: xoreos — `TwoDAFile::load` (https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L145-L172)
-- See also: xoreos — binary `V2.b` (`read2b` + `readHeaders2b` / `skipRowNames2b` / `readRows2b`) (https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L192-L336)
-- See also: xoreos — `TwoDAFile::writeBinary` (https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L517-L611)
-- See also: xoreos-tools — `convert2da` CLI (`main`) (https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86)
-- See also: xoreos-tools — `get2DAGDA` / `TwoDAFile` dispatch (https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159)
-- See also: reone — `TwoDAReader` (https://github.com/modawan/reone/blob/master/src/libs/resource/format/2dareader.cpp#L29-L66)
-- See also: KotOR.js — `TwoDAObject` (https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TwoDAObject.ts#L69-L155)
-- See also: xoreos-docs — 2DA_Format.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf)
Twoda = class.class(KaitaiStruct)

function Twoda:_init(column_count, io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self.column_count = column_count
  self:_read()
end

function Twoda:_read()
  self.header = Twoda.TwodaHeader(self._io, self, self._root)
  self.column_headers_raw = str_decode.decode(self._io:read_bytes_term(0, false, true, true), "ASCII")
  self.row_count = self._io:read_u4le()
  self.row_labels_section = Twoda.RowLabelsSection(self._io, self, self._root)
  self.cell_offsets = {}
  for i = 0, self.row_count * self.column_count - 1 do
    self.cell_offsets[i + 1] = self._io:read_u2le()
  end
  self.len_cell_values_section = self._io:read_u2le()
  self._raw_cell_values_section = self._io:read_bytes(self.len_cell_values_section)
  local _io = KaitaiStream(stringstream(self._raw_cell_values_section))
  self.cell_values_section = Twoda.CellValuesSection(_io, self, self._root)
end

-- 
-- TwoDA file header (9 bytes) - magic "2DA ", version "V2.b", and newline character.
-- 
-- Column headers section as a single null-terminated string.
-- Contains tab-separated column names. The null terminator marks the end.
-- Column names can be extracted by splitting on tab characters (0x09).
-- Example: "col1\tcol2\tcol3\0" represents three columns: "col1", "col2", "col3"
-- 
-- Number of data rows in the TwoDA table.
-- This count determines how many row labels and how many cell entries per column.
-- 
-- Row labels section - tab-separated row labels (one per row).
-- 
-- Array of cell value offsets (uint16 per cell). There are exactly row_count * column_count
-- entries, in row-major order. Each offset is relative to the start of the cell values blob
-- and points to a null-terminated string.
-- 
-- Total size in bytes of the cell values data section.
-- This is the size of all unique cell value strings combined (including null terminators).
-- Not used during reading but stored for format consistency.
-- 
-- Cell values data section containing all unique cell value strings.
-- Each string is null-terminated. Offsets from cell_offsets point into this section.
-- The section starts immediately after len_cell_values_section field and has size = len_cell_values_section bytes.
-- 
-- Number of tab-separated column headers in the file (excluding the trailing null terminator).
-- Kaitai expressions cannot derive this from the header blob, so callers must pre-scan the
-- column header section (same rule as PyKotor: count tab characters between the newline after
-- V2.b and the first 0x00) and pass it into the parser.

Twoda.CellValuesSection = class.class(KaitaiStruct)

function Twoda.CellValuesSection:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Twoda.CellValuesSection:_read()
  self.raw_data = str_decode.decode(self._io:read_bytes(self._root.len_cell_values_section), "ASCII")
end

-- 
-- Raw cell values data as a single string.
-- Contains all null-terminated cell value strings concatenated together.
-- Individual strings can be extracted using offsets from cell_offsets.
-- Note: To read a specific cell value, seek to (cell_values_section start + offset) and read a null-terminated string.

Twoda.RowLabelEntry = class.class(KaitaiStruct)

function Twoda.RowLabelEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Twoda.RowLabelEntry:_read()
  self.label_value = str_decode.decode(self._io:read_bytes_term(9, false, true, false), "ASCII")
end

-- 
-- Row label value (ASCII string terminated by tab character 0x09).
-- Tab terminator is consumed but not included in the string value.
-- Row labels uniquely identify each row in the table.
-- Often numeric (e.g., "0", "1", "2") but can be any string identifier.

Twoda.RowLabelsSection = class.class(KaitaiStruct)

function Twoda.RowLabelsSection:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Twoda.RowLabelsSection:_read()
  self.labels = {}
  for i = 0, self._root.row_count - 1 do
    self.labels[i + 1] = Twoda.RowLabelEntry(self._io, self, self._root)
  end
end

-- 
-- Array of row label entries, one per row.
-- Each label is terminated by tab character (0x09).
-- Total count equals row_count from the header.
-- Row labels typically identify each data row (e.g., numeric IDs, names, etc.).

Twoda.TwodaHeader = class.class(KaitaiStruct)

function Twoda.TwodaHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Twoda.TwodaHeader:_read()
  self.magic = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.newline = self._io:read_u1()
end

-- 
-- Validation check that the file is a valid TwoDA file.
-- All header fields must match expected values.
Twoda.TwodaHeader.property.is_valid_twoda = {}
function Twoda.TwodaHeader.property.is_valid_twoda:get()
  if self._m_is_valid_twoda ~= nil then
    return self._m_is_valid_twoda
  end

  self._m_is_valid_twoda =  ((self.magic == "2DA ") and (self.version == "V2.b") and (self.newline == 10)) 
  return self._m_is_valid_twoda
end

-- 
-- File type signature. Must be "2DA " (space-padded).
-- Bytes: 0x32 0x44 0x41 0x20
-- The space after "2DA" is significant and must be present.
-- 
-- File format version. Always "V2.b" for KotOR/TSL TwoDA files.
-- Bytes: 0x56 0x32 0x2E 0x62
-- This is the binary version identifier (V2.b = Version 2 binary).
-- 
-- Newline character (0x0A = '\n').
-- Separates header from column headers section.

