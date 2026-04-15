// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "lip.h"

lip_t::lip_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, lip_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_keyframes = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void lip_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_file_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_length = m__io->read_f4le();
    m_num_keyframes = m__io->read_u4le();
    m_keyframes = new std::vector<keyframe_entry_t*>();
    const int l_keyframes = num_keyframes();
    for (int i = 0; i < l_keyframes; i++) {
        m_keyframes->push_back(new keyframe_entry_t(m__io, this, m__root));
    }
}

lip_t::~lip_t() {
    _clean_up();
}

void lip_t::_clean_up() {
    if (m_keyframes) {
        for (std::vector<keyframe_entry_t*>::iterator it = m_keyframes->begin(); it != m_keyframes->end(); ++it) {
            delete *it;
        }
        delete m_keyframes; m_keyframes = 0;
    }
}

lip_t::keyframe_entry_t::keyframe_entry_t(kaitai::kstream* p__io, lip_t* p__parent, lip_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void lip_t::keyframe_entry_t::_read() {
    m_timestamp = m__io->read_f4le();
    m_shape = static_cast<bioware_common_t::bioware_lip_viseme_id_t>(m__io->read_u1());
}

lip_t::keyframe_entry_t::~keyframe_entry_t() {
    _clean_up();
}

void lip_t::keyframe_entry_t::_clean_up() {
}
