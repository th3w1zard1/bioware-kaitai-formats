<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * Shared enums and small helper types used by TSLPatcher-style tooling.
 * 
 * Notes:
 * - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
 *   so string-valued enums are modeled here as small string wrapper types with `valid` constraints.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py
 */

namespace {
    class BiowareTslpatcherCommon extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareTslpatcherCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
        }
    }
}

/**
 * String-valued enum equivalent for DiffFormat (null-terminated ASCII).
 */

namespace BiowareTslpatcherCommon {
    class BiowareDiffFormatStr extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareTslpatcherCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_value = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(0, false, true, true), "ASCII");
            if (!( (($this->_m_value == "default") || ($this->_m_value == "unified") || ($this->_m_value == "context") || ($this->_m_value == "side_by_side")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_value, $this->_io, "/types/bioware_diff_format_str/seq/0");
            }
        }
        protected $_m_value;
        public function value() { return $this->_m_value; }
    }
}

/**
 * String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
 */

namespace BiowareTslpatcherCommon {
    class BiowareDiffResourceTypeStr extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareTslpatcherCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_value = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(0, false, true, true), "ASCII");
            if (!( (($this->_m_value == "gff") || ($this->_m_value == "2da") || ($this->_m_value == "tlk") || ($this->_m_value == "lip") || ($this->_m_value == "bytes")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_value, $this->_io, "/types/bioware_diff_resource_type_str/seq/0");
            }
        }
        protected $_m_value;
        public function value() { return $this->_m_value; }
    }
}

/**
 * String-valued enum equivalent for DiffType (null-terminated ASCII).
 */

namespace BiowareTslpatcherCommon {
    class BiowareDiffTypeStr extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareTslpatcherCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_value = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(0, false, true, true), "ASCII");
            if (!( (($this->_m_value == "identical") || ($this->_m_value == "modified") || ($this->_m_value == "added") || ($this->_m_value == "removed") || ($this->_m_value == "error")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_value, $this->_io, "/types/bioware_diff_type_str/seq/0");
            }
        }
        protected $_m_value;
        public function value() { return $this->_m_value; }
    }
}

/**
 * String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
 */

namespace BiowareTslpatcherCommon {
    class BiowareNcsTokenTypeStr extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareTslpatcherCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_value = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(0, false, true, true), "ASCII");
            if (!( (($this->_m_value == "strref") || ($this->_m_value == "strref32") || ($this->_m_value == "2damemory") || ($this->_m_value == "2damemory32") || ($this->_m_value == "uint32") || ($this->_m_value == "uint16") || ($this->_m_value == "uint8")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_value, $this->_io, "/types/bioware_ncs_token_type_str/seq/0");
            }
        }
        protected $_m_value;
        public function value() { return $this->_m_value; }
    }
}

namespace BiowareTslpatcherCommon {
    class BiowareTslpatcherLogTypeId {
        const VERBOSE = 0;
        const NOTE = 1;
        const WARNING = 2;
        const ERROR = 3;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareTslpatcherCommon {
    class BiowareTslpatcherTargetTypeId {
        const ROW_INDEX = 0;
        const ROW_LABEL = 1;
        const LABEL_COLUMN = 2;

        private const _VALUES = [0 => true, 1 => true, 2 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}
