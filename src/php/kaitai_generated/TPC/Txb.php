<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
 * (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.
 * 
 * This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
 * variant diverges, split a dedicated header type and cite **observed behavior** / tooling evidence (`TODO: VERIFY`).
 */

namespace {
    class Txb extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Txb $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Tpc\TpcHeader($this->_io);
            $this->_m_body = $this->_io->readBytesFull();
        }
        protected $_m_header;
        protected $_m_body;

        /**
         * Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
         */
        public function header() { return $this->_m_header; }

        /**
         * Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.
         */
        public function body() { return $this->_m_body; }
    }
}
