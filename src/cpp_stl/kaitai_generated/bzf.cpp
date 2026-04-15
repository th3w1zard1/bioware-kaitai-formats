// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bzf.h"
#include "kaitai/exceptions.h"

bzf_t::bzf_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bzf_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bzf_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_type == std::string("BZF "))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("BZF "), m_file_type, m__io, std::string("/seq/0"));
    }
    m_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_version == std::string("V1.0"))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("V1.0"), m_version, m__io, std::string("/seq/1"));
    }
    m_compressed_data = m__io->read_bytes_full();
}

bzf_t::~bzf_t() {
    _clean_up();
}

void bzf_t::_clean_up() {
}
