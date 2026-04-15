// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Rim || (root.Rim = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Rim_, KaitaiStream) {
/**
 * RIM (Resource Information Manager) files are self-contained archives used for module templates.
 * RIM files are similar to ERF files but are read-only from the game's perspective. The game
 * loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
 * RIM files store all resources inline with metadata, making them self-contained archives.
 * 
 * Format Variants:
 * - Standard RIM: Basic module template files
 * - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
 * 
 * Binary Format (KotOR / PyKotor):
 * - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
 * - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
 * - Key / resource entry table (32 bytes per entry): ResRef, type, ID, offset, size
 * - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim
 * - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/rimreader.cpp:24-100
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp:40-160
 * - https://github.com/KotOR-Community-Patches/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs:11-121
 * - https://github.com/KotOR-Community-Patches/KotOR_IO/blob/master/KotOR_IO/File%20Formats/RIM.cs:20-260
 */

var Rim = (function() {
  Rim.XoreosFileTypeId = Object.freeze({
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

  function Rim(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Rim.prototype._read = function() {
    this.header = new RimHeader(this._io, this, this._root);
    if (this.header.offsetToResourceTable == 0) {
      this.gapBeforeKeyTableImplicit = this._io.readBytes(96);
    }
    if (this.header.offsetToResourceTable != 0) {
      this.gapBeforeKeyTableExplicit = this._io.readBytes(this.header.offsetToResourceTable - 24);
    }
    if (this.header.resourceCount > 0) {
      this.resourceEntryTable = new ResourceEntryTable(this._io, this, this._root);
    }
  }

  var ResourceEntry = Rim.ResourceEntry = (function() {
    function ResourceEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ResourceEntry.prototype._read = function() {
      this.resref = KaitaiStream.bytesToStr(this._io.readBytes(16), "ASCII");
      this.resourceType = this._io.readU4le();
      this.resourceId = this._io.readU4le();
      this.offsetToData = this._io.readU4le();
      this.numData = this._io.readU4le();
    }

    /**
     * Raw binary data for this resource (read at specified offset)
     */
    Object.defineProperty(ResourceEntry.prototype, 'data', {
      get: function() {
        if (this._m_data !== undefined)
          return this._m_data;
        var _pos = this._io.pos;
        this._io.seek(this.offsetToData);
        this._m_data = [];
        for (var i = 0; i < this.numData; i++) {
          this._m_data.push(this._io.readU1());
        }
        this._io.seek(_pos);
        return this._m_data;
      }
    });

    /**
     * Resource filename (ResRef), null-padded to 16 bytes.
     * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
     * Resource names can be mixed case, though most are lowercase in practice.
     * The game engine typically lowercases ResRefs when loading.
     */

    /**
     * Resource type identifier (see ResourceType enum).
     * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
     */

    /**
     * Resource ID (index, usually sequential).
     * Typically matches the index of this entry in the resource_entry_table.
     * Used for internal reference, but not critical for parsing.
     */

    /**
     * Byte offset to resource data from the beginning of the file.
     * Points to the actual binary data for this resource in resource_data_section.
     */

    /**
     * Size of resource data in bytes (repeat count for raw `data` bytes).
     * Uncompressed size of the resource.
     */

    return ResourceEntry;
  })();

  var ResourceEntryTable = Rim.ResourceEntryTable = (function() {
    function ResourceEntryTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ResourceEntryTable.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.resourceCount; i++) {
        this.entries.push(new ResourceEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of resource entries, one per resource in the archive
     */

    return ResourceEntryTable;
  })();

  var RimHeader = Rim.RimHeader = (function() {
    function RimHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    RimHeader.prototype._read = function() {
      this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.fileType == "RIM ")) {
        throw new KaitaiStream.ValidationNotEqualError("RIM ", this.fileType, this._io, "/types/rim_header/seq/0");
      }
      this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.fileVersion == "V1.0")) {
        throw new KaitaiStream.ValidationNotEqualError("V1.0", this.fileVersion, this._io, "/types/rim_header/seq/1");
      }
      this.reserved = this._io.readU4le();
      this.resourceCount = this._io.readU4le();
      this.offsetToResourceTable = this._io.readU4le();
      this.offsetToResources = this._io.readU4le();
    }

    /**
     * Whether the RIM file contains any resources
     */
    Object.defineProperty(RimHeader.prototype, 'hasResources', {
      get: function() {
        if (this._m_hasResources !== undefined)
          return this._m_hasResources;
        this._m_hasResources = this.resourceCount > 0;
        return this._m_hasResources;
      }
    });

    /**
     * File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
     * This identifies the file as a RIM archive.
     */

    /**
     * File format version. Always "V1.0" for KotOR RIM files.
     * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
     */

    /**
     * Reserved field (typically 0x00000000).
     * Unknown purpose, but always set to 0 in practice.
     */

    /**
     * Number of resources in the archive. This determines:
     * - Number of entries in resource_entry_table
     * - Number of resources in resource_data_section
     */

    /**
     * Byte offset to the key / resource entry table from the beginning of the file.
     * 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
     * When non-zero, this offset is used directly (commonly 120).
     */

    /**
     * Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
     * taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
     */

    return RimHeader;
  })();

  /**
   * RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
   */

  /**
   * When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
   * After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
   */

  /**
   * When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
   * Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
   */

  /**
   * Array of resource entries mapping ResRefs to resource data
   */

  return Rim;
})();
Rim_.Rim = Rim;
});
