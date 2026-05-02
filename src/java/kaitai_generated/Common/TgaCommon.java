// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;


/**
 * Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
 * per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
 * 
 * Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — textures (TGA pipeline)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40">PyKotor — `tga.py` (reader core)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177">xoreos — `TGA::readHeader`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L61">xoreos — `kFileTypeTGA`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L80">xoreos-tools — `TGA::load`</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture context)</a>
 */
public class TgaCommon extends KaitaiStruct {
    public static TgaCommon fromFile(String fileName) throws IOException {
        return new TgaCommon(new ByteBufferKaitaiStream(fileName));
    }

    public enum TgaColorMapType {
        NONE(0),
        PRESENT(1);

        private final long id;
        TgaColorMapType(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, TgaColorMapType> byId = new HashMap<Long, TgaColorMapType>(2);
        static {
            for (TgaColorMapType e : TgaColorMapType.values())
                byId.put(e.id(), e);
        }
        public static TgaColorMapType byId(long id) { return byId.get(id); }
    }

    public enum TgaImageType {
        NO_IMAGE_DATA(0),
        UNCOMPRESSED_COLOR_MAPPED(1),
        UNCOMPRESSED_RGB(2),
        UNCOMPRESSED_GREYSCALE(3),
        RLE_COLOR_MAPPED(9),
        RLE_RGB(10),
        RLE_GREYSCALE(11);

        private final long id;
        TgaImageType(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, TgaImageType> byId = new HashMap<Long, TgaImageType>(7);
        static {
            for (TgaImageType e : TgaImageType.values())
                byId.put(e.id(), e);
        }
        public static TgaImageType byId(long id) { return byId.get(id); }
    }

    public TgaCommon(KaitaiStream _io) {
        this(_io, null, null);
    }

    public TgaCommon(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public TgaCommon(KaitaiStream _io, KaitaiStruct _parent, TgaCommon _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
    }

    public void _fetchInstances() {
    }
    private TgaCommon _root;
    private KaitaiStruct _parent;
    public TgaCommon _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
