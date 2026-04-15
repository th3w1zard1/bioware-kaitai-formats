// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


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
public class Erf extends KaitaiStruct {
    public static Erf fromFile(String fileName) throws IOException {
        return new Erf(new ByteBufferKaitaiStream(fileName));
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

    public Erf(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Erf(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Erf(KaitaiStream _io, KaitaiStruct _parent, Erf _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new ErfHeader(this._io, this, _root);
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
        keyList();
        if (this.keyList != null) {
            this.keyList._fetchInstances();
        }
        localizedStringList();
        if (this.localizedStringList != null) {
            this.localizedStringList._fetchInstances();
        }
        resourceList();
        if (this.resourceList != null) {
            this.resourceList._fetchInstances();
        }
    }
    public static class ErfHeader extends KaitaiStruct {
        public static ErfHeader fromFile(String fileName) throws IOException {
            return new ErfHeader(new ByteBufferKaitaiStream(fileName));
        }

        public ErfHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ErfHeader(KaitaiStream _io, Erf _parent) {
            this(_io, _parent, null);
        }

        public ErfHeader(KaitaiStream _io, Erf _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!( ((this.fileType.equals("ERF ")) || (this.fileType.equals("MOD ")) || (this.fileType.equals("SAV ")) || (this.fileType.equals("HAK "))) )) {
                throw new KaitaiStream.ValidationNotAnyOfError(this.fileType, this._io, "/types/erf_header/seq/0");
            }
            this.fileVersion = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.fileVersion.equals("V1.0"))) {
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

        public void _fetchInstances() {
        }
        private Boolean isSaveFile;

        /**
         * Heuristic to detect save game files.
         * Save games use MOD signature but typically have description_strref = 0.
         */
        public Boolean isSaveFile() {
            if (this.isSaveFile != null)
                return this.isSaveFile;
            this.isSaveFile =  ((fileType().equals("MOD ")) && (descriptionStrref() == 0)) ;
            return this.isSaveFile;
        }
        private String fileType;
        private String fileVersion;
        private long languageCount;
        private long localizedStringSize;
        private long entryCount;
        private long offsetToLocalizedStringList;
        private long offsetToKeyList;
        private long offsetToResourceList;
        private long buildYear;
        private long buildDay;
        private int descriptionStrref;
        private byte[] reserved;
        private Erf _root;
        private Erf _parent;

        /**
         * File type signature. Must be one of:
         * - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
         * - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
         * - "SAV " (0x53 0x41 0x56 0x20) - Save game file
         * - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
         */
        public String fileType() { return fileType; }

        /**
         * File format version. Always "V1.0" for KotOR ERF files.
         * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
         */
        public String fileVersion() { return fileVersion; }

        /**
         * Number of localized string entries. Typically 0 for most ERF files.
         * MOD files may include localized module names for the load screen.
         */
        public long languageCount() { return languageCount; }

        /**
         * Total size of localized string data in bytes.
         * Includes all language entries (language_id + string_size + string_data for each).
         */
        public long localizedStringSize() { return localizedStringSize; }

        /**
         * Number of resources in the archive. This determines:
         * - Number of entries in key_list
         * - Number of entries in resource_list
         * - Number of resource data blocks stored at various offsets
         */
        public long entryCount() { return entryCount; }

        /**
         * Byte offset to the localized string list from the beginning of the file.
         * Typically 160 (right after header) if present, or 0 if not present.
         */
        public long offsetToLocalizedStringList() { return offsetToLocalizedStringList; }

        /**
         * Byte offset to the key list from the beginning of the file.
         * Typically 160 (right after header) if no localized strings, or after localized strings.
         */
        public long offsetToKeyList() { return offsetToKeyList; }

        /**
         * Byte offset to the resource list from the beginning of the file.
         * Located after the key list.
         */
        public long offsetToResourceList() { return offsetToResourceList; }

        /**
         * Build year (years since 1900).
         * Example: 103 = year 2003
         * Primarily informational, used by development tools to track module versions.
         */
        public long buildYear() { return buildYear; }

        /**
         * Build day (days since January 1, with January 1 = day 1).
         * Example: 247 = September 4th (the 247th day of the year)
         * Primarily informational, used by development tools to track module versions.
         */
        public long buildDay() { return buildDay; }

        /**
         * Description StrRef (TLK string reference) for the archive description.
         * Values vary by file type:
         * - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
         * - SAV files: 0 (typically no description)
         * - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
         */
        public int descriptionStrref() { return descriptionStrref; }

        /**
         * Reserved padding (usually zeros).
         * Total header size is 160 bytes:
         * file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
         * entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
         * offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
         * reserved (116) = 160 bytes
         */
        public byte[] reserved() { return reserved; }
        public Erf _root() { return _root; }
        public Erf _parent() { return _parent; }
    }
    public static class KeyEntry extends KaitaiStruct {
        public static KeyEntry fromFile(String fileName) throws IOException {
            return new KeyEntry(new ByteBufferKaitaiStream(fileName));
        }

        public KeyEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public KeyEntry(KaitaiStream _io, Erf.KeyList _parent) {
            this(_io, _parent, null);
        }

        public KeyEntry(KaitaiStream _io, Erf.KeyList _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.resref = new String(this._io.readBytes(16), StandardCharsets.US_ASCII);
            this.resourceId = this._io.readU4le();
            this.resourceType = Erf.XoreosFileTypeId.byId(this._io.readU2le());
            this.unused = this._io.readU2le();
        }

        public void _fetchInstances() {
        }
        private String resref;
        private long resourceId;
        private XoreosFileTypeId resourceType;
        private int unused;
        private Erf _root;
        private Erf.KeyList _parent;

        /**
         * Resource filename (ResRef), null-padded to 16 bytes.
         * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
         * Resource names can be mixed case, though most are lowercase in practice.
         */
        public String resref() { return resref; }

        /**
         * Resource ID (index into resource_list).
         * Maps this key entry to the corresponding resource entry.
         */
        public long resourceId() { return resourceId; }

        /**
         * Resource type identifier (see ResourceType enum).
         * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
         */
        public XoreosFileTypeId resourceType() { return resourceType; }

        /**
         * Padding/unused field (typically 0)
         */
        public int unused() { return unused; }
        public Erf _root() { return _root; }
        public Erf.KeyList _parent() { return _parent; }
    }
    public static class KeyList extends KaitaiStruct {
        public static KeyList fromFile(String fileName) throws IOException {
            return new KeyList(new ByteBufferKaitaiStream(fileName));
        }

        public KeyList(KaitaiStream _io) {
            this(_io, null, null);
        }

        public KeyList(KaitaiStream _io, Erf _parent) {
            this(_io, _parent, null);
        }

        public KeyList(KaitaiStream _io, Erf _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<KeyEntry>();
            for (int i = 0; i < _root().header().entryCount(); i++) {
                this.entries.add(new KeyEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<KeyEntry> entries;
        private Erf _root;
        private Erf _parent;

        /**
         * Array of key entries mapping ResRefs to resource indices
         */
        public List<KeyEntry> entries() { return entries; }
        public Erf _root() { return _root; }
        public Erf _parent() { return _parent; }
    }
    public static class LocalizedStringEntry extends KaitaiStruct {
        public static LocalizedStringEntry fromFile(String fileName) throws IOException {
            return new LocalizedStringEntry(new ByteBufferKaitaiStream(fileName));
        }

        public LocalizedStringEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LocalizedStringEntry(KaitaiStream _io, Erf.LocalizedStringList _parent) {
            this(_io, _parent, null);
        }

        public LocalizedStringEntry(KaitaiStream _io, Erf.LocalizedStringList _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.languageId = this._io.readU4le();
            this.stringSize = this._io.readU4le();
            this.stringData = new String(this._io.readBytes(stringSize()), StandardCharsets.UTF_8);
        }

        public void _fetchInstances() {
        }
        private long languageId;
        private long stringSize;
        private String stringData;
        private Erf _root;
        private Erf.LocalizedStringList _parent;

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
        public long languageId() { return languageId; }

        /**
         * Length of string data in bytes
         */
        public long stringSize() { return stringSize; }

        /**
         * UTF-8 encoded text string
         */
        public String stringData() { return stringData; }
        public Erf _root() { return _root; }
        public Erf.LocalizedStringList _parent() { return _parent; }
    }
    public static class LocalizedStringList extends KaitaiStruct {
        public static LocalizedStringList fromFile(String fileName) throws IOException {
            return new LocalizedStringList(new ByteBufferKaitaiStream(fileName));
        }

        public LocalizedStringList(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LocalizedStringList(KaitaiStream _io, Erf _parent) {
            this(_io, _parent, null);
        }

        public LocalizedStringList(KaitaiStream _io, Erf _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<LocalizedStringEntry>();
            for (int i = 0; i < _root().header().languageCount(); i++) {
                this.entries.add(new LocalizedStringEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<LocalizedStringEntry> entries;
        private Erf _root;
        private Erf _parent;

        /**
         * Array of localized string entries, one per language
         */
        public List<LocalizedStringEntry> entries() { return entries; }
        public Erf _root() { return _root; }
        public Erf _parent() { return _parent; }
    }
    public static class ResourceEntry extends KaitaiStruct {
        public static ResourceEntry fromFile(String fileName) throws IOException {
            return new ResourceEntry(new ByteBufferKaitaiStream(fileName));
        }

        public ResourceEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ResourceEntry(KaitaiStream _io, Erf.ResourceList _parent) {
            this(_io, _parent, null);
        }

        public ResourceEntry(KaitaiStream _io, Erf.ResourceList _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.offsetToData = this._io.readU4le();
            this.lenData = this._io.readU4le();
        }

        public void _fetchInstances() {
            data();
            if (this.data != null) {
            }
        }
        private byte[] data;

        /**
         * Raw binary data for this resource
         */
        public byte[] data() {
            if (this.data != null)
                return this.data;
            long _pos = this._io.pos();
            this._io.seek(offsetToData());
            this.data = this._io.readBytes(lenData());
            this._io.seek(_pos);
            return this.data;
        }
        private long offsetToData;
        private long lenData;
        private Erf _root;
        private Erf.ResourceList _parent;

        /**
         * Byte offset to resource data from the beginning of the file.
         * Points to the actual binary data for this resource.
         */
        public long offsetToData() { return offsetToData; }

        /**
         * Size of resource data in bytes.
         * Uncompressed size of the resource.
         */
        public long lenData() { return lenData; }
        public Erf _root() { return _root; }
        public Erf.ResourceList _parent() { return _parent; }
    }
    public static class ResourceList extends KaitaiStruct {
        public static ResourceList fromFile(String fileName) throws IOException {
            return new ResourceList(new ByteBufferKaitaiStream(fileName));
        }

        public ResourceList(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ResourceList(KaitaiStream _io, Erf _parent) {
            this(_io, _parent, null);
        }

        public ResourceList(KaitaiStream _io, Erf _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<ResourceEntry>();
            for (int i = 0; i < _root().header().entryCount(); i++) {
                this.entries.add(new ResourceEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<ResourceEntry> entries;
        private Erf _root;
        private Erf _parent;

        /**
         * Array of resource entries containing offset and size information
         */
        public List<ResourceEntry> entries() { return entries; }
        public Erf _root() { return _root; }
        public Erf _parent() { return _parent; }
    }
    private KeyList keyList;

    /**
     * Array of key entries mapping ResRefs to resource indices
     */
    public KeyList keyList() {
        if (this.keyList != null)
            return this.keyList;
        long _pos = this._io.pos();
        this._io.seek(header().offsetToKeyList());
        this.keyList = new KeyList(this._io, this, _root);
        this._io.seek(_pos);
        return this.keyList;
    }
    private LocalizedStringList localizedStringList;

    /**
     * Optional localized string entries for multi-language descriptions
     */
    public LocalizedStringList localizedStringList() {
        if (this.localizedStringList != null)
            return this.localizedStringList;
        if (header().languageCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(header().offsetToLocalizedStringList());
            this.localizedStringList = new LocalizedStringList(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.localizedStringList;
    }
    private ResourceList resourceList;

    /**
     * Array of resource entries containing offset and size information
     */
    public ResourceList resourceList() {
        if (this.resourceList != null)
            return this.resourceList;
        long _pos = this._io.pos();
        this._io.seek(header().offsetToResourceList());
        this.resourceList = new ResourceList(this._io, this, _root);
        this._io.seek(_pos);
        return this.resourceList;
    }
    private ErfHeader header;
    private Erf _root;
    private KaitaiStruct _parent;

    /**
     * ERF file header (160 bytes)
     */
    public ErfHeader header() { return header; }
    public Erf _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
