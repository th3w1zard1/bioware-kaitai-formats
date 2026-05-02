// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;
import java.nio.charset.StandardCharsets;


/**
 * Enums and small helper types used by installation/extraction tooling.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/installation.py
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60">xoreos — `FileType` enum start (Aurora resource type IDs; no dedicated extraction-layout parser — this `.ksy` is tooling-side)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py#L67-L122">PyKotor — `SearchLocation` / `TexturePackNames` (maps to enums in this `.ksy`)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py">PyKotor — installation / search helpers (full module)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/">PyKotor — `extract/` package</a>
 * @see <a href="https://github.com/OldRepublicDevs/Andastra/blob/master/src/andastra/parsing/extract/installation.cs">Andastra — Eclipse extraction/installation model</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (tooling enums; no extraction-specific PDF)</a>
 */
public class BiowareExtractCommon extends KaitaiStruct {
    public static BiowareExtractCommon fromFile(String fileName) throws IOException {
        return new BiowareExtractCommon(new ByteBufferKaitaiStream(fileName));
    }

    public enum BiowareSearchLocationId {
        OVERRIDE(0),
        MODULES(1),
        CHITIN(2),
        TEXTURES_TPA(3),
        TEXTURES_TPB(4),
        TEXTURES_TPC(5),
        TEXTURES_GUI(6),
        MUSIC(7),
        SOUND(8),
        VOICE(9),
        LIPS(10),
        RIMS(11),
        CUSTOM_MODULES(12),
        CUSTOM_FOLDERS(13);

        private final long id;
        BiowareSearchLocationId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareSearchLocationId> byId = new HashMap<Long, BiowareSearchLocationId>(14);
        static {
            for (BiowareSearchLocationId e : BiowareSearchLocationId.values())
                byId.put(e.id(), e);
        }
        public static BiowareSearchLocationId byId(long id) { return byId.get(id); }
    }

    public BiowareExtractCommon(KaitaiStream _io) {
        this(_io, null, null);
    }

    public BiowareExtractCommon(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public BiowareExtractCommon(KaitaiStream _io, KaitaiStruct _parent, BiowareExtractCommon _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
    }

    public void _fetchInstances() {
    }

    /**
     * String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
     */
    public static class BiowareTexturePackNameStr extends KaitaiStruct {
        public static BiowareTexturePackNameStr fromFile(String fileName) throws IOException {
            return new BiowareTexturePackNameStr(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareTexturePackNameStr(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareTexturePackNameStr(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareTexturePackNameStr(KaitaiStream _io, KaitaiStruct _parent, BiowareExtractCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.value = new String(this._io.readBytesTerm((byte) 0, false, true, true), StandardCharsets.US_ASCII);
            if (!( ((this.value.equals("swpc_tex_tpa.erf")) || (this.value.equals("swpc_tex_tpb.erf")) || (this.value.equals("swpc_tex_tpc.erf")) || (this.value.equals("swpc_tex_gui.erf"))) )) {
                throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_texture_pack_name_str/seq/0");
            }
        }

        public void _fetchInstances() {
        }
        private String value;
        private BiowareExtractCommon _root;
        private KaitaiStruct _parent;
        public String value() { return value; }
        public BiowareExtractCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }
    private BiowareExtractCommon _root;
    private KaitaiStruct _parent;
    public BiowareExtractCommon _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
