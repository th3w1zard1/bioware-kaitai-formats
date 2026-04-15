<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
 * texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
 * ERF files store both resource names (ResRefs) and data in the same file. They also support
 * localized strings for descriptions in multiple languages.
 * 
 * Format Variants:
 * - ERF: Generic encapsulated resource file (texture packs, etc.)
 * - HAK: Hak pak file (contains override resources). Used for mod content distribution
 * - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
 * - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`
 * 
 * All variants use the same binary format structure, differing only in the file type signature.
 * 
 * Binary Format Structure:
 * - Header (160 bytes): File type, version, entry counts, offsets, build date, description
 * - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
 *   include localized module names for the load screen. Each entry contains language_id (u4),
 *   string_size (u4), and string_data (UTF-8 encoded text)
 * - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
 *   - resref (16 bytes, ASCII, null-padded): Resource filename
 *   - resource_id (u4): Index into resource_list
 *   - resource_type (u2): Resource type identifier (see ResourceType enum)
 *   - unused (u2): Padding/unused field (typically 0)
 * - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
 *   - offset_to_data (u4): Byte offset to resource data from beginning of file
 *   - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
 * - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
 *   in resource_list
 * 
 * File Access Pattern:
 * 1. Read header to get entry_count and offsets
 * 2. Read key_list to map ResRefs to resource_ids
 * 3. Use resource_id to index into resource_list
 * 4. Read resource data from offset_to_data with byte length len_data
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf - Complete ERF format documentation
 * - https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf - Official BioWare Aurora ERF specification
 * - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/erfreader.cpp:24-106 - Complete C++ ERF reader implementation
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp:44-229 - Generic Aurora ERF implementation (shared format)
 * - https://github.com/NickHugi/Kotor.NET/blob/master/Formats/KotorERF/ERFBinaryStructure.cs:11-170 - .NET ERF reader/writer
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py - PyKotor binary reader/writer
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py - ERF data model
 */

namespace {
    class Erf extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Erf\ErfHeader($this->_io, $this, $this->_root);
        }
        protected $_m_keyList;

        /**
         * Array of key entries mapping ResRefs to resource indices
         */
        public function keyList() {
            if ($this->_m_keyList !== null)
                return $this->_m_keyList;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->header()->offsetToKeyList());
            $this->_m_keyList = new \Erf\KeyList($this->_io, $this, $this->_root);
            $this->_io->seek($_pos);
            return $this->_m_keyList;
        }
        protected $_m_localizedStringList;

        /**
         * Optional localized string entries for multi-language descriptions
         */
        public function localizedStringList() {
            if ($this->_m_localizedStringList !== null)
                return $this->_m_localizedStringList;
            if ($this->header()->languageCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->offsetToLocalizedStringList());
                $this->_m_localizedStringList = new \Erf\LocalizedStringList($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_localizedStringList;
        }
        protected $_m_resourceList;

        /**
         * Array of resource entries containing offset and size information
         */
        public function resourceList() {
            if ($this->_m_resourceList !== null)
                return $this->_m_resourceList;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->header()->offsetToResourceList());
            $this->_m_resourceList = new \Erf\ResourceList($this->_io, $this, $this->_root);
            $this->_io->seek($_pos);
            return $this->_m_resourceList;
        }
        protected $_m_header;

        /**
         * ERF file header (160 bytes)
         */
        public function header() { return $this->_m_header; }
    }
}

namespace Erf {
    class ErfHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!( (($this->_m_fileType == "ERF ") || ($this->_m_fileType == "MOD ") || ($this->_m_fileType == "SAV ") || ($this->_m_fileType == "HAK ")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_fileType, $this->_io, "/types/erf_header/seq/0");
            }
            $this->_m_fileVersion = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_fileVersion == "V1.0")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("V1.0", $this->_m_fileVersion, $this->_io, "/types/erf_header/seq/1");
            }
            $this->_m_languageCount = $this->_io->readU4le();
            $this->_m_localizedStringSize = $this->_io->readU4le();
            $this->_m_entryCount = $this->_io->readU4le();
            $this->_m_offsetToLocalizedStringList = $this->_io->readU4le();
            $this->_m_offsetToKeyList = $this->_io->readU4le();
            $this->_m_offsetToResourceList = $this->_io->readU4le();
            $this->_m_buildYear = $this->_io->readU4le();
            $this->_m_buildDay = $this->_io->readU4le();
            $this->_m_descriptionStrref = $this->_io->readS4le();
            $this->_m_reserved = $this->_io->readBytes(116);
        }
        protected $_m_isSaveFile;

        /**
         * Heuristic to detect save game files.
         * Save games use MOD signature but typically have description_strref = 0.
         */
        public function isSaveFile() {
            if ($this->_m_isSaveFile !== null)
                return $this->_m_isSaveFile;
            $this->_m_isSaveFile =  (($this->fileType() == "MOD ") && ($this->descriptionStrref() == 0)) ;
            return $this->_m_isSaveFile;
        }
        protected $_m_fileType;
        protected $_m_fileVersion;
        protected $_m_languageCount;
        protected $_m_localizedStringSize;
        protected $_m_entryCount;
        protected $_m_offsetToLocalizedStringList;
        protected $_m_offsetToKeyList;
        protected $_m_offsetToResourceList;
        protected $_m_buildYear;
        protected $_m_buildDay;
        protected $_m_descriptionStrref;
        protected $_m_reserved;

        /**
         * File type signature. Must be one of:
         * - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
         * - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
         * - "SAV " (0x53 0x41 0x56 0x20) - Save game file
         * - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. Always "V1.0" for KotOR ERF files.
         * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
         */
        public function fileVersion() { return $this->_m_fileVersion; }

        /**
         * Number of localized string entries. Typically 0 for most ERF files.
         * MOD files may include localized module names for the load screen.
         */
        public function languageCount() { return $this->_m_languageCount; }

        /**
         * Total size of localized string data in bytes.
         * Includes all language entries (language_id + string_size + string_data for each).
         */
        public function localizedStringSize() { return $this->_m_localizedStringSize; }

        /**
         * Number of resources in the archive. This determines:
         * - Number of entries in key_list
         * - Number of entries in resource_list
         * - Number of resource data blocks stored at various offsets
         */
        public function entryCount() { return $this->_m_entryCount; }

        /**
         * Byte offset to the localized string list from the beginning of the file.
         * Typically 160 (right after header) if present, or 0 if not present.
         */
        public function offsetToLocalizedStringList() { return $this->_m_offsetToLocalizedStringList; }

        /**
         * Byte offset to the key list from the beginning of the file.
         * Typically 160 (right after header) if no localized strings, or after localized strings.
         */
        public function offsetToKeyList() { return $this->_m_offsetToKeyList; }

        /**
         * Byte offset to the resource list from the beginning of the file.
         * Located after the key list.
         */
        public function offsetToResourceList() { return $this->_m_offsetToResourceList; }

        /**
         * Build year (years since 1900).
         * Example: 103 = year 2003
         * Primarily informational, used by development tools to track module versions.
         */
        public function buildYear() { return $this->_m_buildYear; }

        /**
         * Build day (days since January 1, with January 1 = day 1).
         * Example: 247 = September 4th (the 247th day of the year)
         * Primarily informational, used by development tools to track module versions.
         */
        public function buildDay() { return $this->_m_buildDay; }

        /**
         * Description StrRef (TLK string reference) for the archive description.
         * Values vary by file type:
         * - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
         * - SAV files: 0 (typically no description)
         * - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
         */
        public function descriptionStrref() { return $this->_m_descriptionStrref; }

        /**
         * Reserved padding (usually zeros).
         * Total header size is 160 bytes:
         * file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
         * entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
         * offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
         * reserved (116) = 160 bytes
         */
        public function reserved() { return $this->_m_reserved; }
    }
}

namespace Erf {
    class KeyEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf\KeyList $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_resref = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(16), "ASCII");
            $this->_m_resourceId = $this->_io->readU4le();
            $this->_m_resourceType = $this->_io->readU2le();
            $this->_m_unused = $this->_io->readU2le();
        }
        protected $_m_resref;
        protected $_m_resourceId;
        protected $_m_resourceType;
        protected $_m_unused;

        /**
         * Resource filename (ResRef), null-padded to 16 bytes.
         * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
         * Resource names can be mixed case, though most are lowercase in practice.
         */
        public function resref() { return $this->_m_resref; }

        /**
         * Resource ID (index into resource_list).
         * Maps this key entry to the corresponding resource entry.
         */
        public function resourceId() { return $this->_m_resourceId; }

        /**
         * Resource type identifier (see ResourceType enum).
         * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
         */
        public function resourceType() { return $this->_m_resourceType; }

        /**
         * Padding/unused field (typically 0)
         */
        public function unused() { return $this->_m_unused; }
    }
}

namespace Erf {
    class KeyList extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->entryCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Erf\KeyEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of key entries mapping ResRefs to resource indices
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Erf {
    class LocalizedStringEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf\LocalizedStringList $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_languageId = $this->_io->readU4le();
            $this->_m_stringSize = $this->_io->readU4le();
            $this->_m_stringData = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes($this->stringSize()), "UTF-8");
        }
        protected $_m_languageId;
        protected $_m_stringSize;
        protected $_m_stringData;

        /**
         * Language identifier:
         * - 0 = English
         * - 1 = French
         * - 2 = German
         * - 3 = Italian
         * - 4 = Spanish
         * - 5 = Polish
         * - Additional languages for Asian releases
         */
        public function languageId() { return $this->_m_languageId; }

        /**
         * Length of string data in bytes
         */
        public function stringSize() { return $this->_m_stringSize; }

        /**
         * UTF-8 encoded text string
         */
        public function stringData() { return $this->_m_stringData; }
    }
}

namespace Erf {
    class LocalizedStringList extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->languageCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Erf\LocalizedStringEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of localized string entries, one per language
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Erf {
    class ResourceEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf\ResourceList $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_offsetToData = $this->_io->readU4le();
            $this->_m_lenData = $this->_io->readU4le();
        }
        protected $_m_data;

        /**
         * Raw binary data for this resource
         */
        public function data() {
            if ($this->_m_data !== null)
                return $this->_m_data;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->offsetToData());
            $this->_m_data = $this->_io->readBytes($this->lenData());
            $this->_io->seek($_pos);
            return $this->_m_data;
        }
        protected $_m_offsetToData;
        protected $_m_lenData;

        /**
         * Byte offset to resource data from the beginning of the file.
         * Points to the actual binary data for this resource.
         */
        public function offsetToData() { return $this->_m_offsetToData; }

        /**
         * Size of resource data in bytes.
         * Uncompressed size of the resource.
         */
        public function lenData() { return $this->_m_lenData; }
    }
}

namespace Erf {
    class ResourceList extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->entryCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Erf\ResourceEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of resource entries containing offset and size information
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Erf {
    class XoreosFileTypeId {
        const NONE = -1;
        const RES = 0;
        const BMP = 1;
        const MVE = 2;
        const TGA = 3;
        const WAV = 4;
        const PLT = 6;
        const INI = 7;
        const BMU = 8;
        const MPG = 9;
        const TXT = 10;
        const WMA = 11;
        const WMV = 12;
        const XMV = 13;
        const PLH = 2000;
        const TEX = 2001;
        const MDL = 2002;
        const THG = 2003;
        const FNT = 2005;
        const LUA = 2007;
        const SLT = 2008;
        const NSS = 2009;
        const NCS = 2010;
        const MOD = 2011;
        const ARE = 2012;
        const SET = 2013;
        const IFO = 2014;
        const BIC = 2015;
        const WOK = 2016;
        const TWO_DA = 2017;
        const TLK = 2018;
        const TXI = 2022;
        const GIT = 2023;
        const BTI = 2024;
        const UTI = 2025;
        const BTC = 2026;
        const UTC = 2027;
        const DLG = 2029;
        const ITP = 2030;
        const BTT = 2031;
        const UTT = 2032;
        const DDS = 2033;
        const BTS = 2034;
        const UTS = 2035;
        const LTR = 2036;
        const GFF = 2037;
        const FAC = 2038;
        const BTE = 2039;
        const UTE = 2040;
        const BTD = 2041;
        const UTD = 2042;
        const BTP = 2043;
        const UTP = 2044;
        const DFT = 2045;
        const GIC = 2046;
        const GUI = 2047;
        const CSS = 2048;
        const CCS = 2049;
        const BTM = 2050;
        const UTM = 2051;
        const DWK = 2052;
        const PWK = 2053;
        const BTG = 2054;
        const UTG = 2055;
        const JRL = 2056;
        const SAV = 2057;
        const UTW = 2058;
        const FOUR_PC = 2059;
        const SSF = 2060;
        const HAK = 2061;
        const NWM = 2062;
        const BIK = 2063;
        const NDB = 2064;
        const PTM = 2065;
        const PTT = 2066;
        const NCM = 2067;
        const MFX = 2068;
        const MAT = 2069;
        const MDB = 2070;
        const SAY = 2071;
        const TTF = 2072;
        const TTC = 2073;
        const CUT = 2074;
        const KA = 2075;
        const JPG = 2076;
        const ICO = 2077;
        const OGG = 2078;
        const SPT = 2079;
        const SPW = 2080;
        const WFX = 2081;
        const UGM = 2082;
        const QDB = 2083;
        const QST = 2084;
        const NPC = 2085;
        const SPN = 2086;
        const UTX = 2087;
        const MMD = 2088;
        const SMM = 2089;
        const UTA = 2090;
        const MDE = 2091;
        const MDV = 2092;
        const MDA = 2093;
        const MBA = 2094;
        const OCT = 2095;
        const BFX = 2096;
        const PDB = 2097;
        const THE_WITCHER_SAVE = 2098;
        const PVS = 2099;
        const CFX = 2100;
        const LUC = 2101;
        const PRB = 2103;
        const CAM = 2104;
        const VDS = 2105;
        const BIN = 2106;
        const WOB = 2107;
        const API = 2108;
        const PROPERTIES = 2109;
        const PNG = 2110;
        const LYT = 3000;
        const VIS = 3001;
        const RIM = 3002;
        const PTH = 3003;
        const LIP = 3004;
        const BWM = 3005;
        const TXB = 3006;
        const TPC = 3007;
        const MDX = 3008;
        const RSV = 3009;
        const SIG = 3010;
        const MAB = 3011;
        const QST2 = 3012;
        const STO = 3013;
        const HEX = 3015;
        const MDX2 = 3016;
        const TXB2 = 3017;
        const FSM = 3022;
        const ART = 3023;
        const AMP = 3024;
        const CWA = 3025;
        const BIP = 3028;
        const MDB2 = 4000;
        const MDA2 = 4001;
        const SPT2 = 4002;
        const GR2 = 4003;
        const FXA = 4004;
        const FXE = 4005;
        const JPG2 = 4007;
        const PWC = 4008;
        const ONE_DA = 9996;
        const ERF = 9997;
        const BIF = 9998;
        const KEY = 9999;
        const EXE = 19000;
        const DBF = 19001;
        const CDX = 19002;
        const FPT = 19003;
        const ZIP = 20000;
        const FXM = 20001;
        const FXS = 20002;
        const XML = 20003;
        const WLK = 20004;
        const UTR = 20005;
        const SEF = 20006;
        const PFX = 20007;
        const TFX = 20008;
        const IFX = 20009;
        const LFX = 20010;
        const BBX = 20011;
        const PFB = 20012;
        const UPE = 20013;
        const USC = 20014;
        const ULT = 20015;
        const FX = 20016;
        const MAX = 20017;
        const DOC = 20018;
        const SCC = 20019;
        const WMP = 20020;
        const OSC = 20021;
        const TRN = 20022;
        const UEN = 20023;
        const ROS = 20024;
        const RST = 20025;
        const PTX = 20026;
        const LTX = 20027;
        const TRX = 20028;
        const NDS = 21000;
        const HERF = 21001;
        const DICT = 21002;
        const SMALL = 21003;
        const CBGT = 21004;
        const CDPTH = 21005;
        const EMIT = 21006;
        const ITM = 21007;
        const NANR = 21008;
        const NBFP = 21009;
        const NBFS = 21010;
        const NCER = 21011;
        const NCGR = 21012;
        const NCLR = 21013;
        const NFTR = 21014;
        const NSBCA = 21015;
        const NSBMD = 21016;
        const NSBTA = 21017;
        const NSBTP = 21018;
        const NSBTX = 21019;
        const PAL = 21020;
        const RAW = 21021;
        const SADL = 21022;
        const SDAT = 21023;
        const SMP = 21024;
        const SPL = 21025;
        const VX = 21026;
        const ANB = 22000;
        const ANI = 22001;
        const CNS = 22002;
        const CUR = 22003;
        const EVT = 22004;
        const FDL = 22005;
        const FXO = 22006;
        const GAD = 22007;
        const GDA = 22008;
        const GFX = 22009;
        const LDF = 22010;
        const LST = 22011;
        const MAL = 22012;
        const MAO = 22013;
        const MMH = 22014;
        const MOP = 22015;
        const MOR = 22016;
        const MSH = 22017;
        const MTX = 22018;
        const NCC = 22019;
        const PHY = 22020;
        const PLO = 22021;
        const STG = 22022;
        const TBI = 22023;
        const TNT = 22024;
        const ARL = 22025;
        const FEV = 22026;
        const FSB = 22027;
        const OPF = 22028;
        const CRF = 22029;
        const RIMP = 22030;
        const MET = 22031;
        const META = 22032;
        const FXR = 22033;
        const CIF = 22034;
        const CUB = 22035;
        const DLB = 22036;
        const NSC = 22037;
        const MOV = 23000;
        const CURS = 23001;
        const PICT = 23002;
        const RSRC = 23003;
        const PLIST = 23004;
        const CRE = 24000;
        const PSO = 24001;
        const VSO = 24002;
        const ABC = 24003;
        const SBM = 24004;
        const PVD = 24005;
        const PLA = 24006;
        const TRG = 24007;
        const PK = 24008;
        const ALS = 25000;
        const APL = 25001;
        const ASSEMBLY = 25002;
        const BAK = 25003;
        const BNK = 25004;
        const CL = 25005;
        const CNV = 25006;
        const CON = 25007;
        const DAT = 25008;
        const DX11 = 25009;
        const IDS = 25010;
        const LOG = 25011;
        const MAP = 25012;
        const MML = 25013;
        const MP3 = 25014;
        const PCK = 25015;
        const RML = 25016;
        const S = 25017;
        const STA = 25018;
        const SVR = 25019;
        const VLM = 25020;
        const WBD = 25021;
        const XBX = 25022;
        const XLS = 25023;
        const BZF = 26000;
        const ADV = 27000;
        const JSON = 28000;
        const TLK_EXPERT = 28001;
        const TLK_MOBILE = 28002;
        const TLK_TOUCH = 28003;
        const OTF = 28004;
        const PAR = 28005;
        const XWB = 29000;
        const XSB = 29001;
        const XDS = 30000;
        const WND = 30001;
        const XEOSITEX = 40000;

        private const _VALUES = [-1 => true, 0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 6 => true, 7 => true, 8 => true, 9 => true, 10 => true, 11 => true, 12 => true, 13 => true, 2000 => true, 2001 => true, 2002 => true, 2003 => true, 2005 => true, 2007 => true, 2008 => true, 2009 => true, 2010 => true, 2011 => true, 2012 => true, 2013 => true, 2014 => true, 2015 => true, 2016 => true, 2017 => true, 2018 => true, 2022 => true, 2023 => true, 2024 => true, 2025 => true, 2026 => true, 2027 => true, 2029 => true, 2030 => true, 2031 => true, 2032 => true, 2033 => true, 2034 => true, 2035 => true, 2036 => true, 2037 => true, 2038 => true, 2039 => true, 2040 => true, 2041 => true, 2042 => true, 2043 => true, 2044 => true, 2045 => true, 2046 => true, 2047 => true, 2048 => true, 2049 => true, 2050 => true, 2051 => true, 2052 => true, 2053 => true, 2054 => true, 2055 => true, 2056 => true, 2057 => true, 2058 => true, 2059 => true, 2060 => true, 2061 => true, 2062 => true, 2063 => true, 2064 => true, 2065 => true, 2066 => true, 2067 => true, 2068 => true, 2069 => true, 2070 => true, 2071 => true, 2072 => true, 2073 => true, 2074 => true, 2075 => true, 2076 => true, 2077 => true, 2078 => true, 2079 => true, 2080 => true, 2081 => true, 2082 => true, 2083 => true, 2084 => true, 2085 => true, 2086 => true, 2087 => true, 2088 => true, 2089 => true, 2090 => true, 2091 => true, 2092 => true, 2093 => true, 2094 => true, 2095 => true, 2096 => true, 2097 => true, 2098 => true, 2099 => true, 2100 => true, 2101 => true, 2103 => true, 2104 => true, 2105 => true, 2106 => true, 2107 => true, 2108 => true, 2109 => true, 2110 => true, 3000 => true, 3001 => true, 3002 => true, 3003 => true, 3004 => true, 3005 => true, 3006 => true, 3007 => true, 3008 => true, 3009 => true, 3010 => true, 3011 => true, 3012 => true, 3013 => true, 3015 => true, 3016 => true, 3017 => true, 3022 => true, 3023 => true, 3024 => true, 3025 => true, 3028 => true, 4000 => true, 4001 => true, 4002 => true, 4003 => true, 4004 => true, 4005 => true, 4007 => true, 4008 => true, 9996 => true, 9997 => true, 9998 => true, 9999 => true, 19000 => true, 19001 => true, 19002 => true, 19003 => true, 20000 => true, 20001 => true, 20002 => true, 20003 => true, 20004 => true, 20005 => true, 20006 => true, 20007 => true, 20008 => true, 20009 => true, 20010 => true, 20011 => true, 20012 => true, 20013 => true, 20014 => true, 20015 => true, 20016 => true, 20017 => true, 20018 => true, 20019 => true, 20020 => true, 20021 => true, 20022 => true, 20023 => true, 20024 => true, 20025 => true, 20026 => true, 20027 => true, 20028 => true, 21000 => true, 21001 => true, 21002 => true, 21003 => true, 21004 => true, 21005 => true, 21006 => true, 21007 => true, 21008 => true, 21009 => true, 21010 => true, 21011 => true, 21012 => true, 21013 => true, 21014 => true, 21015 => true, 21016 => true, 21017 => true, 21018 => true, 21019 => true, 21020 => true, 21021 => true, 21022 => true, 21023 => true, 21024 => true, 21025 => true, 21026 => true, 22000 => true, 22001 => true, 22002 => true, 22003 => true, 22004 => true, 22005 => true, 22006 => true, 22007 => true, 22008 => true, 22009 => true, 22010 => true, 22011 => true, 22012 => true, 22013 => true, 22014 => true, 22015 => true, 22016 => true, 22017 => true, 22018 => true, 22019 => true, 22020 => true, 22021 => true, 22022 => true, 22023 => true, 22024 => true, 22025 => true, 22026 => true, 22027 => true, 22028 => true, 22029 => true, 22030 => true, 22031 => true, 22032 => true, 22033 => true, 22034 => true, 22035 => true, 22036 => true, 22037 => true, 23000 => true, 23001 => true, 23002 => true, 23003 => true, 23004 => true, 24000 => true, 24001 => true, 24002 => true, 24003 => true, 24004 => true, 24005 => true, 24006 => true, 24007 => true, 24008 => true, 25000 => true, 25001 => true, 25002 => true, 25003 => true, 25004 => true, 25005 => true, 25006 => true, 25007 => true, 25008 => true, 25009 => true, 25010 => true, 25011 => true, 25012 => true, 25013 => true, 25014 => true, 25015 => true, 25016 => true, 25017 => true, 25018 => true, 25019 => true, 25020 => true, 25021 => true, 25022 => true, 25023 => true, 26000 => true, 27000 => true, 28000 => true, 28001 => true, 28002 => true, 28003 => true, 28004 => true, 28005 => true, 29000 => true, 29001 => true, 30000 => true, 30001 => true, 40000 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}
