<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **TXB2** (`kFileTypeTXB2` **3017**): second-generation TXB id in `types.h`; treated like **TXB** / **TPC** by engine
 * texture stacks. This capsule mirrors `TXB.ksy` (TPC header + opaque tail) until a divergent wire is proven.
 */

namespace {
    class Txb2 extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Txb2 $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Tpc\TpcHeader($this->_io);
            $this->_m_body = $this->_io->readBytesFull();
        }
        protected $_m_header;
        protected $_m_body;
        public function header() { return $this->_m_header; }
        public function body() { return $this->_m_body; }
    }
}
