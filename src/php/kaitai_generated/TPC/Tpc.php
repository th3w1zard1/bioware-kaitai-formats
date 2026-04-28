<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
 * (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
 * (`meta.xref`).
 */

namespace {
    class Tpc extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Tpc $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Tpc\TpcHeader($this->_io, $this, $this->_root);
            $this->_m_body = $this->_io->readBytesFull();
        }
        protected $_m_header;
        protected $_m_body;

        /**
         * TPC file header (128 bytes total)
         */
        public function header() { return $this->_m_header; }

        /**
         * Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).
         */
        public function body() { return $this->_m_body; }
    }
}

namespace Tpc {
    class TpcHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Tpc $_parent = null, ?\Tpc $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_dataSize = $this->_io->readU4le();
            $this->_m_alphaTest = $this->_io->readF4le();
            $this->_m_width = $this->_io->readU2le();
            $this->_m_height = $this->_io->readU2le();
            $this->_m_pixelEncoding = $this->_io->readU1();
            $this->_m_mipmapCount = $this->_io->readU1();
            $this->_m_reserved = [];
            $n = 114;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_reserved[] = $this->_io->readU1();
            }
        }
        protected $_m_isCompressed;

        /**
         * True if texture data is compressed (DXT format)
         */
        public function isCompressed() {
            if ($this->_m_isCompressed !== null)
                return $this->_m_isCompressed;
            $this->_m_isCompressed = $this->dataSize() != 0;
            return $this->_m_isCompressed;
        }
        protected $_m_isUncompressed;

        /**
         * True if texture data is uncompressed (raw pixels)
         */
        public function isUncompressed() {
            if ($this->_m_isUncompressed !== null)
                return $this->_m_isUncompressed;
            $this->_m_isUncompressed = $this->dataSize() == 0;
            return $this->_m_isUncompressed;
        }
        protected $_m_dataSize;
        protected $_m_alphaTest;
        protected $_m_width;
        protected $_m_height;
        protected $_m_pixelEncoding;
        protected $_m_mipmapCount;
        protected $_m_reserved;

        /**
         * Total compressed payload size. If non-zero, texture is compressed (DXT).
         * If zero, texture is uncompressed and size is derived from format/width/height.
         */
        public function dataSize() { return $this->_m_dataSize; }

        /**
         * Float threshold used by punch-through rendering.
         * Commonly 0.0 or 0.5.
         */
        public function alphaTest() { return $this->_m_alphaTest; }

        /**
         * Texture width in pixels (uint16).
         * Must be power-of-two for compressed formats.
         */
        public function width() { return $this->_m_width; }

        /**
         * Texture height in pixels (uint16).
         * For cube maps, this is 6x the face width.
         * Must be power-of-two for compressed formats.
         */
        public function height() { return $this->_m_height; }

        /**
         * Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
         * `bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).
         */
        public function pixelEncoding() { return $this->_m_pixelEncoding; }

        /**
         * Number of mip levels per layer (minimum 1).
         * Each mip level is half the size of the previous level.
         */
        public function mipmapCount() { return $this->_m_mipmapCount; }

        /**
         * Reserved/padding bytes (0x72 = 114 bytes).
         * KotOR stores platform hints here but all implementations skip them.
         */
        public function reserved() { return $this->_m_reserved; }
    }
}
