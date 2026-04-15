<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

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
 * **Ghidra / VMA:** engine record names and addresses live on the `seq` / `types` nodes they justify, not in this blurb.
 * 
 * **Pinned URLs and tool history:** `meta.xref` (alphabetical keys). Coverage matrix: `docs/XOREOS_FORMAT_COVERAGE.md`.
 */

namespace {
    class Gff extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_file = new \Gff\GffUnionFile($this->_io, $this, $this->_root);
        }
        protected $_m_file;

        /**
         * Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
         * (`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
         * Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
         * mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
         * downstream `pos:` / `_root.file.gff3.header` paths.
         */
        public function file() { return $this->_m_file; }
    }
}

/**
 * Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
 * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
 */

namespace Gff {
    class FieldArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\Gff3AfterAurora $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->file()->gff3()->header()->fieldCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Gff\FieldEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
         * Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).
         */
        public function entries() { return $this->_m_entries; }
    }
}

/**
 * Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
 */

namespace Gff {
    class FieldData extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\Gff3AfterAurora $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_rawData = $this->_io->readBytes($this->_root()->file()->gff3()->header()->fieldDataCount());
        }
        protected $_m_rawData;

        /**
         * Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
         * Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
         * Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
         */
        public function rawData() { return $this->_m_rawData; }
    }
}

/**
 * One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
 * `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
 * Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
 */

namespace Gff {
    class FieldEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fieldType = $this->_io->readU4le();
            $this->_m_labelIndex = $this->_io->readU4le();
            $this->_m_dataOrOffset = $this->_io->readU4le();
        }
        protected $_m_fieldDataOffsetValue;

        /**
         * Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
         */
        public function fieldDataOffsetValue() {
            if ($this->_m_fieldDataOffsetValue !== null)
                return $this->_m_fieldDataOffsetValue;
            if ($this->isComplexType()) {
                $this->_m_fieldDataOffsetValue = $this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->dataOrOffset();
            }
            return $this->_m_fieldDataOffsetValue;
        }
        protected $_m_isComplexType;

        /**
         * Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
         */
        public function isComplexType() {
            if ($this->_m_isComplexType !== null)
                return $this->_m_isComplexType;
            $this->_m_isComplexType =  (($this->fieldType() == \BiowareGffCommon\GffFieldType::UINT64) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::INT64) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::DOUBLE) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::STRING) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::RESREF) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::LOCALIZED_STRING) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::BINARY) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::VECTOR4) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::VECTOR3)) ;
            return $this->_m_isComplexType;
        }
        protected $_m_isListType;

        /**
         * Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
         */
        public function isListType() {
            if ($this->_m_isListType !== null)
                return $this->_m_isListType;
            $this->_m_isListType = $this->fieldType() == \BiowareGffCommon\GffFieldType::LIST;
            return $this->_m_isListType;
        }
        protected $_m_isSimpleType;

        /**
         * Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
         * Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
         * **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
         */
        public function isSimpleType() {
            if ($this->_m_isSimpleType !== null)
                return $this->_m_isSimpleType;
            $this->_m_isSimpleType =  (($this->fieldType() == \BiowareGffCommon\GffFieldType::UINT8) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::INT8) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::UINT16) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::INT16) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::UINT32) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::INT32) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::SINGLE) || ($this->fieldType() == \BiowareGffCommon\GffFieldType::STR_REF)) ;
            return $this->_m_isSimpleType;
        }
        protected $_m_isStructType;

        /**
         * Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
         */
        public function isStructType() {
            if ($this->_m_isStructType !== null)
                return $this->_m_isStructType;
            $this->_m_isStructType = $this->fieldType() == \BiowareGffCommon\GffFieldType::STRUCT;
            return $this->_m_isStructType;
        }
        protected $_m_listIndicesOffsetValue;

        /**
         * Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.
         */
        public function listIndicesOffsetValue() {
            if ($this->_m_listIndicesOffsetValue !== null)
                return $this->_m_listIndicesOffsetValue;
            if ($this->isListType()) {
                $this->_m_listIndicesOffsetValue = $this->_root()->file()->gff3()->header()->listIndicesOffset() + $this->dataOrOffset();
            }
            return $this->_m_listIndicesOffsetValue;
        }
        protected $_m_structIndexValue;

        /**
         * Struct index (same numeric interpretation as `GFFStructData` row index).
         */
        public function structIndexValue() {
            if ($this->_m_structIndexValue !== null)
                return $this->_m_structIndexValue;
            if ($this->isStructType()) {
                $this->_m_structIndexValue = $this->dataOrOffset();
            }
            return $this->_m_structIndexValue;
        }
        protected $_m_fieldType;
        protected $_m_labelIndex;
        protected $_m_dataOrOffset;

        /**
         * Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
         * (ID → storage: inline vs `field_data` vs struct/list indirection).
         * Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
         * Source: Ghidra `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
         * Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
         * PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
         */
        public function fieldType() { return $this->_m_fieldType; }

        /**
         * Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
         * Source: Ghidra `GFFFieldData.label_index` @ +0x4 (ulong).
         */
        public function labelIndex() { return $this->_m_labelIndex; }

        /**
         * Inline data (simple types) or offset/index (complex types):
         * - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
         * - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
         * - Struct (14): Struct index (index into struct_array)
         * - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
         * Source: Ghidra `GFFFieldData.data_or_data_offset` @ +0x8.
         * `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
         */
        public function dataOrOffset() { return $this->_m_dataOrOffset; }
    }
}

/**
 * Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
 * “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
 */

namespace Gff {
    class FieldIndicesArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\Gff3AfterAurora $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_indices = [];
            $n = $this->_root()->file()->gff3()->header()->fieldIndicesCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_indices[] = $this->_io->readU4le();
            }
        }
        protected $_m_indices;

        /**
         * `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
         * `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
         * Ghidra: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.
         */
        public function indices() { return $this->_m_indices; }
    }
}

/**
 * GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.
 */

namespace Gff {
    class Gff3AfterAurora extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\GffUnionFile $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Gff\GffHeaderTail($this->_io, $this, $this->_root);
        }
        protected $_m_fieldArray;

        /**
         * Field dictionary: `header.field_count` × 12 B at `header.field_offset`. Ghidra: `GFFFieldData`.
         * `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
         *     PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149
         */
        public function fieldArray() {
            if ($this->_m_fieldArray !== null)
                return $this->_m_fieldArray;
            if ($this->header()->fieldCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->fieldOffset());
                $this->_m_fieldArray = new \Gff\FieldArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_fieldArray;
        }
        protected $_m_fieldData;

        /**
         * Complex-type payload heap. Ghidra: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
         *     PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216
         */
        public function fieldData() {
            if ($this->_m_fieldData !== null)
                return $this->_m_fieldData;
            if ($this->header()->fieldDataCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->fieldDataOffset());
                $this->_m_fieldData = new \Gff\FieldData($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_fieldData;
        }
        protected $_m_fieldIndicesArray;

        /**
         * Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
         * Ghidra: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
         *     PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
         */
        public function fieldIndicesArray() {
            if ($this->_m_fieldIndicesArray !== null)
                return $this->_m_fieldIndicesArray;
            if ($this->header()->fieldIndicesCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->fieldIndicesOffset());
                $this->_m_fieldIndicesArray = new \Gff\FieldIndicesArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_fieldIndicesArray;
        }
        protected $_m_labelArray;

        /**
         * Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
         * Ghidra: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
         *     PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154
         */
        public function labelArray() {
            if ($this->_m_labelArray !== null)
                return $this->_m_labelArray;
            if ($this->header()->labelCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->labelOffset());
                $this->_m_labelArray = new \Gff\LabelArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_labelArray;
        }
        protected $_m_listIndicesArray;

        /**
         * Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
         * Ghidra: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
         *     PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
         */
        public function listIndicesArray() {
            if ($this->_m_listIndicesArray !== null)
                return $this->_m_listIndicesArray;
            if ($this->header()->listIndicesCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->listIndicesOffset());
                $this->_m_listIndicesArray = new \Gff\ListIndicesArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_listIndicesArray;
        }
        protected $_m_rootStructResolved;

        /**
         * Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
         * Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
         * Implements the access pattern described in meta.doc (single-field vs multi-field structs).
         */
        public function rootStructResolved() {
            if ($this->_m_rootStructResolved !== null)
                return $this->_m_rootStructResolved;
            $this->_m_rootStructResolved = new \Gff\ResolvedStruct(0, $this->_io, $this, $this->_root);
            return $this->_m_rootStructResolved;
        }
        protected $_m_structArray;

        /**
         * Struct table: `header.struct_count` × 12 B at `header.struct_offset`. Ghidra: `GFFStructData` rows.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         *     PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65
         */
        public function structArray() {
            if ($this->_m_structArray !== null)
                return $this->_m_structArray;
            if ($this->header()->structCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->structOffset());
                $this->_m_structArray = new \Gff\StructArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_structArray;
        }
        protected $_m_header;

        /**
         * Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
         * rows from Struct Array Offset through List Indices Count. Ghidra: `GFFHeaderInfo` @ +0x8 … +0x34.
         */
        public function header() { return $this->_m_header; }
    }
}

/**
 * GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
 * PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
 */

namespace Gff {
    class Gff4AfterAurora extends \Kaitai\Struct\Struct {
        public function __construct(int $auroraVersion, \Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_m_auroraVersion = $auroraVersion;
            $this->_read();
        }

        private function _read() {
            $this->_m_platformId = $this->_io->readU4be();
            $this->_m_fileType = $this->_io->readU4be();
            $this->_m_typeVersion = $this->_io->readU4be();
            $this->_m_numStructTemplates = $this->_io->readU4le();
            if ($this->auroraVersion() == 1446260273) {
                $this->_m_stringCount = $this->_io->readU4le();
            }
            if ($this->auroraVersion() == 1446260273) {
                $this->_m_stringOffset = $this->_io->readU4le();
            }
            $this->_m_dataOffset = $this->_io->readU4le();
            $this->_m_structTemplates = [];
            $n = $this->numStructTemplates();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_structTemplates[] = new \Gff\Gff4StructTemplateHeader($this->_io, $this, $this->_root);
            }
            $this->_m_tail = $this->_io->readBytesFull();
        }
        protected $_m_platformId;
        protected $_m_fileType;
        protected $_m_typeVersion;
        protected $_m_numStructTemplates;
        protected $_m_stringCount;
        protected $_m_stringOffset;
        protected $_m_dataOffset;
        protected $_m_structTemplates;
        protected $_m_tail;
        protected $_m_auroraVersion;

        /**
         * Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
         * `PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).
         */
        public function platformId() { return $this->_m_platformId; }

        /**
         * GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
         * `readUint32BE` on the endian-aware substream (`gff4file.cpp`).
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).
         */
        public function typeVersion() { return $this->_m_typeVersion; }

        /**
         * Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
         * in typical DA assets). xoreos: `_header.structCount`.
         */
        public function numStructTemplates() { return $this->_m_numStructTemplates; }

        /**
         * V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).
         */
        public function stringCount() { return $this->_m_stringCount; }

        /**
         * V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).
         */
        public function stringOffset() { return $this->_m_stringOffset; }

        /**
         * Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
         * `readUint32` on the endian substream (`gff4file.cpp`).
         */
        public function dataOffset() { return $this->_m_dataOffset; }

        /**
         * Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).
         */
        public function structTemplates() { return $this->_m_structTemplates; }

        /**
         * Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
         * optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
         * GFF4 graph walker or defer to engine code.
         */
        public function tail() { return $this->_m_tail; }

        /**
         * Aurora version tag from the enclosing stream’s first 8 bytes (read on disk as `u4be`;
         * passed as `u4` for Kaitai param typing). Same value as `gff_union_file.aurora_version` / `gff4_file.aurora_version`.
         */
        public function auroraVersion() { return $this->_m_auroraVersion; }
    }
}

/**
 * Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
 * that expect a single user-type over the whole file.
 */

namespace Gff {
    class Gff4File extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_auroraMagic = $this->_io->readU4be();
            $this->_m_auroraVersion = $this->_io->readU4be();
            $this->_m_gff4 = new \Gff\Gff4AfterAurora($this->auroraVersion(), $this->_io, $this, $this->_root);
        }
        protected $_m_auroraMagic;
        protected $_m_auroraVersion;
        protected $_m_gff4;

        /**
         * Aurora container magic (`GFF ` as `u4be`).
         */
        public function auroraMagic() { return $this->_m_auroraMagic; }

        /**
         * GFF4 `V4.0` / `V4.1` on-disk tags.
         */
        public function auroraVersion() { return $this->_m_auroraVersion; }

        /**
         * GFF4 header tail + struct templates + opaque remainder.
         */
        public function gff4() { return $this->_m_gff4; }
    }
}

namespace Gff {
    class Gff4StructTemplateHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\Gff4AfterAurora $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_structLabel = $this->_io->readU4be();
            $this->_m_fieldCount = $this->_io->readU4le();
            $this->_m_fieldOffset = $this->_io->readU4le();
            $this->_m_structSize = $this->_io->readU4le();
        }
        protected $_m_structLabel;
        protected $_m_fieldCount;
        protected $_m_fieldOffset;
        protected $_m_structSize;

        /**
         * Template label (fourCC style, read `readUint32BE` in `loadStructs`).
         */
        public function structLabel() { return $this->_m_structLabel; }

        /**
         * Number of field declaration records for this template (may be 0).
         */
        public function fieldCount() { return $this->_m_fieldCount; }

        /**
         * Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
         * (xoreos `continue`s without reading declarations).
         */
        public function fieldOffset() { return $this->_m_fieldOffset; }

        /**
         * Declared on-disk struct size for instances of this template (`strct.size`).
         */
        public function structSize() { return $this->_m_structSize; }
    }
}

/**
 * **GFF3** header continuation: **48 bytes** (twelve LE `u32` dwords) at file offsets **0x08–0x37**, immediately
 * after the shared Aurora 8-byte prefix (`aurora_magic` / `aurora_version` on `gff_union_file`). Same layout as
 * wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) rows from “Struct Array
 * Offset” through “List Indices Count”. Ghidra `/K1/k1_win_gog_swkotor.exe`: `GFFHeaderInfo` @ +0x8 … +0x34.
 * 
 * Sources (same DWORD order on disk after the 8-byte signature):
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 (`file_type`/`file_version` L79–L80 then twelve header `u32`s L93–L106)
 * - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L44 (`GffReader::load` — skips 8-byte signature, reads twelve header `u32`s L30–L41)
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
 * - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 (Aurora/GFF-family background; MultiMap wording)
 */

namespace Gff {
    class GffHeaderTail extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\Gff3AfterAurora $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_structOffset = $this->_io->readU4le();
            $this->_m_structCount = $this->_io->readU4le();
            $this->_m_fieldOffset = $this->_io->readU4le();
            $this->_m_fieldCount = $this->_io->readU4le();
            $this->_m_labelOffset = $this->_io->readU4le();
            $this->_m_labelCount = $this->_io->readU4le();
            $this->_m_fieldDataOffset = $this->_io->readU4le();
            $this->_m_fieldDataCount = $this->_io->readU4le();
            $this->_m_fieldIndicesOffset = $this->_io->readU4le();
            $this->_m_fieldIndicesCount = $this->_io->readU4le();
            $this->_m_listIndicesOffset = $this->_io->readU4le();
            $this->_m_listIndicesCount = $this->_io->readU4le();
        }
        protected $_m_structOffset;
        protected $_m_structCount;
        protected $_m_fieldOffset;
        protected $_m_fieldCount;
        protected $_m_labelOffset;
        protected $_m_labelCount;
        protected $_m_fieldDataOffset;
        protected $_m_fieldDataCount;
        protected $_m_fieldIndicesOffset;
        protected $_m_fieldIndicesCount;
        protected $_m_listIndicesOffset;
        protected $_m_listIndicesCount;

        /**
         * Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
         * Source: Ghidra `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30
         */
        public function structOffset() { return $this->_m_structOffset; }

        /**
         * Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
         * Source: Ghidra `GFFHeaderInfo.struct_count` @ +0xC (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31
         */
        public function structCount() { return $this->_m_structCount; }

        /**
         * Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
         * Source: Ghidra `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32
         */
        public function fieldOffset() { return $this->_m_fieldOffset; }

        /**
         * Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
         * Source: Ghidra `GFFHeaderInfo.field_count` @ +0x14 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33
         */
        public function fieldCount() { return $this->_m_fieldCount; }

        /**
         * Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
         * Source: Ghidra `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34
         */
        public function labelOffset() { return $this->_m_labelOffset; }

        /**
         * Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
         * Source: Ghidra `GFFHeaderInfo.label_count` @ +0x1C (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35
         */
        public function labelCount() { return $this->_m_labelCount; }

        /**
         * Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
         * Source: Ghidra `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36
         */
        public function fieldDataOffset() { return $this->_m_fieldDataOffset; }

        /**
         * Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
         * Source: Ghidra `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37
         */
        public function fieldDataCount() { return $this->_m_fieldDataCount; }

        /**
         * Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
         * Source: Ghidra `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38
         */
        public function fieldIndicesOffset() { return $this->_m_fieldIndicesOffset; }

        /**
         * Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
         * Source: Ghidra `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)
         */
        public function fieldIndicesCount() { return $this->_m_fieldIndicesCount; }

        /**
         * Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
         * Source: Ghidra `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40
         */
        public function listIndicesOffset() { return $this->_m_listIndicesOffset; }

        /**
         * List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
         * Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
         * Source: Ghidra `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
         */
        public function listIndicesCount() { return $this->_m_listIndicesCount; }
    }
}

/**
 * Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
 * (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
 */

namespace Gff {
    class GffUnionFile extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_auroraMagic = $this->_io->readU4be();
            $this->_m_auroraVersion = $this->_io->readU4be();
            if ( (($this->auroraVersion() != 1446260272) && ($this->auroraVersion() != 1446260273)) ) {
                $this->_m_gff3 = new \Gff\Gff3AfterAurora($this->_io, $this, $this->_root);
            }
            if ( (($this->auroraVersion() == 1446260272) || ($this->auroraVersion() == 1446260273)) ) {
                $this->_m_gff4 = new \Gff\Gff4AfterAurora($this->auroraVersion(), $this->_io, $this, $this->_root);
            }
        }
        protected $_m_auroraMagic;
        protected $_m_auroraVersion;
        protected $_m_gff3;
        protected $_m_gff4;

        /**
         * File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
         * legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.
         */
        public function auroraMagic() { return $this->_m_auroraMagic; }

        /**
         * Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
         * `0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.
         */
        public function auroraVersion() { return $this->_m_auroraVersion; }

        /**
         * **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.
         */
        public function gff3() { return $this->_m_gff3; }

        /**
         * **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.
         */
        public function gff4() { return $this->_m_gff4; }
    }
}

/**
 * Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
 * Indexed by `GFFFieldData.label_index` (×16). Not a separate Ghidra struct — rows are `char[16]` in bulk.
 * Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
 */

namespace Gff {
    class LabelArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\Gff3AfterAurora $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_labels = [];
            $n = $this->_root()->file()->gff3()->header()->labelCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_labels[] = new \Gff\LabelEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_labels;

        /**
         * Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
         * Index `i` is at file offset `label_offset + i*16`.
         */
        public function labels() { return $this->_m_labels; }
    }
}

/**
 * One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
 */

namespace Gff {
    class LabelEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\LabelArray $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_name = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(16), "ASCII");
        }
        protected $_m_name;

        /**
         * Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
         * Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
         * Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
         */
        public function name() { return $this->_m_name; }
    }
}

/**
 * Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
 * Not a separate Ghidra datatype. Wire cite: `label_entry.name`.
 */

namespace Gff {
    class LabelEntryTerminated extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\ResolvedField $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_name = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(16), 0, false), "ASCII");
        }
        protected $_m_name;

        /**
         * Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.
         */
        public function name() { return $this->_m_name; }
    }
}

/**
 * One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
 * Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
 */

namespace Gff {
    class ListEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\ResolvedField $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_numStructIndices = $this->_io->readU4le();
            $this->_m_structIndices = [];
            $n = $this->numStructIndices();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_structIndices[] = $this->_io->readU4le();
            }
        }
        protected $_m_numStructIndices;
        protected $_m_structIndices;

        /**
         * Little-endian count of following struct indices (list cardinality).
         * Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
         */
        public function numStructIndices() { return $this->_m_numStructIndices; }

        /**
         * Each value indexes `struct_array.entries[index]` (`GFFStructData` row).
         */
        public function structIndices() { return $this->_m_structIndices; }
    }
}

/**
 * Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
 */

namespace Gff {
    class ListIndicesArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\Gff3AfterAurora $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_rawData = $this->_io->readBytes($this->_root()->file()->gff3()->header()->listIndicesCount());
        }
        protected $_m_rawData;

        /**
         * Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
         * Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
         * This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.
         */
        public function rawData() { return $this->_m_rawData; }
    }
}

/**
 * Kaitai composition: one `GFFFieldData` row + label + payload.
 * Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
 * Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
 * For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
 */

namespace Gff {
    class ResolvedField extends \Kaitai\Struct\Struct {
        public function __construct(int $fieldIndex, \Kaitai\Struct\Stream $_io, ?\Gff\ResolvedStruct $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_m_fieldIndex = $fieldIndex;
            $this->_read();
        }

        private function _read() {
        }
        protected $_m_entry;

        /**
         * Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).
         */
        public function entry() {
            if ($this->_m_entry !== null)
                return $this->_m_entry;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->_root()->file()->gff3()->header()->fieldOffset() + $this->fieldIndex() * 12);
            $this->_m_entry = new \Gff\FieldEntry($this->_io, $this, $this->_root);
            $this->_io->seek($_pos);
            return $this->_m_entry;
        }
        protected $_m_fieldEntryPos;

        /**
         * Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).
         */
        public function fieldEntryPos() {
            if ($this->_m_fieldEntryPos !== null)
                return $this->_m_fieldEntryPos;
            $this->_m_fieldEntryPos = $this->_root()->file()->gff3()->header()->fieldOffset() + $this->fieldIndex() * 12;
            return $this->_m_fieldEntryPos;
        }
        protected $_m_label;

        /**
         * Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.
         */
        public function label() {
            if ($this->_m_label !== null)
                return $this->_m_label;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->_root()->file()->gff3()->header()->labelOffset() + $this->entry()->labelIndex() * 16);
            $this->_m_label = new \Gff\LabelEntryTerminated($this->_io, $this, $this->_root);
            $this->_io->seek($_pos);
            return $this->_m_label;
        }
        protected $_m_listEntry;

        /**
         * `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.
         */
        public function listEntry() {
            if ($this->_m_listEntry !== null)
                return $this->_m_listEntry;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::LIST) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->listIndicesOffset() + $this->entry()->dataOrOffset());
                $this->_m_listEntry = new \Gff\ListEntry($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_listEntry;
        }
        protected $_m_listStructs;

        /**
         * Child structs for this list; indices from `list_entry.struct_indices`.
         */
        public function listStructs() {
            if ($this->_m_listStructs !== null)
                return $this->_m_listStructs;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::LIST) {
                $this->_m_listStructs = [];
                $n = $this->listEntry()->numStructIndices();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_listStructs[] = new \Gff\ResolvedStruct($this->listEntry()->structIndices()[$i], $this->_io, $this, $this->_root);
                }
            }
            return $this->_m_listStructs;
        }
        protected $_m_valueBinary;

        /**
         * `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
         */
        public function valueBinary() {
            if ($this->_m_valueBinary !== null)
                return $this->_m_valueBinary;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::BINARY) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->entry()->dataOrOffset());
                $this->_m_valueBinary = new \BiowareCommon\BiowareBinaryData($this->_io);
                $this->_io->seek($_pos);
            }
            return $this->_m_valueBinary;
        }
        protected $_m_valueDouble;

        /**
         * `GFFFieldTypes` 9 (double).
         */
        public function valueDouble() {
            if ($this->_m_valueDouble !== null)
                return $this->_m_valueDouble;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::DOUBLE) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->entry()->dataOrOffset());
                $this->_m_valueDouble = $this->_io->readF8le();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueDouble;
        }
        protected $_m_valueInt16;

        /**
         * `GFFFieldTypes` 3 (INT16 LE at +8).
         */
        public function valueInt16() {
            if ($this->_m_valueInt16 !== null)
                return $this->_m_valueInt16;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::INT16) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->fieldEntryPos() + 8);
                $this->_m_valueInt16 = $this->_io->readS2le();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueInt16;
        }
        protected $_m_valueInt32;

        /**
         * `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
         */
        public function valueInt32() {
            if ($this->_m_valueInt32 !== null)
                return $this->_m_valueInt32;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::INT32) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->fieldEntryPos() + 8);
                $this->_m_valueInt32 = $this->_io->readS4le();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueInt32;
        }
        protected $_m_valueInt64;

        /**
         * `GFFFieldTypes` 7 (INT64).
         */
        public function valueInt64() {
            if ($this->_m_valueInt64 !== null)
                return $this->_m_valueInt64;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::INT64) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->entry()->dataOrOffset());
                $this->_m_valueInt64 = $this->_io->readS8le();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueInt64;
        }
        protected $_m_valueInt8;

        /**
         * `GFFFieldTypes` 1 (INT8 in low byte of slot).
         */
        public function valueInt8() {
            if ($this->_m_valueInt8 !== null)
                return $this->_m_valueInt8;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::INT8) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->fieldEntryPos() + 8);
                $this->_m_valueInt8 = $this->_io->readS1();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueInt8;
        }
        protected $_m_valueLocalizedString;

        /**
         * `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
         */
        public function valueLocalizedString() {
            if ($this->_m_valueLocalizedString !== null)
                return $this->_m_valueLocalizedString;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::LOCALIZED_STRING) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->entry()->dataOrOffset());
                $this->_m_valueLocalizedString = new \BiowareCommon\BiowareLocstring($this->_io);
                $this->_io->seek($_pos);
            }
            return $this->_m_valueLocalizedString;
        }
        protected $_m_valueResref;

        /**
         * `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
         */
        public function valueResref() {
            if ($this->_m_valueResref !== null)
                return $this->_m_valueResref;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::RESREF) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->entry()->dataOrOffset());
                $this->_m_valueResref = new \BiowareCommon\BiowareResref($this->_io);
                $this->_io->seek($_pos);
            }
            return $this->_m_valueResref;
        }
        protected $_m_valueSingle;

        /**
         * `GFFFieldTypes` 8 (32-bit float).
         */
        public function valueSingle() {
            if ($this->_m_valueSingle !== null)
                return $this->_m_valueSingle;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::SINGLE) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->fieldEntryPos() + 8);
                $this->_m_valueSingle = $this->_io->readF4le();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueSingle;
        }
        protected $_m_valueStrRef;

        /**
         * `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
         * `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
         * **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
         * Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
         * PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
         */
        public function valueStrRef() {
            if ($this->_m_valueStrRef !== null)
                return $this->_m_valueStrRef;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::STR_REF) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->fieldEntryPos() + 8);
                $this->_m_valueStrRef = $this->_io->readU4le();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueStrRef;
        }
        protected $_m_valueString;

        /**
         * `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
         */
        public function valueString() {
            if ($this->_m_valueString !== null)
                return $this->_m_valueString;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::STRING) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->entry()->dataOrOffset());
                $this->_m_valueString = new \BiowareCommon\BiowareCexoString($this->_io);
                $this->_io->seek($_pos);
            }
            return $this->_m_valueString;
        }
        protected $_m_valueStruct;

        /**
         * `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.
         */
        public function valueStruct() {
            if ($this->_m_valueStruct !== null)
                return $this->_m_valueStruct;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::STRUCT) {
                $this->_m_valueStruct = new \Gff\ResolvedStruct($this->entry()->dataOrOffset(), $this->_io, $this, $this->_root);
            }
            return $this->_m_valueStruct;
        }
        protected $_m_valueUint16;

        /**
         * `GFFFieldTypes` 2 (UINT16 LE at +8).
         */
        public function valueUint16() {
            if ($this->_m_valueUint16 !== null)
                return $this->_m_valueUint16;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::UINT16) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->fieldEntryPos() + 8);
                $this->_m_valueUint16 = $this->_io->readU2le();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueUint16;
        }
        protected $_m_valueUint32;

        /**
         * `GFFFieldTypes` 4 (full inline DWORD).
         */
        public function valueUint32() {
            if ($this->_m_valueUint32 !== null)
                return $this->_m_valueUint32;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::UINT32) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->fieldEntryPos() + 8);
                $this->_m_valueUint32 = $this->_io->readU4le();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueUint32;
        }
        protected $_m_valueUint64;

        /**
         * `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
         */
        public function valueUint64() {
            if ($this->_m_valueUint64 !== null)
                return $this->_m_valueUint64;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::UINT64) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->entry()->dataOrOffset());
                $this->_m_valueUint64 = $this->_io->readU8le();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueUint64;
        }
        protected $_m_valueUint8;

        /**
         * `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
         */
        public function valueUint8() {
            if ($this->_m_valueUint8 !== null)
                return $this->_m_valueUint8;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::UINT8) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->fieldEntryPos() + 8);
                $this->_m_valueUint8 = $this->_io->readU1();
                $this->_io->seek($_pos);
            }
            return $this->_m_valueUint8;
        }
        protected $_m_valueVector3;

        /**
         * `GFFFieldTypes` 17 — three floats (`bioware_vector3`).
         */
        public function valueVector3() {
            if ($this->_m_valueVector3 !== null)
                return $this->_m_valueVector3;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::VECTOR3) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->entry()->dataOrOffset());
                $this->_m_valueVector3 = new \BiowareCommon\BiowareVector3($this->_io);
                $this->_io->seek($_pos);
            }
            return $this->_m_valueVector3;
        }
        protected $_m_valueVector4;

        /**
         * `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
         */
        public function valueVector4() {
            if ($this->_m_valueVector4 !== null)
                return $this->_m_valueVector4;
            if ($this->entry()->fieldType() == \BiowareGffCommon\GffFieldType::VECTOR4) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldDataOffset() + $this->entry()->dataOrOffset());
                $this->_m_valueVector4 = new \BiowareCommon\BiowareVector4($this->_io);
                $this->_io->seek($_pos);
            }
            return $this->_m_valueVector4;
        }
        protected $_m_fieldIndex;

        /**
         * Index into `field_array.entries`; require `field_index < field_count`.
         */
        public function fieldIndex() { return $this->_m_fieldIndex; }
    }
}

/**
 * Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
 * On-disk row remains at `struct_offset + struct_index * 12`.
 */

namespace Gff {
    class ResolvedStruct extends \Kaitai\Struct\Struct {
        public function __construct(int $structIndex, \Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_m_structIndex = $structIndex;
            $this->_read();
        }

        private function _read() {
        }
        protected $_m_entry;

        /**
         * Raw `GFFStructData` (Ghidra 12-byte layout).
         */
        public function entry() {
            if ($this->_m_entry !== null)
                return $this->_m_entry;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->_root()->file()->gff3()->header()->structOffset() + $this->structIndex() * 12);
            $this->_m_entry = new \Gff\StructEntry($this->_io, $this, $this->_root);
            $this->_io->seek($_pos);
            return $this->_m_entry;
        }
        protected $_m_fieldIndices;

        /**
         * Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
         * Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
         */
        public function fieldIndices() {
            if ($this->_m_fieldIndices !== null)
                return $this->_m_fieldIndices;
            if ($this->entry()->fieldCount() > 1) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->file()->gff3()->header()->fieldIndicesOffset() + $this->entry()->dataOrOffset());
                $this->_m_fieldIndices = [];
                $n = $this->entry()->fieldCount();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_fieldIndices[] = $this->_io->readU4le();
                }
                $this->_io->seek($_pos);
            }
            return $this->_m_fieldIndices;
        }
        protected $_m_fields;

        /**
         * One `resolved_field` per entry in `field_indices`.
         */
        public function fields() {
            if ($this->_m_fields !== null)
                return $this->_m_fields;
            if ($this->entry()->fieldCount() > 1) {
                $this->_m_fields = [];
                $n = $this->entry()->fieldCount();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_fields[] = new \Gff\ResolvedField($this->fieldIndices()[$i], $this->_io, $this, $this->_root);
                }
            }
            return $this->_m_fields;
        }
        protected $_m_singleField;

        /**
         * `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).
         */
        public function singleField() {
            if ($this->_m_singleField !== null)
                return $this->_m_singleField;
            if ($this->entry()->fieldCount() == 1) {
                $this->_m_singleField = new \Gff\ResolvedField($this->entry()->dataOrOffset(), $this->_io, $this, $this->_root);
            }
            return $this->_m_singleField;
        }
        protected $_m_structIndex;

        /**
         * Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.
         */
        public function structIndex() { return $this->_m_structIndex; }
    }
}

/**
 * Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Ghidra name `GFFStructData`.
 * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
 */

namespace Gff {
    class StructArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Gff\Gff3AfterAurora $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->file()->gff3()->header()->structCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Gff\StructEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
         * Stride 12 bytes per struct (matches Ghidra component sizes).
         */
        public function entries() { return $this->_m_entries; }
    }
}

/**
 * One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
 */

namespace Gff {
    class StructEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Gff $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_structId = $this->_io->readU4le();
            $this->_m_dataOrOffset = $this->_io->readU4le();
            $this->_m_fieldCount = $this->_io->readU4le();
        }
        protected $_m_fieldIndicesOffset;

        /**
         * Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.
         */
        public function fieldIndicesOffset() {
            if ($this->_m_fieldIndicesOffset !== null)
                return $this->_m_fieldIndicesOffset;
            if ($this->hasMultipleFields()) {
                $this->_m_fieldIndicesOffset = $this->dataOrOffset();
            }
            return $this->_m_fieldIndicesOffset;
        }
        protected $_m_hasMultipleFields;

        /**
         * Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
         */
        public function hasMultipleFields() {
            if ($this->_m_hasMultipleFields !== null)
                return $this->_m_hasMultipleFields;
            $this->_m_hasMultipleFields = $this->fieldCount() > 1;
            return $this->_m_hasMultipleFields;
        }
        protected $_m_hasSingleField;

        /**
         * Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
         * Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         */
        public function hasSingleField() {
            if ($this->_m_hasSingleField !== null)
                return $this->_m_hasSingleField;
            $this->_m_hasSingleField = $this->fieldCount() == 1;
            return $this->_m_hasSingleField;
        }
        protected $_m_singleFieldIndex;

        /**
         * Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
         */
        public function singleFieldIndex() {
            if ($this->_m_singleFieldIndex !== null)
                return $this->_m_singleFieldIndex;
            if ($this->hasSingleField()) {
                $this->_m_singleFieldIndex = $this->dataOrOffset();
            }
            return $this->_m_singleFieldIndex;
        }
        protected $_m_structId;
        protected $_m_dataOrOffset;
        protected $_m_fieldCount;

        /**
         * Structure type identifier.
         * Source: Ghidra `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         * 0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.
         */
        public function structId() { return $this->_m_structId; }

        /**
         * Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
         * If field_count == 0, this value is unused.
         * Source: Ghidra `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
         */
        public function dataOrOffset() { return $this->_m_dataOrOffset; }

        /**
         * Number of fields in this struct:
         * - 0: No fields
         * - 1: Single field, data_or_offset contains the field index directly
         * - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
         * Source: Ghidra `GFFStructData.field_count` @ +0x8 (ulong).
         */
        public function fieldCount() { return $this->_m_fieldCount; }
    }
}
