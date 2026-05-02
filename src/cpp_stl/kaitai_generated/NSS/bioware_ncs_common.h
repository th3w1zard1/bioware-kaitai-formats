#ifndef BIOWARE_NCS_COMMON_H_
#define BIOWARE_NCS_COMMON_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bioware_ncs_common_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <set>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).
 * 
 * - `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
 *   (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
 * - `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
 *   decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
 * - `ncs_program_size_marker` is the fixed header byte after `"V1.0"` in retail KotOR NCS blobs (`0x42`).
 * 
 * **Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
 * duplicating opcode lists.
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L115 PyKotor — NCSByteCode
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L118-L140 PyKotor — NCSInstructionQualifier
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format PyKotor wiki — NCS
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355 xoreos — NCSFile::load
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137 xoreos-tools — NCSFile::load
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html xoreos-docs — Torlack ncs.html
 * \sa https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40 reone — NcsReader::load
 */

class bioware_ncs_common_t : public kaitai::kstruct {

public:

    enum ncs_bytecode_t {
        NCS_BYTECODE_RESERVED_BC = 0,
        NCS_BYTECODE_CPDOWNSP = 1,
        NCS_BYTECODE_RSADDX = 2,
        NCS_BYTECODE_CPTOPSP = 3,
        NCS_BYTECODE_CONSTX = 4,
        NCS_BYTECODE_ACTION = 5,
        NCS_BYTECODE_LOGANDXX = 6,
        NCS_BYTECODE_LOGORXX = 7,
        NCS_BYTECODE_INCORXX = 8,
        NCS_BYTECODE_EXCORXX = 9,
        NCS_BYTECODE_BOOLANDXX = 10,
        NCS_BYTECODE_EQUALXX = 11,
        NCS_BYTECODE_NEQUALXX = 12,
        NCS_BYTECODE_GEQXX = 13,
        NCS_BYTECODE_GTXX = 14,
        NCS_BYTECODE_LTXX = 15,
        NCS_BYTECODE_LEQXX = 16,
        NCS_BYTECODE_SHLEFTXX = 17,
        NCS_BYTECODE_SHRIGHTXX = 18,
        NCS_BYTECODE_USHRIGHTXX = 19,
        NCS_BYTECODE_ADDXX = 20,
        NCS_BYTECODE_SUBXX = 21,
        NCS_BYTECODE_MULXX = 22,
        NCS_BYTECODE_DIVXX = 23,
        NCS_BYTECODE_MODXX = 24,
        NCS_BYTECODE_NEGX = 25,
        NCS_BYTECODE_COMPX = 26,
        NCS_BYTECODE_MOVSP = 27,
        NCS_BYTECODE_UNUSED_GAP = 28,
        NCS_BYTECODE_JMP = 29,
        NCS_BYTECODE_JSR = 30,
        NCS_BYTECODE_JZ = 31,
        NCS_BYTECODE_RETN = 32,
        NCS_BYTECODE_DESTRUCT = 33,
        NCS_BYTECODE_NOTX = 34,
        NCS_BYTECODE_DECXSP = 35,
        NCS_BYTECODE_INCXSP = 36,
        NCS_BYTECODE_JNZ = 37,
        NCS_BYTECODE_CPDOWNBP = 38,
        NCS_BYTECODE_CPTOPBP = 39,
        NCS_BYTECODE_DECXBP = 40,
        NCS_BYTECODE_INCXBP = 41,
        NCS_BYTECODE_SAVEBP = 42,
        NCS_BYTECODE_RESTOREBP = 43,
        NCS_BYTECODE_STORE_STATE = 44,
        NCS_BYTECODE_NOP = 45
    };
    static bool _is_defined_ncs_bytecode_t(ncs_bytecode_t v);

private:
    static const std::set<ncs_bytecode_t> _values_ncs_bytecode_t;
    static std::set<ncs_bytecode_t> _build_values_ncs_bytecode_t();

public:

    enum ncs_instruction_qualifier_t {
        NCS_INSTRUCTION_QUALIFIER_NONE = 0,
        NCS_INSTRUCTION_QUALIFIER_UNARY_OPERAND_LAYOUT = 1,
        NCS_INSTRUCTION_QUALIFIER_INT_TYPE = 3,
        NCS_INSTRUCTION_QUALIFIER_FLOAT_TYPE = 4,
        NCS_INSTRUCTION_QUALIFIER_STRING_TYPE = 5,
        NCS_INSTRUCTION_QUALIFIER_OBJECT_TYPE = 6,
        NCS_INSTRUCTION_QUALIFIER_EFFECT_TYPE = 16,
        NCS_INSTRUCTION_QUALIFIER_EVENT_TYPE = 17,
        NCS_INSTRUCTION_QUALIFIER_LOCATION_TYPE = 18,
        NCS_INSTRUCTION_QUALIFIER_TALENT_TYPE = 19,
        NCS_INSTRUCTION_QUALIFIER_INT_INT = 32,
        NCS_INSTRUCTION_QUALIFIER_FLOAT_FLOAT = 33,
        NCS_INSTRUCTION_QUALIFIER_OBJECT_OBJECT = 34,
        NCS_INSTRUCTION_QUALIFIER_STRING_STRING = 35,
        NCS_INSTRUCTION_QUALIFIER_STRUCT_STRUCT = 36,
        NCS_INSTRUCTION_QUALIFIER_INT_FLOAT = 37,
        NCS_INSTRUCTION_QUALIFIER_FLOAT_INT = 38,
        NCS_INSTRUCTION_QUALIFIER_EFFECT_EFFECT = 48,
        NCS_INSTRUCTION_QUALIFIER_EVENT_EVENT = 49,
        NCS_INSTRUCTION_QUALIFIER_LOCATION_LOCATION = 50,
        NCS_INSTRUCTION_QUALIFIER_TALENT_TALENT = 51,
        NCS_INSTRUCTION_QUALIFIER_VECTOR_VECTOR = 58,
        NCS_INSTRUCTION_QUALIFIER_VECTOR_FLOAT = 59,
        NCS_INSTRUCTION_QUALIFIER_FLOAT_VECTOR = 60
    };
    static bool _is_defined_ncs_instruction_qualifier_t(ncs_instruction_qualifier_t v);

private:
    static const std::set<ncs_instruction_qualifier_t> _values_ncs_instruction_qualifier_t;
    static std::set<ncs_instruction_qualifier_t> _build_values_ncs_instruction_qualifier_t();

public:

    enum ncs_program_size_marker_t {
        NCS_PROGRAM_SIZE_MARKER_PROGRAM_SIZE_PREFIX = 66
    };
    static bool _is_defined_ncs_program_size_marker_t(ncs_program_size_marker_t v);

private:
    static const std::set<ncs_program_size_marker_t> _values_ncs_program_size_marker_t;
    static std::set<ncs_program_size_marker_t> _build_values_ncs_program_size_marker_t();

public:

    bioware_ncs_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_ncs_common_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bioware_ncs_common_t();

private:
    bioware_ncs_common_t* m__root;
    kaitai::kstruct* m__parent;

public:
    bioware_ncs_common_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BIOWARE_NCS_COMMON_H_
