#ifndef DDS_H_
#define DDS_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class dds_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_common.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
 * (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.
 * 
 * BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds PyKotor wiki — DDS
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130 PyKotor — TPCDDSReader
 */

class dds_t : public kaitai::kstruct {

public:
    class bioware_dds_header_t;
    class ddpixelformat_t;
    class dds_header_t;

    dds_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, dds_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~dds_t();

    class bioware_dds_header_t : public kaitai::kstruct {

    public:

        bioware_dds_header_t(kaitai::kstream* p__io, dds_t* p__parent = 0, dds_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_dds_header_t();

    private:
        uint32_t m_width;
        uint32_t m_height;
        bioware_common_t::bioware_dds_variant_bytes_per_pixel_t m_bytes_per_pixel;
        uint32_t m_data_size;
        float m_unused_float;
        dds_t* m__root;
        dds_t* m__parent;

    public:

        /**
         * Image width in pixels (must be power of two, < 0x8000)
         */
        uint32_t width() const { return m_width; }

        /**
         * Image height in pixels (must be power of two, < 0x8000)
         */
        uint32_t height() const { return m_height; }

        /**
         * BioWare variant “bytes per pixel” (`u4`): DXT1 vs DXT5 block stride hint. Canonical: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
         */
        bioware_common_t::bioware_dds_variant_bytes_per_pixel_t bytes_per_pixel() const { return m_bytes_per_pixel; }

        /**
         * Total compressed data size.
         * Must match (width*height)/2 for DXT1 or width*height for DXT5
         */
        uint32_t data_size() const { return m_data_size; }

        /**
         * Unused float field (typically 0.0)
         */
        float unused_float() const { return m_unused_float; }
        dds_t* _root() const { return m__root; }
        dds_t* _parent() const { return m__parent; }
    };

    class ddpixelformat_t : public kaitai::kstruct {

    public:

        ddpixelformat_t(kaitai::kstream* p__io, dds_t::dds_header_t* p__parent = 0, dds_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~ddpixelformat_t();

    private:
        uint32_t m_size;
        uint32_t m_flags;
        std::string m_fourcc;
        uint32_t m_rgb_bit_count;
        uint32_t m_r_bit_mask;
        uint32_t m_g_bit_mask;
        uint32_t m_b_bit_mask;
        uint32_t m_a_bit_mask;
        dds_t* m__root;
        dds_t::dds_header_t* m__parent;

    public:

        /**
         * Structure size (must be 32)
         */
        uint32_t size() const { return m_size; }

        /**
         * Pixel format flags:
         * - 0x00000001 = DDPF_ALPHAPIXELS
         * - 0x00000002 = DDPF_ALPHA
         * - 0x00000004 = DDPF_FOURCC
         * - 0x00000040 = DDPF_RGB
         * - 0x00000200 = DDPF_YUV
         * - 0x00080000 = DDPF_LUMINANCE
         */
        uint32_t flags() const { return m_flags; }

        /**
         * Four-character code for compressed formats:
         * - "DXT1" = DXT1 compression
         * - "DXT3" = DXT3 compression
         * - "DXT5" = DXT5 compression
         * - "    " = Uncompressed format
         */
        std::string fourcc() const { return m_fourcc; }

        /**
         * Bits per pixel for uncompressed formats (16, 24, or 32)
         */
        uint32_t rgb_bit_count() const { return m_rgb_bit_count; }

        /**
         * Red channel bit mask (for uncompressed formats)
         */
        uint32_t r_bit_mask() const { return m_r_bit_mask; }

        /**
         * Green channel bit mask (for uncompressed formats)
         */
        uint32_t g_bit_mask() const { return m_g_bit_mask; }

        /**
         * Blue channel bit mask (for uncompressed formats)
         */
        uint32_t b_bit_mask() const { return m_b_bit_mask; }

        /**
         * Alpha channel bit mask (for uncompressed formats)
         */
        uint32_t a_bit_mask() const { return m_a_bit_mask; }
        dds_t* _root() const { return m__root; }
        dds_t::dds_header_t* _parent() const { return m__parent; }
    };

    class dds_header_t : public kaitai::kstruct {

    public:

        dds_header_t(kaitai::kstream* p__io, dds_t* p__parent = 0, dds_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~dds_header_t();

    private:
        uint32_t m_size;
        uint32_t m_flags;
        uint32_t m_height;
        uint32_t m_width;
        uint32_t m_pitch_or_linear_size;
        uint32_t m_depth;
        uint32_t m_mipmap_count;
        std::vector<uint32_t>* m_reserved1;
        ddpixelformat_t* m_pixel_format;
        uint32_t m_caps;
        uint32_t m_caps2;
        uint32_t m_caps3;
        uint32_t m_caps4;
        uint32_t m_reserved2;
        dds_t* m__root;
        dds_t* m__parent;

    public:

        /**
         * Header size (must be 124)
         */
        uint32_t size() const { return m_size; }

        /**
         * DDS flags bitfield:
         * - 0x00001007 = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT
         * - 0x00020000 = DDSD_MIPMAPCOUNT (if mipmaps present)
         */
        uint32_t flags() const { return m_flags; }

        /**
         * Image height in pixels
         */
        uint32_t height() const { return m_height; }

        /**
         * Image width in pixels
         */
        uint32_t width() const { return m_width; }

        /**
         * Pitch (uncompressed) or linear size (compressed).
         * For compressed formats: total size of all mip levels
         */
        uint32_t pitch_or_linear_size() const { return m_pitch_or_linear_size; }

        /**
         * Depth for volume textures (usually 0 for 2D textures)
         */
        uint32_t depth() const { return m_depth; }

        /**
         * Number of mipmap levels (0 or 1 = no mipmaps)
         */
        uint32_t mipmap_count() const { return m_mipmap_count; }

        /**
         * Reserved fields (unused)
         */
        std::vector<uint32_t>* reserved1() const { return m_reserved1; }

        /**
         * Pixel format structure
         */
        ddpixelformat_t* pixel_format() const { return m_pixel_format; }

        /**
         * Capability flags:
         * - 0x00001000 = DDSCAPS_TEXTURE
         * - 0x00000008 = DDSCAPS_MIPMAP
         * - 0x00000200 = DDSCAPS2_CUBEMAP
         */
        uint32_t caps() const { return m_caps; }

        /**
         * Additional capability flags:
         * - 0x00000200 = DDSCAPS2_CUBEMAP
         * - 0x00000FC00 = Cube map face flags
         */
        uint32_t caps2() const { return m_caps2; }

        /**
         * Reserved capability flags
         */
        uint32_t caps3() const { return m_caps3; }

        /**
         * Reserved capability flags
         */
        uint32_t caps4() const { return m_caps4; }

        /**
         * Reserved field
         */
        uint32_t reserved2() const { return m_reserved2; }
        dds_t* _root() const { return m__root; }
        dds_t* _parent() const { return m__parent; }
    };

private:
    std::string m_magic;
    dds_header_t* m_header;
    bool n_header;

public:
    bool _is_null_header() { header(); return n_header; };

private:
    bioware_dds_header_t* m_bioware_header;
    bool n_bioware_header;

public:
    bool _is_null_bioware_header() { bioware_header(); return n_bioware_header; };

private:
    std::string m_pixel_data;
    dds_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * File magic. Either "DDS " (0x44445320) for standard DDS,
     * or check for BioWare variant (no magic, starts with width/height).
     */
    std::string magic() const { return m_magic; }

    /**
     * Standard DDS header (124 bytes) - only present if magic is "DDS "
     */
    dds_header_t* header() const { return m_header; }

    /**
     * BioWare DDS variant header - only present if magic is not "DDS "
     */
    bioware_dds_header_t* bioware_header() const { return m_bioware_header; }

    /**
     * Pixel data (compressed or uncompressed); single blob to EOF.
     * For standard DDS: format determined by DDPIXELFORMAT.
     * For BioWare DDS: DXT1 or DXT5 compressed data.
     */
    std::string pixel_data() const { return m_pixel_data; }
    dds_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // DDS_H_
