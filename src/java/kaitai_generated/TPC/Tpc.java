// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


/**
 * **TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
 * (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
 * (`meta.xref`).
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — TPC</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303">PyKotor — `TPCBinaryReader` + `load`</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120">PyKotor — `TPCTextureFormat` (opening)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520">PyKotor — `class TPC` (opening)</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105">reone — `TpcReader` (body + TXI features)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L183">xoreos — `kFileTypeTPC`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L362">xoreos — `TPC::load` through `readTXI` entrypoints</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68">xoreos-tools — `TPC::load`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224">xoreos-tools — `TPC::readHeader`</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture pipeline context)</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts#L290-L380">KotOR.js — `TPCObject.readHeader`</a>
 */
public class Tpc extends KaitaiStruct {
    public static Tpc fromFile(String fileName) throws IOException {
        return new Tpc(new ByteBufferKaitaiStream(fileName));
    }

    public Tpc(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Tpc(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Tpc(KaitaiStream _io, KaitaiStruct _parent, Tpc _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new TpcHeader(this._io, this, _root);
        this.body = this._io.readBytesFull();
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
    }
    public static class TpcHeader extends KaitaiStruct {
        public static TpcHeader fromFile(String fileName) throws IOException {
            return new TpcHeader(new ByteBufferKaitaiStream(fileName));
        }

        public TpcHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public TpcHeader(KaitaiStream _io, Tpc _parent) {
            this(_io, _parent, null);
        }

        public TpcHeader(KaitaiStream _io, Tpc _parent, Tpc _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.dataSize = this._io.readU4le();
            this.alphaTest = this._io.readF4le();
            this.width = this._io.readU2le();
            this.height = this._io.readU2le();
            this.pixelEncoding = BiowareCommon.BiowareTpcPixelFormatId.byId(this._io.readU1());
            this.mipmapCount = this._io.readU1();
            this.reserved = new ArrayList<Integer>();
            for (int i = 0; i < 114; i++) {
                this.reserved.add(this._io.readU1());
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.reserved.size(); i++) {
            }
        }
        private Boolean isCompressed;

        /**
         * True if texture data is compressed (DXT format)
         */
        public Boolean isCompressed() {
            if (this.isCompressed != null)
                return this.isCompressed;
            this.isCompressed = dataSize() != 0;
            return this.isCompressed;
        }
        private Boolean isUncompressed;

        /**
         * True if texture data is uncompressed (raw pixels)
         */
        public Boolean isUncompressed() {
            if (this.isUncompressed != null)
                return this.isUncompressed;
            this.isUncompressed = dataSize() == 0;
            return this.isUncompressed;
        }
        private long dataSize;
        private float alphaTest;
        private int width;
        private int height;
        private BiowareCommon.BiowareTpcPixelFormatId pixelEncoding;
        private int mipmapCount;
        private List<Integer> reserved;
        private Tpc _root;
        private Tpc _parent;

        /**
         * Total compressed payload size. If non-zero, texture is compressed (DXT).
         * If zero, texture is uncompressed and size is derived from format/width/height.
         */
        public long dataSize() { return dataSize; }

        /**
         * Float threshold used by punch-through rendering.
         * Commonly 0.0 or 0.5.
         */
        public float alphaTest() { return alphaTest; }

        /**
         * Texture width in pixels (uint16).
         * Must be power-of-two for compressed formats.
         */
        public int width() { return width; }

        /**
         * Texture height in pixels (uint16).
         * For cube maps, this is 6x the face width.
         * Must be power-of-two for compressed formats.
         */
        public int height() { return height; }

        /**
         * Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
         * `bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).
         */
        public BiowareCommon.BiowareTpcPixelFormatId pixelEncoding() { return pixelEncoding; }

        /**
         * Number of mip levels per layer (minimum 1).
         * Each mip level is half the size of the previous level.
         */
        public int mipmapCount() { return mipmapCount; }

        /**
         * Reserved/padding bytes (0x72 = 114 bytes).
         * KotOR stores platform hints here but all implementations skip them.
         */
        public List<Integer> reserved() { return reserved; }
        public Tpc _root() { return _root; }
        public Tpc _parent() { return _parent; }
    }
    private TpcHeader header;
    private byte[] body;
    private Tpc _root;
    private KaitaiStruct _parent;

    /**
     * TPC file header (128 bytes total)
     */
    public TpcHeader header() { return header; }

    /**
     * Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).
     */
    public byte[] body() { return body; }
    public Tpc _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
