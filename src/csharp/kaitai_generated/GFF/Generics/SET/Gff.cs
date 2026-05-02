// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// BioWare **GFF** (Generic File Format): hierarchical binary game data (KotOR/TSL and Aurora lineage; GFF4 for
    /// DA / Eclipse-class payloads in this `.ksy`). Human-readable tables and tutorials: PyKotor wiki (**Further
    /// reading**). Wire `gff_field_type` enum: `formats/Common/bioware_gff_common.ksy`.
    /// 
    /// **Aurora prefix (8 bytes):** `u4be` FourCC + `u4be` version (`AuroraFile::readHeader` — `meta.xref`
    /// `xoreos_aurorafile_read_header`).
    /// **GFF3:** Twelve LE `u32` counts/offsets as `gff_header_tail` under `gff3_after_aurora`, then lazy arena
    /// `instances`.
    /// **GFF4:** When version is `V4.0` / `V4.1`, the next field is `platform_id` (`u4be`), not GFF3 `struct_offset`
    /// (`gff4_after_aurora`; partial GFF4 graph — `tail` blob still opaque).
    /// 
    /// **GFF3 wire summary:**
    /// - Root `file` → `gff_union_file`; arenas addressed via `gff3.header` offsets.
    /// - 12-byte struct rows (`struct_entry`), 12-byte field rows (`field_entry`); root struct index **0**; single-field
    ///   vs multi-field vs lists per wiki *Struct array* / *Field indices* / *List indices*.
    /// 
    /// **Observed behavior:** engine record names and addresses live on the `seq` / `types` nodes they justify, not in this blurb.
    /// 
    /// **Pinned URLs and tool history:** `meta.xref` (alphabetical keys). Coverage matrix: `docs/XOREOS_FORMAT_COVERAGE.md`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format">PyKotor wiki — GFF binary format</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — GFF3File::Header::read</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181">xoreos — GFF3File load (post-header struct/field arena wiring)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72">xoreos — GFF4File::Header::read</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L151-L164">xoreos — GFF4File::load entry</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114">PyKotor — GFFBinaryReader.load</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225">reone — GffReader</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts#L152-L221">KotOR.js — GFFObject.parse</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp#L86-L238">xoreos-tools — GFF3 load pipeline (shared with CLIs)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176">xoreos-tools — `gffdumper`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60">xoreos-tools — `gffcreator`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf</a>
    /// </remarks>
    public partial class Gff : KaitaiStruct
    {
        public static Gff FromFile(string fileName)
        {
            return new Gff(new KaitaiStream(fileName));
        }

        public Gff(KaitaiStream p__io, KaitaiStruct p__parent = null, Gff p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _file = new GffUnionFile(m_io, this, m_root);
        }

        /// <summary>
        /// Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
        /// Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
        /// </summary>
        public partial class FieldArray : KaitaiStruct
        {
            public static FieldArray FromFile(string fileName)
            {
                return new FieldArray(new KaitaiStream(fileName));
            }

            public FieldArray(KaitaiStream p__io, Gff.Gff3AfterAurora p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<FieldEntry>();
                for (var i = 0; i < M_Root.File.Gff3.Header.FieldCount; i++)
                {
                    _entries.Add(new FieldEntry(m_io, this, m_root));
                }
            }
            private List<FieldEntry> _entries;
            private Gff m_root;
            private Gff.Gff3AfterAurora m_parent;

            /// <summary>
            /// Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
            /// Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).
            /// </summary>
            public List<FieldEntry> Entries { get { return _entries; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.Gff3AfterAurora M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
        /// </summary>
        public partial class FieldData : KaitaiStruct
        {
            public static FieldData FromFile(string fileName)
            {
                return new FieldData(new KaitaiStream(fileName));
            }

            public FieldData(KaitaiStream p__io, Gff.Gff3AfterAurora p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _rawData = m_io.ReadBytes(M_Root.File.Gff3.Header.FieldDataCount);
            }
            private byte[] _rawData;
            private Gff m_root;
            private Gff.Gff3AfterAurora m_parent;

            /// <summary>
            /// Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
            /// Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
            /// Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
            /// Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
            /// </summary>
            public byte[] RawData { get { return _rawData; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.Gff3AfterAurora M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
        /// `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
        /// Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
        /// </summary>
        public partial class FieldEntry : KaitaiStruct
        {
            public static FieldEntry FromFile(string fileName)
            {
                return new FieldEntry(new KaitaiStream(fileName));
            }

            public FieldEntry(KaitaiStream p__io, KaitaiStruct p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_fieldDataOffsetValue = false;
                f_isComplexType = false;
                f_isListType = false;
                f_isSimpleType = false;
                f_isStructType = false;
                f_listIndicesOffsetValue = false;
                f_structIndexValue = false;
                _read();
            }
            private void _read()
            {
                _fieldType = ((BiowareGffCommon.GffFieldType) m_io.ReadU4le());
                _labelIndex = m_io.ReadU4le();
                _dataOrOffset = m_io.ReadU4le();
            }
            private bool f_fieldDataOffsetValue;
            private int? _fieldDataOffsetValue;

            /// <summary>
            /// Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
            /// </summary>
            public int? FieldDataOffsetValue
            {
                get
                {
                    if (f_fieldDataOffsetValue)
                        return _fieldDataOffsetValue;
                    f_fieldDataOffsetValue = true;
                    if (IsComplexType) {
                        _fieldDataOffsetValue = (int) (M_Root.File.Gff3.Header.FieldDataOffset + DataOrOffset);
                    }
                    return _fieldDataOffsetValue;
                }
            }
            private bool f_isComplexType;
            private bool _isComplexType;

            /// <summary>
            /// Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
            /// </summary>
            public bool IsComplexType
            {
                get
                {
                    if (f_isComplexType)
                        return _isComplexType;
                    f_isComplexType = true;
                    _isComplexType = (bool) ( ((FieldType == BiowareGffCommon.GffFieldType.Uint64) || (FieldType == BiowareGffCommon.GffFieldType.Int64) || (FieldType == BiowareGffCommon.GffFieldType.Double) || (FieldType == BiowareGffCommon.GffFieldType.String) || (FieldType == BiowareGffCommon.GffFieldType.Resref) || (FieldType == BiowareGffCommon.GffFieldType.LocalizedString) || (FieldType == BiowareGffCommon.GffFieldType.Binary) || (FieldType == BiowareGffCommon.GffFieldType.Vector4) || (FieldType == BiowareGffCommon.GffFieldType.Vector3)) );
                    return _isComplexType;
                }
            }
            private bool f_isListType;
            private bool _isListType;

            /// <summary>
            /// Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
            /// </summary>
            public bool IsListType
            {
                get
                {
                    if (f_isListType)
                        return _isListType;
                    f_isListType = true;
                    _isListType = (bool) (FieldType == BiowareGffCommon.GffFieldType.List);
                    return _isListType;
                }
            }
            private bool f_isSimpleType;
            private bool _isSimpleType;

            /// <summary>
            /// Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
            /// Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
            /// **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
            /// </summary>
            public bool IsSimpleType
            {
                get
                {
                    if (f_isSimpleType)
                        return _isSimpleType;
                    f_isSimpleType = true;
                    _isSimpleType = (bool) ( ((FieldType == BiowareGffCommon.GffFieldType.Uint8) || (FieldType == BiowareGffCommon.GffFieldType.Int8) || (FieldType == BiowareGffCommon.GffFieldType.Uint16) || (FieldType == BiowareGffCommon.GffFieldType.Int16) || (FieldType == BiowareGffCommon.GffFieldType.Uint32) || (FieldType == BiowareGffCommon.GffFieldType.Int32) || (FieldType == BiowareGffCommon.GffFieldType.Single) || (FieldType == BiowareGffCommon.GffFieldType.StrRef)) );
                    return _isSimpleType;
                }
            }
            private bool f_isStructType;
            private bool _isStructType;

            /// <summary>
            /// Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
            /// </summary>
            public bool IsStructType
            {
                get
                {
                    if (f_isStructType)
                        return _isStructType;
                    f_isStructType = true;
                    _isStructType = (bool) (FieldType == BiowareGffCommon.GffFieldType.Struct);
                    return _isStructType;
                }
            }
            private bool f_listIndicesOffsetValue;
            private int? _listIndicesOffsetValue;

            /// <summary>
            /// Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.
            /// </summary>
            public int? ListIndicesOffsetValue
            {
                get
                {
                    if (f_listIndicesOffsetValue)
                        return _listIndicesOffsetValue;
                    f_listIndicesOffsetValue = true;
                    if (IsListType) {
                        _listIndicesOffsetValue = (int) (M_Root.File.Gff3.Header.ListIndicesOffset + DataOrOffset);
                    }
                    return _listIndicesOffsetValue;
                }
            }
            private bool f_structIndexValue;
            private uint? _structIndexValue;

            /// <summary>
            /// Struct index (same numeric interpretation as `GFFStructData` row index).
            /// </summary>
            public uint? StructIndexValue
            {
                get
                {
                    if (f_structIndexValue)
                        return _structIndexValue;
                    f_structIndexValue = true;
                    if (IsStructType) {
                        _structIndexValue = (uint) (DataOrOffset);
                    }
                    return _structIndexValue;
                }
            }
            private BiowareGffCommon.GffFieldType _fieldType;
            private uint _labelIndex;
            private uint _dataOrOffset;
            private Gff m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
            /// (ID → storage: inline vs `field_data` vs struct/list indirection).
            /// Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
            /// Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
            /// PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
            /// </summary>
            public BiowareGffCommon.GffFieldType FieldType { get { return _fieldType; } }

            /// <summary>
            /// Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.label_index` @ +0x4 (ulong).
            /// </summary>
            public uint LabelIndex { get { return _labelIndex; } }

            /// <summary>
            /// Inline data (simple types) or offset/index (complex types):
            /// - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
            /// - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
            /// - Struct (14): Struct index (index into struct_array)
            /// - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.data_or_data_offset` @ +0x8.
            /// `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
            /// </summary>
            public uint DataOrOffset { get { return _dataOrOffset; } }
            public Gff M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
        /// “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
        /// </summary>
        public partial class FieldIndicesArray : KaitaiStruct
        {
            public static FieldIndicesArray FromFile(string fileName)
            {
                return new FieldIndicesArray(new KaitaiStream(fileName));
            }

            public FieldIndicesArray(KaitaiStream p__io, Gff.Gff3AfterAurora p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _indices = new List<uint>();
                for (var i = 0; i < M_Root.File.Gff3.Header.FieldIndicesCount; i++)
                {
                    _indices.Add(m_io.ReadU4le());
                }
            }
            private List<uint> _indices;
            private Gff m_root;
            private Gff.Gff3AfterAurora m_parent;

            /// <summary>
            /// `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
            /// `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
            /// **Observed behavior**: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.
            /// </summary>
            public List<uint> Indices { get { return _indices; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.Gff3AfterAurora M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.
        /// </summary>
        public partial class Gff3AfterAurora : KaitaiStruct
        {
            public static Gff3AfterAurora FromFile(string fileName)
            {
                return new Gff3AfterAurora(new KaitaiStream(fileName));
            }

            public Gff3AfterAurora(KaitaiStream p__io, Gff.GffUnionFile p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_fieldArray = false;
                f_fieldData = false;
                f_fieldIndicesArray = false;
                f_labelArray = false;
                f_listIndicesArray = false;
                f_rootStructResolved = false;
                f_structArray = false;
                _read();
            }
            private void _read()
            {
                _header = new GffHeaderTail(m_io, this, m_root);
            }
            private bool f_fieldArray;
            private FieldArray _fieldArray;

            /// <summary>
            /// Field dictionary: `header.field_count` × 12 B at `header.field_offset`. **Observed behavior**: `GFFFieldData`.
            /// `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
            /// Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
            ///     PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149
            /// </summary>
            public FieldArray FieldArray
            {
                get
                {
                    if (f_fieldArray)
                        return _fieldArray;
                    f_fieldArray = true;
                    if (Header.FieldCount > 0) {
                        long _pos = m_io.Pos;
                        m_io.Seek(Header.FieldOffset);
                        _fieldArray = new FieldArray(m_io, this, m_root);
                        m_io.Seek(_pos);
                    }
                    return _fieldArray;
                }
            }
            private bool f_fieldData;
            private FieldData _fieldData;

            /// <summary>
            /// Complex-type payload heap. **Observed behavior**: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
            /// Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
            ///     PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216
            /// </summary>
            public FieldData FieldData
            {
                get
                {
                    if (f_fieldData)
                        return _fieldData;
                    f_fieldData = true;
                    if (Header.FieldDataCount > 0) {
                        long _pos = m_io.Pos;
                        m_io.Seek(Header.FieldDataOffset);
                        _fieldData = new FieldData(m_io, this, m_root);
                        m_io.Seek(_pos);
                    }
                    return _fieldData;
                }
            }
            private bool f_fieldIndicesArray;
            private FieldIndicesArray _fieldIndicesArray;

            /// <summary>
            /// Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
            /// **Observed behavior**: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
            /// Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
            ///     PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
            /// </summary>
            public FieldIndicesArray FieldIndicesArray
            {
                get
                {
                    if (f_fieldIndicesArray)
                        return _fieldIndicesArray;
                    f_fieldIndicesArray = true;
                    if (Header.FieldIndicesCount > 0) {
                        long _pos = m_io.Pos;
                        m_io.Seek(Header.FieldIndicesOffset);
                        _fieldIndicesArray = new FieldIndicesArray(m_io, this, m_root);
                        m_io.Seek(_pos);
                    }
                    return _fieldIndicesArray;
                }
            }
            private bool f_labelArray;
            private LabelArray _labelArray;

            /// <summary>
            /// Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
            /// **Observed behavior**: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
            /// Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
            ///     PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154
            /// </summary>
            public LabelArray LabelArray
            {
                get
                {
                    if (f_labelArray)
                        return _labelArray;
                    f_labelArray = true;
                    if (Header.LabelCount > 0) {
                        long _pos = m_io.Pos;
                        m_io.Seek(Header.LabelOffset);
                        _labelArray = new LabelArray(m_io, this, m_root);
                        m_io.Seek(_pos);
                    }
                    return _labelArray;
                }
            }
            private bool f_listIndicesArray;
            private ListIndicesArray _listIndicesArray;

            /// <summary>
            /// Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
            /// **Observed behavior**: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
            /// Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
            ///     PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
            /// </summary>
            public ListIndicesArray ListIndicesArray
            {
                get
                {
                    if (f_listIndicesArray)
                        return _listIndicesArray;
                    f_listIndicesArray = true;
                    if (Header.ListIndicesCount > 0) {
                        long _pos = m_io.Pos;
                        m_io.Seek(Header.ListIndicesOffset);
                        _listIndicesArray = new ListIndicesArray(m_io, this, m_root);
                        m_io.Seek(_pos);
                    }
                    return _listIndicesArray;
                }
            }
            private bool f_rootStructResolved;
            private ResolvedStruct _rootStructResolved;

            /// <summary>
            /// Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
            /// Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
            /// Implements the access pattern described in meta.doc (single-field vs multi-field structs).
            /// </summary>
            public ResolvedStruct RootStructResolved
            {
                get
                {
                    if (f_rootStructResolved)
                        return _rootStructResolved;
                    f_rootStructResolved = true;
                    _rootStructResolved = new ResolvedStruct(0, m_io, this, m_root);
                    return _rootStructResolved;
                }
            }
            private bool f_structArray;
            private StructArray _structArray;

            /// <summary>
            /// Struct table: `header.struct_count` × 12 B at `header.struct_offset`. **Observed behavior**: `GFFStructData` rows.
            /// Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
            ///     PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65
            /// </summary>
            public StructArray StructArray
            {
                get
                {
                    if (f_structArray)
                        return _structArray;
                    f_structArray = true;
                    if (Header.StructCount > 0) {
                        long _pos = m_io.Pos;
                        m_io.Seek(Header.StructOffset);
                        _structArray = new StructArray(m_io, this, m_root);
                        m_io.Seek(_pos);
                    }
                    return _structArray;
                }
            }
            private GffHeaderTail _header;
            private Gff m_root;
            private Gff.GffUnionFile m_parent;

            /// <summary>
            /// Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
            /// rows from Struct Array Offset through List Indices Count. **Observed behavior**: `GFFHeaderInfo` @ +0x8 … +0x34.
            /// </summary>
            public GffHeaderTail Header { get { return _header; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.GffUnionFile M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
        /// PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
        /// </summary>
        public partial class Gff4AfterAurora : KaitaiStruct
        {
            public Gff4AfterAurora(uint p_auroraVersion, KaitaiStream p__io, KaitaiStruct p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _auroraVersion = p_auroraVersion;
                _read();
            }
            private void _read()
            {
                _platformId = m_io.ReadU4be();
                _fileType = m_io.ReadU4be();
                _typeVersion = m_io.ReadU4be();
                _numStructTemplates = m_io.ReadU4le();
                if (AuroraVersion == 1446260273) {
                    _stringCount = m_io.ReadU4le();
                }
                if (AuroraVersion == 1446260273) {
                    _stringOffset = m_io.ReadU4le();
                }
                _dataOffset = m_io.ReadU4le();
                _structTemplates = new List<Gff4StructTemplateHeader>();
                for (var i = 0; i < NumStructTemplates; i++)
                {
                    _structTemplates.Add(new Gff4StructTemplateHeader(m_io, this, m_root));
                }
                _tail = m_io.ReadBytesFull();
            }
            private uint _platformId;
            private uint _fileType;
            private uint _typeVersion;
            private uint _numStructTemplates;
            private uint? _stringCount;
            private uint? _stringOffset;
            private uint _dataOffset;
            private List<Gff4StructTemplateHeader> _structTemplates;
            private byte[] _tail;
            private uint _auroraVersion;
            private Gff m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
            /// `PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).
            /// </summary>
            public uint PlatformId { get { return _platformId; } }

            /// <summary>
            /// GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
            /// `readUint32BE` on the endian-aware substream (`gff4file.cpp`).
            /// </summary>
            public uint FileType { get { return _fileType; } }

            /// <summary>
            /// Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).
            /// </summary>
            public uint TypeVersion { get { return _typeVersion; } }

            /// <summary>
            /// Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
            /// in typical DA assets). xoreos: `_header.structCount`.
            /// </summary>
            public uint NumStructTemplates { get { return _numStructTemplates; } }

            /// <summary>
            /// V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).
            /// </summary>
            public uint? StringCount { get { return _stringCount; } }

            /// <summary>
            /// V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).
            /// </summary>
            public uint? StringOffset { get { return _stringOffset; } }

            /// <summary>
            /// Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
            /// `readUint32` on the endian substream (`gff4file.cpp`).
            /// </summary>
            public uint DataOffset { get { return _dataOffset; } }

            /// <summary>
            /// Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).
            /// </summary>
            public List<Gff4StructTemplateHeader> StructTemplates { get { return _structTemplates; } }

            /// <summary>
            /// Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
            /// optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
            /// GFF4 graph walker or defer to engine code.
            /// </summary>
            public byte[] Tail { get { return _tail; } }

            /// <summary>
            /// Aurora version tag from the enclosing stream’s first 8 bytes (read on disk as `u4be`;
            /// passed as `u4` for Kaitai param typing). Same value as `gff_union_file.aurora_version` / `gff4_file.aurora_version`.
            /// </summary>
            public uint AuroraVersion { get { return _auroraVersion; } }
            public Gff M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
        /// that expect a single user-type over the whole file.
        /// </summary>
        public partial class Gff4File : KaitaiStruct
        {
            public static Gff4File FromFile(string fileName)
            {
                return new Gff4File(new KaitaiStream(fileName));
            }

            public Gff4File(KaitaiStream p__io, KaitaiStruct p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _auroraMagic = m_io.ReadU4be();
                _auroraVersion = m_io.ReadU4be();
                _gff4 = new Gff4AfterAurora(AuroraVersion, m_io, this, m_root);
            }
            private uint _auroraMagic;
            private uint _auroraVersion;
            private Gff4AfterAurora _gff4;
            private Gff m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Aurora container magic (`GFF ` as `u4be`).
            /// </summary>
            public uint AuroraMagic { get { return _auroraMagic; } }

            /// <summary>
            /// GFF4 `V4.0` / `V4.1` on-disk tags.
            /// </summary>
            public uint AuroraVersion { get { return _auroraVersion; } }

            /// <summary>
            /// GFF4 header tail + struct templates + opaque remainder.
            /// </summary>
            public Gff4AfterAurora Gff4 { get { return _gff4; } }
            public Gff M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        public partial class Gff4StructTemplateHeader : KaitaiStruct
        {
            public static Gff4StructTemplateHeader FromFile(string fileName)
            {
                return new Gff4StructTemplateHeader(new KaitaiStream(fileName));
            }

            public Gff4StructTemplateHeader(KaitaiStream p__io, Gff.Gff4AfterAurora p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _structLabel = m_io.ReadU4be();
                _fieldCount = m_io.ReadU4le();
                _fieldOffset = m_io.ReadU4le();
                _structSize = m_io.ReadU4le();
            }
            private uint _structLabel;
            private uint _fieldCount;
            private uint _fieldOffset;
            private uint _structSize;
            private Gff m_root;
            private Gff.Gff4AfterAurora m_parent;

            /// <summary>
            /// Template label (fourCC style, read `readUint32BE` in `loadStructs`).
            /// </summary>
            public uint StructLabel { get { return _structLabel; } }

            /// <summary>
            /// Number of field declaration records for this template (may be 0).
            /// </summary>
            public uint FieldCount { get { return _fieldCount; } }

            /// <summary>
            /// Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
            /// (xoreos `continue`s without reading declarations).
            /// </summary>
            public uint FieldOffset { get { return _fieldOffset; } }

            /// <summary>
            /// Declared on-disk struct size for instances of this template (`strct.size`).
            /// </summary>
            public uint StructSize { get { return _structSize; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.Gff4AfterAurora M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// **GFF3** header continuation: **48 bytes** (twelve LE `u32` dwords) at file offsets **0x08–0x37**, immediately
        /// after the shared Aurora 8-byte prefix (`aurora_magic` / `aurora_version` on `gff_union_file`). Same layout as
        /// wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) rows from “Struct Array
        /// Offset” through “List Indices Count”. **Observed behavior** on `k1_win_gog_swkotor.exe`: `GFFHeaderInfo` @ +0x8 … +0x34.
        /// 
        /// Sources (same DWORD order on disk after the 8-byte signature):
        /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 (`file_type`/`file_version` L79–L80 then twelve header `u32`s L93–L106)
        /// - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L44 (`GffReader::load` — skips 8-byte signature, reads twelve header `u32`s L30–L41)
        /// - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
        /// - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 (Aurora/GFF-family background; MultiMap wording)
        /// </summary>
        public partial class GffHeaderTail : KaitaiStruct
        {
            public static GffHeaderTail FromFile(string fileName)
            {
                return new GffHeaderTail(new KaitaiStream(fileName));
            }

            public GffHeaderTail(KaitaiStream p__io, Gff.Gff3AfterAurora p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _structOffset = m_io.ReadU4le();
                _structCount = m_io.ReadU4le();
                _fieldOffset = m_io.ReadU4le();
                _fieldCount = m_io.ReadU4le();
                _labelOffset = m_io.ReadU4le();
                _labelCount = m_io.ReadU4le();
                _fieldDataOffset = m_io.ReadU4le();
                _fieldDataCount = m_io.ReadU4le();
                _fieldIndicesOffset = m_io.ReadU4le();
                _fieldIndicesCount = m_io.ReadU4le();
                _listIndicesOffset = m_io.ReadU4le();
                _listIndicesCount = m_io.ReadU4le();
            }
            private uint _structOffset;
            private uint _structCount;
            private uint _fieldOffset;
            private uint _fieldCount;
            private uint _labelOffset;
            private uint _labelCount;
            private uint _fieldDataOffset;
            private uint _fieldDataCount;
            private uint _fieldIndicesOffset;
            private uint _fieldIndicesCount;
            private uint _listIndicesOffset;
            private uint _listIndicesCount;
            private Gff m_root;
            private Gff.Gff3AfterAurora m_parent;

            /// <summary>
            /// Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30
            /// </summary>
            public uint StructOffset { get { return _structOffset; } }

            /// <summary>
            /// Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_count` @ +0xC (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31
            /// </summary>
            public uint StructCount { get { return _structCount; } }

            /// <summary>
            /// Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32
            /// </summary>
            public uint FieldOffset { get { return _fieldOffset; } }

            /// <summary>
            /// Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_count` @ +0x14 (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33
            /// </summary>
            public uint FieldCount { get { return _fieldCount; } }

            /// <summary>
            /// Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34
            /// </summary>
            public uint LabelOffset { get { return _labelOffset; } }

            /// <summary>
            /// Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_count` @ +0x1C (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35
            /// </summary>
            public uint LabelCount { get { return _labelCount; } }

            /// <summary>
            /// Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36
            /// </summary>
            public uint FieldDataOffset { get { return _fieldDataOffset; } }

            /// <summary>
            /// Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37
            /// </summary>
            public uint FieldDataCount { get { return _fieldDataCount; } }

            /// <summary>
            /// Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38
            /// </summary>
            public uint FieldIndicesOffset { get { return _fieldIndicesOffset; } }

            /// <summary>
            /// Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)
            /// </summary>
            public uint FieldIndicesCount { get { return _fieldIndicesCount; } }

            /// <summary>
            /// Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40
            /// </summary>
            public uint ListIndicesOffset { get { return _listIndicesOffset; } }

            /// <summary>
            /// List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
            /// Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
            /// PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
            /// </summary>
            public uint ListIndicesCount { get { return _listIndicesCount; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.Gff3AfterAurora M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
        /// (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
        /// </summary>
        public partial class GffUnionFile : KaitaiStruct
        {
            public static GffUnionFile FromFile(string fileName)
            {
                return new GffUnionFile(new KaitaiStream(fileName));
            }

            public GffUnionFile(KaitaiStream p__io, Gff p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _auroraMagic = m_io.ReadU4be();
                _auroraVersion = m_io.ReadU4be();
                if ( ((AuroraVersion != 1446260272) && (AuroraVersion != 1446260273)) ) {
                    _gff3 = new Gff3AfterAurora(m_io, this, m_root);
                }
                if ( ((AuroraVersion == 1446260272) || (AuroraVersion == 1446260273)) ) {
                    _gff4 = new Gff4AfterAurora(AuroraVersion, m_io, this, m_root);
                }
            }
            private uint _auroraMagic;
            private uint _auroraVersion;
            private Gff3AfterAurora _gff3;
            private Gff4AfterAurora _gff4;
            private Gff m_root;
            private Gff m_parent;

            /// <summary>
            /// File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
            /// legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.
            /// </summary>
            public uint AuroraMagic { get { return _auroraMagic; } }

            /// <summary>
            /// Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
            /// `0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.
            /// </summary>
            public uint AuroraVersion { get { return _auroraVersion; } }

            /// <summary>
            /// **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.
            /// </summary>
            public Gff3AfterAurora Gff3 { get { return _gff3; } }

            /// <summary>
            /// **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.
            /// </summary>
            public Gff4AfterAurora Gff4 { get { return _gff4; } }
            public Gff M_Root { get { return m_root; } }
            public Gff M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
        /// Indexed by `GFFFieldData.label_index` (×16). Not a separate struct in **observed behavior** — rows are `char[16]` in bulk.
        /// Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
        /// </summary>
        public partial class LabelArray : KaitaiStruct
        {
            public static LabelArray FromFile(string fileName)
            {
                return new LabelArray(new KaitaiStream(fileName));
            }

            public LabelArray(KaitaiStream p__io, Gff.Gff3AfterAurora p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _labels = new List<LabelEntry>();
                for (var i = 0; i < M_Root.File.Gff3.Header.LabelCount; i++)
                {
                    _labels.Add(new LabelEntry(m_io, this, m_root));
                }
            }
            private List<LabelEntry> _labels;
            private Gff m_root;
            private Gff.Gff3AfterAurora m_parent;

            /// <summary>
            /// Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
            /// Index `i` is at file offset `label_offset + i*16`.
            /// </summary>
            public List<LabelEntry> Labels { get { return _labels; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.Gff3AfterAurora M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
        /// </summary>
        public partial class LabelEntry : KaitaiStruct
        {
            public static LabelEntry FromFile(string fileName)
            {
                return new LabelEntry(new KaitaiStream(fileName));
            }

            public LabelEntry(KaitaiStream p__io, Gff.LabelArray p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _name = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(16));
            }
            private string _name;
            private Gff m_root;
            private Gff.LabelArray m_parent;

            /// <summary>
            /// Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
            /// Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
            /// Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
            /// Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
            /// </summary>
            public string Name { get { return _name; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.LabelArray M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
        /// Not a separate engine-local datatype. Wire cite: `label_entry.name`.
        /// </summary>
        public partial class LabelEntryTerminated : KaitaiStruct
        {
            public static LabelEntryTerminated FromFile(string fileName)
            {
                return new LabelEntryTerminated(new KaitaiStream(fileName));
            }

            public LabelEntryTerminated(KaitaiStream p__io, Gff.ResolvedField p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _name = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(16), 0, false));
            }
            private string _name;
            private Gff m_root;
            private Gff.ResolvedField m_parent;

            /// <summary>
            /// Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.
            /// </summary>
            public string Name { get { return _name; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.ResolvedField M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
        /// Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
        /// </summary>
        public partial class ListEntry : KaitaiStruct
        {
            public static ListEntry FromFile(string fileName)
            {
                return new ListEntry(new KaitaiStream(fileName));
            }

            public ListEntry(KaitaiStream p__io, Gff.ResolvedField p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _numStructIndices = m_io.ReadU4le();
                _structIndices = new List<uint>();
                for (var i = 0; i < NumStructIndices; i++)
                {
                    _structIndices.Add(m_io.ReadU4le());
                }
            }
            private uint _numStructIndices;
            private List<uint> _structIndices;
            private Gff m_root;
            private Gff.ResolvedField m_parent;

            /// <summary>
            /// Little-endian count of following struct indices (list cardinality).
            /// Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
            /// </summary>
            public uint NumStructIndices { get { return _numStructIndices; } }

            /// <summary>
            /// Each value indexes `struct_array.entries[index]` (`GFFStructData` row).
            /// </summary>
            public List<uint> StructIndices { get { return _structIndices; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.ResolvedField M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
        /// </summary>
        public partial class ListIndicesArray : KaitaiStruct
        {
            public static ListIndicesArray FromFile(string fileName)
            {
                return new ListIndicesArray(new KaitaiStream(fileName));
            }

            public ListIndicesArray(KaitaiStream p__io, Gff.Gff3AfterAurora p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _rawData = m_io.ReadBytes(M_Root.File.Gff3.Header.ListIndicesCount);
            }
            private byte[] _rawData;
            private Gff m_root;
            private Gff.Gff3AfterAurora m_parent;

            /// <summary>
            /// Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
            /// Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
            /// This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.
            /// </summary>
            public byte[] RawData { get { return _rawData; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.Gff3AfterAurora M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Kaitai composition: one `GFFFieldData` row + label + payload.
        /// Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
        /// Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
        /// For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
        /// </summary>
        public partial class ResolvedField : KaitaiStruct
        {
            public ResolvedField(uint p_fieldIndex, KaitaiStream p__io, Gff.ResolvedStruct p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _fieldIndex = p_fieldIndex;
                f_entry = false;
                f_fieldEntryPos = false;
                f_label = false;
                f_listEntry = false;
                f_listStructs = false;
                f_valueBinary = false;
                f_valueDouble = false;
                f_valueInt16 = false;
                f_valueInt32 = false;
                f_valueInt64 = false;
                f_valueInt8 = false;
                f_valueLocalizedString = false;
                f_valueResref = false;
                f_valueSingle = false;
                f_valueStrRef = false;
                f_valueString = false;
                f_valueStruct = false;
                f_valueUint16 = false;
                f_valueUint32 = false;
                f_valueUint64 = false;
                f_valueUint8 = false;
                f_valueVector3 = false;
                f_valueVector4 = false;
                _read();
            }
            private void _read()
            {
            }
            private bool f_entry;
            private FieldEntry _entry;

            /// <summary>
            /// Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).
            /// </summary>
            public FieldEntry Entry
            {
                get
                {
                    if (f_entry)
                        return _entry;
                    f_entry = true;
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.File.Gff3.Header.FieldOffset + FieldIndex * 12);
                    _entry = new FieldEntry(m_io, this, m_root);
                    m_io.Seek(_pos);
                    return _entry;
                }
            }
            private bool f_fieldEntryPos;
            private int _fieldEntryPos;

            /// <summary>
            /// Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).
            /// </summary>
            public int FieldEntryPos
            {
                get
                {
                    if (f_fieldEntryPos)
                        return _fieldEntryPos;
                    f_fieldEntryPos = true;
                    _fieldEntryPos = (int) (M_Root.File.Gff3.Header.FieldOffset + FieldIndex * 12);
                    return _fieldEntryPos;
                }
            }
            private bool f_label;
            private LabelEntryTerminated _label;

            /// <summary>
            /// Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.
            /// </summary>
            public LabelEntryTerminated Label
            {
                get
                {
                    if (f_label)
                        return _label;
                    f_label = true;
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.File.Gff3.Header.LabelOffset + Entry.LabelIndex * 16);
                    _label = new LabelEntryTerminated(m_io, this, m_root);
                    m_io.Seek(_pos);
                    return _label;
                }
            }
            private bool f_listEntry;
            private ListEntry _listEntry;

            /// <summary>
            /// `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.
            /// </summary>
            public ListEntry ListEntry
            {
                get
                {
                    if (f_listEntry)
                        return _listEntry;
                    f_listEntry = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.List) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.ListIndicesOffset + Entry.DataOrOffset);
                        _listEntry = new ListEntry(m_io, this, m_root);
                        m_io.Seek(_pos);
                    }
                    return _listEntry;
                }
            }
            private bool f_listStructs;
            private List<ResolvedStruct> _listStructs;

            /// <summary>
            /// Child structs for this list; indices from `list_entry.struct_indices`.
            /// </summary>
            public List<ResolvedStruct> ListStructs
            {
                get
                {
                    if (f_listStructs)
                        return _listStructs;
                    f_listStructs = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.List) {
                        _listStructs = new List<ResolvedStruct>();
                        for (var i = 0; i < ListEntry.NumStructIndices; i++)
                        {
                            _listStructs.Add(new ResolvedStruct(ListEntry.StructIndices[i], m_io, this, m_root));
                        }
                    }
                    return _listStructs;
                }
            }
            private bool f_valueBinary;
            private BiowareCommon.BiowareBinaryData _valueBinary;

            /// <summary>
            /// `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
            /// </summary>
            public BiowareCommon.BiowareBinaryData ValueBinary
            {
                get
                {
                    if (f_valueBinary)
                        return _valueBinary;
                    f_valueBinary = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Binary) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldDataOffset + Entry.DataOrOffset);
                        _valueBinary = new BiowareCommon.BiowareBinaryData(m_io);
                        m_io.Seek(_pos);
                    }
                    return _valueBinary;
                }
            }
            private bool f_valueDouble;
            private double? _valueDouble;

            /// <summary>
            /// `GFFFieldTypes` 9 (double).
            /// </summary>
            public double? ValueDouble
            {
                get
                {
                    if (f_valueDouble)
                        return _valueDouble;
                    f_valueDouble = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Double) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldDataOffset + Entry.DataOrOffset);
                        _valueDouble = m_io.ReadF8le();
                        m_io.Seek(_pos);
                    }
                    return _valueDouble;
                }
            }
            private bool f_valueInt16;
            private short? _valueInt16;

            /// <summary>
            /// `GFFFieldTypes` 3 (INT16 LE at +8).
            /// </summary>
            public short? ValueInt16
            {
                get
                {
                    if (f_valueInt16)
                        return _valueInt16;
                    f_valueInt16 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Int16) {
                        long _pos = m_io.Pos;
                        m_io.Seek(FieldEntryPos + 8);
                        _valueInt16 = m_io.ReadS2le();
                        m_io.Seek(_pos);
                    }
                    return _valueInt16;
                }
            }
            private bool f_valueInt32;
            private int? _valueInt32;

            /// <summary>
            /// `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
            /// </summary>
            public int? ValueInt32
            {
                get
                {
                    if (f_valueInt32)
                        return _valueInt32;
                    f_valueInt32 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Int32) {
                        long _pos = m_io.Pos;
                        m_io.Seek(FieldEntryPos + 8);
                        _valueInt32 = m_io.ReadS4le();
                        m_io.Seek(_pos);
                    }
                    return _valueInt32;
                }
            }
            private bool f_valueInt64;
            private long? _valueInt64;

            /// <summary>
            /// `GFFFieldTypes` 7 (INT64).
            /// </summary>
            public long? ValueInt64
            {
                get
                {
                    if (f_valueInt64)
                        return _valueInt64;
                    f_valueInt64 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Int64) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldDataOffset + Entry.DataOrOffset);
                        _valueInt64 = m_io.ReadS8le();
                        m_io.Seek(_pos);
                    }
                    return _valueInt64;
                }
            }
            private bool f_valueInt8;
            private sbyte? _valueInt8;

            /// <summary>
            /// `GFFFieldTypes` 1 (INT8 in low byte of slot).
            /// </summary>
            public sbyte? ValueInt8
            {
                get
                {
                    if (f_valueInt8)
                        return _valueInt8;
                    f_valueInt8 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Int8) {
                        long _pos = m_io.Pos;
                        m_io.Seek(FieldEntryPos + 8);
                        _valueInt8 = m_io.ReadS1();
                        m_io.Seek(_pos);
                    }
                    return _valueInt8;
                }
            }
            private bool f_valueLocalizedString;
            private BiowareCommon.BiowareLocstring _valueLocalizedString;

            /// <summary>
            /// `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
            /// </summary>
            public BiowareCommon.BiowareLocstring ValueLocalizedString
            {
                get
                {
                    if (f_valueLocalizedString)
                        return _valueLocalizedString;
                    f_valueLocalizedString = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.LocalizedString) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldDataOffset + Entry.DataOrOffset);
                        _valueLocalizedString = new BiowareCommon.BiowareLocstring(m_io);
                        m_io.Seek(_pos);
                    }
                    return _valueLocalizedString;
                }
            }
            private bool f_valueResref;
            private BiowareCommon.BiowareResref _valueResref;

            /// <summary>
            /// `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
            /// </summary>
            public BiowareCommon.BiowareResref ValueResref
            {
                get
                {
                    if (f_valueResref)
                        return _valueResref;
                    f_valueResref = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Resref) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldDataOffset + Entry.DataOrOffset);
                        _valueResref = new BiowareCommon.BiowareResref(m_io);
                        m_io.Seek(_pos);
                    }
                    return _valueResref;
                }
            }
            private bool f_valueSingle;
            private float? _valueSingle;

            /// <summary>
            /// `GFFFieldTypes` 8 (32-bit float).
            /// </summary>
            public float? ValueSingle
            {
                get
                {
                    if (f_valueSingle)
                        return _valueSingle;
                    f_valueSingle = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Single) {
                        long _pos = m_io.Pos;
                        m_io.Seek(FieldEntryPos + 8);
                        _valueSingle = m_io.ReadF4le();
                        m_io.Seek(_pos);
                    }
                    return _valueSingle;
                }
            }
            private bool f_valueStrRef;
            private uint? _valueStrRef;

            /// <summary>
            /// `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
            /// `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
            /// **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
            /// Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
            /// PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
            /// </summary>
            public uint? ValueStrRef
            {
                get
                {
                    if (f_valueStrRef)
                        return _valueStrRef;
                    f_valueStrRef = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.StrRef) {
                        long _pos = m_io.Pos;
                        m_io.Seek(FieldEntryPos + 8);
                        _valueStrRef = m_io.ReadU4le();
                        m_io.Seek(_pos);
                    }
                    return _valueStrRef;
                }
            }
            private bool f_valueString;
            private BiowareCommon.BiowareCexoString _valueString;

            /// <summary>
            /// `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
            /// </summary>
            public BiowareCommon.BiowareCexoString ValueString
            {
                get
                {
                    if (f_valueString)
                        return _valueString;
                    f_valueString = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.String) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldDataOffset + Entry.DataOrOffset);
                        _valueString = new BiowareCommon.BiowareCexoString(m_io);
                        m_io.Seek(_pos);
                    }
                    return _valueString;
                }
            }
            private bool f_valueStruct;
            private ResolvedStruct _valueStruct;

            /// <summary>
            /// `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.
            /// </summary>
            public ResolvedStruct ValueStruct
            {
                get
                {
                    if (f_valueStruct)
                        return _valueStruct;
                    f_valueStruct = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Struct) {
                        _valueStruct = new ResolvedStruct(Entry.DataOrOffset, m_io, this, m_root);
                    }
                    return _valueStruct;
                }
            }
            private bool f_valueUint16;
            private ushort? _valueUint16;

            /// <summary>
            /// `GFFFieldTypes` 2 (UINT16 LE at +8).
            /// </summary>
            public ushort? ValueUint16
            {
                get
                {
                    if (f_valueUint16)
                        return _valueUint16;
                    f_valueUint16 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Uint16) {
                        long _pos = m_io.Pos;
                        m_io.Seek(FieldEntryPos + 8);
                        _valueUint16 = m_io.ReadU2le();
                        m_io.Seek(_pos);
                    }
                    return _valueUint16;
                }
            }
            private bool f_valueUint32;
            private uint? _valueUint32;

            /// <summary>
            /// `GFFFieldTypes` 4 (full inline DWORD).
            /// </summary>
            public uint? ValueUint32
            {
                get
                {
                    if (f_valueUint32)
                        return _valueUint32;
                    f_valueUint32 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Uint32) {
                        long _pos = m_io.Pos;
                        m_io.Seek(FieldEntryPos + 8);
                        _valueUint32 = m_io.ReadU4le();
                        m_io.Seek(_pos);
                    }
                    return _valueUint32;
                }
            }
            private bool f_valueUint64;
            private ulong? _valueUint64;

            /// <summary>
            /// `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
            /// </summary>
            public ulong? ValueUint64
            {
                get
                {
                    if (f_valueUint64)
                        return _valueUint64;
                    f_valueUint64 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Uint64) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldDataOffset + Entry.DataOrOffset);
                        _valueUint64 = m_io.ReadU8le();
                        m_io.Seek(_pos);
                    }
                    return _valueUint64;
                }
            }
            private bool f_valueUint8;
            private byte? _valueUint8;

            /// <summary>
            /// `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
            /// </summary>
            public byte? ValueUint8
            {
                get
                {
                    if (f_valueUint8)
                        return _valueUint8;
                    f_valueUint8 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Uint8) {
                        long _pos = m_io.Pos;
                        m_io.Seek(FieldEntryPos + 8);
                        _valueUint8 = m_io.ReadU1();
                        m_io.Seek(_pos);
                    }
                    return _valueUint8;
                }
            }
            private bool f_valueVector3;
            private BiowareCommon.BiowareVector3 _valueVector3;

            /// <summary>
            /// `GFFFieldTypes` 17 — three floats (`bioware_vector3`).
            /// </summary>
            public BiowareCommon.BiowareVector3 ValueVector3
            {
                get
                {
                    if (f_valueVector3)
                        return _valueVector3;
                    f_valueVector3 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Vector3) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldDataOffset + Entry.DataOrOffset);
                        _valueVector3 = new BiowareCommon.BiowareVector3(m_io);
                        m_io.Seek(_pos);
                    }
                    return _valueVector3;
                }
            }
            private bool f_valueVector4;
            private BiowareCommon.BiowareVector4 _valueVector4;

            /// <summary>
            /// `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
            /// </summary>
            public BiowareCommon.BiowareVector4 ValueVector4
            {
                get
                {
                    if (f_valueVector4)
                        return _valueVector4;
                    f_valueVector4 = true;
                    if (Entry.FieldType == BiowareGffCommon.GffFieldType.Vector4) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldDataOffset + Entry.DataOrOffset);
                        _valueVector4 = new BiowareCommon.BiowareVector4(m_io);
                        m_io.Seek(_pos);
                    }
                    return _valueVector4;
                }
            }
            private uint _fieldIndex;
            private Gff m_root;
            private Gff.ResolvedStruct m_parent;

            /// <summary>
            /// Index into `field_array.entries`; require `field_index &lt; field_count`.
            /// </summary>
            public uint FieldIndex { get { return _fieldIndex; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.ResolvedStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
        /// On-disk row remains at `struct_offset + struct_index * 12`.
        /// </summary>
        public partial class ResolvedStruct : KaitaiStruct
        {
            public ResolvedStruct(uint p_structIndex, KaitaiStream p__io, KaitaiStruct p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _structIndex = p_structIndex;
                f_entry = false;
                f_fieldIndices = false;
                f_fields = false;
                f_singleField = false;
                _read();
            }
            private void _read()
            {
            }
            private bool f_entry;
            private StructEntry _entry;

            /// <summary>
            /// Raw `GFFStructData` (12-byte layout in **observed behavior**).
            /// </summary>
            public StructEntry Entry
            {
                get
                {
                    if (f_entry)
                        return _entry;
                    f_entry = true;
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.File.Gff3.Header.StructOffset + StructIndex * 12);
                    _entry = new StructEntry(m_io, this, m_root);
                    m_io.Seek(_pos);
                    return _entry;
                }
            }
            private bool f_fieldIndices;
            private List<uint> _fieldIndices;

            /// <summary>
            /// Contiguous `u4` slice when `field_count &gt; 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
            /// Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
            /// </summary>
            public List<uint> FieldIndices
            {
                get
                {
                    if (f_fieldIndices)
                        return _fieldIndices;
                    f_fieldIndices = true;
                    if (Entry.FieldCount > 1) {
                        long _pos = m_io.Pos;
                        m_io.Seek(M_Root.File.Gff3.Header.FieldIndicesOffset + Entry.DataOrOffset);
                        _fieldIndices = new List<uint>();
                        for (var i = 0; i < Entry.FieldCount; i++)
                        {
                            _fieldIndices.Add(m_io.ReadU4le());
                        }
                        m_io.Seek(_pos);
                    }
                    return _fieldIndices;
                }
            }
            private bool f_fields;
            private List<ResolvedField> _fields;

            /// <summary>
            /// One `resolved_field` per entry in `field_indices`.
            /// </summary>
            public List<ResolvedField> Fields
            {
                get
                {
                    if (f_fields)
                        return _fields;
                    f_fields = true;
                    if (Entry.FieldCount > 1) {
                        _fields = new List<ResolvedField>();
                        for (var i = 0; i < Entry.FieldCount; i++)
                        {
                            _fields.Add(new ResolvedField(FieldIndices[i], m_io, this, m_root));
                        }
                    }
                    return _fields;
                }
            }
            private bool f_singleField;
            private ResolvedField _singleField;

            /// <summary>
            /// `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).
            /// </summary>
            public ResolvedField SingleField
            {
                get
                {
                    if (f_singleField)
                        return _singleField;
                    f_singleField = true;
                    if (Entry.FieldCount == 1) {
                        _singleField = new ResolvedField(Entry.DataOrOffset, m_io, this, m_root);
                    }
                    return _singleField;
                }
            }
            private uint _structIndex;
            private Gff m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Row index into `struct_array.entries`; `0` = root. Require `struct_index &lt; struct_count`.
            /// </summary>
            public uint StructIndex { get { return _structIndex; } }
            public Gff M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Name in **observed behavior**: `GFFStructData`.
        /// Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
        /// </summary>
        public partial class StructArray : KaitaiStruct
        {
            public static StructArray FromFile(string fileName)
            {
                return new StructArray(new KaitaiStream(fileName));
            }

            public StructArray(KaitaiStream p__io, Gff.Gff3AfterAurora p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<StructEntry>();
                for (var i = 0; i < M_Root.File.Gff3.Header.StructCount; i++)
                {
                    _entries.Add(new StructEntry(m_io, this, m_root));
                }
            }
            private List<StructEntry> _entries;
            private Gff m_root;
            private Gff.Gff3AfterAurora m_parent;

            /// <summary>
            /// Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
            /// Stride 12 bytes per struct (matches the component layout in **observed behavior**).
            /// </summary>
            public List<StructEntry> Entries { get { return _entries; } }
            public Gff M_Root { get { return m_root; } }
            public Gff.Gff3AfterAurora M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
        /// </summary>
        public partial class StructEntry : KaitaiStruct
        {
            public static StructEntry FromFile(string fileName)
            {
                return new StructEntry(new KaitaiStream(fileName));
            }

            public StructEntry(KaitaiStream p__io, KaitaiStruct p__parent = null, Gff p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_fieldIndicesOffset = false;
                f_hasMultipleFields = false;
                f_hasSingleField = false;
                f_singleFieldIndex = false;
                _read();
            }
            private void _read()
            {
                _structId = m_io.ReadU4le();
                _dataOrOffset = m_io.ReadU4le();
                _fieldCount = m_io.ReadU4le();
            }
            private bool f_fieldIndicesOffset;
            private uint? _fieldIndicesOffset;

            /// <summary>
            /// Alias of `data_or_offset` when `field_count &gt; 1`; added to `field_indices_offset` header field for absolute file pos.
            /// </summary>
            public uint? FieldIndicesOffset
            {
                get
                {
                    if (f_fieldIndicesOffset)
                        return _fieldIndicesOffset;
                    f_fieldIndicesOffset = true;
                    if (HasMultipleFields) {
                        _fieldIndicesOffset = (uint) (DataOrOffset);
                    }
                    return _fieldIndicesOffset;
                }
            }
            private bool f_hasMultipleFields;
            private bool _hasMultipleFields;

            /// <summary>
            /// Derived: `field_count &gt; 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
            /// </summary>
            public bool HasMultipleFields
            {
                get
                {
                    if (f_hasMultipleFields)
                        return _hasMultipleFields;
                    f_hasMultipleFields = true;
                    _hasMultipleFields = (bool) (FieldCount > 1);
                    return _hasMultipleFields;
                }
            }
            private bool f_hasSingleField;
            private bool _hasSingleField;

            /// <summary>
            /// Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
            /// Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
            /// </summary>
            public bool HasSingleField
            {
                get
                {
                    if (f_hasSingleField)
                        return _hasSingleField;
                    f_hasSingleField = true;
                    _hasSingleField = (bool) (FieldCount == 1);
                    return _hasSingleField;
                }
            }
            private bool f_singleFieldIndex;
            private uint? _singleFieldIndex;

            /// <summary>
            /// Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
            /// </summary>
            public uint? SingleFieldIndex
            {
                get
                {
                    if (f_singleFieldIndex)
                        return _singleFieldIndex;
                    f_singleFieldIndex = true;
                    if (HasSingleField) {
                        _singleFieldIndex = (uint) (DataOrOffset);
                    }
                    return _singleFieldIndex;
                }
            }
            private uint _structId;
            private uint _dataOrOffset;
            private uint _fieldCount;
            private Gff m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Structure type identifier.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
            /// Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
            /// 0xFFFFFFFF is the conventional &quot;generic&quot; / unset id in KotOR data; other values are schema-specific.
            /// </summary>
            public uint StructId { get { return _structId; } }

            /// <summary>
            /// Field index (if field_count == 1) or byte offset to field indices array (if field_count &gt; 1).
            /// If field_count == 0, this value is unused.
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
            /// </summary>
            public uint DataOrOffset { get { return _dataOrOffset; } }

            /// <summary>
            /// Number of fields in this struct:
            /// - 0: No fields
            /// - 1: Single field, data_or_offset contains the field index directly
            /// - &gt;1: Multiple fields, data_or_offset contains byte offset into field_indices_array
            /// **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.field_count` @ +0x8 (ulong).
            /// </summary>
            public uint FieldCount { get { return _fieldCount; } }
            public Gff M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        private GffUnionFile _file;
        private Gff m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
        /// (`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
        /// Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
        /// mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
        /// downstream `pos:` / `_root.file.gff3.header` paths.
        /// </summary>
        public GffUnionFile File { get { return _file; } }
        public Gff M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
