<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
 * palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
 * that reference external palette files, enabling dynamic color customization for character models
 * (skin, hair, armor colors, etc.).
 * 
 * **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
 * resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
 * does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
 * including character models. This documentation is provided for reference only.
 * 
 * **reone:** the KotOR-focused fork does not ship a standalone PLT body reader; see `meta.xref.reone_resource_type_plt_note` for the numeric `Plt` type id only.
 * 
 * Binary Format Structure:
 * - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
 * - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)
 * 
 * Palette System:
 * PLT files work in conjunction with external palette files (.pal files) that contain the actual
 * color values. The PLT file itself stores:
 * 1. Palette Group index (0-9): Which palette group to use for each pixel
 * 2. Color index (0-255): Which color within the selected palette to use
 * 
 * At runtime, the game:
 * 1. Loads the appropriate palette file for the selected palette group
 * 2. Uses the palette index (supplied by the content creator) to select a row in the palette file
 * 3. Uses the color index from the PLT file to retrieve the final color value
 * 
 * Palette Groups (10 total):
 * 0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
 * 6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L374-L380 PyKotor — `ResourceType.PLT`
 * - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
 * - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`
 */

namespace {
    class Plt extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Plt $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Plt\PltHeader($this->_io, $this, $this->_root);
            $this->_m_pixelData = new \Plt\PixelDataSection($this->_io, $this, $this->_root);
        }
        protected $_m_header;
        protected $_m_pixelData;

        /**
         * PLT file header (24 bytes)
         */
        public function header() { return $this->_m_header; }

        /**
         * Array of pixel entries (width × height entries, 2 bytes each)
         */
        public function pixelData() { return $this->_m_pixelData; }
    }
}

namespace Plt {
    class PixelDataSection extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Plt $_parent = null, ?\Plt $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_pixels = [];
            $n = $this->_root()->header()->width() * $this->_root()->header()->height();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_pixels[] = new \Plt\PltPixel($this->_io, $this, $this->_root);
            }
        }
        protected $_m_pixels;

        /**
         * Array of pixel entries, stored row by row, left to right, top to bottom.
         * Total size = width × height × 2 bytes.
         * Each pixel entry contains a color index and palette group index.
         */
        public function pixels() { return $this->_m_pixels; }
    }
}

namespace Plt {
    class PltHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Plt $_parent = null, ?\Plt $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_signature = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_signature == "PLT ")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("PLT ", $this->_m_signature, $this->_io, "/types/plt_header/seq/0");
            }
            $this->_m_version = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_version == "V1  ")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("V1  ", $this->_m_version, $this->_io, "/types/plt_header/seq/1");
            }
            $this->_m_unknown1 = $this->_io->readU4le();
            $this->_m_unknown2 = $this->_io->readU4le();
            $this->_m_width = $this->_io->readU4le();
            $this->_m_height = $this->_io->readU4le();
        }
        protected $_m_signature;
        protected $_m_version;
        protected $_m_unknown1;
        protected $_m_unknown2;
        protected $_m_width;
        protected $_m_height;

        /**
         * File signature. Must be "PLT " (space-padded).
         * This identifies the file as a PLT palette texture.
         */
        public function signature() { return $this->_m_signature; }

        /**
         * File format version. Must be "V1  " (space-padded).
         * This is the only known version of the PLT format.
         */
        public function version() { return $this->_m_version; }

        /**
         * Unknown field (4 bytes).
         * Purpose is unknown, may be reserved for future use or internal engine flags.
         */
        public function unknown1() { return $this->_m_unknown1; }

        /**
         * Unknown field (4 bytes).
         * Purpose is unknown, may be reserved for future use or internal engine flags.
         */
        public function unknown2() { return $this->_m_unknown2; }

        /**
         * Texture width in pixels (uint32).
         * Used to calculate the number of pixel entries in the pixel data section.
         */
        public function width() { return $this->_m_width; }

        /**
         * Texture height in pixels (uint32).
         * Used to calculate the number of pixel entries in the pixel data section.
         * Total pixel count = width × height
         */
        public function height() { return $this->_m_height; }
    }
}

namespace Plt {
    class PltPixel extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Plt\PixelDataSection $_parent = null, ?\Plt $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_colorIndex = $this->_io->readU1();
            $this->_m_paletteGroupIndex = $this->_io->readU1();
        }
        protected $_m_colorIndex;
        protected $_m_paletteGroupIndex;

        /**
         * Color index (0-255) within the selected palette.
         * This value selects which color from the palette file row to use.
         * The palette file contains 256 rows (one for each palette index 0-255),
         * and each row contains 256 color values (one for each color index 0-255).
         */
        public function colorIndex() { return $this->_m_colorIndex; }

        /**
         * Palette group index (0-9) that determines which palette file to use.
         * Palette groups:
         * 0 = Skin (pal_skin01.jpg)
         * 1 = Hair (pal_hair01.jpg)
         * 2 = Metal 1 (pal_armor01.jpg)
         * 3 = Metal 2 (pal_armor02.jpg)
         * 4 = Cloth 1 (pal_cloth01.jpg)
         * 5 = Cloth 2 (pal_cloth01.jpg)
         * 6 = Leather 1 (pal_leath01.jpg)
         * 7 = Leather 2 (pal_leath01.jpg)
         * 8 = Tattoo 1 (pal_tattoo01.jpg)
         * 9 = Tattoo 2 (pal_tattoo01.jpg)
         */
        public function paletteGroupIndex() { return $this->_m_paletteGroupIndex; }
    }
}
