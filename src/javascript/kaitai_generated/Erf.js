// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Erf || (root.Erf = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Erf_, KaitaiStream) {
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

var Erf = (function() {
  Erf.XoreosFileTypeId = Object.freeze({
    NONE: -1,
    RES: 0,
    BMP: 1,
    MVE: 2,
    TGA: 3,
    WAV: 4,
    PLT: 6,
    INI: 7,
    BMU: 8,
    MPG: 9,
    TXT: 10,
    WMA: 11,
    WMV: 12,
    XMV: 13,
    PLH: 2000,
    TEX: 2001,
    MDL: 2002,
    THG: 2003,
    FNT: 2005,
    LUA: 2007,
    SLT: 2008,
    NSS: 2009,
    NCS: 2010,
    MOD: 2011,
    ARE: 2012,
    SET: 2013,
    IFO: 2014,
    BIC: 2015,
    WOK: 2016,
    TWO_DA: 2017,
    TLK: 2018,
    TXI: 2022,
    GIT: 2023,
    BTI: 2024,
    UTI: 2025,
    BTC: 2026,
    UTC: 2027,
    DLG: 2029,
    ITP: 2030,
    BTT: 2031,
    UTT: 2032,
    DDS: 2033,
    BTS: 2034,
    UTS: 2035,
    LTR: 2036,
    GFF: 2037,
    FAC: 2038,
    BTE: 2039,
    UTE: 2040,
    BTD: 2041,
    UTD: 2042,
    BTP: 2043,
    UTP: 2044,
    DFT: 2045,
    GIC: 2046,
    GUI: 2047,
    CSS: 2048,
    CCS: 2049,
    BTM: 2050,
    UTM: 2051,
    DWK: 2052,
    PWK: 2053,
    BTG: 2054,
    UTG: 2055,
    JRL: 2056,
    SAV: 2057,
    UTW: 2058,
    FOUR_PC: 2059,
    SSF: 2060,
    HAK: 2061,
    NWM: 2062,
    BIK: 2063,
    NDB: 2064,
    PTM: 2065,
    PTT: 2066,
    NCM: 2067,
    MFX: 2068,
    MAT: 2069,
    MDB: 2070,
    SAY: 2071,
    TTF: 2072,
    TTC: 2073,
    CUT: 2074,
    KA: 2075,
    JPG: 2076,
    ICO: 2077,
    OGG: 2078,
    SPT: 2079,
    SPW: 2080,
    WFX: 2081,
    UGM: 2082,
    QDB: 2083,
    QST: 2084,
    NPC: 2085,
    SPN: 2086,
    UTX: 2087,
    MMD: 2088,
    SMM: 2089,
    UTA: 2090,
    MDE: 2091,
    MDV: 2092,
    MDA: 2093,
    MBA: 2094,
    OCT: 2095,
    BFX: 2096,
    PDB: 2097,
    THE_WITCHER_SAVE: 2098,
    PVS: 2099,
    CFX: 2100,
    LUC: 2101,
    PRB: 2103,
    CAM: 2104,
    VDS: 2105,
    BIN: 2106,
    WOB: 2107,
    API: 2108,
    PROPERTIES: 2109,
    PNG: 2110,
    LYT: 3000,
    VIS: 3001,
    RIM: 3002,
    PTH: 3003,
    LIP: 3004,
    BWM: 3005,
    TXB: 3006,
    TPC: 3007,
    MDX: 3008,
    RSV: 3009,
    SIG: 3010,
    MAB: 3011,
    QST2: 3012,
    STO: 3013,
    HEX: 3015,
    MDX2: 3016,
    TXB2: 3017,
    FSM: 3022,
    ART: 3023,
    AMP: 3024,
    CWA: 3025,
    BIP: 3028,
    MDB2: 4000,
    MDA2: 4001,
    SPT2: 4002,
    GR2: 4003,
    FXA: 4004,
    FXE: 4005,
    JPG2: 4007,
    PWC: 4008,
    ONE_DA: 9996,
    ERF: 9997,
    BIF: 9998,
    KEY: 9999,
    EXE: 19000,
    DBF: 19001,
    CDX: 19002,
    FPT: 19003,
    ZIP: 20000,
    FXM: 20001,
    FXS: 20002,
    XML: 20003,
    WLK: 20004,
    UTR: 20005,
    SEF: 20006,
    PFX: 20007,
    TFX: 20008,
    IFX: 20009,
    LFX: 20010,
    BBX: 20011,
    PFB: 20012,
    UPE: 20013,
    USC: 20014,
    ULT: 20015,
    FX: 20016,
    MAX: 20017,
    DOC: 20018,
    SCC: 20019,
    WMP: 20020,
    OSC: 20021,
    TRN: 20022,
    UEN: 20023,
    ROS: 20024,
    RST: 20025,
    PTX: 20026,
    LTX: 20027,
    TRX: 20028,
    NDS: 21000,
    HERF: 21001,
    DICT: 21002,
    SMALL: 21003,
    CBGT: 21004,
    CDPTH: 21005,
    EMIT: 21006,
    ITM: 21007,
    NANR: 21008,
    NBFP: 21009,
    NBFS: 21010,
    NCER: 21011,
    NCGR: 21012,
    NCLR: 21013,
    NFTR: 21014,
    NSBCA: 21015,
    NSBMD: 21016,
    NSBTA: 21017,
    NSBTP: 21018,
    NSBTX: 21019,
    PAL: 21020,
    RAW: 21021,
    SADL: 21022,
    SDAT: 21023,
    SMP: 21024,
    SPL: 21025,
    VX: 21026,
    ANB: 22000,
    ANI: 22001,
    CNS: 22002,
    CUR: 22003,
    EVT: 22004,
    FDL: 22005,
    FXO: 22006,
    GAD: 22007,
    GDA: 22008,
    GFX: 22009,
    LDF: 22010,
    LST: 22011,
    MAL: 22012,
    MAO: 22013,
    MMH: 22014,
    MOP: 22015,
    MOR: 22016,
    MSH: 22017,
    MTX: 22018,
    NCC: 22019,
    PHY: 22020,
    PLO: 22021,
    STG: 22022,
    TBI: 22023,
    TNT: 22024,
    ARL: 22025,
    FEV: 22026,
    FSB: 22027,
    OPF: 22028,
    CRF: 22029,
    RIMP: 22030,
    MET: 22031,
    META: 22032,
    FXR: 22033,
    CIF: 22034,
    CUB: 22035,
    DLB: 22036,
    NSC: 22037,
    MOV: 23000,
    CURS: 23001,
    PICT: 23002,
    RSRC: 23003,
    PLIST: 23004,
    CRE: 24000,
    PSO: 24001,
    VSO: 24002,
    ABC: 24003,
    SBM: 24004,
    PVD: 24005,
    PLA: 24006,
    TRG: 24007,
    PK: 24008,
    ALS: 25000,
    APL: 25001,
    ASSEMBLY: 25002,
    BAK: 25003,
    BNK: 25004,
    CL: 25005,
    CNV: 25006,
    CON: 25007,
    DAT: 25008,
    DX11: 25009,
    IDS: 25010,
    LOG: 25011,
    MAP: 25012,
    MML: 25013,
    MP3: 25014,
    PCK: 25015,
    RML: 25016,
    S: 25017,
    STA: 25018,
    SVR: 25019,
    VLM: 25020,
    WBD: 25021,
    XBX: 25022,
    XLS: 25023,
    BZF: 26000,
    ADV: 27000,
    JSON: 28000,
    TLK_EXPERT: 28001,
    TLK_MOBILE: 28002,
    TLK_TOUCH: 28003,
    OTF: 28004,
    PAR: 28005,
    XWB: 29000,
    XSB: 29001,
    XDS: 30000,
    WND: 30001,
    XEOSITEX: 40000,

    "-1": "NONE",
    0: "RES",
    1: "BMP",
    2: "MVE",
    3: "TGA",
    4: "WAV",
    6: "PLT",
    7: "INI",
    8: "BMU",
    9: "MPG",
    10: "TXT",
    11: "WMA",
    12: "WMV",
    13: "XMV",
    2000: "PLH",
    2001: "TEX",
    2002: "MDL",
    2003: "THG",
    2005: "FNT",
    2007: "LUA",
    2008: "SLT",
    2009: "NSS",
    2010: "NCS",
    2011: "MOD",
    2012: "ARE",
    2013: "SET",
    2014: "IFO",
    2015: "BIC",
    2016: "WOK",
    2017: "TWO_DA",
    2018: "TLK",
    2022: "TXI",
    2023: "GIT",
    2024: "BTI",
    2025: "UTI",
    2026: "BTC",
    2027: "UTC",
    2029: "DLG",
    2030: "ITP",
    2031: "BTT",
    2032: "UTT",
    2033: "DDS",
    2034: "BTS",
    2035: "UTS",
    2036: "LTR",
    2037: "GFF",
    2038: "FAC",
    2039: "BTE",
    2040: "UTE",
    2041: "BTD",
    2042: "UTD",
    2043: "BTP",
    2044: "UTP",
    2045: "DFT",
    2046: "GIC",
    2047: "GUI",
    2048: "CSS",
    2049: "CCS",
    2050: "BTM",
    2051: "UTM",
    2052: "DWK",
    2053: "PWK",
    2054: "BTG",
    2055: "UTG",
    2056: "JRL",
    2057: "SAV",
    2058: "UTW",
    2059: "FOUR_PC",
    2060: "SSF",
    2061: "HAK",
    2062: "NWM",
    2063: "BIK",
    2064: "NDB",
    2065: "PTM",
    2066: "PTT",
    2067: "NCM",
    2068: "MFX",
    2069: "MAT",
    2070: "MDB",
    2071: "SAY",
    2072: "TTF",
    2073: "TTC",
    2074: "CUT",
    2075: "KA",
    2076: "JPG",
    2077: "ICO",
    2078: "OGG",
    2079: "SPT",
    2080: "SPW",
    2081: "WFX",
    2082: "UGM",
    2083: "QDB",
    2084: "QST",
    2085: "NPC",
    2086: "SPN",
    2087: "UTX",
    2088: "MMD",
    2089: "SMM",
    2090: "UTA",
    2091: "MDE",
    2092: "MDV",
    2093: "MDA",
    2094: "MBA",
    2095: "OCT",
    2096: "BFX",
    2097: "PDB",
    2098: "THE_WITCHER_SAVE",
    2099: "PVS",
    2100: "CFX",
    2101: "LUC",
    2103: "PRB",
    2104: "CAM",
    2105: "VDS",
    2106: "BIN",
    2107: "WOB",
    2108: "API",
    2109: "PROPERTIES",
    2110: "PNG",
    3000: "LYT",
    3001: "VIS",
    3002: "RIM",
    3003: "PTH",
    3004: "LIP",
    3005: "BWM",
    3006: "TXB",
    3007: "TPC",
    3008: "MDX",
    3009: "RSV",
    3010: "SIG",
    3011: "MAB",
    3012: "QST2",
    3013: "STO",
    3015: "HEX",
    3016: "MDX2",
    3017: "TXB2",
    3022: "FSM",
    3023: "ART",
    3024: "AMP",
    3025: "CWA",
    3028: "BIP",
    4000: "MDB2",
    4001: "MDA2",
    4002: "SPT2",
    4003: "GR2",
    4004: "FXA",
    4005: "FXE",
    4007: "JPG2",
    4008: "PWC",
    9996: "ONE_DA",
    9997: "ERF",
    9998: "BIF",
    9999: "KEY",
    19000: "EXE",
    19001: "DBF",
    19002: "CDX",
    19003: "FPT",
    20000: "ZIP",
    20001: "FXM",
    20002: "FXS",
    20003: "XML",
    20004: "WLK",
    20005: "UTR",
    20006: "SEF",
    20007: "PFX",
    20008: "TFX",
    20009: "IFX",
    20010: "LFX",
    20011: "BBX",
    20012: "PFB",
    20013: "UPE",
    20014: "USC",
    20015: "ULT",
    20016: "FX",
    20017: "MAX",
    20018: "DOC",
    20019: "SCC",
    20020: "WMP",
    20021: "OSC",
    20022: "TRN",
    20023: "UEN",
    20024: "ROS",
    20025: "RST",
    20026: "PTX",
    20027: "LTX",
    20028: "TRX",
    21000: "NDS",
    21001: "HERF",
    21002: "DICT",
    21003: "SMALL",
    21004: "CBGT",
    21005: "CDPTH",
    21006: "EMIT",
    21007: "ITM",
    21008: "NANR",
    21009: "NBFP",
    21010: "NBFS",
    21011: "NCER",
    21012: "NCGR",
    21013: "NCLR",
    21014: "NFTR",
    21015: "NSBCA",
    21016: "NSBMD",
    21017: "NSBTA",
    21018: "NSBTP",
    21019: "NSBTX",
    21020: "PAL",
    21021: "RAW",
    21022: "SADL",
    21023: "SDAT",
    21024: "SMP",
    21025: "SPL",
    21026: "VX",
    22000: "ANB",
    22001: "ANI",
    22002: "CNS",
    22003: "CUR",
    22004: "EVT",
    22005: "FDL",
    22006: "FXO",
    22007: "GAD",
    22008: "GDA",
    22009: "GFX",
    22010: "LDF",
    22011: "LST",
    22012: "MAL",
    22013: "MAO",
    22014: "MMH",
    22015: "MOP",
    22016: "MOR",
    22017: "MSH",
    22018: "MTX",
    22019: "NCC",
    22020: "PHY",
    22021: "PLO",
    22022: "STG",
    22023: "TBI",
    22024: "TNT",
    22025: "ARL",
    22026: "FEV",
    22027: "FSB",
    22028: "OPF",
    22029: "CRF",
    22030: "RIMP",
    22031: "MET",
    22032: "META",
    22033: "FXR",
    22034: "CIF",
    22035: "CUB",
    22036: "DLB",
    22037: "NSC",
    23000: "MOV",
    23001: "CURS",
    23002: "PICT",
    23003: "RSRC",
    23004: "PLIST",
    24000: "CRE",
    24001: "PSO",
    24002: "VSO",
    24003: "ABC",
    24004: "SBM",
    24005: "PVD",
    24006: "PLA",
    24007: "TRG",
    24008: "PK",
    25000: "ALS",
    25001: "APL",
    25002: "ASSEMBLY",
    25003: "BAK",
    25004: "BNK",
    25005: "CL",
    25006: "CNV",
    25007: "CON",
    25008: "DAT",
    25009: "DX11",
    25010: "IDS",
    25011: "LOG",
    25012: "MAP",
    25013: "MML",
    25014: "MP3",
    25015: "PCK",
    25016: "RML",
    25017: "S",
    25018: "STA",
    25019: "SVR",
    25020: "VLM",
    25021: "WBD",
    25022: "XBX",
    25023: "XLS",
    26000: "BZF",
    27000: "ADV",
    28000: "JSON",
    28001: "TLK_EXPERT",
    28002: "TLK_MOBILE",
    28003: "TLK_TOUCH",
    28004: "OTF",
    28005: "PAR",
    29000: "XWB",
    29001: "XSB",
    30000: "XDS",
    30001: "WND",
    40000: "XEOSITEX",
  });

  function Erf(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Erf.prototype._read = function() {
    this.header = new ErfHeader(this._io, this, this._root);
  }

  var ErfHeader = Erf.ErfHeader = (function() {
    function ErfHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ErfHeader.prototype._read = function() {
      this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!( ((this.fileType == "ERF ") || (this.fileType == "MOD ") || (this.fileType == "SAV ") || (this.fileType == "HAK ")) )) {
        throw new KaitaiStream.ValidationNotAnyOfError(this.fileType, this._io, "/types/erf_header/seq/0");
      }
      this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.fileVersion == "V1.0")) {
        throw new KaitaiStream.ValidationNotEqualError("V1.0", this.fileVersion, this._io, "/types/erf_header/seq/1");
      }
      this.languageCount = this._io.readU4le();
      this.localizedStringSize = this._io.readU4le();
      this.entryCount = this._io.readU4le();
      this.offsetToLocalizedStringList = this._io.readU4le();
      this.offsetToKeyList = this._io.readU4le();
      this.offsetToResourceList = this._io.readU4le();
      this.buildYear = this._io.readU4le();
      this.buildDay = this._io.readU4le();
      this.descriptionStrref = this._io.readS4le();
      this.reserved = this._io.readBytes(116);
    }

    /**
     * Heuristic to detect save game files.
     * Save games use MOD signature but typically have description_strref = 0.
     */
    Object.defineProperty(ErfHeader.prototype, 'isSaveFile', {
      get: function() {
        if (this._m_isSaveFile !== undefined)
          return this._m_isSaveFile;
        this._m_isSaveFile =  ((this.fileType == "MOD ") && (this.descriptionStrref == 0)) ;
        return this._m_isSaveFile;
      }
    });

    /**
     * File type signature. Must be one of:
     * - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
     * - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
     * - "SAV " (0x53 0x41 0x56 0x20) - Save game file
     * - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
     */

    /**
     * File format version. Always "V1.0" for KotOR ERF files.
     * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
     */

    /**
     * Number of localized string entries. Typically 0 for most ERF files.
     * MOD files may include localized module names for the load screen.
     */

    /**
     * Total size of localized string data in bytes.
     * Includes all language entries (language_id + string_size + string_data for each).
     */

    /**
     * Number of resources in the archive. This determines:
     * - Number of entries in key_list
     * - Number of entries in resource_list
     * - Number of resource data blocks stored at various offsets
     */

    /**
     * Byte offset to the localized string list from the beginning of the file.
     * Typically 160 (right after header) if present, or 0 if not present.
     */

    /**
     * Byte offset to the key list from the beginning of the file.
     * Typically 160 (right after header) if no localized strings, or after localized strings.
     */

    /**
     * Byte offset to the resource list from the beginning of the file.
     * Located after the key list.
     */

    /**
     * Build year (years since 1900).
     * Example: 103 = year 2003
     * Primarily informational, used by development tools to track module versions.
     */

    /**
     * Build day (days since January 1, with January 1 = day 1).
     * Example: 247 = September 4th (the 247th day of the year)
     * Primarily informational, used by development tools to track module versions.
     */

    /**
     * Description StrRef (TLK string reference) for the archive description.
     * Values vary by file type:
     * - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
     * - SAV files: 0 (typically no description)
     * - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
     */

    /**
     * Reserved padding (usually zeros).
     * Total header size is 160 bytes:
     * file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
     * entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
     * offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
     * reserved (116) = 160 bytes
     */

    return ErfHeader;
  })();

  var KeyEntry = Erf.KeyEntry = (function() {
    function KeyEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    KeyEntry.prototype._read = function() {
      this.resref = KaitaiStream.bytesToStr(this._io.readBytes(16), "ASCII");
      this.resourceId = this._io.readU4le();
      this.resourceType = this._io.readU2le();
      this.unused = this._io.readU2le();
    }

    /**
     * Resource filename (ResRef), null-padded to 16 bytes.
     * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
     * Resource names can be mixed case, though most are lowercase in practice.
     */

    /**
     * Resource ID (index into resource_list).
     * Maps this key entry to the corresponding resource entry.
     */

    /**
     * Resource type identifier (see ResourceType enum).
     * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
     */

    /**
     * Padding/unused field (typically 0)
     */

    return KeyEntry;
  })();

  var KeyList = Erf.KeyList = (function() {
    function KeyList(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    KeyList.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.entryCount; i++) {
        this.entries.push(new KeyEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of key entries mapping ResRefs to resource indices
     */

    return KeyList;
  })();

  var LocalizedStringEntry = Erf.LocalizedStringEntry = (function() {
    function LocalizedStringEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LocalizedStringEntry.prototype._read = function() {
      this.languageId = this._io.readU4le();
      this.stringSize = this._io.readU4le();
      this.stringData = KaitaiStream.bytesToStr(this._io.readBytes(this.stringSize), "UTF-8");
    }

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

    /**
     * Length of string data in bytes
     */

    /**
     * UTF-8 encoded text string
     */

    return LocalizedStringEntry;
  })();

  var LocalizedStringList = Erf.LocalizedStringList = (function() {
    function LocalizedStringList(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LocalizedStringList.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.languageCount; i++) {
        this.entries.push(new LocalizedStringEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of localized string entries, one per language
     */

    return LocalizedStringList;
  })();

  var ResourceEntry = Erf.ResourceEntry = (function() {
    function ResourceEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ResourceEntry.prototype._read = function() {
      this.offsetToData = this._io.readU4le();
      this.lenData = this._io.readU4le();
    }

    /**
     * Raw binary data for this resource
     */
    Object.defineProperty(ResourceEntry.prototype, 'data', {
      get: function() {
        if (this._m_data !== undefined)
          return this._m_data;
        var _pos = this._io.pos;
        this._io.seek(this.offsetToData);
        this._m_data = this._io.readBytes(this.lenData);
        this._io.seek(_pos);
        return this._m_data;
      }
    });

    /**
     * Byte offset to resource data from the beginning of the file.
     * Points to the actual binary data for this resource.
     */

    /**
     * Size of resource data in bytes.
     * Uncompressed size of the resource.
     */

    return ResourceEntry;
  })();

  var ResourceList = Erf.ResourceList = (function() {
    function ResourceList(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ResourceList.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.entryCount; i++) {
        this.entries.push(new ResourceEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of resource entries containing offset and size information
     */

    return ResourceList;
  })();

  /**
   * Array of key entries mapping ResRefs to resource indices
   */
  Object.defineProperty(Erf.prototype, 'keyList', {
    get: function() {
      if (this._m_keyList !== undefined)
        return this._m_keyList;
      var _pos = this._io.pos;
      this._io.seek(this.header.offsetToKeyList);
      this._m_keyList = new KeyList(this._io, this, this._root);
      this._io.seek(_pos);
      return this._m_keyList;
    }
  });

  /**
   * Optional localized string entries for multi-language descriptions
   */
  Object.defineProperty(Erf.prototype, 'localizedStringList', {
    get: function() {
      if (this._m_localizedStringList !== undefined)
        return this._m_localizedStringList;
      if (this.header.languageCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.header.offsetToLocalizedStringList);
        this._m_localizedStringList = new LocalizedStringList(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_localizedStringList;
    }
  });

  /**
   * Array of resource entries containing offset and size information
   */
  Object.defineProperty(Erf.prototype, 'resourceList', {
    get: function() {
      if (this._m_resourceList !== undefined)
        return this._m_resourceList;
      var _pos = this._io.pos;
      this._io.seek(this.header.offsetToResourceList);
      this._m_resourceList = new ResourceList(this._io, this, this._root);
      this._io.seek(_pos);
      return this._m_resourceList;
    }
  });

  /**
   * ERF file header (160 bytes)
   */

  return Erf;
})();
Erf_.Erf = Erf;
});
