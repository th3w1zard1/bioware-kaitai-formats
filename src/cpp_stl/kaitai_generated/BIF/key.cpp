// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "key.h"
#include "kaitai/exceptions.h"

key_t::key_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, key_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_file_table = 0;
    m_key_table = 0;
    f_file_table = false;
    f_key_table = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void key_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_type == std::string("KEY "))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("KEY "), m_file_type, m__io, std::string("/seq/0"));
    }
    m_file_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!( ((m_file_version == std::string("V1  ")) || (m_file_version == std::string("V1.1"))) )) {
        throw kaitai::validation_not_any_of_error<std::string>(m_file_version, m__io, std::string("/seq/1"));
    }
    m_bif_count = m__io->read_u4le();
    m_key_count = m__io->read_u4le();
    m_file_table_offset = m__io->read_u4le();
    m_key_table_offset = m__io->read_u4le();
    m_build_year = m__io->read_u4le();
    m_build_day = m__io->read_u4le();
    m_reserved = m__io->read_bytes(32);
}

key_t::~key_t() {
    _clean_up();
}

void key_t::_clean_up() {
    if (f_file_table && !n_file_table) {
        if (m_file_table) {
            delete m_file_table; m_file_table = 0;
        }
    }
    if (f_key_table && !n_key_table) {
        if (m_key_table) {
            delete m_key_table; m_key_table = 0;
        }
    }
}

key_t::file_entry_t::file_entry_t(kaitai::kstream* p__io, key_t::file_table_t* p__parent, key_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_filename = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void key_t::file_entry_t::_read() {
    m_file_size = m__io->read_u4le();
    m_filename_offset = m__io->read_u4le();
    m_filename_size = m__io->read_u2le();
    m_drives = m__io->read_u2le();
}

key_t::file_entry_t::~file_entry_t() {
    _clean_up();
}

void key_t::file_entry_t::_clean_up() {
    if (f_filename) {
    }
}

std::string key_t::file_entry_t::filename() {
    if (f_filename)
        return m_filename;
    f_filename = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(filename_offset());
    m_filename = kaitai::kstream::bytes_to_str(m__io->read_bytes(filename_size()), "ASCII");
    m__io->seek(_pos);
    return m_filename;
}

key_t::file_table_t::file_table_t(kaitai::kstream* p__io, key_t* p__parent, key_t* p__root) : kaitai::kstruct(p__io) {
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

void key_t::file_table_t::_read() {
    m_entries = new std::vector<file_entry_t*>();
    const int l_entries = _root()->bif_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new file_entry_t(m__io, this, m__root));
    }
}

key_t::file_table_t::~file_table_t() {
    _clean_up();
}

void key_t::file_table_t::_clean_up() {
    if (m_entries) {
        for (std::vector<file_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

key_t::filename_table_t::filename_table_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, key_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void key_t::filename_table_t::_read() {
    m_filenames = kaitai::kstream::bytes_to_str(m__io->read_bytes_full(), "ASCII");
}

key_t::filename_table_t::~filename_table_t() {
    _clean_up();
}

void key_t::filename_table_t::_clean_up() {
}

key_t::key_entry_t::key_entry_t(kaitai::kstream* p__io, key_t::key_table_t* p__parent, key_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void key_t::key_entry_t::_read() {
    m_resref = kaitai::kstream::bytes_to_str(m__io->read_bytes(16), "ASCII");
    m_resource_type = static_cast<bioware_type_ids_t::xoreos_file_type_id_t>(m__io->read_u2le());
    m_resource_id = m__io->read_u4le();
}

key_t::key_entry_t::~key_entry_t() {
    _clean_up();
}

void key_t::key_entry_t::_clean_up() {
}

key_t::key_table_t::key_table_t(kaitai::kstream* p__io, key_t* p__parent, key_t* p__root) : kaitai::kstruct(p__io) {
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

void key_t::key_table_t::_read() {
    m_entries = new std::vector<key_entry_t*>();
    const int l_entries = _root()->key_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new key_entry_t(m__io, this, m__root));
    }
}

key_t::key_table_t::~key_table_t() {
    _clean_up();
}

void key_t::key_table_t::_clean_up() {
    if (m_entries) {
        for (std::vector<key_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

key_t::file_table_t* key_t::file_table() {
    if (f_file_table)
        return m_file_table;
    f_file_table = true;
    n_file_table = true;
    if (bif_count() > 0) {
        n_file_table = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(file_table_offset());
        m_file_table = new file_table_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_file_table;
}

key_t::key_table_t* key_t::key_table() {
    if (f_key_table)
        return m_key_table;
    f_key_table = true;
    n_key_table = true;
    if (key_count() > 0) {
        n_key_table = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(key_table_offset());
        m_key_table = new key_table_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_key_table;
}
