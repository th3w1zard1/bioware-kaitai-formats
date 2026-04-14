// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "gff.h"
std::set<gff_t::gff_field_type_t> gff_t::_build_values_gff_field_type_t() {
    std::set<gff_t::gff_field_type_t> _t;
    _t.insert(gff_t::GFF_FIELD_TYPE_UINT8);
    _t.insert(gff_t::GFF_FIELD_TYPE_INT8);
    _t.insert(gff_t::GFF_FIELD_TYPE_UINT16);
    _t.insert(gff_t::GFF_FIELD_TYPE_INT16);
    _t.insert(gff_t::GFF_FIELD_TYPE_UINT32);
    _t.insert(gff_t::GFF_FIELD_TYPE_INT32);
    _t.insert(gff_t::GFF_FIELD_TYPE_UINT64);
    _t.insert(gff_t::GFF_FIELD_TYPE_INT64);
    _t.insert(gff_t::GFF_FIELD_TYPE_SINGLE);
    _t.insert(gff_t::GFF_FIELD_TYPE_DOUBLE);
    _t.insert(gff_t::GFF_FIELD_TYPE_STRING);
    _t.insert(gff_t::GFF_FIELD_TYPE_RESREF);
    _t.insert(gff_t::GFF_FIELD_TYPE_LOCALIZED_STRING);
    _t.insert(gff_t::GFF_FIELD_TYPE_BINARY);
    _t.insert(gff_t::GFF_FIELD_TYPE_STRUCT);
    _t.insert(gff_t::GFF_FIELD_TYPE_LIST);
    _t.insert(gff_t::GFF_FIELD_TYPE_VECTOR4);
    _t.insert(gff_t::GFF_FIELD_TYPE_VECTOR3);
    _t.insert(gff_t::GFF_FIELD_TYPE_STR_REF);
    return _t;
}
const std::set<gff_t::gff_field_type_t> gff_t::_values_gff_field_type_t = gff_t::_build_values_gff_field_type_t();
bool gff_t::_is_defined_gff_field_type_t(gff_t::gff_field_type_t v) {
    return gff_t::_values_gff_field_type_t.find(v) != gff_t::_values_gff_field_type_t.end();
}

gff_t::gff_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_header = 0;
    m_field_array = 0;
    m_field_data = 0;
    m_field_indices_array = 0;
    m_label_array = 0;
    m_list_indices_array = 0;
    m_root_struct_resolved = 0;
    m_struct_array = 0;
    f_field_array = false;
    f_field_data = false;
    f_field_indices_array = false;
    f_label_array = false;
    f_list_indices_array = false;
    f_root_struct_resolved = false;
    f_struct_array = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::_read() {
    m_header = new gff_header_t(m__io, this, m__root);
}

gff_t::~gff_t() {
    _clean_up();
}

void gff_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
    if (f_field_array && !n_field_array) {
        if (m_field_array) {
            delete m_field_array; m_field_array = 0;
        }
    }
    if (f_field_data && !n_field_data) {
        if (m_field_data) {
            delete m_field_data; m_field_data = 0;
        }
    }
    if (f_field_indices_array && !n_field_indices_array) {
        if (m_field_indices_array) {
            delete m_field_indices_array; m_field_indices_array = 0;
        }
    }
    if (f_label_array && !n_label_array) {
        if (m_label_array) {
            delete m_label_array; m_label_array = 0;
        }
    }
    if (f_list_indices_array && !n_list_indices_array) {
        if (m_list_indices_array) {
            delete m_list_indices_array; m_list_indices_array = 0;
        }
    }
    if (f_root_struct_resolved) {
        if (m_root_struct_resolved) {
            delete m_root_struct_resolved; m_root_struct_resolved = 0;
        }
    }
    if (f_struct_array && !n_struct_array) {
        if (m_struct_array) {
            delete m_struct_array; m_struct_array = 0;
        }
    }
}

gff_t::field_array_t::field_array_t(kaitai::kstream* p__io, gff_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_entries = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::field_array_t::_read() {
    m_entries = new std::vector<field_entry_t*>();
    const int l_entries = _root()->header()->field_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new field_entry_t(m__io, this, m__root));
    }
}

gff_t::field_array_t::~field_array_t() {
    _clean_up();
}

void gff_t::field_array_t::_clean_up() {
    if (m_entries) {
        for (std::vector<field_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

gff_t::field_data_t::field_data_t(kaitai::kstream* p__io, gff_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::field_data_t::_read() {
    m_raw_data = m__io->read_bytes(_root()->header()->field_data_count());
}

gff_t::field_data_t::~field_data_t() {
    _clean_up();
}

void gff_t::field_data_t::_clean_up() {
}

gff_t::field_entry_t::field_entry_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_field_data_offset_value = false;
    f_is_complex_type = false;
    f_is_list_type = false;
    f_is_simple_type = false;
    f_is_struct_type = false;
    f_list_indices_offset_value = false;
    f_struct_index_value = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::field_entry_t::_read() {
    m_field_type = static_cast<gff_t::gff_field_type_t>(m__io->read_u4le());
    m_label_index = m__io->read_u4le();
    m_data_or_offset = m__io->read_u4le();
}

gff_t::field_entry_t::~field_entry_t() {
    _clean_up();
}

void gff_t::field_entry_t::_clean_up() {
}

int32_t gff_t::field_entry_t::field_data_offset_value() {
    if (f_field_data_offset_value)
        return m_field_data_offset_value;
    f_field_data_offset_value = true;
    n_field_data_offset_value = true;
    if (is_complex_type()) {
        n_field_data_offset_value = false;
        m_field_data_offset_value = _root()->header()->field_data_offset() + data_or_offset();
    }
    return m_field_data_offset_value;
}

bool gff_t::field_entry_t::is_complex_type() {
    if (f_is_complex_type)
        return m_is_complex_type;
    f_is_complex_type = true;
    m_is_complex_type =  ((field_type() == gff_t::GFF_FIELD_TYPE_UINT64) || (field_type() == gff_t::GFF_FIELD_TYPE_INT64) || (field_type() == gff_t::GFF_FIELD_TYPE_DOUBLE) || (field_type() == gff_t::GFF_FIELD_TYPE_STRING) || (field_type() == gff_t::GFF_FIELD_TYPE_RESREF) || (field_type() == gff_t::GFF_FIELD_TYPE_LOCALIZED_STRING) || (field_type() == gff_t::GFF_FIELD_TYPE_BINARY) || (field_type() == gff_t::GFF_FIELD_TYPE_VECTOR4) || (field_type() == gff_t::GFF_FIELD_TYPE_VECTOR3)) ;
    return m_is_complex_type;
}

bool gff_t::field_entry_t::is_list_type() {
    if (f_is_list_type)
        return m_is_list_type;
    f_is_list_type = true;
    m_is_list_type = field_type() == gff_t::GFF_FIELD_TYPE_LIST;
    return m_is_list_type;
}

bool gff_t::field_entry_t::is_simple_type() {
    if (f_is_simple_type)
        return m_is_simple_type;
    f_is_simple_type = true;
    m_is_simple_type =  ((field_type() == gff_t::GFF_FIELD_TYPE_UINT8) || (field_type() == gff_t::GFF_FIELD_TYPE_INT8) || (field_type() == gff_t::GFF_FIELD_TYPE_UINT16) || (field_type() == gff_t::GFF_FIELD_TYPE_INT16) || (field_type() == gff_t::GFF_FIELD_TYPE_UINT32) || (field_type() == gff_t::GFF_FIELD_TYPE_INT32) || (field_type() == gff_t::GFF_FIELD_TYPE_SINGLE) || (field_type() == gff_t::GFF_FIELD_TYPE_STR_REF)) ;
    return m_is_simple_type;
}

bool gff_t::field_entry_t::is_struct_type() {
    if (f_is_struct_type)
        return m_is_struct_type;
    f_is_struct_type = true;
    m_is_struct_type = field_type() == gff_t::GFF_FIELD_TYPE_STRUCT;
    return m_is_struct_type;
}

int32_t gff_t::field_entry_t::list_indices_offset_value() {
    if (f_list_indices_offset_value)
        return m_list_indices_offset_value;
    f_list_indices_offset_value = true;
    n_list_indices_offset_value = true;
    if (is_list_type()) {
        n_list_indices_offset_value = false;
        m_list_indices_offset_value = _root()->header()->list_indices_offset() + data_or_offset();
    }
    return m_list_indices_offset_value;
}

uint32_t gff_t::field_entry_t::struct_index_value() {
    if (f_struct_index_value)
        return m_struct_index_value;
    f_struct_index_value = true;
    n_struct_index_value = true;
    if (is_struct_type()) {
        n_struct_index_value = false;
        m_struct_index_value = data_or_offset();
    }
    return m_struct_index_value;
}

gff_t::field_indices_array_t::field_indices_array_t(kaitai::kstream* p__io, gff_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_indices = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::field_indices_array_t::_read() {
    m_indices = new std::vector<uint32_t>();
    const int l_indices = _root()->header()->field_indices_count();
    for (int i = 0; i < l_indices; i++) {
        m_indices->push_back(m__io->read_u4le());
    }
}

gff_t::field_indices_array_t::~field_indices_array_t() {
    _clean_up();
}

void gff_t::field_indices_array_t::_clean_up() {
    if (m_indices) {
        delete m_indices; m_indices = 0;
    }
}

gff_t::gff_header_t::gff_header_t(kaitai::kstream* p__io, gff_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::gff_header_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_file_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_struct_offset = m__io->read_u4le();
    m_struct_count = m__io->read_u4le();
    m_field_offset = m__io->read_u4le();
    m_field_count = m__io->read_u4le();
    m_label_offset = m__io->read_u4le();
    m_label_count = m__io->read_u4le();
    m_field_data_offset = m__io->read_u4le();
    m_field_data_count = m__io->read_u4le();
    m_field_indices_offset = m__io->read_u4le();
    m_field_indices_count = m__io->read_u4le();
    m_list_indices_offset = m__io->read_u4le();
    m_list_indices_count = m__io->read_u4le();
}

gff_t::gff_header_t::~gff_header_t() {
    _clean_up();
}

void gff_t::gff_header_t::_clean_up() {
}

gff_t::label_array_t::label_array_t(kaitai::kstream* p__io, gff_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_labels = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::label_array_t::_read() {
    m_labels = new std::vector<label_entry_t*>();
    const int l_labels = _root()->header()->label_count();
    for (int i = 0; i < l_labels; i++) {
        m_labels->push_back(new label_entry_t(m__io, this, m__root));
    }
}

gff_t::label_array_t::~label_array_t() {
    _clean_up();
}

void gff_t::label_array_t::_clean_up() {
    if (m_labels) {
        for (std::vector<label_entry_t*>::iterator it = m_labels->begin(); it != m_labels->end(); ++it) {
            delete *it;
        }
        delete m_labels; m_labels = 0;
    }
}

gff_t::label_entry_t::label_entry_t(kaitai::kstream* p__io, gff_t::label_array_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::label_entry_t::_read() {
    m_name = kaitai::kstream::bytes_to_str(m__io->read_bytes(16), "ASCII");
}

gff_t::label_entry_t::~label_entry_t() {
    _clean_up();
}

void gff_t::label_entry_t::_clean_up() {
}

gff_t::label_entry_terminated_t::label_entry_terminated_t(kaitai::kstream* p__io, gff_t::resolved_field_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::label_entry_terminated_t::_read() {
    m_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(16), 0, false), "ASCII");
}

gff_t::label_entry_terminated_t::~label_entry_terminated_t() {
    _clean_up();
}

void gff_t::label_entry_terminated_t::_clean_up() {
}

gff_t::list_entry_t::list_entry_t(kaitai::kstream* p__io, gff_t::resolved_field_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_struct_indices = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::list_entry_t::_read() {
    m_num_struct_indices = m__io->read_u4le();
    m_struct_indices = new std::vector<uint32_t>();
    const int l_struct_indices = num_struct_indices();
    for (int i = 0; i < l_struct_indices; i++) {
        m_struct_indices->push_back(m__io->read_u4le());
    }
}

gff_t::list_entry_t::~list_entry_t() {
    _clean_up();
}

void gff_t::list_entry_t::_clean_up() {
    if (m_struct_indices) {
        delete m_struct_indices; m_struct_indices = 0;
    }
}

gff_t::list_indices_array_t::list_indices_array_t(kaitai::kstream* p__io, gff_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::list_indices_array_t::_read() {
    m_raw_data = m__io->read_bytes(_root()->header()->list_indices_count());
}

gff_t::list_indices_array_t::~list_indices_array_t() {
    _clean_up();
}

void gff_t::list_indices_array_t::_clean_up() {
}

gff_t::resolved_field_t::resolved_field_t(uint32_t p_field_index, kaitai::kstream* p__io, gff_t::resolved_struct_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_field_index = p_field_index;
    m_entry = 0;
    m_label = 0;
    m_list_entry = 0;
    m_list_structs = 0;
    m_value_binary = 0;
    m_value_localized_string = 0;
    m_value_resref = 0;
    m_value_string = 0;
    m_value_struct = 0;
    m_value_vector3 = 0;
    m_value_vector4 = 0;
    f_entry = false;
    f_field_entry_pos = false;
    f_label = false;
    f_list_entry = false;
    f_list_structs = false;
    f_value_binary = false;
    f_value_double = false;
    f_value_int16 = false;
    f_value_int32 = false;
    f_value_int64 = false;
    f_value_int8 = false;
    f_value_localized_string = false;
    f_value_resref = false;
    f_value_single = false;
    f_value_str_ref = false;
    f_value_string = false;
    f_value_struct = false;
    f_value_uint16 = false;
    f_value_uint32 = false;
    f_value_uint64 = false;
    f_value_uint8 = false;
    f_value_vector3 = false;
    f_value_vector4 = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::resolved_field_t::_read() {
}

gff_t::resolved_field_t::~resolved_field_t() {
    _clean_up();
}

void gff_t::resolved_field_t::_clean_up() {
    if (f_entry) {
        if (m_entry) {
            delete m_entry; m_entry = 0;
        }
    }
    if (f_label) {
        if (m_label) {
            delete m_label; m_label = 0;
        }
    }
    if (f_list_entry && !n_list_entry) {
        if (m_list_entry) {
            delete m_list_entry; m_list_entry = 0;
        }
    }
    if (f_list_structs && !n_list_structs) {
        if (m_list_structs) {
            for (std::vector<resolved_struct_t*>::iterator it = m_list_structs->begin(); it != m_list_structs->end(); ++it) {
                delete *it;
            }
            delete m_list_structs; m_list_structs = 0;
        }
    }
    if (f_value_binary && !n_value_binary) {
        if (m_value_binary) {
            delete m_value_binary; m_value_binary = 0;
        }
    }
    if (f_value_double && !n_value_double) {
    }
    if (f_value_int16 && !n_value_int16) {
    }
    if (f_value_int32 && !n_value_int32) {
    }
    if (f_value_int64 && !n_value_int64) {
    }
    if (f_value_int8 && !n_value_int8) {
    }
    if (f_value_localized_string && !n_value_localized_string) {
        if (m_value_localized_string) {
            delete m_value_localized_string; m_value_localized_string = 0;
        }
    }
    if (f_value_resref && !n_value_resref) {
        if (m_value_resref) {
            delete m_value_resref; m_value_resref = 0;
        }
    }
    if (f_value_single && !n_value_single) {
    }
    if (f_value_str_ref && !n_value_str_ref) {
    }
    if (f_value_string && !n_value_string) {
        if (m_value_string) {
            delete m_value_string; m_value_string = 0;
        }
    }
    if (f_value_struct && !n_value_struct) {
        if (m_value_struct) {
            delete m_value_struct; m_value_struct = 0;
        }
    }
    if (f_value_uint16 && !n_value_uint16) {
    }
    if (f_value_uint32 && !n_value_uint32) {
    }
    if (f_value_uint64 && !n_value_uint64) {
    }
    if (f_value_uint8 && !n_value_uint8) {
    }
    if (f_value_vector3 && !n_value_vector3) {
        if (m_value_vector3) {
            delete m_value_vector3; m_value_vector3 = 0;
        }
    }
    if (f_value_vector4 && !n_value_vector4) {
        if (m_value_vector4) {
            delete m_value_vector4; m_value_vector4 = 0;
        }
    }
}

gff_t::field_entry_t* gff_t::resolved_field_t::entry() {
    if (f_entry)
        return m_entry;
    f_entry = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(_root()->header()->field_offset() + field_index() * 12);
    m_entry = new field_entry_t(m__io, this, m__root);
    m__io->seek(_pos);
    return m_entry;
}

int32_t gff_t::resolved_field_t::field_entry_pos() {
    if (f_field_entry_pos)
        return m_field_entry_pos;
    f_field_entry_pos = true;
    m_field_entry_pos = _root()->header()->field_offset() + field_index() * 12;
    return m_field_entry_pos;
}

gff_t::label_entry_terminated_t* gff_t::resolved_field_t::label() {
    if (f_label)
        return m_label;
    f_label = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(_root()->header()->label_offset() + entry()->label_index() * 16);
    m_label = new label_entry_terminated_t(m__io, this, m__root);
    m__io->seek(_pos);
    return m_label;
}

gff_t::list_entry_t* gff_t::resolved_field_t::list_entry() {
    if (f_list_entry)
        return m_list_entry;
    f_list_entry = true;
    n_list_entry = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_LIST) {
        n_list_entry = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->list_indices_offset() + entry()->data_or_offset());
        m_list_entry = new list_entry_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_list_entry;
}

std::vector<gff_t::resolved_struct_t*>* gff_t::resolved_field_t::list_structs() {
    if (f_list_structs)
        return m_list_structs;
    f_list_structs = true;
    n_list_structs = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_LIST) {
        n_list_structs = false;
        m_list_structs = new std::vector<resolved_struct_t*>();
        const int l_list_structs = list_entry()->num_struct_indices();
        for (int i = 0; i < l_list_structs; i++) {
            m_list_structs->push_back(new resolved_struct_t(list_entry()->struct_indices()->at(i), m__io, this, m__root));
        }
    }
    return m_list_structs;
}

bioware_common_t::bioware_binary_data_t* gff_t::resolved_field_t::value_binary() {
    if (f_value_binary)
        return m_value_binary;
    f_value_binary = true;
    n_value_binary = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_BINARY) {
        n_value_binary = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_data_offset() + entry()->data_or_offset());
        m_value_binary = new bioware_common_t::bioware_binary_data_t(m__io);
        m__io->seek(_pos);
    }
    return m_value_binary;
}

double gff_t::resolved_field_t::value_double() {
    if (f_value_double)
        return m_value_double;
    f_value_double = true;
    n_value_double = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_DOUBLE) {
        n_value_double = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_data_offset() + entry()->data_or_offset());
        m_value_double = m__io->read_f8le();
        m__io->seek(_pos);
    }
    return m_value_double;
}

int16_t gff_t::resolved_field_t::value_int16() {
    if (f_value_int16)
        return m_value_int16;
    f_value_int16 = true;
    n_value_int16 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_INT16) {
        n_value_int16 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(field_entry_pos() + 8);
        m_value_int16 = m__io->read_s2le();
        m__io->seek(_pos);
    }
    return m_value_int16;
}

int32_t gff_t::resolved_field_t::value_int32() {
    if (f_value_int32)
        return m_value_int32;
    f_value_int32 = true;
    n_value_int32 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_INT32) {
        n_value_int32 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(field_entry_pos() + 8);
        m_value_int32 = m__io->read_s4le();
        m__io->seek(_pos);
    }
    return m_value_int32;
}

int64_t gff_t::resolved_field_t::value_int64() {
    if (f_value_int64)
        return m_value_int64;
    f_value_int64 = true;
    n_value_int64 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_INT64) {
        n_value_int64 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_data_offset() + entry()->data_or_offset());
        m_value_int64 = m__io->read_s8le();
        m__io->seek(_pos);
    }
    return m_value_int64;
}

int8_t gff_t::resolved_field_t::value_int8() {
    if (f_value_int8)
        return m_value_int8;
    f_value_int8 = true;
    n_value_int8 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_INT8) {
        n_value_int8 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(field_entry_pos() + 8);
        m_value_int8 = m__io->read_s1();
        m__io->seek(_pos);
    }
    return m_value_int8;
}

bioware_common_t::bioware_locstring_t* gff_t::resolved_field_t::value_localized_string() {
    if (f_value_localized_string)
        return m_value_localized_string;
    f_value_localized_string = true;
    n_value_localized_string = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_LOCALIZED_STRING) {
        n_value_localized_string = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_data_offset() + entry()->data_or_offset());
        m_value_localized_string = new bioware_common_t::bioware_locstring_t(m__io);
        m__io->seek(_pos);
    }
    return m_value_localized_string;
}

bioware_common_t::bioware_resref_t* gff_t::resolved_field_t::value_resref() {
    if (f_value_resref)
        return m_value_resref;
    f_value_resref = true;
    n_value_resref = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_RESREF) {
        n_value_resref = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_data_offset() + entry()->data_or_offset());
        m_value_resref = new bioware_common_t::bioware_resref_t(m__io);
        m__io->seek(_pos);
    }
    return m_value_resref;
}

float gff_t::resolved_field_t::value_single() {
    if (f_value_single)
        return m_value_single;
    f_value_single = true;
    n_value_single = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_SINGLE) {
        n_value_single = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(field_entry_pos() + 8);
        m_value_single = m__io->read_f4le();
        m__io->seek(_pos);
    }
    return m_value_single;
}

uint32_t gff_t::resolved_field_t::value_str_ref() {
    if (f_value_str_ref)
        return m_value_str_ref;
    f_value_str_ref = true;
    n_value_str_ref = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_STR_REF) {
        n_value_str_ref = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(field_entry_pos() + 8);
        m_value_str_ref = m__io->read_u4le();
        m__io->seek(_pos);
    }
    return m_value_str_ref;
}

bioware_common_t::bioware_cexo_string_t* gff_t::resolved_field_t::value_string() {
    if (f_value_string)
        return m_value_string;
    f_value_string = true;
    n_value_string = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_STRING) {
        n_value_string = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_data_offset() + entry()->data_or_offset());
        m_value_string = new bioware_common_t::bioware_cexo_string_t(m__io);
        m__io->seek(_pos);
    }
    return m_value_string;
}

gff_t::resolved_struct_t* gff_t::resolved_field_t::value_struct() {
    if (f_value_struct)
        return m_value_struct;
    f_value_struct = true;
    n_value_struct = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_STRUCT) {
        n_value_struct = false;
        m_value_struct = new resolved_struct_t(entry()->data_or_offset(), m__io, this, m__root);
    }
    return m_value_struct;
}

uint16_t gff_t::resolved_field_t::value_uint16() {
    if (f_value_uint16)
        return m_value_uint16;
    f_value_uint16 = true;
    n_value_uint16 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_UINT16) {
        n_value_uint16 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(field_entry_pos() + 8);
        m_value_uint16 = m__io->read_u2le();
        m__io->seek(_pos);
    }
    return m_value_uint16;
}

uint32_t gff_t::resolved_field_t::value_uint32() {
    if (f_value_uint32)
        return m_value_uint32;
    f_value_uint32 = true;
    n_value_uint32 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_UINT32) {
        n_value_uint32 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(field_entry_pos() + 8);
        m_value_uint32 = m__io->read_u4le();
        m__io->seek(_pos);
    }
    return m_value_uint32;
}

uint64_t gff_t::resolved_field_t::value_uint64() {
    if (f_value_uint64)
        return m_value_uint64;
    f_value_uint64 = true;
    n_value_uint64 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_UINT64) {
        n_value_uint64 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_data_offset() + entry()->data_or_offset());
        m_value_uint64 = m__io->read_u8le();
        m__io->seek(_pos);
    }
    return m_value_uint64;
}

uint8_t gff_t::resolved_field_t::value_uint8() {
    if (f_value_uint8)
        return m_value_uint8;
    f_value_uint8 = true;
    n_value_uint8 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_UINT8) {
        n_value_uint8 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(field_entry_pos() + 8);
        m_value_uint8 = m__io->read_u1();
        m__io->seek(_pos);
    }
    return m_value_uint8;
}

bioware_common_t::bioware_vector3_t* gff_t::resolved_field_t::value_vector3() {
    if (f_value_vector3)
        return m_value_vector3;
    f_value_vector3 = true;
    n_value_vector3 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_VECTOR3) {
        n_value_vector3 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_data_offset() + entry()->data_or_offset());
        m_value_vector3 = new bioware_common_t::bioware_vector3_t(m__io);
        m__io->seek(_pos);
    }
    return m_value_vector3;
}

bioware_common_t::bioware_vector4_t* gff_t::resolved_field_t::value_vector4() {
    if (f_value_vector4)
        return m_value_vector4;
    f_value_vector4 = true;
    n_value_vector4 = true;
    if (entry()->field_type() == gff_t::GFF_FIELD_TYPE_VECTOR4) {
        n_value_vector4 = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_data_offset() + entry()->data_or_offset());
        m_value_vector4 = new bioware_common_t::bioware_vector4_t(m__io);
        m__io->seek(_pos);
    }
    return m_value_vector4;
}

gff_t::resolved_struct_t::resolved_struct_t(uint32_t p_struct_index, kaitai::kstream* p__io, kaitai::kstruct* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_struct_index = p_struct_index;
    m_entry = 0;
    m_field_indices = 0;
    m_fields = 0;
    m_single_field = 0;
    f_entry = false;
    f_field_indices = false;
    f_fields = false;
    f_single_field = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::resolved_struct_t::_read() {
}

gff_t::resolved_struct_t::~resolved_struct_t() {
    _clean_up();
}

void gff_t::resolved_struct_t::_clean_up() {
    if (f_entry) {
        if (m_entry) {
            delete m_entry; m_entry = 0;
        }
    }
    if (f_field_indices && !n_field_indices) {
        if (m_field_indices) {
            delete m_field_indices; m_field_indices = 0;
        }
    }
    if (f_fields && !n_fields) {
        if (m_fields) {
            for (std::vector<resolved_field_t*>::iterator it = m_fields->begin(); it != m_fields->end(); ++it) {
                delete *it;
            }
            delete m_fields; m_fields = 0;
        }
    }
    if (f_single_field && !n_single_field) {
        if (m_single_field) {
            delete m_single_field; m_single_field = 0;
        }
    }
}

gff_t::struct_entry_t* gff_t::resolved_struct_t::entry() {
    if (f_entry)
        return m_entry;
    f_entry = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(_root()->header()->struct_offset() + struct_index() * 12);
    m_entry = new struct_entry_t(m__io, this, m__root);
    m__io->seek(_pos);
    return m_entry;
}

std::vector<uint32_t>* gff_t::resolved_struct_t::field_indices() {
    if (f_field_indices)
        return m_field_indices;
    f_field_indices = true;
    n_field_indices = true;
    if (entry()->field_count() > 1) {
        n_field_indices = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->header()->field_indices_offset() + entry()->data_or_offset());
        m_field_indices = new std::vector<uint32_t>();
        const int l_field_indices = entry()->field_count();
        for (int i = 0; i < l_field_indices; i++) {
            m_field_indices->push_back(m__io->read_u4le());
        }
        m__io->seek(_pos);
    }
    return m_field_indices;
}

std::vector<gff_t::resolved_field_t*>* gff_t::resolved_struct_t::fields() {
    if (f_fields)
        return m_fields;
    f_fields = true;
    n_fields = true;
    if (entry()->field_count() > 1) {
        n_fields = false;
        m_fields = new std::vector<resolved_field_t*>();
        const int l_fields = entry()->field_count();
        for (int i = 0; i < l_fields; i++) {
            m_fields->push_back(new resolved_field_t(field_indices()->at(i), m__io, this, m__root));
        }
    }
    return m_fields;
}

gff_t::resolved_field_t* gff_t::resolved_struct_t::single_field() {
    if (f_single_field)
        return m_single_field;
    f_single_field = true;
    n_single_field = true;
    if (entry()->field_count() == 1) {
        n_single_field = false;
        m_single_field = new resolved_field_t(entry()->data_or_offset(), m__io, this, m__root);
    }
    return m_single_field;
}

gff_t::struct_array_t::struct_array_t(kaitai::kstream* p__io, gff_t* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_entries = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::struct_array_t::_read() {
    m_entries = new std::vector<struct_entry_t*>();
    const int l_entries = _root()->header()->struct_count();
    for (int i = 0; i < l_entries; i++) {
        m_entries->push_back(new struct_entry_t(m__io, this, m__root));
    }
}

gff_t::struct_array_t::~struct_array_t() {
    _clean_up();
}

void gff_t::struct_array_t::_clean_up() {
    if (m_entries) {
        for (std::vector<struct_entry_t*>::iterator it = m_entries->begin(); it != m_entries->end(); ++it) {
            delete *it;
        }
        delete m_entries; m_entries = 0;
    }
}

gff_t::struct_entry_t::struct_entry_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, gff_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_field_indices_offset = false;
    f_has_multiple_fields = false;
    f_has_single_field = false;
    f_single_field_index = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void gff_t::struct_entry_t::_read() {
    m_struct_id = m__io->read_u4le();
    m_data_or_offset = m__io->read_u4le();
    m_field_count = m__io->read_u4le();
}

gff_t::struct_entry_t::~struct_entry_t() {
    _clean_up();
}

void gff_t::struct_entry_t::_clean_up() {
}

uint32_t gff_t::struct_entry_t::field_indices_offset() {
    if (f_field_indices_offset)
        return m_field_indices_offset;
    f_field_indices_offset = true;
    n_field_indices_offset = true;
    if (has_multiple_fields()) {
        n_field_indices_offset = false;
        m_field_indices_offset = data_or_offset();
    }
    return m_field_indices_offset;
}

bool gff_t::struct_entry_t::has_multiple_fields() {
    if (f_has_multiple_fields)
        return m_has_multiple_fields;
    f_has_multiple_fields = true;
    m_has_multiple_fields = field_count() > 1;
    return m_has_multiple_fields;
}

bool gff_t::struct_entry_t::has_single_field() {
    if (f_has_single_field)
        return m_has_single_field;
    f_has_single_field = true;
    m_has_single_field = field_count() == 1;
    return m_has_single_field;
}

uint32_t gff_t::struct_entry_t::single_field_index() {
    if (f_single_field_index)
        return m_single_field_index;
    f_single_field_index = true;
    n_single_field_index = true;
    if (has_single_field()) {
        n_single_field_index = false;
        m_single_field_index = data_or_offset();
    }
    return m_single_field_index;
}

gff_t::field_array_t* gff_t::field_array() {
    if (f_field_array)
        return m_field_array;
    f_field_array = true;
    n_field_array = true;
    if (header()->field_count() > 0) {
        n_field_array = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->field_offset());
        m_field_array = new field_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_field_array;
}

gff_t::field_data_t* gff_t::field_data() {
    if (f_field_data)
        return m_field_data;
    f_field_data = true;
    n_field_data = true;
    if (header()->field_data_count() > 0) {
        n_field_data = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->field_data_offset());
        m_field_data = new field_data_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_field_data;
}

gff_t::field_indices_array_t* gff_t::field_indices_array() {
    if (f_field_indices_array)
        return m_field_indices_array;
    f_field_indices_array = true;
    n_field_indices_array = true;
    if (header()->field_indices_count() > 0) {
        n_field_indices_array = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->field_indices_offset());
        m_field_indices_array = new field_indices_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_field_indices_array;
}

gff_t::label_array_t* gff_t::label_array() {
    if (f_label_array)
        return m_label_array;
    f_label_array = true;
    n_label_array = true;
    if (header()->label_count() > 0) {
        n_label_array = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->label_offset());
        m_label_array = new label_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_label_array;
}

gff_t::list_indices_array_t* gff_t::list_indices_array() {
    if (f_list_indices_array)
        return m_list_indices_array;
    f_list_indices_array = true;
    n_list_indices_array = true;
    if (header()->list_indices_count() > 0) {
        n_list_indices_array = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->list_indices_offset());
        m_list_indices_array = new list_indices_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_list_indices_array;
}

gff_t::resolved_struct_t* gff_t::root_struct_resolved() {
    if (f_root_struct_resolved)
        return m_root_struct_resolved;
    f_root_struct_resolved = true;
    m_root_struct_resolved = new resolved_struct_t(0, m__io, this, m__root);
    return m_root_struct_resolved;
}

gff_t::struct_array_t* gff_t::struct_array() {
    if (f_struct_array)
        return m_struct_array;
    f_struct_array = true;
    n_struct_array = true;
    if (header()->struct_count() > 0) {
        n_struct_array = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(header()->struct_offset());
        m_struct_array = new struct_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_struct_array;
}
