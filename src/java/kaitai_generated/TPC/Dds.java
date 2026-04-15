// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


/**
 * **DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
 * (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.
 * 
 * BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds">PyKotor wiki — DDS</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130">PyKotor — `TPCDDSReader` / `io_dds`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L98">xoreos — `kFileTypeDDS`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L55-L67">xoreos — `dds.cpp` load entry</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L141-L210">xoreos — BioWare headerless / Microsoft DDS branches</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/dds.cpp#L69-L158">xoreos-tools — `dds.cpp` (image tooling)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree (texture-adjacent PDFs)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (engine texture pipeline context)</a>
 * @see <a href="https://github.com/lachjames/NorthernLights">lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L57">reone — `ResourceType::Dds` (type id; TPC path in `tpcreader.cpp`)</a>
 */
public class Dds extends KaitaiStruct {
    public static Dds fromFile(String fileName) throws IOException {
        return new Dds(new ByteBufferKaitaiStream(fileName));
    }

    public Dds(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Dds(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Dds(KaitaiStream _io, KaitaiStruct _parent, Dds _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.magic = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!( ((this.magic.equals("DDS ")) || (this.magic.equals("    "))) )) {
            throw new KaitaiStream.ValidationNotAnyOfError(this.magic, this._io, "/seq/0");
        }
        if (magic().equals("DDS ")) {
            this.header = new DdsHeader(this._io, this, _root);
        }
        if (!magic().equals("DDS ")) {
            this.biowareHeader = new BiowareDdsHeader(this._io, this, _root);
        }
        this.pixelData = this._io.readBytesFull();
    }

    public void _fetchInstances() {
        if (magic().equals("DDS ")) {
            this.header._fetchInstances();
        }
        if (!magic().equals("DDS ")) {
            this.biowareHeader._fetchInstances();
        }
    }
    public static class BiowareDdsHeader extends KaitaiStruct {
        public static BiowareDdsHeader fromFile(String fileName) throws IOException {
            return new BiowareDdsHeader(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareDdsHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareDdsHeader(KaitaiStream _io, Dds _parent) {
            this(_io, _parent, null);
        }

        public BiowareDdsHeader(KaitaiStream _io, Dds _parent, Dds _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.width = this._io.readU4le();
            this.height = this._io.readU4le();
            this.bytesPerPixel = BiowareCommon.BiowareDdsVariantBytesPerPixel.byId(this._io.readU4le());
            this.dataSize = this._io.readU4le();
            this.unusedFloat = this._io.readF4le();
        }

        public void _fetchInstances() {
        }
        private long width;
        private long height;
        private BiowareCommon.BiowareDdsVariantBytesPerPixel bytesPerPixel;
        private long dataSize;
        private float unusedFloat;
        private Dds _root;
        private Dds _parent;

        /**
         * Image width in pixels (must be power of two, < 0x8000)
         */
        public long width() { return width; }

        /**
         * Image height in pixels (must be power of two, < 0x8000)
         */
        public long height() { return height; }

        /**
         * BioWare variant "bytes per pixel" (`u4`): DXT1 vs DXT5 block stride hint. Canonical: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
         */
        public BiowareCommon.BiowareDdsVariantBytesPerPixel bytesPerPixel() { return bytesPerPixel; }

        /**
         * Total compressed data size.
         * Must match (width*height)/2 for DXT1 or width*height for DXT5
         */
        public long dataSize() { return dataSize; }

        /**
         * Unused float field (typically 0.0)
         */
        public float unusedFloat() { return unusedFloat; }
        public Dds _root() { return _root; }
        public Dds _parent() { return _parent; }
    }
    public static class Ddpixelformat extends KaitaiStruct {
        public static Ddpixelformat fromFile(String fileName) throws IOException {
            return new Ddpixelformat(new ByteBufferKaitaiStream(fileName));
        }

        public Ddpixelformat(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Ddpixelformat(KaitaiStream _io, Dds.DdsHeader _parent) {
            this(_io, _parent, null);
        }

        public Ddpixelformat(KaitaiStream _io, Dds.DdsHeader _parent, Dds _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.size = this._io.readU4le();
            if (!(this.size == 32)) {
                throw new KaitaiStream.ValidationNotEqualError(32, this.size, this._io, "/types/ddpixelformat/seq/0");
            }
            this.flags = this._io.readU4le();
            this.fourcc = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            this.rgbBitCount = this._io.readU4le();
            this.rBitMask = this._io.readU4le();
            this.gBitMask = this._io.readU4le();
            this.bBitMask = this._io.readU4le();
            this.aBitMask = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private long size;
        private long flags;
        private String fourcc;
        private long rgbBitCount;
        private long rBitMask;
        private long gBitMask;
        private long bBitMask;
        private long aBitMask;
        private Dds _root;
        private Dds.DdsHeader _parent;

        /**
         * Structure size (must be 32)
         */
        public long size() { return size; }

        /**
         * Pixel format flags:
         * - 0x00000001 = DDPF_ALPHAPIXELS
         * - 0x00000002 = DDPF_ALPHA
         * - 0x00000004 = DDPF_FOURCC
         * - 0x00000040 = DDPF_RGB
         * - 0x00000200 = DDPF_YUV
         * - 0x00080000 = DDPF_LUMINANCE
         */
        public long flags() { return flags; }

        /**
         * Four-character code for compressed formats:
         * - "DXT1" = DXT1 compression
         * - "DXT3" = DXT3 compression
         * - "DXT5" = DXT5 compression
         * - "    " = Uncompressed format
         */
        public String fourcc() { return fourcc; }

        /**
         * Bits per pixel for uncompressed formats (16, 24, or 32)
         */
        public long rgbBitCount() { return rgbBitCount; }

        /**
         * Red channel bit mask (for uncompressed formats)
         */
        public long rBitMask() { return rBitMask; }

        /**
         * Green channel bit mask (for uncompressed formats)
         */
        public long gBitMask() { return gBitMask; }

        /**
         * Blue channel bit mask (for uncompressed formats)
         */
        public long bBitMask() { return bBitMask; }

        /**
         * Alpha channel bit mask (for uncompressed formats)
         */
        public long aBitMask() { return aBitMask; }
        public Dds _root() { return _root; }
        public Dds.DdsHeader _parent() { return _parent; }
    }
    public static class DdsHeader extends KaitaiStruct {
        public static DdsHeader fromFile(String fileName) throws IOException {
            return new DdsHeader(new ByteBufferKaitaiStream(fileName));
        }

        public DdsHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public DdsHeader(KaitaiStream _io, Dds _parent) {
            this(_io, _parent, null);
        }

        public DdsHeader(KaitaiStream _io, Dds _parent, Dds _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.size = this._io.readU4le();
            if (!(this.size == 124)) {
                throw new KaitaiStream.ValidationNotEqualError(124, this.size, this._io, "/types/dds_header/seq/0");
            }
            this.flags = this._io.readU4le();
            this.height = this._io.readU4le();
            this.width = this._io.readU4le();
            this.pitchOrLinearSize = this._io.readU4le();
            this.depth = this._io.readU4le();
            this.mipmapCount = this._io.readU4le();
            this.reserved1 = new ArrayList<Long>();
            for (int i = 0; i < 11; i++) {
                this.reserved1.add(this._io.readU4le());
            }
            this.pixelFormat = new Ddpixelformat(this._io, this, _root);
            this.caps = this._io.readU4le();
            this.caps2 = this._io.readU4le();
            this.caps3 = this._io.readU4le();
            this.caps4 = this._io.readU4le();
            this.reserved2 = this._io.readU4le();
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.reserved1.size(); i++) {
            }
            this.pixelFormat._fetchInstances();
        }
        private long size;
        private long flags;
        private long height;
        private long width;
        private long pitchOrLinearSize;
        private long depth;
        private long mipmapCount;
        private List<Long> reserved1;
        private Ddpixelformat pixelFormat;
        private long caps;
        private long caps2;
        private long caps3;
        private long caps4;
        private long reserved2;
        private Dds _root;
        private Dds _parent;

        /**
         * Header size (must be 124)
         */
        public long size() { return size; }

        /**
         * DDS flags bitfield:
         * - 0x00001007 = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT
         * - 0x00020000 = DDSD_MIPMAPCOUNT (if mipmaps present)
         */
        public long flags() { return flags; }

        /**
         * Image height in pixels
         */
        public long height() { return height; }

        /**
         * Image width in pixels
         */
        public long width() { return width; }

        /**
         * Pitch (uncompressed) or linear size (compressed).
         * For compressed formats: total size of all mip levels
         */
        public long pitchOrLinearSize() { return pitchOrLinearSize; }

        /**
         * Depth for volume textures (usually 0 for 2D textures)
         */
        public long depth() { return depth; }

        /**
         * Number of mipmap levels (0 or 1 = no mipmaps)
         */
        public long mipmapCount() { return mipmapCount; }

        /**
         * Reserved fields (unused)
         */
        public List<Long> reserved1() { return reserved1; }

        /**
         * Pixel format structure
         */
        public Ddpixelformat pixelFormat() { return pixelFormat; }

        /**
         * Capability flags:
         * - 0x00001000 = DDSCAPS_TEXTURE
         * - 0x00000008 = DDSCAPS_MIPMAP
         * - 0x00000200 = DDSCAPS2_CUBEMAP
         */
        public long caps() { return caps; }

        /**
         * Additional capability flags:
         * - 0x00000200 = DDSCAPS2_CUBEMAP
         * - 0x00000FC00 = Cube map face flags
         */
        public long caps2() { return caps2; }

        /**
         * Reserved capability flags
         */
        public long caps3() { return caps3; }

        /**
         * Reserved capability flags
         */
        public long caps4() { return caps4; }

        /**
         * Reserved field
         */
        public long reserved2() { return reserved2; }
        public Dds _root() { return _root; }
        public Dds _parent() { return _parent; }
    }
    private String magic;
    private DdsHeader header;
    private BiowareDdsHeader biowareHeader;
    private byte[] pixelData;
    private Dds _root;
    private KaitaiStruct _parent;

    /**
     * File magic. Either "DDS " (0x44445320) for standard DDS,
     * or check for BioWare variant (no magic, starts with width/height).
     */
    public String magic() { return magic; }

    /**
     * Standard DDS header (124 bytes) - only present if magic is "DDS "
     */
    public DdsHeader header() { return header; }

    /**
     * BioWare DDS variant header - only present if magic is not "DDS "
     */
    public BiowareDdsHeader biowareHeader() { return biowareHeader; }

    /**
     * Pixel data (compressed or uncompressed); single blob to EOF.
     * For standard DDS: format determined by DDPIXELFORMAT.
     * For BioWare DDS: DXT1 or DXT5 compressed data.
     */
    public byte[] pixelData() { return pixelData; }
    public Dds _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
