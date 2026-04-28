#ifndef ITP_XML_H_
#define ITP_XML_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class itp_xml_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
 * ITP files use GFF format (FileType "ITP " in GFF header).
 * Uses GFF XML structure with root element <gff3> containing <struct> elements.
 * Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).
 * 
 * Canonical links: `meta.doc-ref` and `meta.xref`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF (ITP is GFF-shaped)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — `GFF3File::readHeader`
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225 reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 xoreos-docs — Torlack ITP / MultiMap (GFF-family context)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 */

class itp_xml_t : public kaitai::kstruct {

public:

    itp_xml_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, itp_xml_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~itp_xml_t();

private:
    std::string m_xml_content;
    itp_xml_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * XML document content as UTF-8 text
     */
    std::string xml_content() const { return m_xml_content; }
    itp_xml_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // ITP_XML_H_
