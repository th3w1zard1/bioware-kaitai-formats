#ifndef RIM_H_
#define RIM_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class rim_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <set>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

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

class rim_t : public kaitai::kstruct {

public:
    class resource_entry_t;
    class resource_entry_table_t;
    class rim_header_t;

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

    rim_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, rim_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~rim_t();

    class resource_entry_t : public kaitai::kstruct {

    public:

        resource_entry_t(kaitai::kstream* p__io, rim_t::resource_entry_table_t* p__parent = 0, rim_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~resource_entry_t();

    private:
        bool f_data;
        std::vector<uint8_t>* m_data;

    public:

        /**
         * Raw binary data for this resource (read at specified offset)
         */
        std::vector<uint8_t>* data();

    private:
        std::string m_resref;
        xoreos_file_type_id_t m_resource_type;
        uint32_t m_resource_id;
        uint32_t m_offset_to_data;
        uint32_t m_num_data;
        rim_t* m__root;
        rim_t::resource_entry_table_t* m__parent;

    public:

        /**
         * Resource filename (ResRef), null-padded to 16 bytes.
         * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
         * Resource names can be mixed case, though most are lowercase in practice.
         * The game engine typically lowercases ResRefs when loading.
         */
        std::string resref() const { return m_resref; }

        /**
         * Resource type identifier (see ResourceType enum).
         * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
         */
        xoreos_file_type_id_t resource_type() const { return m_resource_type; }

        /**
         * Resource ID (index, usually sequential).
         * Typically matches the index of this entry in the resource_entry_table.
         * Used for internal reference, but not critical for parsing.
         */
        uint32_t resource_id() const { return m_resource_id; }

        /**
         * Byte offset to resource data from the beginning of the file.
         * Points to the actual binary data for this resource in resource_data_section.
         */
        uint32_t offset_to_data() const { return m_offset_to_data; }

        /**
         * Size of resource data in bytes (repeat count for raw `data` bytes).
         * Uncompressed size of the resource.
         */
        uint32_t num_data() const { return m_num_data; }
        rim_t* _root() const { return m__root; }
        rim_t::resource_entry_table_t* _parent() const { return m__parent; }
    };

    class resource_entry_table_t : public kaitai::kstruct {

    public:

        resource_entry_table_t(kaitai::kstream* p__io, rim_t* p__parent = 0, rim_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~resource_entry_table_t();

    private:
        std::vector<resource_entry_t*>* m_entries;
        rim_t* m__root;
        rim_t* m__parent;

    public:

        /**
         * Array of resource entries, one per resource in the archive
         */
        std::vector<resource_entry_t*>* entries() const { return m_entries; }
        rim_t* _root() const { return m__root; }
        rim_t* _parent() const { return m__parent; }
    };

    class rim_header_t : public kaitai::kstruct {

    public:

        rim_header_t(kaitai::kstream* p__io, rim_t* p__parent = 0, rim_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~rim_header_t();

    private:
        bool f_has_resources;
        bool m_has_resources;

    public:

        /**
         * Whether the RIM file contains any resources
         */
        bool has_resources();

    private:
        std::string m_file_type;
        std::string m_file_version;
        uint32_t m_reserved;
        uint32_t m_resource_count;
        uint32_t m_offset_to_resource_table;
        uint32_t m_offset_to_resources;
        rim_t* m__root;
        rim_t* m__parent;

    public:

        /**
         * File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
         * This identifies the file as a RIM archive.
         */
        std::string file_type() const { return m_file_type; }

        /**
         * File format version. Always "V1.0" for KotOR RIM files.
         * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
         */
        std::string file_version() const { return m_file_version; }

        /**
         * Reserved field (typically 0x00000000).
         * Unknown purpose, but always set to 0 in practice.
         */
        uint32_t reserved() const { return m_reserved; }

        /**
         * Number of resources in the archive. This determines:
         * - Number of entries in resource_entry_table
         * - Number of resources in resource_data_section
         */
        uint32_t resource_count() const { return m_resource_count; }

        /**
         * Byte offset to the key / resource entry table from the beginning of the file.
         * 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
         * When non-zero, this offset is used directly (commonly 120).
         */
        uint32_t offset_to_resource_table() const { return m_offset_to_resource_table; }

        /**
         * Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
         * taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
         */
        uint32_t offset_to_resources() const { return m_offset_to_resources; }
        rim_t* _root() const { return m__root; }
        rim_t* _parent() const { return m__parent; }
    };

private:
    rim_header_t* m_header;
    std::string m_gap_before_key_table_implicit;
    bool n_gap_before_key_table_implicit;

public:
    bool _is_null_gap_before_key_table_implicit() { gap_before_key_table_implicit(); return n_gap_before_key_table_implicit; };

private:
    std::string m_gap_before_key_table_explicit;
    bool n_gap_before_key_table_explicit;

public:
    bool _is_null_gap_before_key_table_explicit() { gap_before_key_table_explicit(); return n_gap_before_key_table_explicit; };

private:
    resource_entry_table_t* m_resource_entry_table;
    bool n_resource_entry_table;

public:
    bool _is_null_resource_entry_table() { resource_entry_table(); return n_resource_entry_table; };

private:
    rim_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
     */
    rim_header_t* header() const { return m_header; }

    /**
     * When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
     * After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
     */
    std::string gap_before_key_table_implicit() const { return m_gap_before_key_table_implicit; }

    /**
     * When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
     * Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
     */
    std::string gap_before_key_table_explicit() const { return m_gap_before_key_table_explicit; }

    /**
     * Array of resource entries mapping ResRefs to resource data
     */
    resource_entry_table_t* resource_entry_table() const { return m_resource_entry_table; }
    rim_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // RIM_H_
