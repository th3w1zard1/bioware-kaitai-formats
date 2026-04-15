<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **BTI** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
 * `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
 * `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.
 * 
 * FileType / restype id **2024** — see `bioware_type_ids::xoreos_file_type_id` enum member `bti`.
 */

namespace {
    class GffBti extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\GffBti $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_contents = new \Gff\GffUnionFile($this->_io);
        }
        protected $_m_contents;

        /**
         * Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per BTI template docs / PyKotor `gff_auto`.
         */
        public function contents() { return $this->_m_contents; }
    }
}
