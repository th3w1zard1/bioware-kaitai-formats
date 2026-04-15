// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "das.h"
#include "kaitai/exceptions.h"

das_t::das_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, das_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_save_name = 0;
    m_module_name = 0;
    m_area_name = 0;
    m_screenshot_data = 0;
    m_portrait_data = 0;
    m_player_name = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void das_t::_read() {
    m_signature = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_signature == std::string("DAS "))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("DAS "), m_signature, m__io, std::string("/seq/0"));
    }
    m_version = m__io->read_s4le();
    if (!(m_version == 1)) {
        throw kaitai::validation_not_equal_error<int32_t>(1, m_version, m__io, std::string("/seq/1"));
    }
    m_save_name = new length_prefixed_string_t(m__io, this, m__root);
    m_module_name = new length_prefixed_string_t(m__io, this, m__root);
    m_area_name = new length_prefixed_string_t(m__io, this, m__root);
    m_time_played_seconds = m__io->read_s4le();
    m_timestamp_filetime = m__io->read_s8le();
    m_num_screenshot_data = m__io->read_s4le();
    n_screenshot_data = true;
    if (num_screenshot_data() > 0) {
        n_screenshot_data = false;
        m_screenshot_data = new std::vector<uint8_t>();
        const int l_screenshot_data = num_screenshot_data();
        for (int i = 0; i < l_screenshot_data; i++) {
            m_screenshot_data->push_back(m__io->read_u1());
        }
    }
    m_num_portrait_data = m__io->read_s4le();
    n_portrait_data = true;
    if (num_portrait_data() > 0) {
        n_portrait_data = false;
        m_portrait_data = new std::vector<uint8_t>();
        const int l_portrait_data = num_portrait_data();
        for (int i = 0; i < l_portrait_data; i++) {
            m_portrait_data->push_back(m__io->read_u1());
        }
    }
    m_player_name = new length_prefixed_string_t(m__io, this, m__root);
    m_party_member_count = m__io->read_s4le();
    m_player_level = m__io->read_s4le();
}

das_t::~das_t() {
    _clean_up();
}

void das_t::_clean_up() {
    if (m_save_name) {
        delete m_save_name; m_save_name = 0;
    }
    if (m_module_name) {
        delete m_module_name; m_module_name = 0;
    }
    if (m_area_name) {
        delete m_area_name; m_area_name = 0;
    }
    if (!n_screenshot_data) {
        if (m_screenshot_data) {
            delete m_screenshot_data; m_screenshot_data = 0;
        }
    }
    if (!n_portrait_data) {
        if (m_portrait_data) {
            delete m_portrait_data; m_portrait_data = 0;
        }
    }
    if (m_player_name) {
        delete m_player_name; m_player_name = 0;
    }
}

das_t::length_prefixed_string_t::length_prefixed_string_t(kaitai::kstream* p__io, das_t* p__parent, das_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_value_trimmed = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void das_t::length_prefixed_string_t::_read() {
    m_length = m__io->read_s4le();
    m_value = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(length()), 0, false), "UTF-8");
}

das_t::length_prefixed_string_t::~length_prefixed_string_t() {
    _clean_up();
}

void das_t::length_prefixed_string_t::_clean_up() {
}

std::string das_t::length_prefixed_string_t::value_trimmed() {
    if (f_value_trimmed)
        return m_value_trimmed;
    f_value_trimmed = true;
    m_value_trimmed = value();
    return m_value_trimmed;
}
