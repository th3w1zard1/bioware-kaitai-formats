// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;


/**
 * **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
 * (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.
 * 
 * This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
 * variant diverges, split a dedicated header type and cite Ghidra / binary evidence (`TODO: VERIFY`).
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182">xoreos — `kFileTypeTXB`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66">xoreos — `TPC::load` (texture family)</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68">xoreos-tools — `TPC::load`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224">xoreos-tools — `TPC::readHeader`</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture pipeline context)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — texture family (cross-check TXB)</a>
 */
public class Txb extends KaitaiStruct {
    public static Txb fromFile(String fileName) throws IOException {
        return new Txb(new ByteBufferKaitaiStream(fileName));
    }

    public Txb(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Txb(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Txb(KaitaiStream _io, KaitaiStruct _parent, Txb _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new Tpc.TpcHeader(this._io);
        this.body = this._io.readBytesFull();
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
    }
    private Tpc.TpcHeader header;
    private byte[] body;
    private Txb _root;
    private KaitaiStruct _parent;

    /**
     * Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
     */
    public Tpc.TpcHeader header() { return header; }

    /**
     * Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.
     */
    public byte[] body() { return body; }
    public Txb _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
