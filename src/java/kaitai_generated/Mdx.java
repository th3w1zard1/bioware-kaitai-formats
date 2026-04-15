// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;


/**
 * **MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
 * Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
 * opaque `size-eos` span — per-attribute layouts are MDL-driven.
 * 
 * xoreos interleaved MDX reads: `meta.xref.xoreos_model_kotor_mdx_reads`.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format">PyKotor wiki — MDL/MDX</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L885-L917">xoreos — Model_KotOR MDX reads</a>
 */
public class Mdx extends KaitaiStruct {
    public static Mdx fromFile(String fileName) throws IOException {
        return new Mdx(new ByteBufferKaitaiStream(fileName));
    }

    public Mdx(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Mdx(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Mdx(KaitaiStream _io, KaitaiStruct _parent, Mdx _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.vertexData = this._io.readBytesFull();
    }

    public void _fetchInstances() {
    }
    private byte[] vertexData;
    private Mdx _root;
    private KaitaiStruct _parent;

    /**
     * Raw vertex data bytes; layout follows the trimesh header in the paired MDL (`mdx_data_offset`, `mdx_vertex_size`,
     * `mdx_data_flags`). Bit names for `mdx_data_flags`: `bioware_mdl_common::mdx_vertex_stream_flag` (bitmask on wire).
     * 
     * See `meta.xref.pykotor_wiki_mdl` and `meta.xref.xoreos_model_kotor_mdx_reads`. Skinned meshes add bone weights
     * and indices per vertex as described on the wiki.
     */
    public byte[] vertexData() { return vertexData; }
    public Mdx _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
