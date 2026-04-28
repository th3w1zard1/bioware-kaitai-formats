#ifndef PCC_H_
#define PCC_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class pcc_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_common.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
 * tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).
 * 
 * **Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60 xoreos — `FileType` enum start (Aurora/BioWare family IDs; **PCC/Unreal packages are not in this table** — included only as canonical upstream anchor for “what this repo’s xoreos stack is”)
 * \sa https://github.com/ME3Tweaks/LegendaryExplorer/wiki/PCC-File-Format ME3Tweaks — PCC file format
 * \sa https://github.com/ME3Tweaks/LegendaryExplorer/wiki/Package-Handling ME3Tweaks — Package handling (export/import tables, UE3-era BioWare packages)
 * \sa https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/docs/XOREOS_FORMAT_COVERAGE.md In-tree — coverage matrix (PCC is out-of-xoreos Aurora scope; see table)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (KotOR-era PDFs; PCC is Mass Effect / UE3 — use LegendaryExplorer wiki as wire authority)
 */

class pcc_t : public kaitai::kstruct {

public:
    class export_entry_t;
    class export_table_t;
    class file_header_t;
    class guid_t;
    class import_entry_t;
    class import_table_t;
    class name_entry_t;
    class name_table_t;

    pcc_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, pcc_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~pcc_t();

    class export_entry_t : public kaitai::kstruct {

    public:

        export_entry_t(kaitai::kstream* p__io, pcc_t::export_table_t* p__parent = 0, pcc_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~export_entry_t();

    private:
        int32_t m_class_index;
        int32_t m_super_class_index;
        int32_t m_link;
        int32_t m_object_name_index;
        int32_t m_object_name_number;
        int32_t m_archetype_index;
        uint64_t m_object_flags;
        uint32_t m_data_size;
        uint32_t m_data_offset;
        uint32_t m_unknown1;
        int32_t m_num_components;
        uint32_t m_unknown2;
        guid_t* m_guid;
        std::vector<int32_t>* m_components;
        bool n_components;

    public:
        bool _is_null_components() { components(); return n_components; };

    private:
        pcc_t* m__root;
        pcc_t::export_table_t* m__parent;

    public:

        /**
         * Object index for the class.
         * Negative = import table index
         * Positive = export table index
         * Zero = no class
         */
        int32_t class_index() const { return m_class_index; }

        /**
         * Object index for the super class.
         * Negative = import table index
         * Positive = export table index
         * Zero = no super class
         */
        int32_t super_class_index() const { return m_super_class_index; }

        /**
         * Link to other objects (internal reference).
         */
        int32_t link() const { return m_link; }

        /**
         * Index into name table for the object name.
         */
        int32_t object_name_index() const { return m_object_name_index; }

        /**
         * Object name number (for duplicate names).
         */
        int32_t object_name_number() const { return m_object_name_number; }

        /**
         * Object index for the archetype.
         * Negative = import table index
         * Positive = export table index
         * Zero = no archetype
         */
        int32_t archetype_index() const { return m_archetype_index; }

        /**
         * Object flags bitfield (64-bit).
         */
        uint64_t object_flags() const { return m_object_flags; }

        /**
         * Size of the export data in bytes.
         */
        uint32_t data_size() const { return m_data_size; }

        /**
         * Byte offset to the export data from the beginning of the file.
         */
        uint32_t data_offset() const { return m_data_offset; }

        /**
         * Unknown field.
         */
        uint32_t unknown1() const { return m_unknown1; }

        /**
         * Number of component entries (can be negative).
         */
        int32_t num_components() const { return m_num_components; }

        /**
         * Unknown field.
         */
        uint32_t unknown2() const { return m_unknown2; }

        /**
         * GUID for this export object.
         */
        guid_t* guid() const { return m_guid; }

        /**
         * Array of component indices.
         * Only present if num_components > 0.
         */
        std::vector<int32_t>* components() const { return m_components; }
        pcc_t* _root() const { return m__root; }
        pcc_t::export_table_t* _parent() const { return m__parent; }
    };

    class export_table_t : public kaitai::kstruct {

    public:

        export_table_t(kaitai::kstream* p__io, pcc_t* p__parent = 0, pcc_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~export_table_t();

    private:
        std::vector<export_entry_t*>* m_entries;
        pcc_t* m__root;
        pcc_t* m__parent;

    public:

        /**
         * Array of export entries.
         */
        std::vector<export_entry_t*>* entries() const { return m_entries; }
        pcc_t* _root() const { return m__root; }
        pcc_t* _parent() const { return m__parent; }
    };

    class file_header_t : public kaitai::kstruct {

    public:

        file_header_t(kaitai::kstream* p__io, pcc_t* p__parent = 0, pcc_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~file_header_t();

    private:
        uint32_t m_magic;
        uint32_t m_version;
        uint32_t m_licensee_version;
        int32_t m_header_size;
        std::string m_package_name;
        uint32_t m_package_flags;
        bioware_common_t::bioware_pcc_package_kind_t m_package_type;
        uint32_t m_name_count;
        uint32_t m_name_table_offset;
        uint32_t m_export_count;
        uint32_t m_export_table_offset;
        uint32_t m_import_count;
        uint32_t m_import_table_offset;
        uint32_t m_depend_offset;
        uint32_t m_depend_count;
        uint32_t m_guid_part1;
        uint32_t m_guid_part2;
        uint32_t m_guid_part3;
        uint32_t m_guid_part4;
        uint32_t m_generations;
        uint32_t m_export_count_dup;
        uint32_t m_name_count_dup;
        uint32_t m_unknown1;
        uint32_t m_engine_version;
        uint32_t m_cooker_version;
        uint32_t m_compression_flags;
        uint32_t m_package_source;
        bioware_common_t::bioware_pcc_compression_codec_t m_compression_type;
        uint32_t m_chunk_count;
        pcc_t* m__root;
        pcc_t* m__parent;

    public:

        /**
         * Magic number identifying PCC format. Must be 0x9E2A83C1.
         */
        uint32_t magic() const { return m_magic; }

        /**
         * File format version.
         * Encoded as: (major << 16) | (minor << 8) | patch
         * Example: 0xC202AC = 194/684 (major=194, minor=684)
         */
        uint32_t version() const { return m_version; }

        /**
         * Licensee-specific version field (typically 0x67C).
         */
        uint32_t licensee_version() const { return m_licensee_version; }

        /**
         * Header size field (typically -5 = 0xFFFFFFFB).
         */
        int32_t header_size() const { return m_header_size; }

        /**
         * Package name (typically "None" = 0x4E006F006E006500).
         */
        std::string package_name() const { return m_package_name; }

        /**
         * Package flags bitfield.
         * Bit 25 (0x2000000): Compressed package
         * Bit 20 (0x100000): ME3Explorer edited format flag
         * Other bits: Various package attributes
         */
        uint32_t package_flags() const { return m_package_flags; }

        /**
         * Package type indicator (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_package_kind`
         * (LegendaryExplorer PCC wiki).
         */
        bioware_common_t::bioware_pcc_package_kind_t package_type() const { return m_package_type; }

        /**
         * Number of entries in the name table.
         */
        uint32_t name_count() const { return m_name_count; }

        /**
         * Byte offset to the name table from the beginning of the file.
         */
        uint32_t name_table_offset() const { return m_name_table_offset; }

        /**
         * Number of entries in the export table.
         */
        uint32_t export_count() const { return m_export_count; }

        /**
         * Byte offset to the export table from the beginning of the file.
         */
        uint32_t export_table_offset() const { return m_export_table_offset; }

        /**
         * Number of entries in the import table.
         */
        uint32_t import_count() const { return m_import_count; }

        /**
         * Byte offset to the import table from the beginning of the file.
         */
        uint32_t import_table_offset() const { return m_import_table_offset; }

        /**
         * Offset to dependency table (typically 0x664).
         */
        uint32_t depend_offset() const { return m_depend_offset; }

        /**
         * Number of dependencies (typically 0x67C).
         */
        uint32_t depend_count() const { return m_depend_count; }

        /**
         * First 32 bits of package GUID.
         */
        uint32_t guid_part1() const { return m_guid_part1; }

        /**
         * Second 32 bits of package GUID.
         */
        uint32_t guid_part2() const { return m_guid_part2; }

        /**
         * Third 32 bits of package GUID.
         */
        uint32_t guid_part3() const { return m_guid_part3; }

        /**
         * Fourth 32 bits of package GUID.
         */
        uint32_t guid_part4() const { return m_guid_part4; }

        /**
         * Number of generation entries.
         */
        uint32_t generations() const { return m_generations; }

        /**
         * Duplicate export count (should match export_count).
         */
        uint32_t export_count_dup() const { return m_export_count_dup; }

        /**
         * Duplicate name count (should match name_count).
         */
        uint32_t name_count_dup() const { return m_name_count_dup; }

        /**
         * Unknown field (typically 0x0).
         */
        uint32_t unknown1() const { return m_unknown1; }

        /**
         * Engine version (typically 0x18EF = 6383).
         */
        uint32_t engine_version() const { return m_engine_version; }

        /**
         * Cooker version (typically 0x3006B = 196715).
         */
        uint32_t cooker_version() const { return m_cooker_version; }

        /**
         * Compression flags (typically 0x15330000).
         */
        uint32_t compression_flags() const { return m_compression_flags; }

        /**
         * Package source identifier (typically 0x8AA0000).
         */
        uint32_t package_source() const { return m_package_source; }

        /**
         * Compression codec when package is compressed (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_compression_codec`
         * (LegendaryExplorer PCC wiki). Unused / undefined when uncompressed.
         */
        bioware_common_t::bioware_pcc_compression_codec_t compression_type() const { return m_compression_type; }

        /**
         * Number of compressed chunks (0 for uncompressed, 1 for compressed).
         * If > 0, file uses compressed structure with chunks.
         */
        uint32_t chunk_count() const { return m_chunk_count; }
        pcc_t* _root() const { return m__root; }
        pcc_t* _parent() const { return m__parent; }
    };

    class guid_t : public kaitai::kstruct {

    public:

        guid_t(kaitai::kstream* p__io, pcc_t::export_entry_t* p__parent = 0, pcc_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~guid_t();

    private:
        uint32_t m_part1;
        uint32_t m_part2;
        uint32_t m_part3;
        uint32_t m_part4;
        pcc_t* m__root;
        pcc_t::export_entry_t* m__parent;

    public:

        /**
         * First 32 bits of GUID.
         */
        uint32_t part1() const { return m_part1; }

        /**
         * Second 32 bits of GUID.
         */
        uint32_t part2() const { return m_part2; }

        /**
         * Third 32 bits of GUID.
         */
        uint32_t part3() const { return m_part3; }

        /**
         * Fourth 32 bits of GUID.
         */
        uint32_t part4() const { return m_part4; }
        pcc_t* _root() const { return m__root; }
        pcc_t::export_entry_t* _parent() const { return m__parent; }
    };

    class import_entry_t : public kaitai::kstruct {

    public:

        import_entry_t(kaitai::kstream* p__io, pcc_t::import_table_t* p__parent = 0, pcc_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~import_entry_t();

    private:
        int64_t m_package_name_index;
        int32_t m_class_name_index;
        int64_t m_link;
        int64_t m_import_name_index;
        pcc_t* m__root;
        pcc_t::import_table_t* m__parent;

    public:

        /**
         * Index into name table for package name.
         * Negative value indicates import from external package.
         * Positive value indicates import from this package.
         */
        int64_t package_name_index() const { return m_package_name_index; }

        /**
         * Index into name table for class name.
         */
        int32_t class_name_index() const { return m_class_name_index; }

        /**
         * Link to import/export table entry.
         * Used to resolve the actual object reference.
         */
        int64_t link() const { return m_link; }

        /**
         * Index into name table for the imported object name.
         */
        int64_t import_name_index() const { return m_import_name_index; }
        pcc_t* _root() const { return m__root; }
        pcc_t::import_table_t* _parent() const { return m__parent; }
    };

    class import_table_t : public kaitai::kstruct {

    public:

        import_table_t(kaitai::kstream* p__io, pcc_t* p__parent = 0, pcc_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~import_table_t();

    private:
        std::vector<import_entry_t*>* m_entries;
        pcc_t* m__root;
        pcc_t* m__parent;

    public:

        /**
         * Array of import entries.
         */
        std::vector<import_entry_t*>* entries() const { return m_entries; }
        pcc_t* _root() const { return m__root; }
        pcc_t* _parent() const { return m__parent; }
    };

    class name_entry_t : public kaitai::kstruct {

    public:

        name_entry_t(kaitai::kstream* p__io, pcc_t::name_table_t* p__parent = 0, pcc_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~name_entry_t();

    private:
        bool f_abs_length;
        int32_t m_abs_length;

    public:

        /**
         * Absolute value of length for size calculation
         */
        int32_t abs_length();

    private:
        bool f_name_size;
        int32_t m_name_size;

    public:

        /**
         * Size of name string in bytes (absolute length * 2 bytes per WCHAR)
         */
        int32_t name_size();

    private:
        int32_t m_length;
        std::string m_name;
        pcc_t* m__root;
        pcc_t::name_table_t* m__parent;

    public:

        /**
         * Length of the name string in characters (signed).
         * Negative value indicates the number of WCHAR characters.
         * Positive value is also valid but less common.
         */
        int32_t length() const { return m_length; }

        /**
         * Name string encoded as UTF-16LE (WCHAR).
         * Size is absolute value of length * 2 bytes per character.
         * Negative length indicates WCHAR count (use absolute value).
         */
        std::string name() const { return m_name; }
        pcc_t* _root() const { return m__root; }
        pcc_t::name_table_t* _parent() const { return m__parent; }
    };

    class name_table_t : public kaitai::kstruct {

    public:

        name_table_t(kaitai::kstream* p__io, pcc_t* p__parent = 0, pcc_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~name_table_t();

    private:
        std::vector<name_entry_t*>* m_entries;
        pcc_t* m__root;
        pcc_t* m__parent;

    public:

        /**
         * Array of name entries.
         */
        std::vector<name_entry_t*>* entries() const { return m_entries; }
        pcc_t* _root() const { return m__root; }
        pcc_t* _parent() const { return m__parent; }
    };

private:
    bool f_compression_type;
    bioware_common_t::bioware_pcc_compression_codec_t m_compression_type;

public:

    /**
     * Compression algorithm used (0=None, 1=Zlib, 2=LZO).
     */
    bioware_common_t::bioware_pcc_compression_codec_t compression_type();

private:
    bool f_export_table;
    export_table_t* m_export_table;
    bool n_export_table;

public:
    bool _is_null_export_table() { export_table(); return n_export_table; };

private:

public:

    /**
     * Table containing all objects exported from this package.
     */
    export_table_t* export_table();

private:
    bool f_import_table;
    import_table_t* m_import_table;
    bool n_import_table;

public:
    bool _is_null_import_table() { import_table(); return n_import_table; };

private:

public:

    /**
     * Table containing references to external packages and classes.
     */
    import_table_t* import_table();

private:
    bool f_is_compressed;
    bool m_is_compressed;

public:

    /**
     * True if package uses compressed chunks (bit 25 of package_flags).
     */
    bool is_compressed();

private:
    bool f_name_table;
    name_table_t* m_name_table;
    bool n_name_table;

public:
    bool _is_null_name_table() { name_table(); return n_name_table; };

private:

public:

    /**
     * Table containing all string names used in the package.
     */
    name_table_t* name_table();

private:
    file_header_t* m_header;
    pcc_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * File header containing format metadata and table offsets.
     */
    file_header_t* header() const { return m_header; }
    pcc_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // PCC_H_
