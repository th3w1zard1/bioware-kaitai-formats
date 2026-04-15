#ifndef KEY_H_
#define KEY_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class key_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_type_ids.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
 * Resource types use `bioware_type_ids`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key PyKotor wiki — KEY
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp#L50-L88 xoreos — KEY::load
 */

class key_t : public kaitai::kstruct {

public:
    class file_entry_t;
    class file_table_t;
    class filename_table_t;
    class key_entry_t;
    class key_table_t;

    key_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, key_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~key_t();

    class file_entry_t : public kaitai::kstruct {

    public:

        file_entry_t(kaitai::kstream* p__io, key_t::file_table_t* p__parent = 0, key_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~file_entry_t();

    private:
        bool f_filename;
        std::string m_filename;

    public:

        /**
         * BIF filename string at the absolute filename_offset in the KEY file.
         */
        std::string filename();

    private:
        uint32_t m_file_size;
        uint32_t m_filename_offset;
        uint16_t m_filename_size;
        uint16_t m_drives;
        key_t* m__root;
        key_t::file_table_t* m__parent;

    public:

        /**
         * Size of the BIF file on disk in bytes.
         */
        uint32_t file_size() const { return m_file_size; }

        /**
         * Absolute byte offset from the start of the KEY file where this BIF's filename is stored
         * (seek(filename_offset), then read filename_size bytes).
         * This is not relative to the file table or to the end of the BIF entry array.
         */
        uint32_t filename_offset() const { return m_filename_offset; }

        /**
         * Length of the filename in bytes (including null terminator).
         */
        uint16_t filename_size() const { return m_filename_size; }

        /**
         * Drive flags indicating which media contains the BIF file.
         * Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
         * Modern distributions typically use 0x0001 (HD) for all files.
         */
        uint16_t drives() const { return m_drives; }
        key_t* _root() const { return m__root; }
        key_t::file_table_t* _parent() const { return m__parent; }
    };

    class file_table_t : public kaitai::kstruct {

    public:

        file_table_t(kaitai::kstream* p__io, key_t* p__parent = 0, key_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~file_table_t();

    private:
        std::vector<file_entry_t*>* m_entries;
        key_t* m__root;
        key_t* m__parent;

    public:

        /**
         * Array of BIF file entries.
         */
        std::vector<file_entry_t*>* entries() const { return m_entries; }
        key_t* _root() const { return m__root; }
        key_t* _parent() const { return m__parent; }
    };

    class filename_table_t : public kaitai::kstruct {

    public:

        filename_table_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, key_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~filename_table_t();

    private:
        std::string m_filenames;
        key_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Null-terminated BIF filenames concatenated together.
         * Each filename is read using the filename_offset and filename_size
         * from the corresponding file_entry.
         */
        std::string filenames() const { return m_filenames; }
        key_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    class key_entry_t : public kaitai::kstruct {

    public:

        key_entry_t(kaitai::kstream* p__io, key_t::key_table_t* p__parent = 0, key_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~key_entry_t();

    private:
        std::string m_resref;
        bioware_type_ids_t::xoreos_file_type_id_t m_resource_type;
        uint32_t m_resource_id;
        key_t* m__root;
        key_t::key_table_t* m__parent;

    public:

        /**
         * Resource filename (ResRef) without extension.
         * Null-padded, maximum 16 characters.
         * The game uses this name to access the resource.
         */
        std::string resref() const { return m_resref; }

        /**
         * Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
         * `formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).
         */
        bioware_type_ids_t::xoreos_file_type_id_t resource_type() const { return m_resource_type; }

        /**
         * Encoded resource location.
         * Bits 31-20: BIF index (top 12 bits) - index into file table
         * Bits 19-0: Resource index (bottom 20 bits) - index within the BIF file
         * 
         * Formula: resource_id = (bif_index << 20) | resource_index
         * 
         * Decoding:
         * - bif_index = (resource_id >> 20) & 0xFFF
         * - resource_index = resource_id & 0xFFFFF
         */
        uint32_t resource_id() const { return m_resource_id; }
        key_t* _root() const { return m__root; }
        key_t::key_table_t* _parent() const { return m__parent; }
    };

    class key_table_t : public kaitai::kstruct {

    public:

        key_table_t(kaitai::kstream* p__io, key_t* p__parent = 0, key_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~key_table_t();

    private:
        std::vector<key_entry_t*>* m_entries;
        key_t* m__root;
        key_t* m__parent;

    public:

        /**
         * Array of resource entries.
         */
        std::vector<key_entry_t*>* entries() const { return m_entries; }
        key_t* _root() const { return m__root; }
        key_t* _parent() const { return m__parent; }
    };

private:
    bool f_file_table;
    file_table_t* m_file_table;
    bool n_file_table;

public:
    bool _is_null_file_table() { file_table(); return n_file_table; };

private:

public:

    /**
     * File table containing BIF file entries.
     */
    file_table_t* file_table();

private:
    bool f_key_table;
    key_table_t* m_key_table;
    bool n_key_table;

public:
    bool _is_null_key_table() { key_table(); return n_key_table; };

private:

public:

    /**
     * KEY table containing resource entries.
     */
    key_table_t* key_table();

private:
    std::string m_file_type;
    std::string m_file_version;
    uint32_t m_bif_count;
    uint32_t m_key_count;
    uint32_t m_file_table_offset;
    uint32_t m_key_table_offset;
    uint32_t m_build_year;
    uint32_t m_build_day;
    std::string m_reserved;
    key_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * File type signature. Must be "KEY " (space-padded).
     */
    std::string file_type() const { return m_file_type; }

    /**
     * File format version. Typically "V1  " or "V1.1".
     */
    std::string file_version() const { return m_file_version; }

    /**
     * Number of BIF files referenced by this KEY file.
     */
    uint32_t bif_count() const { return m_bif_count; }

    /**
     * Number of resource entries in the KEY table.
     */
    uint32_t key_count() const { return m_key_count; }

    /**
     * Byte offset to the file table from the beginning of the file.
     */
    uint32_t file_table_offset() const { return m_file_table_offset; }

    /**
     * Byte offset to the KEY table from the beginning of the file.
     */
    uint32_t key_table_offset() const { return m_key_table_offset; }

    /**
     * Build year (years since 1900).
     */
    uint32_t build_year() const { return m_build_year; }

    /**
     * Build day (days since January 1).
     */
    uint32_t build_day() const { return m_build_day; }

    /**
     * Reserved padding (usually zeros).
     */
    std::string reserved() const { return m_reserved; }
    key_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // KEY_H_
