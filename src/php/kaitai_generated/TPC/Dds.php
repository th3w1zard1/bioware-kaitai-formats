<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
 * (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.
 * 
 * BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.
 */

namespace {
    class Dds extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Dds $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_magic = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!( (($this->_m_magic == "DDS ") || ($this->_m_magic == "    ")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_magic, $this->_io, "/seq/0");
            }
            if ($this->magic() == "DDS ") {
                $this->_m_header = new \Dds\DdsHeader($this->_io, $this, $this->_root);
            }
            if ($this->magic() != "DDS ") {
                $this->_m_biowareHeader = new \Dds\BiowareDdsHeader($this->_io, $this, $this->_root);
            }
            $this->_m_pixelData = $this->_io->readBytesFull();
        }
        protected $_m_magic;
        protected $_m_header;
        protected $_m_biowareHeader;
        protected $_m_pixelData;

        /**
         * File magic. Either "DDS " (0x44445320) for standard DDS,
         * or check for BioWare variant (no magic, starts with width/height).
         */
        public function magic() { return $this->_m_magic; }

        /**
         * Standard DDS header (124 bytes) - only present if magic is "DDS "
         */
        public function header() { return $this->_m_header; }

        /**
         * BioWare DDS variant header - only present if magic is not "DDS "
         */
        public function biowareHeader() { return $this->_m_biowareHeader; }

        /**
         * Pixel data (compressed or uncompressed); single blob to EOF.
         * For standard DDS: format determined by DDPIXELFORMAT.
         * For BioWare DDS: DXT1 or DXT5 compressed data.
         */
        public function pixelData() { return $this->_m_pixelData; }
    }
}

namespace Dds {
    class BiowareDdsHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Dds $_parent = null, ?\Dds $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_width = $this->_io->readU4le();
            $this->_m_height = $this->_io->readU4le();
            $this->_m_bytesPerPixel = $this->_io->readU4le();
            $this->_m_dataSize = $this->_io->readU4le();
            $this->_m_unusedFloat = $this->_io->readF4le();
        }
        protected $_m_width;
        protected $_m_height;
        protected $_m_bytesPerPixel;
        protected $_m_dataSize;
        protected $_m_unusedFloat;

        /**
         * Image width in pixels (must be power of two, < 0x8000)
         */
        public function width() { return $this->_m_width; }

        /**
         * Image height in pixels (must be power of two, < 0x8000)
         */
        public function height() { return $this->_m_height; }

        /**
         * BioWare variant "bytes per pixel" (`u4`): DXT1 vs DXT5 block stride hint. Canonical: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
         */
        public function bytesPerPixel() { return $this->_m_bytesPerPixel; }

        /**
         * Total compressed data size.
         * Must match (width*height)/2 for DXT1 or width*height for DXT5
         */
        public function dataSize() { return $this->_m_dataSize; }

        /**
         * Unused float field (typically 0.0)
         */
        public function unusedFloat() { return $this->_m_unusedFloat; }
    }
}

namespace Dds {
    class Ddpixelformat extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Dds\DdsHeader $_parent = null, ?\Dds $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_size = $this->_io->readU4le();
            if (!($this->_m_size == 32)) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError(32, $this->_m_size, $this->_io, "/types/ddpixelformat/seq/0");
            }
            $this->_m_flags = $this->_io->readU4le();
            $this->_m_fourcc = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_rgbBitCount = $this->_io->readU4le();
            $this->_m_rBitMask = $this->_io->readU4le();
            $this->_m_gBitMask = $this->_io->readU4le();
            $this->_m_bBitMask = $this->_io->readU4le();
            $this->_m_aBitMask = $this->_io->readU4le();
        }
        protected $_m_size;
        protected $_m_flags;
        protected $_m_fourcc;
        protected $_m_rgbBitCount;
        protected $_m_rBitMask;
        protected $_m_gBitMask;
        protected $_m_bBitMask;
        protected $_m_aBitMask;

        /**
         * Structure size (must be 32)
         */
        public function size() { return $this->_m_size; }

        /**
         * Pixel format flags:
         * - 0x00000001 = DDPF_ALPHAPIXELS
         * - 0x00000002 = DDPF_ALPHA
         * - 0x00000004 = DDPF_FOURCC
         * - 0x00000040 = DDPF_RGB
         * - 0x00000200 = DDPF_YUV
         * - 0x00080000 = DDPF_LUMINANCE
         */
        public function flags() { return $this->_m_flags; }

        /**
         * Four-character code for compressed formats:
         * - "DXT1" = DXT1 compression
         * - "DXT3" = DXT3 compression
         * - "DXT5" = DXT5 compression
         * - "    " = Uncompressed format
         */
        public function fourcc() { return $this->_m_fourcc; }

        /**
         * Bits per pixel for uncompressed formats (16, 24, or 32)
         */
        public function rgbBitCount() { return $this->_m_rgbBitCount; }

        /**
         * Red channel bit mask (for uncompressed formats)
         */
        public function rBitMask() { return $this->_m_rBitMask; }

        /**
         * Green channel bit mask (for uncompressed formats)
         */
        public function gBitMask() { return $this->_m_gBitMask; }

        /**
         * Blue channel bit mask (for uncompressed formats)
         */
        public function bBitMask() { return $this->_m_bBitMask; }

        /**
         * Alpha channel bit mask (for uncompressed formats)
         */
        public function aBitMask() { return $this->_m_aBitMask; }
    }
}

namespace Dds {
    class DdsHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Dds $_parent = null, ?\Dds $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_size = $this->_io->readU4le();
            if (!($this->_m_size == 124)) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError(124, $this->_m_size, $this->_io, "/types/dds_header/seq/0");
            }
            $this->_m_flags = $this->_io->readU4le();
            $this->_m_height = $this->_io->readU4le();
            $this->_m_width = $this->_io->readU4le();
            $this->_m_pitchOrLinearSize = $this->_io->readU4le();
            $this->_m_depth = $this->_io->readU4le();
            $this->_m_mipmapCount = $this->_io->readU4le();
            $this->_m_reserved1 = [];
            $n = 11;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_reserved1[] = $this->_io->readU4le();
            }
            $this->_m_pixelFormat = new \Dds\Ddpixelformat($this->_io, $this, $this->_root);
            $this->_m_caps = $this->_io->readU4le();
            $this->_m_caps2 = $this->_io->readU4le();
            $this->_m_caps3 = $this->_io->readU4le();
            $this->_m_caps4 = $this->_io->readU4le();
            $this->_m_reserved2 = $this->_io->readU4le();
        }
        protected $_m_size;
        protected $_m_flags;
        protected $_m_height;
        protected $_m_width;
        protected $_m_pitchOrLinearSize;
        protected $_m_depth;
        protected $_m_mipmapCount;
        protected $_m_reserved1;
        protected $_m_pixelFormat;
        protected $_m_caps;
        protected $_m_caps2;
        protected $_m_caps3;
        protected $_m_caps4;
        protected $_m_reserved2;

        /**
         * Header size (must be 124)
         */
        public function size() { return $this->_m_size; }

        /**
         * DDS flags bitfield:
         * - 0x00001007 = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT
         * - 0x00020000 = DDSD_MIPMAPCOUNT (if mipmaps present)
         */
        public function flags() { return $this->_m_flags; }

        /**
         * Image height in pixels
         */
        public function height() { return $this->_m_height; }

        /**
         * Image width in pixels
         */
        public function width() { return $this->_m_width; }

        /**
         * Pitch (uncompressed) or linear size (compressed).
         * For compressed formats: total size of all mip levels
         */
        public function pitchOrLinearSize() { return $this->_m_pitchOrLinearSize; }

        /**
         * Depth for volume textures (usually 0 for 2D textures)
         */
        public function depth() { return $this->_m_depth; }

        /**
         * Number of mipmap levels (0 or 1 = no mipmaps)
         */
        public function mipmapCount() { return $this->_m_mipmapCount; }

        /**
         * Reserved fields (unused)
         */
        public function reserved1() { return $this->_m_reserved1; }

        /**
         * Pixel format structure
         */
        public function pixelFormat() { return $this->_m_pixelFormat; }

        /**
         * Capability flags:
         * - 0x00001000 = DDSCAPS_TEXTURE
         * - 0x00000008 = DDSCAPS_MIPMAP
         * - 0x00000200 = DDSCAPS2_CUBEMAP
         */
        public function caps() { return $this->_m_caps; }

        /**
         * Additional capability flags:
         * - 0x00000200 = DDSCAPS2_CUBEMAP
         * - 0x00000FC00 = Cube map face flags
         */
        public function caps2() { return $this->_m_caps2; }

        /**
         * Reserved capability flags
         */
        public function caps3() { return $this->_m_caps3; }

        /**
         * Reserved capability flags
         */
        public function caps4() { return $this->_m_caps4; }

        /**
         * Reserved field
         */
        public function reserved2() { return $this->_m_reserved2; }
    }
}
