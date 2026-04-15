// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.ArrayList;


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
public class Rim extends KaitaiStruct {
    public static Rim fromFile(String fileName) throws IOException {
        return new Rim(new ByteBufferKaitaiStream(fileName));
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

    public Rim(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Rim(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Rim(KaitaiStream _io, KaitaiStruct _parent, Rim _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new RimHeader(this._io, this, _root);
        if (header().offsetToResourceTable() == 0) {
            this.gapBeforeKeyTableImplicit = this._io.readBytes(96);
        }
        if (header().offsetToResourceTable() != 0) {
            this.gapBeforeKeyTableExplicit = this._io.readBytes(header().offsetToResourceTable() - 24);
        }
        if (header().resourceCount() > 0) {
            this.resourceEntryTable = new ResourceEntryTable(this._io, this, _root);
        }
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
        if (header().offsetToResourceTable() == 0) {
        }
        if (header().offsetToResourceTable() != 0) {
        }
        if (header().resourceCount() > 0) {
            this.resourceEntryTable._fetchInstances();
        }
    }
    public static class ResourceEntry extends KaitaiStruct {
        public static ResourceEntry fromFile(String fileName) throws IOException {
            return new ResourceEntry(new ByteBufferKaitaiStream(fileName));
        }

        public ResourceEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ResourceEntry(KaitaiStream _io, Rim.ResourceEntryTable _parent) {
            this(_io, _parent, null);
        }

        public ResourceEntry(KaitaiStream _io, Rim.ResourceEntryTable _parent, Rim _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.resref = new String(this._io.readBytes(16), StandardCharsets.US_ASCII);
            this.resourceType = Rim.XoreosFileTypeId.byId(this._io.readU4le());
            this.resourceId = this._io.readU4le();
            this.offsetToData = this._io.readU4le();
            this.numData = this._io.readU4le();
        }

        public void _fetchInstances() {
            data();
            if (this.data != null) {
                for (int i = 0; i < this.data.size(); i++) {
                }
            }
        }
        private List<Integer> data;

        /**
         * Raw binary data for this resource (read at specified offset)
         */
        public List<Integer> data() {
            if (this.data != null)
                return this.data;
            long _pos = this._io.pos();
            this._io.seek(offsetToData());
            this.data = new ArrayList<Integer>();
            for (int i = 0; i < numData(); i++) {
                this.data.add(this._io.readU1());
            }
            this._io.seek(_pos);
            return this.data;
        }
        private String resref;
        private XoreosFileTypeId resourceType;
        private long resourceId;
        private long offsetToData;
        private long numData;
        private Rim _root;
        private Rim.ResourceEntryTable _parent;

        /**
         * Resource filename (ResRef), null-padded to 16 bytes.
         * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
         * Resource names can be mixed case, though most are lowercase in practice.
         * The game engine typically lowercases ResRefs when loading.
         */
        public String resref() { return resref; }

        /**
         * Resource type identifier (see ResourceType enum).
         * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
         */
        public XoreosFileTypeId resourceType() { return resourceType; }

        /**
         * Resource ID (index, usually sequential).
         * Typically matches the index of this entry in the resource_entry_table.
         * Used for internal reference, but not critical for parsing.
         */
        public long resourceId() { return resourceId; }

        /**
         * Byte offset to resource data from the beginning of the file.
         * Points to the actual binary data for this resource in resource_data_section.
         */
        public long offsetToData() { return offsetToData; }

        /**
         * Size of resource data in bytes (repeat count for raw `data` bytes).
         * Uncompressed size of the resource.
         */
        public long numData() { return numData; }
        public Rim _root() { return _root; }
        public Rim.ResourceEntryTable _parent() { return _parent; }
    }
    public static class ResourceEntryTable extends KaitaiStruct {
        public static ResourceEntryTable fromFile(String fileName) throws IOException {
            return new ResourceEntryTable(new ByteBufferKaitaiStream(fileName));
        }

        public ResourceEntryTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ResourceEntryTable(KaitaiStream _io, Rim _parent) {
            this(_io, _parent, null);
        }

        public ResourceEntryTable(KaitaiStream _io, Rim _parent, Rim _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<ResourceEntry>();
            for (int i = 0; i < _root().header().resourceCount(); i++) {
                this.entries.add(new ResourceEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<ResourceEntry> entries;
        private Rim _root;
        private Rim _parent;

        /**
         * Array of resource entries, one per resource in the archive
         */
        public List<ResourceEntry> entries() { return entries; }
        public Rim _root() { return _root; }
        public Rim _parent() { return _parent; }
    }
    public static class RimHeader extends KaitaiStruct {
        public static RimHeader fromFile(String fileName) throws IOException {
            return new RimHeader(new ByteBufferKaitaiStream(fileName));
        }

        public RimHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public RimHeader(KaitaiStream _io, Rim _parent) {
            this(_io, _parent, null);
        }

        public RimHeader(KaitaiStream _io, Rim _parent, Rim _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.fileType.equals("RIM "))) {
                throw new KaitaiStream.ValidationNotEqualError("RIM ", this.fileType, this._io, "/types/rim_header/seq/0");
            }
            this.fileVersion = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.fileVersion.equals("V1.0"))) {
                throw new KaitaiStream.ValidationNotEqualError("V1.0", this.fileVersion, this._io, "/types/rim_header/seq/1");
            }
            this.reserved = this._io.readU4le();
            this.resourceCount = this._io.readU4le();
            this.offsetToResourceTable = this._io.readU4le();
            this.offsetToResources = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private Boolean hasResources;

        /**
         * Whether the RIM file contains any resources
         */
        public Boolean hasResources() {
            if (this.hasResources != null)
                return this.hasResources;
            this.hasResources = resourceCount() > 0;
            return this.hasResources;
        }
        private String fileType;
        private String fileVersion;
        private long reserved;
        private long resourceCount;
        private long offsetToResourceTable;
        private long offsetToResources;
        private Rim _root;
        private Rim _parent;

        /**
         * File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
         * This identifies the file as a RIM archive.
         */
        public String fileType() { return fileType; }

        /**
         * File format version. Always "V1.0" for KotOR RIM files.
         * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
         */
        public String fileVersion() { return fileVersion; }

        /**
         * Reserved field (typically 0x00000000).
         * Unknown purpose, but always set to 0 in practice.
         */
        public long reserved() { return reserved; }

        /**
         * Number of resources in the archive. This determines:
         * - Number of entries in resource_entry_table
         * - Number of resources in resource_data_section
         */
        public long resourceCount() { return resourceCount; }

        /**
         * Byte offset to the key / resource entry table from the beginning of the file.
         * 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
         * When non-zero, this offset is used directly (commonly 120).
         */
        public long offsetToResourceTable() { return offsetToResourceTable; }

        /**
         * Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
         * taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
         */
        public long offsetToResources() { return offsetToResources; }
        public Rim _root() { return _root; }
        public Rim _parent() { return _parent; }
    }
    private RimHeader header;
    private byte[] gapBeforeKeyTableImplicit;
    private byte[] gapBeforeKeyTableExplicit;
    private ResourceEntryTable resourceEntryTable;
    private Rim _root;
    private KaitaiStruct _parent;

    /**
     * RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
     */
    public RimHeader header() { return header; }

    /**
     * When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
     * After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
     */
    public byte[] gapBeforeKeyTableImplicit() { return gapBeforeKeyTableImplicit; }

    /**
     * When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
     * Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
     */
    public byte[] gapBeforeKeyTableExplicit() { return gapBeforeKeyTableExplicit; }

    /**
     * Array of resource entries mapping ResRefs to resource data
     */
    public ResourceEntryTable resourceEntryTable() { return resourceEntryTable; }
    public Rim _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
