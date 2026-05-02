<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
 * (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
 * 
 * G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
 * 
 * **reone:** not applicable for GDA wire ingestion on the KotOR fork (`meta.xref.reone_gda_consumer_note`).
 */

namespace {
    class Gda extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Gda $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_asGff4 = new \Gff\Gff4File($this->_io);
        }
        protected $_m_asGff4;

        /**
         * On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
         * (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).
         */
        public function asGff4() { return $this->_m_asGff4; }
    }
}
