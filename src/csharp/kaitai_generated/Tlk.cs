// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// TLK (Talk Table) files contain all text strings used in the game, both written and spoken.
    /// They enable easy localization by providing a lookup table from string reference numbers (StrRef)
    /// to localized text and associated voice-over audio files.
    /// 
    /// Binary Format Structure:
    /// - File Header (20 bytes): File type signature, version, language ID, string count, entries offset
    /// - String Data Table (40 bytes per entry): Metadata for each string entry (flags, sound ResRef, offsets, lengths)
    /// - String Entries (variable size): Sequential null-terminated text strings starting at entries_offset
    /// 
    /// The format uses a two-level structure:
    /// 1. String Data Table: Contains metadata (flags, sound filename, text offset/length) for each entry
    /// 2. String Entries: Actual text data stored sequentially, referenced by offsets in the data table
    /// 
    /// String references (StrRef) are 0-based indices into the string_data_table array. StrRef 0 refers to
    /// the first entry, StrRef 1 to the second, etc. StrRef -1 indicates no string reference.
    /// 
    /// References:
    /// - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk
    /// - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/tlkreader.cpp:31-84
    /// - https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp:42-176
    /// - https://github.com/TSLPatcher/TSLPatcher/blob/master/lib/site/Bioware/TLK.pm:1-533
    /// - https://github.com/KotOR-Community-Patches/Kotor.NET/blob/master/Kotor.NET/Formats/KotorTLK/TLKBinaryStructure.cs:11-132
    /// </summary>
    public partial class Tlk : KaitaiStruct
    {
        public static Tlk FromFile(string fileName)
        {
            return new Tlk(new KaitaiStream(fileName));
        }

        public Tlk(KaitaiStream p__io, KaitaiStruct p__parent = null, Tlk p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _header = new TlkHeader(m_io, this, m_root);
            _stringDataTable = new StringDataTable(m_io, this, m_root);
        }
        public partial class StringDataEntry : KaitaiStruct
        {
            public static StringDataEntry FromFile(string fileName)
            {
                return new StringDataEntry(new KaitaiStream(fileName));
            }

            public StringDataEntry(KaitaiStream p__io, Tlk.StringDataTable p__parent = null, Tlk p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_entrySize = false;
                f_soundLengthPresent = false;
                f_soundPresent = false;
                f_textData = false;
                f_textFileOffset = false;
                f_textPresent = false;
                _read();
            }
            private void _read()
            {
                _flags = m_io.ReadU4le();
                _soundResref = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(16));
                _volumeVariance = m_io.ReadU4le();
                _pitchVariance = m_io.ReadU4le();
                _textOffset = m_io.ReadU4le();
                _textLength = m_io.ReadU4le();
                _soundLength = m_io.ReadF4le();
            }
            private bool f_entrySize;
            private sbyte _entrySize;

            /// <summary>
            /// Size of each string_data_entry in bytes.
            /// Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
            /// text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.
            /// </summary>
            public sbyte EntrySize
            {
                get
                {
                    if (f_entrySize)
                        return _entrySize;
                    f_entrySize = true;
                    _entrySize = (sbyte) (40);
                    return _entrySize;
                }
            }
            private bool f_soundLengthPresent;
            private bool _soundLengthPresent;

            /// <summary>
            /// Whether sound length is valid (bit 2 of flags)
            /// </summary>
            public bool SoundLengthPresent
            {
                get
                {
                    if (f_soundLengthPresent)
                        return _soundLengthPresent;
                    f_soundLengthPresent = true;
                    _soundLengthPresent = (bool) ((Flags & 4) != 0);
                    return _soundLengthPresent;
                }
            }
            private bool f_soundPresent;
            private bool _soundPresent;

            /// <summary>
            /// Whether voice-over audio exists (bit 1 of flags)
            /// </summary>
            public bool SoundPresent
            {
                get
                {
                    if (f_soundPresent)
                        return _soundPresent;
                    f_soundPresent = true;
                    _soundPresent = (bool) ((Flags & 2) != 0);
                    return _soundPresent;
                }
            }
            private bool f_textData;
            private string _textData;

            /// <summary>
            /// Text string data as raw bytes (read as ASCII for byte-level access).
            /// The actual encoding depends on the language_id in the header.
            /// Common encodings:
            /// - English/French/German/Italian/Spanish: Windows-1252 (cp1252)
            /// - Polish: Windows-1250 (cp1250)
            /// - Korean: EUC-KR (cp949)
            /// - Chinese Traditional: Big5 (cp950)
            /// - Chinese Simplified: GB2312 (cp936)
            /// - Japanese: Shift-JIS (cp932)
            /// 
            /// Note: This field reads the raw bytes as ASCII string for byte-level access.
            /// The application layer should decode based on the language_id field in the header.
            /// To get raw bytes, access the underlying byte representation of this string.
            /// 
            /// In practice, strings are stored sequentially starting at entries_offset,
            /// so text_offset values are relative to entries_offset (0, len1, len1+len2, etc.).
            /// 
            /// Strings may be null-terminated, but text_length includes the null terminator.
            /// Application code should trim null bytes when decoding.
            /// 
            /// If text_present flag (bit 0) is not set, this field may contain garbage data
            /// or be empty. Always check text_present before using this data.
            /// </summary>
            public string TextData
            {
                get
                {
                    if (f_textData)
                        return _textData;
                    f_textData = true;
                    long _pos = m_io.Pos;
                    m_io.Seek(TextFileOffset);
                    _textData = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(TextLength));
                    m_io.Seek(_pos);
                    return _textData;
                }
            }
            private bool f_textFileOffset;
            private int _textFileOffset;

            /// <summary>
            /// Absolute file offset to the text string.
            /// Calculated as entries_offset (from header) + text_offset (from entry).
            /// </summary>
            public int TextFileOffset
            {
                get
                {
                    if (f_textFileOffset)
                        return _textFileOffset;
                    f_textFileOffset = true;
                    _textFileOffset = (int) (M_Root.Header.EntriesOffset + TextOffset);
                    return _textFileOffset;
                }
            }
            private bool f_textPresent;
            private bool _textPresent;

            /// <summary>
            /// Whether text content exists (bit 0 of flags)
            /// </summary>
            public bool TextPresent
            {
                get
                {
                    if (f_textPresent)
                        return _textPresent;
                    f_textPresent = true;
                    _textPresent = (bool) ((Flags & 1) != 0);
                    return _textPresent;
                }
            }
            private uint _flags;
            private string _soundResref;
            private uint _volumeVariance;
            private uint _pitchVariance;
            private uint _textOffset;
            private uint _textLength;
            private float _soundLength;
            private Tlk m_root;
            private Tlk.StringDataTable m_parent;

            /// <summary>
            /// Bit flags indicating what data is present:
            /// - bit 0 (0x0001): Text present - string has text content
            /// - bit 1 (0x0002): Sound present - string has associated voice-over audio
            /// - bit 2 (0x0004): Sound length present - sound length field is valid
            /// 
            /// Common flag combinations:
            /// - 0x0001: Text only (menu options, item descriptions)
            /// - 0x0003: Text + Sound (voiced dialog lines)
            /// - 0x0007: Text + Sound + Length (fully voiced with duration)
            /// - 0x0000: Empty entry (unused StrRef slots)
            /// </summary>
            public uint Flags { get { return _flags; } }

            /// <summary>
            /// Voice-over audio filename (ResRef), null-terminated ASCII, max 16 chars.
            /// If the string is shorter than 16 bytes, it is null-padded.
            /// Empty string (all nulls) indicates no voice-over audio.
            /// </summary>
            public string SoundResref { get { return _soundResref; } }

            /// <summary>
            /// Volume variance (unused in KotOR, always 0).
            /// Legacy field from Neverwinter Nights, not used by KotOR engine.
            /// </summary>
            public uint VolumeVariance { get { return _volumeVariance; } }

            /// <summary>
            /// Pitch variance (unused in KotOR, always 0).
            /// Legacy field from Neverwinter Nights, not used by KotOR engine.
            /// </summary>
            public uint PitchVariance { get { return _pitchVariance; } }

            /// <summary>
            /// Offset to string text relative to entries_offset.
            /// The actual file offset is: header.entries_offset + text_offset.
            /// First string starts at offset 0, subsequent strings follow sequentially.
            /// </summary>
            public uint TextOffset { get { return _textOffset; } }

            /// <summary>
            /// Length of string text in bytes (not characters).
            /// For single-byte encodings (Windows-1252, etc.), byte length equals character count.
            /// For multi-byte encodings (UTF-8, etc.), byte length may be greater than character count.
            /// </summary>
            public uint TextLength { get { return _textLength; } }

            /// <summary>
            /// Duration of voice-over audio in seconds (float).
            /// Only valid if sound_length_present flag (bit 2) is set.
            /// Used by the engine to determine how long to wait before auto-advancing dialog.
            /// </summary>
            public float SoundLength { get { return _soundLength; } }
            public Tlk M_Root { get { return m_root; } }
            public Tlk.StringDataTable M_Parent { get { return m_parent; } }
        }
        public partial class StringDataTable : KaitaiStruct
        {
            public static StringDataTable FromFile(string fileName)
            {
                return new StringDataTable(new KaitaiStream(fileName));
            }

            public StringDataTable(KaitaiStream p__io, Tlk p__parent = null, Tlk p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<StringDataEntry>();
                for (var i = 0; i < M_Root.Header.StringCount; i++)
                {
                    _entries.Add(new StringDataEntry(m_io, this, m_root));
                }
            }
            private List<StringDataEntry> _entries;
            private Tlk m_root;
            private Tlk m_parent;

            /// <summary>
            /// Array of string data entries, one per string in the file
            /// </summary>
            public List<StringDataEntry> Entries { get { return _entries; } }
            public Tlk M_Root { get { return m_root; } }
            public Tlk M_Parent { get { return m_parent; } }
        }
        public partial class TlkHeader : KaitaiStruct
        {
            public static TlkHeader FromFile(string fileName)
            {
                return new TlkHeader(new KaitaiStream(fileName));
            }

            public TlkHeader(KaitaiStream p__io, Tlk p__parent = null, Tlk p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_expectedEntriesOffset = false;
                f_headerSize = false;
                _read();
            }
            private void _read()
            {
                _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                _languageId = m_io.ReadU4le();
                _stringCount = m_io.ReadU4le();
                _entriesOffset = m_io.ReadU4le();
            }
            private bool f_expectedEntriesOffset;
            private int _expectedEntriesOffset;

            /// <summary>
            /// Expected offset to string entries (header + string data table).
            /// Used for validation.
            /// </summary>
            public int ExpectedEntriesOffset
            {
                get
                {
                    if (f_expectedEntriesOffset)
                        return _expectedEntriesOffset;
                    f_expectedEntriesOffset = true;
                    _expectedEntriesOffset = (int) (20 + StringCount * 40);
                    return _expectedEntriesOffset;
                }
            }
            private bool f_headerSize;
            private sbyte _headerSize;

            /// <summary>
            /// Size of the TLK header in bytes
            /// </summary>
            public sbyte HeaderSize
            {
                get
                {
                    if (f_headerSize)
                        return _headerSize;
                    f_headerSize = true;
                    _headerSize = (sbyte) (20);
                    return _headerSize;
                }
            }
            private string _fileType;
            private string _fileVersion;
            private uint _languageId;
            private uint _stringCount;
            private uint _entriesOffset;
            private Tlk m_root;
            private Tlk m_parent;

            /// <summary>
            /// File type signature. Must be &quot;TLK &quot; (space-padded).
            /// Validates that this is a TLK file.
            /// Note: Validation removed temporarily due to Kaitai Struct parser issues.
            /// </summary>
            public string FileType { get { return _fileType; } }

            /// <summary>
            /// File format version. &quot;V3.0&quot; for KotOR, &quot;V4.0&quot; for Jade Empire.
            /// KotOR games use V3.0. Jade Empire uses V4.0.
            /// Note: Validation removed due to Kaitai Struct parser limitations with period in string.
            /// </summary>
            public string FileVersion { get { return _fileVersion; } }

            /// <summary>
            /// Language identifier:
            /// - 0 = English
            /// - 1 = French
            /// - 2 = German
            /// - 3 = Italian
            /// - 4 = Spanish
            /// - 5 = Polish
            /// - 128 = Korean
            /// - 129 = Chinese Traditional
            /// - 130 = Chinese Simplified
            /// - 131 = Japanese
            /// See Language enum for complete list.
            /// </summary>
            public uint LanguageId { get { return _languageId; } }

            /// <summary>
            /// Number of string entries in the file.
            /// Determines the number of entries in string_data_table.
            /// </summary>
            public uint StringCount { get { return _stringCount; } }

            /// <summary>
            /// Byte offset to string entries array from the beginning of the file.
            /// Typically 20 + (string_count * 40) = header size + string data table size.
            /// Points to where the actual text strings begin.
            /// </summary>
            public uint EntriesOffset { get { return _entriesOffset; } }
            public Tlk M_Root { get { return m_root; } }
            public Tlk M_Parent { get { return m_parent; } }
        }
        private TlkHeader _header;
        private StringDataTable _stringDataTable;
        private Tlk m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// TLK file header (20 bytes) - contains file signature, version, language, and counts
        /// </summary>
        public TlkHeader Header { get { return _header; } }

        /// <summary>
        /// Array of string data entries (metadata for each string) - 40 bytes per entry
        /// </summary>
        public StringDataTable StringDataTable { get { return _stringDataTable; } }
        public Tlk M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
