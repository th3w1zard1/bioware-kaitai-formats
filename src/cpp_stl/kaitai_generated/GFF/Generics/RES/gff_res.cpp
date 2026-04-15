// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "gff_res.h"

gff_res_t::gff_res_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, gff_res_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_contents = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_res_t::_read() {
    m_contents = new gff_t::gff_union_file_t(m__io);
}

gff_res_t::~gff_res_t() {
    _clean_up();
}

void gff_res_t::_clean_up() {
    if (m_contents) {
        delete m_contents; m_contents = 0;
    }
}
