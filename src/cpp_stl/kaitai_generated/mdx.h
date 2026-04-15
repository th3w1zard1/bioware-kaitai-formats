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
 * xoreos interleaved MDX reads: `meta.xref.xoreos_model_kotor_mdx_reads`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L885-L917 xoreos — Model_KotOR MDX reads
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
     * See `meta.xref.pykotor_wiki_mdl` and `meta.xref.xoreos_model_kotor_mdx_reads`. Skinned meshes add bone weights
     * and indices per vertex as described on the wiki.
     */
    std::string vertex_data() const { return m_vertex_data; }
    mdx_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // MDX_H_
