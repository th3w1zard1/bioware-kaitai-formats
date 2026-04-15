// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;


/**
 * Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).
 * 
 * Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
 * (Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).
 */
public class BiowareGffCommon extends KaitaiStruct {
    public static BiowareGffCommon fromFile(String fileName) throws IOException {
        return new BiowareGffCommon(new ByteBufferKaitaiStream(fileName));
    }

    public enum GffFieldType {
        UINT8(0),
        INT8(1),
        UINT16(2),
        INT16(3),
        UINT32(4),
        INT32(5),
        UINT64(6),
        INT64(7),
        SINGLE(8),
        DOUBLE(9),
        STRING(10),
        RESREF(11),
        LOCALIZED_STRING(12),
        BINARY(13),
        STRUCT(14),
        LIST(15),
        VECTOR4(16),
        VECTOR3(17),
        STR_REF(18);

        private final long id;
        GffFieldType(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, GffFieldType> byId = new HashMap<Long, GffFieldType>(19);
        static {
            for (GffFieldType e : GffFieldType.values())
                byId.put(e.id(), e);
        }
        public static GffFieldType byId(long id) { return byId.get(id); }
    }

    public BiowareGffCommon(KaitaiStream _io) {
        this(_io, null, null);
    }

    public BiowareGffCommon(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public BiowareGffCommon(KaitaiStream _io, KaitaiStruct _parent, BiowareGffCommon _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
    }

    public void _fetchInstances() {
    }
    private BiowareGffCommon _root;
    private KaitaiStruct _parent;
    public BiowareGffCommon _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
