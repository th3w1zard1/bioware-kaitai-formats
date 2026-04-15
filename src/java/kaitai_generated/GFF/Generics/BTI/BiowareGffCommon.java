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
 * 
 * **GFF4** uses a different container/struct layout on disk (`GFF4File::Header::read` in `meta.xref.xoreos_gff4file_header_read`);
 * this enum remains the **GFF3** field-type table unless a future split spec proves wire-identical IDs across both.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types">PyKotor wiki — GFF data types</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367">PyKotor — `GFFFieldType` enum</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L197-L273">PyKotor — field read dispatch</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — `GFF3File::readHeader`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L59-L82">xoreos — `GFF4File::Header::read` (GFF4 container; distinct from GFF3 field tags above)</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225">reone — `GffReader`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176">xoreos-tools — `gffdumper` (identify / dump)</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60">xoreos-tools — `gffcreator` (create)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf">xoreos-docs — CommonGFFStructs.pdf</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
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
