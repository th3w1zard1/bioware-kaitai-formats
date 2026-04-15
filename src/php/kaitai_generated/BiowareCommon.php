<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * Shared enums and "common objects" used across the BioWare ecosystem that also appear
 * in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).
 * 
 * This file is intended to be imported by other `.ksy` files to avoid repeating:
 * - Language IDs (used in TLK headers and GFF LocalizedString substrings)
 * - Gender IDs (used in GFF LocalizedString substrings)
 * - The CExoLocString / LocalizedString binary layout
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py
 * - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h
 * - https://github.com/seedhartha/reone/blob/master/include/reone/resource/types.h
 */

namespace {
    class BiowareCommon extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
        }
    }
}

/**
 * Variable-length binary data with 4-byte length prefix.
 * Used for Void/Binary fields in GFF files.
 */

namespace BiowareCommon {
    class BiowareBinaryData extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_lenValue = $this->_io->readU4le();
            $this->_m_value = $this->_io->readBytes($this->lenValue());
        }
        protected $_m_lenValue;
        protected $_m_value;

        /**
         * Length of binary data in bytes
         */
        public function lenValue() { return $this->_m_lenValue; }

        /**
         * Binary data
         */
        public function value() { return $this->_m_value; }
    }
}

/**
 * BioWare CExoString - variable-length string with 4-byte length prefix.
 * Used for string fields in GFF files.
 */

namespace BiowareCommon {
    class BiowareCexoString extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_lenString = $this->_io->readU4le();
            $this->_m_value = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes($this->lenString()), "UTF-8");
        }
        protected $_m_lenString;
        protected $_m_value;

        /**
         * Length of string in bytes
         */
        public function lenString() { return $this->_m_lenString; }

        /**
         * String data (UTF-8)
         */
        public function value() { return $this->_m_value; }
    }
}

/**
 * BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
 * section for field type "LocalizedString".
 */

namespace BiowareCommon {
    class BiowareLocstring extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_totalSize = $this->_io->readU4le();
            $this->_m_stringRef = $this->_io->readU4le();
            $this->_m_numSubstrings = $this->_io->readU4le();
            $this->_m_substrings = [];
            $n = $this->numSubstrings();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_substrings[] = new \BiowareCommon\Substring($this->_io, $this, $this->_root);
            }
        }
        protected $_m_hasStrref;

        /**
         * True if this locstring references dialog.tlk
         */
        public function hasStrref() {
            if ($this->_m_hasStrref !== null)
                return $this->_m_hasStrref;
            $this->_m_hasStrref = $this->stringRef() != 4294967295;
            return $this->_m_hasStrref;
        }
        protected $_m_totalSize;
        protected $_m_stringRef;
        protected $_m_numSubstrings;
        protected $_m_substrings;

        /**
         * Total size of the structure in bytes (excluding this field).
         */
        public function totalSize() { return $this->_m_totalSize; }

        /**
         * StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).
         */
        public function stringRef() { return $this->_m_stringRef; }

        /**
         * Number of substring entries that follow.
         */
        public function numSubstrings() { return $this->_m_numSubstrings; }

        /**
         * Language/gender-specific substring entries.
         */
        public function substrings() { return $this->_m_substrings; }
    }
}

/**
 * BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
 * Used throughout GFF files to reference game resources by name.
 */

namespace BiowareCommon {
    class BiowareResref extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_lenResref = $this->_io->readU1();
            if (!($this->_m_lenResref <= 16)) {
                throw new \Kaitai\Struct\Error\ValidationGreaterThanError(16, $this->_m_lenResref, $this->_io, "/types/bioware_resref/seq/0");
            }
            $this->_m_value = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes($this->lenResref()), "ASCII");
        }
        protected $_m_lenResref;
        protected $_m_value;

        /**
         * Length of ResRef string (0-16 characters)
         */
        public function lenResref() { return $this->_m_lenResref; }

        /**
         * ResRef string data (ASCII, lowercase recommended)
         */
        public function value() { return $this->_m_value; }
    }
}

/**
 * 3D vector (X, Y, Z coordinates).
 * Used for positions, directions, etc. in game files.
 */

namespace BiowareCommon {
    class BiowareVector3 extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_x = $this->_io->readF4le();
            $this->_m_y = $this->_io->readF4le();
            $this->_m_z = $this->_io->readF4le();
        }
        protected $_m_x;
        protected $_m_y;
        protected $_m_z;

        /**
         * X coordinate
         */
        public function x() { return $this->_m_x; }

        /**
         * Y coordinate
         */
        public function y() { return $this->_m_y; }

        /**
         * Z coordinate
         */
        public function z() { return $this->_m_z; }
    }
}

/**
 * 4D vector / Quaternion (X, Y, Z, W components).
 * Used for orientations/rotations in game files.
 */

namespace BiowareCommon {
    class BiowareVector4 extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_x = $this->_io->readF4le();
            $this->_m_y = $this->_io->readF4le();
            $this->_m_z = $this->_io->readF4le();
            $this->_m_w = $this->_io->readF4le();
        }
        protected $_m_x;
        protected $_m_y;
        protected $_m_z;
        protected $_m_w;

        /**
         * X component
         */
        public function x() { return $this->_m_x; }

        /**
         * Y component
         */
        public function y() { return $this->_m_y; }

        /**
         * Z component
         */
        public function z() { return $this->_m_z; }

        /**
         * W component
         */
        public function w() { return $this->_m_w; }
    }
}

namespace BiowareCommon {
    class Substring extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\BiowareCommon\BiowareLocstring $_parent = null, ?\BiowareCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_substringId = $this->_io->readU4le();
            $this->_m_lenText = $this->_io->readU4le();
            $this->_m_text = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes($this->lenText()), "UTF-8");
        }
        protected $_m_gender;

        /**
         * Gender as enum value
         */
        public function gender() {
            if ($this->_m_gender !== null)
                return $this->_m_gender;
            $this->_m_gender = $this->genderRaw();
            return $this->_m_gender;
        }
        protected $_m_genderRaw;

        /**
         * Raw gender ID (0..255).
         */
        public function genderRaw() {
            if ($this->_m_genderRaw !== null)
                return $this->_m_genderRaw;
            $this->_m_genderRaw = $this->substringId() & 255;
            return $this->_m_genderRaw;
        }
        protected $_m_language;

        /**
         * Language as enum value
         */
        public function language() {
            if ($this->_m_language !== null)
                return $this->_m_language;
            $this->_m_language = $this->languageRaw();
            return $this->_m_language;
        }
        protected $_m_languageRaw;

        /**
         * Raw language ID (0..255).
         */
        public function languageRaw() {
            if ($this->_m_languageRaw !== null)
                return $this->_m_languageRaw;
            $this->_m_languageRaw = $this->substringId() >> 8 & 255;
            return $this->_m_languageRaw;
        }
        protected $_m_substringId;
        protected $_m_lenText;
        protected $_m_text;

        /**
         * Packed language+gender identifier:
         * - bits 0..7: gender
         * - bits 8..15: language
         */
        public function substringId() { return $this->_m_substringId; }

        /**
         * Length of text in bytes.
         */
        public function lenText() { return $this->_m_lenText; }

        /**
         * Substring text.
         */
        public function text() { return $this->_m_text; }
    }
}

namespace BiowareCommon {
    class BiowareDdsVariantBytesPerPixel {
        const DXT1 = 3;
        const DXT5 = 4;

        private const _VALUES = [3 => true, 4 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowareEquipmentSlotFlag {
        const INVALID = 0;
        const HEAD = 1;
        const ARMOR = 2;
        const GAUNTLET = 8;
        const RIGHT_HAND = 16;
        const LEFT_HAND = 32;
        const RIGHT_ARM = 128;
        const LEFT_ARM = 256;
        const IMPLANT = 512;
        const BELT = 1024;
        const CLAW1 = 16384;
        const CLAW2 = 32768;
        const CLAW3 = 65536;
        const HIDE = 131072;
        const RIGHT_HAND_2 = 262144;
        const LEFT_HAND_2 = 524288;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 8 => true, 16 => true, 32 => true, 128 => true, 256 => true, 512 => true, 1024 => true, 16384 => true, 32768 => true, 65536 => true, 131072 => true, 262144 => true, 524288 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowareGameId {
        const K1 = 1;
        const K2 = 2;
        const K1_XBOX = 3;
        const K2_XBOX = 4;
        const K1_IOS = 5;
        const K2_IOS = 6;
        const K1_ANDROID = 7;
        const K2_ANDROID = 8;

        private const _VALUES = [1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 8 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowareGenderId {
        const MALE = 0;
        const FEMALE = 1;

        private const _VALUES = [0 => true, 1 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowareLanguageId {
        const ENGLISH = 0;
        const FRENCH = 1;
        const GERMAN = 2;
        const ITALIAN = 3;
        const SPANISH = 4;
        const POLISH = 5;
        const AFRIKAANS = 6;
        const BASQUE = 7;
        const BRETON = 9;
        const CATALAN = 10;
        const CHAMORRO = 11;
        const CHICHEWA = 12;
        const CORSICAN = 13;
        const DANISH = 14;
        const DUTCH = 15;
        const FAROESE = 16;
        const FILIPINO = 18;
        const FINNISH = 19;
        const FLEMISH = 20;
        const FRISIAN = 21;
        const GALICIAN = 22;
        const GANDA = 23;
        const HAITIAN_CREOLE = 24;
        const HAUSA_LATIN = 25;
        const HAWAIIAN = 26;
        const ICELANDIC = 27;
        const IDO = 28;
        const INDONESIAN = 29;
        const IGBO = 30;
        const IRISH = 31;
        const INTERLINGUA = 32;
        const JAVANESE_LATIN = 33;
        const LATIN = 34;
        const LUXEMBOURGISH = 35;
        const MALTESE = 36;
        const NORWEGIAN = 37;
        const OCCITAN = 38;
        const PORTUGUESE = 39;
        const SCOTS = 40;
        const SCOTTISH_GAELIC = 41;
        const SHONA = 42;
        const SOTO = 43;
        const SUNDANESE_LATIN = 44;
        const SWAHILI = 45;
        const SWEDISH = 46;
        const TAGALOG = 47;
        const TAHITIAN = 48;
        const TONGAN = 49;
        const UZBEK_LATIN = 50;
        const WALLOON = 51;
        const XHOSA = 52;
        const YORUBA = 53;
        const WELSH = 54;
        const ZULU = 55;
        const BULGARIAN = 58;
        const BELARISIAN = 59;
        const MACEDONIAN = 60;
        const RUSSIAN = 61;
        const SERBIAN_CYRILLIC = 62;
        const TAJIK = 63;
        const TATAR_CYRILLIC = 64;
        const UKRAINIAN = 66;
        const UZBEK = 67;
        const ALBANIAN = 68;
        const BOSNIAN_LATIN = 69;
        const CZECH = 70;
        const SLOVAK = 71;
        const SLOVENE = 72;
        const CROATIAN = 73;
        const HUNGARIAN = 75;
        const ROMANIAN = 76;
        const GREEK = 77;
        const ESPERANTO = 78;
        const AZERBAIJANI_LATIN = 79;
        const TURKISH = 81;
        const TURKMEN_LATIN = 82;
        const HEBREW = 83;
        const ARABIC = 84;
        const ESTONIAN = 85;
        const LATVIAN = 86;
        const LITHUANIAN = 87;
        const VIETNAMESE = 88;
        const THAI = 89;
        const AYMARA = 90;
        const KINYARWANDA = 91;
        const KURDISH_LATIN = 92;
        const MALAGASY = 93;
        const MALAY_LATIN = 94;
        const MAORI = 95;
        const MOLDOVAN_LATIN = 96;
        const SAMOAN = 97;
        const SOMALI = 98;
        const KOREAN = 128;
        const CHINESE_TRADITIONAL = 129;
        const CHINESE_SIMPLIFIED = 130;
        const JAPANESE = 131;
        const UNKNOWN = 2147483646;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 9 => true, 10 => true, 11 => true, 12 => true, 13 => true, 14 => true, 15 => true, 16 => true, 18 => true, 19 => true, 20 => true, 21 => true, 22 => true, 23 => true, 24 => true, 25 => true, 26 => true, 27 => true, 28 => true, 29 => true, 30 => true, 31 => true, 32 => true, 33 => true, 34 => true, 35 => true, 36 => true, 37 => true, 38 => true, 39 => true, 40 => true, 41 => true, 42 => true, 43 => true, 44 => true, 45 => true, 46 => true, 47 => true, 48 => true, 49 => true, 50 => true, 51 => true, 52 => true, 53 => true, 54 => true, 55 => true, 58 => true, 59 => true, 60 => true, 61 => true, 62 => true, 63 => true, 64 => true, 66 => true, 67 => true, 68 => true, 69 => true, 70 => true, 71 => true, 72 => true, 73 => true, 75 => true, 76 => true, 77 => true, 78 => true, 79 => true, 81 => true, 82 => true, 83 => true, 84 => true, 85 => true, 86 => true, 87 => true, 88 => true, 89 => true, 90 => true, 91 => true, 92 => true, 93 => true, 94 => true, 95 => true, 96 => true, 97 => true, 98 => true, 128 => true, 129 => true, 130 => true, 131 => true, 2147483646 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowareLipVisemeId {
        const NEUTRAL = 0;
        const EE = 1;
        const EH = 2;
        const AH = 3;
        const OH = 4;
        const OOH = 5;
        const Y = 6;
        const STS = 7;
        const FV = 8;
        const NG = 9;
        const TH = 10;
        const MPB = 11;
        const TD = 12;
        const SH = 13;
        const L = 14;
        const KG = 15;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 8 => true, 9 => true, 10 => true, 11 => true, 12 => true, 13 => true, 14 => true, 15 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowareLtrAlphabetLength {
        const NEVERWINTER_NIGHTS = 26;
        const KOTOR = 28;

        private const _VALUES = [26 => true, 28 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowareObjectTypeId {
        const INVALID = 0;
        const CREATURE = 1;
        const DOOR = 2;
        const ITEM = 3;
        const TRIGGER = 4;
        const PLACEABLE = 5;
        const WAYPOINT = 6;
        const ENCOUNTER = 7;
        const STORE = 8;
        const AREA = 9;
        const SOUND = 10;
        const CAMERA = 11;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 8 => true, 9 => true, 10 => true, 11 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowarePccCompressionCodec {
        const NONE = 0;
        const ZLIB = 1;
        const LZO = 2;

        private const _VALUES = [0 => true, 1 => true, 2 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowarePccPackageKind {
        const NORMAL_PACKAGE = 0;
        const PATCH_PACKAGE = 1;

        private const _VALUES = [0 => true, 1 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class BiowareTpcPixelFormatId {
        const GREYSCALE = 1;
        const RGB_OR_DXT1 = 2;
        const RGBA_OR_DXT5 = 4;
        const BGRA_XBOX_SWIZZLE = 12;

        private const _VALUES = [1 => true, 2 => true, 4 => true, 12 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareCommon {
    class RiffWaveFormatTag {
        const PCM = 1;
        const ADPCM_MS = 2;
        const IEEE_FLOAT = 3;
        const ALAW = 6;
        const MULAW = 7;
        const DVI_IMA_ADPCM = 17;
        const MPEG_LAYER3 = 85;
        const WAVE_FORMAT_EXTENSIBLE = 65534;

        private const _VALUES = [1 => true, 2 => true, 3 => true, 6 => true, 7 => true, 17 => true, 85 => true, 65534 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}
