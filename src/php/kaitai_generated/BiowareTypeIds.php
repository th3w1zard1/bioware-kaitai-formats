<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * This file provides **exhaustive enum mappings** for resource/type identifiers used across
 * BioWare-family games and their tooling ecosystems.
 * 
 * **Consumers:** KEY/RIM/BIF import `xoreos_file_type_id` from here instead of duplicating the archive
 * type table; cite this file for upstream alias/conflict notes. TLK/ERF language ids and LIP visemes live in
 * `bioware_common.ksy` (`bioware_language_id`, `bioware_lip_viseme_id`).
 * Additional **xoreos-only** Aurora enums (`xoreos_game_id`, `xoreos_archive_type`, `xoreos_resource_category`, `xoreos_platform_id`)
 * mirror the same `types.h` header (distinct from PyKotor `ResourceType` / archive `FileType` IDs).
 * 
 * Why two enums?
 * - `xoreos_file_type_id` mirrors `https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h` (`enum FileType`) and is the
 *   canonical set of **engine-facing** numeric type IDs found in archives (KEY/BIF/ERF/RIM, etc).
 * - `bioware_resource_type_id` mirrors `https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py` (`class ResourceType`)
 *   and includes additional **toolset-only** IDs (e.g. XML/JSON abstractions).
 * 
 * Important notes:
 * - **Duplicates / aliases** exist in upstream definitions (e.g., `DFT`/`DTF` share `2045`,
 *   `FXR`/`FXT` share `22033` — see `meta.xref.xoreos_types_fxr_fxt_duplicate`). Kaitai enums cannot represent multiple names for the same numeric key,
 *   so this file keeps a single canonical name per value.
 * - **Conflicts between ecosystems** exist: PyKotor assigns `25015` to `wav_deob` for toolset use,
 *   while xoreos uses `25015` for `pck` (Dragon Age II). Keeping the enums separate preserves both.
 * 
 * References:
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py
 */

namespace {
    class BiowareTypeIds extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareTypeIds $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
        }
    }
}

namespace BiowareTypeIds {
    class BiowareResourceTypeId {
        const INVALID = -1;
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
        const PVS = 2099;
        const CFX = 2100;
        const LUC = 2101;
        const PRB = 2103;
        const CAM = 2104;
        const VDS = 2105;
        const BIN = 2106;
        const WOB = 2107;
        const API = 2108;
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
        const ERF = 9997;
        const BIF = 9998;
        const KEY = 9999;
        const MP3 = 25014;
        const WAV_DEOB = 25015;
        const TLK_XML = 50001;
        const MDL_ASCII = 50002;
        const IFO_XML = 50006;
        const GIT_XML = 50007;
        const UTI_XML = 50008;
        const UTC_XML = 50009;
        const DLG_XML = 50010;
        const ITP_XML = 50011;
        const UTT_XML = 50012;
        const UTS_XML = 50013;
        const FAC_XML = 50014;
        const UTE_XML = 50015;
        const UTD_XML = 50016;
        const UTP_XML = 50017;
        const GUI_XML = 50018;
        const UTM_XML = 50019;
        const JRL_XML = 50020;
        const UTW_XML = 50021;
        const PTH_XML = 50022;
        const LIP_XML = 50023;
        const SSF_XML = 50024;
        const ARE_XML = 50025;
        const TLK_JSON = 50027;
        const LIP_JSON = 50028;
        const RES_XML = 50029;

        private const _VALUES = [-1 => true, 0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 6 => true, 7 => true, 8 => true, 9 => true, 10 => true, 11 => true, 12 => true, 13 => true, 2000 => true, 2001 => true, 2002 => true, 2003 => true, 2005 => true, 2007 => true, 2008 => true, 2009 => true, 2010 => true, 2011 => true, 2012 => true, 2013 => true, 2014 => true, 2015 => true, 2016 => true, 2018 => true, 2022 => true, 2023 => true, 2024 => true, 2025 => true, 2026 => true, 2027 => true, 2029 => true, 2030 => true, 2031 => true, 2032 => true, 2033 => true, 2034 => true, 2035 => true, 2036 => true, 2037 => true, 2038 => true, 2039 => true, 2040 => true, 2041 => true, 2042 => true, 2043 => true, 2044 => true, 2045 => true, 2046 => true, 2047 => true, 2048 => true, 2049 => true, 2050 => true, 2051 => true, 2052 => true, 2053 => true, 2054 => true, 2055 => true, 2056 => true, 2057 => true, 2058 => true, 2060 => true, 2061 => true, 2062 => true, 2063 => true, 2064 => true, 2065 => true, 2066 => true, 2067 => true, 2068 => true, 2069 => true, 2070 => true, 2071 => true, 2072 => true, 2073 => true, 2074 => true, 2075 => true, 2076 => true, 2077 => true, 2078 => true, 2079 => true, 2080 => true, 2081 => true, 2082 => true, 2083 => true, 2084 => true, 2085 => true, 2086 => true, 2087 => true, 2088 => true, 2089 => true, 2090 => true, 2091 => true, 2092 => true, 2093 => true, 2094 => true, 2095 => true, 2096 => true, 2097 => true, 2099 => true, 2100 => true, 2101 => true, 2103 => true, 2104 => true, 2105 => true, 2106 => true, 2107 => true, 2108 => true, 2110 => true, 3000 => true, 3001 => true, 3002 => true, 3003 => true, 3004 => true, 3005 => true, 3006 => true, 3007 => true, 3008 => true, 3009 => true, 3010 => true, 3011 => true, 3012 => true, 3013 => true, 3015 => true, 3016 => true, 3017 => true, 3022 => true, 3023 => true, 3024 => true, 3025 => true, 3028 => true, 9997 => true, 9998 => true, 9999 => true, 25014 => true, 25015 => true, 50001 => true, 50002 => true, 50006 => true, 50007 => true, 50008 => true, 50009 => true, 50010 => true, 50011 => true, 50012 => true, 50013 => true, 50014 => true, 50015 => true, 50016 => true, 50017 => true, 50018 => true, 50019 => true, 50020 => true, 50021 => true, 50022 => true, 50023 => true, 50024 => true, 50025 => true, 50027 => true, 50028 => true, 50029 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareTypeIds {
    class XoreosArchiveType {
        const KEY = 0;
        const BIF = 1;
        const ERF = 2;
        const RIM = 3;
        const ZIP = 4;
        const EXE = 5;
        const NDS = 6;
        const HERF = 7;
        const NSBTX = 8;
        const MAX = 9;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 8 => true, 9 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareTypeIds {
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

namespace BiowareTypeIds {
    class XoreosGameId {
        const UNKNOWN = -1;
        const NWN = 0;
        const NWN2 = 1;
        const KOTOR = 2;
        const KOTOR2 = 3;
        const JADE = 4;
        const WITCHER = 5;
        const SONIC = 6;
        const DRAGON_AGE = 7;
        const DRAGON_AGE2 = 8;
        const MAX = 9;

        private const _VALUES = [-1 => true, 0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 8 => true, 9 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareTypeIds {
    class XoreosPlatformId {
        const WINDOWS = 0;
        const MAC_OSX = 1;
        const LINUX = 2;
        const XBOX = 3;
        const XBOX360 = 4;
        const PS3 = 5;
        const NDS = 6;
        const ANDROID = 7;
        const IOS = 8;
        const UNKNOWN = 9;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 8 => true, 9 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareTypeIds {
    class XoreosResourceCategory {
        const IMAGE = 0;
        const VIDEO = 1;
        const SOUND = 2;
        const MUSIC = 3;
        const CURSOR = 4;
        const MAX = 5;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}
