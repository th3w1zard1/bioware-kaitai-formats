#ifndef GFF_H_
#define GFF_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class gff_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_common.h"
#include "bioware_gff_common.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

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
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF binary format
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — GFF3File::Header::read
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181 xoreos — GFF3File load (post-header struct/field arena wiring)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72 xoreos — GFF4File::Header::read
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L151-L164 xoreos — GFF4File::load entry
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 PyKotor — GFFBinaryReader.load
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225 reone — GffReader
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts#L152-L221 KotOR.js — GFFObject.parse
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp#L86-L238 xoreos-tools — GFF3 load pipeline (shared with CLIs)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176 xoreos-tools — `gffdumper`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60 xoreos-tools — `gffcreator`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf
 */

class gff_t : public kaitai::kstruct {

public:
    class field_array_t;
    class field_data_t;
    class field_entry_t;
    class field_indices_array_t;
    class gff3_after_aurora_t;
    class gff4_after_aurora_t;
    class gff4_file_t;
    class gff4_struct_template_header_t;
    class gff_header_tail_t;
    class gff_union_file_t;
    class label_array_t;
    class label_entry_t;
    class label_entry_terminated_t;
    class list_entry_t;
    class list_indices_array_t;
    class resolved_field_t;
    class resolved_struct_t;
    class struct_array_t;
    class struct_entry_t;

    gff_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~gff_t();

    /**
     * Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
     * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
     */

    class field_array_t : public kaitai::kstruct {

    public:

        field_array_t(kaitai::kstream* p__io, gff_t::gff3_after_aurora_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_array_t();

    private:
        std::vector<field_entry_t*>* m_entries;
        gff_t* m__root;
        gff_t::gff3_after_aurora_t* m__parent;

    public:

        /**
         * Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
         * Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).
         */
        std::vector<field_entry_t*>* entries() const { return m_entries; }
        gff_t* _root() const { return m__root; }
        gff_t::gff3_after_aurora_t* _parent() const { return m__parent; }
    };

    /**
     * Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
     */

    class field_data_t : public kaitai::kstruct {

    public:

        field_data_t(kaitai::kstream* p__io, gff_t::gff3_after_aurora_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_data_t();

    private:
        std::string m_raw_data;
        gff_t* m__root;
        gff_t::gff3_after_aurora_t* m__parent;

    public:

        /**
         * Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
         * Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
         * Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
         */
        std::string raw_data() const { return m_raw_data; }
        gff_t* _root() const { return m__root; }
        gff_t::gff3_after_aurora_t* _parent() const { return m__parent; }
    };

    /**
     * One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
     * `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
     * Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
     */

    class field_entry_t : public kaitai::kstruct {

    public:

        field_entry_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_entry_t();

    private:
        bool f_field_data_offset_value;
        int32_t m_field_data_offset_value;
        bool n_field_data_offset_value;

    public:
        bool _is_null_field_data_offset_value() { field_data_offset_value(); return n_field_data_offset_value; };

    private:

    public:

        /**
         * Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
         */
        int32_t field_data_offset_value();

    private:
        bool f_is_complex_type;
        bool m_is_complex_type;

    public:

        /**
         * Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
         */
        bool is_complex_type();

    private:
        bool f_is_list_type;
        bool m_is_list_type;

    public:

        /**
         * Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
         */
        bool is_list_type();

    private:
        bool f_is_simple_type;
        bool m_is_simple_type;

    public:

        /**
         * Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
         * Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
         * **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
         */
        bool is_simple_type();

    private:
        bool f_is_struct_type;
        bool m_is_struct_type;

    public:

        /**
         * Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
         */
        bool is_struct_type();

    private:
        bool f_list_indices_offset_value;
        int32_t m_list_indices_offset_value;
        bool n_list_indices_offset_value;

    public:
        bool _is_null_list_indices_offset_value() { list_indices_offset_value(); return n_list_indices_offset_value; };

    private:

    public:

        /**
         * Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.
         */
        int32_t list_indices_offset_value();

    private:
        bool f_struct_index_value;
        uint32_t m_struct_index_value;
        bool n_struct_index_value;

    public:
        bool _is_null_struct_index_value() { struct_index_value(); return n_struct_index_value; };

    private:

    public:

        /**
         * Struct index (same numeric interpretation as `GFFStructData` row index).
         */
        uint32_t struct_index_value();

    private:
        bioware_gff_common_t::gff_field_type_t m_field_type;
        uint32_t m_label_index;
        uint32_t m_data_or_offset;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
         * (ID → storage: inline vs `field_data` vs struct/list indirection).
         * Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
         * Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
         * PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
         */
        bioware_gff_common_t::gff_field_type_t field_type() const { return m_field_type; }

        /**
         * Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.label_index` @ +0x4 (ulong).
         */
        uint32_t label_index() const { return m_label_index; }

        /**
         * Inline data (simple types) or offset/index (complex types):
         * - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
         * - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
         * - Struct (14): Struct index (index into struct_array)
         * - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFFieldData.data_or_data_offset` @ +0x8.
         * `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
         */
        uint32_t data_or_offset() const { return m_data_or_offset; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
     * “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
     */

    class field_indices_array_t : public kaitai::kstruct {

    public:

        field_indices_array_t(kaitai::kstream* p__io, gff_t::gff3_after_aurora_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_indices_array_t();

    private:
        std::vector<uint32_t>* m_indices;
        gff_t* m__root;
        gff_t::gff3_after_aurora_t* m__parent;

    public:

        /**
         * `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
         * `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
         * **Observed behavior**: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.
         */
        std::vector<uint32_t>* indices() const { return m_indices; }
        gff_t* _root() const { return m__root; }
        gff_t::gff3_after_aurora_t* _parent() const { return m__parent; }
    };

    /**
     * GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.
     */

    class gff3_after_aurora_t : public kaitai::kstruct {

    public:

        gff3_after_aurora_t(kaitai::kstream* p__io, gff_t::gff_union_file_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~gff3_after_aurora_t();

    private:
        bool f_field_array;
        field_array_t* m_field_array;
        bool n_field_array;

    public:
        bool _is_null_field_array() { field_array(); return n_field_array; };

    private:

    public:

        /**
         * Field dictionary: `header.field_count` × 12 B at `header.field_offset`. **Observed behavior**: `GFFFieldData`.
         * `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
         *     PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149
         */
        field_array_t* field_array();

    private:
        bool f_field_data;
        field_data_t* m_field_data;
        bool n_field_data;

    public:
        bool _is_null_field_data() { field_data(); return n_field_data; };

    private:

    public:

        /**
         * Complex-type payload heap. **Observed behavior**: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
         *     PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216
         */
        field_data_t* field_data();

    private:
        bool f_field_indices_array;
        field_indices_array_t* m_field_indices_array;
        bool n_field_indices_array;

    public:
        bool _is_null_field_indices_array() { field_indices_array(); return n_field_indices_array; };

    private:

    public:

        /**
         * Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
         * **Observed behavior**: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
         *     PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
         */
        field_indices_array_t* field_indices_array();

    private:
        bool f_label_array;
        label_array_t* m_label_array;
        bool n_label_array;

    public:
        bool _is_null_label_array() { label_array(); return n_label_array; };

    private:

    public:

        /**
         * Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
         * **Observed behavior**: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
         *     PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154
         */
        label_array_t* label_array();

    private:
        bool f_list_indices_array;
        list_indices_array_t* m_list_indices_array;
        bool n_list_indices_array;

    public:
        bool _is_null_list_indices_array() { list_indices_array(); return n_list_indices_array; };

    private:

    public:

        /**
         * Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
         * **Observed behavior**: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
         *     PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
         */
        list_indices_array_t* list_indices_array();

    private:
        bool f_root_struct_resolved;
        resolved_struct_t* m_root_struct_resolved;

    public:

        /**
         * Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
         * Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
         * Implements the access pattern described in meta.doc (single-field vs multi-field structs).
         */
        resolved_struct_t* root_struct_resolved();

    private:
        bool f_struct_array;
        struct_array_t* m_struct_array;
        bool n_struct_array;

    public:
        bool _is_null_struct_array() { struct_array(); return n_struct_array; };

    private:

    public:

        /**
         * Struct table: `header.struct_count` × 12 B at `header.struct_offset`. **Observed behavior**: `GFFStructData` rows.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         *     PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65
         */
        struct_array_t* struct_array();

    private:
        gff_header_tail_t* m_header;
        gff_t* m__root;
        gff_t::gff_union_file_t* m__parent;

    public:

        /**
         * Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
         * rows from Struct Array Offset through List Indices Count. **Observed behavior**: `GFFHeaderInfo` @ +0x8 … +0x34.
         */
        gff_header_tail_t* header() const { return m_header; }
        gff_t* _root() const { return m__root; }
        gff_t::gff_union_file_t* _parent() const { return m__parent; }
    };

    /**
     * GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
     * PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
     */

    class gff4_after_aurora_t : public kaitai::kstruct {

    public:

        gff4_after_aurora_t(uint32_t p_aurora_version, kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~gff4_after_aurora_t();

    private:
        uint32_t m_platform_id;
        uint32_t m_file_type;
        uint32_t m_type_version;
        uint32_t m_num_struct_templates;
        uint32_t m_string_count;
        bool n_string_count;

    public:
        bool _is_null_string_count() { string_count(); return n_string_count; };

    private:
        uint32_t m_string_offset;
        bool n_string_offset;

    public:
        bool _is_null_string_offset() { string_offset(); return n_string_offset; };

    private:
        uint32_t m_data_offset;
        std::vector<gff4_struct_template_header_t*>* m_struct_templates;
        std::string m_tail;
        uint32_t m_aurora_version;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
         * `PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).
         */
        uint32_t platform_id() const { return m_platform_id; }

        /**
         * GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
         * `readUint32BE` on the endian-aware substream (`gff4file.cpp`).
         */
        uint32_t file_type() const { return m_file_type; }

        /**
         * Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).
         */
        uint32_t type_version() const { return m_type_version; }

        /**
         * Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
         * in typical DA assets). xoreos: `_header.structCount`.
         */
        uint32_t num_struct_templates() const { return m_num_struct_templates; }

        /**
         * V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).
         */
        uint32_t string_count() const { return m_string_count; }

        /**
         * V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).
         */
        uint32_t string_offset() const { return m_string_offset; }

        /**
         * Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
         * `readUint32` on the endian substream (`gff4file.cpp`).
         */
        uint32_t data_offset() const { return m_data_offset; }

        /**
         * Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).
         */
        std::vector<gff4_struct_template_header_t*>* struct_templates() const { return m_struct_templates; }

        /**
         * Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
         * optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
         * GFF4 graph walker or defer to engine code.
         */
        std::string tail() const { return m_tail; }

        /**
         * Aurora version tag from the enclosing stream’s first 8 bytes (read on disk as `u4be`;
         * passed as `u4` for Kaitai param typing). Same value as `gff_union_file.aurora_version` / `gff4_file.aurora_version`.
         */
        uint32_t aurora_version() const { return m_aurora_version; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
     * that expect a single user-type over the whole file.
     */

    class gff4_file_t : public kaitai::kstruct {

    public:

        gff4_file_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~gff4_file_t();

    private:
        uint32_t m_aurora_magic;
        uint32_t m_aurora_version;
        gff4_after_aurora_t* m_gff4;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Aurora container magic (`GFF ` as `u4be`).
         */
        uint32_t aurora_magic() const { return m_aurora_magic; }

        /**
         * GFF4 `V4.0` / `V4.1` on-disk tags.
         */
        uint32_t aurora_version() const { return m_aurora_version; }

        /**
         * GFF4 header tail + struct templates + opaque remainder.
         */
        gff4_after_aurora_t* gff4() const { return m_gff4; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    class gff4_struct_template_header_t : public kaitai::kstruct {

    public:

        gff4_struct_template_header_t(kaitai::kstream* p__io, gff_t::gff4_after_aurora_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~gff4_struct_template_header_t();

    private:
        uint32_t m_struct_label;
        uint32_t m_field_count;
        uint32_t m_field_offset;
        uint32_t m_struct_size;
        gff_t* m__root;
        gff_t::gff4_after_aurora_t* m__parent;

    public:

        /**
         * Template label (fourCC style, read `readUint32BE` in `loadStructs`).
         */
        uint32_t struct_label() const { return m_struct_label; }

        /**
         * Number of field declaration records for this template (may be 0).
         */
        uint32_t field_count() const { return m_field_count; }

        /**
         * Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
         * (xoreos `continue`s without reading declarations).
         */
        uint32_t field_offset() const { return m_field_offset; }

        /**
         * Declared on-disk struct size for instances of this template (`strct.size`).
         */
        uint32_t struct_size() const { return m_struct_size; }
        gff_t* _root() const { return m__root; }
        gff_t::gff4_after_aurora_t* _parent() const { return m__parent; }
    };

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

    class gff_header_tail_t : public kaitai::kstruct {

    public:

        gff_header_tail_t(kaitai::kstream* p__io, gff_t::gff3_after_aurora_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~gff_header_tail_t();

    private:
        uint32_t m_struct_offset;
        uint32_t m_struct_count;
        uint32_t m_field_offset;
        uint32_t m_field_count;
        uint32_t m_label_offset;
        uint32_t m_label_count;
        uint32_t m_field_data_offset;
        uint32_t m_field_data_count;
        uint32_t m_field_indices_offset;
        uint32_t m_field_indices_count;
        uint32_t m_list_indices_offset;
        uint32_t m_list_indices_count;
        gff_t* m__root;
        gff_t::gff3_after_aurora_t* m__parent;

    public:

        /**
         * Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30
         */
        uint32_t struct_offset() const { return m_struct_offset; }

        /**
         * Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.struct_count` @ +0xC (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31
         */
        uint32_t struct_count() const { return m_struct_count; }

        /**
         * Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32
         */
        uint32_t field_offset() const { return m_field_offset; }

        /**
         * Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_count` @ +0x14 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33
         */
        uint32_t field_count() const { return m_field_count; }

        /**
         * Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34
         */
        uint32_t label_offset() const { return m_label_offset; }

        /**
         * Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.label_count` @ +0x1C (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35
         */
        uint32_t label_count() const { return m_label_count; }

        /**
         * Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36
         */
        uint32_t field_data_offset() const { return m_field_data_offset; }

        /**
         * Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37
         */
        uint32_t field_data_count() const { return m_field_data_count; }

        /**
         * Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38
         */
        uint32_t field_indices_offset() const { return m_field_indices_offset; }

        /**
         * Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)
         */
        uint32_t field_indices_count() const { return m_field_indices_count; }

        /**
         * Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40
         */
        uint32_t list_indices_offset() const { return m_list_indices_offset; }

        /**
         * List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
         * Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
         */
        uint32_t list_indices_count() const { return m_list_indices_count; }
        gff_t* _root() const { return m__root; }
        gff_t::gff3_after_aurora_t* _parent() const { return m__parent; }
    };

    /**
     * Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
     * (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
     */

    class gff_union_file_t : public kaitai::kstruct {

    public:

        gff_union_file_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~gff_union_file_t();

    private:
        uint32_t m_aurora_magic;
        uint32_t m_aurora_version;
        gff3_after_aurora_t* m_gff3;
        bool n_gff3;

    public:
        bool _is_null_gff3() { gff3(); return n_gff3; };

    private:
        gff4_after_aurora_t* m_gff4;
        bool n_gff4;

    public:
        bool _is_null_gff4() { gff4(); return n_gff4; };

    private:
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
         * legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.
         */
        uint32_t aurora_magic() const { return m_aurora_magic; }

        /**
         * Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
         * `0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.
         */
        uint32_t aurora_version() const { return m_aurora_version; }

        /**
         * **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.
         */
        gff3_after_aurora_t* gff3() const { return m_gff3; }

        /**
         * **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.
         */
        gff4_after_aurora_t* gff4() const { return m_gff4; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    /**
     * Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
     * Indexed by `GFFFieldData.label_index` (×16). Not a separate struct in **observed behavior** — rows are `char[16]` in bulk.
     * Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
     */

    class label_array_t : public kaitai::kstruct {

    public:

        label_array_t(kaitai::kstream* p__io, gff_t::gff3_after_aurora_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~label_array_t();

    private:
        std::vector<label_entry_t*>* m_labels;
        gff_t* m__root;
        gff_t::gff3_after_aurora_t* m__parent;

    public:

        /**
         * Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
         * Index `i` is at file offset `label_offset + i*16`.
         */
        std::vector<label_entry_t*>* labels() const { return m_labels; }
        gff_t* _root() const { return m__root; }
        gff_t::gff3_after_aurora_t* _parent() const { return m__parent; }
    };

    /**
     * One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
     */

    class label_entry_t : public kaitai::kstruct {

    public:

        label_entry_t(kaitai::kstream* p__io, gff_t::label_array_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~label_entry_t();

    private:
        std::string m_name;
        gff_t* m__root;
        gff_t::label_array_t* m__parent;

    public:

        /**
         * Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
         * Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
         * Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
         */
        std::string name() const { return m_name; }
        gff_t* _root() const { return m__root; }
        gff_t::label_array_t* _parent() const { return m__parent; }
    };

    /**
     * Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
     * Not a separate engine-local datatype. Wire cite: `label_entry.name`.
     */

    class label_entry_terminated_t : public kaitai::kstruct {

    public:

        label_entry_terminated_t(kaitai::kstream* p__io, gff_t::resolved_field_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~label_entry_terminated_t();

    private:
        std::string m_name;
        gff_t* m__root;
        gff_t::resolved_field_t* m__parent;

    public:

        /**
         * Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.
         */
        std::string name() const { return m_name; }
        gff_t* _root() const { return m__root; }
        gff_t::resolved_field_t* _parent() const { return m__parent; }
    };

    /**
     * One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
     * Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
     */

    class list_entry_t : public kaitai::kstruct {

    public:

        list_entry_t(kaitai::kstream* p__io, gff_t::resolved_field_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~list_entry_t();

    private:
        uint32_t m_num_struct_indices;
        std::vector<uint32_t>* m_struct_indices;
        gff_t* m__root;
        gff_t::resolved_field_t* m__parent;

    public:

        /**
         * Little-endian count of following struct indices (list cardinality).
         * Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
         */
        uint32_t num_struct_indices() const { return m_num_struct_indices; }

        /**
         * Each value indexes `struct_array.entries[index]` (`GFFStructData` row).
         */
        std::vector<uint32_t>* struct_indices() const { return m_struct_indices; }
        gff_t* _root() const { return m__root; }
        gff_t::resolved_field_t* _parent() const { return m__parent; }
    };

    /**
     * Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
     */

    class list_indices_array_t : public kaitai::kstruct {

    public:

        list_indices_array_t(kaitai::kstream* p__io, gff_t::gff3_after_aurora_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~list_indices_array_t();

    private:
        std::string m_raw_data;
        gff_t* m__root;
        gff_t::gff3_after_aurora_t* m__parent;

    public:

        /**
         * Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
         * Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
         * This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.
         */
        std::string raw_data() const { return m_raw_data; }
        gff_t* _root() const { return m__root; }
        gff_t::gff3_after_aurora_t* _parent() const { return m__parent; }
    };

    /**
     * Kaitai composition: one `GFFFieldData` row + label + payload.
     * Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
     * Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
     * For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
     */

    class resolved_field_t : public kaitai::kstruct {

    public:

        resolved_field_t(uint32_t p_field_index, kaitai::kstream* p__io, gff_t::resolved_struct_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~resolved_field_t();

    private:
        bool f_entry;
        field_entry_t* m_entry;

    public:

        /**
         * Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).
         */
        field_entry_t* entry();

    private:
        bool f_field_entry_pos;
        int32_t m_field_entry_pos;

    public:

        /**
         * Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).
         */
        int32_t field_entry_pos();

    private:
        bool f_label;
        label_entry_terminated_t* m_label;

    public:

        /**
         * Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.
         */
        label_entry_terminated_t* label();

    private:
        bool f_list_entry;
        list_entry_t* m_list_entry;
        bool n_list_entry;

    public:
        bool _is_null_list_entry() { list_entry(); return n_list_entry; };

    private:

    public:

        /**
         * `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.
         */
        list_entry_t* list_entry();

    private:
        bool f_list_structs;
        std::vector<resolved_struct_t*>* m_list_structs;
        bool n_list_structs;

    public:
        bool _is_null_list_structs() { list_structs(); return n_list_structs; };

    private:

    public:

        /**
         * Child structs for this list; indices from `list_entry.struct_indices`.
         */
        std::vector<resolved_struct_t*>* list_structs();

    private:
        bool f_value_binary;
        bioware_common_t::bioware_binary_data_t* m_value_binary;
        bool n_value_binary;

    public:
        bool _is_null_value_binary() { value_binary(); return n_value_binary; };

    private:

    public:

        /**
         * `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
         */
        bioware_common_t::bioware_binary_data_t* value_binary();

    private:
        bool f_value_double;
        double m_value_double;
        bool n_value_double;

    public:
        bool _is_null_value_double() { value_double(); return n_value_double; };

    private:

    public:

        /**
         * `GFFFieldTypes` 9 (double).
         */
        double value_double();

    private:
        bool f_value_int16;
        int16_t m_value_int16;
        bool n_value_int16;

    public:
        bool _is_null_value_int16() { value_int16(); return n_value_int16; };

    private:

    public:

        /**
         * `GFFFieldTypes` 3 (INT16 LE at +8).
         */
        int16_t value_int16();

    private:
        bool f_value_int32;
        int32_t m_value_int32;
        bool n_value_int32;

    public:
        bool _is_null_value_int32() { value_int32(); return n_value_int32; };

    private:

    public:

        /**
         * `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
         */
        int32_t value_int32();

    private:
        bool f_value_int64;
        int64_t m_value_int64;
        bool n_value_int64;

    public:
        bool _is_null_value_int64() { value_int64(); return n_value_int64; };

    private:

    public:

        /**
         * `GFFFieldTypes` 7 (INT64).
         */
        int64_t value_int64();

    private:
        bool f_value_int8;
        int8_t m_value_int8;
        bool n_value_int8;

    public:
        bool _is_null_value_int8() { value_int8(); return n_value_int8; };

    private:

    public:

        /**
         * `GFFFieldTypes` 1 (INT8 in low byte of slot).
         */
        int8_t value_int8();

    private:
        bool f_value_localized_string;
        bioware_common_t::bioware_locstring_t* m_value_localized_string;
        bool n_value_localized_string;

    public:
        bool _is_null_value_localized_string() { value_localized_string(); return n_value_localized_string; };

    private:

    public:

        /**
         * `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
         */
        bioware_common_t::bioware_locstring_t* value_localized_string();

    private:
        bool f_value_resref;
        bioware_common_t::bioware_resref_t* m_value_resref;
        bool n_value_resref;

    public:
        bool _is_null_value_resref() { value_resref(); return n_value_resref; };

    private:

    public:

        /**
         * `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
         */
        bioware_common_t::bioware_resref_t* value_resref();

    private:
        bool f_value_single;
        float m_value_single;
        bool n_value_single;

    public:
        bool _is_null_value_single() { value_single(); return n_value_single; };

    private:

    public:

        /**
         * `GFFFieldTypes` 8 (32-bit float).
         */
        float value_single();

    private:
        bool f_value_str_ref;
        uint32_t m_value_str_ref;
        bool n_value_str_ref;

    public:
        bool _is_null_value_str_ref() { value_str_ref(); return n_value_str_ref; };

    private:

    public:

        /**
         * `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
         * `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
         * **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
         * Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
         * PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
         */
        uint32_t value_str_ref();

    private:
        bool f_value_string;
        bioware_common_t::bioware_cexo_string_t* m_value_string;
        bool n_value_string;

    public:
        bool _is_null_value_string() { value_string(); return n_value_string; };

    private:

    public:

        /**
         * `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
         */
        bioware_common_t::bioware_cexo_string_t* value_string();

    private:
        bool f_value_struct;
        resolved_struct_t* m_value_struct;
        bool n_value_struct;

    public:
        bool _is_null_value_struct() { value_struct(); return n_value_struct; };

    private:

    public:

        /**
         * `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.
         */
        resolved_struct_t* value_struct();

    private:
        bool f_value_uint16;
        uint16_t m_value_uint16;
        bool n_value_uint16;

    public:
        bool _is_null_value_uint16() { value_uint16(); return n_value_uint16; };

    private:

    public:

        /**
         * `GFFFieldTypes` 2 (UINT16 LE at +8).
         */
        uint16_t value_uint16();

    private:
        bool f_value_uint32;
        uint32_t m_value_uint32;
        bool n_value_uint32;

    public:
        bool _is_null_value_uint32() { value_uint32(); return n_value_uint32; };

    private:

    public:

        /**
         * `GFFFieldTypes` 4 (full inline DWORD).
         */
        uint32_t value_uint32();

    private:
        bool f_value_uint64;
        uint64_t m_value_uint64;
        bool n_value_uint64;

    public:
        bool _is_null_value_uint64() { value_uint64(); return n_value_uint64; };

    private:

    public:

        /**
         * `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
         */
        uint64_t value_uint64();

    private:
        bool f_value_uint8;
        uint8_t m_value_uint8;
        bool n_value_uint8;

    public:
        bool _is_null_value_uint8() { value_uint8(); return n_value_uint8; };

    private:

    public:

        /**
         * `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
         */
        uint8_t value_uint8();

    private:
        bool f_value_vector3;
        bioware_common_t::bioware_vector3_t* m_value_vector3;
        bool n_value_vector3;

    public:
        bool _is_null_value_vector3() { value_vector3(); return n_value_vector3; };

    private:

    public:

        /**
         * `GFFFieldTypes` 17 — three floats (`bioware_vector3`).
         */
        bioware_common_t::bioware_vector3_t* value_vector3();

    private:
        bool f_value_vector4;
        bioware_common_t::bioware_vector4_t* m_value_vector4;
        bool n_value_vector4;

    public:
        bool _is_null_value_vector4() { value_vector4(); return n_value_vector4; };

    private:

    public:

        /**
         * `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
         */
        bioware_common_t::bioware_vector4_t* value_vector4();

    private:
        uint32_t m_field_index;
        gff_t* m__root;
        gff_t::resolved_struct_t* m__parent;

    public:

        /**
         * Index into `field_array.entries`; require `field_index < field_count`.
         */
        uint32_t field_index() const { return m_field_index; }
        gff_t* _root() const { return m__root; }
        gff_t::resolved_struct_t* _parent() const { return m__parent; }
    };

    /**
     * Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
     * On-disk row remains at `struct_offset + struct_index * 12`.
     */

    class resolved_struct_t : public kaitai::kstruct {

    public:

        resolved_struct_t(uint32_t p_struct_index, kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~resolved_struct_t();

    private:
        bool f_entry;
        struct_entry_t* m_entry;

    public:

        /**
         * Raw `GFFStructData` (12-byte layout in **observed behavior**).
         */
        struct_entry_t* entry();

    private:
        bool f_field_indices;
        std::vector<uint32_t>* m_field_indices;
        bool n_field_indices;

    public:
        bool _is_null_field_indices() { field_indices(); return n_field_indices; };

    private:

    public:

        /**
         * Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
         * Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
         */
        std::vector<uint32_t>* field_indices();

    private:
        bool f_fields;
        std::vector<resolved_field_t*>* m_fields;
        bool n_fields;

    public:
        bool _is_null_fields() { fields(); return n_fields; };

    private:

    public:

        /**
         * One `resolved_field` per entry in `field_indices`.
         */
        std::vector<resolved_field_t*>* fields();

    private:
        bool f_single_field;
        resolved_field_t* m_single_field;
        bool n_single_field;

    public:
        bool _is_null_single_field() { single_field(); return n_single_field; };

    private:

    public:

        /**
         * `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).
         */
        resolved_field_t* single_field();

    private:
        uint32_t m_struct_index;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.
         */
        uint32_t struct_index() const { return m_struct_index; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Name in **observed behavior**: `GFFStructData`.
     * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
     */

    class struct_array_t : public kaitai::kstruct {

    public:

        struct_array_t(kaitai::kstream* p__io, gff_t::gff3_after_aurora_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~struct_array_t();

    private:
        std::vector<struct_entry_t*>* m_entries;
        gff_t* m__root;
        gff_t::gff3_after_aurora_t* m__parent;

    public:

        /**
         * Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
         * Stride 12 bytes per struct (matches the component layout in **observed behavior**).
         */
        std::vector<struct_entry_t*>* entries() const { return m_entries; }
        gff_t* _root() const { return m__root; }
        gff_t::gff3_after_aurora_t* _parent() const { return m__parent; }
    };

    /**
     * One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
     */

    class struct_entry_t : public kaitai::kstruct {

    public:

        struct_entry_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~struct_entry_t();

    private:
        bool f_field_indices_offset;
        uint32_t m_field_indices_offset;
        bool n_field_indices_offset;

    public:
        bool _is_null_field_indices_offset() { field_indices_offset(); return n_field_indices_offset; };

    private:

    public:

        /**
         * Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.
         */
        uint32_t field_indices_offset();

    private:
        bool f_has_multiple_fields;
        bool m_has_multiple_fields;

    public:

        /**
         * Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
         */
        bool has_multiple_fields();

    private:
        bool f_has_single_field;
        bool m_has_single_field;

    public:

        /**
         * Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
         * Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         */
        bool has_single_field();

    private:
        bool f_single_field_index;
        uint32_t m_single_field_index;
        bool n_single_field_index;

    public:
        bool _is_null_single_field_index() { single_field_index(); return n_single_field_index; };

    private:

    public:

        /**
         * Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
         */
        uint32_t single_field_index();

    private:
        uint32_t m_struct_id;
        uint32_t m_data_or_offset;
        uint32_t m_field_count;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Structure type identifier.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         * 0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.
         */
        uint32_t struct_id() const { return m_struct_id; }

        /**
         * Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
         * If field_count == 0, this value is unused.
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
         */
        uint32_t data_or_offset() const { return m_data_or_offset; }

        /**
         * Number of fields in this struct:
         * - 0: No fields
         * - 1: Single field, data_or_offset contains the field index directly
         * - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
         * **Observed behavior** (k1_win_gog_swkotor.exe): `GFFStructData.field_count` @ +0x8 (ulong).
         */
        uint32_t field_count() const { return m_field_count; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

private:
    gff_union_file_t* m_file;
    gff_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
     * (`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
     * Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
     * mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
     * downstream `pos:` / `_root.file.gff3.header` paths.
     */
    gff_union_file_t* file() const { return m_file; }
    gff_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // GFF_H_
