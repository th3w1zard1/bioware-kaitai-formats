#ifndef GDA_H_
#define GDA_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class gda_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "gff.h"

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
 * (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
 * 
 * G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
 * 
 * **reone:** not applicable for GDA wire ingestion on the KotOR fork (`meta.xref.reone_gda_consumer_note`).
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305 xoreos — `GDAFile::load`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L87-L93 xoreos — `GFF4File` stream ctor (type dispatch)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4fields.h#L1230-L1260 xoreos — G2DA column field ids (excerpt)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L136-L140 xoreos — `TwoDAFile(const GDAFile &)`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L343-L400 xoreos — `TwoDAFile::load(const GDAFile &)`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86 xoreos-tools — `main`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159 xoreos-tools — `get2DAGDA`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L167-L181 xoreos-tools — multi-file `GDAFile` merge
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L1466-L1472 PyKotor — `ResourceType.GDA`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (GFF4 family; G2DA container)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf xoreos-docs — 2DA_Format.pdf (classic `.2da`; contrast with GDA)
 */

class gda_t : public kaitai::kstruct {

public:

    gda_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gda_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~gda_t();

private:
    gff_t::gff4_file_t* m_as_gff4;
    gda_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
     * (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).
     */
    gff_t::gff4_file_t* as_gff4() const { return m_as_gff4; }
    gda_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // GDA_H_
