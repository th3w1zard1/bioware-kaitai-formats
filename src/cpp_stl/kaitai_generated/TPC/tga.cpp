// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "tga.h"

tga_t::tga_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, tga_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_color_map_spec = 0;
    m_image_spec = 0;
    m_color_map_data = 0;
    m_image_data = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void tga_t::_read() {
    m_id_length = m__io->read_u1();
    m_color_map_type = static_cast<tga_common_t::tga_color_map_type_t>(m__io->read_u1());
    m_image_type = static_cast<tga_common_t::tga_image_type_t>(m__io->read_u1());
    n_color_map_spec = true;
    if (color_map_type() == tga_common_t::TGA_COLOR_MAP_TYPE_PRESENT) {
        n_color_map_spec = false;
        m_color_map_spec = new color_map_specification_t(m__io, this, m__root);
    }
    m_image_spec = new image_specification_t(m__io, this, m__root);
    n_image_id = true;
    if (id_length() > 0) {
        n_image_id = false;
        m_image_id = kaitai::kstream::bytes_to_str(m__io->read_bytes(id_length()), "ASCII");
    }
    n_color_map_data = true;
    if (color_map_type() == tga_common_t::TGA_COLOR_MAP_TYPE_PRESENT) {
        n_color_map_data = false;
        m_color_map_data = new std::vector<uint8_t>();
        const int l_color_map_data = color_map_spec()->length();
        for (int i = 0; i < l_color_map_data; i++) {
            m_color_map_data->push_back(m__io->read_u1());
        }
    }
    m_image_data = new std::vector<uint8_t>();
    {
        int i = 0;
        while (!m__io->is_eof()) {
            m_image_data->push_back(m__io->read_u1());
            i++;
        }
    }
}

tga_t::~tga_t() {
    _clean_up();
}

void tga_t::_clean_up() {
    if (!n_color_map_spec) {
        if (m_color_map_spec) {
            delete m_color_map_spec; m_color_map_spec = 0;
        }
    }
    if (m_image_spec) {
        delete m_image_spec; m_image_spec = 0;
    }
    if (!n_image_id) {
    }
    if (!n_color_map_data) {
        if (m_color_map_data) {
            delete m_color_map_data; m_color_map_data = 0;
        }
    }
    if (m_image_data) {
        delete m_image_data; m_image_data = 0;
    }
}

tga_t::color_map_specification_t::color_map_specification_t(kaitai::kstream* p__io, tga_t* p__parent, tga_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void tga_t::color_map_specification_t::_read() {
    m_first_entry_index = m__io->read_u2le();
    m_length = m__io->read_u2le();
    m_entry_size = m__io->read_u1();
}

tga_t::color_map_specification_t::~color_map_specification_t() {
    _clean_up();
}

void tga_t::color_map_specification_t::_clean_up() {
}

tga_t::image_specification_t::image_specification_t(kaitai::kstream* p__io, tga_t* p__parent, tga_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void tga_t::image_specification_t::_read() {
    m_x_origin = m__io->read_u2le();
    m_y_origin = m__io->read_u2le();
    m_width = m__io->read_u2le();
    m_height = m__io->read_u2le();
    m_pixel_depth = m__io->read_u1();
    m_image_descriptor = m__io->read_u1();
}

tga_t::image_specification_t::~image_specification_t() {
    _clean_up();
}

void tga_t::image_specification_t::_clean_up() {
}
