<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
 * Scripts run inside a stack-based virtual machine shared across Aurora engine games.
 * 
 * Format Structure:
 * - Header (13 bytes): Signature "NCS ", version "V1.0", size marker (0x42), file size
 * - Instruction Stream: Sequence of bytecode instructions
 * 
 * All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format - Complete NCS format documentation
 * - NSS.ksy - NWScript source code that compiles to NCS
 */

namespace {
    class Ncs extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Ncs $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_fileType == "NCS ")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("NCS ", $this->_m_fileType, $this->_io, "/seq/0");
            }
            $this->_m_fileVersion = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_fileVersion == "V1.0")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("V1.0", $this->_m_fileVersion, $this->_io, "/seq/1");
            }
            $this->_m_sizeMarker = $this->_io->readU1();
            if (!($this->_m_sizeMarker == 66)) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError(66, $this->_m_sizeMarker, $this->_io, "/seq/2");
            }
            $this->_m_fileSize = $this->_io->readU4be();
            $this->_m_instructions = [];
            $i = 0;
            do {
                $_ = new \Ncs\Instruction($this->_io, $this, $this->_root);
                $this->_m_instructions[] = $_;
                $i++;
            } while (!($this->_io()->pos() >= $this->fileSize()));
        }
        protected $_m_fileType;
        protected $_m_fileVersion;
        protected $_m_sizeMarker;
        protected $_m_fileSize;
        protected $_m_instructions;

        /**
         * File type signature. Must be "NCS " (0x4E 0x43 0x53 0x20).
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. Must be "V1.0" (0x56 0x31 0x2E 0x30).
         */
        public function fileVersion() { return $this->_m_fileVersion; }

        /**
         * Program size marker opcode. Must be 0x42.
         * This is not a real instruction but a metadata field containing the total file size.
         * All implementations validate this marker before parsing instructions.
         */
        public function sizeMarker() { return $this->_m_sizeMarker; }

        /**
         * Total file size in bytes (big-endian).
         * This value should match the actual file size.
         */
        public function fileSize() { return $this->_m_fileSize; }

        /**
         * Stream of bytecode instructions.
         * Execution begins at offset 13 (0x0D) after the header.
         * Instructions continue until end of file.
         */
        public function instructions() { return $this->_m_instructions; }
    }
}

/**
 * NWScript bytecode instruction.
 * Format: <opcode: uint8> <qualifier: uint8> <arguments: variable>
 * 
 * Instruction size varies by opcode:
 * - Base: 2 bytes (opcode + qualifier)
 * - Arguments: 0 to variable bytes depending on instruction type
 * 
 * Common instruction types:
 * - Constants: CONSTI (6B), CONSTF (6B), CONSTS (2+N B), CONSTO (6B)
 * - Stack ops: CPDOWNSP, CPTOPSP, MOVSP (variable size)
 * - Arithmetic: ADDxx, SUBxx, MULxx, DIVxx (2B)
 * - Control flow: JMP, JSR, JZ, JNZ (6B), RETN (2B)
 * - Function calls: ACTION (5B)
 * - And many more (see NCS format documentation)
 */

namespace Ncs {
    class Instruction extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Ncs $_parent = null, ?\Ncs $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_opcode = $this->_io->readU1();
            $this->_m_qualifier = $this->_io->readU1();
            $this->_m_arguments = [];
            $i = 0;
            do {
                $_ = $this->_io->readU1();
                $this->_m_arguments[] = $_;
                $i++;
            } while (!($this->_io()->pos() >= $this->_io()->size()));
        }
        protected $_m_opcode;
        protected $_m_qualifier;
        protected $_m_arguments;

        /**
         * Instruction opcode (0x01-0x2D, excluding 0x42 which is reserved for size marker).
         * Determines the instruction type and argument format.
         */
        public function opcode() { return $this->_m_opcode; }

        /**
         * Qualifier byte that refines the instruction to specific operand types.
         * Examples: 0x03=Int, 0x04=Float, 0x05=String, 0x06=Object, 0x24=Structure
         */
        public function qualifier() { return $this->_m_qualifier; }

        /**
         * Instruction arguments (variable size).
         * Format depends on opcode:
         * - No args: None (total 2B)
         * - Int/Float/Object: 4 bytes (total 6B)
         * - String: 2B length + data (total 2+N B)
         * - Jump: 4B signed offset (total 6B)
         * - Stack copy: 4B offset + 2B size (total 8B)
         * - ACTION: 2B routine + 1B argCount (total 5B)
         * - DESTRUCT: 2B size + 2B offset + 2B sizeNoDestroy (total 8B)
         * - STORE_STATE: 4B size + 4B sizeLocals (total 10B)
         * - And others (see documentation)
         */
        public function arguments() { return $this->_m_arguments; }
    }
}
