<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
 * framed wire lives in `LIP.ksy`.
 * 
 * **TODO: VERIFY** full BIP layout against Odyssey Ghidra (`user-agdec-http`) and PyKotor; until then this spec
 * exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.
 */

namespace {
    class Bip extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Bip $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_payload = $this->_io->readBytesFull();
        }
        protected $_m_payload;

        /**
         * Opaque binary LIP payload — replace with structured fields after verification.
         */
        public function payload() { return $this->_m_payload; }
    }
}
