// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


/**
 * **TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
 * converts authoring TGAs to **TPC** for shipping.
 * 
 * Shared header enums: `formats/Common/tga_common.ksy`.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — textures (TPC/TGA pipeline)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40">PyKotor — compact TGA reader (`tga.py`)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120">PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177">xoreos — `TGA::readHeader`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L241">xoreos-tools — `TGA::load` through `readRLE` (tooling reader)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture pipeline context)</a>
 * @see <a href="https://github.com/lachjames/NorthernLights">lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)</a>
 */
public class Tga extends KaitaiStruct {
    public static Tga fromFile(String fileName) throws IOException {
        return new Tga(new ByteBufferKaitaiStream(fileName));
    }

    public Tga(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Tga(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Tga(KaitaiStream _io, KaitaiStruct _parent, Tga _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.idLength = this._io.readU1();
        this.colorMapType = TgaCommon.TgaColorMapType.byId(this._io.readU1());
        this.imageType = TgaCommon.TgaImageType.byId(this._io.readU1());
        if (colorMapType() == TgaCommon.TgaColorMapType.PRESENT) {
            this.colorMapSpec = new ColorMapSpecification(this._io, this, _root);
        }
        this.imageSpec = new ImageSpecification(this._io, this, _root);
        if (idLength() > 0) {
            this.imageId = new String(this._io.readBytes(idLength()), StandardCharsets.US_ASCII);
        }
        if (colorMapType() == TgaCommon.TgaColorMapType.PRESENT) {
            this.colorMapData = new ArrayList<Integer>();
            for (int i = 0; i < colorMapSpec().length(); i++) {
                this.colorMapData.add(this._io.readU1());
            }
        }
        this.imageData = new ArrayList<Integer>();
        {
            int i = 0;
            while (!this._io.isEof()) {
                this.imageData.add(this._io.readU1());
                i++;
            }
        }
    }

    public void _fetchInstances() {
        if (colorMapType() == TgaCommon.TgaColorMapType.PRESENT) {
            this.colorMapSpec._fetchInstances();
        }
        this.imageSpec._fetchInstances();
        if (idLength() > 0) {
        }
        if (colorMapType() == TgaCommon.TgaColorMapType.PRESENT) {
            for (int i = 0; i < this.colorMapData.size(); i++) {
            }
        }
        for (int i = 0; i < this.imageData.size(); i++) {
        }
    }
    public static class ColorMapSpecification extends KaitaiStruct {
        public static ColorMapSpecification fromFile(String fileName) throws IOException {
            return new ColorMapSpecification(new ByteBufferKaitaiStream(fileName));
        }

        public ColorMapSpecification(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ColorMapSpecification(KaitaiStream _io, Tga _parent) {
            this(_io, _parent, null);
        }

        public ColorMapSpecification(KaitaiStream _io, Tga _parent, Tga _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.firstEntryIndex = this._io.readU2le();
            this.length = this._io.readU2le();
            this.entrySize = this._io.readU1();
        }

        public void _fetchInstances() {
        }
        private int firstEntryIndex;
        private int length;
        private int entrySize;
        private Tga _root;
        private Tga _parent;

        /**
         * Index of first color map entry
         */
        public int firstEntryIndex() { return firstEntryIndex; }

        /**
         * Number of color map entries
         */
        public int length() { return length; }

        /**
         * Size of each color map entry in bits (15, 16, 24, or 32)
         */
        public int entrySize() { return entrySize; }
        public Tga _root() { return _root; }
        public Tga _parent() { return _parent; }
    }
    public static class ImageSpecification extends KaitaiStruct {
        public static ImageSpecification fromFile(String fileName) throws IOException {
            return new ImageSpecification(new ByteBufferKaitaiStream(fileName));
        }

        public ImageSpecification(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ImageSpecification(KaitaiStream _io, Tga _parent) {
            this(_io, _parent, null);
        }

        public ImageSpecification(KaitaiStream _io, Tga _parent, Tga _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.xOrigin = this._io.readU2le();
            this.yOrigin = this._io.readU2le();
            this.width = this._io.readU2le();
            this.height = this._io.readU2le();
            this.pixelDepth = this._io.readU1();
            this.imageDescriptor = this._io.readU1();
        }

        public void _fetchInstances() {
        }
        private int xOrigin;
        private int yOrigin;
        private int width;
        private int height;
        private int pixelDepth;
        private int imageDescriptor;
        private Tga _root;
        private Tga _parent;

        /**
         * X coordinate of lower-left corner of image
         */
        public int xOrigin() { return xOrigin; }

        /**
         * Y coordinate of lower-left corner of image
         */
        public int yOrigin() { return yOrigin; }

        /**
         * Image width in pixels
         */
        public int width() { return width; }

        /**
         * Image height in pixels
         */
        public int height() { return height; }

        /**
         * Bits per pixel:
         * - 8 = Greyscale or indexed
         * - 16 = RGB 5-5-5 or RGBA 1-5-5-5
         * - 24 = RGB
         * - 32 = RGBA
         */
        public int pixelDepth() { return pixelDepth; }

        /**
         * Image descriptor byte:
         * - Bits 0-3: Number of attribute bits per pixel (alpha channel)
         * - Bit 4: Reserved
         * - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
         * - Bits 6-7: Interleaving (usually 0)
         */
        public int imageDescriptor() { return imageDescriptor; }
        public Tga _root() { return _root; }
        public Tga _parent() { return _parent; }
    }
    private int idLength;
    private TgaCommon.TgaColorMapType colorMapType;
    private TgaCommon.TgaImageType imageType;
    private ColorMapSpecification colorMapSpec;
    private ImageSpecification imageSpec;
    private String imageId;
    private List<Integer> colorMapData;
    private List<Integer> imageData;
    private Tga _root;
    private KaitaiStruct _parent;

    /**
     * Length of image ID field (0-255 bytes)
     */
    public int idLength() { return idLength; }

    /**
     * Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.
     */
    public TgaCommon.TgaColorMapType colorMapType() { return colorMapType; }

    /**
     * Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.
     */
    public TgaCommon.TgaImageType imageType() { return imageType; }

    /**
     * Color map specification (only present if color_map_type == present)
     */
    public ColorMapSpecification colorMapSpec() { return colorMapSpec; }

    /**
     * Image specification (dimensions and pixel format)
     */
    public ImageSpecification imageSpec() { return imageSpec; }

    /**
     * Image identification field (optional ASCII string)
     */
    public String imageId() { return imageId; }

    /**
     * Color map data (palette entries)
     */
    public List<Integer> colorMapData() { return colorMapData; }

    /**
     * Image pixel data (raw or RLE-compressed).
     * Size depends on image dimensions, pixel format, and compression.
     * For uncompressed formats: width × height × bytes_per_pixel
     * For RLE formats: Variable size depending on compression ratio
     */
    public List<Integer> imageData() { return imageData; }
    public Tga _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
