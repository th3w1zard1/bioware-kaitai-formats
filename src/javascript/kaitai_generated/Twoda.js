// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Twoda || (root.Twoda = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Twoda_, KaitaiStream) {
/**
 * TwoDA (2D Array) files store tabular data in a binary format used by BioWare games
 * including Knights of the Old Republic (KotOR) and The Sith Lords (TSL).
 * 
 * TwoDA files are essentially two-dimensional arrays (tables) with:
 * - Column headers (first row defines column names)
 * - Row labels (first column defines row identifiers)
 * - Cell values (data at row/column intersections)
 * 
 * Binary Format Structure:
 * - File Header (9 bytes): Magic "2DA " (space-padded), version "V2.b", and newline
 * - Column Headers Section: Tab-separated column names, terminated by null byte
 * - Row Count (4 bytes): uint32 indicating number of data rows
 * - Row Labels Section: Tab-separated row labels (one per row)
 * - Cell Offsets Array: Array of uint16 offsets (rowCount * columnCount entries)
 * - Data Size (2 bytes): uint16 indicating total size of cell data section
 * - Cell Values Section: Null-terminated strings at offsets specified in offsets array
 * 
 * The format uses an offset-based string table for cell values, allowing efficient
 * storage of duplicate values (shared strings are stored once and referenced by offset).
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py
 */

var Twoda = (function() {
  function Twoda(_io, _parent, _root, columnCount) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;
    this.columnCount = columnCount;

    this._read();
  }
  Twoda.prototype._read = function() {
    this.header = new TwodaHeader(this._io, this, this._root);
    this.columnHeadersRaw = KaitaiStream.bytesToStr(this._io.readBytesTerm(0, false, true, true), "ASCII");
    this.rowCount = this._io.readU4le();
    this.rowLabelsSection = new RowLabelsSection(this._io, this, this._root);
    this.cellOffsets = [];
    for (var i = 0; i < this.rowCount * this.columnCount; i++) {
      this.cellOffsets.push(this._io.readU2le());
    }
    this.lenCellValuesSection = this._io.readU2le();
    this._raw_cellValuesSection = this._io.readBytes(this.lenCellValuesSection);
    var _io__raw_cellValuesSection = new KaitaiStream(this._raw_cellValuesSection);
    this.cellValuesSection = new CellValuesSection(_io__raw_cellValuesSection, this, this._root);
  }

  var CellValuesSection = Twoda.CellValuesSection = (function() {
    function CellValuesSection(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    CellValuesSection.prototype._read = function() {
      this.rawData = KaitaiStream.bytesToStr(this._io.readBytes(this._root.lenCellValuesSection), "ASCII");
    }

    /**
     * Raw cell values data as a single string.
     * Contains all null-terminated cell value strings concatenated together.
     * Individual strings can be extracted using offsets from cell_offsets.
     * Note: To read a specific cell value, seek to (cell_values_section start + offset) and read a null-terminated string.
     */

    return CellValuesSection;
  })();

  var RowLabelEntry = Twoda.RowLabelEntry = (function() {
    function RowLabelEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    RowLabelEntry.prototype._read = function() {
      this.labelValue = KaitaiStream.bytesToStr(this._io.readBytesTerm(9, false, true, false), "ASCII");
    }

    /**
     * Row label value (ASCII string terminated by tab character 0x09).
     * Tab terminator is consumed but not included in the string value.
     * Row labels uniquely identify each row in the table.
     * Often numeric (e.g., "0", "1", "2") but can be any string identifier.
     */

    return RowLabelEntry;
  })();

  var RowLabelsSection = Twoda.RowLabelsSection = (function() {
    function RowLabelsSection(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    RowLabelsSection.prototype._read = function() {
      this.labels = [];
      for (var i = 0; i < this._root.rowCount; i++) {
        this.labels.push(new RowLabelEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of row label entries, one per row.
     * Each label is terminated by tab character (0x09).
     * Total count equals row_count from the header.
     * Row labels typically identify each data row (e.g., numeric IDs, names, etc.).
     */

    return RowLabelsSection;
  })();

  var TwodaHeader = Twoda.TwodaHeader = (function() {
    function TwodaHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    TwodaHeader.prototype._read = function() {
      this.magic = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      this.version = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      this.newline = this._io.readU1();
    }

    /**
     * Validation check that the file is a valid TwoDA file.
     * All header fields must match expected values.
     */
    Object.defineProperty(TwodaHeader.prototype, 'isValidTwoda', {
      get: function() {
        if (this._m_isValidTwoda !== undefined)
          return this._m_isValidTwoda;
        this._m_isValidTwoda =  ((this.magic == "2DA ") && (this.version == "V2.b") && (this.newline == 10)) ;
        return this._m_isValidTwoda;
      }
    });

    /**
     * File type signature. Must be "2DA " (space-padded).
     * Bytes: 0x32 0x44 0x41 0x20
     * The space after "2DA" is significant and must be present.
     */

    /**
     * File format version. Always "V2.b" for KotOR/TSL TwoDA files.
     * Bytes: 0x56 0x32 0x2E 0x62
     * This is the binary version identifier (V2.b = Version 2 binary).
     */

    /**
     * Newline character (0x0A = '\n').
     * Separates header from column headers section.
     */

    return TwodaHeader;
  })();

  /**
   * TwoDA file header (9 bytes) - magic "2DA ", version "V2.b", and newline character
   */

  /**
   * Column headers section as a single null-terminated string.
   * Contains tab-separated column names. The null terminator marks the end.
   * Column names can be extracted by splitting on tab characters (0x09).
   * Example: "col1\tcol2\tcol3\0" represents three columns: "col1", "col2", "col3"
   */

  /**
   * Number of data rows in the TwoDA table.
   * This count determines how many row labels and how many cell entries per column.
   */

  /**
   * Row labels section - tab-separated row labels (one per row)
   */

  /**
   * Array of cell value offsets (uint16 per cell). There are exactly row_count * column_count
   * entries, in row-major order. Each offset is relative to the start of the cell values blob
   * and points to a null-terminated string.
   */

  /**
   * Total size in bytes of the cell values data section.
   * This is the size of all unique cell value strings combined (including null terminators).
   * Not used during reading but stored for format consistency.
   */

  /**
   * Cell values data section containing all unique cell value strings.
   * Each string is null-terminated. Offsets from cell_offsets point into this section.
   * The section starts immediately after len_cell_values_section field and has size = len_cell_values_section bytes.
   */

  /**
   * Number of tab-separated column headers in the file (excluding the trailing null terminator).
   * Kaitai expressions cannot derive this from the header blob, so callers must pre-scan the
   * column header section (same rule as PyKotor: count tab characters between the newline after
   * V2.b and the first 0x00) and pass it into the parser.
   */

  return Twoda;
})();
Twoda_.Twoda = Twoda;
});
