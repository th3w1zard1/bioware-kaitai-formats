// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
    /// the paired **KEY** (`KEY.ksy`), not in the BIF.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif">PyKotor wiki — BIF</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L82">xoreos — BIFF::load</a>
    /// </remarks>
    public partial class Bif : KaitaiStruct
    {
        public static Bif FromFile(string fileName)
        {
            return new Bif(new KaitaiStream(fileName));
        }

        public Bif(KaitaiStream p__io, KaitaiStruct p__parent = null, Bif p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            f_varResourceTable = false;
            _read();
        }
        private void _read()
        {
            _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_fileType == "BIFF"))
            {
                throw new ValidationNotEqualError("BIFF", _fileType, m_io, "/seq/0");
            }
            _version = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!( ((_version == "V1  ") || (_version == "V1.1")) ))
            {
                throw new ValidationNotAnyOfError(_version, m_io, "/seq/1");
            }
            _varResCount = m_io.ReadU4le();
            _fixedResCount = m_io.ReadU4le();
            if (!(_fixedResCount == 0))
            {
                throw new ValidationNotEqualError(0, _fixedResCount, m_io, "/seq/3");
            }
            _varTableOffset = m_io.ReadU4le();
        }
        public partial class VarResourceEntry : KaitaiStruct
        {
            public static VarResourceEntry FromFile(string fileName)
            {
                return new VarResourceEntry(new KaitaiStream(fileName));
            }

            public VarResourceEntry(KaitaiStream p__io, Bif.VarResourceTable p__parent = null, Bif p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _resourceId = m_io.ReadU4le();
                _offset = m_io.ReadU4le();
                _fileSize = m_io.ReadU4le();
                _resourceType = ((BiowareTypeIds.XoreosFileTypeId) m_io.ReadU4le());
            }
            private uint _resourceId;
            private uint _offset;
            private uint _fileSize;
            private BiowareTypeIds.XoreosFileTypeId _resourceType;
            private Bif m_root;
            private Bif.VarResourceTable m_parent;

            /// <summary>
            /// Resource ID (matches KEY file entry).
            /// Encodes BIF index (bits 31-20) and resource index (bits 19-0).
            /// Formula: resource_id = (bif_index &lt;&lt; 20) | resource_index
            /// </summary>
            public uint ResourceId { get { return _resourceId; } }

            /// <summary>
            /// Byte offset to resource data in file (absolute file offset).
            /// </summary>
            public uint Offset { get { return _offset; } }

            /// <summary>
            /// Uncompressed size of resource data in bytes.
            /// </summary>
            public uint FileSize { get { return _fileSize; } }

            /// <summary>
            /// Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
            /// read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
            /// `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.
            /// </summary>
            public BiowareTypeIds.XoreosFileTypeId ResourceType { get { return _resourceType; } }
            public Bif M_Root { get { return m_root; } }
            public Bif.VarResourceTable M_Parent { get { return m_parent; } }
        }
        public partial class VarResourceTable : KaitaiStruct
        {
            public static VarResourceTable FromFile(string fileName)
            {
                return new VarResourceTable(new KaitaiStream(fileName));
            }

            public VarResourceTable(KaitaiStream p__io, Bif p__parent = null, Bif p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<VarResourceEntry>();
                for (var i = 0; i < M_Root.VarResCount; i++)
                {
                    _entries.Add(new VarResourceEntry(m_io, this, m_root));
                }
            }
            private List<VarResourceEntry> _entries;
            private Bif m_root;
            private Bif m_parent;

            /// <summary>
            /// Array of variable resource entries.
            /// </summary>
            public List<VarResourceEntry> Entries { get { return _entries; } }
            public Bif M_Root { get { return m_root; } }
            public Bif M_Parent { get { return m_parent; } }
        }
        private bool f_varResourceTable;
        private VarResourceTable _varResourceTable;

        /// <summary>
        /// Variable resource table containing entries for each resource.
        /// </summary>
        public VarResourceTable VarResourceTable
        {
            get
            {
                if (f_varResourceTable)
                    return _varResourceTable;
                f_varResourceTable = true;
                if (VarResCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(VarTableOffset);
                    _varResourceTable = new VarResourceTable(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _varResourceTable;
            }
        }
        private string _fileType;
        private string _version;
        private uint _varResCount;
        private uint _fixedResCount;
        private uint _varTableOffset;
        private Bif m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File type signature. Must be &quot;BIFF&quot; for BIF files.
        /// </summary>
        public string FileType { get { return _fileType; } }

        /// <summary>
        /// File format version. Typically &quot;V1  &quot; or &quot;V1.1&quot;.
        /// </summary>
        public string Version { get { return _version; } }

        /// <summary>
        /// Number of variable-size resources in this file.
        /// </summary>
        public uint VarResCount { get { return _varResCount; } }

        /// <summary>
        /// Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
        /// </summary>
        public uint FixedResCount { get { return _fixedResCount; } }

        /// <summary>
        /// Byte offset to the variable resource table from the beginning of the file.
        /// </summary>
        public uint VarTableOffset { get { return _varTableOffset; } }
        public Bif M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
