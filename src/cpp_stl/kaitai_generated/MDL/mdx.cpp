// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "mdx.h"

mdx_t::mdx_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdx_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdx_t::_read() {
    m_vertex_data = m__io->read_bytes_full();
}

mdx_t::~mdx_t() {
    _clean_up();
}

void mdx_t::_clean_up() {
}
