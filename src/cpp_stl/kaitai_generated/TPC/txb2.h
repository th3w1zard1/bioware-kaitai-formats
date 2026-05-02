#ifndef TXB2_H_
#define TXB2_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class txb2_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "tpc.h"

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **TXB2** (`kFileTypeTXB2` **3017**): second-generation TXB id in `types.h`; treated like **TXB** / **TPC** by engine
 * texture stacks. This capsule mirrors `TXB.ksy` (TPC header + opaque tail) until a divergent wire is proven.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192 xoreos — `kFileTypeTXB2`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66 xoreos — `TPC::load` (texture family)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — texture family
 */

class txb2_t : public kaitai::kstruct {

public:

    txb2_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, txb2_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~txb2_t();

private:
    tpc_t::tpc_header_t* m_header;
    std::string m_body;
    txb2_t* m__root;
    kaitai::kstruct* m__parent;

public:
    tpc_t::tpc_header_t* header() const { return m_header; }
    std::string body() const { return m_body; }
    txb2_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // TXB2_H_
