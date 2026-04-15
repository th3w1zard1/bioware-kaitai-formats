#ifndef BIOWARE_TYPE_IDS_H_
#define BIOWARE_TYPE_IDS_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bioware_type_ids_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <set>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

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

class bioware_type_ids_t : public kaitai::kstruct {

public:

    enum bioware_resource_type_id_t {
        BIOWARE_RESOURCE_TYPE_ID_INVALID = -1,
        BIOWARE_RESOURCE_TYPE_ID_RES = 0,
        BIOWARE_RESOURCE_TYPE_ID_BMP = 1,
        BIOWARE_RESOURCE_TYPE_ID_MVE = 2,
        BIOWARE_RESOURCE_TYPE_ID_TGA = 3,
        BIOWARE_RESOURCE_TYPE_ID_WAV = 4,
        BIOWARE_RESOURCE_TYPE_ID_PLT = 6,
        BIOWARE_RESOURCE_TYPE_ID_INI = 7,
        BIOWARE_RESOURCE_TYPE_ID_BMU = 8,
        BIOWARE_RESOURCE_TYPE_ID_MPG = 9,
        BIOWARE_RESOURCE_TYPE_ID_TXT = 10,
        BIOWARE_RESOURCE_TYPE_ID_WMA = 11,
        BIOWARE_RESOURCE_TYPE_ID_WMV = 12,
        BIOWARE_RESOURCE_TYPE_ID_XMV = 13,
        BIOWARE_RESOURCE_TYPE_ID_PLH = 2000,
        BIOWARE_RESOURCE_TYPE_ID_TEX = 2001,
        BIOWARE_RESOURCE_TYPE_ID_MDL = 2002,
        BIOWARE_RESOURCE_TYPE_ID_THG = 2003,
        BIOWARE_RESOURCE_TYPE_ID_FNT = 2005,
        BIOWARE_RESOURCE_TYPE_ID_LUA = 2007,
        BIOWARE_RESOURCE_TYPE_ID_SLT = 2008,
        BIOWARE_RESOURCE_TYPE_ID_NSS = 2009,
        BIOWARE_RESOURCE_TYPE_ID_NCS = 2010,
        BIOWARE_RESOURCE_TYPE_ID_MOD = 2011,
        BIOWARE_RESOURCE_TYPE_ID_ARE = 2012,
        BIOWARE_RESOURCE_TYPE_ID_SET = 2013,
        BIOWARE_RESOURCE_TYPE_ID_IFO = 2014,
        BIOWARE_RESOURCE_TYPE_ID_BIC = 2015,
        BIOWARE_RESOURCE_TYPE_ID_WOK = 2016,
        BIOWARE_RESOURCE_TYPE_ID_TLK = 2018,
        BIOWARE_RESOURCE_TYPE_ID_TXI = 2022,
        BIOWARE_RESOURCE_TYPE_ID_GIT = 2023,
        BIOWARE_RESOURCE_TYPE_ID_BTI = 2024,
        BIOWARE_RESOURCE_TYPE_ID_UTI = 2025,
        BIOWARE_RESOURCE_TYPE_ID_BTC = 2026,
        BIOWARE_RESOURCE_TYPE_ID_UTC = 2027,
        BIOWARE_RESOURCE_TYPE_ID_DLG = 2029,
        BIOWARE_RESOURCE_TYPE_ID_ITP = 2030,
        BIOWARE_RESOURCE_TYPE_ID_BTT = 2031,
        BIOWARE_RESOURCE_TYPE_ID_UTT = 2032,
        BIOWARE_RESOURCE_TYPE_ID_DDS = 2033,
        BIOWARE_RESOURCE_TYPE_ID_BTS = 2034,
        BIOWARE_RESOURCE_TYPE_ID_UTS = 2035,
        BIOWARE_RESOURCE_TYPE_ID_LTR = 2036,
        BIOWARE_RESOURCE_TYPE_ID_GFF = 2037,
        BIOWARE_RESOURCE_TYPE_ID_FAC = 2038,
        BIOWARE_RESOURCE_TYPE_ID_BTE = 2039,
        BIOWARE_RESOURCE_TYPE_ID_UTE = 2040,
        BIOWARE_RESOURCE_TYPE_ID_BTD = 2041,
        BIOWARE_RESOURCE_TYPE_ID_UTD = 2042,
        BIOWARE_RESOURCE_TYPE_ID_BTP = 2043,
        BIOWARE_RESOURCE_TYPE_ID_UTP = 2044,
        BIOWARE_RESOURCE_TYPE_ID_DFT = 2045,
        BIOWARE_RESOURCE_TYPE_ID_GIC = 2046,
        BIOWARE_RESOURCE_TYPE_ID_GUI = 2047,
        BIOWARE_RESOURCE_TYPE_ID_CSS = 2048,
        BIOWARE_RESOURCE_TYPE_ID_CCS = 2049,
        BIOWARE_RESOURCE_TYPE_ID_BTM = 2050,
        BIOWARE_RESOURCE_TYPE_ID_UTM = 2051,
        BIOWARE_RESOURCE_TYPE_ID_DWK = 2052,
        BIOWARE_RESOURCE_TYPE_ID_PWK = 2053,
        BIOWARE_RESOURCE_TYPE_ID_BTG = 2054,
        BIOWARE_RESOURCE_TYPE_ID_UTG = 2055,
        BIOWARE_RESOURCE_TYPE_ID_JRL = 2056,
        BIOWARE_RESOURCE_TYPE_ID_SAV = 2057,
        BIOWARE_RESOURCE_TYPE_ID_UTW = 2058,
        BIOWARE_RESOURCE_TYPE_ID_SSF = 2060,
        BIOWARE_RESOURCE_TYPE_ID_HAK = 2061,
        BIOWARE_RESOURCE_TYPE_ID_NWM = 2062,
        BIOWARE_RESOURCE_TYPE_ID_BIK = 2063,
        BIOWARE_RESOURCE_TYPE_ID_NDB = 2064,
        BIOWARE_RESOURCE_TYPE_ID_PTM = 2065,
        BIOWARE_RESOURCE_TYPE_ID_PTT = 2066,
        BIOWARE_RESOURCE_TYPE_ID_NCM = 2067,
        BIOWARE_RESOURCE_TYPE_ID_MFX = 2068,
        BIOWARE_RESOURCE_TYPE_ID_MAT = 2069,
        BIOWARE_RESOURCE_TYPE_ID_MDB = 2070,
        BIOWARE_RESOURCE_TYPE_ID_SAY = 2071,
        BIOWARE_RESOURCE_TYPE_ID_TTF = 2072,
        BIOWARE_RESOURCE_TYPE_ID_TTC = 2073,
        BIOWARE_RESOURCE_TYPE_ID_CUT = 2074,
        BIOWARE_RESOURCE_TYPE_ID_KA = 2075,
        BIOWARE_RESOURCE_TYPE_ID_JPG = 2076,
        BIOWARE_RESOURCE_TYPE_ID_ICO = 2077,
        BIOWARE_RESOURCE_TYPE_ID_OGG = 2078,
        BIOWARE_RESOURCE_TYPE_ID_SPT = 2079,
        BIOWARE_RESOURCE_TYPE_ID_SPW = 2080,
        BIOWARE_RESOURCE_TYPE_ID_WFX = 2081,
        BIOWARE_RESOURCE_TYPE_ID_UGM = 2082,
        BIOWARE_RESOURCE_TYPE_ID_QDB = 2083,
        BIOWARE_RESOURCE_TYPE_ID_QST = 2084,
        BIOWARE_RESOURCE_TYPE_ID_NPC = 2085,
        BIOWARE_RESOURCE_TYPE_ID_SPN = 2086,
        BIOWARE_RESOURCE_TYPE_ID_UTX = 2087,
        BIOWARE_RESOURCE_TYPE_ID_MMD = 2088,
        BIOWARE_RESOURCE_TYPE_ID_SMM = 2089,
        BIOWARE_RESOURCE_TYPE_ID_UTA = 2090,
        BIOWARE_RESOURCE_TYPE_ID_MDE = 2091,
        BIOWARE_RESOURCE_TYPE_ID_MDV = 2092,
        BIOWARE_RESOURCE_TYPE_ID_MDA = 2093,
        BIOWARE_RESOURCE_TYPE_ID_MBA = 2094,
        BIOWARE_RESOURCE_TYPE_ID_OCT = 2095,
        BIOWARE_RESOURCE_TYPE_ID_BFX = 2096,
        BIOWARE_RESOURCE_TYPE_ID_PDB = 2097,
        BIOWARE_RESOURCE_TYPE_ID_PVS = 2099,
        BIOWARE_RESOURCE_TYPE_ID_CFX = 2100,
        BIOWARE_RESOURCE_TYPE_ID_LUC = 2101,
        BIOWARE_RESOURCE_TYPE_ID_PRB = 2103,
        BIOWARE_RESOURCE_TYPE_ID_CAM = 2104,
        BIOWARE_RESOURCE_TYPE_ID_VDS = 2105,
        BIOWARE_RESOURCE_TYPE_ID_BIN = 2106,
        BIOWARE_RESOURCE_TYPE_ID_WOB = 2107,
        BIOWARE_RESOURCE_TYPE_ID_API = 2108,
        BIOWARE_RESOURCE_TYPE_ID_PNG = 2110,
        BIOWARE_RESOURCE_TYPE_ID_LYT = 3000,
        BIOWARE_RESOURCE_TYPE_ID_VIS = 3001,
        BIOWARE_RESOURCE_TYPE_ID_RIM = 3002,
        BIOWARE_RESOURCE_TYPE_ID_PTH = 3003,
        BIOWARE_RESOURCE_TYPE_ID_LIP = 3004,
        BIOWARE_RESOURCE_TYPE_ID_BWM = 3005,
        BIOWARE_RESOURCE_TYPE_ID_TXB = 3006,
        BIOWARE_RESOURCE_TYPE_ID_TPC = 3007,
        BIOWARE_RESOURCE_TYPE_ID_MDX = 3008,
        BIOWARE_RESOURCE_TYPE_ID_RSV = 3009,
        BIOWARE_RESOURCE_TYPE_ID_SIG = 3010,
        BIOWARE_RESOURCE_TYPE_ID_MAB = 3011,
        BIOWARE_RESOURCE_TYPE_ID_QST2 = 3012,
        BIOWARE_RESOURCE_TYPE_ID_STO = 3013,
        BIOWARE_RESOURCE_TYPE_ID_HEX = 3015,
        BIOWARE_RESOURCE_TYPE_ID_MDX2 = 3016,
        BIOWARE_RESOURCE_TYPE_ID_TXB2 = 3017,
        BIOWARE_RESOURCE_TYPE_ID_FSM = 3022,
        BIOWARE_RESOURCE_TYPE_ID_ART = 3023,
        BIOWARE_RESOURCE_TYPE_ID_AMP = 3024,
        BIOWARE_RESOURCE_TYPE_ID_CWA = 3025,
        BIOWARE_RESOURCE_TYPE_ID_BIP = 3028,
        BIOWARE_RESOURCE_TYPE_ID_ERF = 9997,
        BIOWARE_RESOURCE_TYPE_ID_BIF = 9998,
        BIOWARE_RESOURCE_TYPE_ID_KEY = 9999,
        BIOWARE_RESOURCE_TYPE_ID_MP3 = 25014,
        BIOWARE_RESOURCE_TYPE_ID_WAV_DEOB = 25015,
        BIOWARE_RESOURCE_TYPE_ID_TLK_XML = 50001,
        BIOWARE_RESOURCE_TYPE_ID_MDL_ASCII = 50002,
        BIOWARE_RESOURCE_TYPE_ID_IFO_XML = 50006,
        BIOWARE_RESOURCE_TYPE_ID_GIT_XML = 50007,
        BIOWARE_RESOURCE_TYPE_ID_UTI_XML = 50008,
        BIOWARE_RESOURCE_TYPE_ID_UTC_XML = 50009,
        BIOWARE_RESOURCE_TYPE_ID_DLG_XML = 50010,
        BIOWARE_RESOURCE_TYPE_ID_ITP_XML = 50011,
        BIOWARE_RESOURCE_TYPE_ID_UTT_XML = 50012,
        BIOWARE_RESOURCE_TYPE_ID_UTS_XML = 50013,
        BIOWARE_RESOURCE_TYPE_ID_FAC_XML = 50014,
        BIOWARE_RESOURCE_TYPE_ID_UTE_XML = 50015,
        BIOWARE_RESOURCE_TYPE_ID_UTD_XML = 50016,
        BIOWARE_RESOURCE_TYPE_ID_UTP_XML = 50017,
        BIOWARE_RESOURCE_TYPE_ID_GUI_XML = 50018,
        BIOWARE_RESOURCE_TYPE_ID_UTM_XML = 50019,
        BIOWARE_RESOURCE_TYPE_ID_JRL_XML = 50020,
        BIOWARE_RESOURCE_TYPE_ID_UTW_XML = 50021,
        BIOWARE_RESOURCE_TYPE_ID_PTH_XML = 50022,
        BIOWARE_RESOURCE_TYPE_ID_LIP_XML = 50023,
        BIOWARE_RESOURCE_TYPE_ID_SSF_XML = 50024,
        BIOWARE_RESOURCE_TYPE_ID_ARE_XML = 50025,
        BIOWARE_RESOURCE_TYPE_ID_TLK_JSON = 50027,
        BIOWARE_RESOURCE_TYPE_ID_LIP_JSON = 50028,
        BIOWARE_RESOURCE_TYPE_ID_RES_XML = 50029
    };
    static bool _is_defined_bioware_resource_type_id_t(bioware_resource_type_id_t v);

private:
    static const std::set<bioware_resource_type_id_t> _values_bioware_resource_type_id_t;
    static std::set<bioware_resource_type_id_t> _build_values_bioware_resource_type_id_t();

public:

    enum xoreos_archive_type_t {
        XOREOS_ARCHIVE_TYPE_KEY = 0,
        XOREOS_ARCHIVE_TYPE_BIF = 1,
        XOREOS_ARCHIVE_TYPE_ERF = 2,
        XOREOS_ARCHIVE_TYPE_RIM = 3,
        XOREOS_ARCHIVE_TYPE_ZIP = 4,
        XOREOS_ARCHIVE_TYPE_EXE = 5,
        XOREOS_ARCHIVE_TYPE_NDS = 6,
        XOREOS_ARCHIVE_TYPE_HERF = 7,
        XOREOS_ARCHIVE_TYPE_NSBTX = 8,
        XOREOS_ARCHIVE_TYPE_MAX = 9
    };
    static bool _is_defined_xoreos_archive_type_t(xoreos_archive_type_t v);

private:
    static const std::set<xoreos_archive_type_t> _values_xoreos_archive_type_t;
    static std::set<xoreos_archive_type_t> _build_values_xoreos_archive_type_t();

public:

    enum xoreos_file_type_id_t {
        XOREOS_FILE_TYPE_ID_NONE = -1,
        XOREOS_FILE_TYPE_ID_RES = 0,
        XOREOS_FILE_TYPE_ID_BMP = 1,
        XOREOS_FILE_TYPE_ID_MVE = 2,
        XOREOS_FILE_TYPE_ID_TGA = 3,
        XOREOS_FILE_TYPE_ID_WAV = 4,
        XOREOS_FILE_TYPE_ID_PLT = 6,
        XOREOS_FILE_TYPE_ID_INI = 7,
        XOREOS_FILE_TYPE_ID_BMU = 8,
        XOREOS_FILE_TYPE_ID_MPG = 9,
        XOREOS_FILE_TYPE_ID_TXT = 10,
        XOREOS_FILE_TYPE_ID_WMA = 11,
        XOREOS_FILE_TYPE_ID_WMV = 12,
        XOREOS_FILE_TYPE_ID_XMV = 13,
        XOREOS_FILE_TYPE_ID_PLH = 2000,
        XOREOS_FILE_TYPE_ID_TEX = 2001,
        XOREOS_FILE_TYPE_ID_MDL = 2002,
        XOREOS_FILE_TYPE_ID_THG = 2003,
        XOREOS_FILE_TYPE_ID_FNT = 2005,
        XOREOS_FILE_TYPE_ID_LUA = 2007,
        XOREOS_FILE_TYPE_ID_SLT = 2008,
        XOREOS_FILE_TYPE_ID_NSS = 2009,
        XOREOS_FILE_TYPE_ID_NCS = 2010,
        XOREOS_FILE_TYPE_ID_MOD = 2011,
        XOREOS_FILE_TYPE_ID_ARE = 2012,
        XOREOS_FILE_TYPE_ID_SET = 2013,
        XOREOS_FILE_TYPE_ID_IFO = 2014,
        XOREOS_FILE_TYPE_ID_BIC = 2015,
        XOREOS_FILE_TYPE_ID_WOK = 2016,
        XOREOS_FILE_TYPE_ID_TWO_DA = 2017,
        XOREOS_FILE_TYPE_ID_TLK = 2018,
        XOREOS_FILE_TYPE_ID_TXI = 2022,
        XOREOS_FILE_TYPE_ID_GIT = 2023,
        XOREOS_FILE_TYPE_ID_BTI = 2024,
        XOREOS_FILE_TYPE_ID_UTI = 2025,
        XOREOS_FILE_TYPE_ID_BTC = 2026,
        XOREOS_FILE_TYPE_ID_UTC = 2027,
        XOREOS_FILE_TYPE_ID_DLG = 2029,
        XOREOS_FILE_TYPE_ID_ITP = 2030,
        XOREOS_FILE_TYPE_ID_BTT = 2031,
        XOREOS_FILE_TYPE_ID_UTT = 2032,
        XOREOS_FILE_TYPE_ID_DDS = 2033,
        XOREOS_FILE_TYPE_ID_BTS = 2034,
        XOREOS_FILE_TYPE_ID_UTS = 2035,
        XOREOS_FILE_TYPE_ID_LTR = 2036,
        XOREOS_FILE_TYPE_ID_GFF = 2037,
        XOREOS_FILE_TYPE_ID_FAC = 2038,
        XOREOS_FILE_TYPE_ID_BTE = 2039,
        XOREOS_FILE_TYPE_ID_UTE = 2040,
        XOREOS_FILE_TYPE_ID_BTD = 2041,
        XOREOS_FILE_TYPE_ID_UTD = 2042,
        XOREOS_FILE_TYPE_ID_BTP = 2043,
        XOREOS_FILE_TYPE_ID_UTP = 2044,
        XOREOS_FILE_TYPE_ID_DFT = 2045,
        XOREOS_FILE_TYPE_ID_GIC = 2046,
        XOREOS_FILE_TYPE_ID_GUI = 2047,
        XOREOS_FILE_TYPE_ID_CSS = 2048,
        XOREOS_FILE_TYPE_ID_CCS = 2049,
        XOREOS_FILE_TYPE_ID_BTM = 2050,
        XOREOS_FILE_TYPE_ID_UTM = 2051,
        XOREOS_FILE_TYPE_ID_DWK = 2052,
        XOREOS_FILE_TYPE_ID_PWK = 2053,
        XOREOS_FILE_TYPE_ID_BTG = 2054,
        XOREOS_FILE_TYPE_ID_UTG = 2055,
        XOREOS_FILE_TYPE_ID_JRL = 2056,
        XOREOS_FILE_TYPE_ID_SAV = 2057,
        XOREOS_FILE_TYPE_ID_UTW = 2058,
        XOREOS_FILE_TYPE_ID_FOUR_PC = 2059,
        XOREOS_FILE_TYPE_ID_SSF = 2060,
        XOREOS_FILE_TYPE_ID_HAK = 2061,
        XOREOS_FILE_TYPE_ID_NWM = 2062,
        XOREOS_FILE_TYPE_ID_BIK = 2063,
        XOREOS_FILE_TYPE_ID_NDB = 2064,
        XOREOS_FILE_TYPE_ID_PTM = 2065,
        XOREOS_FILE_TYPE_ID_PTT = 2066,
        XOREOS_FILE_TYPE_ID_NCM = 2067,
        XOREOS_FILE_TYPE_ID_MFX = 2068,
        XOREOS_FILE_TYPE_ID_MAT = 2069,
        XOREOS_FILE_TYPE_ID_MDB = 2070,
        XOREOS_FILE_TYPE_ID_SAY = 2071,
        XOREOS_FILE_TYPE_ID_TTF = 2072,
        XOREOS_FILE_TYPE_ID_TTC = 2073,
        XOREOS_FILE_TYPE_ID_CUT = 2074,
        XOREOS_FILE_TYPE_ID_KA = 2075,
        XOREOS_FILE_TYPE_ID_JPG = 2076,
        XOREOS_FILE_TYPE_ID_ICO = 2077,
        XOREOS_FILE_TYPE_ID_OGG = 2078,
        XOREOS_FILE_TYPE_ID_SPT = 2079,
        XOREOS_FILE_TYPE_ID_SPW = 2080,
        XOREOS_FILE_TYPE_ID_WFX = 2081,
        XOREOS_FILE_TYPE_ID_UGM = 2082,
        XOREOS_FILE_TYPE_ID_QDB = 2083,
        XOREOS_FILE_TYPE_ID_QST = 2084,
        XOREOS_FILE_TYPE_ID_NPC = 2085,
        XOREOS_FILE_TYPE_ID_SPN = 2086,
        XOREOS_FILE_TYPE_ID_UTX = 2087,
        XOREOS_FILE_TYPE_ID_MMD = 2088,
        XOREOS_FILE_TYPE_ID_SMM = 2089,
        XOREOS_FILE_TYPE_ID_UTA = 2090,
        XOREOS_FILE_TYPE_ID_MDE = 2091,
        XOREOS_FILE_TYPE_ID_MDV = 2092,
        XOREOS_FILE_TYPE_ID_MDA = 2093,
        XOREOS_FILE_TYPE_ID_MBA = 2094,
        XOREOS_FILE_TYPE_ID_OCT = 2095,
        XOREOS_FILE_TYPE_ID_BFX = 2096,
        XOREOS_FILE_TYPE_ID_PDB = 2097,
        XOREOS_FILE_TYPE_ID_THE_WITCHER_SAVE = 2098,
        XOREOS_FILE_TYPE_ID_PVS = 2099,
        XOREOS_FILE_TYPE_ID_CFX = 2100,
        XOREOS_FILE_TYPE_ID_LUC = 2101,
        XOREOS_FILE_TYPE_ID_PRB = 2103,
        XOREOS_FILE_TYPE_ID_CAM = 2104,
        XOREOS_FILE_TYPE_ID_VDS = 2105,
        XOREOS_FILE_TYPE_ID_BIN = 2106,
        XOREOS_FILE_TYPE_ID_WOB = 2107,
        XOREOS_FILE_TYPE_ID_API = 2108,
        XOREOS_FILE_TYPE_ID_PROPERTIES = 2109,
        XOREOS_FILE_TYPE_ID_PNG = 2110,
        XOREOS_FILE_TYPE_ID_LYT = 3000,
        XOREOS_FILE_TYPE_ID_VIS = 3001,
        XOREOS_FILE_TYPE_ID_RIM = 3002,
        XOREOS_FILE_TYPE_ID_PTH = 3003,
        XOREOS_FILE_TYPE_ID_LIP = 3004,
        XOREOS_FILE_TYPE_ID_BWM = 3005,
        XOREOS_FILE_TYPE_ID_TXB = 3006,
        XOREOS_FILE_TYPE_ID_TPC = 3007,
        XOREOS_FILE_TYPE_ID_MDX = 3008,
        XOREOS_FILE_TYPE_ID_RSV = 3009,
        XOREOS_FILE_TYPE_ID_SIG = 3010,
        XOREOS_FILE_TYPE_ID_MAB = 3011,
        XOREOS_FILE_TYPE_ID_QST2 = 3012,
        XOREOS_FILE_TYPE_ID_STO = 3013,
        XOREOS_FILE_TYPE_ID_HEX = 3015,
        XOREOS_FILE_TYPE_ID_MDX2 = 3016,
        XOREOS_FILE_TYPE_ID_TXB2 = 3017,
        XOREOS_FILE_TYPE_ID_FSM = 3022,
        XOREOS_FILE_TYPE_ID_ART = 3023,
        XOREOS_FILE_TYPE_ID_AMP = 3024,
        XOREOS_FILE_TYPE_ID_CWA = 3025,
        XOREOS_FILE_TYPE_ID_BIP = 3028,
        XOREOS_FILE_TYPE_ID_MDB2 = 4000,
        XOREOS_FILE_TYPE_ID_MDA2 = 4001,
        XOREOS_FILE_TYPE_ID_SPT2 = 4002,
        XOREOS_FILE_TYPE_ID_GR2 = 4003,
        XOREOS_FILE_TYPE_ID_FXA = 4004,
        XOREOS_FILE_TYPE_ID_FXE = 4005,
        XOREOS_FILE_TYPE_ID_JPG2 = 4007,
        XOREOS_FILE_TYPE_ID_PWC = 4008,
        XOREOS_FILE_TYPE_ID_ONE_DA = 9996,
        XOREOS_FILE_TYPE_ID_ERF = 9997,
        XOREOS_FILE_TYPE_ID_BIF = 9998,
        XOREOS_FILE_TYPE_ID_KEY = 9999,
        XOREOS_FILE_TYPE_ID_EXE = 19000,
        XOREOS_FILE_TYPE_ID_DBF = 19001,
        XOREOS_FILE_TYPE_ID_CDX = 19002,
        XOREOS_FILE_TYPE_ID_FPT = 19003,
        XOREOS_FILE_TYPE_ID_ZIP = 20000,
        XOREOS_FILE_TYPE_ID_FXM = 20001,
        XOREOS_FILE_TYPE_ID_FXS = 20002,
        XOREOS_FILE_TYPE_ID_XML = 20003,
        XOREOS_FILE_TYPE_ID_WLK = 20004,
        XOREOS_FILE_TYPE_ID_UTR = 20005,
        XOREOS_FILE_TYPE_ID_SEF = 20006,
        XOREOS_FILE_TYPE_ID_PFX = 20007,
        XOREOS_FILE_TYPE_ID_TFX = 20008,
        XOREOS_FILE_TYPE_ID_IFX = 20009,
        XOREOS_FILE_TYPE_ID_LFX = 20010,
        XOREOS_FILE_TYPE_ID_BBX = 20011,
        XOREOS_FILE_TYPE_ID_PFB = 20012,
        XOREOS_FILE_TYPE_ID_UPE = 20013,
        XOREOS_FILE_TYPE_ID_USC = 20014,
        XOREOS_FILE_TYPE_ID_ULT = 20015,
        XOREOS_FILE_TYPE_ID_FX = 20016,
        XOREOS_FILE_TYPE_ID_MAX = 20017,
        XOREOS_FILE_TYPE_ID_DOC = 20018,
        XOREOS_FILE_TYPE_ID_SCC = 20019,
        XOREOS_FILE_TYPE_ID_WMP = 20020,
        XOREOS_FILE_TYPE_ID_OSC = 20021,
        XOREOS_FILE_TYPE_ID_TRN = 20022,
        XOREOS_FILE_TYPE_ID_UEN = 20023,
        XOREOS_FILE_TYPE_ID_ROS = 20024,
        XOREOS_FILE_TYPE_ID_RST = 20025,
        XOREOS_FILE_TYPE_ID_PTX = 20026,
        XOREOS_FILE_TYPE_ID_LTX = 20027,
        XOREOS_FILE_TYPE_ID_TRX = 20028,
        XOREOS_FILE_TYPE_ID_NDS = 21000,
        XOREOS_FILE_TYPE_ID_HERF = 21001,
        XOREOS_FILE_TYPE_ID_DICT = 21002,
        XOREOS_FILE_TYPE_ID_SMALL = 21003,
        XOREOS_FILE_TYPE_ID_CBGT = 21004,
        XOREOS_FILE_TYPE_ID_CDPTH = 21005,
        XOREOS_FILE_TYPE_ID_EMIT = 21006,
        XOREOS_FILE_TYPE_ID_ITM = 21007,
        XOREOS_FILE_TYPE_ID_NANR = 21008,
        XOREOS_FILE_TYPE_ID_NBFP = 21009,
        XOREOS_FILE_TYPE_ID_NBFS = 21010,
        XOREOS_FILE_TYPE_ID_NCER = 21011,
        XOREOS_FILE_TYPE_ID_NCGR = 21012,
        XOREOS_FILE_TYPE_ID_NCLR = 21013,
        XOREOS_FILE_TYPE_ID_NFTR = 21014,
        XOREOS_FILE_TYPE_ID_NSBCA = 21015,
        XOREOS_FILE_TYPE_ID_NSBMD = 21016,
        XOREOS_FILE_TYPE_ID_NSBTA = 21017,
        XOREOS_FILE_TYPE_ID_NSBTP = 21018,
        XOREOS_FILE_TYPE_ID_NSBTX = 21019,
        XOREOS_FILE_TYPE_ID_PAL = 21020,
        XOREOS_FILE_TYPE_ID_RAW = 21021,
        XOREOS_FILE_TYPE_ID_SADL = 21022,
        XOREOS_FILE_TYPE_ID_SDAT = 21023,
        XOREOS_FILE_TYPE_ID_SMP = 21024,
        XOREOS_FILE_TYPE_ID_SPL = 21025,
        XOREOS_FILE_TYPE_ID_VX = 21026,
        XOREOS_FILE_TYPE_ID_ANB = 22000,
        XOREOS_FILE_TYPE_ID_ANI = 22001,
        XOREOS_FILE_TYPE_ID_CNS = 22002,
        XOREOS_FILE_TYPE_ID_CUR = 22003,
        XOREOS_FILE_TYPE_ID_EVT = 22004,
        XOREOS_FILE_TYPE_ID_FDL = 22005,
        XOREOS_FILE_TYPE_ID_FXO = 22006,
        XOREOS_FILE_TYPE_ID_GAD = 22007,
        XOREOS_FILE_TYPE_ID_GDA = 22008,
        XOREOS_FILE_TYPE_ID_GFX = 22009,
        XOREOS_FILE_TYPE_ID_LDF = 22010,
        XOREOS_FILE_TYPE_ID_LST = 22011,
        XOREOS_FILE_TYPE_ID_MAL = 22012,
        XOREOS_FILE_TYPE_ID_MAO = 22013,
        XOREOS_FILE_TYPE_ID_MMH = 22014,
        XOREOS_FILE_TYPE_ID_MOP = 22015,
        XOREOS_FILE_TYPE_ID_MOR = 22016,
        XOREOS_FILE_TYPE_ID_MSH = 22017,
        XOREOS_FILE_TYPE_ID_MTX = 22018,
        XOREOS_FILE_TYPE_ID_NCC = 22019,
        XOREOS_FILE_TYPE_ID_PHY = 22020,
        XOREOS_FILE_TYPE_ID_PLO = 22021,
        XOREOS_FILE_TYPE_ID_STG = 22022,
        XOREOS_FILE_TYPE_ID_TBI = 22023,
        XOREOS_FILE_TYPE_ID_TNT = 22024,
        XOREOS_FILE_TYPE_ID_ARL = 22025,
        XOREOS_FILE_TYPE_ID_FEV = 22026,
        XOREOS_FILE_TYPE_ID_FSB = 22027,
        XOREOS_FILE_TYPE_ID_OPF = 22028,
        XOREOS_FILE_TYPE_ID_CRF = 22029,
        XOREOS_FILE_TYPE_ID_RIMP = 22030,
        XOREOS_FILE_TYPE_ID_MET = 22031,
        XOREOS_FILE_TYPE_ID_META = 22032,
        XOREOS_FILE_TYPE_ID_FXR = 22033,
        XOREOS_FILE_TYPE_ID_CIF = 22034,
        XOREOS_FILE_TYPE_ID_CUB = 22035,
        XOREOS_FILE_TYPE_ID_DLB = 22036,
        XOREOS_FILE_TYPE_ID_NSC = 22037,
        XOREOS_FILE_TYPE_ID_MOV = 23000,
        XOREOS_FILE_TYPE_ID_CURS = 23001,
        XOREOS_FILE_TYPE_ID_PICT = 23002,
        XOREOS_FILE_TYPE_ID_RSRC = 23003,
        XOREOS_FILE_TYPE_ID_PLIST = 23004,
        XOREOS_FILE_TYPE_ID_CRE = 24000,
        XOREOS_FILE_TYPE_ID_PSO = 24001,
        XOREOS_FILE_TYPE_ID_VSO = 24002,
        XOREOS_FILE_TYPE_ID_ABC = 24003,
        XOREOS_FILE_TYPE_ID_SBM = 24004,
        XOREOS_FILE_TYPE_ID_PVD = 24005,
        XOREOS_FILE_TYPE_ID_PLA = 24006,
        XOREOS_FILE_TYPE_ID_TRG = 24007,
        XOREOS_FILE_TYPE_ID_PK = 24008,
        XOREOS_FILE_TYPE_ID_ALS = 25000,
        XOREOS_FILE_TYPE_ID_APL = 25001,
        XOREOS_FILE_TYPE_ID_ASSEMBLY = 25002,
        XOREOS_FILE_TYPE_ID_BAK = 25003,
        XOREOS_FILE_TYPE_ID_BNK = 25004,
        XOREOS_FILE_TYPE_ID_CL = 25005,
        XOREOS_FILE_TYPE_ID_CNV = 25006,
        XOREOS_FILE_TYPE_ID_CON = 25007,
        XOREOS_FILE_TYPE_ID_DAT = 25008,
        XOREOS_FILE_TYPE_ID_DX11 = 25009,
        XOREOS_FILE_TYPE_ID_IDS = 25010,
        XOREOS_FILE_TYPE_ID_LOG = 25011,
        XOREOS_FILE_TYPE_ID_MAP = 25012,
        XOREOS_FILE_TYPE_ID_MML = 25013,
        XOREOS_FILE_TYPE_ID_MP3 = 25014,
        XOREOS_FILE_TYPE_ID_PCK = 25015,
        XOREOS_FILE_TYPE_ID_RML = 25016,
        XOREOS_FILE_TYPE_ID_S = 25017,
        XOREOS_FILE_TYPE_ID_STA = 25018,
        XOREOS_FILE_TYPE_ID_SVR = 25019,
        XOREOS_FILE_TYPE_ID_VLM = 25020,
        XOREOS_FILE_TYPE_ID_WBD = 25021,
        XOREOS_FILE_TYPE_ID_XBX = 25022,
        XOREOS_FILE_TYPE_ID_XLS = 25023,
        XOREOS_FILE_TYPE_ID_BZF = 26000,
        XOREOS_FILE_TYPE_ID_ADV = 27000,
        XOREOS_FILE_TYPE_ID_JSON = 28000,
        XOREOS_FILE_TYPE_ID_TLK_EXPERT = 28001,
        XOREOS_FILE_TYPE_ID_TLK_MOBILE = 28002,
        XOREOS_FILE_TYPE_ID_TLK_TOUCH = 28003,
        XOREOS_FILE_TYPE_ID_OTF = 28004,
        XOREOS_FILE_TYPE_ID_PAR = 28005,
        XOREOS_FILE_TYPE_ID_XWB = 29000,
        XOREOS_FILE_TYPE_ID_XSB = 29001,
        XOREOS_FILE_TYPE_ID_XDS = 30000,
        XOREOS_FILE_TYPE_ID_WND = 30001,
        XOREOS_FILE_TYPE_ID_XEOSITEX = 40000
    };
    static bool _is_defined_xoreos_file_type_id_t(xoreos_file_type_id_t v);

private:
    static const std::set<xoreos_file_type_id_t> _values_xoreos_file_type_id_t;
    static std::set<xoreos_file_type_id_t> _build_values_xoreos_file_type_id_t();

public:

    enum xoreos_game_id_t {
        XOREOS_GAME_ID_UNKNOWN = -1,
        XOREOS_GAME_ID_NWN = 0,
        XOREOS_GAME_ID_NWN2 = 1,
        XOREOS_GAME_ID_KOTOR = 2,
        XOREOS_GAME_ID_KOTOR2 = 3,
        XOREOS_GAME_ID_JADE = 4,
        XOREOS_GAME_ID_WITCHER = 5,
        XOREOS_GAME_ID_SONIC = 6,
        XOREOS_GAME_ID_DRAGON_AGE = 7,
        XOREOS_GAME_ID_DRAGON_AGE2 = 8,
        XOREOS_GAME_ID_MAX = 9
    };
    static bool _is_defined_xoreos_game_id_t(xoreos_game_id_t v);

private:
    static const std::set<xoreos_game_id_t> _values_xoreos_game_id_t;
    static std::set<xoreos_game_id_t> _build_values_xoreos_game_id_t();

public:

    enum xoreos_platform_id_t {
        XOREOS_PLATFORM_ID_WINDOWS = 0,
        XOREOS_PLATFORM_ID_MAC_OSX = 1,
        XOREOS_PLATFORM_ID_LINUX = 2,
        XOREOS_PLATFORM_ID_XBOX = 3,
        XOREOS_PLATFORM_ID_XBOX360 = 4,
        XOREOS_PLATFORM_ID_PS3 = 5,
        XOREOS_PLATFORM_ID_NDS = 6,
        XOREOS_PLATFORM_ID_ANDROID = 7,
        XOREOS_PLATFORM_ID_IOS = 8,
        XOREOS_PLATFORM_ID_UNKNOWN = 9
    };
    static bool _is_defined_xoreos_platform_id_t(xoreos_platform_id_t v);

private:
    static const std::set<xoreos_platform_id_t> _values_xoreos_platform_id_t;
    static std::set<xoreos_platform_id_t> _build_values_xoreos_platform_id_t();

public:

    enum xoreos_resource_category_t {
        XOREOS_RESOURCE_CATEGORY_IMAGE = 0,
        XOREOS_RESOURCE_CATEGORY_VIDEO = 1,
        XOREOS_RESOURCE_CATEGORY_SOUND = 2,
        XOREOS_RESOURCE_CATEGORY_MUSIC = 3,
        XOREOS_RESOURCE_CATEGORY_CURSOR = 4,
        XOREOS_RESOURCE_CATEGORY_MAX = 5
    };
    static bool _is_defined_xoreos_resource_category_t(xoreos_resource_category_t v);

private:
    static const std::set<xoreos_resource_category_t> _values_xoreos_resource_category_t;
    static std::set<xoreos_resource_category_t> _build_values_xoreos_resource_category_t();

public:

    bioware_type_ids_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_type_ids_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bioware_type_ids_t();

private:
    bioware_type_ids_t* m__root;
    kaitai::kstruct* m__parent;

public:
    bioware_type_ids_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BIOWARE_TYPE_IDS_H_
