// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "plt.h"
#include "kaitai/exceptions.h"

plt_t::plt_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, plt_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_header = 0;
    m_pixel_data = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void plt_t::_read() {
    m_header = new plt_header_t(m__io, this, m__root);
    m_pixel_data = new pixel_data_section_t(m__io, this, m__root);
}

plt_t::~plt_t() {
    _clean_up();
}

void plt_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
    if (m_pixel_data) {
        delete m_pixel_data; m_pixel_data = 0;
    }
}

plt_t::pixel_data_section_t::pixel_data_section_t(kaitai::kstream* p__io, plt_t* p__parent, plt_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_pixels = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void plt_t::pixel_data_section_t::_read() {
    m_pixels = new std::vector<plt_pixel_t*>();
    const int l_pixels = _root()->header()->width() * _root()->header()->height();
    for (int i = 0; i < l_pixels; i++) {
        m_pixels->push_back(new plt_pixel_t(m__io, this, m__root));
    }
}

plt_t::pixel_data_section_t::~pixel_data_section_t() {
    _clean_up();
}

void plt_t::pixel_data_section_t::_clean_up() {
    if (m_pixels) {
        for (std::vector<plt_pixel_t*>::iterator it = m_pixels->begin(); it != m_pixels->end(); ++it) {
            delete *it;
        }
        delete m_pixels; m_pixels = 0;
    }
}

plt_t::plt_header_t::plt_header_t(kaitai::kstream* p__io, plt_t* p__parent, plt_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void plt_t::plt_header_t::_read() {
    m_signature = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_signature == std::string("PLT "))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("PLT "), m_signature, m__io, std::string("/types/plt_header/seq/0"));
    }
    m_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_version == std::string("V1  "))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("V1  "), m_version, m__io, std::string("/types/plt_header/seq/1"));
    }
    m_unknown1 = m__io->read_u4le();
    m_unknown2 = m__io->read_u4le();
    m_width = m__io->read_u4le();
    m_height = m__io->read_u4le();
}

plt_t::plt_header_t::~plt_header_t() {
    _clean_up();
}

void plt_t::plt_header_t::_clean_up() {
}

plt_t::plt_pixel_t::plt_pixel_t(kaitai::kstream* p__io, plt_t::pixel_data_section_t* p__parent, plt_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void plt_t::plt_pixel_t::_read() {
    m_color_index = m__io->read_u1();
    m_palette_group_index = m__io->read_u1();
}

plt_t::plt_pixel_t::~plt_pixel_t() {
    _clean_up();
}

void plt_t::plt_pixel_t::_clean_up() {
}
