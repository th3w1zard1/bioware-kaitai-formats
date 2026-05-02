<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
 * per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
 * 
 * Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
 */

namespace {
    class TgaCommon extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\TgaCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
        }
    }
}

namespace TgaCommon {
    class TgaColorMapType {
        const NONE = 0;
        const PRESENT = 1;

        private const _VALUES = [0 => true, 1 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace TgaCommon {
    class TgaImageType {
        const NO_IMAGE_DATA = 0;
        const UNCOMPRESSED_COLOR_MAPPED = 1;
        const UNCOMPRESSED_RGB = 2;
        const UNCOMPRESSED_GREYSCALE = 3;
        const RLE_COLOR_MAPPED = 9;
        const RLE_RGB = 10;
        const RLE_GREYSCALE = 11;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 9 => true, 10 => true, 11 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}
