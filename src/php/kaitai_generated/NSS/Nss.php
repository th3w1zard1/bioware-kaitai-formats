<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

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
 */

namespace {
    class Nss extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Nss $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            if ($this->_io()->pos() == 0) {
                $this->_m_bom = $this->_io->readU2le();
                if (!( (($this->_m_bom == 65279) || ($this->_m_bom == 0)) )) {
                    throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_bom, $this->_io, "/seq/0");
                }
            }
            $this->_m_sourceCode = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesFull(), "UTF-8");
        }
        protected $_m_bom;
        protected $_m_sourceCode;

        /**
         * Optional UTF-8 BOM (Byte Order Mark) at the start of the file.
         * If present, will be 0xFEFF (UTF-8 BOM).
         * Most NSS files do not include a BOM.
         */
        public function bom() { return $this->_m_bom; }

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
        public function sourceCode() { return $this->_m_sourceCode; }
    }
}

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

namespace Nss {
    class NssSource extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Nss $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_content = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesFull(), "UTF-8");
        }
        protected $_m_content;

        /**
         * Complete source code content.
         */
        public function content() { return $this->_m_content; }
    }
}
