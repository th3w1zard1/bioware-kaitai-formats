// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// TwoDA (2D Array) files store tabular data in a binary format used by BioWare games
    /// including Knights of the Old Republic (KotOR) and The Sith Lords (TSL).
    /// 
    /// TwoDA files are essentially two-dimensional arrays (tables) with:
    /// - Column headers (first row defines column names)
    /// - Row labels (first column defines row identifiers)
    /// - Cell values (data at row/column intersections)
    /// 
    /// Binary Format Structure:
    /// - File Header (9 bytes): Magic &quot;2DA &quot; (space-padded), version &quot;V2.b&quot;, and newline
    /// - Column Headers Section: Tab-separated column names, terminated by null byte
    /// - Row Count (4 bytes): uint32 indicating number of data rows
    /// - Row Labels Section: Tab-separated row labels (one per row)
    /// - Cell Offsets Array: Array of uint16 offsets (rowCount * columnCount entries)
    /// - Data Size (2 bytes): uint16 indicating total size of cell data section
    /// - Cell Values Section: Null-terminated strings at offsets specified in offsets array
    /// 
    /// The format uses an offset-based string table for cell values, allowing efficient
    /// storage of duplicate values (shared strings are stored once and referenced by offset).
    /// 
    /// References:
    /// - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py
    /// - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py
    /// </summary>
    public partial class Twoda : KaitaiStruct
    {
        public Twoda(uint p_columnCount, KaitaiStream p__io, KaitaiStruct p__parent = null, Twoda p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _columnCount = p_columnCount;
            _read();
        }
        private void _read()
        {
            _header = new TwodaHeader(m_io, this, m_root);
            _columnHeadersRaw = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesTerm(0, false, true, true));
            _rowCount = m_io.ReadU4le();
            _rowLabelsSection = new RowLabelsSection(m_io, this, m_root);
            _cellOffsets = new List<ushort>();
            for (var i = 0; i < RowCount * ColumnCount; i++)
            {
                _cellOffsets.Add(m_io.ReadU2le());
            }
            _lenCellValuesSection = m_io.ReadU2le();
            __raw_cellValuesSection = m_io.ReadBytes(LenCellValuesSection);
            var io___raw_cellValuesSection = new KaitaiStream(__raw_cellValuesSection);
            _cellValuesSection = new CellValuesSection(io___raw_cellValuesSection, this, m_root);
        }
        public partial class CellValuesSection : KaitaiStruct
        {
            public static CellValuesSection FromFile(string fileName)
            {
                return new CellValuesSection(new KaitaiStream(fileName));
            }

            public CellValuesSection(KaitaiStream p__io, Twoda p__parent = null, Twoda p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _rawData = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(M_Root.LenCellValuesSection));
            }
            private string _rawData;
            private Twoda m_root;
            private Twoda m_parent;

            /// <summary>
            /// Raw cell values data as a single string.
            /// Contains all null-terminated cell value strings concatenated together.
            /// Individual strings can be extracted using offsets from cell_offsets.
            /// Note: To read a specific cell value, seek to (cell_values_section start + offset) and read a null-terminated string.
            /// </summary>
            public string RawData { get { return _rawData; } }
            public Twoda M_Root { get { return m_root; } }
            public Twoda M_Parent { get { return m_parent; } }
        }
        public partial class RowLabelEntry : KaitaiStruct
        {
            public static RowLabelEntry FromFile(string fileName)
            {
                return new RowLabelEntry(new KaitaiStream(fileName));
            }

            public RowLabelEntry(KaitaiStream p__io, Twoda.RowLabelsSection p__parent = null, Twoda p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _labelValue = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesTerm(9, false, true, false));
            }
            private string _labelValue;
            private Twoda m_root;
            private Twoda.RowLabelsSection m_parent;

            /// <summary>
            /// Row label value (ASCII string terminated by tab character 0x09).
            /// Tab terminator is consumed but not included in the string value.
            /// Row labels uniquely identify each row in the table.
            /// Often numeric (e.g., &quot;0&quot;, &quot;1&quot;, &quot;2&quot;) but can be any string identifier.
            /// </summary>
            public string LabelValue { get { return _labelValue; } }
            public Twoda M_Root { get { return m_root; } }
            public Twoda.RowLabelsSection M_Parent { get { return m_parent; } }
        }
        public partial class RowLabelsSection : KaitaiStruct
        {
            public static RowLabelsSection FromFile(string fileName)
            {
                return new RowLabelsSection(new KaitaiStream(fileName));
            }

            public RowLabelsSection(KaitaiStream p__io, Twoda p__parent = null, Twoda p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _labels = new List<RowLabelEntry>();
                for (var i = 0; i < M_Root.RowCount; i++)
                {
                    _labels.Add(new RowLabelEntry(m_io, this, m_root));
                }
            }
            private List<RowLabelEntry> _labels;
            private Twoda m_root;
            private Twoda m_parent;

            /// <summary>
            /// Array of row label entries, one per row.
            /// Each label is terminated by tab character (0x09).
            /// Total count equals row_count from the header.
            /// Row labels typically identify each data row (e.g., numeric IDs, names, etc.).
            /// </summary>
            public List<RowLabelEntry> Labels { get { return _labels; } }
            public Twoda M_Root { get { return m_root; } }
            public Twoda M_Parent { get { return m_parent; } }
        }
        public partial class TwodaHeader : KaitaiStruct
        {
            public static TwodaHeader FromFile(string fileName)
            {
                return new TwodaHeader(new KaitaiStream(fileName));
            }

            public TwodaHeader(KaitaiStream p__io, Twoda p__parent = null, Twoda p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_isValidTwoda = false;
                _read();
            }
            private void _read()
            {
                _magic = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                _version = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                _newline = m_io.ReadU1();
            }
            private bool f_isValidTwoda;
            private bool _isValidTwoda;

            /// <summary>
            /// Validation check that the file is a valid TwoDA file.
            /// All header fields must match expected values.
            /// </summary>
            public bool IsValidTwoda
            {
                get
                {
                    if (f_isValidTwoda)
                        return _isValidTwoda;
                    f_isValidTwoda = true;
                    _isValidTwoda = (bool) ( ((Magic == "2DA ") && (Version == "V2.b") && (Newline == 10)) );
                    return _isValidTwoda;
                }
            }
            private string _magic;
            private string _version;
            private byte _newline;
            private Twoda m_root;
            private Twoda m_parent;

            /// <summary>
            /// File type signature. Must be &quot;2DA &quot; (space-padded).
            /// Bytes: 0x32 0x44 0x41 0x20
            /// The space after &quot;2DA&quot; is significant and must be present.
            /// </summary>
            public string Magic { get { return _magic; } }

            /// <summary>
            /// File format version. Always &quot;V2.b&quot; for KotOR/TSL TwoDA files.
            /// Bytes: 0x56 0x32 0x2E 0x62
            /// This is the binary version identifier (V2.b = Version 2 binary).
            /// </summary>
            public string Version { get { return _version; } }

            /// <summary>
            /// Newline character (0x0A = '\n').
            /// Separates header from column headers section.
            /// </summary>
            public byte Newline { get { return _newline; } }
            public Twoda M_Root { get { return m_root; } }
            public Twoda M_Parent { get { return m_parent; } }
        }
        private TwodaHeader _header;
        private string _columnHeadersRaw;
        private uint _rowCount;
        private RowLabelsSection _rowLabelsSection;
        private List<ushort> _cellOffsets;
        private ushort _lenCellValuesSection;
        private CellValuesSection _cellValuesSection;
        private uint _columnCount;
        private Twoda m_root;
        private KaitaiStruct m_parent;
        private byte[] __raw_cellValuesSection;

        /// <summary>
        /// TwoDA file header (9 bytes) - magic &quot;2DA &quot;, version &quot;V2.b&quot;, and newline character
        /// </summary>
        public TwodaHeader Header { get { return _header; } }

        /// <summary>
        /// Column headers section as a single null-terminated string.
        /// Contains tab-separated column names. The null terminator marks the end.
        /// Column names can be extracted by splitting on tab characters (0x09).
        /// Example: &quot;col1\tcol2\tcol3\0&quot; represents three columns: &quot;col1&quot;, &quot;col2&quot;, &quot;col3&quot;
        /// </summary>
        public string ColumnHeadersRaw { get { return _columnHeadersRaw; } }

        /// <summary>
        /// Number of data rows in the TwoDA table.
        /// This count determines how many row labels and how many cell entries per column.
        /// </summary>
        public uint RowCount { get { return _rowCount; } }

        /// <summary>
        /// Row labels section - tab-separated row labels (one per row)
        /// </summary>
        public RowLabelsSection RowLabelsSection { get { return _rowLabelsSection; } }

        /// <summary>
        /// Array of cell value offsets (uint16 per cell). There are exactly row_count * column_count
        /// entries, in row-major order. Each offset is relative to the start of the cell values blob
        /// and points to a null-terminated string.
        /// </summary>
        public List<ushort> CellOffsets { get { return _cellOffsets; } }

        /// <summary>
        /// Total size in bytes of the cell values data section.
        /// This is the size of all unique cell value strings combined (including null terminators).
        /// Not used during reading but stored for format consistency.
        /// </summary>
        public ushort LenCellValuesSection { get { return _lenCellValuesSection; } }

        /// <summary>
        /// Cell values data section containing all unique cell value strings.
        /// Each string is null-terminated. Offsets from cell_offsets point into this section.
        /// The section starts immediately after len_cell_values_section field and has size = len_cell_values_section bytes.
        /// </summary>
        public CellValuesSection CellValuesSection { get { return _cellValuesSection; } }

        /// <summary>
        /// Number of tab-separated column headers in the file (excluding the trailing null terminator).
        /// Kaitai expressions cannot derive this from the header blob, so callers must pre-scan the
        /// column header section (same rule as PyKotor: count tab characters between the newline after
        /// V2.b and the first 0x00) and pass it into the parser.
        /// </summary>
        public uint ColumnCount { get { return _columnCount; } }
        public Twoda M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
        public byte[] M_RawCellValuesSection { get { return __raw_cellValuesSection; } }
    }
}
