// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;


/**
 * ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
 * ITP files use GFF format (FileType "ITP " in GFF header).
 * Uses GFF XML structure with root element <gff3> containing <struct> elements.
 * Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).
 * 
 * Canonical links: `meta.doc-ref` and `meta.xref`.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format">PyKotor wiki — GFF (ITP is GFF-shaped)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — `GFF3File::readHeader`</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225">reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49">xoreos-docs — Torlack ITP / MultiMap (GFF-family context)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
 */
public class ItpXml extends KaitaiStruct {
    public static ItpXml fromFile(String fileName) throws IOException {
        return new ItpXml(new ByteBufferKaitaiStream(fileName));
    }

    public ItpXml(KaitaiStream _io) {
        this(_io, null, null);
    }

    public ItpXml(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public ItpXml(KaitaiStream _io, KaitaiStruct _parent, ItpXml _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.xmlContent = new String(this._io.readBytesFull(), StandardCharsets.UTF_8);
    }

    public void _fetchInstances() {
    }
    private String xmlContent;
    private ItpXml _root;
    private KaitaiStruct _parent;

    /**
     * XML document content as UTF-8 text
     */
    public String xmlContent() { return xmlContent; }
    public ItpXml _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
