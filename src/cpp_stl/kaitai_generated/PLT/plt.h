#ifndef PLT_H_
#define PLT_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class plt_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
 * palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
 * that reference external palette files, enabling dynamic color customization for character models
 * (skin, hair, armor colors, etc.).
 * 
 * **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
 * resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
 * does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
 * including character models. This documentation is provided for reference only.
 * 
 * **reone:** the KotOR-focused fork does not ship a standalone PLT body reader; see `meta.xref.reone_resource_type_plt_note` for the numeric `Plt` type id only.
 * 
 * Binary Format Structure:
 * - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
 * - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)
 * 
 * Palette System:
 * PLT files work in conjunction with external palette files (.pal files) that contain the actual
 * color values. The PLT file itself stores:
 * 1. Palette Group index (0-9): Which palette group to use for each pixel
 * 2. Color index (0-255): Which color within the selected palette to use
 * 
 * At runtime, the game:
 * 1. Loads the appropriate palette file for the selected palette group
 * 2. Uses the palette index (supplied by the content creator) to select a row in the palette file
 * 3. Uses the color index from the PLT file to retrieve the final color value
 * 
 * Palette Groups (10 total):
 * 0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
 * 6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L374-L380 PyKotor — `ResourceType.PLT`
 * - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
 * - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy PyKotor wiki — PLT (NWN legacy)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html xoreos-docs — Torlack plt.html
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L63 xoreos — `kFileTypePLT`
 * \sa https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L35 reone — `ResourceType::Plt` (id 6; no `.plt` wire reader on default branch)
 */

class plt_t : public kaitai::kstruct {

public:
    class pixel_data_section_t;
    class plt_header_t;
    class plt_pixel_t;

    plt_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, plt_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~plt_t();

    class pixel_data_section_t : public kaitai::kstruct {

    public:

        pixel_data_section_t(kaitai::kstream* p__io, plt_t* p__parent = 0, plt_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~pixel_data_section_t();

    private:
        std::vector<plt_pixel_t*>* m_pixels;
        plt_t* m__root;
        plt_t* m__parent;

    public:

        /**
         * Array of pixel entries, stored row by row, left to right, top to bottom.
         * Total size = width × height × 2 bytes.
         * Each pixel entry contains a color index and palette group index.
         */
        std::vector<plt_pixel_t*>* pixels() const { return m_pixels; }
        plt_t* _root() const { return m__root; }
        plt_t* _parent() const { return m__parent; }
    };

    class plt_header_t : public kaitai::kstruct {

    public:

        plt_header_t(kaitai::kstream* p__io, plt_t* p__parent = 0, plt_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~plt_header_t();

    private:
        std::string m_signature;
        std::string m_version;
        uint32_t m_unknown1;
        uint32_t m_unknown2;
        uint32_t m_width;
        uint32_t m_height;
        plt_t* m__root;
        plt_t* m__parent;

    public:

        /**
         * File signature. Must be "PLT " (space-padded).
         * This identifies the file as a PLT palette texture.
         */
        std::string signature() const { return m_signature; }

        /**
         * File format version. Must be "V1  " (space-padded).
         * This is the only known version of the PLT format.
         */
        std::string version() const { return m_version; }

        /**
         * Unknown field (4 bytes).
         * Purpose is unknown, may be reserved for future use or internal engine flags.
         */
        uint32_t unknown1() const { return m_unknown1; }

        /**
         * Unknown field (4 bytes).
         * Purpose is unknown, may be reserved for future use or internal engine flags.
         */
        uint32_t unknown2() const { return m_unknown2; }

        /**
         * Texture width in pixels (uint32).
         * Used to calculate the number of pixel entries in the pixel data section.
         */
        uint32_t width() const { return m_width; }

        /**
         * Texture height in pixels (uint32).
         * Used to calculate the number of pixel entries in the pixel data section.
         * Total pixel count = width × height
         */
        uint32_t height() const { return m_height; }
        plt_t* _root() const { return m__root; }
        plt_t* _parent() const { return m__parent; }
    };

    class plt_pixel_t : public kaitai::kstruct {

    public:

        plt_pixel_t(kaitai::kstream* p__io, plt_t::pixel_data_section_t* p__parent = 0, plt_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~plt_pixel_t();

    private:
        uint8_t m_color_index;
        uint8_t m_palette_group_index;
        plt_t* m__root;
        plt_t::pixel_data_section_t* m__parent;

    public:

        /**
         * Color index (0-255) within the selected palette.
         * This value selects which color from the palette file row to use.
         * The palette file contains 256 rows (one for each palette index 0-255),
         * and each row contains 256 color values (one for each color index 0-255).
         */
        uint8_t color_index() const { return m_color_index; }

        /**
         * Palette group index (0-9) that determines which palette file to use.
         * Palette groups:
         * 0 = Skin (pal_skin01.jpg)
         * 1 = Hair (pal_hair01.jpg)
         * 2 = Metal 1 (pal_armor01.jpg)
         * 3 = Metal 2 (pal_armor02.jpg)
         * 4 = Cloth 1 (pal_cloth01.jpg)
         * 5 = Cloth 2 (pal_cloth01.jpg)
         * 6 = Leather 1 (pal_leath01.jpg)
         * 7 = Leather 2 (pal_leath01.jpg)
         * 8 = Tattoo 1 (pal_tattoo01.jpg)
         * 9 = Tattoo 2 (pal_tattoo01.jpg)
         */
        uint8_t palette_group_index() const { return m_palette_group_index; }
        plt_t* _root() const { return m__root; }
        plt_t::pixel_data_section_t* _parent() const { return m__parent; }
    };

private:
    plt_header_t* m_header;
    pixel_data_section_t* m_pixel_data;
    plt_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * PLT file header (24 bytes)
     */
    plt_header_t* header() const { return m_header; }

    /**
     * Array of pixel entries (width × height entries, 2 bytes each)
     */
    pixel_data_section_t* pixel_data() const { return m_pixel_data; }
    plt_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // PLT_H_
