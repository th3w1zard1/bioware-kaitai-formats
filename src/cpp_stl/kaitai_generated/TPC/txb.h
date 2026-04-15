#ifndef TXB_H_
#define TXB_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class txb_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "tpc.h"

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
 * (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.
 * 
 * This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
 * variant diverges, split a dedicated header type and cite Ghidra / binary evidence (`TODO: VERIFY`).
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182 xoreos — `kFileTypeTXB`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66 xoreos — `TPC::load` (texture family)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — texture family (cross-check TXB)
 */

class txb_t : public kaitai::kstruct {

public:

    txb_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, txb_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~txb_t();

private:
    tpc_t::tpc_header_t* m_header;
    std::string m_body;
    txb_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
     */
    tpc_t::tpc_header_t* header() const { return m_header; }

    /**
     * Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.
     */
    std::string body() const { return m_body; }
    txb_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // TXB_H_
