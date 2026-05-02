#ifndef RIM_H_
#define RIM_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class rim_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_type_ids.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * RIM (Resource Information Manager) files are self-contained archives used for module templates.
 * RIM files are similar to ERF files but are read-only from the game's perspective. The game
 * loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
 * RIM files store all resources inline with metadata, making them self-contained archives.
 * 
 * Format Variants:
 * - Standard RIM: Basic module template files
 * - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
 * 
 * Binary Format (KotOR / PyKotor):
 * - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
 * - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
 * - Key / resource entry table (32 bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
 * - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
 * 
 * Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim PyKotor wiki — RIM
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128 PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L35-L91 xoreos — `RIMFile::load` + `readResList`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/unrim.cpp#L55-L85 xoreos-tools — `unrim` CLI (`main`)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/rim.cpp#L43-L84 xoreos-tools — `rim` packer CLI (`main`)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html xoreos-docs — Torlack mod.html (MOD/RIM family)
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/RIMObject.ts#L69-L93 KotOR.js — `RIMObject`
 * \sa https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs NickHugi/Kotor.NET — `RIMBinaryStructure`
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/rimreader.cpp#L26-L58 reone — `RimReader`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394 xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py PyKotor — `ResourceType` (tooling superset)
 */

class rim_t : public kaitai::kstruct {

public:
    class resource_entry_t;
    class resource_entry_table_t;
    class rim_header_t;

    rim_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, rim_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~rim_t();

    class resource_entry_t : public kaitai::kstruct {

    public:

        resource_entry_t(kaitai::kstream* p__io, rim_t::resource_entry_table_t* p__parent = 0, rim_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~resource_entry_t();

    private:
        bool f_data;
        std::vector<uint8_t>* m_data;

    public:

        /**
         * Raw binary data for this resource (read at specified offset)
         */
        std::vector<uint8_t>* data();

    private:
        std::string m_resref;
        bioware_type_ids_t::xoreos_file_type_id_t m_resource_type;
        uint32_t m_resource_id;
        uint32_t m_offset_to_data;
        uint32_t m_num_data;
        rim_t* m__root;
        rim_t::resource_entry_table_t* m__parent;

    public:

        /**
         * Resource filename (ResRef), null-padded to 16 bytes.
         * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
         * Resource names can be mixed case, though most are lowercase in practice.
         * The game engine typically lowercases ResRefs when loading.
         */
        std::string resref() const { return m_resref; }

        /**
         * Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
         * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
         */
        bioware_type_ids_t::xoreos_file_type_id_t resource_type() const { return m_resource_type; }

        /**
         * Resource ID (index, usually sequential).
         * Typically matches the index of this entry in the resource_entry_table.
         * Used for internal reference, but not critical for parsing.
         */
        uint32_t resource_id() const { return m_resource_id; }

        /**
         * Byte offset to resource data from the beginning of the file.
         * Points to the actual binary data for this resource in resource_data_section.
         */
        uint32_t offset_to_data() const { return m_offset_to_data; }

        /**
         * Size of resource data in bytes (repeat count for raw `data` bytes).
         * Uncompressed size of the resource.
         */
        uint32_t num_data() const { return m_num_data; }
        rim_t* _root() const { return m__root; }
        rim_t::resource_entry_table_t* _parent() const { return m__parent; }
    };

    class resource_entry_table_t : public kaitai::kstruct {

    public:

        resource_entry_table_t(kaitai::kstream* p__io, rim_t* p__parent = 0, rim_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~resource_entry_table_t();

    private:
        std::vector<resource_entry_t*>* m_entries;
        rim_t* m__root;
        rim_t* m__parent;

    public:

        /**
         * Array of resource entries, one per resource in the archive
         */
        std::vector<resource_entry_t*>* entries() const { return m_entries; }
        rim_t* _root() const { return m__root; }
        rim_t* _parent() const { return m__parent; }
    };

    class rim_header_t : public kaitai::kstruct {

    public:

        rim_header_t(kaitai::kstream* p__io, rim_t* p__parent = 0, rim_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~rim_header_t();

    private:
        bool f_has_resources;
        bool m_has_resources;

    public:

        /**
         * Whether the RIM file contains any resources
         */
        bool has_resources();

    private:
        std::string m_file_type;
        std::string m_file_version;
        uint32_t m_reserved;
        uint32_t m_resource_count;
        uint32_t m_offset_to_resource_table;
        uint32_t m_offset_to_resources;
        rim_t* m__root;
        rim_t* m__parent;

    public:

        /**
         * File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
         * This identifies the file as a RIM archive.
         */
        std::string file_type() const { return m_file_type; }

        /**
         * File format version. Always "V1.0" for KotOR RIM files.
         * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
         */
        std::string file_version() const { return m_file_version; }

        /**
         * Reserved field (typically 0x00000000).
         * Unknown purpose, but always set to 0 in practice.
         */
        uint32_t reserved() const { return m_reserved; }

        /**
         * Number of resources in the archive. This determines:
         * - Number of entries in resource_entry_table
         * - Number of resources in resource_data_section
         */
        uint32_t resource_count() const { return m_resource_count; }

        /**
         * Byte offset to the key / resource entry table from the beginning of the file.
         * 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
         * When non-zero, this offset is used directly (commonly 120).
         */
        uint32_t offset_to_resource_table() const { return m_offset_to_resource_table; }

        /**
         * Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
         * taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
         */
        uint32_t offset_to_resources() const { return m_offset_to_resources; }
        rim_t* _root() const { return m__root; }
        rim_t* _parent() const { return m__parent; }
    };

private:
    rim_header_t* m_header;
    std::string m_gap_before_key_table_implicit;
    bool n_gap_before_key_table_implicit;

public:
    bool _is_null_gap_before_key_table_implicit() { gap_before_key_table_implicit(); return n_gap_before_key_table_implicit; };

private:
    std::string m_gap_before_key_table_explicit;
    bool n_gap_before_key_table_explicit;

public:
    bool _is_null_gap_before_key_table_explicit() { gap_before_key_table_explicit(); return n_gap_before_key_table_explicit; };

private:
    resource_entry_table_t* m_resource_entry_table;
    bool n_resource_entry_table;

public:
    bool _is_null_resource_entry_table() { resource_entry_table(); return n_resource_entry_table; };

private:
    rim_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
     */
    rim_header_t* header() const { return m_header; }

    /**
     * When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
     * After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
     */
    std::string gap_before_key_table_implicit() const { return m_gap_before_key_table_implicit; }

    /**
     * When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
     * Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
     */
    std::string gap_before_key_table_explicit() const { return m_gap_before_key_table_explicit; }

    /**
     * Array of resource entries mapping ResRefs to resource data
     */
    resource_entry_table_t* resource_entry_table() const { return m_resource_entry_table; }
    rim_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // RIM_H_
