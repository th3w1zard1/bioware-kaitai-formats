// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// RIM (Resource Information Manager) files are self-contained archives used for module templates.
    /// RIM files are similar to ERF files but are read-only from the game's perspective. The game
    /// loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
    /// RIM files store all resources inline with metadata, making them self-contained archives.
    /// 
    /// Format Variants:
    /// - Standard RIM: Basic module template files
    /// - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
    /// 
    /// Binary Format (KotOR / PyKotor):
    /// - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
    /// - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
    /// - Key / resource entry table (32 bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
    /// - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
    /// 
    /// Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim">PyKotor wiki — RIM</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128">PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L35-L91">xoreos — `RIMFile::load` + `readResList`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unrim.cpp#L55-L85">xoreos-tools — `unrim` CLI (`main`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/rim.cpp#L43-L84">xoreos-tools — `rim` packer CLI (`main`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html">xoreos-docs — Torlack mod.html (MOD/RIM family)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/RIMObject.ts#L69-L93">KotOR.js — `RIMObject`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs">NickHugi/Kotor.NET — `RIMBinaryStructure`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/rimreader.cpp#L26-L58">reone — `RimReader`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394">xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py">PyKotor — `ResourceType` (tooling superset)</a>
    /// </remarks>
    public partial class Rim : KaitaiStruct
    {
        public static Rim FromFile(string fileName)
        {
            return new Rim(new KaitaiStream(fileName));
        }

        public Rim(KaitaiStream p__io, KaitaiStruct p__parent = null, Rim p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _header = new RimHeader(m_io, this, m_root);
            if (Header.OffsetToResourceTable == 0) {
                _gapBeforeKeyTableImplicit = m_io.ReadBytes(96);
            }
            if (Header.OffsetToResourceTable != 0) {
                _gapBeforeKeyTableExplicit = m_io.ReadBytes(Header.OffsetToResourceTable - 24);
            }
            if (Header.ResourceCount > 0) {
                _resourceEntryTable = new ResourceEntryTable(m_io, this, m_root);
            }
        }
        public partial class ResourceEntry : KaitaiStruct
        {
            public static ResourceEntry FromFile(string fileName)
            {
                return new ResourceEntry(new KaitaiStream(fileName));
            }

            public ResourceEntry(KaitaiStream p__io, Rim.ResourceEntryTable p__parent = null, Rim p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_data = false;
                _read();
            }
            private void _read()
            {
                _resref = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(16));
                _resourceType = ((BiowareTypeIds.XoreosFileTypeId) m_io.ReadU4le());
                _resourceId = m_io.ReadU4le();
                _offsetToData = m_io.ReadU4le();
                _numData = m_io.ReadU4le();
            }
            private bool f_data;
            private List<byte> _data;

            /// <summary>
            /// Raw binary data for this resource (read at specified offset)
            /// </summary>
            public List<byte> Data
            {
                get
                {
                    if (f_data)
                        return _data;
                    f_data = true;
                    long _pos = m_io.Pos;
                    m_io.Seek(OffsetToData);
                    _data = new List<byte>();
                    for (var i = 0; i < NumData; i++)
                    {
                        _data.Add(m_io.ReadU1());
                    }
                    m_io.Seek(_pos);
                    return _data;
                }
            }
            private string _resref;
            private BiowareTypeIds.XoreosFileTypeId _resourceType;
            private uint _resourceId;
            private uint _offsetToData;
            private uint _numData;
            private Rim m_root;
            private Rim.ResourceEntryTable m_parent;

            /// <summary>
            /// Resource filename (ResRef), null-padded to 16 bytes.
            /// Maximum 16 characters. If exactly 16 characters, no null terminator exists.
            /// Resource names can be mixed case, though most are lowercase in practice.
            /// The game engine typically lowercases ResRefs when loading.
            /// </summary>
            public string Resref { get { return _resref; } }

            /// <summary>
            /// Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
            /// Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
            /// </summary>
            public BiowareTypeIds.XoreosFileTypeId ResourceType { get { return _resourceType; } }

            /// <summary>
            /// Resource ID (index, usually sequential).
            /// Typically matches the index of this entry in the resource_entry_table.
            /// Used for internal reference, but not critical for parsing.
            /// </summary>
            public uint ResourceId { get { return _resourceId; } }

            /// <summary>
            /// Byte offset to resource data from the beginning of the file.
            /// Points to the actual binary data for this resource in resource_data_section.
            /// </summary>
            public uint OffsetToData { get { return _offsetToData; } }

            /// <summary>
            /// Size of resource data in bytes (repeat count for raw `data` bytes).
            /// Uncompressed size of the resource.
            /// </summary>
            public uint NumData { get { return _numData; } }
            public Rim M_Root { get { return m_root; } }
            public Rim.ResourceEntryTable M_Parent { get { return m_parent; } }
        }
        public partial class ResourceEntryTable : KaitaiStruct
        {
            public static ResourceEntryTable FromFile(string fileName)
            {
                return new ResourceEntryTable(new KaitaiStream(fileName));
            }

            public ResourceEntryTable(KaitaiStream p__io, Rim p__parent = null, Rim p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<ResourceEntry>();
                for (var i = 0; i < M_Root.Header.ResourceCount; i++)
                {
                    _entries.Add(new ResourceEntry(m_io, this, m_root));
                }
            }
            private List<ResourceEntry> _entries;
            private Rim m_root;
            private Rim m_parent;

            /// <summary>
            /// Array of resource entries, one per resource in the archive
            /// </summary>
            public List<ResourceEntry> Entries { get { return _entries; } }
            public Rim M_Root { get { return m_root; } }
            public Rim M_Parent { get { return m_parent; } }
        }
        public partial class RimHeader : KaitaiStruct
        {
            public static RimHeader FromFile(string fileName)
            {
                return new RimHeader(new KaitaiStream(fileName));
            }

            public RimHeader(KaitaiStream p__io, Rim p__parent = null, Rim p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_hasResources = false;
                _read();
            }
            private void _read()
            {
                _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!(_fileType == "RIM "))
                {
                    throw new ValidationNotEqualError("RIM ", _fileType, m_io, "/types/rim_header/seq/0");
                }
                _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!(_fileVersion == "V1.0"))
                {
                    throw new ValidationNotEqualError("V1.0", _fileVersion, m_io, "/types/rim_header/seq/1");
                }
                _reserved = m_io.ReadU4le();
                _resourceCount = m_io.ReadU4le();
                _offsetToResourceTable = m_io.ReadU4le();
                _offsetToResources = m_io.ReadU4le();
            }
            private bool f_hasResources;
            private bool _hasResources;

            /// <summary>
            /// Whether the RIM file contains any resources
            /// </summary>
            public bool HasResources
            {
                get
                {
                    if (f_hasResources)
                        return _hasResources;
                    f_hasResources = true;
                    _hasResources = (bool) (ResourceCount > 0);
                    return _hasResources;
                }
            }
            private string _fileType;
            private string _fileVersion;
            private uint _reserved;
            private uint _resourceCount;
            private uint _offsetToResourceTable;
            private uint _offsetToResources;
            private Rim m_root;
            private Rim m_parent;

            /// <summary>
            /// File type signature. Must be &quot;RIM &quot; (0x52 0x49 0x4D 0x20).
            /// This identifies the file as a RIM archive.
            /// </summary>
            public string FileType { get { return _fileType; } }

            /// <summary>
            /// File format version. Always &quot;V1.0&quot; for KotOR RIM files.
            /// Other versions may exist in Neverwinter Nights but are not supported in KotOR.
            /// </summary>
            public string FileVersion { get { return _fileVersion; } }

            /// <summary>
            /// Reserved field (typically 0x00000000).
            /// Unknown purpose, but always set to 0 in practice.
            /// </summary>
            public uint Reserved { get { return _reserved; } }

            /// <summary>
            /// Number of resources in the archive. This determines:
            /// - Number of entries in resource_entry_table
            /// - Number of resources in resource_data_section
            /// </summary>
            public uint ResourceCount { get { return _resourceCount; } }

            /// <summary>
            /// Byte offset to the key / resource entry table from the beginning of the file.
            /// 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
            /// When non-zero, this offset is used directly (commonly 120).
            /// </summary>
            public uint OffsetToResourceTable { get { return _offsetToResourceTable; } }

            /// <summary>
            /// Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
            /// taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
            /// </summary>
            public uint OffsetToResources { get { return _offsetToResources; } }
            public Rim M_Root { get { return m_root; } }
            public Rim M_Parent { get { return m_parent; } }
        }
        private RimHeader _header;
        private byte[] _gapBeforeKeyTableImplicit;
        private byte[] _gapBeforeKeyTableExplicit;
        private ResourceEntryTable _resourceEntryTable;
        private Rim m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
        /// </summary>
        public RimHeader Header { get { return _header; } }

        /// <summary>
        /// When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
        /// After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
        /// </summary>
        public byte[] GapBeforeKeyTableImplicit { get { return _gapBeforeKeyTableImplicit; } }

        /// <summary>
        /// When offset_to_resource_table is non-zero, skip until that byte offset (must be &gt;= 24).
        /// Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
        /// </summary>
        public byte[] GapBeforeKeyTableExplicit { get { return _gapBeforeKeyTableExplicit; } }

        /// <summary>
        /// Array of resource entries mapping ResRefs to resource data
        /// </summary>
        public ResourceEntryTable ResourceEntryTable { get { return _resourceEntryTable; } }
        public Rim M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
