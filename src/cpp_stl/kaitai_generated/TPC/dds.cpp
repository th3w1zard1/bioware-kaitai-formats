// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "dds.h"
#include "kaitai/exceptions.h"

dds_t::dds_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, dds_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_header = 0;
    m_bioware_header = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void dds_t::_read() {
    m_magic = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!( ((m_magic == std::string("DDS ")) || (m_magic == std::string("    "))) )) {
        throw kaitai::validation_not_any_of_error<std::string>(m_magic, m__io, std::string("/seq/0"));
    }
    n_header = true;
    if (magic() == std::string("DDS ")) {
        n_header = false;
        m_header = new dds_header_t(m__io, this, m__root);
    }
    n_bioware_header = true;
    if (magic() != std::string("DDS ")) {
        n_bioware_header = false;
        m_bioware_header = new bioware_dds_header_t(m__io, this, m__root);
    }
    m_pixel_data = m__io->read_bytes_full();
}

dds_t::~dds_t() {
    _clean_up();
}

void dds_t::_clean_up() {
    if (!n_header) {
        if (m_header) {
            delete m_header; m_header = 0;
        }
    }
    if (!n_bioware_header) {
        if (m_bioware_header) {
            delete m_bioware_header; m_bioware_header = 0;
        }
    }
}

dds_t::bioware_dds_header_t::bioware_dds_header_t(kaitai::kstream* p__io, dds_t* p__parent, dds_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void dds_t::bioware_dds_header_t::_read() {
    m_width = m__io->read_u4le();
    m_height = m__io->read_u4le();
    m_bytes_per_pixel = static_cast<bioware_common_t::bioware_dds_variant_bytes_per_pixel_t>(m__io->read_u4le());
    m_data_size = m__io->read_u4le();
    m_unused_float = m__io->read_f4le();
}

dds_t::bioware_dds_header_t::~bioware_dds_header_t() {
    _clean_up();
}

void dds_t::bioware_dds_header_t::_clean_up() {
}

dds_t::ddpixelformat_t::ddpixelformat_t(kaitai::kstream* p__io, dds_t::dds_header_t* p__parent, dds_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void dds_t::ddpixelformat_t::_read() {
    m_size = m__io->read_u4le();
    if (!(m_size == 32)) {
        throw kaitai::validation_not_equal_error<uint32_t>(32, m_size, m__io, std::string("/types/ddpixelformat/seq/0"));
    }
    m_flags = m__io->read_u4le();
    m_fourcc = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_rgb_bit_count = m__io->read_u4le();
    m_r_bit_mask = m__io->read_u4le();
    m_g_bit_mask = m__io->read_u4le();
    m_b_bit_mask = m__io->read_u4le();
    m_a_bit_mask = m__io->read_u4le();
}

dds_t::ddpixelformat_t::~ddpixelformat_t() {
    _clean_up();
}

void dds_t::ddpixelformat_t::_clean_up() {
}

dds_t::dds_header_t::dds_header_t(kaitai::kstream* p__io, dds_t* p__parent, dds_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_reserved1 = 0;
    m_pixel_format = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void dds_t::dds_header_t::_read() {
    m_size = m__io->read_u4le();
    if (!(m_size == 124)) {
        throw kaitai::validation_not_equal_error<uint32_t>(124, m_size, m__io, std::string("/types/dds_header/seq/0"));
    }
    m_flags = m__io->read_u4le();
    m_height = m__io->read_u4le();
    m_width = m__io->read_u4le();
    m_pitch_or_linear_size = m__io->read_u4le();
    m_depth = m__io->read_u4le();
    m_mipmap_count = m__io->read_u4le();
    m_reserved1 = new std::vector<uint32_t>();
    const int l_reserved1 = 11;
    for (int i = 0; i < l_reserved1; i++) {
        m_reserved1->push_back(m__io->read_u4le());
    }
    m_pixel_format = new ddpixelformat_t(m__io, this, m__root);
    m_caps = m__io->read_u4le();
    m_caps2 = m__io->read_u4le();
    m_caps3 = m__io->read_u4le();
    m_caps4 = m__io->read_u4le();
    m_reserved2 = m__io->read_u4le();
}

dds_t::dds_header_t::~dds_header_t() {
    _clean_up();
}

void dds_t::dds_header_t::_clean_up() {
    if (m_reserved1) {
        delete m_reserved1; m_reserved1 = 0;
    }
    if (m_pixel_format) {
        delete m_pixel_format; m_pixel_format = 0;
    }
}
