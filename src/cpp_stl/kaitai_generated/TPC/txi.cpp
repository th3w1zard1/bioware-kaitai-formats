// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "txi.h"

txi_t::txi_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, txi_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void txi_t::_read() {
    m_content = kaitai::kstream::bytes_to_str(m__io->read_bytes_full(), "ASCII");
}

txi_t::~txi_t() {
    _clean_up();
}

void txi_t::_clean_up() {
}
