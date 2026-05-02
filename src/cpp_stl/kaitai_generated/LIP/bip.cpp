// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bip.h"

bip_t::bip_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bip_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bip_t::_read() {
    m_payload = m__io->read_bytes_full();
}

bip_t::~bip_t() {
    _clean_up();
}

void bip_t::_clean_up() {
}
