// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
    /// Resource types use `bioware_type_ids`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key">PyKotor wiki — KEY</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/key/io_key.py#L26-L183">PyKotor — `io_key` (Kaitai + legacy + header write)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/keyreader.cpp#L26-L80">reone — `KeyReader`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp#L50-L88">xoreos — `KEYFile::load`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L192-L210">xoreos-tools — `openKEYs` / `openKEYDataFiles`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf">xoreos-docs — KeyBIF_Format.pdf</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/key.html">xoreos-docs — Torlack key.html</a>
    /// </remarks>
    public partial class Key : KaitaiStruct
    {
        public static Key FromFile(string fileName)
        {
            return new Key(new KaitaiStream(fileName));
        }

        public Key(KaitaiStream p__io, KaitaiStruct p__parent = null, Key p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            f_fileTable = false;
            f_keyTable = false;
            _read();
        }
        private void _read()
        {
            _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_fileType == "KEY "))
            {
                throw new ValidationNotEqualError("KEY ", _fileType, m_io, "/seq/0");
            }
            _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!( ((_fileVersion == "V1  ") || (_fileVersion == "V1.1")) ))
            {
                throw new ValidationNotAnyOfError(_fileVersion, m_io, "/seq/1");
            }
            _bifCount = m_io.ReadU4le();
            _keyCount = m_io.ReadU4le();
            _fileTableOffset = m_io.ReadU4le();
            _keyTableOffset = m_io.ReadU4le();
            _buildYear = m_io.ReadU4le();
            _buildDay = m_io.ReadU4le();
            _reserved = m_io.ReadBytes(32);
        }
        public partial class FileEntry : KaitaiStruct
        {
            public static FileEntry FromFile(string fileName)
            {
                return new FileEntry(new KaitaiStream(fileName));
            }

            public FileEntry(KaitaiStream p__io, Key.FileTable p__parent = null, Key p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_filename = false;
                _read();
            }
            private void _read()
            {
                _fileSize = m_io.ReadU4le();
                _filenameOffset = m_io.ReadU4le();
                _filenameSize = m_io.ReadU2le();
                _drives = m_io.ReadU2le();
            }
            private bool f_filename;
            private string _filename;

            /// <summary>
            /// BIF filename string at the absolute filename_offset in the KEY file.
            /// </summary>
            public string Filename
            {
                get
                {
                    if (f_filename)
                        return _filename;
                    f_filename = true;
                    long _pos = m_io.Pos;
                    m_io.Seek(FilenameOffset);
                    _filename = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(FilenameSize));
                    m_io.Seek(_pos);
                    return _filename;
                }
            }
            private uint _fileSize;
            private uint _filenameOffset;
            private ushort _filenameSize;
            private ushort _drives;
            private Key m_root;
            private Key.FileTable m_parent;

            /// <summary>
            /// Size of the BIF file on disk in bytes.
            /// </summary>
            public uint FileSize { get { return _fileSize; } }

            /// <summary>
            /// Absolute byte offset from the start of the KEY file where this BIF's filename is stored
            /// (seek(filename_offset), then read filename_size bytes).
            /// This is not relative to the file table or to the end of the BIF entry array.
            /// </summary>
            public uint FilenameOffset { get { return _filenameOffset; } }

            /// <summary>
            /// Length of the filename in bytes (including null terminator).
            /// </summary>
            public ushort FilenameSize { get { return _filenameSize; } }

            /// <summary>
            /// Drive flags indicating which media contains the BIF file.
            /// Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
            /// Modern distributions typically use 0x0001 (HD) for all files.
            /// </summary>
            public ushort Drives { get { return _drives; } }
            public Key M_Root { get { return m_root; } }
            public Key.FileTable M_Parent { get { return m_parent; } }
        }
        public partial class FileTable : KaitaiStruct
        {
            public static FileTable FromFile(string fileName)
            {
                return new FileTable(new KaitaiStream(fileName));
            }

            public FileTable(KaitaiStream p__io, Key p__parent = null, Key p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<FileEntry>();
                for (var i = 0; i < M_Root.BifCount; i++)
                {
                    _entries.Add(new FileEntry(m_io, this, m_root));
                }
            }
            private List<FileEntry> _entries;
            private Key m_root;
            private Key m_parent;

            /// <summary>
            /// Array of BIF file entries.
            /// </summary>
            public List<FileEntry> Entries { get { return _entries; } }
            public Key M_Root { get { return m_root; } }
            public Key M_Parent { get { return m_parent; } }
        }
        public partial class FilenameTable : KaitaiStruct
        {
            public static FilenameTable FromFile(string fileName)
            {
                return new FilenameTable(new KaitaiStream(fileName));
            }

            public FilenameTable(KaitaiStream p__io, KaitaiStruct p__parent = null, Key p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _filenames = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesFull());
            }
            private string _filenames;
            private Key m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Null-terminated BIF filenames concatenated together.
            /// Each filename is read using the filename_offset and filename_size
            /// from the corresponding file_entry.
            /// </summary>
            public string Filenames { get { return _filenames; } }
            public Key M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        public partial class KeyEntry : KaitaiStruct
        {
            public static KeyEntry FromFile(string fileName)
            {
                return new KeyEntry(new KaitaiStream(fileName));
            }

            public KeyEntry(KaitaiStream p__io, Key.KeyTable p__parent = null, Key p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _resref = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(16));
                _resourceType = ((BiowareTypeIds.XoreosFileTypeId) m_io.ReadU2le());
                _resourceId = m_io.ReadU4le();
            }
            private string _resref;
            private BiowareTypeIds.XoreosFileTypeId _resourceType;
            private uint _resourceId;
            private Key m_root;
            private Key.KeyTable m_parent;

            /// <summary>
            /// Resource filename (ResRef) without extension.
            /// Null-padded, maximum 16 characters.
            /// The game uses this name to access the resource.
            /// </summary>
            public string Resref { get { return _resref; } }

            /// <summary>
            /// Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
            /// `formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).
            /// </summary>
            public BiowareTypeIds.XoreosFileTypeId ResourceType { get { return _resourceType; } }

            /// <summary>
            /// Encoded resource location.
            /// Bits 31-20: BIF index (top 12 bits) - index into file table
            /// Bits 19-0: Resource index (bottom 20 bits) - index within the BIF file
            /// 
            /// Formula: resource_id = (bif_index &lt;&lt; 20) | resource_index
            /// 
            /// Decoding:
            /// - bif_index = (resource_id &gt;&gt; 20) &amp; 0xFFF
            /// - resource_index = resource_id &amp; 0xFFFFF
            /// </summary>
            public uint ResourceId { get { return _resourceId; } }
            public Key M_Root { get { return m_root; } }
            public Key.KeyTable M_Parent { get { return m_parent; } }
        }
        public partial class KeyTable : KaitaiStruct
        {
            public static KeyTable FromFile(string fileName)
            {
                return new KeyTable(new KaitaiStream(fileName));
            }

            public KeyTable(KaitaiStream p__io, Key p__parent = null, Key p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<KeyEntry>();
                for (var i = 0; i < M_Root.KeyCount; i++)
                {
                    _entries.Add(new KeyEntry(m_io, this, m_root));
                }
            }
            private List<KeyEntry> _entries;
            private Key m_root;
            private Key m_parent;

            /// <summary>
            /// Array of resource entries.
            /// </summary>
            public List<KeyEntry> Entries { get { return _entries; } }
            public Key M_Root { get { return m_root; } }
            public Key M_Parent { get { return m_parent; } }
        }
        private bool f_fileTable;
        private FileTable _fileTable;

        /// <summary>
        /// File table containing BIF file entries.
        /// </summary>
        public FileTable FileTable
        {
            get
            {
                if (f_fileTable)
                    return _fileTable;
                f_fileTable = true;
                if (BifCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(FileTableOffset);
                    _fileTable = new FileTable(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _fileTable;
            }
        }
        private bool f_keyTable;
        private KeyTable _keyTable;

        /// <summary>
        /// KEY table containing resource entries.
        /// </summary>
        public KeyTable KeyTable
        {
            get
            {
                if (f_keyTable)
                    return _keyTable;
                f_keyTable = true;
                if (KeyCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(KeyTableOffset);
                    _keyTable = new KeyTable(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _keyTable;
            }
        }
        private string _fileType;
        private string _fileVersion;
        private uint _bifCount;
        private uint _keyCount;
        private uint _fileTableOffset;
        private uint _keyTableOffset;
        private uint _buildYear;
        private uint _buildDay;
        private byte[] _reserved;
        private Key m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File type signature. Must be &quot;KEY &quot; (space-padded).
        /// </summary>
        public string FileType { get { return _fileType; } }

        /// <summary>
        /// File format version. Typically &quot;V1  &quot; or &quot;V1.1&quot;.
        /// </summary>
        public string FileVersion { get { return _fileVersion; } }

        /// <summary>
        /// Number of BIF files referenced by this KEY file.
        /// </summary>
        public uint BifCount { get { return _bifCount; } }

        /// <summary>
        /// Number of resource entries in the KEY table.
        /// </summary>
        public uint KeyCount { get { return _keyCount; } }

        /// <summary>
        /// Byte offset to the file table from the beginning of the file.
        /// </summary>
        public uint FileTableOffset { get { return _fileTableOffset; } }

        /// <summary>
        /// Byte offset to the KEY table from the beginning of the file.
        /// </summary>
        public uint KeyTableOffset { get { return _keyTableOffset; } }

        /// <summary>
        /// Build year (years since 1900).
        /// </summary>
        public uint BuildYear { get { return _buildYear; } }

        /// <summary>
        /// Build day (days since January 1).
        /// </summary>
        public uint BuildDay { get { return _buildDay; } }

        /// <summary>
        /// Reserved padding (usually zeros).
        /// </summary>
        public byte[] Reserved { get { return _reserved; } }
        public Key M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
