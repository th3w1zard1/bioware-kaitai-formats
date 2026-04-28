<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
 * converts authoring TGAs to **TPC** for shipping.
 * 
 * Shared header enums: `formats/Common/tga_common.ksy`.
 */

namespace {
    class Tga extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Tga $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_idLength = $this->_io->readU1();
            $this->_m_colorMapType = $this->_io->readU1();
            $this->_m_imageType = $this->_io->readU1();
            if ($this->colorMapType() == \TgaCommon\TgaColorMapType::PRESENT) {
                $this->_m_colorMapSpec = new \Tga\ColorMapSpecification($this->_io, $this, $this->_root);
            }
            $this->_m_imageSpec = new \Tga\ImageSpecification($this->_io, $this, $this->_root);
            if ($this->idLength() > 0) {
                $this->_m_imageId = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes($this->idLength()), "ASCII");
            }
            if ($this->colorMapType() == \TgaCommon\TgaColorMapType::PRESENT) {
                $this->_m_colorMapData = [];
                $n = $this->colorMapSpec()->length();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_colorMapData[] = $this->_io->readU1();
                }
            }
            $this->_m_imageData = [];
            $i = 0;
            while (!$this->_io->isEof()) {
                $this->_m_imageData[] = $this->_io->readU1();
                $i++;
            }
        }
        protected $_m_idLength;
        protected $_m_colorMapType;
        protected $_m_imageType;
        protected $_m_colorMapSpec;
        protected $_m_imageSpec;
        protected $_m_imageId;
        protected $_m_colorMapData;
        protected $_m_imageData;

        /**
         * Length of image ID field (0-255 bytes)
         */
        public function idLength() { return $this->_m_idLength; }

        /**
         * Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.
         */
        public function colorMapType() { return $this->_m_colorMapType; }

        /**
         * Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.
         */
        public function imageType() { return $this->_m_imageType; }

        /**
         * Color map specification (only present if color_map_type == present)
         */
        public function colorMapSpec() { return $this->_m_colorMapSpec; }

        /**
         * Image specification (dimensions and pixel format)
         */
        public function imageSpec() { return $this->_m_imageSpec; }

        /**
         * Image identification field (optional ASCII string)
         */
        public function imageId() { return $this->_m_imageId; }

        /**
         * Color map data (palette entries)
         */
        public function colorMapData() { return $this->_m_colorMapData; }

        /**
         * Image pixel data (raw or RLE-compressed).
         * Size depends on image dimensions, pixel format, and compression.
         * For uncompressed formats: width × height × bytes_per_pixel
         * For RLE formats: Variable size depending on compression ratio
         */
        public function imageData() { return $this->_m_imageData; }
    }
}

namespace Tga {
    class ColorMapSpecification extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Tga $_parent = null, ?\Tga $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_firstEntryIndex = $this->_io->readU2le();
            $this->_m_length = $this->_io->readU2le();
            $this->_m_entrySize = $this->_io->readU1();
        }
        protected $_m_firstEntryIndex;
        protected $_m_length;
        protected $_m_entrySize;

        /**
         * Index of first color map entry
         */
        public function firstEntryIndex() { return $this->_m_firstEntryIndex; }

        /**
         * Number of color map entries
         */
        public function length() { return $this->_m_length; }

        /**
         * Size of each color map entry in bits (15, 16, 24, or 32)
         */
        public function entrySize() { return $this->_m_entrySize; }
    }
}

namespace Tga {
    class ImageSpecification extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Tga $_parent = null, ?\Tga $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_xOrigin = $this->_io->readU2le();
            $this->_m_yOrigin = $this->_io->readU2le();
            $this->_m_width = $this->_io->readU2le();
            $this->_m_height = $this->_io->readU2le();
            $this->_m_pixelDepth = $this->_io->readU1();
            $this->_m_imageDescriptor = $this->_io->readU1();
        }
        protected $_m_xOrigin;
        protected $_m_yOrigin;
        protected $_m_width;
        protected $_m_height;
        protected $_m_pixelDepth;
        protected $_m_imageDescriptor;

        /**
         * X coordinate of lower-left corner of image
         */
        public function xOrigin() { return $this->_m_xOrigin; }

        /**
         * Y coordinate of lower-left corner of image
         */
        public function yOrigin() { return $this->_m_yOrigin; }

        /**
         * Image width in pixels
         */
        public function width() { return $this->_m_width; }

        /**
         * Image height in pixels
         */
        public function height() { return $this->_m_height; }

        /**
         * Bits per pixel:
         * - 8 = Greyscale or indexed
         * - 16 = RGB 5-5-5 or RGBA 1-5-5-5
         * - 24 = RGB
         * - 32 = RGBA
         */
        public function pixelDepth() { return $this->_m_pixelDepth; }

        /**
         * Image descriptor byte:
         * - Bits 0-3: Number of attribute bits per pixel (alpha channel)
         * - Bit 4: Reserved
         * - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
         * - Bits 6-7: Interleaving (usually 0)
         */
        public function imageDescriptor() { return $this->_m_imageDescriptor; }
    }
}
