# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# TwoDA (2D Array) files store tabular data in a binary format used by BioWare games
# including Knights of the Old Republic (KotOR) and The Sith Lords (TSL).
# 
# TwoDA files are essentially two-dimensional arrays (tables) with:
# - Column headers (first row defines column names)
# - Row labels (first column defines row identifiers)
# - Cell values (data at row/column intersections)
# 
# Binary Format Structure:
# - File Header (9 bytes): Magic "2DA " (space-padded), version "V2.b", and newline
# - Column Headers Section: Tab-separated column names, terminated by null byte
# - Row Count (4 bytes): uint32 indicating number of data rows
# - Row Labels Section: Tab-separated row labels (one per row)
# - Cell Offsets Array: Array of uint16 offsets (rowCount * columnCount entries)
# - Data Size (2 bytes): uint16 indicating total size of cell data section
# - Cell Values Section: Null-terminated strings at offsets specified in offsets array
# 
# The format uses an offset-based string table for cell values, allowing efficient
# storage of duplicate values (shared strings are stored once and referenced by offset).
# 
# Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_twoda` / `twoda_data`, xoreos `TwoDAFile`, xoreos-tools `convert2da`, reone `TwoDAReader`, KotOR.js `TwoDAObject`).
# @see https://github.com/OpenKotOR/PyKotor/wiki/2DA-File-Format PyKotor wiki — TwoDA
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py#L25-L238 PyKotor — `io_twoda` (binary `V2.b` + writer)
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py#L8-L114 PyKotor — `twoda_data` (model + ASCII/binary notes)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L48-L51 xoreos — `k2DAID` / `k2DAIDTab` + version tags
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L145-L172 xoreos — `TwoDAFile::load`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L192-L336 xoreos — binary `V2.b` (`read2b` + `readHeaders2b` / `skipRowNames2b` / `readRows2b`)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L517-L611 xoreos — `TwoDAFile::writeBinary`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86 xoreos-tools — `convert2da` CLI (`main`)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159 xoreos-tools — `get2DAGDA` / `TwoDAFile` dispatch
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/2dareader.cpp#L29-L66 reone — `TwoDAReader`
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TwoDAObject.ts#L69-L155 KotOR.js — `TwoDAObject`
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf xoreos-docs — 2DA_Format.pdf
class Twoda < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil, column_count)
    super(_io, _parent, _root || self)
    @column_count = column_count
    _read
  end

  def _read
    @header = TwodaHeader.new(@_io, self, @_root)
    @column_headers_raw = (@_io.read_bytes_term(0, false, true, true)).force_encoding("ASCII").encode('UTF-8')
    @row_count = @_io.read_u4le
    @row_labels_section = RowLabelsSection.new(@_io, self, @_root)
    @cell_offsets = []
    (row_count * column_count).times { |i|
      @cell_offsets << @_io.read_u2le
    }
    @len_cell_values_section = @_io.read_u2le
    _io_cell_values_section = @_io.substream(len_cell_values_section)
    @cell_values_section = CellValuesSection.new(_io_cell_values_section, self, @_root)
    self
  end
  class CellValuesSection < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @raw_data = (@_io.read_bytes(_root.len_cell_values_section)).force_encoding("ASCII").encode('UTF-8')
      self
    end

    ##
    # Raw cell values data as a single string.
    # Contains all null-terminated cell value strings concatenated together.
    # Individual strings can be extracted using offsets from cell_offsets.
    # Note: To read a specific cell value, seek to (cell_values_section start + offset) and read a null-terminated string.
    attr_reader :raw_data
  end
  class RowLabelEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @label_value = (@_io.read_bytes_term(9, false, true, false)).force_encoding("ASCII").encode('UTF-8')
      self
    end

    ##
    # Row label value (ASCII string terminated by tab character 0x09).
    # Tab terminator is consumed but not included in the string value.
    # Row labels uniquely identify each row in the table.
    # Often numeric (e.g., "0", "1", "2") but can be any string identifier.
    attr_reader :label_value
  end
  class RowLabelsSection < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @labels = []
      (_root.row_count).times { |i|
        @labels << RowLabelEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of row label entries, one per row.
    # Each label is terminated by tab character (0x09).
    # Total count equals row_count from the header.
    # Row labels typically identify each data row (e.g., numeric IDs, names, etc.).
    attr_reader :labels
  end
  class TwodaHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @magic = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      @version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      @newline = @_io.read_u1
      self
    end

    ##
    # Validation check that the file is a valid TwoDA file.
    # All header fields must match expected values.
    def is_valid_twoda
      return @is_valid_twoda unless @is_valid_twoda.nil?
      @is_valid_twoda =  ((magic == "2DA ") && (version == "V2.b") && (newline == 10)) 
      @is_valid_twoda
    end

    ##
    # File type signature. Must be "2DA " (space-padded).
    # Bytes: 0x32 0x44 0x41 0x20
    # The space after "2DA" is significant and must be present.
    attr_reader :magic

    ##
    # File format version. Always "V2.b" for KotOR/TSL TwoDA files.
    # Bytes: 0x56 0x32 0x2E 0x62
    # This is the binary version identifier (V2.b = Version 2 binary).
    attr_reader :version

    ##
    # Newline character (0x0A = '\n').
    # Separates header from column headers section.
    attr_reader :newline
  end

  ##
  # TwoDA file header (9 bytes) - magic "2DA ", version "V2.b", and newline character
  attr_reader :header

  ##
  # Column headers section as a single null-terminated string.
  # Contains tab-separated column names. The null terminator marks the end.
  # Column names can be extracted by splitting on tab characters (0x09).
  # Example: "col1\tcol2\tcol3\0" represents three columns: "col1", "col2", "col3"
  attr_reader :column_headers_raw

  ##
  # Number of data rows in the TwoDA table.
  # This count determines how many row labels and how many cell entries per column.
  attr_reader :row_count

  ##
  # Row labels section - tab-separated row labels (one per row)
  attr_reader :row_labels_section

  ##
  # Array of cell value offsets (uint16 per cell). There are exactly row_count * column_count
  # entries, in row-major order. Each offset is relative to the start of the cell values blob
  # and points to a null-terminated string.
  attr_reader :cell_offsets

  ##
  # Total size in bytes of the cell values data section.
  # This is the size of all unique cell value strings combined (including null terminators).
  # Not used during reading but stored for format consistency.
  attr_reader :len_cell_values_section

  ##
  # Cell values data section containing all unique cell value strings.
  # Each string is null-terminated. Offsets from cell_offsets point into this section.
  # The section starts immediately after len_cell_values_section field and has size = len_cell_values_section bytes.
  attr_reader :cell_values_section

  ##
  # Number of tab-separated column headers in the file (excluding the trailing null terminator).
  # Kaitai expressions cannot derive this from the header blob, so callers must pre-scan the
  # column header section (same rule as PyKotor: count tab characters between the newline after
  # V2.b and the first 0x00) and pass it into the parser.
  attr_reader :column_count
  attr_reader :_raw_cell_values_section
end
