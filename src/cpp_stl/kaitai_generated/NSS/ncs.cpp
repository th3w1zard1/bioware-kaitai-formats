// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "ncs.h"
#include "kaitai/exceptions.h"

ncs_t::ncs_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, ncs_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_instructions = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void ncs_t::_read() {
    m_file_type = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_type == std::string("NCS "))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("NCS "), m_file_type, m__io, std::string("/seq/0"));
    }
    m_file_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_file_version == std::string("V1.0"))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("V1.0"), m_file_version, m__io, std::string("/seq/1"));
    }
    m_size_marker = m__io->read_u1();
    if (!(m_size_marker == 66)) {
        throw kaitai::validation_not_equal_error<uint8_t>(66, m_size_marker, m__io, std::string("/seq/2"));
    }
    m_file_size = m__io->read_u4be();
    m_instructions = new std::vector<instruction_t*>();
    {
        int i = 0;
        instruction_t* _;
        do {
            _ = new instruction_t(m__io, this, m__root);
            m_instructions->push_back(_);
            i++;
        } while (!(_io()->pos() >= file_size()));
    }
}

ncs_t::~ncs_t() {
    _clean_up();
}

void ncs_t::_clean_up() {
    if (m_instructions) {
        for (std::vector<instruction_t*>::iterator it = m_instructions->begin(); it != m_instructions->end(); ++it) {
            delete *it;
        }
        delete m_instructions; m_instructions = 0;
    }
}

ncs_t::instruction_t::instruction_t(kaitai::kstream* p__io, ncs_t* p__parent, ncs_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_arguments = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void ncs_t::instruction_t::_read() {
    m_opcode = static_cast<bioware_ncs_common_t::ncs_bytecode_t>(m__io->read_u1());
    m_qualifier = static_cast<bioware_ncs_common_t::ncs_instruction_qualifier_t>(m__io->read_u1());
    m_arguments = new std::vector<uint8_t>();
    {
        int i = 0;
        uint8_t _;
        do {
            _ = m__io->read_u1();
            m_arguments->push_back(_);
            i++;
        } while (!(_io()->pos() >= _io()->size()));
    }
}

ncs_t::instruction_t::~instruction_t() {
    _clean_up();
}

void ncs_t::instruction_t::_clean_up() {
    if (m_arguments) {
        delete m_arguments; m_arguments = 0;
    }
}
