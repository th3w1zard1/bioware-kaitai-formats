// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "rim.h"
#include "kaitai/exceptions.h"

rim_t::rim_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, rim_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_header = 0;
    m_resource_entry_table = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void rim_t::_read() {
    m_header = new rim_header_t(m__io, this, m__root);
    n_gap_before_key_table_implicit = true;
    if (header()->offset_to_resource_table() == 0) {
        n_gap_before_key_table_implicit = false;
        m_gap_before_key_table_implicit = m__io->read_bytes(96);
    }
    n_gap_before_key_table_explicit = true;
    if (header()->offset_to_resource_table() != 0) {
        n_gap_before_key_table_explicit = false;
        m_gap_before_key_table_explicit = m__io->read_bytes(header()->offset_to_resource_table() - 24);
    }
    n_resource_entry_table = true;
    if (header()->resource_count() > 0) {
        n_resource_entry_table = false;
        m_resource_entry_table = new resource_entry_table_t(m__io, this, m__root);
    }
}

rim_t::~rim_t() {
    _clean_up();
}

void rim_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
    if (!n_gap_before_key_table_implicit) {
    }
    if (!n_gap_before_key_table_explicit) {
    }
    if (!n_resource_entry_table) {
        if (m_resource_entry_table) {
            delete m_resource_entry_table; m_resource_entry_table = 0;
        }
    }
}

rim_t::resource_entry_t::resource_entry_t(kaitai::kstream* p__io, rim_t::resource_entry_table_t* p__parent, rim_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_data = 0;
    f_data = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void rim_t::resource_entry_t::_read() {
    m_resref = kaitai::kstream::bytes_to_str(m__io->read_bytes(16), "ASCII");
    m_resource_type = static_cast<bioware_type_ids_t::xoreos_file_type_id_t>(m__io->read_u4le());
    m_resource_id = m__io->read_u4le();
    m_offset_to_data = m__io->read_u4le();
    m_num_data = m__io->read_u4le();
}

rim_t::resource_entry_t::~resource_entry_t() {
    _clean_up();
}

void rim_t::resource_entry_t::_clean_up() {
    if (f_data) {
        if (m_data) {
            delete m_data; m_data = 0;
        }
    }
}

std::vector<uint8_t>* rim_t::resource_entry_t::data() {
    if (f_data)
        return m_data;
    f_data = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(offset_to_data());
    m_data = new std::vector<uint8_t>();
    const int l_data = num_data();
    for (int i = 0; i < l_data; i++) {
        m_data->push_back(m__io->read_u1());
    }
    m__io->seek(_pos);
    return m_data;
}

rim_t::resource_entry_table_t::resource_entry_table_t(kaitai::kstream* p__io, rim_t* p__parent, rim_t* p__root) : kaitai::kstruct(p__io) {
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

void rim_t::resource_entry_table_t::_read() {
    m_entries = new std::vector<resource_entry_t*>();
    const int l_entries = _root()->header()->resource_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new resource_entry_t(m__io, this, m__root));
    }
}

rim_t::resource_entry_table_t::~resource_entry_table_t() {
    _clean_up();
}

void rim_t::resource_entry_table_t::_clean_up() {
    if (m_entries) {
        for (std::vector<resource_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

rim_t::rim_header_t::rim_header_t(kaitai::kstream* p__io, rim_t* p__parent, rim_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_has_resources = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void rim_t::rim_header_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_type == std::string("RIM "))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("RIM "), m_file_type, m__io, std::string("/types/rim_header/seq/0"));
    }
    m_file_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_version == std::string("V1.0"))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("V1.0"), m_file_version, m__io, std::string("/types/rim_header/seq/1"));
    }
    m_reserved = m__io->read_u4le();
    m_resource_count = m__io->read_u4le();
    m_offset_to_resource_table = m__io->read_u4le();
    m_offset_to_resources = m__io->read_u4le();
}

rim_t::rim_header_t::~rim_header_t() {
    _clean_up();
}

void rim_t::rim_header_t::_clean_up() {
}

bool rim_t::rim_header_t::has_resources() {
    if (f_has_resources)
        return m_has_resources;
    f_has_resources = true;
    m_has_resources = resource_count() > 0;
    return m_has_resources;
}
