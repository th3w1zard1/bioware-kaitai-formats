<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
 * mobile KotOR ports.
 */

namespace {
    class Bzf extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Bzf $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_fileType == "BZF ")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("BZF ", $this->_m_fileType, $this->_io, "/seq/0");
            }
            $this->_m_version = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_version == "V1.0")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("V1.0", $this->_m_version, $this->_io, "/seq/1");
            }
            $this->_m_compressedData = $this->_io->readBytesFull();
        }
        protected $_m_fileType;
        protected $_m_version;
        protected $_m_compressedData;

        /**
         * File type signature. Must be "BZF " for compressed BIF files.
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. Always "V1.0" for BZF files.
         */
        public function version() { return $this->_m_version; }

        /**
         * LZMA-compressed BIF file data (single blob to EOF).
         * Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).
         */
        public function compressedData() { return $this->_m_compressedData; }
    }
}
