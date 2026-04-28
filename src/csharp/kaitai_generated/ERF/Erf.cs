// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
    /// texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
    /// ERF files store both resource names (ResRefs) and data in the same file. They also support
    /// localized strings for descriptions in multiple languages.
    /// 
    /// Format Variants:
    /// - ERF: Generic encapsulated resource file (texture packs, etc.)
    /// - HAK: Hak pak file (contains override resources). Used for mod content distribution
    /// - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
    /// - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`
    /// 
    /// All variants use the same binary format structure, differing only in the file type signature.
    /// 
    /// Archive `resource_type` values use the shared **`bioware_type_ids::xoreos_file_type_id`** enum (xoreos `FileType`); see `formats/Common/bioware_type_ids.ksy`.
    /// 
    /// Binary Format Structure:
    /// - Header (160 bytes): File type, version, entry counts, offsets, build date, description
    /// - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
    ///   include localized module names for the load screen. Each entry contains language_id (u4),
    ///   string_size (u4), and string_data (UTF-8 encoded text)
    /// - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
    ///   - resref (16 bytes, ASCII, null-padded): Resource filename
    ///   - resource_id (u4): Index into resource_list
    ///   - resource_type (u2): Resource type identifier (`bioware_type_ids::xoreos_file_type_id`, xoreos `FileType`)
    ///   - unused (u2): Padding/unused field (typically 0)
    /// - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
    ///   - offset_to_data (u4): Byte offset to resource data from beginning of file
    ///   - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
    /// - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
    ///   in resource_list
    /// 
    /// File Access Pattern:
    /// 1. Read header to get entry_count and offsets
    /// 2. Read key_list to map ResRefs to resource_ids
    /// 3. Use resource_id to index into resource_list
    /// 4. Read resource data from offset_to_data with byte length len_data
    /// 
    /// Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_erf` / `erf_data`, xoreos `ERFFile`, xoreos-tools `unerf` / `erf`, reone `ErfReader`, KotOR.js `ERFObject`, NickHugi `Kotor.NET/Formats/KotorERF`).
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf">PyKotor wiki — ERF</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf">PyKotor wiki — Aurora ERF notes</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py#L22-L316">PyKotor — `io_erf` (Kaitai + legacy + `ERFBinaryWriter.write`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L130">PyKotor — `ERFType` + `ERF` model (opening)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L50-L335">xoreos — ERF type tags + `ERFFile::load` + `readV10Header` start</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unerf.cpp#L69-L106">xoreos-tools — `unerf` CLI (`main`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/erf.cpp#L49-L96">xoreos-tools — `erf` packer CLI (`main`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html">xoreos-docs — Torlack mod.html</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/erfreader.cpp#L26-L92">reone — `ErfReader`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/ERFObject.ts#L70-L115">KotOR.js — `ERFObject`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorERF/ERFBinaryStructure.cs">NickHugi/Kotor.NET — `ERFBinaryStructure`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/ERF_Format.pdf">xoreos-docs — ERF_Format.pdf</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394">xoreos — `enum FileType` (numeric IDs in KEY/ERF/RIM tables)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py">PyKotor — `ResourceType` (tooling superset; overlaps FileType for KotOR rows)</a>
    /// </remarks>
    public partial class Erf : KaitaiStruct
    {
        public static Erf FromFile(string fileName)
        {
            return new Erf(new KaitaiStream(fileName));
        }

        public Erf(KaitaiStream p__io, KaitaiStruct p__parent = null, Erf p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            f_keyList = false;
            f_localizedStringList = false;
            f_resourceList = false;
            _read();
        }
        private void _read()
        {
            _header = new ErfHeader(m_io, this, m_root);
        }
        public partial class ErfHeader : KaitaiStruct
        {
            public static ErfHeader FromFile(string fileName)
            {
                return new ErfHeader(new KaitaiStream(fileName));
            }

            public ErfHeader(KaitaiStream p__io, Erf p__parent = null, Erf p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_isSaveFile = false;
                _read();
            }
            private void _read()
            {
                _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!( ((_fileType == "ERF ") || (_fileType == "MOD ") || (_fileType == "SAV ") || (_fileType == "HAK ")) ))
                {
                    throw new ValidationNotAnyOfError(_fileType, m_io, "/types/erf_header/seq/0");
                }
                _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!(_fileVersion == "V1.0"))
                {
                    throw new ValidationNotEqualError("V1.0", _fileVersion, m_io, "/types/erf_header/seq/1");
                }
                _languageCount = m_io.ReadU4le();
                _localizedStringSize = m_io.ReadU4le();
                _entryCount = m_io.ReadU4le();
                _offsetToLocalizedStringList = m_io.ReadU4le();
                _offsetToKeyList = m_io.ReadU4le();
                _offsetToResourceList = m_io.ReadU4le();
                _buildYear = m_io.ReadU4le();
                _buildDay = m_io.ReadU4le();
                _descriptionStrref = m_io.ReadS4le();
                _reserved = m_io.ReadBytes(116);
            }
            private bool f_isSaveFile;
            private bool _isSaveFile;

            /// <summary>
            /// Heuristic to detect save game files.
            /// Save games use MOD signature but typically have description_strref = 0.
            /// </summary>
            public bool IsSaveFile
            {
                get
                {
                    if (f_isSaveFile)
                        return _isSaveFile;
                    f_isSaveFile = true;
                    _isSaveFile = (bool) ( ((FileType == "MOD ") && (DescriptionStrref == 0)) );
                    return _isSaveFile;
                }
            }
            private string _fileType;
            private string _fileVersion;
            private uint _languageCount;
            private uint _localizedStringSize;
            private uint _entryCount;
            private uint _offsetToLocalizedStringList;
            private uint _offsetToKeyList;
            private uint _offsetToResourceList;
            private uint _buildYear;
            private uint _buildDay;
            private int _descriptionStrref;
            private byte[] _reserved;
            private Erf m_root;
            private Erf m_parent;

            /// <summary>
            /// File type signature. Must be one of:
            /// - &quot;ERF &quot; (0x45 0x52 0x46 0x20) - Generic ERF archive
            /// - &quot;MOD &quot; (0x4D 0x4F 0x44 0x20) - Module file
            /// - &quot;SAV &quot; (0x53 0x41 0x56 0x20) - Save game file
            /// - &quot;HAK &quot; (0x48 0x41 0x4B 0x20) - Hak pak file
            /// </summary>
            public string FileType { get { return _fileType; } }

            /// <summary>
            /// File format version. Always &quot;V1.0&quot; for KotOR ERF files.
            /// Other versions may exist in Neverwinter Nights but are not supported in KotOR.
            /// </summary>
            public string FileVersion { get { return _fileVersion; } }

            /// <summary>
            /// Number of localized string entries. Typically 0 for most ERF files.
            /// MOD files may include localized module names for the load screen.
            /// </summary>
            public uint LanguageCount { get { return _languageCount; } }

            /// <summary>
            /// Total size of localized string data in bytes.
            /// Includes all language entries (language_id + string_size + string_data for each).
            /// </summary>
            public uint LocalizedStringSize { get { return _localizedStringSize; } }

            /// <summary>
            /// Number of resources in the archive. This determines:
            /// - Number of entries in key_list
            /// - Number of entries in resource_list
            /// - Number of resource data blocks stored at various offsets
            /// </summary>
            public uint EntryCount { get { return _entryCount; } }

            /// <summary>
            /// Byte offset to the localized string list from the beginning of the file.
            /// Typically 160 (right after header) if present, or 0 if not present.
            /// </summary>
            public uint OffsetToLocalizedStringList { get { return _offsetToLocalizedStringList; } }

            /// <summary>
            /// Byte offset to the key list from the beginning of the file.
            /// Typically 160 (right after header) if no localized strings, or after localized strings.
            /// </summary>
            public uint OffsetToKeyList { get { return _offsetToKeyList; } }

            /// <summary>
            /// Byte offset to the resource list from the beginning of the file.
            /// Located after the key list.
            /// </summary>
            public uint OffsetToResourceList { get { return _offsetToResourceList; } }

            /// <summary>
            /// Build year (years since 1900).
            /// Example: 103 = year 2003
            /// Primarily informational, used by development tools to track module versions.
            /// </summary>
            public uint BuildYear { get { return _buildYear; } }

            /// <summary>
            /// Build day (days since January 1, with January 1 = day 1).
            /// Example: 247 = September 4th (the 247th day of the year)
            /// Primarily informational, used by development tools to track module versions.
            /// </summary>
            public uint BuildDay { get { return _buildDay; } }

            /// <summary>
            /// Description StrRef (TLK string reference) for the archive description.
            /// Values vary by file type:
            /// - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
            /// - SAV files: 0 (typically no description)
            /// - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
            /// </summary>
            public int DescriptionStrref { get { return _descriptionStrref; } }

            /// <summary>
            /// Reserved padding (usually zeros).
            /// Total header size is 160 bytes:
            /// file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
            /// entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
            /// offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
            /// reserved (116) = 160 bytes
            /// </summary>
            public byte[] Reserved { get { return _reserved; } }
            public Erf M_Root { get { return m_root; } }
            public Erf M_Parent { get { return m_parent; } }
        }
        public partial class KeyEntry : KaitaiStruct
        {
            public static KeyEntry FromFile(string fileName)
            {
                return new KeyEntry(new KaitaiStream(fileName));
            }

            public KeyEntry(KaitaiStream p__io, Erf.KeyList p__parent = null, Erf p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _resref = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(16));
                _resourceId = m_io.ReadU4le();
                _resourceType = ((BiowareTypeIds.XoreosFileTypeId) m_io.ReadU2le());
                _unused = m_io.ReadU2le();
            }
            private string _resref;
            private uint _resourceId;
            private BiowareTypeIds.XoreosFileTypeId _resourceType;
            private ushort _unused;
            private Erf m_root;
            private Erf.KeyList m_parent;

            /// <summary>
            /// Resource filename (ResRef), null-padded to 16 bytes.
            /// Maximum 16 characters. If exactly 16 characters, no null terminator exists.
            /// Resource names can be mixed case, though most are lowercase in practice.
            /// </summary>
            public string Resref { get { return _resref; } }

            /// <summary>
            /// Resource ID (index into resource_list).
            /// Maps this key entry to the corresponding resource entry.
            /// </summary>
            public uint ResourceId { get { return _resourceId; } }

            /// <summary>
            /// Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
            /// Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
            /// </summary>
            public BiowareTypeIds.XoreosFileTypeId ResourceType { get { return _resourceType; } }

            /// <summary>
            /// Padding/unused field (typically 0)
            /// </summary>
            public ushort Unused { get { return _unused; } }
            public Erf M_Root { get { return m_root; } }
            public Erf.KeyList M_Parent { get { return m_parent; } }
        }
        public partial class KeyList : KaitaiStruct
        {
            public static KeyList FromFile(string fileName)
            {
                return new KeyList(new KaitaiStream(fileName));
            }

            public KeyList(KaitaiStream p__io, Erf p__parent = null, Erf p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<KeyEntry>();
                for (var i = 0; i < M_Root.Header.EntryCount; i++)
                {
                    _entries.Add(new KeyEntry(m_io, this, m_root));
                }
            }
            private List<KeyEntry> _entries;
            private Erf m_root;
            private Erf m_parent;

            /// <summary>
            /// Array of key entries mapping ResRefs to resource indices
            /// </summary>
            public List<KeyEntry> Entries { get { return _entries; } }
            public Erf M_Root { get { return m_root; } }
            public Erf M_Parent { get { return m_parent; } }
        }
        public partial class LocalizedStringEntry : KaitaiStruct
        {
            public static LocalizedStringEntry FromFile(string fileName)
            {
                return new LocalizedStringEntry(new KaitaiStream(fileName));
            }

            public LocalizedStringEntry(KaitaiStream p__io, Erf.LocalizedStringList p__parent = null, Erf p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _languageId = m_io.ReadU4le();
                _stringSize = m_io.ReadU4le();
                _stringData = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytes(StringSize));
            }
            private uint _languageId;
            private uint _stringSize;
            private string _stringData;
            private Erf m_root;
            private Erf.LocalizedStringList m_parent;

            /// <summary>
            /// Language identifier:
            /// - 0 = English
            /// - 1 = French
            /// - 2 = German
            /// - 3 = Italian
            /// - 4 = Spanish
            /// - 5 = Polish
            /// - Additional languages for Asian releases
            /// </summary>
            public uint LanguageId { get { return _languageId; } }

            /// <summary>
            /// Length of string data in bytes
            /// </summary>
            public uint StringSize { get { return _stringSize; } }

            /// <summary>
            /// UTF-8 encoded text string
            /// </summary>
            public string StringData { get { return _stringData; } }
            public Erf M_Root { get { return m_root; } }
            public Erf.LocalizedStringList M_Parent { get { return m_parent; } }
        }
        public partial class LocalizedStringList : KaitaiStruct
        {
            public static LocalizedStringList FromFile(string fileName)
            {
                return new LocalizedStringList(new KaitaiStream(fileName));
            }

            public LocalizedStringList(KaitaiStream p__io, Erf p__parent = null, Erf p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<LocalizedStringEntry>();
                for (var i = 0; i < M_Root.Header.LanguageCount; i++)
                {
                    _entries.Add(new LocalizedStringEntry(m_io, this, m_root));
                }
            }
            private List<LocalizedStringEntry> _entries;
            private Erf m_root;
            private Erf m_parent;

            /// <summary>
            /// Array of localized string entries, one per language
            /// </summary>
            public List<LocalizedStringEntry> Entries { get { return _entries; } }
            public Erf M_Root { get { return m_root; } }
            public Erf M_Parent { get { return m_parent; } }
        }
        public partial class ResourceEntry : KaitaiStruct
        {
            public static ResourceEntry FromFile(string fileName)
            {
                return new ResourceEntry(new KaitaiStream(fileName));
            }

            public ResourceEntry(KaitaiStream p__io, Erf.ResourceList p__parent = null, Erf p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_data = false;
                _read();
            }
            private void _read()
            {
                _offsetToData = m_io.ReadU4le();
                _lenData = m_io.ReadU4le();
            }
            private bool f_data;
            private byte[] _data;

            /// <summary>
            /// Raw binary data for this resource
            /// </summary>
            public byte[] Data
            {
                get
                {
                    if (f_data)
                        return _data;
                    f_data = true;
                    long _pos = m_io.Pos;
                    m_io.Seek(OffsetToData);
                    _data = m_io.ReadBytes(LenData);
                    m_io.Seek(_pos);
                    return _data;
                }
            }
            private uint _offsetToData;
            private uint _lenData;
            private Erf m_root;
            private Erf.ResourceList m_parent;

            /// <summary>
            /// Byte offset to resource data from the beginning of the file.
            /// Points to the actual binary data for this resource.
            /// </summary>
            public uint OffsetToData { get { return _offsetToData; } }

            /// <summary>
            /// Size of resource data in bytes.
            /// Uncompressed size of the resource.
            /// </summary>
            public uint LenData { get { return _lenData; } }
            public Erf M_Root { get { return m_root; } }
            public Erf.ResourceList M_Parent { get { return m_parent; } }
        }
        public partial class ResourceList : KaitaiStruct
        {
            public static ResourceList FromFile(string fileName)
            {
                return new ResourceList(new KaitaiStream(fileName));
            }

            public ResourceList(KaitaiStream p__io, Erf p__parent = null, Erf p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<ResourceEntry>();
                for (var i = 0; i < M_Root.Header.EntryCount; i++)
                {
                    _entries.Add(new ResourceEntry(m_io, this, m_root));
                }
            }
            private List<ResourceEntry> _entries;
            private Erf m_root;
            private Erf m_parent;

            /// <summary>
            /// Array of resource entries containing offset and size information
            /// </summary>
            public List<ResourceEntry> Entries { get { return _entries; } }
            public Erf M_Root { get { return m_root; } }
            public Erf M_Parent { get { return m_parent; } }
        }
        private bool f_keyList;
        private KeyList _keyList;

        /// <summary>
        /// Array of key entries mapping ResRefs to resource indices
        /// </summary>
        public KeyList KeyList
        {
            get
            {
                if (f_keyList)
                    return _keyList;
                f_keyList = true;
                long _pos = m_io.Pos;
                m_io.Seek(Header.OffsetToKeyList);
                _keyList = new KeyList(m_io, this, m_root);
                m_io.Seek(_pos);
                return _keyList;
            }
        }
        private bool f_localizedStringList;
        private LocalizedStringList _localizedStringList;

        /// <summary>
        /// Optional localized string entries for multi-language descriptions
        /// </summary>
        public LocalizedStringList LocalizedStringList
        {
            get
            {
                if (f_localizedStringList)
                    return _localizedStringList;
                f_localizedStringList = true;
                if (Header.LanguageCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(Header.OffsetToLocalizedStringList);
                    _localizedStringList = new LocalizedStringList(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _localizedStringList;
            }
        }
        private bool f_resourceList;
        private ResourceList _resourceList;

        /// <summary>
        /// Array of resource entries containing offset and size information
        /// </summary>
        public ResourceList ResourceList
        {
            get
            {
                if (f_resourceList)
                    return _resourceList;
                f_resourceList = true;
                long _pos = m_io.Pos;
                m_io.Seek(Header.OffsetToResourceList);
                _resourceList = new ResourceList(m_io, this, m_root);
                m_io.Seek(_pos);
                return _resourceList;
            }
        }
        private ErfHeader _header;
        private Erf m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// ERF file header (160 bytes)
        /// </summary>
        public ErfHeader Header { get { return _header; } }
        public Erf M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
