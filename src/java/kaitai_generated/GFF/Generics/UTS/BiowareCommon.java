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
 * - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33
 * - https://github.com/modawan/reone/blob/master/include/reone/resource/types.h
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py">PyKotor — Language (substring language IDs)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py">PyKotor — Gender / Game / EquipmentSlot</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py">PyKotor — ObjectType</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L235">PyKotor — GFF field read path (LocalizedString via reader)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73">xoreos — `Language` / `LanguageGender` (Aurora runtime; compare TLK / substring packing)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L57-L92">xoreos — `TalkTable_TLK::load` (TLK header + language id field)</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33">xoreos-tools — `byte` / `uint` typedefs</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/include/reone/resource/types.h">reone — resource type / engine constants</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree (discoverability)</a>
 */
public class BiowareCommon extends KaitaiStruct {
    public static BiowareCommon fromFile(String fileName) throws IOException {
        return new BiowareCommon(new ByteBufferKaitaiStream(fileName));
    }

    public enum BiowareDdsVariantBytesPerPixel {
        DXT1(3),
        DXT5(4);

        private final long id;
        BiowareDdsVariantBytesPerPixel(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareDdsVariantBytesPerPixel> byId = new HashMap<Long, BiowareDdsVariantBytesPerPixel>(2);
        static {
            for (BiowareDdsVariantBytesPerPixel e : BiowareDdsVariantBytesPerPixel.values())
                byId.put(e.id(), e);
        }
        public static BiowareDdsVariantBytesPerPixel byId(long id) { return byId.get(id); }
    }

    public enum BiowareEquipmentSlotFlag {
        INVALID(0),
        HEAD(1),
        ARMOR(2),
        GAUNTLET(8),
        RIGHT_HAND(16),
        LEFT_HAND(32),
        RIGHT_ARM(128),
        LEFT_ARM(256),
        IMPLANT(512),
        BELT(1024),
        CLAW1(16384),
        CLAW2(32768),
        CLAW3(65536),
        HIDE(131072),
        RIGHT_HAND_2(262144),
        LEFT_HAND_2(524288);

        private final long id;
        BiowareEquipmentSlotFlag(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareEquipmentSlotFlag> byId = new HashMap<Long, BiowareEquipmentSlotFlag>(16);
        static {
            for (BiowareEquipmentSlotFlag e : BiowareEquipmentSlotFlag.values())
                byId.put(e.id(), e);
        }
        public static BiowareEquipmentSlotFlag byId(long id) { return byId.get(id); }
    }

    public enum BiowareGameId {
        K1(1),
        K2(2),
        K1_XBOX(3),
        K2_XBOX(4),
        K1_IOS(5),
        K2_IOS(6),
        K1_ANDROID(7),
        K2_ANDROID(8);

        private final long id;
        BiowareGameId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareGameId> byId = new HashMap<Long, BiowareGameId>(8);
        static {
            for (BiowareGameId e : BiowareGameId.values())
                byId.put(e.id(), e);
        }
        public static BiowareGameId byId(long id) { return byId.get(id); }
    }

    public enum BiowareGenderId {
        MALE(0),
        FEMALE(1);

        private final long id;
        BiowareGenderId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareGenderId> byId = new HashMap<Long, BiowareGenderId>(2);
        static {
            for (BiowareGenderId e : BiowareGenderId.values())
                byId.put(e.id(), e);
        }
        public static BiowareGenderId byId(long id) { return byId.get(id); }
    }

    public enum BiowareLanguageId {
        ENGLISH(0),
        FRENCH(1),
        GERMAN(2),
        ITALIAN(3),
        SPANISH(4),
        POLISH(5),
        AFRIKAANS(6),
        BASQUE(7),
        BRETON(9),
        CATALAN(10),
        CHAMORRO(11),
        CHICHEWA(12),
        CORSICAN(13),
        DANISH(14),
        DUTCH(15),
        FAROESE(16),
        FILIPINO(18),
        FINNISH(19),
        FLEMISH(20),
        FRISIAN(21),
        GALICIAN(22),
        GANDA(23),
        HAITIAN_CREOLE(24),
        HAUSA_LATIN(25),
        HAWAIIAN(26),
        ICELANDIC(27),
        IDO(28),
        INDONESIAN(29),
        IGBO(30),
        IRISH(31),
        INTERLINGUA(32),
        JAVANESE_LATIN(33),
        LATIN(34),
        LUXEMBOURGISH(35),
        MALTESE(36),
        NORWEGIAN(37),
        OCCITAN(38),
        PORTUGUESE(39),
        SCOTS(40),
        SCOTTISH_GAELIC(41),
        SHONA(42),
        SOTO(43),
        SUNDANESE_LATIN(44),
        SWAHILI(45),
        SWEDISH(46),
        TAGALOG(47),
        TAHITIAN(48),
        TONGAN(49),
        UZBEK_LATIN(50),
        WALLOON(51),
        XHOSA(52),
        YORUBA(53),
        WELSH(54),
        ZULU(55),
        BULGARIAN(58),
        BELARISIAN(59),
        MACEDONIAN(60),
        RUSSIAN(61),
        SERBIAN_CYRILLIC(62),
        TAJIK(63),
        TATAR_CYRILLIC(64),
        UKRAINIAN(66),
        UZBEK(67),
        ALBANIAN(68),
        BOSNIAN_LATIN(69),
        CZECH(70),
        SLOVAK(71),
        SLOVENE(72),
        CROATIAN(73),
        HUNGARIAN(75),
        ROMANIAN(76),
        GREEK(77),
        ESPERANTO(78),
        AZERBAIJANI_LATIN(79),
        TURKISH(81),
        TURKMEN_LATIN(82),
        HEBREW(83),
        ARABIC(84),
        ESTONIAN(85),
        LATVIAN(86),
        LITHUANIAN(87),
        VIETNAMESE(88),
        THAI(89),
        AYMARA(90),
        KINYARWANDA(91),
        KURDISH_LATIN(92),
        MALAGASY(93),
        MALAY_LATIN(94),
        MAORI(95),
        MOLDOVAN_LATIN(96),
        SAMOAN(97),
        SOMALI(98),
        KOREAN(128),
        CHINESE_TRADITIONAL(129),
        CHINESE_SIMPLIFIED(130),
        JAPANESE(131),
        UNKNOWN(2147483646);

        private final long id;
        BiowareLanguageId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareLanguageId> byId = new HashMap<Long, BiowareLanguageId>(97);
        static {
            for (BiowareLanguageId e : BiowareLanguageId.values())
                byId.put(e.id(), e);
        }
        public static BiowareLanguageId byId(long id) { return byId.get(id); }
    }

    public enum BiowareLipVisemeId {
        NEUTRAL(0),
        EE(1),
        EH(2),
        AH(3),
        OH(4),
        OOH(5),
        Y(6),
        STS(7),
        FV(8),
        NG(9),
        TH(10),
        MPB(11),
        TD(12),
        SH(13),
        L(14),
        KG(15);

        private final long id;
        BiowareLipVisemeId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareLipVisemeId> byId = new HashMap<Long, BiowareLipVisemeId>(16);
        static {
            for (BiowareLipVisemeId e : BiowareLipVisemeId.values())
                byId.put(e.id(), e);
        }
        public static BiowareLipVisemeId byId(long id) { return byId.get(id); }
    }

    public enum BiowareLtrAlphabetLength {
        NEVERWINTER_NIGHTS(26),
        KOTOR(28);

        private final long id;
        BiowareLtrAlphabetLength(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareLtrAlphabetLength> byId = new HashMap<Long, BiowareLtrAlphabetLength>(2);
        static {
            for (BiowareLtrAlphabetLength e : BiowareLtrAlphabetLength.values())
                byId.put(e.id(), e);
        }
        public static BiowareLtrAlphabetLength byId(long id) { return byId.get(id); }
    }

    public enum BiowareObjectTypeId {
        INVALID(0),
        CREATURE(1),
        DOOR(2),
        ITEM(3),
        TRIGGER(4),
        PLACEABLE(5),
        WAYPOINT(6),
        ENCOUNTER(7),
        STORE(8),
        AREA(9),
        SOUND(10),
        CAMERA(11);

        private final long id;
        BiowareObjectTypeId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareObjectTypeId> byId = new HashMap<Long, BiowareObjectTypeId>(12);
        static {
            for (BiowareObjectTypeId e : BiowareObjectTypeId.values())
                byId.put(e.id(), e);
        }
        public static BiowareObjectTypeId byId(long id) { return byId.get(id); }
    }

    public enum BiowarePccCompressionCodec {
        NONE(0),
        ZLIB(1),
        LZO(2);

        private final long id;
        BiowarePccCompressionCodec(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowarePccCompressionCodec> byId = new HashMap<Long, BiowarePccCompressionCodec>(3);
        static {
            for (BiowarePccCompressionCodec e : BiowarePccCompressionCodec.values())
                byId.put(e.id(), e);
        }
        public static BiowarePccCompressionCodec byId(long id) { return byId.get(id); }
    }

    public enum BiowarePccPackageKind {
        NORMAL_PACKAGE(0),
        PATCH_PACKAGE(1);

        private final long id;
        BiowarePccPackageKind(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowarePccPackageKind> byId = new HashMap<Long, BiowarePccPackageKind>(2);
        static {
            for (BiowarePccPackageKind e : BiowarePccPackageKind.values())
                byId.put(e.id(), e);
        }
        public static BiowarePccPackageKind byId(long id) { return byId.get(id); }
    }

    public enum BiowareTpcPixelFormatId {
        GREYSCALE(1),
        RGB_OR_DXT1(2),
        RGBA_OR_DXT5(4),
        BGRA_XBOX_SWIZZLE(12);

        private final long id;
        BiowareTpcPixelFormatId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareTpcPixelFormatId> byId = new HashMap<Long, BiowareTpcPixelFormatId>(4);
        static {
            for (BiowareTpcPixelFormatId e : BiowareTpcPixelFormatId.values())
                byId.put(e.id(), e);
        }
        public static BiowareTpcPixelFormatId byId(long id) { return byId.get(id); }
    }

    public enum RiffWaveFormatTag {
        PCM(1),
        ADPCM_MS(2),
        IEEE_FLOAT(3),
        ALAW(6),
        MULAW(7),
        DVI_IMA_ADPCM(17),
        MPEG_LAYER3(85),
        WAVE_FORMAT_EXTENSIBLE(65534);

        private final long id;
        RiffWaveFormatTag(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, RiffWaveFormatTag> byId = new HashMap<Long, RiffWaveFormatTag>(8);
        static {
            for (RiffWaveFormatTag e : RiffWaveFormatTag.values())
                byId.put(e.id(), e);
        }
        public static RiffWaveFormatTag byId(long id) { return byId.get(id); }
    }

    public BiowareCommon(KaitaiStream _io) {
        this(_io, null, null);
    }

    public BiowareCommon(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public BiowareCommon(KaitaiStream _io, KaitaiStruct _parent, BiowareCommon _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
    }

    public void _fetchInstances() {
    }

    /**
     * Variable-length binary data with 4-byte length prefix.
     * Used for Void/Binary fields in GFF files.
     */
    public static class BiowareBinaryData extends KaitaiStruct {
        public static BiowareBinaryData fromFile(String fileName) throws IOException {
            return new BiowareBinaryData(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareBinaryData(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareBinaryData(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareBinaryData(KaitaiStream _io, KaitaiStruct _parent, BiowareCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.lenValue = this._io.readU4le();
            this.value = this._io.readBytes(lenValue());
        }

        public void _fetchInstances() {
        }
        private long lenValue;
        private byte[] value;
        private BiowareCommon _root;
        private KaitaiStruct _parent;

        /**
         * Length of binary data in bytes
         */
        public long lenValue() { return lenValue; }

        /**
         * Binary data
         */
        public byte[] value() { return value; }
        public BiowareCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * BioWare CExoString - variable-length string with 4-byte length prefix.
     * Used for string fields in GFF files.
     */
    public static class BiowareCexoString extends KaitaiStruct {
        public static BiowareCexoString fromFile(String fileName) throws IOException {
            return new BiowareCexoString(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareCexoString(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareCexoString(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareCexoString(KaitaiStream _io, KaitaiStruct _parent, BiowareCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.lenString = this._io.readU4le();
            this.value = new String(this._io.readBytes(lenString()), StandardCharsets.UTF_8);
        }

        public void _fetchInstances() {
        }
        private long lenString;
        private String value;
        private BiowareCommon _root;
        private KaitaiStruct _parent;

        /**
         * Length of string in bytes
         */
        public long lenString() { return lenString; }

        /**
         * String data (UTF-8)
         */
        public String value() { return value; }
        public BiowareCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
     * section for field type "LocalizedString".
     */
    public static class BiowareLocstring extends KaitaiStruct {
        public static BiowareLocstring fromFile(String fileName) throws IOException {
            return new BiowareLocstring(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareLocstring(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareLocstring(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareLocstring(KaitaiStream _io, KaitaiStruct _parent, BiowareCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.totalSize = this._io.readU4le();
            this.stringRef = this._io.readU4le();
            this.numSubstrings = this._io.readU4le();
            this.substrings = new ArrayList<Substring>();
            for (int i = 0; i < numSubstrings(); i++) {
                this.substrings.add(new Substring(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.substrings.size(); i++) {
                this.substrings.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private Boolean hasStrref;

        /**
         * True if this locstring references dialog.tlk
         */
        public Boolean hasStrref() {
            if (this.hasStrref != null)
                return this.hasStrref;
            this.hasStrref = stringRef() != 4294967295L;
            return this.hasStrref;
        }
        private long totalSize;
        private long stringRef;
        private long numSubstrings;
        private List<Substring> substrings;
        private BiowareCommon _root;
        private KaitaiStruct _parent;

        /**
         * Total size of the structure in bytes (excluding this field).
         */
        public long totalSize() { return totalSize; }

        /**
         * StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).
         */
        public long stringRef() { return stringRef; }

        /**
         * Number of substring entries that follow.
         */
        public long numSubstrings() { return numSubstrings; }

        /**
         * Language/gender-specific substring entries.
         */
        public List<Substring> substrings() { return substrings; }
        public BiowareCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
     * Used throughout GFF files to reference game resources by name.
     */
    public static class BiowareResref extends KaitaiStruct {
        public static BiowareResref fromFile(String fileName) throws IOException {
            return new BiowareResref(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareResref(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareResref(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareResref(KaitaiStream _io, KaitaiStruct _parent, BiowareCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.lenResref = this._io.readU1();
            if (!(this.lenResref <= 16)) {
                throw new KaitaiStream.ValidationGreaterThanError(16, this.lenResref, this._io, "/types/bioware_resref/seq/0");
            }
            this.value = new String(this._io.readBytes(lenResref()), StandardCharsets.US_ASCII);
        }

        public void _fetchInstances() {
        }
        private int lenResref;
        private String value;
        private BiowareCommon _root;
        private KaitaiStruct _parent;

        /**
         * Length of ResRef string (0-16 characters)
         */
        public int lenResref() { return lenResref; }

        /**
         * ResRef string data (ASCII, lowercase recommended)
         */
        public String value() { return value; }
        public BiowareCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * 3D vector (X, Y, Z coordinates).
     * Used for positions, directions, etc. in game files.
     */
    public static class BiowareVector3 extends KaitaiStruct {
        public static BiowareVector3 fromFile(String fileName) throws IOException {
            return new BiowareVector3(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareVector3(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareVector3(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareVector3(KaitaiStream _io, KaitaiStruct _parent, BiowareCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.x = this._io.readF4le();
            this.y = this._io.readF4le();
            this.z = this._io.readF4le();
        }

        public void _fetchInstances() {
        }
        private float x;
        private float y;
        private float z;
        private BiowareCommon _root;
        private KaitaiStruct _parent;

        /**
         * X coordinate
         */
        public float x() { return x; }

        /**
         * Y coordinate
         */
        public float y() { return y; }

        /**
         * Z coordinate
         */
        public float z() { return z; }
        public BiowareCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * 4D vector / Quaternion (X, Y, Z, W components).
     * Used for orientations/rotations in game files.
     */
    public static class BiowareVector4 extends KaitaiStruct {
        public static BiowareVector4 fromFile(String fileName) throws IOException {
            return new BiowareVector4(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareVector4(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareVector4(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareVector4(KaitaiStream _io, KaitaiStruct _parent, BiowareCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.x = this._io.readF4le();
            this.y = this._io.readF4le();
            this.z = this._io.readF4le();
            this.w = this._io.readF4le();
        }

        public void _fetchInstances() {
        }
        private float x;
        private float y;
        private float z;
        private float w;
        private BiowareCommon _root;
        private KaitaiStruct _parent;

        /**
         * X component
         */
        public float x() { return x; }

        /**
         * Y component
         */
        public float y() { return y; }

        /**
         * Z component
         */
        public float z() { return z; }

        /**
         * W component
         */
        public float w() { return w; }
        public BiowareCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }
    public static class Substring extends KaitaiStruct {
        public static Substring fromFile(String fileName) throws IOException {
            return new Substring(new ByteBufferKaitaiStream(fileName));
        }

        public Substring(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Substring(KaitaiStream _io, BiowareCommon.BiowareLocstring _parent) {
            this(_io, _parent, null);
        }

        public Substring(KaitaiStream _io, BiowareCommon.BiowareLocstring _parent, BiowareCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.substringId = this._io.readU4le();
            this.lenText = this._io.readU4le();
            this.text = new String(this._io.readBytes(lenText()), StandardCharsets.UTF_8);
        }

        public void _fetchInstances() {
        }
        private BiowareGenderId gender;

        /**
         * Gender as enum value
         */
        public BiowareGenderId gender() {
            if (this.gender != null)
                return this.gender;
            this.gender = BiowareCommon.BiowareGenderId.byId(genderRaw());
            return this.gender;
        }
        private Integer genderRaw;

        /**
         * Raw gender ID (0..255).
         */
        public Integer genderRaw() {
            if (this.genderRaw != null)
                return this.genderRaw;
            this.genderRaw = ((Number) (substringId() & 255)).intValue();
            return this.genderRaw;
        }
        private BiowareLanguageId language;

        /**
         * Language as enum value
         */
        public BiowareLanguageId language() {
            if (this.language != null)
                return this.language;
            this.language = BiowareCommon.BiowareLanguageId.byId(languageRaw());
            return this.language;
        }
        private Integer languageRaw;

        /**
         * Raw language ID (0..255).
         */
        public Integer languageRaw() {
            if (this.languageRaw != null)
                return this.languageRaw;
            this.languageRaw = ((Number) (substringId() >> 8 & 255)).intValue();
            return this.languageRaw;
        }
        private long substringId;
        private long lenText;
        private String text;
        private BiowareCommon _root;
        private BiowareCommon.BiowareLocstring _parent;

        /**
         * Packed language+gender identifier:
         * - bits 0..7: gender
         * - bits 8..15: language
         */
        public long substringId() { return substringId; }

        /**
         * Length of text in bytes.
         */
        public long lenText() { return lenText; }

        /**
         * Substring text.
         */
        public String text() { return text; }
        public BiowareCommon _root() { return _root; }
        public BiowareCommon.BiowareLocstring _parent() { return _parent; }
    }
    private BiowareCommon _root;
    private KaitaiStruct _parent;
    public BiowareCommon _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
