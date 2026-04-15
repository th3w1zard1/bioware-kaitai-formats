// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "erf.h"
#include "kaitai/exceptions.h"

erf_t::erf_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, erf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_header = 0;
    m_key_list = 0;
    m_localized_string_list = 0;
    m_resource_list = 0;
    f_key_list = false;
    f_localized_string_list = false;
    f_resource_list = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void erf_t::_read() {
    m_header = new erf_header_t(m__io, this, m__root);
}

erf_t::~erf_t() {
    _clean_up();
}

void erf_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
    if (f_key_list) {
        if (m_key_list) {
            delete m_key_list; m_key_list = 0;
        }
    }
    if (f_localized_string_list && !n_localized_string_list) {
        if (m_localized_string_list) {
            delete m_localized_string_list; m_localized_string_list = 0;
        }
    }
    if (f_resource_list) {
        if (m_resource_list) {
            delete m_resource_list; m_resource_list = 0;
        }
    }
}

erf_t::erf_header_t::erf_header_t(kaitai::kstream* p__io, erf_t* p__parent, erf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_is_save_file = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void erf_t::erf_header_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!( ((m_file_type == std::string("ERF ")) || (m_file_type == std::string("MOD ")) || (m_file_type == std::string("SAV ")) || (m_file_type == std::string("HAK "))) )) {
        throw kaitai::validation_not_any_of_error<std::string>(m_file_type, m__io, std::string("/types/erf_header/seq/0"));
    }
    m_file_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_version == std::string("V1.0"))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("V1.0"), m_file_version, m__io, std::string("/types/erf_header/seq/1"));
    }
    m_language_count = m__io->read_u4le();
    m_localized_string_size = m__io->read_u4le();
    m_entry_count = m__io->read_u4le();
    m_offset_to_localized_string_list = m__io->read_u4le();
    m_offset_to_key_list = m__io->read_u4le();
    m_offset_to_resource_list = m__io->read_u4le();
    m_build_year = m__io->read_u4le();
    m_build_day = m__io->read_u4le();
    m_description_strref = m__io->read_s4le();
    m_reserved = m__io->read_bytes(116);
}

erf_t::erf_header_t::~erf_header_t() {
    _clean_up();
}

void erf_t::erf_header_t::_clean_up() {
}

bool erf_t::erf_header_t::is_save_file() {
    if (f_is_save_file)
        return m_is_save_file;
    f_is_save_file = true;
    m_is_save_file =  ((file_type() == std::string("MOD ")) && (description_strref() == 0)) ;
    return m_is_save_file;
}

erf_t::key_entry_t::key_entry_t(kaitai::kstream* p__io, erf_t::key_list_t* p__parent, erf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void erf_t::key_entry_t::_read() {
    m_resref = kaitai::kstream::bytes_to_str(m__io->read_bytes(16), "ASCII");
    m_resource_id = m__io->read_u4le();
    m_resource_type = static_cast<bioware_type_ids_t::xoreos_file_type_id_t>(m__io->read_u2le());
    m_unused = m__io->read_u2le();
}

erf_t::key_entry_t::~key_entry_t() {
    _clean_up();
}

void erf_t::key_entry_t::_clean_up() {
}

erf_t::key_list_t::key_list_t(kaitai::kstream* p__io, erf_t* p__parent, erf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_entries = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void erf_t::key_list_t::_read() {
    m_entries = new std::vector<key_entry_t*>();
    const int l_entries = _root()->header()->entry_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new key_entry_t(m__io, this, m__root));
    }
}

erf_t::key_list_t::~key_list_t() {
    _clean_up();
}

void erf_t::key_list_t::_clean_up() {
    if (m_entries) {
        for (std::vector<key_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

erf_t::localized_string_entry_t::localized_string_entry_t(kaitai::kstream* p__io, erf_t::localized_string_list_t* p__parent, erf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void erf_t::localized_string_entry_t::_read() {
    m_language_id = m__io->read_u4le();
    m_string_size = m__io->read_u4le();
    m_string_data = kaitai::kstream::bytes_to_str(m__io->read_bytes(string_size()), "UTF-8");
}

erf_t::localized_string_entry_t::~localized_string_entry_t() {
    _clean_up();
}

void erf_t::localized_string_entry_t::_clean_up() {
}

erf_t::localized_string_list_t::localized_string_list_t(kaitai::kstream* p__io, erf_t* p__parent, erf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_entries = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void erf_t::localized_string_list_t::_read() {
    m_entries = new std::vector<localized_string_entry_t*>();
    const int l_entries = _root()->header()->language_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new localized_string_entry_t(m__io, this, m__root));
    }
}

erf_t::localized_string_list_t::~localized_string_list_t() {
    _clean_up();
}

void erf_t::localized_string_list_t::_clean_up() {
    if (m_entries) {
        for (std::vector<localized_string_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

erf_t::resource_entry_t::resource_entry_t(kaitai::kstream* p__io, erf_t::resource_list_t* p__parent, erf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_data = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void erf_t::resource_entry_t::_read() {
    m_offset_to_data = m__io->read_u4le();
    m_len_data = m__io->read_u4le();
}

erf_t::resource_entry_t::~resource_entry_t() {
    _clean_up();
}

void erf_t::resource_entry_t::_clean_up() {
    if (f_data) {
    }
}

std::string erf_t::resource_entry_t::data() {
    if (f_data)
        return m_data;
    f_data = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(offset_to_data());
    m_data = m__io->read_bytes(len_data());
    m__io->seek(_pos);
    return m_data;
}

erf_t::resource_list_t::resource_list_t(kaitai::kstream* p__io, erf_t* p__parent, erf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_entries = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void erf_t::resource_list_t::_read() {
    m_entries = new std::vector<resource_entry_t*>();
    const int l_entries = _root()->header()->entry_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new resource_entry_t(m__io, this, m__root));
    }
}

erf_t::resource_list_t::~resource_list_t() {
    _clean_up();
}

void erf_t::resource_list_t::_clean_up() {
    if (m_entries) {
        for (std::vector<resource_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

erf_t::key_list_t* erf_t::key_list() {
    if (f_key_list)
        return m_key_list;
    f_key_list = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(header()->offset_to_key_list());
    m_key_list = new key_list_t(m__io, this, m__root);
    m__io->seek(_pos);
    return m_key_list;
}

erf_t::localized_string_list_t* erf_t::localized_string_list() {
    if (f_localized_string_list)
        return m_localized_string_list;
    f_localized_string_list = true;
    n_localized_string_list = true;
    if (header()->language_count() > 0) {
        n_localized_string_list = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->offset_to_localized_string_list());
        m_localized_string_list = new localized_string_list_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_localized_string_list;
}

erf_t::resource_list_t* erf_t::resource_list() {
    if (f_resource_list)
        return m_resource_list;
    f_resource_list = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(header()->offset_to_resource_list());
    m_resource_list = new resource_list_t(m__io, this, m__root);
    m__io->seek(_pos);
    return m_resource_list;
}
