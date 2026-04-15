#ifndef TXI_H_
#define TXI_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class txi_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **Policy:** TXI is **plaintext** (line-oriented ASCII). This `.ksy` models only an opaque string span for tooling;
 * authoritative command semantics live in PyKotor / reone parsers (`meta.xref`). xoreos consumes embedded TXI via **`TPC::readTXI`**
 * (`meta.xref.xoreos_tpc_read_txi`), not a standalone `txifile.cpp`.
 * 
 * TXI (Texture Info) files are compact ASCII descriptors that attach metadata to TPC textures.
 * They control mipmap usage, filtering, flipbook animation, environment mapping, font atlases,
 * and platform-specific downsampling. Every TXI file is parsed at runtime to configure how
 * a TPC image is rendered.
 * 
 * Format Structure:
 * - Line-based ASCII text file (UTF-8 or Windows-1252)
 * - Commands are case-insensitive but conventionally lowercase
 * - Empty TXI files (0 bytes) are valid and use default settings
 * - A TXI can be embedded at the end of a .tpc file or exist as a separate .txi file
 * 
 * Command Formats (from PyKotor implementation):
 * 1. Simple commands: "command value" (e.g., "mipmap 0", "blending additive")
 * 2. Multi-value commands: "command v1 v2 v3" (e.g., "channelscale 1.0 0.5 0.5")
 * 3. Coordinate commands: "command count" followed by count coordinate lines
 *    Coordinate format: "x y z" (normalized floats + int, typically z=0)
 * 
 * Parsing Behavior (matches PyKotor TXIReaderMode):
 * - Lines parsed sequentially, whitespace stripped
 * - Empty lines ignored
 * - Commands recognized by uppercase comparison against TXICommand enum
 * - Invalid commands logged but don't stop parsing
 * - Coordinate commands switch parser to coordinate mode until count reached
 * - Commands can interrupt coordinate parsing
 * 
 * All Supported Commands (from TXICommand enum in txi_data.py):
 * - alphamean, arturoheight, arturowidth, baselineheight, blending, bumpmapscaling, bumpmaptexture
 * - bumpyshinytexture, candownsample, caretindent, channelscale, channeltranslate, clamp, codepage
 * - cols, compresstexture, controllerscript, cube, decal, defaultbpp, defaultheight, defaultwidth
 * - distort, distortangle, distortionamplitude, downsamplefactor, downsamplemax, downsamplemin
 * - envmaptexture, filerange, filter, fontheight, fontwidth, fps, isbumpmap, isdiffusebumpmap
 * - islightmap, isspecularbumpmap, lowerrightcoords, maxsizehq, maxsizelq, minsizehq, minsizelq
 * - mipmap, numchars, numcharspersheet, numx, numy, ondemand, priority, proceduretype, rows
 * - spacingb, spacingr, speed, temporary, texturewidth, unique, upperleftcoords, wateralpha
 * - waterheight, waterwidth, xbox_downsample
 * 
 * Index: `meta.xref` and `doc-ref`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi PyKotor wiki — TXI
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/io_txi.py#L20-L50 PyKotor — TXI reader (`TXIReaderMode`, `TXIBinaryReader.load` start)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py#L619-L684 PyKotor — `TXICommand` enum block
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/txireader.cpp#L28-L125 reone — `TxiReader` ASCII parse (`load` + `processLine`)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L362-L373 xoreos — `TPC::readTXI` (embedded TXI tail)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader` (texture tool stack; TXI pairs with TPC)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L88 xoreos — `kFileTypeTXI`
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (TPC-attached TXI context)
 */

class txi_t : public kaitai::kstruct {

public:

    txi_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, txi_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~txi_t();

private:
    std::string m_content;
    txi_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * Complete TXI file content as raw ASCII text.
     * The PyKotor parser processes this line-by-line with special handling for:
     * - Coordinate commands (upperleftcoords, lowerrightcoords) followed by coordinate data
     * - Multi-value commands (channelscale, channeltranslate, filerange)
     * - Boolean/numeric/string single-value commands
     * - Empty files (valid, indicates default settings)
     */
    std::string content() const { return m_content; }
    txi_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // TXI_H_
