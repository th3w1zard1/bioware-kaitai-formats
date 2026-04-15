#ifndef NSS_H_
#define NSS_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class nss_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * NSS (NWScript Source) files contain human-readable NWScript source code
 * that compiles to NCS bytecode. NWScript is the scripting language used
 * in KotOR, TSL, and Neverwinter Nights.
 * 
 * NSS files are plain text files (typically Windows-1252 or UTF-8 encoding)
 * containing NWScript source code. The nwscript.nss file defines all
 * engine-exposed functions and constants available to scripts.
 * 
 * Format:
 * - Plain text source code
 * - May include BOM (Byte Order Mark) for UTF-8 files
 * - Lines are typically terminated with CRLF (\r\n) or LF (\n)
 * - Comments: // for single-line, /* */ for multi-line
 * - Preprocessor directives: #include, #define, etc.
 * 
 * Authoritative links: `meta.doc-ref` (PyKotor wiki, xoreos `types.h` `kFileTypeNSS`, xoreos-tools `NCSFile`, reone `NssWriter`).
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/NSS-File-Format PyKotor wiki — NSS
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L85-L86 xoreos — `kFileTypeNSS` / `kFileTypeNCS` (Aurora `FileType` IDs; NSS plaintext, NCS bytecode)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137 xoreos-tools — `NCSFile`
 * \sa https://github.com/modawan/reone/blob/master/src/libs/tools/script/format/nsswriter.cpp#L33-L45 reone — `NssWriter::save`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html xoreos-docs — Torlack NCS (bytecode companion to plaintext NSS)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree
 */

class nss_t : public kaitai::kstruct {

public:
    class nss_source_t;

    nss_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, nss_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~nss_t();

    /**
     * NWScript source code structure.
     * This is primarily a text format, so the main content is the source_code string.
     * 
     * The source can be parsed into:
     * - Tokens (keywords, identifiers, operators, literals)
     * - Statements (declarations, assignments, control flow)
     * - Functions (definitions with parameters and body)
     * - Preprocessor directives (#include, #define)
     */

    class nss_source_t : public kaitai::kstruct {

    public:

        nss_source_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, nss_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~nss_source_t();

    private:
        std::string m_content;
        nss_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Complete source code content.
         */
        std::string content() const { return m_content; }
        nss_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

private:
    uint16_t m_bom;
    bool n_bom;

public:
    bool _is_null_bom() { bom(); return n_bom; };

private:
    std::string m_source_code;
    nss_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * Optional UTF-8 BOM (Byte Order Mark) at the start of the file.
     * If present, will be 0xFEFF (UTF-8 BOM).
     * Most NSS files do not include a BOM.
     */
    uint16_t bom() const { return m_bom; }

    /**
     * Complete NWScript source code.
     * Contains function definitions, variable declarations, control flow
     * statements, and engine function calls.
     * 
     * Common elements:
     * - Function definitions: void function_name() { ... }
     * - Variable declarations: int variable_name;
     * - Control flow: if, while, for, switch
     * - Engine function calls: GetFirstObject(), GetObjectByTag(), etc.
     * - Constants: OBJECT_SELF, OBJECT_INVALID, etc.
     * 
     * The source code is compiled to NCS bytecode by the NWScript compiler.
     */
    std::string source_code() const { return m_source_code; }
    nss_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // NSS_H_
