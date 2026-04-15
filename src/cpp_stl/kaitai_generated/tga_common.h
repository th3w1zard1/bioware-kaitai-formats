#ifndef TGA_COMMON_H_
#define TGA_COMMON_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class tga_common_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <set>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
 * per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
 * 
 * Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
 */

class tga_common_t : public kaitai::kstruct {

public:

    enum tga_color_map_type_t {
        TGA_COLOR_MAP_TYPE_NONE = 0,
        TGA_COLOR_MAP_TYPE_PRESENT = 1
    };
    static bool _is_defined_tga_color_map_type_t(tga_color_map_type_t v);

private:
    static const std::set<tga_color_map_type_t> _values_tga_color_map_type_t;
    static std::set<tga_color_map_type_t> _build_values_tga_color_map_type_t();

public:

    enum tga_image_type_t {
        TGA_IMAGE_TYPE_NO_IMAGE_DATA = 0,
        TGA_IMAGE_TYPE_UNCOMPRESSED_COLOR_MAPPED = 1,
        TGA_IMAGE_TYPE_UNCOMPRESSED_RGB = 2,
        TGA_IMAGE_TYPE_UNCOMPRESSED_GREYSCALE = 3,
        TGA_IMAGE_TYPE_RLE_COLOR_MAPPED = 9,
        TGA_IMAGE_TYPE_RLE_RGB = 10,
        TGA_IMAGE_TYPE_RLE_GREYSCALE = 11
    };
    static bool _is_defined_tga_image_type_t(tga_image_type_t v);

private:
    static const std::set<tga_image_type_t> _values_tga_image_type_t;
    static std::set<tga_image_type_t> _build_values_tga_image_type_t();

public:

    tga_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, tga_common_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~tga_common_t();

private:
    tga_common_t* m__root;
    kaitai::kstruct* m__parent;

public:
    tga_common_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // TGA_COMMON_H_
