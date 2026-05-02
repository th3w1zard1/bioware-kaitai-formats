// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.nio.charset.StandardCharsets;


/**
 * BioWare **GFF** (Generic File Format): hierarchical binary game data (KotOR/TSL and Aurora lineage; GFF4 for
 * DA / Eclipse-class payloads in this `.ksy`). Human-readable tables and tutorials: PyKotor wiki (**Further
 * reading**). Wire `gff_field_type` enum: `formats/Common/bioware_gff_common.ksy`.
 * 
 * **Aurora prefix (8 bytes):** `u4be` FourCC + `u4be` version (`AuroraFile::readHeader` — `meta.xref`
 * `xoreos_aurorafile_read_header`).
 * **GFF3:** Twelve LE `u32` counts/offsets as `gff_header_tail` under `gff3_after_aurora`, then lazy arena
 * `instances`.
 * **GFF4:** When version is `V4.0` / `V4.1`, the next field is `platform_id` (`u4be`), not GFF3 `struct_offset`
 * (`gff4_after_aurora`; partial GFF4 graph — `tail` blob still opaque).
 * 
 * **GFF3 wire summary:**
 * - Root `file` → `gff_union_file`; arenas addressed via `gff3.header` offsets.
 * - 12-byte struct rows (`struct_entry`), 12-byte field rows (`field_entry`); root struct index **0**; single-field
 *   vs multi-field vs lists per wiki *Struct array* / *Field indices* / *List indices*.
 * 
 * **Observed behavior:** engine record names and addresses live on the `seq` / `types` nodes they justify, not in this blurb.
 * 
 * **Pinned URLs and tool history:** `meta.xref` (alphabetical keys). Coverage matrix: `docs/XOREOS_FORMAT_COVERAGE.md`.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format">PyKotor wiki — GFF binary format</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — GFF3File::Header::read</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181">xoreos — GFF3File load (post-header struct/field arena wiring)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72">xoreos — GFF4File::Header::read</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L151-L164">xoreos — GFF4File::load entry</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114">PyKotor — GFFBinaryReader.load</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225">reone — GffReader</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts#L152-L221">KotOR.js — GFFObject.parse</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp#L86-L238">xoreos-tools — GFF3 load pipeline (shared with CLIs)</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176">xoreos-tools — `gffdumper`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60">xoreos-tools — `gffcreator`</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf</a>
 */
public class Gff extends KaitaiStruct {
    public static Gff fromFile(String fileName) throws IOException {
        return new Gff(new ByteBufferKaitaiStream(fileName));
    }

    public Gff(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Gff(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Gff(KaitaiStream _io, KaitaiStruct _parent, Gff _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.file = new GffUnionFile(this._io, this, _root);
    }

    public void _fetchInstances() {
        this.file._fetchInstances();
    }

    /**
     * Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
     * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
     */
    public static class FieldArray extends KaitaiStruct {
        public static FieldArray fromFile(String fileName) throws IOException {
            return new FieldArray(new ByteBufferKaitaiStream(fileName));
        }

        public FieldArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FieldArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent) {
            this(_io, _parent, null);
        }

        public FieldArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<FieldEntry>();
            for (int i = 0; i < _root().file().gff3().header().fieldCount(); i++) {
                this.entries.add(new FieldEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<FieldEntry> entries;
        private Gff _root;
        private Gff.Gff3AfterAurora _parent;

        /**
         * Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
         * Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).
         */
        public List<FieldEntry> entries() { return entries; }
        public Gff _root() { return _root; }
        public Gff.Gff3AfterAurora _parent() { return _parent; }
    }

    /**
     * Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
     */
    public static class FieldData extends KaitaiStruct {
        public static FieldData fromFile(String fileName) throws IOException {
            return new FieldData(new ByteBufferKaitaiStream(fileName));
        }

        public FieldData(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FieldData(KaitaiStream _io, Gff.Gff3AfterAurora _parent) {
            this(_io, _parent, null);
        }

        public FieldData(KaitaiStream _io, Gff.Gff3AfterAurora _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.rawData = this._io.readBytes(_root().file().gff3().header().fieldDataCount());
        }

        public void _fetchInstances() {
        }
        private byte[] rawData;
        private Gff _root;
        private Gff.Gff3AfterAurora _parent;

        /**
         * Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
         * Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
         * Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
         */
        public byte[] rawData() { return rawData; }
        public Gff _root() { return _root; }
        public Gff.Gff3AfterAurora _parent() { return _parent; }
    }

    /**
     * One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
     * `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
     * Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
     */
    public static class FieldEntry extends KaitaiStruct {
        public static FieldEntry fromFile(String fileName) throws IOException {
            return new FieldEntry(new ByteBufferKaitaiStream(fileName));
        }

        public FieldEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FieldEntry(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public FieldEntry(KaitaiStream _io, KaitaiStruct _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.fieldType = BiowareGffCommon.GffFieldType.byId(this._io.readU4le());
            this.labelIndex = this._io.readU4le();
            this.dataOrOffset = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private Integer fieldDataOffsetValue;

        /**
         * Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
         */
        public Integer fieldDataOffsetValue() {
            if (this.fieldDataOffsetValue != null)
                return this.fieldDataOffsetValue;
            if (isComplexType()) {
                this.fieldDataOffsetValue = ((Number) (_root().file().gff3().header().fieldDataOffset() + dataOrOffset())).intValue();
            }
            return this.fieldDataOffsetValue;
        }
        private Boolean isComplexType;

        /**
         * Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
         */
        public Boolean isComplexType() {
            if (this.isComplexType != null)
                return this.isComplexType;
            this.isComplexType =  ((fieldType() == BiowareGffCommon.GffFieldType.UINT64) || (fieldType() == BiowareGffCommon.GffFieldType.INT64) || (fieldType() == BiowareGffCommon.GffFieldType.DOUBLE) || (fieldType() == BiowareGffCommon.GffFieldType.STRING) || (fieldType() == BiowareGffCommon.GffFieldType.RESREF) || (fieldType() == BiowareGffCommon.GffFieldType.LOCALIZED_STRING) || (fieldType() == BiowareGffCommon.GffFieldType.BINARY) || (fieldType() == BiowareGffCommon.GffFieldType.VECTOR4) || (fieldType() == BiowareGffCommon.GffFieldType.VECTOR3)) ;
            return this.isComplexType;
        }
        private Boolean isListType;

        /**
         * Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
         */
        public Boolean isListType() {
            if (this.isListType != null)
                return this.isListType;
            this.isListType = fieldType() == BiowareGffCommon.GffFieldType.LIST;
            return this.isListType;
        }
        private Boolean isSimpleType;

        /**
         * Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
         * Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
         * **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
         */
        public Boolean isSimpleType() {
            if (this.isSimpleType != null)
                return this.isSimpleType;
            this.isSimpleType =  ((fieldType() == BiowareGffCommon.GffFieldType.UINT8) || (fieldType() == BiowareGffCommon.GffFieldType.INT8) || (fieldType() == BiowareGffCommon.GffFieldType.UINT16) || (fieldType() == BiowareGffCommon.GffFieldType.INT16) || (fieldType() == BiowareGffCommon.GffFieldType.UINT32) || (fieldType() == BiowareGffCommon.GffFieldType.INT32) || (fieldType() == BiowareGffCommon.GffFieldType.SINGLE) || (fieldType() == BiowareGffCommon.GffFieldType.STR_REF)) ;
            return this.isSimpleType;
        }
        private Boolean isStructType;

        /**
         * Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
         */
        public Boolean isStructType() {
            if (this.isStructType != null)
                return this.isStructType;
            this.isStructType = fieldType() == BiowareGffCommon.GffFieldType.STRUCT;
            return this.isStructType;
        }
        private Integer listIndicesOffsetValue;

        /**
         * Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.
         */
        public Integer listIndicesOffsetValue() {
            if (this.listIndicesOffsetValue != null)
                return this.listIndicesOffsetValue;
            if (isListType()) {
                this.listIndicesOffsetValue = ((Number) (_root().file().gff3().header().listIndicesOffset() + dataOrOffset())).intValue();
            }
            return this.listIndicesOffsetValue;
        }
        private Long structIndexValue;

        /**
         * Struct index (same numeric interpretation as `GFFStructData` row index).
         */
        public Long structIndexValue() {
            if (this.structIndexValue != null)
                return this.structIndexValue;
            if (isStructType()) {
                this.structIndexValue = ((Number) (dataOrOffset())).longValue();
            }
            return this.structIndexValue;
        }
        private BiowareGffCommon.GffFieldType fieldType;
        private long labelIndex;
        private long dataOrOffset;
        private Gff _root;
        private KaitaiStruct _parent;

        /**
         * Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
         * (ID → storage: inline vs `field_data` vs struct/list indirection).
         * Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
         * Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
         * PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
         */
        public BiowareGffCommon.GffFieldType fieldType() { return fieldType; }

        /**
         * Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.label_index` @ +0x4 (ulong).
         */
        public long labelIndex() { return labelIndex; }

        /**
         * Inline data (simple types) or offset/index (complex types):
         * - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
         * - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
         * - Struct (14): Struct index (index into struct_array)
         * - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.data_or_data_offset` @ +0x8.
         * `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
         */
        public long dataOrOffset() { return dataOrOffset; }
        public Gff _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
     * “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
     */
    public static class FieldIndicesArray extends KaitaiStruct {
        public static FieldIndicesArray fromFile(String fileName) throws IOException {
            return new FieldIndicesArray(new ByteBufferKaitaiStream(fileName));
        }

        public FieldIndicesArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FieldIndicesArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent) {
            this(_io, _parent, null);
        }

        public FieldIndicesArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.indices = new ArrayList<Long>();
            for (int i = 0; i < _root().file().gff3().header().fieldIndicesCount(); i++) {
                this.indices.add(this._io.readU4le());
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.indices.size(); i++) {
            }
        }
        private List<Long> indices;
        private Gff _root;
        private Gff.Gff3AfterAurora _parent;

        /**
         * `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
         * `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
         * **Observed behavior**: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.
         */
        public List<Long> indices() { return indices; }
        public Gff _root() { return _root; }
        public Gff.Gff3AfterAurora _parent() { return _parent; }
    }

    /**
     * GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.
     */
    public static class Gff3AfterAurora extends KaitaiStruct {
        public static Gff3AfterAurora fromFile(String fileName) throws IOException {
            return new Gff3AfterAurora(new ByteBufferKaitaiStream(fileName));
        }

        public Gff3AfterAurora(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Gff3AfterAurora(KaitaiStream _io, Gff.GffUnionFile _parent) {
            this(_io, _parent, null);
        }

        public Gff3AfterAurora(KaitaiStream _io, Gff.GffUnionFile _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.header = new GffHeaderTail(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.header._fetchInstances();
            fieldArray();
            if (this.fieldArray != null) {
                this.fieldArray._fetchInstances();
            }
            fieldData();
            if (this.fieldData != null) {
                this.fieldData._fetchInstances();
            }
            fieldIndicesArray();
            if (this.fieldIndicesArray != null) {
                this.fieldIndicesArray._fetchInstances();
            }
            labelArray();
            if (this.labelArray != null) {
                this.labelArray._fetchInstances();
            }
            listIndicesArray();
            if (this.listIndicesArray != null) {
                this.listIndicesArray._fetchInstances();
            }
            rootStructResolved();
            if (this.rootStructResolved != null) {
                this.rootStructResolved._fetchInstances();
            }
            structArray();
            if (this.structArray != null) {
                this.structArray._fetchInstances();
            }
        }
        private FieldArray fieldArray;

        /**
         * Field dictionary: `header.field_count` × 12 B at `header.field_offset`. **Observed behavior**: `GFFFieldData`.
         * `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
         *     PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149
         */
        public FieldArray fieldArray() {
            if (this.fieldArray != null)
                return this.fieldArray;
            if (header().fieldCount() > 0) {
                long _pos = this._io.pos();
                this._io.seek(header().fieldOffset());
                this.fieldArray = new FieldArray(this._io, this, _root);
                this._io.seek(_pos);
            }
            return this.fieldArray;
        }
        private FieldData fieldData;

        /**
         * Complex-type payload heap. **Observed behavior**: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
         *     PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216
         */
        public FieldData fieldData() {
            if (this.fieldData != null)
                return this.fieldData;
            if (header().fieldDataCount() > 0) {
                long _pos = this._io.pos();
                this._io.seek(header().fieldDataOffset());
                this.fieldData = new FieldData(this._io, this, _root);
                this._io.seek(_pos);
            }
            return this.fieldData;
        }
        private FieldIndicesArray fieldIndicesArray;

        /**
         * Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
         * **Observed behavior**: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
         *     PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
         */
        public FieldIndicesArray fieldIndicesArray() {
            if (this.fieldIndicesArray != null)
                return this.fieldIndicesArray;
            if (header().fieldIndicesCount() > 0) {
                long _pos = this._io.pos();
                this._io.seek(header().fieldIndicesOffset());
                this.fieldIndicesArray = new FieldIndicesArray(this._io, this, _root);
                this._io.seek(_pos);
            }
            return this.fieldIndicesArray;
        }
        private LabelArray labelArray;

        /**
         * Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
         * **Observed behavior**: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
         *     PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154
         */
        public LabelArray labelArray() {
            if (this.labelArray != null)
                return this.labelArray;
            if (header().labelCount() > 0) {
                long _pos = this._io.pos();
                this._io.seek(header().labelOffset());
                this.labelArray = new LabelArray(this._io, this, _root);
                this._io.seek(_pos);
            }
            return this.labelArray;
        }
        private ListIndicesArray listIndicesArray;

        /**
         * Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
         * **Observed behavior**: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
         *     PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
         */
        public ListIndicesArray listIndicesArray() {
            if (this.listIndicesArray != null)
                return this.listIndicesArray;
            if (header().listIndicesCount() > 0) {
                long _pos = this._io.pos();
                this._io.seek(header().listIndicesOffset());
                this.listIndicesArray = new ListIndicesArray(this._io, this, _root);
                this._io.seek(_pos);
            }
            return this.listIndicesArray;
        }
        private ResolvedStruct rootStructResolved;

        /**
         * Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
         * Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
         * Implements the access pattern described in meta.doc (single-field vs multi-field structs).
         */
        public ResolvedStruct rootStructResolved() {
            if (this.rootStructResolved != null)
                return this.rootStructResolved;
            this.rootStructResolved = new ResolvedStruct(this._io, this, _root, 0);
            return this.rootStructResolved;
        }
        private StructArray structArray;

        /**
         * Struct table: `header.struct_count` × 12 B at `header.struct_offset`. **Observed behavior**: `GFFStructData` rows.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         *     PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65
         */
        public StructArray structArray() {
            if (this.structArray != null)
                return this.structArray;
            if (header().structCount() > 0) {
                long _pos = this._io.pos();
                this._io.seek(header().structOffset());
                this.structArray = new StructArray(this._io, this, _root);
                this._io.seek(_pos);
            }
            return this.structArray;
        }
        private GffHeaderTail header;
        private Gff _root;
        private Gff.GffUnionFile _parent;

        /**
         * Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
         * rows from Struct Array Offset through List Indices Count. **Observed behavior**: `GFFHeaderInfo` @ +0x8 … +0x34.
         */
        public GffHeaderTail header() { return header; }
        public Gff _root() { return _root; }
        public Gff.GffUnionFile _parent() { return _parent; }
    }

    /**
     * GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
     * PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
     */
    public static class Gff4AfterAurora extends KaitaiStruct {

        public Gff4AfterAurora(KaitaiStream _io, long auroraVersion) {
            this(_io, null, null, auroraVersion);
        }

        public Gff4AfterAurora(KaitaiStream _io, KaitaiStruct _parent, long auroraVersion) {
            this(_io, _parent, null, auroraVersion);
        }

        public Gff4AfterAurora(KaitaiStream _io, KaitaiStruct _parent, Gff _root, long auroraVersion) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            this.auroraVersion = auroraVersion;
            _read();
        }
        private void _read() {
            this.platformId = this._io.readU4be();
            this.fileType = this._io.readU4be();
            this.typeVersion = this._io.readU4be();
            this.numStructTemplates = this._io.readU4le();
            if (auroraVersion() == 1446260273) {
                this.stringCount = this._io.readU4le();
            }
            if (auroraVersion() == 1446260273) {
                this.stringOffset = this._io.readU4le();
            }
            this.dataOffset = this._io.readU4le();
            this.structTemplates = new ArrayList<Gff4StructTemplateHeader>();
            for (int i = 0; i < numStructTemplates(); i++) {
                this.structTemplates.add(new Gff4StructTemplateHeader(this._io, this, _root));
            }
            this.tail = this._io.readBytesFull();
        }

        public void _fetchInstances() {
            if (auroraVersion() == 1446260273) {
            }
            if (auroraVersion() == 1446260273) {
            }
            for (int i = 0; i < this.structTemplates.size(); i++) {
                this.structTemplates.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private long platformId;
        private long fileType;
        private long typeVersion;
        private long numStructTemplates;
        private Long stringCount;
        private Long stringOffset;
        private long dataOffset;
        private List<Gff4StructTemplateHeader> structTemplates;
        private byte[] tail;
        private long auroraVersion;
        private Gff _root;
        private KaitaiStruct _parent;

        /**
         * Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
         * `PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).
         */
        public long platformId() { return platformId; }

        /**
         * GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
         * `readUint32BE` on the endian-aware substream (`gff4file.cpp`).
         */
        public long fileType() { return fileType; }

        /**
         * Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).
         */
        public long typeVersion() { return typeVersion; }

        /**
         * Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
         * in typical DA assets). xoreos: `_header.structCount`.
         */
        public long numStructTemplates() { return numStructTemplates; }

        /**
         * V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).
         */
        public Long stringCount() { return stringCount; }

        /**
         * V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).
         */
        public Long stringOffset() { return stringOffset; }

        /**
         * Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
         * `readUint32` on the endian substream (`gff4file.cpp`).
         */
        public long dataOffset() { return dataOffset; }

        /**
         * Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).
         */
        public List<Gff4StructTemplateHeader> structTemplates() { return structTemplates; }

        /**
         * Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
         * optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
         * GFF4 graph walker or defer to engine code.
         */
        public byte[] tail() { return tail; }

        /**
         * Aurora version tag from the enclosing stream’s first 8 bytes (read on disk as `u4be`;
         * passed as `u4` for Kaitai param typing). Same value as `gff_union_file.aurora_version` / `gff4_file.aurora_version`.
         */
        public long auroraVersion() { return auroraVersion; }
        public Gff _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
     * that expect a single user-type over the whole file.
     */
    public static class Gff4File extends KaitaiStruct {
        public static Gff4File fromFile(String fileName) throws IOException {
            return new Gff4File(new ByteBufferKaitaiStream(fileName));
        }

        public Gff4File(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Gff4File(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public Gff4File(KaitaiStream _io, KaitaiStruct _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.auroraMagic = this._io.readU4be();
            this.auroraVersion = this._io.readU4be();
            this.gff4 = new Gff4AfterAurora(this._io, this, _root, auroraVersion());
        }

        public void _fetchInstances() {
            this.gff4._fetchInstances();
        }
        private long auroraMagic;
        private long auroraVersion;
        private Gff4AfterAurora gff4;
        private Gff _root;
        private KaitaiStruct _parent;

        /**
         * Aurora container magic (`GFF ` as `u4be`).
         */
        public long auroraMagic() { return auroraMagic; }

        /**
         * GFF4 `V4.0` / `V4.1` on-disk tags.
         */
        public long auroraVersion() { return auroraVersion; }

        /**
         * GFF4 header tail + struct templates + opaque remainder.
         */
        public Gff4AfterAurora gff4() { return gff4; }
        public Gff _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }
    public static class Gff4StructTemplateHeader extends KaitaiStruct {
        public static Gff4StructTemplateHeader fromFile(String fileName) throws IOException {
            return new Gff4StructTemplateHeader(new ByteBufferKaitaiStream(fileName));
        }

        public Gff4StructTemplateHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Gff4StructTemplateHeader(KaitaiStream _io, Gff.Gff4AfterAurora _parent) {
            this(_io, _parent, null);
        }

        public Gff4StructTemplateHeader(KaitaiStream _io, Gff.Gff4AfterAurora _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.structLabel = this._io.readU4be();
            this.fieldCount = this._io.readU4le();
            this.fieldOffset = this._io.readU4le();
            this.structSize = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private long structLabel;
        private long fieldCount;
        private long fieldOffset;
        private long structSize;
        private Gff _root;
        private Gff.Gff4AfterAurora _parent;

        /**
         * Template label (fourCC style, read `readUint32BE` in `loadStructs`).
         */
        public long structLabel() { return structLabel; }

        /**
         * Number of field declaration records for this template (may be 0).
         */
        public long fieldCount() { return fieldCount; }

        /**
         * Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
         * (xoreos `continue`s without reading declarations).
         */
        public long fieldOffset() { return fieldOffset; }

        /**
         * Declared on-disk struct size for instances of this template (`strct.size`).
         */
        public long structSize() { return structSize; }
        public Gff _root() { return _root; }
        public Gff.Gff4AfterAurora _parent() { return _parent; }
    }

    /**
     * **GFF3** header continuation: **48 bytes** (twelve LE `u32` dwords) at file offsets **0x08–0x37**, immediately
     * after the shared Aurora 8-byte prefix (`aurora_magic` / `aurora_version` on `gff_union_file`). Same layout as
     * wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) rows from “Struct Array
     * Offset” through “List Indices Count”. **Observed behavior** on `k1_win_gog_swkotor.exe`: `GFFHeaderInfo` @ +0x8 … +0x34.
     * 
     * Sources (same DWORD order on disk after the 8-byte signature):
     * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 (`file_type`/`file_version` L79–L80 then twelve header `u32`s L93–L106)
     * - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L44 (`GffReader::load` — skips 8-byte signature, reads twelve header `u32`s L30–L41)
     * - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
     * - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 (Aurora/GFF-family background; MultiMap wording)
     */
    public static class GffHeaderTail extends KaitaiStruct {
        public static GffHeaderTail fromFile(String fileName) throws IOException {
            return new GffHeaderTail(new ByteBufferKaitaiStream(fileName));
        }

        public GffHeaderTail(KaitaiStream _io) {
            this(_io, null, null);
        }

        public GffHeaderTail(KaitaiStream _io, Gff.Gff3AfterAurora _parent) {
            this(_io, _parent, null);
        }

        public GffHeaderTail(KaitaiStream _io, Gff.Gff3AfterAurora _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.structOffset = this._io.readU4le();
            this.structCount = this._io.readU4le();
            this.fieldOffset = this._io.readU4le();
            this.fieldCount = this._io.readU4le();
            this.labelOffset = this._io.readU4le();
            this.labelCount = this._io.readU4le();
            this.fieldDataOffset = this._io.readU4le();
            this.fieldDataCount = this._io.readU4le();
            this.fieldIndicesOffset = this._io.readU4le();
            this.fieldIndicesCount = this._io.readU4le();
            this.listIndicesOffset = this._io.readU4le();
            this.listIndicesCount = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private long structOffset;
        private long structCount;
        private long fieldOffset;
        private long fieldCount;
        private long labelOffset;
        private long labelCount;
        private long fieldDataOffset;
        private long fieldDataCount;
        private long fieldIndicesOffset;
        private long fieldIndicesCount;
        private long listIndicesOffset;
        private long listIndicesCount;
        private Gff _root;
        private Gff.Gff3AfterAurora _parent;

        /**
         * Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30
         */
        public long structOffset() { return structOffset; }

        /**
         * Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_count` @ +0xC (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31
         */
        public long structCount() { return structCount; }

        /**
         * Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32
         */
        public long fieldOffset() { return fieldOffset; }

        /**
         * Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_count` @ +0x14 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33
         */
        public long fieldCount() { return fieldCount; }

        /**
         * Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34
         */
        public long labelOffset() { return labelOffset; }

        /**
         * Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_count` @ +0x1C (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35
         */
        public long labelCount() { return labelCount; }

        /**
         * Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36
         */
        public long fieldDataOffset() { return fieldDataOffset; }

        /**
         * Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37
         */
        public long fieldDataCount() { return fieldDataCount; }

        /**
         * Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38
         */
        public long fieldIndicesOffset() { return fieldIndicesOffset; }

        /**
         * Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)
         */
        public long fieldIndicesCount() { return fieldIndicesCount; }

        /**
         * Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40
         */
        public long listIndicesOffset() { return listIndicesOffset; }

        /**
         * List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
         * Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
         */
        public long listIndicesCount() { return listIndicesCount; }
        public Gff _root() { return _root; }
        public Gff.Gff3AfterAurora _parent() { return _parent; }
    }

    /**
     * Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
     * (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
     */
    public static class GffUnionFile extends KaitaiStruct {
        public static GffUnionFile fromFile(String fileName) throws IOException {
            return new GffUnionFile(new ByteBufferKaitaiStream(fileName));
        }

        public GffUnionFile(KaitaiStream _io) {
            this(_io, null, null);
        }

        public GffUnionFile(KaitaiStream _io, Gff _parent) {
            this(_io, _parent, null);
        }

        public GffUnionFile(KaitaiStream _io, Gff _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.auroraMagic = this._io.readU4be();
            this.auroraVersion = this._io.readU4be();
            if ( ((auroraVersion() != 1446260272) && (auroraVersion() != 1446260273)) ) {
                this.gff3 = new Gff3AfterAurora(this._io, this, _root);
            }
            if ( ((auroraVersion() == 1446260272) || (auroraVersion() == 1446260273)) ) {
                this.gff4 = new Gff4AfterAurora(this._io, this, _root, auroraVersion());
            }
        }

        public void _fetchInstances() {
            if ( ((auroraVersion() != 1446260272) && (auroraVersion() != 1446260273)) ) {
                this.gff3._fetchInstances();
            }
            if ( ((auroraVersion() == 1446260272) || (auroraVersion() == 1446260273)) ) {
                this.gff4._fetchInstances();
            }
        }
        private long auroraMagic;
        private long auroraVersion;
        private Gff3AfterAurora gff3;
        private Gff4AfterAurora gff4;
        private Gff _root;
        private Gff _parent;

        /**
         * File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
         * legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.
         */
        public long auroraMagic() { return auroraMagic; }

        /**
         * Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
         * `0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.
         */
        public long auroraVersion() { return auroraVersion; }

        /**
         * **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.
         */
        public Gff3AfterAurora gff3() { return gff3; }

        /**
         * **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.
         */
        public Gff4AfterAurora gff4() { return gff4; }
        public Gff _root() { return _root; }
        public Gff _parent() { return _parent; }
    }

    /**
     * Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
     * Indexed by `GFFFieldData.label_index` (×16). Not a separate struct in **observed behavior** — rows are `char[16]` in bulk.
     * Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
     */
    public static class LabelArray extends KaitaiStruct {
        public static LabelArray fromFile(String fileName) throws IOException {
            return new LabelArray(new ByteBufferKaitaiStream(fileName));
        }

        public LabelArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LabelArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent) {
            this(_io, _parent, null);
        }

        public LabelArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.labels = new ArrayList<LabelEntry>();
            for (int i = 0; i < _root().file().gff3().header().labelCount(); i++) {
                this.labels.add(new LabelEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.labels.size(); i++) {
                this.labels.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<LabelEntry> labels;
        private Gff _root;
        private Gff.Gff3AfterAurora _parent;

        /**
         * Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
         * Index `i` is at file offset `label_offset + i*16`.
         */
        public List<LabelEntry> labels() { return labels; }
        public Gff _root() { return _root; }
        public Gff.Gff3AfterAurora _parent() { return _parent; }
    }

    /**
     * One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
     */
    public static class LabelEntry extends KaitaiStruct {
        public static LabelEntry fromFile(String fileName) throws IOException {
            return new LabelEntry(new ByteBufferKaitaiStream(fileName));
        }

        public LabelEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LabelEntry(KaitaiStream _io, Gff.LabelArray _parent) {
            this(_io, _parent, null);
        }

        public LabelEntry(KaitaiStream _io, Gff.LabelArray _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.name = new String(this._io.readBytes(16), StandardCharsets.US_ASCII);
        }

        public void _fetchInstances() {
        }
        private String name;
        private Gff _root;
        private Gff.LabelArray _parent;

        /**
         * Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
         * Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
         * Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
         */
        public String name() { return name; }
        public Gff _root() { return _root; }
        public Gff.LabelArray _parent() { return _parent; }
    }

    /**
     * Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
     * Not a separate engine-local datatype. Wire cite: `label_entry.name`.
     */
    public static class LabelEntryTerminated extends KaitaiStruct {
        public static LabelEntryTerminated fromFile(String fileName) throws IOException {
            return new LabelEntryTerminated(new ByteBufferKaitaiStream(fileName));
        }

        public LabelEntryTerminated(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LabelEntryTerminated(KaitaiStream _io, Gff.ResolvedField _parent) {
            this(_io, _parent, null);
        }

        public LabelEntryTerminated(KaitaiStream _io, Gff.ResolvedField _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.name = new String(KaitaiStream.bytesTerminate(this._io.readBytes(16), (byte) 0, false), StandardCharsets.US_ASCII);
        }

        public void _fetchInstances() {
        }
        private String name;
        private Gff _root;
        private Gff.ResolvedField _parent;

        /**
         * Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.
         */
        public String name() { return name; }
        public Gff _root() { return _root; }
        public Gff.ResolvedField _parent() { return _parent; }
    }

    /**
     * One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
     * Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
     */
    public static class ListEntry extends KaitaiStruct {
        public static ListEntry fromFile(String fileName) throws IOException {
            return new ListEntry(new ByteBufferKaitaiStream(fileName));
        }

        public ListEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ListEntry(KaitaiStream _io, Gff.ResolvedField _parent) {
            this(_io, _parent, null);
        }

        public ListEntry(KaitaiStream _io, Gff.ResolvedField _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.numStructIndices = this._io.readU4le();
            this.structIndices = new ArrayList<Long>();
            for (int i = 0; i < numStructIndices(); i++) {
                this.structIndices.add(this._io.readU4le());
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.structIndices.size(); i++) {
            }
        }
        private long numStructIndices;
        private List<Long> structIndices;
        private Gff _root;
        private Gff.ResolvedField _parent;

        /**
         * Little-endian count of following struct indices (list cardinality).
         * Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
         */
        public long numStructIndices() { return numStructIndices; }

        /**
         * Each value indexes `struct_array.entries[index]` (`GFFStructData` row).
         */
        public List<Long> structIndices() { return structIndices; }
        public Gff _root() { return _root; }
        public Gff.ResolvedField _parent() { return _parent; }
    }

    /**
     * Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
     */
    public static class ListIndicesArray extends KaitaiStruct {
        public static ListIndicesArray fromFile(String fileName) throws IOException {
            return new ListIndicesArray(new ByteBufferKaitaiStream(fileName));
        }

        public ListIndicesArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ListIndicesArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent) {
            this(_io, _parent, null);
        }

        public ListIndicesArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.rawData = this._io.readBytes(_root().file().gff3().header().listIndicesCount());
        }

        public void _fetchInstances() {
        }
        private byte[] rawData;
        private Gff _root;
        private Gff.Gff3AfterAurora _parent;

        /**
         * Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
         * Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
         * This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.
         */
        public byte[] rawData() { return rawData; }
        public Gff _root() { return _root; }
        public Gff.Gff3AfterAurora _parent() { return _parent; }
    }

    /**
     * Kaitai composition: one `GFFFieldData` row + label + payload.
     * Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
     * Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
     * For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
     */
    public static class ResolvedField extends KaitaiStruct {

        public ResolvedField(KaitaiStream _io, long fieldIndex) {
            this(_io, null, null, fieldIndex);
        }

        public ResolvedField(KaitaiStream _io, Gff.ResolvedStruct _parent, long fieldIndex) {
            this(_io, _parent, null, fieldIndex);
        }

        public ResolvedField(KaitaiStream _io, Gff.ResolvedStruct _parent, Gff _root, long fieldIndex) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            this.fieldIndex = fieldIndex;
            _read();
        }
        private void _read() {
        }

        public void _fetchInstances() {
            entry();
            if (this.entry != null) {
                this.entry._fetchInstances();
            }
            label();
            if (this.label != null) {
                this.label._fetchInstances();
            }
            listEntry();
            if (this.listEntry != null) {
                this.listEntry._fetchInstances();
            }
            listStructs();
            if (this.listStructs != null) {
                for (int i = 0; i < this.listStructs.size(); i++) {
                    this.listStructs.get(((Number) (i)).intValue())._fetchInstances();
                }
            }
            valueBinary();
            if (this.valueBinary != null) {
                this.valueBinary._fetchInstances();
            }
            valueDouble();
            if (this.valueDouble != null) {
            }
            valueInt16();
            if (this.valueInt16 != null) {
            }
            valueInt32();
            if (this.valueInt32 != null) {
            }
            valueInt64();
            if (this.valueInt64 != null) {
            }
            valueInt8();
            if (this.valueInt8 != null) {
            }
            valueLocalizedString();
            if (this.valueLocalizedString != null) {
                this.valueLocalizedString._fetchInstances();
            }
            valueResref();
            if (this.valueResref != null) {
                this.valueResref._fetchInstances();
            }
            valueSingle();
            if (this.valueSingle != null) {
            }
            valueStrRef();
            if (this.valueStrRef != null) {
            }
            valueString();
            if (this.valueString != null) {
                this.valueString._fetchInstances();
            }
            valueStruct();
            if (this.valueStruct != null) {
                this.valueStruct._fetchInstances();
            }
            valueUint16();
            if (this.valueUint16 != null) {
            }
            valueUint32();
            if (this.valueUint32 != null) {
            }
            valueUint64();
            if (this.valueUint64 != null) {
            }
            valueUint8();
            if (this.valueUint8 != null) {
            }
            valueVector3();
            if (this.valueVector3 != null) {
                this.valueVector3._fetchInstances();
            }
            valueVector4();
            if (this.valueVector4 != null) {
                this.valueVector4._fetchInstances();
            }
        }
        private FieldEntry entry;

        /**
         * Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).
         */
        public FieldEntry entry() {
            if (this.entry != null)
                return this.entry;
            long _pos = this._io.pos();
            this._io.seek(_root().file().gff3().header().fieldOffset() + fieldIndex() * 12);
            this.entry = new FieldEntry(this._io, this, _root);
            this._io.seek(_pos);
            return this.entry;
        }
        private Integer fieldEntryPos;

        /**
         * Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).
         */
        public Integer fieldEntryPos() {
            if (this.fieldEntryPos != null)
                return this.fieldEntryPos;
            this.fieldEntryPos = ((Number) (_root().file().gff3().header().fieldOffset() + fieldIndex() * 12)).intValue();
            return this.fieldEntryPos;
        }
        private LabelEntryTerminated label;

        /**
         * Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.
         */
        public LabelEntryTerminated label() {
            if (this.label != null)
                return this.label;
            long _pos = this._io.pos();
            this._io.seek(_root().file().gff3().header().labelOffset() + entry().labelIndex() * 16);
            this.label = new LabelEntryTerminated(this._io, this, _root);
            this._io.seek(_pos);
            return this.label;
        }
        private ListEntry listEntry;

        /**
         * `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.
         */
        public ListEntry listEntry() {
            if (this.listEntry != null)
                return this.listEntry;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.LIST) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().listIndicesOffset() + entry().dataOrOffset());
                this.listEntry = new ListEntry(this._io, this, _root);
                this._io.seek(_pos);
            }
            return this.listEntry;
        }
        private List<ResolvedStruct> listStructs;

        /**
         * Child structs for this list; indices from `list_entry.struct_indices`.
         */
        public List<ResolvedStruct> listStructs() {
            if (this.listStructs != null)
                return this.listStructs;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.LIST) {
                this.listStructs = new ArrayList<ResolvedStruct>();
                for (int i = 0; i < listEntry().numStructIndices(); i++) {
                    this.listStructs.add(new ResolvedStruct(this._io, this, _root, listEntry().structIndices().get(((Number) (i)).intValue())));
                }
            }
            return this.listStructs;
        }
        private BiowareCommon.BiowareBinaryData valueBinary;

        /**
         * `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
         */
        public BiowareCommon.BiowareBinaryData valueBinary() {
            if (this.valueBinary != null)
                return this.valueBinary;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.BINARY) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldDataOffset() + entry().dataOrOffset());
                this.valueBinary = new BiowareCommon.BiowareBinaryData(this._io);
                this._io.seek(_pos);
            }
            return this.valueBinary;
        }
        private Double valueDouble;

        /**
         * `GFFFieldTypes` 9 (double).
         */
        public Double valueDouble() {
            if (this.valueDouble != null)
                return this.valueDouble;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.DOUBLE) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldDataOffset() + entry().dataOrOffset());
                this.valueDouble = this._io.readF8le();
                this._io.seek(_pos);
            }
            return this.valueDouble;
        }
        private Short valueInt16;

        /**
         * `GFFFieldTypes` 3 (INT16 LE at +8).
         */
        public Short valueInt16() {
            if (this.valueInt16 != null)
                return this.valueInt16;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.INT16) {
                long _pos = this._io.pos();
                this._io.seek(fieldEntryPos() + 8);
                this.valueInt16 = this._io.readS2le();
                this._io.seek(_pos);
            }
            return this.valueInt16;
        }
        private Integer valueInt32;

        /**
         * `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
         */
        public Integer valueInt32() {
            if (this.valueInt32 != null)
                return this.valueInt32;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.INT32) {
                long _pos = this._io.pos();
                this._io.seek(fieldEntryPos() + 8);
                this.valueInt32 = this._io.readS4le();
                this._io.seek(_pos);
            }
            return this.valueInt32;
        }
        private Long valueInt64;

        /**
         * `GFFFieldTypes` 7 (INT64).
         */
        public Long valueInt64() {
            if (this.valueInt64 != null)
                return this.valueInt64;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.INT64) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldDataOffset() + entry().dataOrOffset());
                this.valueInt64 = this._io.readS8le();
                this._io.seek(_pos);
            }
            return this.valueInt64;
        }
        private Byte valueInt8;

        /**
         * `GFFFieldTypes` 1 (INT8 in low byte of slot).
         */
        public Byte valueInt8() {
            if (this.valueInt8 != null)
                return this.valueInt8;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.INT8) {
                long _pos = this._io.pos();
                this._io.seek(fieldEntryPos() + 8);
                this.valueInt8 = this._io.readS1();
                this._io.seek(_pos);
            }
            return this.valueInt8;
        }
        private BiowareCommon.BiowareLocstring valueLocalizedString;

        /**
         * `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
         */
        public BiowareCommon.BiowareLocstring valueLocalizedString() {
            if (this.valueLocalizedString != null)
                return this.valueLocalizedString;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.LOCALIZED_STRING) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldDataOffset() + entry().dataOrOffset());
                this.valueLocalizedString = new BiowareCommon.BiowareLocstring(this._io);
                this._io.seek(_pos);
            }
            return this.valueLocalizedString;
        }
        private BiowareCommon.BiowareResref valueResref;

        /**
         * `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
         */
        public BiowareCommon.BiowareResref valueResref() {
            if (this.valueResref != null)
                return this.valueResref;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.RESREF) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldDataOffset() + entry().dataOrOffset());
                this.valueResref = new BiowareCommon.BiowareResref(this._io);
                this._io.seek(_pos);
            }
            return this.valueResref;
        }
        private Float valueSingle;

        /**
         * `GFFFieldTypes` 8 (32-bit float).
         */
        public Float valueSingle() {
            if (this.valueSingle != null)
                return this.valueSingle;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.SINGLE) {
                long _pos = this._io.pos();
                this._io.seek(fieldEntryPos() + 8);
                this.valueSingle = this._io.readF4le();
                this._io.seek(_pos);
            }
            return this.valueSingle;
        }
        private Long valueStrRef;

        /**
         * `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
         * `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
         * **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
         * Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
         * PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
         */
        public Long valueStrRef() {
            if (this.valueStrRef != null)
                return this.valueStrRef;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.STR_REF) {
                long _pos = this._io.pos();
                this._io.seek(fieldEntryPos() + 8);
                this.valueStrRef = this._io.readU4le();
                this._io.seek(_pos);
            }
            return this.valueStrRef;
        }
        private BiowareCommon.BiowareCexoString valueString;

        /**
         * `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
         */
        public BiowareCommon.BiowareCexoString valueString() {
            if (this.valueString != null)
                return this.valueString;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.STRING) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldDataOffset() + entry().dataOrOffset());
                this.valueString = new BiowareCommon.BiowareCexoString(this._io);
                this._io.seek(_pos);
            }
            return this.valueString;
        }
        private ResolvedStruct valueStruct;

        /**
         * `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.
         */
        public ResolvedStruct valueStruct() {
            if (this.valueStruct != null)
                return this.valueStruct;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.STRUCT) {
                this.valueStruct = new ResolvedStruct(this._io, this, _root, entry().dataOrOffset());
            }
            return this.valueStruct;
        }
        private Integer valueUint16;

        /**
         * `GFFFieldTypes` 2 (UINT16 LE at +8).
         */
        public Integer valueUint16() {
            if (this.valueUint16 != null)
                return this.valueUint16;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.UINT16) {
                long _pos = this._io.pos();
                this._io.seek(fieldEntryPos() + 8);
                this.valueUint16 = this._io.readU2le();
                this._io.seek(_pos);
            }
            return this.valueUint16;
        }
        private Long valueUint32;

        /**
         * `GFFFieldTypes` 4 (full inline DWORD).
         */
        public Long valueUint32() {
            if (this.valueUint32 != null)
                return this.valueUint32;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.UINT32) {
                long _pos = this._io.pos();
                this._io.seek(fieldEntryPos() + 8);
                this.valueUint32 = this._io.readU4le();
                this._io.seek(_pos);
            }
            return this.valueUint32;
        }
        private Long valueUint64;

        /**
         * `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
         */
        public Long valueUint64() {
            if (this.valueUint64 != null)
                return this.valueUint64;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.UINT64) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldDataOffset() + entry().dataOrOffset());
                this.valueUint64 = this._io.readU8le();
                this._io.seek(_pos);
            }
            return this.valueUint64;
        }
        private Integer valueUint8;

        /**
         * `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
         */
        public Integer valueUint8() {
            if (this.valueUint8 != null)
                return this.valueUint8;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.UINT8) {
                long _pos = this._io.pos();
                this._io.seek(fieldEntryPos() + 8);
                this.valueUint8 = this._io.readU1();
                this._io.seek(_pos);
            }
            return this.valueUint8;
        }
        private BiowareCommon.BiowareVector3 valueVector3;

        /**
         * `GFFFieldTypes` 17 — three floats (`bioware_vector3`).
         */
        public BiowareCommon.BiowareVector3 valueVector3() {
            if (this.valueVector3 != null)
                return this.valueVector3;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.VECTOR3) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldDataOffset() + entry().dataOrOffset());
                this.valueVector3 = new BiowareCommon.BiowareVector3(this._io);
                this._io.seek(_pos);
            }
            return this.valueVector3;
        }
        private BiowareCommon.BiowareVector4 valueVector4;

        /**
         * `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
         */
        public BiowareCommon.BiowareVector4 valueVector4() {
            if (this.valueVector4 != null)
                return this.valueVector4;
            if (entry().fieldType() == BiowareGffCommon.GffFieldType.VECTOR4) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldDataOffset() + entry().dataOrOffset());
                this.valueVector4 = new BiowareCommon.BiowareVector4(this._io);
                this._io.seek(_pos);
            }
            return this.valueVector4;
        }
        private long fieldIndex;
        private Gff _root;
        private Gff.ResolvedStruct _parent;

        /**
         * Index into `field_array.entries`; require `field_index < field_count`.
         */
        public long fieldIndex() { return fieldIndex; }
        public Gff _root() { return _root; }
        public Gff.ResolvedStruct _parent() { return _parent; }
    }

    /**
     * Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
     * On-disk row remains at `struct_offset + struct_index * 12`.
     */
    public static class ResolvedStruct extends KaitaiStruct {

        public ResolvedStruct(KaitaiStream _io, long structIndex) {
            this(_io, null, null, structIndex);
        }

        public ResolvedStruct(KaitaiStream _io, KaitaiStruct _parent, long structIndex) {
            this(_io, _parent, null, structIndex);
        }

        public ResolvedStruct(KaitaiStream _io, KaitaiStruct _parent, Gff _root, long structIndex) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            this.structIndex = structIndex;
            _read();
        }
        private void _read() {
        }

        public void _fetchInstances() {
            entry();
            if (this.entry != null) {
                this.entry._fetchInstances();
            }
            fieldIndices();
            if (this.fieldIndices != null) {
                for (int i = 0; i < this.fieldIndices.size(); i++) {
                }
            }
            fields();
            if (this.fields != null) {
                for (int i = 0; i < this.fields.size(); i++) {
                    this.fields.get(((Number) (i)).intValue())._fetchInstances();
                }
            }
            singleField();
            if (this.singleField != null) {
                this.singleField._fetchInstances();
            }
        }
        private StructEntry entry;

        /**
         * Raw `GFFStructData` (12-byte layout in **observed behavior**).
         */
        public StructEntry entry() {
            if (this.entry != null)
                return this.entry;
            long _pos = this._io.pos();
            this._io.seek(_root().file().gff3().header().structOffset() + structIndex() * 12);
            this.entry = new StructEntry(this._io, this, _root);
            this._io.seek(_pos);
            return this.entry;
        }
        private List<Long> fieldIndices;

        /**
         * Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
         * Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
         */
        public List<Long> fieldIndices() {
            if (this.fieldIndices != null)
                return this.fieldIndices;
            if (entry().fieldCount() > 1) {
                long _pos = this._io.pos();
                this._io.seek(_root().file().gff3().header().fieldIndicesOffset() + entry().dataOrOffset());
                this.fieldIndices = new ArrayList<Long>();
                for (int i = 0; i < entry().fieldCount(); i++) {
                    this.fieldIndices.add(this._io.readU4le());
                }
                this._io.seek(_pos);
            }
            return this.fieldIndices;
        }
        private List<ResolvedField> fields;

        /**
         * One `resolved_field` per entry in `field_indices`.
         */
        public List<ResolvedField> fields() {
            if (this.fields != null)
                return this.fields;
            if (entry().fieldCount() > 1) {
                this.fields = new ArrayList<ResolvedField>();
                for (int i = 0; i < entry().fieldCount(); i++) {
                    this.fields.add(new ResolvedField(this._io, this, _root, fieldIndices().get(((Number) (i)).intValue())));
                }
            }
            return this.fields;
        }
        private ResolvedField singleField;

        /**
         * `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).
         */
        public ResolvedField singleField() {
            if (this.singleField != null)
                return this.singleField;
            if (entry().fieldCount() == 1) {
                this.singleField = new ResolvedField(this._io, this, _root, entry().dataOrOffset());
            }
            return this.singleField;
        }
        private long structIndex;
        private Gff _root;
        private KaitaiStruct _parent;

        /**
         * Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.
         */
        public long structIndex() { return structIndex; }
        public Gff _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Name in **observed behavior**: `GFFStructData`.
     * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
     */
    public static class StructArray extends KaitaiStruct {
        public static StructArray fromFile(String fileName) throws IOException {
            return new StructArray(new ByteBufferKaitaiStream(fileName));
        }

        public StructArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public StructArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent) {
            this(_io, _parent, null);
        }

        public StructArray(KaitaiStream _io, Gff.Gff3AfterAurora _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<StructEntry>();
            for (int i = 0; i < _root().file().gff3().header().structCount(); i++) {
                this.entries.add(new StructEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<StructEntry> entries;
        private Gff _root;
        private Gff.Gff3AfterAurora _parent;

        /**
         * Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
         * Stride 12 bytes per struct (matches the component layout in **observed behavior**).
         */
        public List<StructEntry> entries() { return entries; }
        public Gff _root() { return _root; }
        public Gff.Gff3AfterAurora _parent() { return _parent; }
    }

    /**
     * One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
     */
    public static class StructEntry extends KaitaiStruct {
        public static StructEntry fromFile(String fileName) throws IOException {
            return new StructEntry(new ByteBufferKaitaiStream(fileName));
        }

        public StructEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public StructEntry(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public StructEntry(KaitaiStream _io, KaitaiStruct _parent, Gff _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.structId = this._io.readU4le();
            this.dataOrOffset = this._io.readU4le();
            this.fieldCount = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private Long fieldIndicesOffset;

        /**
         * Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.
         */
        public Long fieldIndicesOffset() {
            if (this.fieldIndicesOffset != null)
                return this.fieldIndicesOffset;
            if (hasMultipleFields()) {
                this.fieldIndicesOffset = ((Number) (dataOrOffset())).longValue();
            }
            return this.fieldIndicesOffset;
        }
        private Boolean hasMultipleFields;

        /**
         * Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
         */
        public Boolean hasMultipleFields() {
            if (this.hasMultipleFields != null)
                return this.hasMultipleFields;
            this.hasMultipleFields = fieldCount() > 1;
            return this.hasMultipleFields;
        }
        private Boolean hasSingleField;

        /**
         * Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
         * Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         */
        public Boolean hasSingleField() {
            if (this.hasSingleField != null)
                return this.hasSingleField;
            this.hasSingleField = fieldCount() == 1;
            return this.hasSingleField;
        }
        private Long singleFieldIndex;

        /**
         * Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
         */
        public Long singleFieldIndex() {
            if (this.singleFieldIndex != null)
                return this.singleFieldIndex;
            if (hasSingleField()) {
                this.singleFieldIndex = ((Number) (dataOrOffset())).longValue();
            }
            return this.singleFieldIndex;
        }
        private long structId;
        private long dataOrOffset;
        private long fieldCount;
        private Gff _root;
        private KaitaiStruct _parent;

        /**
         * Structure type identifier.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         * 0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.
         */
        public long structId() { return structId; }

        /**
         * Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
         * If field_count == 0, this value is unused.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
         */
        public long dataOrOffset() { return dataOrOffset; }

        /**
         * Number of fields in this struct:
         * - 0: No fields
         * - 1: Single field, data_or_offset contains the field index directly
         * - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.field_count` @ +0x8 (ulong).
         */
        public long fieldCount() { return fieldCount; }
        public Gff _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }
    private GffUnionFile file;
    private Gff _root;
    private KaitaiStruct _parent;

    /**
     * Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
     * (`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
     * Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
     * mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
     * downstream `pos:` / `_root.file.gff3.header` paths.
     */
    public GffUnionFile file() { return file; }
    public Gff _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
