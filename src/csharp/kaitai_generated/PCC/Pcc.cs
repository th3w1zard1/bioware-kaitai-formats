// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
    /// tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).
    /// 
    /// **Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60">xoreos — `FileType` enum start (Aurora/BioWare family IDs; **PCC/Unreal packages are not in this table** — included only as canonical upstream anchor for “what this repo’s xoreos stack is”)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/ME3Tweaks/LegendaryExplorer/wiki/PCC-File-Format">ME3Tweaks — PCC file format</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/ME3Tweaks/LegendaryExplorer/wiki/Package-Handling">ME3Tweaks — Package handling (export/import tables, UE3-era BioWare packages)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/docs/XOREOS_FORMAT_COVERAGE.md">In-tree — coverage matrix (PCC is out-of-xoreos Aurora scope; see table)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (KotOR-era PDFs; PCC is Mass Effect / UE3 — use LegendaryExplorer wiki as wire authority)</a>
    /// </remarks>
    public partial class Pcc : KaitaiStruct
    {
        public static Pcc FromFile(string fileName)
        {
            return new Pcc(new KaitaiStream(fileName));
        }

        public Pcc(KaitaiStream p__io, KaitaiStruct p__parent = null, Pcc p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            f_compressionType = false;
            f_exportTable = false;
            f_importTable = false;
            f_isCompressed = false;
            f_nameTable = false;
            _read();
        }
        private void _read()
        {
            _header = new FileHeader(m_io, this, m_root);
        }
        public partial class ExportEntry : KaitaiStruct
        {
            public static ExportEntry FromFile(string fileName)
            {
                return new ExportEntry(new KaitaiStream(fileName));
            }

            public ExportEntry(KaitaiStream p__io, Pcc.ExportTable p__parent = null, Pcc p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _classIndex = m_io.ReadS4le();
                _superClassIndex = m_io.ReadS4le();
                _link = m_io.ReadS4le();
                _objectNameIndex = m_io.ReadS4le();
                _objectNameNumber = m_io.ReadS4le();
                _archetypeIndex = m_io.ReadS4le();
                _objectFlags = m_io.ReadU8le();
                _dataSize = m_io.ReadU4le();
                _dataOffset = m_io.ReadU4le();
                _unknown1 = m_io.ReadU4le();
                _numComponents = m_io.ReadS4le();
                _unknown2 = m_io.ReadU4le();
                _guid = new Guid(m_io, this, m_root);
                if (NumComponents > 0) {
                    _components = new List<int>();
                    for (var i = 0; i < NumComponents; i++)
                    {
                        _components.Add(m_io.ReadS4le());
                    }
                }
            }
            private int _classIndex;
            private int _superClassIndex;
            private int _link;
            private int _objectNameIndex;
            private int _objectNameNumber;
            private int _archetypeIndex;
            private ulong _objectFlags;
            private uint _dataSize;
            private uint _dataOffset;
            private uint _unknown1;
            private int _numComponents;
            private uint _unknown2;
            private Guid _guid;
            private List<int> _components;
            private Pcc m_root;
            private Pcc.ExportTable m_parent;

            /// <summary>
            /// Object index for the class.
            /// Negative = import table index
            /// Positive = export table index
            /// Zero = no class
            /// </summary>
            public int ClassIndex { get { return _classIndex; } }

            /// <summary>
            /// Object index for the super class.
            /// Negative = import table index
            /// Positive = export table index
            /// Zero = no super class
            /// </summary>
            public int SuperClassIndex { get { return _superClassIndex; } }

            /// <summary>
            /// Link to other objects (internal reference).
            /// </summary>
            public int Link { get { return _link; } }

            /// <summary>
            /// Index into name table for the object name.
            /// </summary>
            public int ObjectNameIndex { get { return _objectNameIndex; } }

            /// <summary>
            /// Object name number (for duplicate names).
            /// </summary>
            public int ObjectNameNumber { get { return _objectNameNumber; } }

            /// <summary>
            /// Object index for the archetype.
            /// Negative = import table index
            /// Positive = export table index
            /// Zero = no archetype
            /// </summary>
            public int ArchetypeIndex { get { return _archetypeIndex; } }

            /// <summary>
            /// Object flags bitfield (64-bit).
            /// </summary>
            public ulong ObjectFlags { get { return _objectFlags; } }

            /// <summary>
            /// Size of the export data in bytes.
            /// </summary>
            public uint DataSize { get { return _dataSize; } }

            /// <summary>
            /// Byte offset to the export data from the beginning of the file.
            /// </summary>
            public uint DataOffset { get { return _dataOffset; } }

            /// <summary>
            /// Unknown field.
            /// </summary>
            public uint Unknown1 { get { return _unknown1; } }

            /// <summary>
            /// Number of component entries (can be negative).
            /// </summary>
            public int NumComponents { get { return _numComponents; } }

            /// <summary>
            /// Unknown field.
            /// </summary>
            public uint Unknown2 { get { return _unknown2; } }

            /// <summary>
            /// GUID for this export object.
            /// </summary>
            public Guid Guid { get { return _guid; } }

            /// <summary>
            /// Array of component indices.
            /// Only present if num_components &gt; 0.
            /// </summary>
            public List<int> Components { get { return _components; } }
            public Pcc M_Root { get { return m_root; } }
            public Pcc.ExportTable M_Parent { get { return m_parent; } }
        }
        public partial class ExportTable : KaitaiStruct
        {
            public static ExportTable FromFile(string fileName)
            {
                return new ExportTable(new KaitaiStream(fileName));
            }

            public ExportTable(KaitaiStream p__io, Pcc p__parent = null, Pcc p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<ExportEntry>();
                for (var i = 0; i < M_Root.Header.ExportCount; i++)
                {
                    _entries.Add(new ExportEntry(m_io, this, m_root));
                }
            }
            private List<ExportEntry> _entries;
            private Pcc m_root;
            private Pcc m_parent;

            /// <summary>
            /// Array of export entries.
            /// </summary>
            public List<ExportEntry> Entries { get { return _entries; } }
            public Pcc M_Root { get { return m_root; } }
            public Pcc M_Parent { get { return m_parent; } }
        }
        public partial class FileHeader : KaitaiStruct
        {
            public static FileHeader FromFile(string fileName)
            {
                return new FileHeader(new KaitaiStream(fileName));
            }

            public FileHeader(KaitaiStream p__io, Pcc p__parent = null, Pcc p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _magic = m_io.ReadU4le();
                if (!(_magic == 2653586369))
                {
                    throw new ValidationNotEqualError(2653586369, _magic, m_io, "/types/file_header/seq/0");
                }
                _version = m_io.ReadU4le();
                _licenseeVersion = m_io.ReadU4le();
                _headerSize = m_io.ReadS4le();
                _packageName = System.Text.Encoding.GetEncoding("UTF-16LE").GetString(m_io.ReadBytes(10));
                _packageFlags = m_io.ReadU4le();
                _packageType = ((BiowareCommon.BiowarePccPackageKind) m_io.ReadU4le());
                _nameCount = m_io.ReadU4le();
                _nameTableOffset = m_io.ReadU4le();
                _exportCount = m_io.ReadU4le();
                _exportTableOffset = m_io.ReadU4le();
                _importCount = m_io.ReadU4le();
                _importTableOffset = m_io.ReadU4le();
                _dependOffset = m_io.ReadU4le();
                _dependCount = m_io.ReadU4le();
                _guidPart1 = m_io.ReadU4le();
                _guidPart2 = m_io.ReadU4le();
                _guidPart3 = m_io.ReadU4le();
                _guidPart4 = m_io.ReadU4le();
                _generations = m_io.ReadU4le();
                _exportCountDup = m_io.ReadU4le();
                _nameCountDup = m_io.ReadU4le();
                _unknown1 = m_io.ReadU4le();
                _engineVersion = m_io.ReadU4le();
                _cookerVersion = m_io.ReadU4le();
                _compressionFlags = m_io.ReadU4le();
                _packageSource = m_io.ReadU4le();
                _compressionType = ((BiowareCommon.BiowarePccCompressionCodec) m_io.ReadU4le());
                _chunkCount = m_io.ReadU4le();
            }
            private uint _magic;
            private uint _version;
            private uint _licenseeVersion;
            private int _headerSize;
            private string _packageName;
            private uint _packageFlags;
            private BiowareCommon.BiowarePccPackageKind _packageType;
            private uint _nameCount;
            private uint _nameTableOffset;
            private uint _exportCount;
            private uint _exportTableOffset;
            private uint _importCount;
            private uint _importTableOffset;
            private uint _dependOffset;
            private uint _dependCount;
            private uint _guidPart1;
            private uint _guidPart2;
            private uint _guidPart3;
            private uint _guidPart4;
            private uint _generations;
            private uint _exportCountDup;
            private uint _nameCountDup;
            private uint _unknown1;
            private uint _engineVersion;
            private uint _cookerVersion;
            private uint _compressionFlags;
            private uint _packageSource;
            private BiowareCommon.BiowarePccCompressionCodec _compressionType;
            private uint _chunkCount;
            private Pcc m_root;
            private Pcc m_parent;

            /// <summary>
            /// Magic number identifying PCC format. Must be 0x9E2A83C1.
            /// </summary>
            public uint Magic { get { return _magic; } }

            /// <summary>
            /// File format version.
            /// Encoded as: (major &lt;&lt; 16) | (minor &lt;&lt; 8) | patch
            /// Example: 0xC202AC = 194/684 (major=194, minor=684)
            /// </summary>
            public uint Version { get { return _version; } }

            /// <summary>
            /// Licensee-specific version field (typically 0x67C).
            /// </summary>
            public uint LicenseeVersion { get { return _licenseeVersion; } }

            /// <summary>
            /// Header size field (typically -5 = 0xFFFFFFFB).
            /// </summary>
            public int HeaderSize { get { return _headerSize; } }

            /// <summary>
            /// Package name (typically &quot;None&quot; = 0x4E006F006E006500).
            /// </summary>
            public string PackageName { get { return _packageName; } }

            /// <summary>
            /// Package flags bitfield.
            /// Bit 25 (0x2000000): Compressed package
            /// Bit 20 (0x100000): ME3Explorer edited format flag
            /// Other bits: Various package attributes
            /// </summary>
            public uint PackageFlags { get { return _packageFlags; } }

            /// <summary>
            /// Package type indicator (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_package_kind`
            /// (LegendaryExplorer PCC wiki).
            /// </summary>
            public BiowareCommon.BiowarePccPackageKind PackageType { get { return _packageType; } }

            /// <summary>
            /// Number of entries in the name table.
            /// </summary>
            public uint NameCount { get { return _nameCount; } }

            /// <summary>
            /// Byte offset to the name table from the beginning of the file.
            /// </summary>
            public uint NameTableOffset { get { return _nameTableOffset; } }

            /// <summary>
            /// Number of entries in the export table.
            /// </summary>
            public uint ExportCount { get { return _exportCount; } }

            /// <summary>
            /// Byte offset to the export table from the beginning of the file.
            /// </summary>
            public uint ExportTableOffset { get { return _exportTableOffset; } }

            /// <summary>
            /// Number of entries in the import table.
            /// </summary>
            public uint ImportCount { get { return _importCount; } }

            /// <summary>
            /// Byte offset to the import table from the beginning of the file.
            /// </summary>
            public uint ImportTableOffset { get { return _importTableOffset; } }

            /// <summary>
            /// Offset to dependency table (typically 0x664).
            /// </summary>
            public uint DependOffset { get { return _dependOffset; } }

            /// <summary>
            /// Number of dependencies (typically 0x67C).
            /// </summary>
            public uint DependCount { get { return _dependCount; } }

            /// <summary>
            /// First 32 bits of package GUID.
            /// </summary>
            public uint GuidPart1 { get { return _guidPart1; } }

            /// <summary>
            /// Second 32 bits of package GUID.
            /// </summary>
            public uint GuidPart2 { get { return _guidPart2; } }

            /// <summary>
            /// Third 32 bits of package GUID.
            /// </summary>
            public uint GuidPart3 { get { return _guidPart3; } }

            /// <summary>
            /// Fourth 32 bits of package GUID.
            /// </summary>
            public uint GuidPart4 { get { return _guidPart4; } }

            /// <summary>
            /// Number of generation entries.
            /// </summary>
            public uint Generations { get { return _generations; } }

            /// <summary>
            /// Duplicate export count (should match export_count).
            /// </summary>
            public uint ExportCountDup { get { return _exportCountDup; } }

            /// <summary>
            /// Duplicate name count (should match name_count).
            /// </summary>
            public uint NameCountDup { get { return _nameCountDup; } }

            /// <summary>
            /// Unknown field (typically 0x0).
            /// </summary>
            public uint Unknown1 { get { return _unknown1; } }

            /// <summary>
            /// Engine version (typically 0x18EF = 6383).
            /// </summary>
            public uint EngineVersion { get { return _engineVersion; } }

            /// <summary>
            /// Cooker version (typically 0x3006B = 196715).
            /// </summary>
            public uint CookerVersion { get { return _cookerVersion; } }

            /// <summary>
            /// Compression flags (typically 0x15330000).
            /// </summary>
            public uint CompressionFlags { get { return _compressionFlags; } }

            /// <summary>
            /// Package source identifier (typically 0x8AA0000).
            /// </summary>
            public uint PackageSource { get { return _packageSource; } }

            /// <summary>
            /// Compression codec when package is compressed (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_compression_codec`
            /// (LegendaryExplorer PCC wiki). Unused / undefined when uncompressed.
            /// </summary>
            public BiowareCommon.BiowarePccCompressionCodec CompressionType { get { return _compressionType; } }

            /// <summary>
            /// Number of compressed chunks (0 for uncompressed, 1 for compressed).
            /// If &gt; 0, file uses compressed structure with chunks.
            /// </summary>
            public uint ChunkCount { get { return _chunkCount; } }
            public Pcc M_Root { get { return m_root; } }
            public Pcc M_Parent { get { return m_parent; } }
        }
        public partial class Guid : KaitaiStruct
        {
            public static Guid FromFile(string fileName)
            {
                return new Guid(new KaitaiStream(fileName));
            }

            public Guid(KaitaiStream p__io, Pcc.ExportEntry p__parent = null, Pcc p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _part1 = m_io.ReadU4le();
                _part2 = m_io.ReadU4le();
                _part3 = m_io.ReadU4le();
                _part4 = m_io.ReadU4le();
            }
            private uint _part1;
            private uint _part2;
            private uint _part3;
            private uint _part4;
            private Pcc m_root;
            private Pcc.ExportEntry m_parent;

            /// <summary>
            /// First 32 bits of GUID.
            /// </summary>
            public uint Part1 { get { return _part1; } }

            /// <summary>
            /// Second 32 bits of GUID.
            /// </summary>
            public uint Part2 { get { return _part2; } }

            /// <summary>
            /// Third 32 bits of GUID.
            /// </summary>
            public uint Part3 { get { return _part3; } }

            /// <summary>
            /// Fourth 32 bits of GUID.
            /// </summary>
            public uint Part4 { get { return _part4; } }
            public Pcc M_Root { get { return m_root; } }
            public Pcc.ExportEntry M_Parent { get { return m_parent; } }
        }
        public partial class ImportEntry : KaitaiStruct
        {
            public static ImportEntry FromFile(string fileName)
            {
                return new ImportEntry(new KaitaiStream(fileName));
            }

            public ImportEntry(KaitaiStream p__io, Pcc.ImportTable p__parent = null, Pcc p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _packageNameIndex = m_io.ReadS8le();
                _classNameIndex = m_io.ReadS4le();
                _link = m_io.ReadS8le();
                _importNameIndex = m_io.ReadS8le();
            }
            private long _packageNameIndex;
            private int _classNameIndex;
            private long _link;
            private long _importNameIndex;
            private Pcc m_root;
            private Pcc.ImportTable m_parent;

            /// <summary>
            /// Index into name table for package name.
            /// Negative value indicates import from external package.
            /// Positive value indicates import from this package.
            /// </summary>
            public long PackageNameIndex { get { return _packageNameIndex; } }

            /// <summary>
            /// Index into name table for class name.
            /// </summary>
            public int ClassNameIndex { get { return _classNameIndex; } }

            /// <summary>
            /// Link to import/export table entry.
            /// Used to resolve the actual object reference.
            /// </summary>
            public long Link { get { return _link; } }

            /// <summary>
            /// Index into name table for the imported object name.
            /// </summary>
            public long ImportNameIndex { get { return _importNameIndex; } }
            public Pcc M_Root { get { return m_root; } }
            public Pcc.ImportTable M_Parent { get { return m_parent; } }
        }
        public partial class ImportTable : KaitaiStruct
        {
            public static ImportTable FromFile(string fileName)
            {
                return new ImportTable(new KaitaiStream(fileName));
            }

            public ImportTable(KaitaiStream p__io, Pcc p__parent = null, Pcc p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<ImportEntry>();
                for (var i = 0; i < M_Root.Header.ImportCount; i++)
                {
                    _entries.Add(new ImportEntry(m_io, this, m_root));
                }
            }
            private List<ImportEntry> _entries;
            private Pcc m_root;
            private Pcc m_parent;

            /// <summary>
            /// Array of import entries.
            /// </summary>
            public List<ImportEntry> Entries { get { return _entries; } }
            public Pcc M_Root { get { return m_root; } }
            public Pcc M_Parent { get { return m_parent; } }
        }
        public partial class NameEntry : KaitaiStruct
        {
            public static NameEntry FromFile(string fileName)
            {
                return new NameEntry(new KaitaiStream(fileName));
            }

            public NameEntry(KaitaiStream p__io, Pcc.NameTable p__parent = null, Pcc p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_absLength = false;
                f_nameSize = false;
                _read();
            }
            private void _read()
            {
                _length = m_io.ReadS4le();
                _name = System.Text.Encoding.GetEncoding("UTF-16LE").GetString(m_io.ReadBytes((Length < 0 ? -(Length) : Length) * 2));
            }
            private bool f_absLength;
            private int _absLength;

            /// <summary>
            /// Absolute value of length for size calculation
            /// </summary>
            public int AbsLength
            {
                get
                {
                    if (f_absLength)
                        return _absLength;
                    f_absLength = true;
                    _absLength = (int) ((Length < 0 ? -(Length) : Length));
                    return _absLength;
                }
            }
            private bool f_nameSize;
            private int _nameSize;

            /// <summary>
            /// Size of name string in bytes (absolute length * 2 bytes per WCHAR)
            /// </summary>
            public int NameSize
            {
                get
                {
                    if (f_nameSize)
                        return _nameSize;
                    f_nameSize = true;
                    _nameSize = (int) (AbsLength * 2);
                    return _nameSize;
                }
            }
            private int _length;
            private string _name;
            private Pcc m_root;
            private Pcc.NameTable m_parent;

            /// <summary>
            /// Length of the name string in characters (signed).
            /// Negative value indicates the number of WCHAR characters.
            /// Positive value is also valid but less common.
            /// </summary>
            public int Length { get { return _length; } }

            /// <summary>
            /// Name string encoded as UTF-16LE (WCHAR).
            /// Size is absolute value of length * 2 bytes per character.
            /// Negative length indicates WCHAR count (use absolute value).
            /// </summary>
            public string Name { get { return _name; } }
            public Pcc M_Root { get { return m_root; } }
            public Pcc.NameTable M_Parent { get { return m_parent; } }
        }
        public partial class NameTable : KaitaiStruct
        {
            public static NameTable FromFile(string fileName)
            {
                return new NameTable(new KaitaiStream(fileName));
            }

            public NameTable(KaitaiStream p__io, Pcc p__parent = null, Pcc p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<NameEntry>();
                for (var i = 0; i < M_Root.Header.NameCount; i++)
                {
                    _entries.Add(new NameEntry(m_io, this, m_root));
                }
            }
            private List<NameEntry> _entries;
            private Pcc m_root;
            private Pcc m_parent;

            /// <summary>
            /// Array of name entries.
            /// </summary>
            public List<NameEntry> Entries { get { return _entries; } }
            public Pcc M_Root { get { return m_root; } }
            public Pcc M_Parent { get { return m_parent; } }
        }
        private bool f_compressionType;
        private BiowareCommon.BiowarePccCompressionCodec _compressionType;

        /// <summary>
        /// Compression algorithm used (0=None, 1=Zlib, 2=LZO).
        /// </summary>
        public BiowareCommon.BiowarePccCompressionCodec CompressionType
        {
            get
            {
                if (f_compressionType)
                    return _compressionType;
                f_compressionType = true;
                _compressionType = (BiowareCommon.BiowarePccCompressionCodec) (Header.CompressionType);
                return _compressionType;
            }
        }
        private bool f_exportTable;
        private ExportTable _exportTable;

        /// <summary>
        /// Table containing all objects exported from this package.
        /// </summary>
        public ExportTable ExportTable
        {
            get
            {
                if (f_exportTable)
                    return _exportTable;
                f_exportTable = true;
                if (Header.ExportCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(Header.ExportTableOffset);
                    _exportTable = new ExportTable(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _exportTable;
            }
        }
        private bool f_importTable;
        private ImportTable _importTable;

        /// <summary>
        /// Table containing references to external packages and classes.
        /// </summary>
        public ImportTable ImportTable
        {
            get
            {
                if (f_importTable)
                    return _importTable;
                f_importTable = true;
                if (Header.ImportCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(Header.ImportTableOffset);
                    _importTable = new ImportTable(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _importTable;
            }
        }
        private bool f_isCompressed;
        private bool _isCompressed;

        /// <summary>
        /// True if package uses compressed chunks (bit 25 of package_flags).
        /// </summary>
        public bool IsCompressed
        {
            get
            {
                if (f_isCompressed)
                    return _isCompressed;
                f_isCompressed = true;
                _isCompressed = (bool) ((Header.PackageFlags & 33554432) != 0);
                return _isCompressed;
            }
        }
        private bool f_nameTable;
        private NameTable _nameTable;

        /// <summary>
        /// Table containing all string names used in the package.
        /// </summary>
        public NameTable NameTable
        {
            get
            {
                if (f_nameTable)
                    return _nameTable;
                f_nameTable = true;
                if (Header.NameCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(Header.NameTableOffset);
                    _nameTable = new NameTable(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _nameTable;
            }
        }
        private FileHeader _header;
        private Pcc m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File header containing format metadata and table offsets.
        /// </summary>
        public FileHeader Header { get { return _header; } }
        public Pcc M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
