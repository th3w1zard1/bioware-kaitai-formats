// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "pcc.h"
#include "kaitai/exceptions.h"

pcc_t::pcc_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, pcc_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_header = 0;
    m_export_table = 0;
    m_import_table = 0;
    m_name_table = 0;
    f_compression_type = false;
    f_export_table = false;
    f_import_table = false;
    f_is_compressed = false;
    f_name_table = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void pcc_t::_read() {
    m_header = new file_header_t(m__io, this, m__root);
}

pcc_t::~pcc_t() {
    _clean_up();
}

void pcc_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
    if (f_export_table && !n_export_table) {
        if (m_export_table) {
            delete m_export_table; m_export_table = 0;
        }
    }
    if (f_import_table && !n_import_table) {
        if (m_import_table) {
            delete m_import_table; m_import_table = 0;
        }
    }
    if (f_name_table && !n_name_table) {
        if (m_name_table) {
            delete m_name_table; m_name_table = 0;
        }
    }
}

pcc_t::export_entry_t::export_entry_t(kaitai::kstream* p__io, pcc_t::export_table_t* p__parent, pcc_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_guid = 0;
    m_components = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void pcc_t::export_entry_t::_read() {
    m_class_index = m__io->read_s4le();
    m_super_class_index = m__io->read_s4le();
    m_link = m__io->read_s4le();
    m_object_name_index = m__io->read_s4le();
    m_object_name_number = m__io->read_s4le();
    m_archetype_index = m__io->read_s4le();
    m_object_flags = m__io->read_u8le();
    m_data_size = m__io->read_u4le();
    m_data_offset = m__io->read_u4le();
    m_unknown1 = m__io->read_u4le();
    m_num_components = m__io->read_s4le();
    m_unknown2 = m__io->read_u4le();
    m_guid = new guid_t(m__io, this, m__root);
    n_components = true;
    if (num_components() > 0) {
        n_components = false;
        m_components = new std::vector<int32_t>();
        const int l_components = num_components();
        for (int i = 0; i < l_components; i++) {
            m_components->push_back(m__io->read_s4le());
        }
    }
}

pcc_t::export_entry_t::~export_entry_t() {
    _clean_up();
}

void pcc_t::export_entry_t::_clean_up() {
    if (m_guid) {
        delete m_guid; m_guid = 0;
    }
    if (!n_components) {
        if (m_components) {
            delete m_components; m_components = 0;
        }
    }
}

pcc_t::export_table_t::export_table_t(kaitai::kstream* p__io, pcc_t* p__parent, pcc_t* p__root) : kaitai::kstruct(p__io) {
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

void pcc_t::export_table_t::_read() {
    m_entries = new std::vector<export_entry_t*>();
    const int l_entries = _root()->header()->export_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new export_entry_t(m__io, this, m__root));
    }
}

pcc_t::export_table_t::~export_table_t() {
    _clean_up();
}

void pcc_t::export_table_t::_clean_up() {
    if (m_entries) {
        for (std::vector<export_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

pcc_t::file_header_t::file_header_t(kaitai::kstream* p__io, pcc_t* p__parent, pcc_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void pcc_t::file_header_t::_read() {
    m_magic = m__io->read_u4le();
    if (!(m_magic == 2653586369UL)) {
        throw kaitai::validation_not_equal_error<uint32_t>(2653586369UL, m_magic, m__io, std::string("/types/file_header/seq/0"));
    }
    m_version = m__io->read_u4le();
    m_licensee_version = m__io->read_u4le();
    m_header_size = m__io->read_s4le();
    m_package_name = kaitai::kstream::bytes_to_str(m__io->read_bytes(10), "UTF-16LE");
    m_package_flags = m__io->read_u4le();
    m_package_type = static_cast<bioware_common_t::bioware_pcc_package_kind_t>(m__io->read_u4le());
    m_name_count = m__io->read_u4le();
    m_name_table_offset = m__io->read_u4le();
    m_export_count = m__io->read_u4le();
    m_export_table_offset = m__io->read_u4le();
    m_import_count = m__io->read_u4le();
    m_import_table_offset = m__io->read_u4le();
    m_depend_offset = m__io->read_u4le();
    m_depend_count = m__io->read_u4le();
    m_guid_part1 = m__io->read_u4le();
    m_guid_part2 = m__io->read_u4le();
    m_guid_part3 = m__io->read_u4le();
    m_guid_part4 = m__io->read_u4le();
    m_generations = m__io->read_u4le();
    m_export_count_dup = m__io->read_u4le();
    m_name_count_dup = m__io->read_u4le();
    m_unknown1 = m__io->read_u4le();
    m_engine_version = m__io->read_u4le();
    m_cooker_version = m__io->read_u4le();
    m_compression_flags = m__io->read_u4le();
    m_package_source = m__io->read_u4le();
    m_compression_type = static_cast<bioware_common_t::bioware_pcc_compression_codec_t>(m__io->read_u4le());
    m_chunk_count = m__io->read_u4le();
}

pcc_t::file_header_t::~file_header_t() {
    _clean_up();
}

void pcc_t::file_header_t::_clean_up() {
}

pcc_t::guid_t::guid_t(kaitai::kstream* p__io, pcc_t::export_entry_t* p__parent, pcc_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void pcc_t::guid_t::_read() {
    m_part1 = m__io->read_u4le();
    m_part2 = m__io->read_u4le();
    m_part3 = m__io->read_u4le();
    m_part4 = m__io->read_u4le();
}

pcc_t::guid_t::~guid_t() {
    _clean_up();
}

void pcc_t::guid_t::_clean_up() {
}

pcc_t::import_entry_t::import_entry_t(kaitai::kstream* p__io, pcc_t::import_table_t* p__parent, pcc_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void pcc_t::import_entry_t::_read() {
    m_package_name_index = m__io->read_s8le();
    m_class_name_index = m__io->read_s4le();
    m_link = m__io->read_s8le();
    m_import_name_index = m__io->read_s8le();
}

pcc_t::import_entry_t::~import_entry_t() {
    _clean_up();
}

void pcc_t::import_entry_t::_clean_up() {
}

pcc_t::import_table_t::import_table_t(kaitai::kstream* p__io, pcc_t* p__parent, pcc_t* p__root) : kaitai::kstruct(p__io) {
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

void pcc_t::import_table_t::_read() {
    m_entries = new std::vector<import_entry_t*>();
    const int l_entries = _root()->header()->import_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new import_entry_t(m__io, this, m__root));
    }
}

pcc_t::import_table_t::~import_table_t() {
    _clean_up();
}

void pcc_t::import_table_t::_clean_up() {
    if (m_entries) {
        for (std::vector<import_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

pcc_t::name_entry_t::name_entry_t(kaitai::kstream* p__io, pcc_t::name_table_t* p__parent, pcc_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_abs_length = false;
    f_name_size = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void pcc_t::name_entry_t::_read() {
    m_length = m__io->read_s4le();
    m_name = kaitai::kstream::bytes_to_str(m__io->read_bytes(((length() < 0) ? (-(length())) : (length())) * 2), "UTF-16LE");
}

pcc_t::name_entry_t::~name_entry_t() {
    _clean_up();
}

void pcc_t::name_entry_t::_clean_up() {
}

int32_t pcc_t::name_entry_t::abs_length() {
    if (f_abs_length)
        return m_abs_length;
    f_abs_length = true;
    m_abs_length = ((length() < 0) ? (-(length())) : (length()));
    return m_abs_length;
}

int32_t pcc_t::name_entry_t::name_size() {
    if (f_name_size)
        return m_name_size;
    f_name_size = true;
    m_name_size = abs_length() * 2;
    return m_name_size;
}

pcc_t::name_table_t::name_table_t(kaitai::kstream* p__io, pcc_t* p__parent, pcc_t* p__root) : kaitai::kstruct(p__io) {
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

void pcc_t::name_table_t::_read() {
    m_entries = new std::vector<name_entry_t*>();
    const int l_entries = _root()->header()->name_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new name_entry_t(m__io, this, m__root));
    }
}

pcc_t::name_table_t::~name_table_t() {
    _clean_up();
}

void pcc_t::name_table_t::_clean_up() {
    if (m_entries) {
        for (std::vector<name_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

bioware_common_t::bioware_pcc_compression_codec_t pcc_t::compression_type() {
    if (f_compression_type)
        return m_compression_type;
    f_compression_type = true;
    m_compression_type = header()->compression_type();
    return m_compression_type;
}

pcc_t::export_table_t* pcc_t::export_table() {
    if (f_export_table)
        return m_export_table;
    f_export_table = true;
    n_export_table = true;
    if (header()->export_count() > 0) {
        n_export_table = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->export_table_offset());
        m_export_table = new export_table_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_export_table;
}

pcc_t::import_table_t* pcc_t::import_table() {
    if (f_import_table)
        return m_import_table;
    f_import_table = true;
    n_import_table = true;
    if (header()->import_count() > 0) {
        n_import_table = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->import_table_offset());
        m_import_table = new import_table_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_import_table;
}

bool pcc_t::is_compressed() {
    if (f_is_compressed)
        return m_is_compressed;
    f_is_compressed = true;
    m_is_compressed = (header()->package_flags() & 33554432) != 0;
    return m_is_compressed;
}

pcc_t::name_table_t* pcc_t::name_table() {
    if (f_name_table)
        return m_name_table;
    f_name_table = true;
    n_name_table = true;
    if (header()->name_count() > 0) {
        n_name_table = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->name_table_offset());
        m_name_table = new name_table_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_name_table;
}
