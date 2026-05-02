// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bioware_gff_common.h"
std::set<bioware_gff_common_t::gff_field_type_t> bioware_gff_common_t::_build_values_gff_field_type_t() {
    std::set<bioware_gff_common_t::gff_field_type_t> _t;
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_UINT8);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_INT8);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_UINT16);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_INT16);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_UINT32);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_INT32);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_UINT64);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_INT64);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_SINGLE);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_DOUBLE);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_STRING);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_RESREF);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_LOCALIZED_STRING);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_BINARY);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_STRUCT);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_LIST);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_VECTOR4);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_VECTOR3);
    _t.insert(bioware_gff_common_t::GFF_FIELD_TYPE_STR_REF);
    return _t;
}
const std::set<bioware_gff_common_t::gff_field_type_t> bioware_gff_common_t::_values_gff_field_type_t = bioware_gff_common_t::_build_values_gff_field_type_t();
bool bioware_gff_common_t::_is_defined_gff_field_type_t(bioware_gff_common_t::gff_field_type_t v) {
    return bioware_gff_common_t::_values_gff_field_type_t.find(v) != bioware_gff_common_t::_values_gff_field_type_t.end();
}

bioware_gff_common_t::bioware_gff_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_gff_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_gff_common_t::_read() {
}

bioware_gff_common_t::~bioware_gff_common_t() {
    _clean_up();
}

void bioware_gff_common_t::_clean_up() {
}
