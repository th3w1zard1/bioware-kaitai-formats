// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareCommon', './BiowareGffCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareCommon'), require('./BiowareGffCommon'));
  } else {
    factory(root.Gff || (root.Gff = {}), root.KaitaiStream, root.BiowareCommon || (root.BiowareCommon = {}), root.BiowareGffCommon || (root.BiowareGffCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Gff_, KaitaiStream, BiowareCommon_, BiowareGffCommon_) {
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
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format|PyKotor wiki — GFF binary format}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63|xoreos — GFF3File::Header::read}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181|xoreos — GFF3File load (post-header struct/field arena wiring)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72|xoreos — GFF4File::Header::read}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L151-L164|xoreos — GFF4File::load entry}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114|PyKotor — GFFBinaryReader.load}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225|reone — GffReader}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts#L152-L221|KotOR.js — GFFObject.parse}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp#L86-L238|xoreos-tools — GFF3 load pipeline (shared with CLIs)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176|xoreos-tools — `gffdumper`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60|xoreos-tools — `gffcreator`}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf|xoreos-docs — GFF_Format.pdf}
 */

var Gff = (function() {
  function Gff(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Gff.prototype._read = function() {
    this.file = new GffUnionFile(this._io, this, this._root);
  }

  /**
   * Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
   * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
   */

  var FieldArray = Gff.FieldArray = (function() {
    function FieldArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FieldArray.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.file.gff3.header.fieldCount; i++) {
        this.entries.push(new FieldEntry(this._io, this, this._root));
      }
    }

    /**
     * Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
     * Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).
     */

    return FieldArray;
  })();

  /**
   * Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
   */

  var FieldData = Gff.FieldData = (function() {
    function FieldData(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FieldData.prototype._read = function() {
      this.rawData = this._io.readBytes(this._root.file.gff3.header.fieldDataCount);
    }

    /**
     * Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
     * Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
     * Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
     */

    return FieldData;
  })();

  /**
   * One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
   * `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
   * Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
   */

  var FieldEntry = Gff.FieldEntry = (function() {
    function FieldEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FieldEntry.prototype._read = function() {
      this.fieldType = this._io.readU4le();
      this.labelIndex = this._io.readU4le();
      this.dataOrOffset = this._io.readU4le();
    }

    /**
     * Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
     */
    Object.defineProperty(FieldEntry.prototype, 'fieldDataOffsetValue', {
      get: function() {
        if (this._m_fieldDataOffsetValue !== undefined)
          return this._m_fieldDataOffsetValue;
        if (this.isComplexType) {
          this._m_fieldDataOffsetValue = this._root.file.gff3.header.fieldDataOffset + this.dataOrOffset;
        }
        return this._m_fieldDataOffsetValue;
      }
    });

    /**
     * Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
     */
    Object.defineProperty(FieldEntry.prototype, 'isComplexType', {
      get: function() {
        if (this._m_isComplexType !== undefined)
          return this._m_isComplexType;
        this._m_isComplexType =  ((this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.UINT64) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.INT64) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.DOUBLE) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.STRING) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.RESREF) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.LOCALIZED_STRING) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.BINARY) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.VECTOR4) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.VECTOR3)) ;
        return this._m_isComplexType;
      }
    });

    /**
     * Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
     */
    Object.defineProperty(FieldEntry.prototype, 'isListType', {
      get: function() {
        if (this._m_isListType !== undefined)
          return this._m_isListType;
        this._m_isListType = this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.LIST;
        return this._m_isListType;
      }
    });

    /**
     * Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
     * Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
     * **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
     */
    Object.defineProperty(FieldEntry.prototype, 'isSimpleType', {
      get: function() {
        if (this._m_isSimpleType !== undefined)
          return this._m_isSimpleType;
        this._m_isSimpleType =  ((this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.UINT8) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.INT8) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.UINT16) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.INT16) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.UINT32) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.INT32) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.SINGLE) || (this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.STR_REF)) ;
        return this._m_isSimpleType;
      }
    });

    /**
     * Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
     */
    Object.defineProperty(FieldEntry.prototype, 'isStructType', {
      get: function() {
        if (this._m_isStructType !== undefined)
          return this._m_isStructType;
        this._m_isStructType = this.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.STRUCT;
        return this._m_isStructType;
      }
    });

    /**
     * Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.
     */
    Object.defineProperty(FieldEntry.prototype, 'listIndicesOffsetValue', {
      get: function() {
        if (this._m_listIndicesOffsetValue !== undefined)
          return this._m_listIndicesOffsetValue;
        if (this.isListType) {
          this._m_listIndicesOffsetValue = this._root.file.gff3.header.listIndicesOffset + this.dataOrOffset;
        }
        return this._m_listIndicesOffsetValue;
      }
    });

    /**
     * Struct index (same numeric interpretation as `GFFStructData` row index).
     */
    Object.defineProperty(FieldEntry.prototype, 'structIndexValue', {
      get: function() {
        if (this._m_structIndexValue !== undefined)
          return this._m_structIndexValue;
        if (this.isStructType) {
          this._m_structIndexValue = this.dataOrOffset;
        }
        return this._m_structIndexValue;
      }
    });

    /**
     * Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
     * (ID → storage: inline vs `field_data` vs struct/list indirection).
     * Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
     * Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
     * PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
     */

    /**
     * Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.label_index` @ +0x4 (ulong).
     */

    /**
     * Inline data (simple types) or offset/index (complex types):
     * - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
     * - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
     * - Struct (14): Struct index (index into struct_array)
     * - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.data_or_data_offset` @ +0x8.
     * `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
     */

    return FieldEntry;
  })();

  /**
   * Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
   * “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
   */

  var FieldIndicesArray = Gff.FieldIndicesArray = (function() {
    function FieldIndicesArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FieldIndicesArray.prototype._read = function() {
      this.indices = [];
      for (var i = 0; i < this._root.file.gff3.header.fieldIndicesCount; i++) {
        this.indices.push(this._io.readU4le());
      }
    }

    /**
     * `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
     * `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
     * **Observed behavior**: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.
     */

    return FieldIndicesArray;
  })();

  /**
   * GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.
   */

  var Gff3AfterAurora = Gff.Gff3AfterAurora = (function() {
    function Gff3AfterAurora(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Gff3AfterAurora.prototype._read = function() {
      this.header = new GffHeaderTail(this._io, this, this._root);
    }

    /**
     * Field dictionary: `header.field_count` × 12 B at `header.field_offset`. **Observed behavior**: `GFFFieldData`.
     * `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
     *     PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149
     */
    Object.defineProperty(Gff3AfterAurora.prototype, 'fieldArray', {
      get: function() {
        if (this._m_fieldArray !== undefined)
          return this._m_fieldArray;
        if (this.header.fieldCount > 0) {
          var _pos = this._io.pos;
          this._io.seek(this.header.fieldOffset);
          this._m_fieldArray = new FieldArray(this._io, this, this._root);
          this._io.seek(_pos);
        }
        return this._m_fieldArray;
      }
    });

    /**
     * Complex-type payload heap. **Observed behavior**: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
     *     PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216
     */
    Object.defineProperty(Gff3AfterAurora.prototype, 'fieldData', {
      get: function() {
        if (this._m_fieldData !== undefined)
          return this._m_fieldData;
        if (this.header.fieldDataCount > 0) {
          var _pos = this._io.pos;
          this._io.seek(this.header.fieldDataOffset);
          this._m_fieldData = new FieldData(this._io, this, this._root);
          this._io.seek(_pos);
        }
        return this._m_fieldData;
      }
    });

    /**
     * Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
     * **Observed behavior**: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
     *     PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
     */
    Object.defineProperty(Gff3AfterAurora.prototype, 'fieldIndicesArray', {
      get: function() {
        if (this._m_fieldIndicesArray !== undefined)
          return this._m_fieldIndicesArray;
        if (this.header.fieldIndicesCount > 0) {
          var _pos = this._io.pos;
          this._io.seek(this.header.fieldIndicesOffset);
          this._m_fieldIndicesArray = new FieldIndicesArray(this._io, this, this._root);
          this._io.seek(_pos);
        }
        return this._m_fieldIndicesArray;
      }
    });

    /**
     * Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
     * **Observed behavior**: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
     *     PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154
     */
    Object.defineProperty(Gff3AfterAurora.prototype, 'labelArray', {
      get: function() {
        if (this._m_labelArray !== undefined)
          return this._m_labelArray;
        if (this.header.labelCount > 0) {
          var _pos = this._io.pos;
          this._io.seek(this.header.labelOffset);
          this._m_labelArray = new LabelArray(this._io, this, this._root);
          this._io.seek(_pos);
        }
        return this._m_labelArray;
      }
    });

    /**
     * Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
     * **Observed behavior**: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
     *     PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
     */
    Object.defineProperty(Gff3AfterAurora.prototype, 'listIndicesArray', {
      get: function() {
        if (this._m_listIndicesArray !== undefined)
          return this._m_listIndicesArray;
        if (this.header.listIndicesCount > 0) {
          var _pos = this._io.pos;
          this._io.seek(this.header.listIndicesOffset);
          this._m_listIndicesArray = new ListIndicesArray(this._io, this, this._root);
          this._io.seek(_pos);
        }
        return this._m_listIndicesArray;
      }
    });

    /**
     * Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
     * Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
     * Implements the access pattern described in meta.doc (single-field vs multi-field structs).
     */
    Object.defineProperty(Gff3AfterAurora.prototype, 'rootStructResolved', {
      get: function() {
        if (this._m_rootStructResolved !== undefined)
          return this._m_rootStructResolved;
        this._m_rootStructResolved = new ResolvedStruct(this._io, this, this._root, 0);
        return this._m_rootStructResolved;
      }
    });

    /**
     * Struct table: `header.struct_count` × 12 B at `header.struct_offset`. **Observed behavior**: `GFFStructData` rows.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
     *     PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65
     */
    Object.defineProperty(Gff3AfterAurora.prototype, 'structArray', {
      get: function() {
        if (this._m_structArray !== undefined)
          return this._m_structArray;
        if (this.header.structCount > 0) {
          var _pos = this._io.pos;
          this._io.seek(this.header.structOffset);
          this._m_structArray = new StructArray(this._io, this, this._root);
          this._io.seek(_pos);
        }
        return this._m_structArray;
      }
    });

    /**
     * Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
     * rows from Struct Array Offset through List Indices Count. **Observed behavior**: `GFFHeaderInfo` @ +0x8 … +0x34.
     */

    return Gff3AfterAurora;
  })();

  /**
   * GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
   * PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
   */

  var Gff4AfterAurora = Gff.Gff4AfterAurora = (function() {
    function Gff4AfterAurora(_io, _parent, _root, auroraVersion) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;
      this.auroraVersion = auroraVersion;

      this._read();
    }
    Gff4AfterAurora.prototype._read = function() {
      this.platformId = this._io.readU4be();
      this.fileType = this._io.readU4be();
      this.typeVersion = this._io.readU4be();
      this.numStructTemplates = this._io.readU4le();
      if (this.auroraVersion == 1446260273) {
        this.stringCount = this._io.readU4le();
      }
      if (this.auroraVersion == 1446260273) {
        this.stringOffset = this._io.readU4le();
      }
      this.dataOffset = this._io.readU4le();
      this.structTemplates = [];
      for (var i = 0; i < this.numStructTemplates; i++) {
        this.structTemplates.push(new Gff4StructTemplateHeader(this._io, this, this._root));
      }
      this.tail = this._io.readBytesFull();
    }

    /**
     * Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
     * `PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).
     */

    /**
     * GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
     * `readUint32BE` on the endian-aware substream (`gff4file.cpp`).
     */

    /**
     * Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).
     */

    /**
     * Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
     * in typical DA assets). xoreos: `_header.structCount`.
     */

    /**
     * V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).
     */

    /**
     * V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).
     */

    /**
     * Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
     * `readUint32` on the endian substream (`gff4file.cpp`).
     */

    /**
     * Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).
     */

    /**
     * Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
     * optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
     * GFF4 graph walker or defer to engine code.
     */

    /**
     * Aurora version tag from the enclosing stream’s first 8 bytes (read on disk as `u4be`;
     * passed as `u4` for Kaitai param typing). Same value as `gff_union_file.aurora_version` / `gff4_file.aurora_version`.
     */

    return Gff4AfterAurora;
  })();

  /**
   * Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
   * that expect a single user-type over the whole file.
   */

  var Gff4File = Gff.Gff4File = (function() {
    function Gff4File(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Gff4File.prototype._read = function() {
      this.auroraMagic = this._io.readU4be();
      this.auroraVersion = this._io.readU4be();
      this.gff4 = new Gff4AfterAurora(this._io, this, this._root, this.auroraVersion);
    }

    /**
     * Aurora container magic (`GFF ` as `u4be`).
     */

    /**
     * GFF4 `V4.0` / `V4.1` on-disk tags.
     */

    /**
     * GFF4 header tail + struct templates + opaque remainder.
     */

    return Gff4File;
  })();

  var Gff4StructTemplateHeader = Gff.Gff4StructTemplateHeader = (function() {
    function Gff4StructTemplateHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Gff4StructTemplateHeader.prototype._read = function() {
      this.structLabel = this._io.readU4be();
      this.fieldCount = this._io.readU4le();
      this.fieldOffset = this._io.readU4le();
      this.structSize = this._io.readU4le();
    }

    /**
     * Template label (fourCC style, read `readUint32BE` in `loadStructs`).
     */

    /**
     * Number of field declaration records for this template (may be 0).
     */

    /**
     * Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
     * (xoreos `continue`s without reading declarations).
     */

    /**
     * Declared on-disk struct size for instances of this template (`strct.size`).
     */

    return Gff4StructTemplateHeader;
  })();

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

  var GffHeaderTail = Gff.GffHeaderTail = (function() {
    function GffHeaderTail(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    GffHeaderTail.prototype._read = function() {
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

    /**
     * Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30
     */

    /**
     * Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_count` @ +0xC (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31
     */

    /**
     * Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32
     */

    /**
     * Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_count` @ +0x14 (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33
     */

    /**
     * Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34
     */

    /**
     * Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_count` @ +0x1C (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35
     */

    /**
     * Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36
     */

    /**
     * Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37
     */

    /**
     * Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38
     */

    /**
     * Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)
     */

    /**
     * Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40
     */

    /**
     * List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
     * Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
     */

    return GffHeaderTail;
  })();

  /**
   * Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
   * (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
   */

  var GffUnionFile = Gff.GffUnionFile = (function() {
    function GffUnionFile(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    GffUnionFile.prototype._read = function() {
      this.auroraMagic = this._io.readU4be();
      this.auroraVersion = this._io.readU4be();
      if ( ((this.auroraVersion != 1446260272) && (this.auroraVersion != 1446260273)) ) {
        this.gff3 = new Gff3AfterAurora(this._io, this, this._root);
      }
      if ( ((this.auroraVersion == 1446260272) || (this.auroraVersion == 1446260273)) ) {
        this.gff4 = new Gff4AfterAurora(this._io, this, this._root, this.auroraVersion);
      }
    }

    /**
     * File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
     * legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.
     */

    /**
     * Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
     * `0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.
     */

    /**
     * **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.
     */

    /**
     * **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.
     */

    return GffUnionFile;
  })();

  /**
   * Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
   * Indexed by `GFFFieldData.label_index` (×16). Not a separate struct in **observed behavior** — rows are `char[16]` in bulk.
   * Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
   */

  var LabelArray = Gff.LabelArray = (function() {
    function LabelArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LabelArray.prototype._read = function() {
      this.labels = [];
      for (var i = 0; i < this._root.file.gff3.header.labelCount; i++) {
        this.labels.push(new LabelEntry(this._io, this, this._root));
      }
    }

    /**
     * Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
     * Index `i` is at file offset `label_offset + i*16`.
     */

    return LabelArray;
  })();

  /**
   * One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
   */

  var LabelEntry = Gff.LabelEntry = (function() {
    function LabelEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LabelEntry.prototype._read = function() {
      this.name = KaitaiStream.bytesToStr(this._io.readBytes(16), "ASCII");
    }

    /**
     * Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
     * Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
     * Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
     */

    return LabelEntry;
  })();

  /**
   * Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
   * Not a separate engine-local datatype. Wire cite: `label_entry.name`.
   */

  var LabelEntryTerminated = Gff.LabelEntryTerminated = (function() {
    function LabelEntryTerminated(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LabelEntryTerminated.prototype._read = function() {
      this.name = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(16), 0, false), "ASCII");
    }

    /**
     * Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.
     */

    return LabelEntryTerminated;
  })();

  /**
   * One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
   * Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
   */

  var ListEntry = Gff.ListEntry = (function() {
    function ListEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ListEntry.prototype._read = function() {
      this.numStructIndices = this._io.readU4le();
      this.structIndices = [];
      for (var i = 0; i < this.numStructIndices; i++) {
        this.structIndices.push(this._io.readU4le());
      }
    }

    /**
     * Little-endian count of following struct indices (list cardinality).
     * Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
     */

    /**
     * Each value indexes `struct_array.entries[index]` (`GFFStructData` row).
     */

    return ListEntry;
  })();

  /**
   * Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
   */

  var ListIndicesArray = Gff.ListIndicesArray = (function() {
    function ListIndicesArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ListIndicesArray.prototype._read = function() {
      this.rawData = this._io.readBytes(this._root.file.gff3.header.listIndicesCount);
    }

    /**
     * Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
     * Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
     * This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.
     */

    return ListIndicesArray;
  })();

  /**
   * Kaitai composition: one `GFFFieldData` row + label + payload.
   * Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
   * Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
   * For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
   */

  var ResolvedField = Gff.ResolvedField = (function() {
    function ResolvedField(_io, _parent, _root, fieldIndex) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;
      this.fieldIndex = fieldIndex;

      this._read();
    }
    ResolvedField.prototype._read = function() {
    }

    /**
     * Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).
     */
    Object.defineProperty(ResolvedField.prototype, 'entry', {
      get: function() {
        if (this._m_entry !== undefined)
          return this._m_entry;
        var _pos = this._io.pos;
        this._io.seek(this._root.file.gff3.header.fieldOffset + this.fieldIndex * 12);
        this._m_entry = new FieldEntry(this._io, this, this._root);
        this._io.seek(_pos);
        return this._m_entry;
      }
    });

    /**
     * Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).
     */
    Object.defineProperty(ResolvedField.prototype, 'fieldEntryPos', {
      get: function() {
        if (this._m_fieldEntryPos !== undefined)
          return this._m_fieldEntryPos;
        this._m_fieldEntryPos = this._root.file.gff3.header.fieldOffset + this.fieldIndex * 12;
        return this._m_fieldEntryPos;
      }
    });

    /**
     * Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.
     */
    Object.defineProperty(ResolvedField.prototype, 'label', {
      get: function() {
        if (this._m_label !== undefined)
          return this._m_label;
        var _pos = this._io.pos;
        this._io.seek(this._root.file.gff3.header.labelOffset + this.entry.labelIndex * 16);
        this._m_label = new LabelEntryTerminated(this._io, this, this._root);
        this._io.seek(_pos);
        return this._m_label;
      }
    });

    /**
     * `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.
     */
    Object.defineProperty(ResolvedField.prototype, 'listEntry', {
      get: function() {
        if (this._m_listEntry !== undefined)
          return this._m_listEntry;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.LIST) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.listIndicesOffset + this.entry.dataOrOffset);
          this._m_listEntry = new ListEntry(this._io, this, this._root);
          this._io.seek(_pos);
        }
        return this._m_listEntry;
      }
    });

    /**
     * Child structs for this list; indices from `list_entry.struct_indices`.
     */
    Object.defineProperty(ResolvedField.prototype, 'listStructs', {
      get: function() {
        if (this._m_listStructs !== undefined)
          return this._m_listStructs;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.LIST) {
          this._m_listStructs = [];
          for (var i = 0; i < this.listEntry.numStructIndices; i++) {
            this._m_listStructs.push(new ResolvedStruct(this._io, this, this._root, this.listEntry.structIndices[i]));
          }
        }
        return this._m_listStructs;
      }
    });

    /**
     * `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueBinary', {
      get: function() {
        if (this._m_valueBinary !== undefined)
          return this._m_valueBinary;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.BINARY) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldDataOffset + this.entry.dataOrOffset);
          this._m_valueBinary = new BiowareCommon_.BiowareCommon.BiowareBinaryData(this._io, null, null);
          this._io.seek(_pos);
        }
        return this._m_valueBinary;
      }
    });

    /**
     * `GFFFieldTypes` 9 (double).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueDouble', {
      get: function() {
        if (this._m_valueDouble !== undefined)
          return this._m_valueDouble;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.DOUBLE) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldDataOffset + this.entry.dataOrOffset);
          this._m_valueDouble = this._io.readF8le();
          this._io.seek(_pos);
        }
        return this._m_valueDouble;
      }
    });

    /**
     * `GFFFieldTypes` 3 (INT16 LE at +8).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueInt16', {
      get: function() {
        if (this._m_valueInt16 !== undefined)
          return this._m_valueInt16;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.INT16) {
          var _pos = this._io.pos;
          this._io.seek(this.fieldEntryPos + 8);
          this._m_valueInt16 = this._io.readS2le();
          this._io.seek(_pos);
        }
        return this._m_valueInt16;
      }
    });

    /**
     * `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
     */
    Object.defineProperty(ResolvedField.prototype, 'valueInt32', {
      get: function() {
        if (this._m_valueInt32 !== undefined)
          return this._m_valueInt32;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.INT32) {
          var _pos = this._io.pos;
          this._io.seek(this.fieldEntryPos + 8);
          this._m_valueInt32 = this._io.readS4le();
          this._io.seek(_pos);
        }
        return this._m_valueInt32;
      }
    });

    /**
     * `GFFFieldTypes` 7 (INT64).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueInt64', {
      get: function() {
        if (this._m_valueInt64 !== undefined)
          return this._m_valueInt64;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.INT64) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldDataOffset + this.entry.dataOrOffset);
          this._m_valueInt64 = this._io.readS8le();
          this._io.seek(_pos);
        }
        return this._m_valueInt64;
      }
    });

    /**
     * `GFFFieldTypes` 1 (INT8 in low byte of slot).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueInt8', {
      get: function() {
        if (this._m_valueInt8 !== undefined)
          return this._m_valueInt8;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.INT8) {
          var _pos = this._io.pos;
          this._io.seek(this.fieldEntryPos + 8);
          this._m_valueInt8 = this._io.readS1();
          this._io.seek(_pos);
        }
        return this._m_valueInt8;
      }
    });

    /**
     * `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueLocalizedString', {
      get: function() {
        if (this._m_valueLocalizedString !== undefined)
          return this._m_valueLocalizedString;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.LOCALIZED_STRING) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldDataOffset + this.entry.dataOrOffset);
          this._m_valueLocalizedString = new BiowareCommon_.BiowareCommon.BiowareLocstring(this._io, null, null);
          this._io.seek(_pos);
        }
        return this._m_valueLocalizedString;
      }
    });

    /**
     * `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueResref', {
      get: function() {
        if (this._m_valueResref !== undefined)
          return this._m_valueResref;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.RESREF) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldDataOffset + this.entry.dataOrOffset);
          this._m_valueResref = new BiowareCommon_.BiowareCommon.BiowareResref(this._io, null, null);
          this._io.seek(_pos);
        }
        return this._m_valueResref;
      }
    });

    /**
     * `GFFFieldTypes` 8 (32-bit float).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueSingle', {
      get: function() {
        if (this._m_valueSingle !== undefined)
          return this._m_valueSingle;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.SINGLE) {
          var _pos = this._io.pos;
          this._io.seek(this.fieldEntryPos + 8);
          this._m_valueSingle = this._io.readF4le();
          this._io.seek(_pos);
        }
        return this._m_valueSingle;
      }
    });

    /**
     * `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
     * `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
     * **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
     * Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
     * PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
     */
    Object.defineProperty(ResolvedField.prototype, 'valueStrRef', {
      get: function() {
        if (this._m_valueStrRef !== undefined)
          return this._m_valueStrRef;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.STR_REF) {
          var _pos = this._io.pos;
          this._io.seek(this.fieldEntryPos + 8);
          this._m_valueStrRef = this._io.readU4le();
          this._io.seek(_pos);
        }
        return this._m_valueStrRef;
      }
    });

    /**
     * `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueString', {
      get: function() {
        if (this._m_valueString !== undefined)
          return this._m_valueString;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.STRING) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldDataOffset + this.entry.dataOrOffset);
          this._m_valueString = new BiowareCommon_.BiowareCommon.BiowareCexoString(this._io, null, null);
          this._io.seek(_pos);
        }
        return this._m_valueString;
      }
    });

    /**
     * `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.
     */
    Object.defineProperty(ResolvedField.prototype, 'valueStruct', {
      get: function() {
        if (this._m_valueStruct !== undefined)
          return this._m_valueStruct;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.STRUCT) {
          this._m_valueStruct = new ResolvedStruct(this._io, this, this._root, this.entry.dataOrOffset);
        }
        return this._m_valueStruct;
      }
    });

    /**
     * `GFFFieldTypes` 2 (UINT16 LE at +8).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueUint16', {
      get: function() {
        if (this._m_valueUint16 !== undefined)
          return this._m_valueUint16;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.UINT16) {
          var _pos = this._io.pos;
          this._io.seek(this.fieldEntryPos + 8);
          this._m_valueUint16 = this._io.readU2le();
          this._io.seek(_pos);
        }
        return this._m_valueUint16;
      }
    });

    /**
     * `GFFFieldTypes` 4 (full inline DWORD).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueUint32', {
      get: function() {
        if (this._m_valueUint32 !== undefined)
          return this._m_valueUint32;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.UINT32) {
          var _pos = this._io.pos;
          this._io.seek(this.fieldEntryPos + 8);
          this._m_valueUint32 = this._io.readU4le();
          this._io.seek(_pos);
        }
        return this._m_valueUint32;
      }
    });

    /**
     * `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueUint64', {
      get: function() {
        if (this._m_valueUint64 !== undefined)
          return this._m_valueUint64;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.UINT64) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldDataOffset + this.entry.dataOrOffset);
          this._m_valueUint64 = this._io.readU8le();
          this._io.seek(_pos);
        }
        return this._m_valueUint64;
      }
    });

    /**
     * `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
     */
    Object.defineProperty(ResolvedField.prototype, 'valueUint8', {
      get: function() {
        if (this._m_valueUint8 !== undefined)
          return this._m_valueUint8;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.UINT8) {
          var _pos = this._io.pos;
          this._io.seek(this.fieldEntryPos + 8);
          this._m_valueUint8 = this._io.readU1();
          this._io.seek(_pos);
        }
        return this._m_valueUint8;
      }
    });

    /**
     * `GFFFieldTypes` 17 — three floats (`bioware_vector3`).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueVector3', {
      get: function() {
        if (this._m_valueVector3 !== undefined)
          return this._m_valueVector3;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.VECTOR3) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldDataOffset + this.entry.dataOrOffset);
          this._m_valueVector3 = new BiowareCommon_.BiowareCommon.BiowareVector3(this._io, null, null);
          this._io.seek(_pos);
        }
        return this._m_valueVector3;
      }
    });

    /**
     * `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
     */
    Object.defineProperty(ResolvedField.prototype, 'valueVector4', {
      get: function() {
        if (this._m_valueVector4 !== undefined)
          return this._m_valueVector4;
        if (this.entry.fieldType == BiowareGffCommon_.BiowareGffCommon.GffFieldType.VECTOR4) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldDataOffset + this.entry.dataOrOffset);
          this._m_valueVector4 = new BiowareCommon_.BiowareCommon.BiowareVector4(this._io, null, null);
          this._io.seek(_pos);
        }
        return this._m_valueVector4;
      }
    });

    /**
     * Index into `field_array.entries`; require `field_index < field_count`.
     */

    return ResolvedField;
  })();

  /**
   * Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
   * On-disk row remains at `struct_offset + struct_index * 12`.
   */

  var ResolvedStruct = Gff.ResolvedStruct = (function() {
    function ResolvedStruct(_io, _parent, _root, structIndex) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;
      this.structIndex = structIndex;

      this._read();
    }
    ResolvedStruct.prototype._read = function() {
    }

    /**
     * Raw `GFFStructData` (12-byte layout in **observed behavior**).
     */
    Object.defineProperty(ResolvedStruct.prototype, 'entry', {
      get: function() {
        if (this._m_entry !== undefined)
          return this._m_entry;
        var _pos = this._io.pos;
        this._io.seek(this._root.file.gff3.header.structOffset + this.structIndex * 12);
        this._m_entry = new StructEntry(this._io, this, this._root);
        this._io.seek(_pos);
        return this._m_entry;
      }
    });

    /**
     * Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
     * Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
     */
    Object.defineProperty(ResolvedStruct.prototype, 'fieldIndices', {
      get: function() {
        if (this._m_fieldIndices !== undefined)
          return this._m_fieldIndices;
        if (this.entry.fieldCount > 1) {
          var _pos = this._io.pos;
          this._io.seek(this._root.file.gff3.header.fieldIndicesOffset + this.entry.dataOrOffset);
          this._m_fieldIndices = [];
          for (var i = 0; i < this.entry.fieldCount; i++) {
            this._m_fieldIndices.push(this._io.readU4le());
          }
          this._io.seek(_pos);
        }
        return this._m_fieldIndices;
      }
    });

    /**
     * One `resolved_field` per entry in `field_indices`.
     */
    Object.defineProperty(ResolvedStruct.prototype, 'fields', {
      get: function() {
        if (this._m_fields !== undefined)
          return this._m_fields;
        if (this.entry.fieldCount > 1) {
          this._m_fields = [];
          for (var i = 0; i < this.entry.fieldCount; i++) {
            this._m_fields.push(new ResolvedField(this._io, this, this._root, this.fieldIndices[i]));
          }
        }
        return this._m_fields;
      }
    });

    /**
     * `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).
     */
    Object.defineProperty(ResolvedStruct.prototype, 'singleField', {
      get: function() {
        if (this._m_singleField !== undefined)
          return this._m_singleField;
        if (this.entry.fieldCount == 1) {
          this._m_singleField = new ResolvedField(this._io, this, this._root, this.entry.dataOrOffset);
        }
        return this._m_singleField;
      }
    });

    /**
     * Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.
     */

    return ResolvedStruct;
  })();

  /**
   * Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Name in **observed behavior**: `GFFStructData`.
   * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
   */

  var StructArray = Gff.StructArray = (function() {
    function StructArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    StructArray.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.file.gff3.header.structCount; i++) {
        this.entries.push(new StructEntry(this._io, this, this._root));
      }
    }

    /**
     * Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
     * Stride 12 bytes per struct (matches the component layout in **observed behavior**).
     */

    return StructArray;
  })();

  /**
   * One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
   */

  var StructEntry = Gff.StructEntry = (function() {
    function StructEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    StructEntry.prototype._read = function() {
      this.structId = this._io.readU4le();
      this.dataOrOffset = this._io.readU4le();
      this.fieldCount = this._io.readU4le();
    }

    /**
     * Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.
     */
    Object.defineProperty(StructEntry.prototype, 'fieldIndicesOffset', {
      get: function() {
        if (this._m_fieldIndicesOffset !== undefined)
          return this._m_fieldIndicesOffset;
        if (this.hasMultipleFields) {
          this._m_fieldIndicesOffset = this.dataOrOffset;
        }
        return this._m_fieldIndicesOffset;
      }
    });

    /**
     * Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
     */
    Object.defineProperty(StructEntry.prototype, 'hasMultipleFields', {
      get: function() {
        if (this._m_hasMultipleFields !== undefined)
          return this._m_hasMultipleFields;
        this._m_hasMultipleFields = this.fieldCount > 1;
        return this._m_hasMultipleFields;
      }
    });

    /**
     * Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
     * Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
     */
    Object.defineProperty(StructEntry.prototype, 'hasSingleField', {
      get: function() {
        if (this._m_hasSingleField !== undefined)
          return this._m_hasSingleField;
        this._m_hasSingleField = this.fieldCount == 1;
        return this._m_hasSingleField;
      }
    });

    /**
     * Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
     */
    Object.defineProperty(StructEntry.prototype, 'singleFieldIndex', {
      get: function() {
        if (this._m_singleFieldIndex !== undefined)
          return this._m_singleFieldIndex;
        if (this.hasSingleField) {
          this._m_singleFieldIndex = this.dataOrOffset;
        }
        return this._m_singleFieldIndex;
      }
    });

    /**
     * Structure type identifier.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
     * 0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.
     */

    /**
     * Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
     * If field_count == 0, this value is unused.
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
     */

    /**
     * Number of fields in this struct:
     * - 0: No fields
     * - 1: Single field, data_or_offset contains the field index directly
     * - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
     * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.field_count` @ +0x8 (ulong).
     */

    return StructEntry;
  })();

  /**
   * Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
   * (`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
   * Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
   * mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
   * downstream `pos:` / `_root.file.gff3.header` paths.
   */

  return Gff;
})();
Gff_.Gff = Gff;
});
