// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bif.h"
#include "kaitai/exceptions.h"

bif_t::bif_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bif_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_var_resource_table = 0;
    f_var_resource_table = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bif_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_type == std::string("BIFF"))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("BIFF"), m_file_type, m__io, std::string("/seq/0"));
    }
    m_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!( ((m_version == std::string("V1  ")) || (m_version == std::string("V1.1"))) )) {
        throw kaitai::validation_not_any_of_error<std::string>(m_version, m__io, std::string("/seq/1"));
    }
    m_var_res_count = m__io->read_u4le();
    m_fixed_res_count = m__io->read_u4le();
    if (!(m_fixed_res_count == 0)) {
        throw kaitai::validation_not_equal_error<uint32_t>(0, m_fixed_res_count, m__io, std::string("/seq/3"));
    }
    m_var_table_offset = m__io->read_u4le();
}

bif_t::~bif_t() {
    _clean_up();
}

void bif_t::_clean_up() {
    if (f_var_resource_table && !n_var_resource_table) {
        if (m_var_resource_table) {
            delete m_var_resource_table; m_var_resource_table = 0;
        }
    }
}

bif_t::var_resource_entry_t::var_resource_entry_t(kaitai::kstream* p__io, bif_t::var_resource_table_t* p__parent, bif_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bif_t::var_resource_entry_t::_read() {
    m_resource_id = m__io->read_u4le();
    m_offset = m__io->read_u4le();
    m_file_size = m__io->read_u4le();
    m_resource_type = static_cast<bioware_type_ids_t::xoreos_file_type_id_t>(m__io->read_u4le());
}

bif_t::var_resource_entry_t::~var_resource_entry_t() {
    _clean_up();
}

void bif_t::var_resource_entry_t::_clean_up() {
}

bif_t::var_resource_table_t::var_resource_table_t(kaitai::kstream* p__io, bif_t* p__parent, bif_t* p__root) : kaitai::kstruct(p__io) {
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

void bif_t::var_resource_table_t::_read() {
    m_entries = new std::vector<var_resource_entry_t*>();
    const int l_entries = _root()->var_res_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new var_resource_entry_t(m__io, this, m__root));
    }
}

bif_t::var_resource_table_t::~var_resource_table_t() {
    _clean_up();
}

void bif_t::var_resource_table_t::_clean_up() {
    if (m_entries) {
        for (std::vector<var_resource_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

bif_t::var_resource_table_t* bif_t::var_resource_table() {
    if (f_var_resource_table)
        return m_var_resource_table;
    f_var_resource_table = true;
    n_var_resource_table = true;
    if (var_res_count() > 0) {
        n_var_resource_table = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(var_table_offset());
        m_var_resource_table = new var_resource_table_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_var_resource_table;
}
