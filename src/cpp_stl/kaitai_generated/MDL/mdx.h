#ifndef MDX_H_
#define MDX_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class mdx_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
 * Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
 * opaque `size-eos` span — per-attribute layouts are MDL-driven.
 * 
 * Cross-implementations: xoreos reads trimesh MDX stride and interleaved streams in `meta.xref.xoreos_model_kotor_*`;
 * reone parses mesh MDX in `meta.xref.reone_mdlmdxreader_read_mesh`; KotOR.js uses `OdysseyModelNodeMesh` and
 * `OdysseyModelMDXFlag` (`meta.xref.kotor_js_*`). Shared bitmask names: imported `bioware_mdl_common::mdx_vertex_stream_flag`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408 PyKotor — `MDLBinaryReader` / MDX tail read path
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L809-L842 xoreos — trimesh MDX header fields (mdxStructSize, UV offsets, counts)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L864-L917 xoreos — interleaved MDX vertex loop
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192 xoreos — `kFileTypeMDX` (3008)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L201 xoreos — `kFileTypeMDX2` (3016)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDX-specific tool)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL/MDX overview
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (MDX-related controller / mesh background)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L197-L487 reone — MdlMdxReader::readMesh (MDX consumption)
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/enums/odyssey/OdysseyModelMDXFlag.ts KotOR.js — MDX stream flag enum
 */

class mdx_t : public kaitai::kstruct {

public:

    mdx_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdx_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~mdx_t();

private:
    std::string m_vertex_data;
    mdx_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * Raw vertex data bytes; layout follows the trimesh header in the paired MDL (`mdx_data_offset`, `mdx_vertex_size`,
     * `mdx_data_flags`). Bit names for `mdx_data_flags`: `bioware_mdl_common::mdx_vertex_stream_flag` (bitmask on wire).
     * 
     * See `meta.xref.pykotor_wiki_mdl`, `meta.xref.xoreos_model_kotor_trimesh_mdx_fields`, and
     * `meta.xref.xoreos_model_kotor_mdx_interleaved_vertices`. Skinned meshes add bone weights
     * and indices per vertex as described on the wiki.
     */
    std::string vertex_data() const { return m_vertex_data; }
    mdx_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // MDX_H_
