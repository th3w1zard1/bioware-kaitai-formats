// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;


/**
 * **RES** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
 * `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
 * `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.
 * 
 * FileType / restype id **0** — see `bioware_type_ids::xoreos_file_type_id` enum member `res`.
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — GFF3 header read</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format">PyKotor wiki — GFF binary</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf (GFF3 wire)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf">xoreos-docs — CommonGFFStructs.pdf</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
 */
public class GffRes extends KaitaiStruct {
    public static GffRes fromFile(String fileName) throws IOException {
        return new GffRes(new ByteBufferKaitaiStream(fileName));
    }

    public GffRes(KaitaiStream _io) {
        this(_io, null, null);
    }

    public GffRes(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public GffRes(KaitaiStream _io, KaitaiStruct _parent, GffRes _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.contents = new Gff.GffUnionFile(this._io);
    }

    public void _fetchInstances() {
        this.contents._fetchInstances();
    }
    private Gff.GffUnionFile contents;
    private GffRes _root;
    private KaitaiStruct _parent;

    /**
     * Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per RES template docs / PyKotor `gff_auto`.
     */
    public Gff.GffUnionFile contents() { return contents; }
    public GffRes _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
