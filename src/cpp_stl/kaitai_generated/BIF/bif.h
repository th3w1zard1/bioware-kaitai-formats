#ifndef BIF_H_
#define BIF_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bif_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_type_ids.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
 * the paired **KEY** (`KEY.ksy`), not in the BIF.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif PyKotor wiki — BIF
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L57-L215 PyKotor — `io_bif` (Kaitai + legacy + reader)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py#L59-L71 PyKotor — `BIFType`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L97 xoreos — `BIFFile::load` + `readVarResTable`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L208 xoreos — `kFileTypeBIF`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L209 xoreos-tools — `unkeybif` (non-`.bzf` → `BIFFile`)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/bifreader.cpp#L26-L63 reone — `BifReader`
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/BIFObject.ts KotOR.js — `BIFObject`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/bif.html xoreos-docs — Torlack bif.html
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf
 */

class bif_t : public kaitai::kstruct {

public:
    class var_resource_entry_t;
    class var_resource_table_t;

    bif_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bif_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bif_t();

    class var_resource_entry_t : public kaitai::kstruct {

    public:

        var_resource_entry_t(kaitai::kstream* p__io, bif_t::var_resource_table_t* p__parent = 0, bif_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~var_resource_entry_t();

    private:
        uint32_t m_resource_id;
        uint32_t m_offset;
        uint32_t m_file_size;
        bioware_type_ids_t::xoreos_file_type_id_t m_resource_type;
        bif_t* m__root;
        bif_t::var_resource_table_t* m__parent;

    public:

        /**
         * Resource ID (matches KEY file entry).
         * Encodes BIF index (bits 31-20) and resource index (bits 19-0).
         * Formula: resource_id = (bif_index << 20) | resource_index
         */
        uint32_t resource_id() const { return m_resource_id; }

        /**
         * Byte offset to resource data in file (absolute file offset).
         */
        uint32_t offset() const { return m_offset; }

        /**
         * Uncompressed size of resource data in bytes.
         */
        uint32_t file_size() const { return m_file_size; }

        /**
         * Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
         * read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
         * `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.
         */
        bioware_type_ids_t::xoreos_file_type_id_t resource_type() const { return m_resource_type; }
        bif_t* _root() const { return m__root; }
        bif_t::var_resource_table_t* _parent() const { return m__parent; }
    };

    class var_resource_table_t : public kaitai::kstruct {

    public:

        var_resource_table_t(kaitai::kstream* p__io, bif_t* p__parent = 0, bif_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~var_resource_table_t();

    private:
        std::vector<var_resource_entry_t*>* m_entries;
        bif_t* m__root;
        bif_t* m__parent;

    public:

        /**
         * Array of variable resource entries.
         */
        std::vector<var_resource_entry_t*>* entries() const { return m_entries; }
        bif_t* _root() const { return m__root; }
        bif_t* _parent() const { return m__parent; }
    };

private:
    bool f_var_resource_table;
    var_resource_table_t* m_var_resource_table;
    bool n_var_resource_table;

public:
    bool _is_null_var_resource_table() { var_resource_table(); return n_var_resource_table; };

private:

public:

    /**
     * Variable resource table containing entries for each resource.
     */
    var_resource_table_t* var_resource_table();

private:
    std::string m_file_type;
    std::string m_version;
    uint32_t m_var_res_count;
    uint32_t m_fixed_res_count;
    uint32_t m_var_table_offset;
    bif_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * File type signature. Must be "BIFF" for BIF files.
     */
    std::string file_type() const { return m_file_type; }

    /**
     * File format version. Typically "V1  " or "V1.1".
     */
    std::string version() const { return m_version; }

    /**
     * Number of variable-size resources in this file.
     */
    uint32_t var_res_count() const { return m_var_res_count; }

    /**
     * Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
     */
    uint32_t fixed_res_count() const { return m_fixed_res_count; }

    /**
     * Byte offset to the variable resource table from the beginning of the file.
     */
    uint32_t var_table_offset() const { return m_var_table_offset; }
    bif_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BIF_H_
