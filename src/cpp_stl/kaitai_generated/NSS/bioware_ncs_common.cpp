// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bioware_ncs_common.h"
std::set<bioware_ncs_common_t::ncs_bytecode_t> bioware_ncs_common_t::_build_values_ncs_bytecode_t() {
    std::set<bioware_ncs_common_t::ncs_bytecode_t> _t;
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_RESERVED_BC);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_CPDOWNSP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_RSADDX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_CPTOPSP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_CONSTX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_ACTION);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_LOGANDXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_LOGORXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_INCORXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_EXCORXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_BOOLANDXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_EQUALXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_NEQUALXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_GEQXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_GTXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_LTXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_LEQXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_SHLEFTXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_SHRIGHTXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_USHRIGHTXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_ADDXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_SUBXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_MULXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_DIVXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_MODXX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_NEGX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_COMPX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_MOVSP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_UNUSED_GAP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_JMP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_JSR);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_JZ);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_RETN);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_DESTRUCT);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_NOTX);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_DECXSP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_INCXSP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_JNZ);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_CPDOWNBP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_CPTOPBP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_DECXBP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_INCXBP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_SAVEBP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_RESTOREBP);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_STORE_STATE);
    _t.insert(bioware_ncs_common_t::NCS_BYTECODE_NOP);
    return _t;
}
const std::set<bioware_ncs_common_t::ncs_bytecode_t> bioware_ncs_common_t::_values_ncs_bytecode_t = bioware_ncs_common_t::_build_values_ncs_bytecode_t();
bool bioware_ncs_common_t::_is_defined_ncs_bytecode_t(bioware_ncs_common_t::ncs_bytecode_t v) {
    return bioware_ncs_common_t::_values_ncs_bytecode_t.find(v) != bioware_ncs_common_t::_values_ncs_bytecode_t.end();
}
std::set<bioware_ncs_common_t::ncs_instruction_qualifier_t> bioware_ncs_common_t::_build_values_ncs_instruction_qualifier_t() {
    std::set<bioware_ncs_common_t::ncs_instruction_qualifier_t> _t;
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_NONE);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_UNARY_OPERAND_LAYOUT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_INT_TYPE);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_FLOAT_TYPE);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_STRING_TYPE);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_OBJECT_TYPE);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_EFFECT_TYPE);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_EVENT_TYPE);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_LOCATION_TYPE);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_TALENT_TYPE);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_INT_INT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_FLOAT_FLOAT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_OBJECT_OBJECT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_STRING_STRING);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_STRUCT_STRUCT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_INT_FLOAT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_FLOAT_INT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_EFFECT_EFFECT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_EVENT_EVENT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_LOCATION_LOCATION);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_TALENT_TALENT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_VECTOR_VECTOR);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_VECTOR_FLOAT);
    _t.insert(bioware_ncs_common_t::NCS_INSTRUCTION_QUALIFIER_FLOAT_VECTOR);
    return _t;
}
const std::set<bioware_ncs_common_t::ncs_instruction_qualifier_t> bioware_ncs_common_t::_values_ncs_instruction_qualifier_t = bioware_ncs_common_t::_build_values_ncs_instruction_qualifier_t();
bool bioware_ncs_common_t::_is_defined_ncs_instruction_qualifier_t(bioware_ncs_common_t::ncs_instruction_qualifier_t v) {
    return bioware_ncs_common_t::_values_ncs_instruction_qualifier_t.find(v) != bioware_ncs_common_t::_values_ncs_instruction_qualifier_t.end();
}
std::set<bioware_ncs_common_t::ncs_program_size_marker_t> bioware_ncs_common_t::_build_values_ncs_program_size_marker_t() {
    std::set<bioware_ncs_common_t::ncs_program_size_marker_t> _t;
    _t.insert(bioware_ncs_common_t::NCS_PROGRAM_SIZE_MARKER_PROGRAM_SIZE_PREFIX);
    return _t;
}
const std::set<bioware_ncs_common_t::ncs_program_size_marker_t> bioware_ncs_common_t::_values_ncs_program_size_marker_t = bioware_ncs_common_t::_build_values_ncs_program_size_marker_t();
bool bioware_ncs_common_t::_is_defined_ncs_program_size_marker_t(bioware_ncs_common_t::ncs_program_size_marker_t v) {
    return bioware_ncs_common_t::_values_ncs_program_size_marker_t.find(v) != bioware_ncs_common_t::_values_ncs_program_size_marker_t.end();
}

bioware_ncs_common_t::bioware_ncs_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_ncs_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_ncs_common_t::_read() {
}

bioware_ncs_common_t::~bioware_ncs_common_t() {
    _clean_up();
}

void bioware_ncs_common_t::_clean_up() {
}
