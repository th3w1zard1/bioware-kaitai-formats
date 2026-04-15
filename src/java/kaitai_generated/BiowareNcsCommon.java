// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;


/**
 * Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).
 * 
 * - `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
 *   (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
 * - `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
 *   decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
 * - `ncs_program_size_marker` is the fixed header byte after `"V1.0"` in retail KotOR NCS blobs (`0x42`).
 * 
 * **Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
 * duplicating opcode lists.
 */
public class BiowareNcsCommon extends KaitaiStruct {
    public static BiowareNcsCommon fromFile(String fileName) throws IOException {
        return new BiowareNcsCommon(new ByteBufferKaitaiStream(fileName));
    }

    public enum NcsBytecode {
        RESERVED_BC(0),
        CPDOWNSP(1),
        RSADDX(2),
        CPTOPSP(3),
        CONSTX(4),
        ACTION(5),
        LOGANDXX(6),
        LOGORXX(7),
        INCORXX(8),
        EXCORXX(9),
        BOOLANDXX(10),
        EQUALXX(11),
        NEQUALXX(12),
        GEQXX(13),
        GTXX(14),
        LTXX(15),
        LEQXX(16),
        SHLEFTXX(17),
        SHRIGHTXX(18),
        USHRIGHTXX(19),
        ADDXX(20),
        SUBXX(21),
        MULXX(22),
        DIVXX(23),
        MODXX(24),
        NEGX(25),
        COMPX(26),
        MOVSP(27),
        UNUSED_GAP(28),
        JMP(29),
        JSR(30),
        JZ(31),
        RETN(32),
        DESTRUCT(33),
        NOTX(34),
        DECXSP(35),
        INCXSP(36),
        JNZ(37),
        CPDOWNBP(38),
        CPTOPBP(39),
        DECXBP(40),
        INCXBP(41),
        SAVEBP(42),
        RESTOREBP(43),
        STORE_STATE(44),
        NOP(45);

        private final long id;
        NcsBytecode(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, NcsBytecode> byId = new HashMap<Long, NcsBytecode>(46);
        static {
            for (NcsBytecode e : NcsBytecode.values())
                byId.put(e.id(), e);
        }
        public static NcsBytecode byId(long id) { return byId.get(id); }
    }

    public enum NcsInstructionQualifier {
        NONE(0),
        UNARY_OPERAND_LAYOUT(1),
        INT_TYPE(3),
        FLOAT_TYPE(4),
        STRING_TYPE(5),
        OBJECT_TYPE(6),
        EFFECT_TYPE(16),
        EVENT_TYPE(17),
        LOCATION_TYPE(18),
        TALENT_TYPE(19),
        INT_INT(32),
        FLOAT_FLOAT(33),
        OBJECT_OBJECT(34),
        STRING_STRING(35),
        STRUCT_STRUCT(36),
        INT_FLOAT(37),
        FLOAT_INT(38),
        EFFECT_EFFECT(48),
        EVENT_EVENT(49),
        LOCATION_LOCATION(50),
        TALENT_TALENT(51),
        VECTOR_VECTOR(58),
        VECTOR_FLOAT(59),
        FLOAT_VECTOR(60);

        private final long id;
        NcsInstructionQualifier(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, NcsInstructionQualifier> byId = new HashMap<Long, NcsInstructionQualifier>(24);
        static {
            for (NcsInstructionQualifier e : NcsInstructionQualifier.values())
                byId.put(e.id(), e);
        }
        public static NcsInstructionQualifier byId(long id) { return byId.get(id); }
    }

    public enum NcsProgramSizeMarker {
        PROGRAM_SIZE_PREFIX(66);

        private final long id;
        NcsProgramSizeMarker(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, NcsProgramSizeMarker> byId = new HashMap<Long, NcsProgramSizeMarker>(1);
        static {
            for (NcsProgramSizeMarker e : NcsProgramSizeMarker.values())
                byId.put(e.id(), e);
        }
        public static NcsProgramSizeMarker byId(long id) { return byId.get(id); }
    }

    public BiowareNcsCommon(KaitaiStream _io) {
        this(_io, null, null);
    }

    public BiowareNcsCommon(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public BiowareNcsCommon(KaitaiStream _io, KaitaiStruct _parent, BiowareNcsCommon _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
    }

    public void _fetchInstances() {
    }
    private BiowareNcsCommon _root;
    private KaitaiStruct _parent;
    public BiowareNcsCommon _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
