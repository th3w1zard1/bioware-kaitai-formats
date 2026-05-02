#ifndef TPC_H_
#define TPC_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class tpc_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_common.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
 * (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
 * (`meta.xref`).
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — TPC
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303 PyKotor — `TPCBinaryReader` + `load`
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120 PyKotor — `TPCTextureFormat` (opening)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520 PyKotor — `class TPC` (opening)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105 reone — `TpcReader` (body + TXI features)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L183 xoreos — `kFileTypeTPC`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L362 xoreos — `TPC::load` through `readTXI` entrypoints
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts#L290-L380 KotOR.js — `TPCObject.readHeader`
 */

class tpc_t : public kaitai::kstruct {

public:
    class tpc_header_t;

    tpc_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, tpc_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~tpc_t();

    class tpc_header_t : public kaitai::kstruct {

    public:

        tpc_header_t(kaitai::kstream* p__io, tpc_t* p__parent = 0, tpc_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~tpc_header_t();

    private:
        bool f_is_compressed;
        bool m_is_compressed;

    public:

        /**
         * True if texture data is compressed (DXT format)
         */
        bool is_compressed();

    private:
        bool f_is_uncompressed;
        bool m_is_uncompressed;

    public:

        /**
         * True if texture data is uncompressed (raw pixels)
         */
        bool is_uncompressed();

    private:
        uint32_t m_data_size;
        float m_alpha_test;
        uint16_t m_width;
        uint16_t m_height;
        bioware_common_t::bioware_tpc_pixel_format_id_t m_pixel_encoding;
        uint8_t m_mipmap_count;
        std::vector<uint8_t>* m_reserved;
        tpc_t* m__root;
        tpc_t* m__parent;

    public:

        /**
         * Total compressed payload size. If non-zero, texture is compressed (DXT).
         * If zero, texture is uncompressed and size is derived from format/width/height.
         */
        uint32_t data_size() const { return m_data_size; }

        /**
         * Float threshold used by punch-through rendering.
         * Commonly 0.0 or 0.5.
         */
        float alpha_test() const { return m_alpha_test; }

        /**
         * Texture width in pixels (uint16).
         * Must be power-of-two for compressed formats.
         */
        uint16_t width() const { return m_width; }

        /**
         * Texture height in pixels (uint16).
         * For cube maps, this is 6x the face width.
         * Must be power-of-two for compressed formats.
         */
        uint16_t height() const { return m_height; }

        /**
         * Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
         * `bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).
         */
        bioware_common_t::bioware_tpc_pixel_format_id_t pixel_encoding() const { return m_pixel_encoding; }

        /**
         * Number of mip levels per layer (minimum 1).
         * Each mip level is half the size of the previous level.
         */
        uint8_t mipmap_count() const { return m_mipmap_count; }

        /**
         * Reserved/padding bytes (0x72 = 114 bytes).
         * KotOR stores platform hints here but all implementations skip them.
         */
        std::vector<uint8_t>* reserved() const { return m_reserved; }
        tpc_t* _root() const { return m__root; }
        tpc_t* _parent() const { return m__parent; }
    };

private:
    tpc_header_t* m_header;
    std::string m_body;
    tpc_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * TPC file header (128 bytes total)
     */
    tpc_header_t* header() const { return m_header; }

    /**
     * Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).
     */
    std::string body() const { return m_body; }
    tpc_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // TPC_H_
