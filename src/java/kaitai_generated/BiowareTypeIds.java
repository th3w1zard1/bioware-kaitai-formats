// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;


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
public class BiowareTypeIds extends KaitaiStruct {
    public static BiowareTypeIds fromFile(String fileName) throws IOException {
        return new BiowareTypeIds(new ByteBufferKaitaiStream(fileName));
    }

    public enum BiowareResourceTypeId {
        INVALID(-1),
        RES(0),
        BMP(1),
        MVE(2),
        TGA(3),
        WAV(4),
        PLT(6),
        INI(7),
        BMU(8),
        MPG(9),
        TXT(10),
        WMA(11),
        WMV(12),
        XMV(13),
        PLH(2000),
        TEX(2001),
        MDL(2002),
        THG(2003),
        FNT(2005),
        LUA(2007),
        SLT(2008),
        NSS(2009),
        NCS(2010),
        MOD(2011),
        ARE(2012),
        SET(2013),
        IFO(2014),
        BIC(2015),
        WOK(2016),
        TLK(2018),
        TXI(2022),
        GIT(2023),
        BTI(2024),
        UTI(2025),
        BTC(2026),
        UTC(2027),
        DLG(2029),
        ITP(2030),
        BTT(2031),
        UTT(2032),
        DDS(2033),
        BTS(2034),
        UTS(2035),
        LTR(2036),
        GFF(2037),
        FAC(2038),
        BTE(2039),
        UTE(2040),
        BTD(2041),
        UTD(2042),
        BTP(2043),
        UTP(2044),
        DFT(2045),
        GIC(2046),
        GUI(2047),
        CSS(2048),
        CCS(2049),
        BTM(2050),
        UTM(2051),
        DWK(2052),
        PWK(2053),
        BTG(2054),
        UTG(2055),
        JRL(2056),
        SAV(2057),
        UTW(2058),
        SSF(2060),
        HAK(2061),
        NWM(2062),
        BIK(2063),
        NDB(2064),
        PTM(2065),
        PTT(2066),
        NCM(2067),
        MFX(2068),
        MAT(2069),
        MDB(2070),
        SAY(2071),
        TTF(2072),
        TTC(2073),
        CUT(2074),
        KA(2075),
        JPG(2076),
        ICO(2077),
        OGG(2078),
        SPT(2079),
        SPW(2080),
        WFX(2081),
        UGM(2082),
        QDB(2083),
        QST(2084),
        NPC(2085),
        SPN(2086),
        UTX(2087),
        MMD(2088),
        SMM(2089),
        UTA(2090),
        MDE(2091),
        MDV(2092),
        MDA(2093),
        MBA(2094),
        OCT(2095),
        BFX(2096),
        PDB(2097),
        PVS(2099),
        CFX(2100),
        LUC(2101),
        PRB(2103),
        CAM(2104),
        VDS(2105),
        BIN(2106),
        WOB(2107),
        API(2108),
        PNG(2110),
        LYT(3000),
        VIS(3001),
        RIM(3002),
        PTH(3003),
        LIP(3004),
        BWM(3005),
        TXB(3006),
        TPC(3007),
        MDX(3008),
        RSV(3009),
        SIG(3010),
        MAB(3011),
        QST2(3012),
        STO(3013),
        HEX(3015),
        MDX2(3016),
        TXB2(3017),
        FSM(3022),
        ART(3023),
        AMP(3024),
        CWA(3025),
        BIP(3028),
        ERF(9997),
        BIF(9998),
        KEY(9999),
        MP3(25014),
        WAV_DEOB(25015),
        TLK_XML(50001),
        MDL_ASCII(50002),
        IFO_XML(50006),
        GIT_XML(50007),
        UTI_XML(50008),
        UTC_XML(50009),
        DLG_XML(50010),
        ITP_XML(50011),
        UTT_XML(50012),
        UTS_XML(50013),
        FAC_XML(50014),
        UTE_XML(50015),
        UTD_XML(50016),
        UTP_XML(50017),
        GUI_XML(50018),
        UTM_XML(50019),
        JRL_XML(50020),
        UTW_XML(50021),
        PTH_XML(50022),
        LIP_XML(50023),
        SSF_XML(50024),
        ARE_XML(50025),
        TLK_JSON(50027),
        LIP_JSON(50028),
        RES_XML(50029);

        private final long id;
        BiowareResourceTypeId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareResourceTypeId> byId = new HashMap<Long, BiowareResourceTypeId>(166);
        static {
            for (BiowareResourceTypeId e : BiowareResourceTypeId.values())
                byId.put(e.id(), e);
        }
        public static BiowareResourceTypeId byId(long id) { return byId.get(id); }
    }

    public enum XoreosArchiveType {
        KEY(0),
        BIF(1),
        ERF(2),
        RIM(3),
        ZIP(4),
        EXE(5),
        NDS(6),
        HERF(7),
        NSBTX(8),
        MAX(9);

        private final long id;
        XoreosArchiveType(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, XoreosArchiveType> byId = new HashMap<Long, XoreosArchiveType>(10);
        static {
            for (XoreosArchiveType e : XoreosArchiveType.values())
                byId.put(e.id(), e);
        }
        public static XoreosArchiveType byId(long id) { return byId.get(id); }
    }

    public enum XoreosFileTypeId {
        NONE(-1),
        RES(0),
        BMP(1),
        MVE(2),
        TGA(3),
        WAV(4),
        PLT(6),
        INI(7),
        BMU(8),
        MPG(9),
        TXT(10),
        WMA(11),
        WMV(12),
        XMV(13),
        PLH(2000),
        TEX(2001),
        MDL(2002),
        THG(2003),
        FNT(2005),
        LUA(2007),
        SLT(2008),
        NSS(2009),
        NCS(2010),
        MOD(2011),
        ARE(2012),
        SET(2013),
        IFO(2014),
        BIC(2015),
        WOK(2016),
        TWO_DA(2017),
        TLK(2018),
        TXI(2022),
        GIT(2023),
        BTI(2024),
        UTI(2025),
        BTC(2026),
        UTC(2027),
        DLG(2029),
        ITP(2030),
        BTT(2031),
        UTT(2032),
        DDS(2033),
        BTS(2034),
        UTS(2035),
        LTR(2036),
        GFF(2037),
        FAC(2038),
        BTE(2039),
        UTE(2040),
        BTD(2041),
        UTD(2042),
        BTP(2043),
        UTP(2044),
        DFT(2045),
        GIC(2046),
        GUI(2047),
        CSS(2048),
        CCS(2049),
        BTM(2050),
        UTM(2051),
        DWK(2052),
        PWK(2053),
        BTG(2054),
        UTG(2055),
        JRL(2056),
        SAV(2057),
        UTW(2058),
        FOUR_PC(2059),
        SSF(2060),
        HAK(2061),
        NWM(2062),
        BIK(2063),
        NDB(2064),
        PTM(2065),
        PTT(2066),
        NCM(2067),
        MFX(2068),
        MAT(2069),
        MDB(2070),
        SAY(2071),
        TTF(2072),
        TTC(2073),
        CUT(2074),
        KA(2075),
        JPG(2076),
        ICO(2077),
        OGG(2078),
        SPT(2079),
        SPW(2080),
        WFX(2081),
        UGM(2082),
        QDB(2083),
        QST(2084),
        NPC(2085),
        SPN(2086),
        UTX(2087),
        MMD(2088),
        SMM(2089),
        UTA(2090),
        MDE(2091),
        MDV(2092),
        MDA(2093),
        MBA(2094),
        OCT(2095),
        BFX(2096),
        PDB(2097),
        THE_WITCHER_SAVE(2098),
        PVS(2099),
        CFX(2100),
        LUC(2101),
        PRB(2103),
        CAM(2104),
        VDS(2105),
        BIN(2106),
        WOB(2107),
        API(2108),
        PROPERTIES(2109),
        PNG(2110),
        LYT(3000),
        VIS(3001),
        RIM(3002),
        PTH(3003),
        LIP(3004),
        BWM(3005),
        TXB(3006),
        TPC(3007),
        MDX(3008),
        RSV(3009),
        SIG(3010),
        MAB(3011),
        QST2(3012),
        STO(3013),
        HEX(3015),
        MDX2(3016),
        TXB2(3017),
        FSM(3022),
        ART(3023),
        AMP(3024),
        CWA(3025),
        BIP(3028),
        MDB2(4000),
        MDA2(4001),
        SPT2(4002),
        GR2(4003),
        FXA(4004),
        FXE(4005),
        JPG2(4007),
        PWC(4008),
        ONE_DA(9996),
        ERF(9997),
        BIF(9998),
        KEY(9999),
        EXE(19000),
        DBF(19001),
        CDX(19002),
        FPT(19003),
        ZIP(20000),
        FXM(20001),
        FXS(20002),
        XML(20003),
        WLK(20004),
        UTR(20005),
        SEF(20006),
        PFX(20007),
        TFX(20008),
        IFX(20009),
        LFX(20010),
        BBX(20011),
        PFB(20012),
        UPE(20013),
        USC(20014),
        ULT(20015),
        FX(20016),
        MAX(20017),
        DOC(20018),
        SCC(20019),
        WMP(20020),
        OSC(20021),
        TRN(20022),
        UEN(20023),
        ROS(20024),
        RST(20025),
        PTX(20026),
        LTX(20027),
        TRX(20028),
        NDS(21000),
        HERF(21001),
        DICT(21002),
        SMALL(21003),
        CBGT(21004),
        CDPTH(21005),
        EMIT(21006),
        ITM(21007),
        NANR(21008),
        NBFP(21009),
        NBFS(21010),
        NCER(21011),
        NCGR(21012),
        NCLR(21013),
        NFTR(21014),
        NSBCA(21015),
        NSBMD(21016),
        NSBTA(21017),
        NSBTP(21018),
        NSBTX(21019),
        PAL(21020),
        RAW(21021),
        SADL(21022),
        SDAT(21023),
        SMP(21024),
        SPL(21025),
        VX(21026),
        ANB(22000),
        ANI(22001),
        CNS(22002),
        CUR(22003),
        EVT(22004),
        FDL(22005),
        FXO(22006),
        GAD(22007),
        GDA(22008),
        GFX(22009),
        LDF(22010),
        LST(22011),
        MAL(22012),
        MAO(22013),
        MMH(22014),
        MOP(22015),
        MOR(22016),
        MSH(22017),
        MTX(22018),
        NCC(22019),
        PHY(22020),
        PLO(22021),
        STG(22022),
        TBI(22023),
        TNT(22024),
        ARL(22025),
        FEV(22026),
        FSB(22027),
        OPF(22028),
        CRF(22029),
        RIMP(22030),
        MET(22031),
        META(22032),
        FXR(22033),
        CIF(22034),
        CUB(22035),
        DLB(22036),
        NSC(22037),
        MOV(23000),
        CURS(23001),
        PICT(23002),
        RSRC(23003),
        PLIST(23004),
        CRE(24000),
        PSO(24001),
        VSO(24002),
        ABC(24003),
        SBM(24004),
        PVD(24005),
        PLA(24006),
        TRG(24007),
        PK(24008),
        ALS(25000),
        APL(25001),
        ASSEMBLY(25002),
        BAK(25003),
        BNK(25004),
        CL(25005),
        CNV(25006),
        CON(25007),
        DAT(25008),
        DX11(25009),
        IDS(25010),
        LOG(25011),
        MAP(25012),
        MML(25013),
        MP3(25014),
        PCK(25015),
        RML(25016),
        S(25017),
        STA(25018),
        SVR(25019),
        VLM(25020),
        WBD(25021),
        XBX(25022),
        XLS(25023),
        BZF(26000),
        ADV(27000),
        JSON(28000),
        TLK_EXPERT(28001),
        TLK_MOBILE(28002),
        TLK_TOUCH(28003),
        OTF(28004),
        PAR(28005),
        XWB(29000),
        XSB(29001),
        XDS(30000),
        WND(30001),
        XEOSITEX(40000);

        private final long id;
        XoreosFileTypeId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, XoreosFileTypeId> byId = new HashMap<Long, XoreosFileTypeId>(301);
        static {
            for (XoreosFileTypeId e : XoreosFileTypeId.values())
                byId.put(e.id(), e);
        }
        public static XoreosFileTypeId byId(long id) { return byId.get(id); }
    }

    public enum XoreosGameId {
        UNKNOWN(-1),
        NWN(0),
        NWN2(1),
        KOTOR(2),
        KOTOR2(3),
        JADE(4),
        WITCHER(5),
        SONIC(6),
        DRAGON_AGE(7),
        DRAGON_AGE2(8),
        MAX(9);

        private final long id;
        XoreosGameId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, XoreosGameId> byId = new HashMap<Long, XoreosGameId>(11);
        static {
            for (XoreosGameId e : XoreosGameId.values())
                byId.put(e.id(), e);
        }
        public static XoreosGameId byId(long id) { return byId.get(id); }
    }

    public enum XoreosPlatformId {
        WINDOWS(0),
        MAC_OSX(1),
        LINUX(2),
        XBOX(3),
        XBOX360(4),
        PS3(5),
        NDS(6),
        ANDROID(7),
        IOS(8),
        UNKNOWN(9);

        private final long id;
        XoreosPlatformId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, XoreosPlatformId> byId = new HashMap<Long, XoreosPlatformId>(10);
        static {
            for (XoreosPlatformId e : XoreosPlatformId.values())
                byId.put(e.id(), e);
        }
        public static XoreosPlatformId byId(long id) { return byId.get(id); }
    }

    public enum XoreosResourceCategory {
        IMAGE(0),
        VIDEO(1),
        SOUND(2),
        MUSIC(3),
        CURSOR(4),
        MAX(5);

        private final long id;
        XoreosResourceCategory(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, XoreosResourceCategory> byId = new HashMap<Long, XoreosResourceCategory>(6);
        static {
            for (XoreosResourceCategory e : XoreosResourceCategory.values())
                byId.put(e.id(), e);
        }
        public static XoreosResourceCategory byId(long id) { return byId.get(id); }
    }

    public BiowareTypeIds(KaitaiStream _io) {
        this(_io, null, null);
    }

    public BiowareTypeIds(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public BiowareTypeIds(KaitaiStream _io, KaitaiStruct _parent, BiowareTypeIds _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
    }

    public void _fetchInstances() {
    }
    private BiowareTypeIds _root;
    private KaitaiStruct _parent;
    public BiowareTypeIds _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
