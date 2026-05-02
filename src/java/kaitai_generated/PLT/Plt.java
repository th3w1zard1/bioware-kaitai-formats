// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.nio.charset.StandardCharsets;


/**
 * PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
 * palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
 * that reference external palette files, enabling dynamic color customization for character models
 * (skin, hair, armor colors, etc.).
 * 
 * **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
 * resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
 * does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
 * including character models. This documentation is provided for reference only.
 * 
 * **reone:** the KotOR-focused fork does not ship a standalone PLT body reader; see `meta.xref.reone_resource_type_plt_note` for the numeric `Plt` type id only.
 * 
 * Binary Format Structure:
 * - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
 * - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)
 * 
 * Palette System:
 * PLT files work in conjunction with external palette files (.pal files) that contain the actual
 * color values. The PLT file itself stores:
 * 1. Palette Group index (0-9): Which palette group to use for each pixel
 * 2. Color index (0-255): Which color within the selected palette to use
 * 
 * At runtime, the game:
 * 1. Loads the appropriate palette file for the selected palette group
 * 2. Uses the palette index (supplied by the content creator) to select a row in the palette file
 * 3. Uses the color index from the PLT file to retrieve the final color value
 * 
 * Palette Groups (10 total):
 * 0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
 * 6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L374-L380 PyKotor — `ResourceType.PLT`
 * - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
 * - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy">PyKotor wiki — PLT (NWN legacy)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html">xoreos-docs — Torlack plt.html</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145">xoreos — `PLTFile::load`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L63">xoreos — `kFileTypePLT`</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L35">reone — `ResourceType::Plt` (id 6; no `.plt` wire reader on default branch)</a>
 */
public class Plt extends KaitaiStruct {
    public static Plt fromFile(String fileName) throws IOException {
        return new Plt(new ByteBufferKaitaiStream(fileName));
    }

    public Plt(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Plt(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Plt(KaitaiStream _io, KaitaiStruct _parent, Plt _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new PltHeader(this._io, this, _root);
        this.pixelData = new PixelDataSection(this._io, this, _root);
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
        this.pixelData._fetchInstances();
    }
    public static class PixelDataSection extends KaitaiStruct {
        public static PixelDataSection fromFile(String fileName) throws IOException {
            return new PixelDataSection(new ByteBufferKaitaiStream(fileName));
        }

        public PixelDataSection(KaitaiStream _io) {
            this(_io, null, null);
        }

        public PixelDataSection(KaitaiStream _io, Plt _parent) {
            this(_io, _parent, null);
        }

        public PixelDataSection(KaitaiStream _io, Plt _parent, Plt _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.pixels = new ArrayList<PltPixel>();
            for (int i = 0; i < _root().header().width() * _root().header().height(); i++) {
                this.pixels.add(new PltPixel(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.pixels.size(); i++) {
                this.pixels.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<PltPixel> pixels;
        private Plt _root;
        private Plt _parent;

        /**
         * Array of pixel entries, stored row by row, left to right, top to bottom.
         * Total size = width × height × 2 bytes.
         * Each pixel entry contains a color index and palette group index.
         */
        public List<PltPixel> pixels() { return pixels; }
        public Plt _root() { return _root; }
        public Plt _parent() { return _parent; }
    }
    public static class PltHeader extends KaitaiStruct {
        public static PltHeader fromFile(String fileName) throws IOException {
            return new PltHeader(new ByteBufferKaitaiStream(fileName));
        }

        public PltHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public PltHeader(KaitaiStream _io, Plt _parent) {
            this(_io, _parent, null);
        }

        public PltHeader(KaitaiStream _io, Plt _parent, Plt _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.signature = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.signature.equals("PLT "))) {
                throw new KaitaiStream.ValidationNotEqualError("PLT ", this.signature, this._io, "/types/plt_header/seq/0");
            }
            this.version = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.version.equals("V1  "))) {
                throw new KaitaiStream.ValidationNotEqualError("V1  ", this.version, this._io, "/types/plt_header/seq/1");
            }
            this.unknown1 = this._io.readU4le();
            this.unknown2 = this._io.readU4le();
            this.width = this._io.readU4le();
            this.height = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private String signature;
        private String version;
        private long unknown1;
        private long unknown2;
        private long width;
        private long height;
        private Plt _root;
        private Plt _parent;

        /**
         * File signature. Must be "PLT " (space-padded).
         * This identifies the file as a PLT palette texture.
         */
        public String signature() { return signature; }

        /**
         * File format version. Must be "V1  " (space-padded).
         * This is the only known version of the PLT format.
         */
        public String version() { return version; }

        /**
         * Unknown field (4 bytes).
         * Purpose is unknown, may be reserved for future use or internal engine flags.
         */
        public long unknown1() { return unknown1; }

        /**
         * Unknown field (4 bytes).
         * Purpose is unknown, may be reserved for future use or internal engine flags.
         */
        public long unknown2() { return unknown2; }

        /**
         * Texture width in pixels (uint32).
         * Used to calculate the number of pixel entries in the pixel data section.
         */
        public long width() { return width; }

        /**
         * Texture height in pixels (uint32).
         * Used to calculate the number of pixel entries in the pixel data section.
         * Total pixel count = width × height
         */
        public long height() { return height; }
        public Plt _root() { return _root; }
        public Plt _parent() { return _parent; }
    }
    public static class PltPixel extends KaitaiStruct {
        public static PltPixel fromFile(String fileName) throws IOException {
            return new PltPixel(new ByteBufferKaitaiStream(fileName));
        }

        public PltPixel(KaitaiStream _io) {
            this(_io, null, null);
        }

        public PltPixel(KaitaiStream _io, Plt.PixelDataSection _parent) {
            this(_io, _parent, null);
        }

        public PltPixel(KaitaiStream _io, Plt.PixelDataSection _parent, Plt _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.colorIndex = this._io.readU1();
            this.paletteGroupIndex = this._io.readU1();
        }

        public void _fetchInstances() {
        }
        private int colorIndex;
        private int paletteGroupIndex;
        private Plt _root;
        private Plt.PixelDataSection _parent;

        /**
         * Color index (0-255) within the selected palette.
         * This value selects which color from the palette file row to use.
         * The palette file contains 256 rows (one for each palette index 0-255),
         * and each row contains 256 color values (one for each color index 0-255).
         */
        public int colorIndex() { return colorIndex; }

        /**
         * Palette group index (0-9) that determines which palette file to use.
         * Palette groups:
         * 0 = Skin (pal_skin01.jpg)
         * 1 = Hair (pal_hair01.jpg)
         * 2 = Metal 1 (pal_armor01.jpg)
         * 3 = Metal 2 (pal_armor02.jpg)
         * 4 = Cloth 1 (pal_cloth01.jpg)
         * 5 = Cloth 2 (pal_cloth01.jpg)
         * 6 = Leather 1 (pal_leath01.jpg)
         * 7 = Leather 2 (pal_leath01.jpg)
         * 8 = Tattoo 1 (pal_tattoo01.jpg)
         * 9 = Tattoo 2 (pal_tattoo01.jpg)
         */
        public int paletteGroupIndex() { return paletteGroupIndex; }
        public Plt _root() { return _root; }
        public Plt.PixelDataSection _parent() { return _parent; }
    }
    private PltHeader header;
    private PixelDataSection pixelData;
    private Plt _root;
    private KaitaiStruct _parent;

    /**
     * PLT file header (24 bytes)
     */
    public PltHeader header() { return header; }

    /**
     * Array of pixel entries (width × height entries, 2 bytes each)
     */
    public PixelDataSection pixelData() { return pixelData; }
    public Plt _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
