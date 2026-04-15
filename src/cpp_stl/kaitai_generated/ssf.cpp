// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "ssf.h"
#include "kaitai/exceptions.h"

ssf_t::ssf_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, ssf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_sounds = 0;
    f_sounds = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void ssf_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_type == std::string("SSF "))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("SSF "), m_file_type, m__io, std::string("/seq/0"));
    }
    m_file_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_version == std::string("V1.1"))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("V1.1"), m_file_version, m__io, std::string("/seq/1"));
    }
    m_sounds_offset = m__io->read_u4le();
}

ssf_t::~ssf_t() {
    _clean_up();
}

void ssf_t::_clean_up() {
    if (f_sounds) {
        if (m_sounds) {
            delete m_sounds; m_sounds = 0;
        }
    }
}

ssf_t::sound_array_t::sound_array_t(kaitai::kstream* p__io, ssf_t* p__parent, ssf_t* p__root) : kaitai::kstruct(p__io) {
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

void ssf_t::sound_array_t::_read() {
    m_entries = new std::vector<sound_entry_t*>();
    const int l_entries = 28;
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new sound_entry_t(m__io, this, m__root));
    }
}

ssf_t::sound_array_t::~sound_array_t() {
    _clean_up();
}

void ssf_t::sound_array_t::_clean_up() {
    if (m_entries) {
        for (std::vector<sound_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

ssf_t::sound_entry_t::sound_entry_t(kaitai::kstream* p__io, ssf_t::sound_array_t* p__parent, ssf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_is_no_sound = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void ssf_t::sound_entry_t::_read() {
    m_strref_raw = m__io->read_u4le();
}

ssf_t::sound_entry_t::~sound_entry_t() {
    _clean_up();
}

void ssf_t::sound_entry_t::_clean_up() {
}

bool ssf_t::sound_entry_t::is_no_sound() {
    if (f_is_no_sound)
        return m_is_no_sound;
    f_is_no_sound = true;
    m_is_no_sound = strref_raw() == 4294967295UL;
    return m_is_no_sound;
}

ssf_t::sound_array_t* ssf_t::sounds() {
    if (f_sounds)
        return m_sounds;
    f_sounds = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(sounds_offset());
    m_sounds = new sound_array_t(m__io, this, m__root);
    m__io->seek(_pos);
    return m_sounds;
}
