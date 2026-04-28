<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * Enums and small helper types used by installation/extraction tooling.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/installation.py
 */

namespace {
    class BiowareExtractCommon extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareExtractCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
        }
    }
}

/**
 * String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
 */

namespace BiowareExtractCommon {
    class BiowareTexturePackNameStr extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareExtractCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_value = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(0, false, true, true), "ASCII");
            if (!( (($this->_m_value == "swpc_tex_tpa.erf") || ($this->_m_value == "swpc_tex_tpb.erf") || ($this->_m_value == "swpc_tex_tpc.erf") || ($this->_m_value == "swpc_tex_gui.erf")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_value, $this->_io, "/types/bioware_texture_pack_name_str/seq/0");
            }
        }
        protected $_m_value;
        public function value() { return $this->_m_value; }
    }
}

namespace BiowareExtractCommon {
    class BiowareSearchLocationId {
        const OVERRIDE = 0;
        const MODULES = 1;
        const CHITIN = 2;
        const TEXTURES_TPA = 3;
        const TEXTURES_TPB = 4;
        const TEXTURES_TPC = 5;
        const TEXTURES_GUI = 6;
        const MUSIC = 7;
        const SOUND = 8;
        const VOICE = 9;
        const LIPS = 10;
        const RIMS = 11;
        const CUSTOM_MODULES = 12;
        const CUSTOM_FOLDERS = 13;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 8 => true, 9 => true, 10 => true, 11 => true, 12 => true, 13 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}
