#ifndef BIOWARE_EXTRACT_COMMON_H_
#define BIOWARE_EXTRACT_COMMON_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bioware_extract_common_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <set>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * Enums and small helper types used by installation/extraction tooling.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/installation.py
 */

class bioware_extract_common_t : public kaitai::kstruct {

public:
    class bioware_texture_pack_name_str_t;

    enum bioware_search_location_id_t {
        BIOWARE_SEARCH_LOCATION_ID_OVERRIDE = 0,
        BIOWARE_SEARCH_LOCATION_ID_MODULES = 1,
        BIOWARE_SEARCH_LOCATION_ID_CHITIN = 2,
        BIOWARE_SEARCH_LOCATION_ID_TEXTURES_TPA = 3,
        BIOWARE_SEARCH_LOCATION_ID_TEXTURES_TPB = 4,
        BIOWARE_SEARCH_LOCATION_ID_TEXTURES_TPC = 5,
        BIOWARE_SEARCH_LOCATION_ID_TEXTURES_GUI = 6,
        BIOWARE_SEARCH_LOCATION_ID_MUSIC = 7,
        BIOWARE_SEARCH_LOCATION_ID_SOUND = 8,
        BIOWARE_SEARCH_LOCATION_ID_VOICE = 9,
        BIOWARE_SEARCH_LOCATION_ID_LIPS = 10,
        BIOWARE_SEARCH_LOCATION_ID_RIMS = 11,
        BIOWARE_SEARCH_LOCATION_ID_CUSTOM_MODULES = 12,
        BIOWARE_SEARCH_LOCATION_ID_CUSTOM_FOLDERS = 13
    };
    static bool _is_defined_bioware_search_location_id_t(bioware_search_location_id_t v);

private:
    static const std::set<bioware_search_location_id_t> _values_bioware_search_location_id_t;
    static std::set<bioware_search_location_id_t> _build_values_bioware_search_location_id_t();

public:

    bioware_extract_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_extract_common_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bioware_extract_common_t();

    /**
     * String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
     */

    class bioware_texture_pack_name_str_t : public kaitai::kstruct {

    public:

        bioware_texture_pack_name_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_extract_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_texture_pack_name_str_t();

    private:
        std::string m_value;
        bioware_extract_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:
        std::string value() const { return m_value; }
        bioware_extract_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

private:
    bioware_extract_common_t* m__root;
    kaitai::kstruct* m__parent;

public:
    bioware_extract_common_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BIOWARE_EXTRACT_COMMON_H_
