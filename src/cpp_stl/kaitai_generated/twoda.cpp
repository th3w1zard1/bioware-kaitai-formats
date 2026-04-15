// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "twoda.h"

twoda_t::twoda_t(uint32_t p_column_count, kaitai::kstream* p__io, kaitai::kstruct* p__parent, twoda_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_column_count = p_column_count;
    m_header = 0;
    m_row_labels_section = 0;
    m_cell_offsets = 0;
    m_cell_values_section = 0;
    m__io__raw_cell_values_section = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void twoda_t::_read() {
    m_header = new twoda_header_t(m__io, this, m__root);
    m_column_headers_raw = kaitai::kstream::bytes_to_str(m__io->read_bytes_term(0, false, true, true), "ASCII");
    m_row_count = m__io->read_u4le();
    m_row_labels_section = new row_labels_section_t(m__io, this, m__root);
    m_cell_offsets = new std::vector<uint16_t>();
    const int l_cell_offsets = row_count() * column_count();
    for (int i = 0; i < l_cell_offsets; i++) {
        m_cell_offsets->push_back(m__io->read_u2le());
    }
    m_len_cell_values_section = m__io->read_u2le();
    m__raw_cell_values_section = m__io->read_bytes(len_cell_values_section());
    m__io__raw_cell_values_section = new kaitai::kstream(m__raw_cell_values_section);
    m_cell_values_section = new cell_values_section_t(m__io__raw_cell_values_section, this, m__root);
}

twoda_t::~twoda_t() {
    _clean_up();
}

void twoda_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
    if (m_row_labels_section) {
        delete m_row_labels_section; m_row_labels_section = 0;
    }
    if (m_cell_offsets) {
        delete m_cell_offsets; m_cell_offsets = 0;
    }
    if (m__io__raw_cell_values_section) {
        delete m__io__raw_cell_values_section; m__io__raw_cell_values_section = 0;
    }
    if (m_cell_values_section) {
        delete m_cell_values_section; m_cell_values_section = 0;
    }
}

twoda_t::cell_values_section_t::cell_values_section_t(kaitai::kstream* p__io, twoda_t* p__parent, twoda_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void twoda_t::cell_values_section_t::_read() {
    m_raw_data = kaitai::kstream::bytes_to_str(m__io->read_bytes(_root()->len_cell_values_section()), "ASCII");
}

twoda_t::cell_values_section_t::~cell_values_section_t() {
    _clean_up();
}

void twoda_t::cell_values_section_t::_clean_up() {
}

twoda_t::row_label_entry_t::row_label_entry_t(kaitai::kstream* p__io, twoda_t::row_labels_section_t* p__parent, twoda_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void twoda_t::row_label_entry_t::_read() {
    m_label_value = kaitai::kstream::bytes_to_str(m__io->read_bytes_term(9, false, true, false), "ASCII");
}

twoda_t::row_label_entry_t::~row_label_entry_t() {
    _clean_up();
}

void twoda_t::row_label_entry_t::_clean_up() {
}

twoda_t::row_labels_section_t::row_labels_section_t(kaitai::kstream* p__io, twoda_t* p__parent, twoda_t* p__root) : kaitai::kstruct(p__io) {
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

void twoda_t::row_labels_section_t::_read() {
    m_labels = new std::vector<row_label_entry_t*>();
    const int l_labels = _root()->row_count();
    for (int i = 0; i < l_labels; i++) {
        m_labels->push_back(new row_label_entry_t(m__io, this, m__root));
    }
}

twoda_t::row_labels_section_t::~row_labels_section_t() {
    _clean_up();
}

void twoda_t::row_labels_section_t::_clean_up() {
    if (m_labels) {
        for (std::vector<row_label_entry_t*>::iterator it = m_labels->begin(); it != m_labels->end(); ++it) {
            delete *it;
        }
        delete m_labels; m_labels = 0;
    }
}

twoda_t::twoda_header_t::twoda_header_t(kaitai::kstream* p__io, twoda_t* p__parent, twoda_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_is_valid_twoda = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void twoda_t::twoda_header_t::_read() {
    m_magic = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_newline = m__io->read_u1();
}

twoda_t::twoda_header_t::~twoda_header_t() {
    _clean_up();
}

void twoda_t::twoda_header_t::_clean_up() {
}

bool twoda_t::twoda_header_t::is_valid_twoda() {
    if (f_is_valid_twoda)
        return m_is_valid_twoda;
    f_is_valid_twoda = true;
    m_is_valid_twoda =  ((magic() == std::string("2DA ")) && (version() == std::string("V2.b")) && (newline() == 10)) ;
    return m_is_valid_twoda;
}
