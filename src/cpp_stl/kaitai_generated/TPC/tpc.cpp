// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "tpc.h"

tpc_t::tpc_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, tpc_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_header = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void tpc_t::_read() {
    m_header = new tpc_header_t(m__io, this, m__root);
    m_body = m__io->read_bytes_full();
}

tpc_t::~tpc_t() {
    _clean_up();
}

void tpc_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
}

tpc_t::tpc_header_t::tpc_header_t(kaitai::kstream* p__io, tpc_t* p__parent, tpc_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_reserved = 0;
    f_is_compressed = false;
    f_is_uncompressed = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void tpc_t::tpc_header_t::_read() {
    m_data_size = m__io->read_u4le();
    m_alpha_test = m__io->read_f4le();
    m_width = m__io->read_u2le();
    m_height = m__io->read_u2le();
    m_pixel_encoding = static_cast<bioware_common_t::bioware_tpc_pixel_format_id_t>(m__io->read_u1());
    m_mipmap_count = m__io->read_u1();
    m_reserved = new std::vector<uint8_t>();
    const int l_reserved = 114;
    for (int i = 0; i < l_reserved; i++) {
        m_reserved->push_back(m__io->read_u1());
    }
}

tpc_t::tpc_header_t::~tpc_header_t() {
    _clean_up();
}

void tpc_t::tpc_header_t::_clean_up() {
    if (m_reserved) {
        delete m_reserved; m_reserved = 0;
    }
}

bool tpc_t::tpc_header_t::is_compressed() {
    if (f_is_compressed)
        return m_is_compressed;
    f_is_compressed = true;
    m_is_compressed = data_size() != 0;
    return m_is_compressed;
}

bool tpc_t::tpc_header_t::is_uncompressed() {
    if (f_is_uncompressed)
        return m_is_uncompressed;
    f_is_uncompressed = true;
    m_is_uncompressed = data_size() == 0;
    return m_is_uncompressed;
}
