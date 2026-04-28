// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "txb2.h"

txb2_t::txb2_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, txb2_t* p__root) : kaitai::kstruct(p__io) {
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

void txb2_t::_read() {
    m_header = new tpc_t::tpc_header_t(m__io);
    m_body = m__io->read_bytes_full();
}

txb2_t::~txb2_t() {
    _clean_up();
}

void txb2_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
}
