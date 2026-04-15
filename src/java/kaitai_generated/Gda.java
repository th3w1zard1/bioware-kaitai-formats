// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;


/**
 * **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
 * (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
 * 
 * G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305">xoreos — GDAFile::load</a>
 */
public class Gda extends KaitaiStruct {
    public static Gda fromFile(String fileName) throws IOException {
        return new Gda(new ByteBufferKaitaiStream(fileName));
    }

    public Gda(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Gda(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Gda(KaitaiStream _io, KaitaiStruct _parent, Gda _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.asGff4 = new Gff.Gff4File(this._io);
    }

    public void _fetchInstances() {
        this.asGff4._fetchInstances();
    }
    private Gff.Gff4File asGff4;
    private Gda _root;
    private KaitaiStruct _parent;

    /**
     * On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
     * (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).
     */
    public Gff.Gff4File asGff4() { return asGff4; }
    public Gda _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
