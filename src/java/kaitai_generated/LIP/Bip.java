// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;


/**
 * **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
 * framed wire lives in `LIP.ksy`.
 * 
 * **TODO: VERIFY** full BIP layout against Odyssey Ghidra (`user-agdec-http`) and PyKotor; until then this spec
 * exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198">xoreos — `kFileTypeBIP`</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip">PyKotor wiki — LIP family</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; placeholder wire — verify in Ghidra)</a>
 */
public class Bip extends KaitaiStruct {
    public static Bip fromFile(String fileName) throws IOException {
        return new Bip(new ByteBufferKaitaiStream(fileName));
    }

    public Bip(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Bip(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Bip(KaitaiStream _io, KaitaiStruct _parent, Bip _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.payload = this._io.readBytesFull();
    }

    public void _fetchInstances() {
    }
    private byte[] payload;
    private Bip _root;
    private KaitaiStruct _parent;

    /**
     * Opaque binary LIP payload — replace with structured fields after verification.
     */
    public byte[] payload() { return payload; }
    public Bip _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
