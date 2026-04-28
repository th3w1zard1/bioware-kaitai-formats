// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "tga_common.h"
std::set<tga_common_t::tga_color_map_type_t> tga_common_t::_build_values_tga_color_map_type_t() {
    std::set<tga_common_t::tga_color_map_type_t> _t;
    _t.insert(tga_common_t::TGA_COLOR_MAP_TYPE_NONE);
    _t.insert(tga_common_t::TGA_COLOR_MAP_TYPE_PRESENT);
    return _t;
}
const std::set<tga_common_t::tga_color_map_type_t> tga_common_t::_values_tga_color_map_type_t = tga_common_t::_build_values_tga_color_map_type_t();
bool tga_common_t::_is_defined_tga_color_map_type_t(tga_common_t::tga_color_map_type_t v) {
    return tga_common_t::_values_tga_color_map_type_t.find(v) != tga_common_t::_values_tga_color_map_type_t.end();
}
std::set<tga_common_t::tga_image_type_t> tga_common_t::_build_values_tga_image_type_t() {
    std::set<tga_common_t::tga_image_type_t> _t;
    _t.insert(tga_common_t::TGA_IMAGE_TYPE_NO_IMAGE_DATA);
    _t.insert(tga_common_t::TGA_IMAGE_TYPE_UNCOMPRESSED_COLOR_MAPPED);
    _t.insert(tga_common_t::TGA_IMAGE_TYPE_UNCOMPRESSED_RGB);
    _t.insert(tga_common_t::TGA_IMAGE_TYPE_UNCOMPRESSED_GREYSCALE);
    _t.insert(tga_common_t::TGA_IMAGE_TYPE_RLE_COLOR_MAPPED);
    _t.insert(tga_common_t::TGA_IMAGE_TYPE_RLE_RGB);
    _t.insert(tga_common_t::TGA_IMAGE_TYPE_RLE_GREYSCALE);
    return _t;
}
const std::set<tga_common_t::tga_image_type_t> tga_common_t::_values_tga_image_type_t = tga_common_t::_build_values_tga_image_type_t();
bool tga_common_t::_is_defined_tga_image_type_t(tga_common_t::tga_image_type_t v) {
    return tga_common_t::_values_tga_image_type_t.find(v) != tga_common_t::_values_tga_image_type_t.end();
}

tga_common_t::tga_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, tga_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void tga_common_t::_read() {
}

tga_common_t::~tga_common_t() {
    _clean_up();
}

void tga_common_t::_clean_up() {
}
