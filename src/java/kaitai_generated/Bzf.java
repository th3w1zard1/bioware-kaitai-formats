// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;


/**
 * **BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
 * mobile KotOR ports.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression">PyKotor wiki — BZF (LZMA BIF)</a>
 */
public class Bzf extends KaitaiStruct {
    public static Bzf fromFile(String fileName) throws IOException {
        return new Bzf(new ByteBufferKaitaiStream(fileName));
    }

    public Bzf(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Bzf(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Bzf(KaitaiStream _io, KaitaiStruct _parent, Bzf _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!(this.fileType.equals("BZF "))) {
            throw new KaitaiStream.ValidationNotEqualError("BZF ", this.fileType, this._io, "/seq/0");
        }
        this.version = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!(this.version.equals("V1.0"))) {
            throw new KaitaiStream.ValidationNotEqualError("V1.0", this.version, this._io, "/seq/1");
        }
        this.compressedData = this._io.readBytesFull();
    }

    public void _fetchInstances() {
    }
    private String fileType;
    private String version;
    private byte[] compressedData;
    private Bzf _root;
    private KaitaiStruct _parent;

    /**
     * File type signature. Must be "BZF " for compressed BIF files.
     */
    public String fileType() { return fileType; }

    /**
     * File format version. Always "V1.0" for BZF files.
     */
    public String version() { return version; }

    /**
     * LZMA-compressed BIF file data (single blob to EOF).
     * Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).
     */
    public byte[] compressedData() { return compressedData; }
    public Bzf _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
