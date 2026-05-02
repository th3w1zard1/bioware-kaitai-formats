// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "gda.h"

gda_t::gda_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, gda_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_as_gff4 = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gda_t::_read() {
    m_as_gff4 = new gff_t::gff4_file_t(m__io);
}

gda_t::~gda_t() {
    _clean_up();
}

void gda_t::_clean_up() {
    if (m_as_gff4) {
        delete m_as_gff4; m_as_gff4 = 0;
    }
}
