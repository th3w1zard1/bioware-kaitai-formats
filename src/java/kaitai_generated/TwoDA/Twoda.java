// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


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
 * Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_twoda` / `twoda_data`, xoreos `TwoDAFile`, xoreos-tools `convert2da`, reone `TwoDAReader`, KotOR.js `TwoDAObject`).
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/2DA-File-Format">PyKotor wiki — TwoDA</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py#L25-L238">PyKotor — `io_twoda` (binary `V2.b` + writer)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py#L8-L114">PyKotor — `twoda_data` (model + ASCII/binary notes)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L48-L51">xoreos — `k2DAID` / `k2DAIDTab` + version tags</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L145-L172">xoreos — `TwoDAFile::load`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L192-L336">xoreos — binary `V2.b` (`read2b` + `readHeaders2b` / `skipRowNames2b` / `readRows2b`)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L517-L611">xoreos — `TwoDAFile::writeBinary`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86">xoreos-tools — `convert2da` CLI (`main`)</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159">xoreos-tools — `get2DAGDA` / `TwoDAFile` dispatch</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/2dareader.cpp#L29-L66">reone — `TwoDAReader`</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TwoDAObject.ts#L69-L155">KotOR.js — `TwoDAObject`</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf">xoreos-docs — 2DA_Format.pdf</a>
 */
public class Twoda extends KaitaiStruct {

    public Twoda(KaitaiStream _io, long columnCount) {
        this(_io, null, null, columnCount);
    }

    public Twoda(KaitaiStream _io, KaitaiStruct _parent, long columnCount) {
        this(_io, _parent, null, columnCount);
    }

    public Twoda(KaitaiStream _io, KaitaiStruct _parent, Twoda _root, long columnCount) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        this.columnCount = columnCount;
        _read();
    }
    private void _read() {
        this.header = new TwodaHeader(this._io, this, _root);
        this.columnHeadersRaw = new String(this._io.readBytesTerm((byte) 0, false, true, true), StandardCharsets.US_ASCII);
        this.rowCount = this._io.readU4le();
        this.rowLabelsSection = new RowLabelsSection(this._io, this, _root);
        this.cellOffsets = new ArrayList<Integer>();
        for (int i = 0; i < rowCount() * columnCount(); i++) {
            this.cellOffsets.add(this._io.readU2le());
        }
        this.lenCellValuesSection = this._io.readU2le();
        KaitaiStream _io_cellValuesSection = this._io.substream(lenCellValuesSection());
        this.cellValuesSection = new CellValuesSection(_io_cellValuesSection, this, _root);
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
        this.rowLabelsSection._fetchInstances();
        for (int i = 0; i < this.cellOffsets.size(); i++) {
        }
        this.cellValuesSection._fetchInstances();
    }
    public static class CellValuesSection extends KaitaiStruct {
        public static CellValuesSection fromFile(String fileName) throws IOException {
            return new CellValuesSection(new ByteBufferKaitaiStream(fileName));
        }

        public CellValuesSection(KaitaiStream _io) {
            this(_io, null, null);
        }

        public CellValuesSection(KaitaiStream _io, Twoda _parent) {
            this(_io, _parent, null);
        }

        public CellValuesSection(KaitaiStream _io, Twoda _parent, Twoda _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.rawData = new String(this._io.readBytes(_root().lenCellValuesSection()), StandardCharsets.US_ASCII);
        }

        public void _fetchInstances() {
        }
        private String rawData;
        private Twoda _root;
        private Twoda _parent;

        /**
         * Raw cell values data as a single string.
         * Contains all null-terminated cell value strings concatenated together.
         * Individual strings can be extracted using offsets from cell_offsets.
         * Note: To read a specific cell value, seek to (cell_values_section start + offset) and read a null-terminated string.
         */
        public String rawData() { return rawData; }
        public Twoda _root() { return _root; }
        public Twoda _parent() { return _parent; }
    }
    public static class RowLabelEntry extends KaitaiStruct {
        public static RowLabelEntry fromFile(String fileName) throws IOException {
            return new RowLabelEntry(new ByteBufferKaitaiStream(fileName));
        }

        public RowLabelEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public RowLabelEntry(KaitaiStream _io, Twoda.RowLabelsSection _parent) {
            this(_io, _parent, null);
        }

        public RowLabelEntry(KaitaiStream _io, Twoda.RowLabelsSection _parent, Twoda _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.labelValue = new String(this._io.readBytesTerm((byte) 9, false, true, false), StandardCharsets.US_ASCII);
        }

        public void _fetchInstances() {
        }
        private String labelValue;
        private Twoda _root;
        private Twoda.RowLabelsSection _parent;

        /**
         * Row label value (ASCII string terminated by tab character 0x09).
         * Tab terminator is consumed but not included in the string value.
         * Row labels uniquely identify each row in the table.
         * Often numeric (e.g., "0", "1", "2") but can be any string identifier.
         */
        public String labelValue() { return labelValue; }
        public Twoda _root() { return _root; }
        public Twoda.RowLabelsSection _parent() { return _parent; }
    }
    public static class RowLabelsSection extends KaitaiStruct {
        public static RowLabelsSection fromFile(String fileName) throws IOException {
            return new RowLabelsSection(new ByteBufferKaitaiStream(fileName));
        }

        public RowLabelsSection(KaitaiStream _io) {
            this(_io, null, null);
        }

        public RowLabelsSection(KaitaiStream _io, Twoda _parent) {
            this(_io, _parent, null);
        }

        public RowLabelsSection(KaitaiStream _io, Twoda _parent, Twoda _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.labels = new ArrayList<RowLabelEntry>();
            for (int i = 0; i < _root().rowCount(); i++) {
                this.labels.add(new RowLabelEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.labels.size(); i++) {
                this.labels.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<RowLabelEntry> labels;
        private Twoda _root;
        private Twoda _parent;

        /**
         * Array of row label entries, one per row.
         * Each label is terminated by tab character (0x09).
         * Total count equals row_count from the header.
         * Row labels typically identify each data row (e.g., numeric IDs, names, etc.).
         */
        public List<RowLabelEntry> labels() { return labels; }
        public Twoda _root() { return _root; }
        public Twoda _parent() { return _parent; }
    }
    public static class TwodaHeader extends KaitaiStruct {
        public static TwodaHeader fromFile(String fileName) throws IOException {
            return new TwodaHeader(new ByteBufferKaitaiStream(fileName));
        }

        public TwodaHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public TwodaHeader(KaitaiStream _io, Twoda _parent) {
            this(_io, _parent, null);
        }

        public TwodaHeader(KaitaiStream _io, Twoda _parent, Twoda _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.magic = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            this.version = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            this.newline = this._io.readU1();
        }

        public void _fetchInstances() {
        }
        private Boolean isValidTwoda;

        /**
         * Validation check that the file is a valid TwoDA file.
         * All header fields must match expected values.
         */
        public Boolean isValidTwoda() {
            if (this.isValidTwoda != null)
                return this.isValidTwoda;
            this.isValidTwoda =  ((magic().equals("2DA ")) && (version().equals("V2.b")) && (newline() == 10)) ;
            return this.isValidTwoda;
        }
        private String magic;
        private String version;
        private int newline;
        private Twoda _root;
        private Twoda _parent;

        /**
         * File type signature. Must be "2DA " (space-padded).
         * Bytes: 0x32 0x44 0x41 0x20
         * The space after "2DA" is significant and must be present.
         */
        public String magic() { return magic; }

        /**
         * File format version. Always "V2.b" for KotOR/TSL TwoDA files.
         * Bytes: 0x56 0x32 0x2E 0x62
         * This is the binary version identifier (V2.b = Version 2 binary).
         */
        public String version() { return version; }

        /**
         * Newline character (0x0A = '\n').
         * Separates header from column headers section.
         */
        public int newline() { return newline; }
        public Twoda _root() { return _root; }
        public Twoda _parent() { return _parent; }
    }
    private TwodaHeader header;
    private String columnHeadersRaw;
    private long rowCount;
    private RowLabelsSection rowLabelsSection;
    private List<Integer> cellOffsets;
    private int lenCellValuesSection;
    private CellValuesSection cellValuesSection;
    private long columnCount;
    private Twoda _root;
    private KaitaiStruct _parent;

    /**
     * TwoDA file header (9 bytes) - magic "2DA ", version "V2.b", and newline character
     */
    public TwodaHeader header() { return header; }

    /**
     * Column headers section as a single null-terminated string.
     * Contains tab-separated column names. The null terminator marks the end.
     * Column names can be extracted by splitting on tab characters (0x09).
     * Example: "col1\tcol2\tcol3\0" represents three columns: "col1", "col2", "col3"
     */
    public String columnHeadersRaw() { return columnHeadersRaw; }

    /**
     * Number of data rows in the TwoDA table.
     * This count determines how many row labels and how many cell entries per column.
     */
    public long rowCount() { return rowCount; }

    /**
     * Row labels section - tab-separated row labels (one per row)
     */
    public RowLabelsSection rowLabelsSection() { return rowLabelsSection; }

    /**
     * Array of cell value offsets (uint16 per cell). There are exactly row_count * column_count
     * entries, in row-major order. Each offset is relative to the start of the cell values blob
     * and points to a null-terminated string.
     */
    public List<Integer> cellOffsets() { return cellOffsets; }

    /**
     * Total size in bytes of the cell values data section.
     * This is the size of all unique cell value strings combined (including null terminators).
     * Not used during reading but stored for format consistency.
     */
    public int lenCellValuesSection() { return lenCellValuesSection; }

    /**
     * Cell values data section containing all unique cell value strings.
     * Each string is null-terminated. Offsets from cell_offsets point into this section.
     * The section starts immediately after len_cell_values_section field and has size = len_cell_values_section bytes.
     */
    public CellValuesSection cellValuesSection() { return cellValuesSection; }

    /**
     * Number of tab-separated column headers in the file (excluding the trailing null terminator).
     * Kaitai expressions cannot derive this from the header blob, so callers must pre-scan the
     * column header section (same rule as PyKotor: count tab characters between the newline after
     * V2.b and the first 0x00) and pass it into the parser.
     */
    public long columnCount() { return columnCount; }
    public Twoda _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
