// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "tlk.h"

tlk_t::tlk_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, tlk_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_header = 0;
    m_string_data_table = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void tlk_t::_read() {
    m_header = new tlk_header_t(m__io, this, m__root);
    m_string_data_table = new string_data_table_t(m__io, this, m__root);
}

tlk_t::~tlk_t() {
    _clean_up();
}

void tlk_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
    if (m_string_data_table) {
        delete m_string_data_table; m_string_data_table = 0;
    }
}

tlk_t::string_data_entry_t::string_data_entry_t(kaitai::kstream* p__io, tlk_t::string_data_table_t* p__parent, tlk_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_entry_size = false;
    f_sound_length_present = false;
    f_sound_present = false;
    f_text_data = false;
    f_text_file_offset = false;
    f_text_present = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void tlk_t::string_data_entry_t::_read() {
    m_flags = m__io->read_u4le();
    m_sound_resref = kaitai::kstream::bytes_to_str(m__io->read_bytes(16), "ASCII");
    m_volume_variance = m__io->read_u4le();
    m_pitch_variance = m__io->read_u4le();
    m_text_offset = m__io->read_u4le();
    m_text_length = m__io->read_u4le();
    m_sound_length = m__io->read_f4le();
}

tlk_t::string_data_entry_t::~string_data_entry_t() {
    _clean_up();
}

void tlk_t::string_data_entry_t::_clean_up() {
    if (f_text_data) {
    }
}

int8_t tlk_t::string_data_entry_t::entry_size() {
    if (f_entry_size)
        return m_entry_size;
    f_entry_size = true;
    m_entry_size = 40;
    return m_entry_size;
}

bool tlk_t::string_data_entry_t::sound_length_present() {
    if (f_sound_length_present)
        return m_sound_length_present;
    f_sound_length_present = true;
    m_sound_length_present = (flags() & 4) != 0;
    return m_sound_length_present;
}

bool tlk_t::string_data_entry_t::sound_present() {
    if (f_sound_present)
        return m_sound_present;
    f_sound_present = true;
    m_sound_present = (flags() & 2) != 0;
    return m_sound_present;
}

std::string tlk_t::string_data_entry_t::text_data() {
    if (f_text_data)
        return m_text_data;
    f_text_data = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(text_file_offset());
    m_text_data = kaitai::kstream::bytes_to_str(m__io->read_bytes(text_length()), "ASCII");
    m__io->seek(_pos);
    return m_text_data;
}

int32_t tlk_t::string_data_entry_t::text_file_offset() {
    if (f_text_file_offset)
        return m_text_file_offset;
    f_text_file_offset = true;
    m_text_file_offset = _root()->header()->entries_offset() + text_offset();
    return m_text_file_offset;
}

bool tlk_t::string_data_entry_t::text_present() {
    if (f_text_present)
        return m_text_present;
    f_text_present = true;
    m_text_present = (flags() & 1) != 0;
    return m_text_present;
}

tlk_t::string_data_table_t::string_data_table_t(kaitai::kstream* p__io, tlk_t* p__parent, tlk_t* p__root) : kaitai::kstruct(p__io) {
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

void tlk_t::string_data_table_t::_read() {
    m_entries = new std::vector<string_data_entry_t*>();
    const int l_entries = _root()->header()->string_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new string_data_entry_t(m__io, this, m__root));
    }
}

tlk_t::string_data_table_t::~string_data_table_t() {
    _clean_up();
}

void tlk_t::string_data_table_t::_clean_up() {
    if (m_entries) {
        for (std::vector<string_data_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

tlk_t::tlk_header_t::tlk_header_t(kaitai::kstream* p__io, tlk_t* p__parent, tlk_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_expected_entries_offset = false;
    f_header_size = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void tlk_t::tlk_header_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_file_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_language_id = m__io->read_u4le();
    m_string_count = m__io->read_u4le();
    m_entries_offset = m__io->read_u4le();
}

tlk_t::tlk_header_t::~tlk_header_t() {
    _clean_up();
}

void tlk_t::tlk_header_t::_clean_up() {
}

int32_t tlk_t::tlk_header_t::expected_entries_offset() {
    if (f_expected_entries_offset)
        return m_expected_entries_offset;
    f_expected_entries_offset = true;
    m_expected_entries_offset = 20 + string_count() * 40;
    return m_expected_entries_offset;
}

int8_t tlk_t::tlk_header_t::header_size() {
    if (f_header_size)
        return m_header_size;
    f_header_size = true;
    m_header_size = 20;
    return m_header_size;
}
