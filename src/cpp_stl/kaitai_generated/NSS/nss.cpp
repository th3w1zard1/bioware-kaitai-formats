// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "nss.h"
#include "kaitai/exceptions.h"

nss_t::nss_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, nss_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void nss_t::_read() {
    n_bom = true;
    if (_io()->pos() == 0) {
        n_bom = false;
        m_bom = m__io->read_u2le();
        if (!( ((m_bom == 65279) || (m_bom == 0)) )) {
            throw kaitai::validation_not_any_of_error<uint16_t>(m_bom, m__io, std::string("/seq/0"));
        }
    }
    m_source_code = kaitai::kstream::bytes_to_str(m__io->read_bytes_full(), "UTF-8");
}

nss_t::~nss_t() {
    _clean_up();
}

void nss_t::_clean_up() {
    if (!n_bom) {
    }
}

nss_t::nss_source_t::nss_source_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, nss_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void nss_t::nss_source_t::_read() {
    m_content = kaitai::kstream::bytes_to_str(m__io->read_bytes_full(), "UTF-8");
}

nss_t::nss_source_t::~nss_source_t() {
    _clean_up();
}

void nss_t::nss_source_t::_clean_up() {
}
