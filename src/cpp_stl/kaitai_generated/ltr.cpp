// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "ltr.h"

ltr_t::ltr_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, ltr_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_single_letter_block = 0;
    m_double_letter_blocks = 0;
    m_triple_letter_blocks = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void ltr_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_file_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_letter_count = static_cast<bioware_common_t::bioware_ltr_alphabet_length_t>(m__io->read_u1());
    m_single_letter_block = new letter_block_t(m__io, this, m__root);
    m_double_letter_blocks = new double_letter_blocks_array_t(m__io, this, m__root);
    m_triple_letter_blocks = new triple_letter_blocks_array_t(m__io, this, m__root);
}

ltr_t::~ltr_t() {
    _clean_up();
}

void ltr_t::_clean_up() {
    if (m_single_letter_block) {
        delete m_single_letter_block; m_single_letter_block = 0;
    }
    if (m_double_letter_blocks) {
        delete m_double_letter_blocks; m_double_letter_blocks = 0;
    }
    if (m_triple_letter_blocks) {
        delete m_triple_letter_blocks; m_triple_letter_blocks = 0;
    }
}

ltr_t::double_letter_blocks_array_t::double_letter_blocks_array_t(kaitai::kstream* p__io, ltr_t* p__parent, ltr_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_blocks = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void ltr_t::double_letter_blocks_array_t::_read() {
    m_blocks = new std::vector<letter_block_t*>();
    const int l_blocks = _root()->letter_count();
    for (int i = 0; i < l_blocks; i++) {
        m_blocks->push_back(new letter_block_t(m__io, this, m__root));
    }
}

ltr_t::double_letter_blocks_array_t::~double_letter_blocks_array_t() {
    _clean_up();
}

void ltr_t::double_letter_blocks_array_t::_clean_up() {
    if (m_blocks) {
        for (std::vector<letter_block_t*>::iterator it = m_blocks->begin(); it != m_blocks->end(); ++it) {
            delete *it;
        }
        delete m_blocks; m_blocks = 0;
    }
}

ltr_t::letter_block_t::letter_block_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, ltr_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_start_probabilities = 0;
    m_middle_probabilities = 0;
    m_end_probabilities = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void ltr_t::letter_block_t::_read() {
    m_start_probabilities = new std::vector<float>();
    const int l_start_probabilities = _root()->letter_count();
    for (int i = 0; i < l_start_probabilities; i++) {
        m_start_probabilities->push_back(m__io->read_f4le());
    }
    m_middle_probabilities = new std::vector<float>();
    const int l_middle_probabilities = _root()->letter_count();
    for (int i = 0; i < l_middle_probabilities; i++) {
        m_middle_probabilities->push_back(m__io->read_f4le());
    }
    m_end_probabilities = new std::vector<float>();
    const int l_end_probabilities = _root()->letter_count();
    for (int i = 0; i < l_end_probabilities; i++) {
        m_end_probabilities->push_back(m__io->read_f4le());
    }
}

ltr_t::letter_block_t::~letter_block_t() {
    _clean_up();
}

void ltr_t::letter_block_t::_clean_up() {
    if (m_start_probabilities) {
        delete m_start_probabilities; m_start_probabilities = 0;
    }
    if (m_middle_probabilities) {
        delete m_middle_probabilities; m_middle_probabilities = 0;
    }
    if (m_end_probabilities) {
        delete m_end_probabilities; m_end_probabilities = 0;
    }
}

ltr_t::triple_letter_blocks_array_t::triple_letter_blocks_array_t(kaitai::kstream* p__io, ltr_t* p__parent, ltr_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_rows = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void ltr_t::triple_letter_blocks_array_t::_read() {
    m_rows = new std::vector<triple_letter_row_t*>();
    const int l_rows = _root()->letter_count();
    for (int i = 0; i < l_rows; i++) {
        m_rows->push_back(new triple_letter_row_t(m__io, this, m__root));
    }
}

ltr_t::triple_letter_blocks_array_t::~triple_letter_blocks_array_t() {
    _clean_up();
}

void ltr_t::triple_letter_blocks_array_t::_clean_up() {
    if (m_rows) {
        for (std::vector<triple_letter_row_t*>::iterator it = m_rows->begin(); it != m_rows->end(); ++it) {
            delete *it;
        }
        delete m_rows; m_rows = 0;
    }
}

ltr_t::triple_letter_row_t::triple_letter_row_t(kaitai::kstream* p__io, ltr_t::triple_letter_blocks_array_t* p__parent, ltr_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_blocks = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void ltr_t::triple_letter_row_t::_read() {
    m_blocks = new std::vector<letter_block_t*>();
    const int l_blocks = _root()->letter_count();
    for (int i = 0; i < l_blocks; i++) {
        m_blocks->push_back(new letter_block_t(m__io, this, m__root));
    }
}

ltr_t::triple_letter_row_t::~triple_letter_row_t() {
    _clean_up();
}

void ltr_t::triple_letter_row_t::_clean_up() {
    if (m_blocks) {
        for (std::vector<letter_block_t*>::iterator it = m_blocks->begin(); it != m_blocks->end(); ++it) {
            delete *it;
        }
        delete m_blocks; m_blocks = 0;
    }
}
