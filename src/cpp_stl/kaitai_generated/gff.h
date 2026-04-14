#ifndef GFF_H_
#define GFF_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class gff_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_common.h"
#include <set>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * GFF (Generic File Format) is BioWare's universal container format for structured game data.
 * It is used by many KotOR file types including UTC (creature), UTI (item), DLG (dialogue),
 * ARE (area), GIT (game instance template), IFO (module info), and many others.
 * 
 * GFF uses a hierarchical structure with structs containing fields, which can be simple values,
 * nested structs, or lists of structs. The format supports version V3.2 (KotOR) and later
 * versions (V3.3, V4.0, V4.1) used in other BioWare games.
 * 
 * Binary Format Structure:
 * - File Header (56 bytes): File type signature (FourCC), version, counts, and offsets to all
 *   data tables (structs, fields, labels, field_data, field_indices, list_indices)
 * - Label Array: Array of 16-byte null-padded field name labels
 * - Struct Array: Array of struct entries (12 bytes each) - struct_id (uint32; 0xFFFFFFFF = generic per engine), data_or_offset, field_count
 * - Field Array: Array of field entries (12 bytes each) - field_type, label_index, data_or_offset
 * - Field Data: Storage area for complex field types (strings, binary, vectors, etc.)
 * - Field Indices Array: Array of field index arrays (used when structs have multiple fields)
 * - List Indices Array: Array of list entry structures (count + struct indices)
 * 
 * Field Types:
 * - Simple types (0-5, 8, 18): Stored inline in data_or_offset (uint8, int8, uint16, int16, uint32,
 *   int32, float, str_ref as TLK StrRef / uint32)
 * - Complex types (6-7, 9-13, 16-17): Offset to field_data section (uint64, int64, double, string,
 *   resref, localized_string, binary, vector4, vector3)
 * - Struct (14): Struct index stored inline (nested struct)
 * - List (15): Offset to list_indices_array (list of structs)
 * 
 * StrRef (18) is a distinct field type from Int (5): same 4-byte inline width, indexes dialog.tlk
 * (see PyKotor wiki GFF-File-Format.md — GFF Data Types).
 * 
 * Struct Access Pattern:
 * 1. Root struct is always at struct_array index 0
 * 2. If struct.field_count == 1: data_or_offset contains direct field index
 * 3. If struct.field_count > 1: data_or_offset contains offset into field_indices_array
 * 4. Use field_index to access field_array entry
 * 5. Use field.label_index to get field name from label_array
 * 6. Use field.data_or_offset based on field_type (inline, offset, struct index, list offset)
 * 
 * References:
 * - https://github.com/OldRepublicDevs/PyKotor/wiki/GFF-File-Format.md - Complete GFF format documentation
 * - https://github.com/OldRepublicDevs/PyKotor/wiki/Bioware-Aurora-GFF.md - Official BioWare Aurora GFF specification
 * - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html - Tim Smith/Torlack's GFF/ITP documentation
 * - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/gffreader.cpp - Complete C++ GFF reader implementation
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp - Generic Aurora GFF implementation (shared format)
 * - https://github.com/KotOR-Community-Patches/KotOR.js/blob/master/src/resource/GFFObject.ts - TypeScript GFF parser
 * - https://github.com/KotOR-Community-Patches/KotOR-Unity/blob/master/Assets/Scripts/FileObjects/GFFObject.cs - C# Unity GFF loader
 * - https://github.com/KotOR-Community-Patches/Kotor.NET/tree/master/Kotor.NET/Formats/KotorGFF/ - .NET GFF reader/writer
 * - https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py - PyKotor binary reader/writer
 * - https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py - GFF data model
 */

class gff_t : public kaitai::kstruct {

public:
    class field_array_t;
    class field_data_t;
    class field_entry_t;
    class field_indices_array_t;
    class gff_header_t;
    class label_array_t;
    class label_entry_t;
    class label_entry_terminated_t;
    class list_entry_t;
    class list_indices_array_t;
    class resolved_field_t;
    class resolved_struct_t;
    class struct_array_t;
    class struct_entry_t;

    enum gff_field_type_t {
        GFF_FIELD_TYPE_UINT8 = 0,
        GFF_FIELD_TYPE_INT8 = 1,
        GFF_FIELD_TYPE_UINT16 = 2,
        GFF_FIELD_TYPE_INT16 = 3,
        GFF_FIELD_TYPE_UINT32 = 4,
        GFF_FIELD_TYPE_INT32 = 5,
        GFF_FIELD_TYPE_UINT64 = 6,
        GFF_FIELD_TYPE_INT64 = 7,
        GFF_FIELD_TYPE_SINGLE = 8,
        GFF_FIELD_TYPE_DOUBLE = 9,
        GFF_FIELD_TYPE_STRING = 10,
        GFF_FIELD_TYPE_RESREF = 11,
        GFF_FIELD_TYPE_LOCALIZED_STRING = 12,
        GFF_FIELD_TYPE_BINARY = 13,
        GFF_FIELD_TYPE_STRUCT = 14,
        GFF_FIELD_TYPE_LIST = 15,
        GFF_FIELD_TYPE_VECTOR4 = 16,
        GFF_FIELD_TYPE_VECTOR3 = 17,
        GFF_FIELD_TYPE_STR_REF = 18
    };
    static bool _is_defined_gff_field_type_t(gff_field_type_t v);

private:
    static const std::set<gff_field_type_t> _values_gff_field_type_t;
    static std::set<gff_field_type_t> _build_values_gff_field_type_t();

public:

    gff_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~gff_t();

    class field_array_t : public kaitai::kstruct {

    public:

        field_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_array_t();

    private:
        std::vector<field_entry_t*>* m_entries;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Array of field entries (12 bytes each)
         */
        std::vector<field_entry_t*>* entries() const { return m_entries; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    class field_data_t : public kaitai::kstruct {

    public:

        field_data_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_data_t();

    private:
        std::string m_raw_data;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Raw field data storage. Individual field data entries are accessed via
         * field_entry.field_data_offset_value offsets. The structure of each entry
         * depends on the field_type:
         * - UInt64/Int64/Double: 8 bytes
         * - String: 4-byte length + string bytes
         * - ResRef: 1-byte length + string bytes (max 16)
         * - LocalizedString: variable (see bioware_common::bioware_locstring type)
         * - Binary: 4-byte length + binary bytes
         * - Vector3: 12 bytes (3×float)
         * - Vector4: 16 bytes (4×float)
         */
        std::string raw_data() const { return m_raw_data; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

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
         * Absolute file offset to field data for complex types
         */
        int32_t field_data_offset_value();

    private:
        bool f_is_complex_type;
        bool m_is_complex_type;

    public:

        /**
         * True if field stores data in field_data section
         */
        bool is_complex_type();

    private:
        bool f_is_list_type;
        bool m_is_list_type;

    public:

        /**
         * True if field is a list of structs
         */
        bool is_list_type();

    private:
        bool f_is_simple_type;
        bool m_is_simple_type;

    public:

        /**
         * True if field stores data inline (simple types)
         */
        bool is_simple_type();

    private:
        bool f_is_struct_type;
        bool m_is_struct_type;

    public:

        /**
         * True if field is a nested struct
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
         * Absolute file offset to list indices for list type fields
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
         * Struct index for struct type fields
         */
        uint32_t struct_index_value();

    private:
        gff_field_type_t m_field_type;
        uint32_t m_label_index;
        uint32_t m_data_or_offset;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Field data type (see gff_field_type enum):
         * - 0-5, 8, 18: Simple types (stored inline in data_or_offset)
         * - 6-7, 9-13, 16-17: Complex types (offset to field_data in data_or_offset)
         * - 14: Struct (struct index in data_or_offset)
         * - 15: List (offset to list_indices_array in data_or_offset)
         * Source: Odyssey Ghidra `GFFFieldData.field_type` @ +0x0, typed `GFFFieldTypes` in the same program.
         * Runtime: `CResGFF::GetField` @ `0x00410990` indexes the field table with 12-byte stride; `ReadFieldBYTE`
         * @ `0x00411a60` / `ReadFieldINT` @ `0x00411c90` dispatch on resolved field records after lookup.
         */
        gff_field_type_t field_type() const { return m_field_type; }

        /**
         * Index into label_array for field name.
         * Source: Ghidra `GFFFieldData.label_index` @ +0x4 (ulong).
         */
        uint32_t label_index() const { return m_label_index; }

        /**
         * Inline data (simple types) or offset/index (complex types):
         * - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
         * - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
         * - Struct (14): Struct index (index into struct_array)
         * - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
         * Source: Ghidra `GFFFieldData.data_or_data_offset` @ +0x8. Kaitai `resolved_field` reads narrow
         * integers from this same 12-byte record at file offset `field_offset + index*12 + 8` for inline types
         * (matches how `ReadField*` consumers use the resolved field payload width).
         */
        uint32_t data_or_offset() const { return m_data_or_offset; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    class field_indices_array_t : public kaitai::kstruct {

    public:

        field_indices_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_indices_array_t();

    private:
        std::vector<uint32_t>* m_indices;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Array of field indices. When a struct has multiple fields, it stores an offset
         * into this array, and the next N consecutive u4 values (where N = struct.field_count)
         * are the field indices for that struct.
         */
        std::vector<uint32_t>* indices() const { return m_indices; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    class gff_header_t : public kaitai::kstruct {

    public:

        gff_header_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~gff_header_t();

    private:
        std::string m_file_type;
        std::string m_file_version;
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
        gff_t* m__parent;

    public:

        /**
         * File type signature (FourCC). Examples: "GFF ", "UTC ", "UTI ", "DLG ", "ARE ", etc.
         * Must match a valid GFFContent enum value.
         * Source: Odyssey Ghidra `/K1/k1_win_gog_swkotor.exe` datatype `GFFHeaderInfo.file_type` @ +0x0 (char[4]).
         * See also: pykotor_wiki_gff_format (content FourCC vs container).
         */
        std::string file_type() const { return m_file_type; }

        /**
         * File format version. Must be "V3.2" for KotOR games.
         * Later BioWare games use "V3.3", "V4.0", or "V4.1".
         * Valid values: "V3.2" (KotOR), "V3.3", "V4.0", "V4.1" (other BioWare games)
         * Source: Ghidra `GFFHeaderInfo.file_version` @ +0x4 (char[4]) on same program path as meta.xref.
         */
        std::string file_version() const { return m_file_version; }

        /**
         * Byte offset to struct array from beginning of file.
         * Source: Ghidra `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
         */
        uint32_t struct_offset() const { return m_struct_offset; }

        /**
         * Number of struct entries in struct array.
         * Source: Ghidra `GFFHeaderInfo.struct_count` @ +0xC (ulong).
         */
        uint32_t struct_count() const { return m_struct_count; }

        /**
         * Byte offset to field array from beginning of file.
         * Source: Ghidra `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
         */
        uint32_t field_offset() const { return m_field_offset; }

        /**
         * Number of field entries in field array.
         * Source: Ghidra `GFFHeaderInfo.field_count` @ +0x14 (ulong).
         */
        uint32_t field_count() const { return m_field_count; }

        /**
         * Byte offset to label array from beginning of file.
         * Source: Ghidra `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
         */
        uint32_t label_offset() const { return m_label_offset; }

        /**
         * Number of labels in label array.
         * Source: Ghidra `GFFHeaderInfo.label_count` @ +0x1C (ulong).
         */
        uint32_t label_count() const { return m_label_count; }

        /**
         * Byte offset to field data section from beginning of file.
         * Source: Ghidra `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
         */
        uint32_t field_data_offset() const { return m_field_data_offset; }

        /**
         * Size of field data section in bytes.
         * Source: Ghidra `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
         */
        uint32_t field_data_count() const { return m_field_data_count; }

        /**
         * Byte offset to field indices array from beginning of file.
         * Source: Ghidra `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
         */
        uint32_t field_indices_offset() const { return m_field_indices_offset; }

        /**
         * Number of field indices (total count across all structs with multiple fields).
         * Source: Ghidra `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
         */
        uint32_t field_indices_count() const { return m_field_indices_count; }

        /**
         * Byte offset to list indices array from beginning of file.
         * Source: Ghidra `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
         */
        uint32_t list_indices_offset() const { return m_list_indices_offset; }

        /**
         * Number of list indices entries.
         * Source: Ghidra `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
         */
        uint32_t list_indices_count() const { return m_list_indices_count; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    class label_array_t : public kaitai::kstruct {

    public:

        label_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~label_array_t();

    private:
        std::vector<label_entry_t*>* m_labels;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Array of label entries (16 bytes each)
         */
        std::vector<label_entry_t*>* labels() const { return m_labels; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

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
         * Field name label (null-padded to 16 bytes, null-terminated).
         * The actual label length is determined by the first null byte.
         * Application code should trim trailing null bytes when using this field.
         */
        std::string name() const { return m_name; }
        gff_t* _root() const { return m__root; }
        gff_t::label_array_t* _parent() const { return m__parent; }
    };

    /**
     * Label entry as a null-terminated ASCII string within a fixed 16-byte field.
     * This avoids leaking trailing `\0` bytes into generated-code consumers.
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
        std::string name() const { return m_name; }
        gff_t* _root() const { return m__root; }
        gff_t::resolved_field_t* _parent() const { return m__parent; }
    };

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
         * Number of struct indices in this list
         */
        uint32_t num_struct_indices() const { return m_num_struct_indices; }

        /**
         * Array of struct indices (indices into struct_array)
         */
        std::vector<uint32_t>* struct_indices() const { return m_struct_indices; }
        gff_t* _root() const { return m__root; }
        gff_t::resolved_field_t* _parent() const { return m__parent; }
    };

    class list_indices_array_t : public kaitai::kstruct {

    public:

        list_indices_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~list_indices_array_t();

    private:
        std::string m_raw_data;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Raw list indices data. List entries are accessed via offsets stored in
         * list-type field entries (field_entry.list_indices_offset_value).
         * Each entry starts with a count (u4), followed by that many struct indices (u4 each).
         * 
         * Note: This is a raw data block. In practice, list entries are accessed via
         * offsets stored in list-type field entries, not as a sequential array.
         * Use list_entry type to parse individual entries at specific offsets.
         */
        std::string raw_data() const { return m_raw_data; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    /**
     * A decoded field: includes resolved label string and decoded typed value.
     * Exactly one `value_*` instance (or one of `value_struct` / `list_*`) will be active for a
     * valid field_type; includes `value_str_ref` for TLK StrRef (type 18).
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
         * Raw field entry at field_index
         */
        field_entry_t* entry();

    private:
        bool f_field_entry_pos;
        int32_t m_field_entry_pos;

    public:

        /**
         * Absolute file offset of this field entry (start of 12-byte record)
         */
        int32_t field_entry_pos();

    private:
        bool f_label;
        label_entry_terminated_t* m_label;

    public:

        /**
         * Resolved field label string
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
         * Parsed list entry at offset (list indices)
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
         * Resolved structs referenced by this list
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
        bioware_common_t::bioware_binary_data_t* value_binary();

    private:
        bool f_value_double;
        double m_value_double;
        bool n_value_double;

    public:
        bool _is_null_value_double() { value_double(); return n_value_double; };

    private:

    public:
        double value_double();

    private:
        bool f_value_int16;
        int16_t m_value_int16;
        bool n_value_int16;

    public:
        bool _is_null_value_int16() { value_int16(); return n_value_int16; };

    private:

    public:
        int16_t value_int16();

    private:
        bool f_value_int32;
        int32_t m_value_int32;
        bool n_value_int32;

    public:
        bool _is_null_value_int32() { value_int32(); return n_value_int32; };

    private:

    public:
        int32_t value_int32();

    private:
        bool f_value_int64;
        int64_t m_value_int64;
        bool n_value_int64;

    public:
        bool _is_null_value_int64() { value_int64(); return n_value_int64; };

    private:

    public:
        int64_t value_int64();

    private:
        bool f_value_int8;
        int8_t m_value_int8;
        bool n_value_int8;

    public:
        bool _is_null_value_int8() { value_int8(); return n_value_int8; };

    private:

    public:
        int8_t value_int8();

    private:
        bool f_value_localized_string;
        bioware_common_t::bioware_locstring_t* m_value_localized_string;
        bool n_value_localized_string;

    public:
        bool _is_null_value_localized_string() { value_localized_string(); return n_value_localized_string; };

    private:

    public:
        bioware_common_t::bioware_locstring_t* value_localized_string();

    private:
        bool f_value_resref;
        bioware_common_t::bioware_resref_t* m_value_resref;
        bool n_value_resref;

    public:
        bool _is_null_value_resref() { value_resref(); return n_value_resref; };

    private:

    public:
        bioware_common_t::bioware_resref_t* value_resref();

    private:
        bool f_value_single;
        float m_value_single;
        bool n_value_single;

    public:
        bool _is_null_value_single() { value_single(); return n_value_single; };

    private:

    public:
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
         * TLK string reference stored inline (type ID 18). Same width as int32; 0xFFFFFFFF means
         * no string / not set in many game files (see TLK StrRef conventions).
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
         * Nested struct (struct index = entry.data_or_offset)
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
        uint16_t value_uint16();

    private:
        bool f_value_uint32;
        uint32_t m_value_uint32;
        bool n_value_uint32;

    public:
        bool _is_null_value_uint32() { value_uint32(); return n_value_uint32; };

    private:

    public:
        uint32_t value_uint32();

    private:
        bool f_value_uint64;
        uint64_t m_value_uint64;
        bool n_value_uint64;

    public:
        bool _is_null_value_uint64() { value_uint64(); return n_value_uint64; };

    private:

    public:
        uint64_t value_uint64();

    private:
        bool f_value_uint8;
        uint8_t m_value_uint8;
        bool n_value_uint8;

    public:
        bool _is_null_value_uint8() { value_uint8(); return n_value_uint8; };

    private:

    public:
        uint8_t value_uint8();

    private:
        bool f_value_vector3;
        bioware_common_t::bioware_vector3_t* m_value_vector3;
        bool n_value_vector3;

    public:
        bool _is_null_value_vector3() { value_vector3(); return n_value_vector3; };

    private:

    public:
        bioware_common_t::bioware_vector3_t* value_vector3();

    private:
        bool f_value_vector4;
        bioware_common_t::bioware_vector4_t* m_value_vector4;
        bool n_value_vector4;

    public:
        bool _is_null_value_vector4() { value_vector4(); return n_value_vector4; };

    private:

    public:
        bioware_common_t::bioware_vector4_t* value_vector4();

    private:
        uint32_t m_field_index;
        gff_t* m__root;
        gff_t::resolved_struct_t* m__parent;

    public:

        /**
         * Index into field_array
         */
        uint32_t field_index() const { return m_field_index; }
        gff_t* _root() const { return m__root; }
        gff_t::resolved_struct_t* _parent() const { return m__parent; }
    };

    /**
     * A decoded struct node: resolves field indices -> field entries -> typed values,
     * and recursively resolves nested structs and lists.
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
         * Raw struct entry at struct_index
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
         * Field indices for this struct (only present when field_count > 1).
         * When field_count == 1, the single field index is stored directly in entry.data_or_offset.
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
         * Resolved fields (multi-field struct)
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
         * Resolved field (single-field struct)
         */
        resolved_field_t* single_field();

    private:
        uint32_t m_struct_index;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Index into struct_array
         */
        uint32_t struct_index() const { return m_struct_index; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    class struct_array_t : public kaitai::kstruct {

    public:

        struct_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~struct_array_t();

    private:
        std::vector<struct_entry_t*>* m_entries;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Array of struct entries (12 bytes each)
         */
        std::vector<struct_entry_t*>* entries() const { return m_entries; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

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
         * Byte offset into field_indices_array when struct has multiple fields
         */
        uint32_t field_indices_offset();

    private:
        bool f_has_multiple_fields;
        bool m_has_multiple_fields;

    public:

        /**
         * True if struct has multiple fields (offset to field indices in data_or_offset)
         */
        bool has_multiple_fields();

    private:
        bool f_has_single_field;
        bool m_has_single_field;

    public:

        /**
         * True if struct has exactly one field (direct field index in data_or_offset)
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
         * Direct field index when struct has exactly one field
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
         * Source: Odyssey Ghidra `/K1/k1_win_gog_swkotor.exe` `GFFStructData.id` @ +0x0 (ulong).
         * 0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.
         */
        uint32_t struct_id() const { return m_struct_id; }

        /**
         * Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
         * If field_count == 0, this value is unused.
         * Source: Ghidra `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
         */
        uint32_t data_or_offset() const { return m_data_or_offset; }

        /**
         * Number of fields in this struct:
         * - 0: No fields
         * - 1: Single field, data_or_offset contains the field index directly
         * - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
         * Source: Ghidra `GFFStructData.field_count` @ +0x8 (ulong).
         */
        uint32_t field_count() const { return m_field_count; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

private:
    bool f_field_array;
    field_array_t* m_field_array;
    bool n_field_array;

public:
    bool _is_null_field_array() { field_array(); return n_field_array; };

private:

public:

    /**
     * Array of field entries (12 bytes each)
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
     * Storage area for complex field types (strings, binary, vectors, etc.)
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
     * Array of field index arrays (used when structs have multiple fields)
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
     * Array of 16-byte null-padded field name labels
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
     * Array of list entry structures (count + struct indices)
     */
    list_indices_array_t* list_indices_array();

private:
    bool f_root_struct_resolved;
    resolved_struct_t* m_root_struct_resolved;

public:

    /**
     * Convenience "decoded" view of the root struct (struct_array[0]).
     * This resolves field indices to field entries, resolves labels to strings,
     * and decodes field values (including nested structs and lists) into typed instances.
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
     * Array of struct entries (12 bytes each)
     */
    struct_array_t* struct_array();

private:
    gff_header_t* m_header;
    gff_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * GFF file header (56 bytes total)
     */
    gff_header_t* header() const { return m_header; }
    gff_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // GFF_H_
