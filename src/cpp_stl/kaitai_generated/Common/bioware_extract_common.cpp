// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bioware_extract_common.h"
#include "kaitai/exceptions.h"
std::set<bioware_extract_common_t::bioware_search_location_id_t> bioware_extract_common_t::_build_values_bioware_search_location_id_t() {
    std::set<bioware_extract_common_t::bioware_search_location_id_t> _t;
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_OVERRIDE);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_MODULES);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_CHITIN);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_TEXTURES_TPA);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_TEXTURES_TPB);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_TEXTURES_TPC);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_TEXTURES_GUI);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_MUSIC);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_SOUND);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_VOICE);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_LIPS);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_RIMS);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_CUSTOM_MODULES);
    _t.insert(bioware_extract_common_t::BIOWARE_SEARCH_LOCATION_ID_CUSTOM_FOLDERS);
    return _t;
}
const std::set<bioware_extract_common_t::bioware_search_location_id_t> bioware_extract_common_t::_values_bioware_search_location_id_t = bioware_extract_common_t::_build_values_bioware_search_location_id_t();
bool bioware_extract_common_t::_is_defined_bioware_search_location_id_t(bioware_extract_common_t::bioware_search_location_id_t v) {
    return bioware_extract_common_t::_values_bioware_search_location_id_t.find(v) != bioware_extract_common_t::_values_bioware_search_location_id_t.end();
}

bioware_extract_common_t::bioware_extract_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_extract_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_extract_common_t::_read() {
}

bioware_extract_common_t::~bioware_extract_common_t() {
    _clean_up();
}

void bioware_extract_common_t::_clean_up() {
}

bioware_extract_common_t::bioware_texture_pack_name_str_t::bioware_texture_pack_name_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_extract_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_extract_common_t::bioware_texture_pack_name_str_t::_read() {
    m_value = kaitai::kstream::bytes_to_str(m__io->read_bytes_term(0, false, true, true), "ASCII");
    if (!( ((m_value == std::string("swpc_tex_tpa.erf")) || (m_value == std::string("swpc_tex_tpb.erf")) || (m_value == std::string("swpc_tex_tpc.erf")) || (m_value == std::string("swpc_tex_gui.erf"))) )) {
        throw kaitai::validation_not_any_of_error<std::string>(m_value, m__io, std::string("/types/bioware_texture_pack_name_str/seq/0"));
    }
}

bioware_extract_common_t::bioware_texture_pack_name_str_t::~bioware_texture_pack_name_str_t() {
    _clean_up();
}

void bioware_extract_common_t::bioware_texture_pack_name_str_t::_clean_up() {
}
