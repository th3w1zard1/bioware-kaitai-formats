#ifndef GFF_IFO_H_
#define GFF_IFO_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class gff_ifo_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "gff.h"

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **IFO** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
 * `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
 * `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.
 * 
 * FileType / restype id **2014** — see `bioware_type_ids::xoreos_file_type_id` enum member `ifo`.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — GFF3 header read
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF binary
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (GFF3 wire)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 */

class gff_ifo_t : public kaitai::kstruct {

public:

    gff_ifo_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_ifo_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~gff_ifo_t();

private:
    gff_t::gff_union_file_t* m_contents;
    gff_ifo_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per IFO template docs / PyKotor `gff_auto`.
     */
    gff_t::gff_union_file_t* contents() const { return m_contents; }
    gff_ifo_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // GFF_IFO_H_
