#ifndef TGA_H_
#define TGA_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class tga_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "tga_common.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
 * converts authoring TGAs to **TPC** for shipping.
 * 
 * Shared header enums: `formats/Common/tga_common.ksy`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — textures (TPC/TGA pipeline)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40 PyKotor — compact TGA reader (`tga.py`)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120 PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177 xoreos — `TGA::readHeader`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L241 xoreos-tools — `TGA::load` through `readRLE` (tooling reader)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
 * \sa https://github.com/lachjames/NorthernLights lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)
 */

class tga_t : public kaitai::kstruct {

public:
    class color_map_specification_t;
    class image_specification_t;

    tga_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, tga_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~tga_t();

    class color_map_specification_t : public kaitai::kstruct {

    public:

        color_map_specification_t(kaitai::kstream* p__io, tga_t* p__parent = 0, tga_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~color_map_specification_t();

    private:
        uint16_t m_first_entry_index;
        uint16_t m_length;
        uint8_t m_entry_size;
        tga_t* m__root;
        tga_t* m__parent;

    public:

        /**
         * Index of first color map entry
         */
        uint16_t first_entry_index() const { return m_first_entry_index; }

        /**
         * Number of color map entries
         */
        uint16_t length() const { return m_length; }

        /**
         * Size of each color map entry in bits (15, 16, 24, or 32)
         */
        uint8_t entry_size() const { return m_entry_size; }
        tga_t* _root() const { return m__root; }
        tga_t* _parent() const { return m__parent; }
    };

    class image_specification_t : public kaitai::kstruct {

    public:

        image_specification_t(kaitai::kstream* p__io, tga_t* p__parent = 0, tga_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~image_specification_t();

    private:
        uint16_t m_x_origin;
        uint16_t m_y_origin;
        uint16_t m_width;
        uint16_t m_height;
        uint8_t m_pixel_depth;
        uint8_t m_image_descriptor;
        tga_t* m__root;
        tga_t* m__parent;

    public:

        /**
         * X coordinate of lower-left corner of image
         */
        uint16_t x_origin() const { return m_x_origin; }

        /**
         * Y coordinate of lower-left corner of image
         */
        uint16_t y_origin() const { return m_y_origin; }

        /**
         * Image width in pixels
         */
        uint16_t width() const { return m_width; }

        /**
         * Image height in pixels
         */
        uint16_t height() const { return m_height; }

        /**
         * Bits per pixel:
         * - 8 = Greyscale or indexed
         * - 16 = RGB 5-5-5 or RGBA 1-5-5-5
         * - 24 = RGB
         * - 32 = RGBA
         */
        uint8_t pixel_depth() const { return m_pixel_depth; }

        /**
         * Image descriptor byte:
         * - Bits 0-3: Number of attribute bits per pixel (alpha channel)
         * - Bit 4: Reserved
         * - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
         * - Bits 6-7: Interleaving (usually 0)
         */
        uint8_t image_descriptor() const { return m_image_descriptor; }
        tga_t* _root() const { return m__root; }
        tga_t* _parent() const { return m__parent; }
    };

private:
    uint8_t m_id_length;
    tga_common_t::tga_color_map_type_t m_color_map_type;
    tga_common_t::tga_image_type_t m_image_type;
    color_map_specification_t* m_color_map_spec;
    bool n_color_map_spec;

public:
    bool _is_null_color_map_spec() { color_map_spec(); return n_color_map_spec; };

private:
    image_specification_t* m_image_spec;
    std::string m_image_id;
    bool n_image_id;

public:
    bool _is_null_image_id() { image_id(); return n_image_id; };

private:
    std::vector<uint8_t>* m_color_map_data;
    bool n_color_map_data;

public:
    bool _is_null_color_map_data() { color_map_data(); return n_color_map_data; };

private:
    std::vector<uint8_t>* m_image_data;
    tga_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * Length of image ID field (0-255 bytes)
     */
    uint8_t id_length() const { return m_id_length; }

    /**
     * Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.
     */
    tga_common_t::tga_color_map_type_t color_map_type() const { return m_color_map_type; }

    /**
     * Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.
     */
    tga_common_t::tga_image_type_t image_type() const { return m_image_type; }

    /**
     * Color map specification (only present if color_map_type == present)
     */
    color_map_specification_t* color_map_spec() const { return m_color_map_spec; }

    /**
     * Image specification (dimensions and pixel format)
     */
    image_specification_t* image_spec() const { return m_image_spec; }

    /**
     * Image identification field (optional ASCII string)
     */
    std::string image_id() const { return m_image_id; }

    /**
     * Color map data (palette entries)
     */
    std::vector<uint8_t>* color_map_data() const { return m_color_map_data; }

    /**
     * Image pixel data (raw or RLE-compressed).
     * Size depends on image dimensions, pixel format, and compression.
     * For uncompressed formats: width × height × bytes_per_pixel
     * For RLE formats: Variable size depending on compression ratio
     */
    std::vector<uint8_t>* image_data() const { return m_image_data; }
    tga_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // TGA_H_
