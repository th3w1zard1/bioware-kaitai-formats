#ifndef BZF_H_
#define BZF_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bzf_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
 * mobile KotOR ports.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression PyKotor wiki — BZF (LZMA BIF)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L26-L54 PyKotor — `_decompress_bzf_payload`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/bzffile.cpp#L41-L83 xoreos — `kBZFID` quirk + `BZFFile::load`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L207 xoreos-tools — `.bzf` → `BZFFile`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf
 */

class bzf_t : public kaitai::kstruct {

public:

    bzf_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bzf_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bzf_t();

private:
    std::string m_file_type;
    std::string m_version;
    std::string m_compressed_data;
    bzf_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * File type signature. Must be "BZF " for compressed BIF files.
     */
    std::string file_type() const { return m_file_type; }

    /**
     * File format version. Always "V1.0" for BZF files.
     */
    std::string version() const { return m_version; }

    /**
     * LZMA-compressed BIF file data (single blob to EOF).
     * Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).
     */
    std::string compressed_data() const { return m_compressed_data; }
    bzf_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BZF_H_
