// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bioware_tslpatcher_common.h"
#include "kaitai/exceptions.h"
std::set<bioware_tslpatcher_common_t::bioware_tslpatcher_log_type_id_t> bioware_tslpatcher_common_t::_build_values_bioware_tslpatcher_log_type_id_t() {
    std::set<bioware_tslpatcher_common_t::bioware_tslpatcher_log_type_id_t> _t;
    _t.insert(bioware_tslpatcher_common_t::BIOWARE_TSLPATCHER_LOG_TYPE_ID_VERBOSE);
    _t.insert(bioware_tslpatcher_common_t::BIOWARE_TSLPATCHER_LOG_TYPE_ID_NOTE);
    _t.insert(bioware_tslpatcher_common_t::BIOWARE_TSLPATCHER_LOG_TYPE_ID_WARNING);
    _t.insert(bioware_tslpatcher_common_t::BIOWARE_TSLPATCHER_LOG_TYPE_ID_ERROR);
    return _t;
}
const std::set<bioware_tslpatcher_common_t::bioware_tslpatcher_log_type_id_t> bioware_tslpatcher_common_t::_values_bioware_tslpatcher_log_type_id_t = bioware_tslpatcher_common_t::_build_values_bioware_tslpatcher_log_type_id_t();
bool bioware_tslpatcher_common_t::_is_defined_bioware_tslpatcher_log_type_id_t(bioware_tslpatcher_common_t::bioware_tslpatcher_log_type_id_t v) {
    return bioware_tslpatcher_common_t::_values_bioware_tslpatcher_log_type_id_t.find(v) != bioware_tslpatcher_common_t::_values_bioware_tslpatcher_log_type_id_t.end();
}
std::set<bioware_tslpatcher_common_t::bioware_tslpatcher_target_type_id_t> bioware_tslpatcher_common_t::_build_values_bioware_tslpatcher_target_type_id_t() {
    std::set<bioware_tslpatcher_common_t::bioware_tslpatcher_target_type_id_t> _t;
    _t.insert(bioware_tslpatcher_common_t::BIOWARE_TSLPATCHER_TARGET_TYPE_ID_ROW_INDEX);
    _t.insert(bioware_tslpatcher_common_t::BIOWARE_TSLPATCHER_TARGET_TYPE_ID_ROW_LABEL);
    _t.insert(bioware_tslpatcher_common_t::BIOWARE_TSLPATCHER_TARGET_TYPE_ID_LABEL_COLUMN);
    return _t;
}
const std::set<bioware_tslpatcher_common_t::bioware_tslpatcher_target_type_id_t> bioware_tslpatcher_common_t::_values_bioware_tslpatcher_target_type_id_t = bioware_tslpatcher_common_t::_build_values_bioware_tslpatcher_target_type_id_t();
bool bioware_tslpatcher_common_t::_is_defined_bioware_tslpatcher_target_type_id_t(bioware_tslpatcher_common_t::bioware_tslpatcher_target_type_id_t v) {
    return bioware_tslpatcher_common_t::_values_bioware_tslpatcher_target_type_id_t.find(v) != bioware_tslpatcher_common_t::_values_bioware_tslpatcher_target_type_id_t.end();
}

bioware_tslpatcher_common_t::bioware_tslpatcher_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_tslpatcher_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_tslpatcher_common_t::_read() {
}

bioware_tslpatcher_common_t::~bioware_tslpatcher_common_t() {
    _clean_up();
}

void bioware_tslpatcher_common_t::_clean_up() {
}

bioware_tslpatcher_common_t::bioware_diff_format_str_t::bioware_diff_format_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_tslpatcher_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_tslpatcher_common_t::bioware_diff_format_str_t::_read() {
    m_value = kaitai::kstream::bytes_to_str(m__io->read_bytes_term(0, false, true, true), "ASCII");
    if (!( ((m_value == std::string("default")) || (m_value == std::string("unified")) || (m_value == std::string("context")) || (m_value == std::string("side_by_side"))) )) {
        throw kaitai::validation_not_any_of_error<std::string>(m_value, m__io, std::string("/types/bioware_diff_format_str/seq/0"));
    }
}

bioware_tslpatcher_common_t::bioware_diff_format_str_t::~bioware_diff_format_str_t() {
    _clean_up();
}

void bioware_tslpatcher_common_t::bioware_diff_format_str_t::_clean_up() {
}

bioware_tslpatcher_common_t::bioware_diff_resource_type_str_t::bioware_diff_resource_type_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_tslpatcher_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_tslpatcher_common_t::bioware_diff_resource_type_str_t::_read() {
    m_value = kaitai::kstream::bytes_to_str(m__io->read_bytes_term(0, false, true, true), "ASCII");
    if (!( ((m_value == std::string("gff")) || (m_value == std::string("2da")) || (m_value == std::string("tlk")) || (m_value == std::string("lip")) || (m_value == std::string("bytes"))) )) {
        throw kaitai::validation_not_any_of_error<std::string>(m_value, m__io, std::string("/types/bioware_diff_resource_type_str/seq/0"));
    }
}

bioware_tslpatcher_common_t::bioware_diff_resource_type_str_t::~bioware_diff_resource_type_str_t() {
    _clean_up();
}

void bioware_tslpatcher_common_t::bioware_diff_resource_type_str_t::_clean_up() {
}

bioware_tslpatcher_common_t::bioware_diff_type_str_t::bioware_diff_type_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_tslpatcher_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_tslpatcher_common_t::bioware_diff_type_str_t::_read() {
    m_value = kaitai::kstream::bytes_to_str(m__io->read_bytes_term(0, false, true, true), "ASCII");
    if (!( ((m_value == std::string("identical")) || (m_value == std::string("modified")) || (m_value == std::string("added")) || (m_value == std::string("removed")) || (m_value == std::string("error"))) )) {
        throw kaitai::validation_not_any_of_error<std::string>(m_value, m__io, std::string("/types/bioware_diff_type_str/seq/0"));
    }
}

bioware_tslpatcher_common_t::bioware_diff_type_str_t::~bioware_diff_type_str_t() {
    _clean_up();
}

void bioware_tslpatcher_common_t::bioware_diff_type_str_t::_clean_up() {
}

bioware_tslpatcher_common_t::bioware_ncs_token_type_str_t::bioware_ncs_token_type_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_tslpatcher_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_tslpatcher_common_t::bioware_ncs_token_type_str_t::_read() {
    m_value = kaitai::kstream::bytes_to_str(m__io->read_bytes_term(0, false, true, true), "ASCII");
    if (!( ((m_value == std::string("strref")) || (m_value == std::string("strref32")) || (m_value == std::string("2damemory")) || (m_value == std::string("2damemory32")) || (m_value == std::string("uint32")) || (m_value == std::string("uint16")) || (m_value == std::string("uint8"))) )) {
        throw kaitai::validation_not_any_of_error<std::string>(m_value, m__io, std::string("/types/bioware_ncs_token_type_str/seq/0"));
    }
}

bioware_tslpatcher_common_t::bioware_ncs_token_type_str_t::~bioware_ncs_token_type_str_t() {
    _clean_up();
}

void bioware_tslpatcher_common_t::bioware_ncs_token_type_str_t::_clean_up() {
}
