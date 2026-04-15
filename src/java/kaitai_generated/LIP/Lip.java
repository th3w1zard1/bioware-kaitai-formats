// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


/**
 * **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
 * `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
 * 
 * xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no LIP-specific tool)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip">PyKotor wiki — LIP</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116">PyKotor — `io_lip` (Kaitai + legacy read/write)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/lip_data.py#L47-L127">PyKotor — `LIPShape` enum</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L41">reone — `LipReader::load`</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LIPObject.ts#L99-L118">KotOR.js — `LIPObject.readBinary`</a>
 * @see <a href="https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorLIP/LIP.cs">NickHugi/Kotor.NET — `LIP`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L180">xoreos — `kFileTypeLIP` (numeric id; no standalone `lipfile.cpp`)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no dedicated LIP Torlack/PDF; wire from PyKotor/reone)</a>
 */
public class Lip extends KaitaiStruct {
    public static Lip fromFile(String fileName) throws IOException {
        return new Lip(new ByteBufferKaitaiStream(fileName));
    }

    public Lip(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Lip(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Lip(KaitaiStream _io, KaitaiStruct _parent, Lip _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        this.fileVersion = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        this.length = this._io.readF4le();
        this.numKeyframes = this._io.readU4le();
        this.keyframes = new ArrayList<KeyframeEntry>();
        for (int i = 0; i < numKeyframes(); i++) {
            this.keyframes.add(new KeyframeEntry(this._io, this, _root));
        }
    }

    public void _fetchInstances() {
        for (int i = 0; i < this.keyframes.size(); i++) {
            this.keyframes.get(((Number) (i)).intValue())._fetchInstances();
        }
    }

    /**
     * A single keyframe entry mapping a timestamp to a viseme (mouth shape).
     * Keyframes are used by the engine to interpolate between mouth shapes during
     * audio playback to create lip sync animation.
     */
    public static class KeyframeEntry extends KaitaiStruct {
        public static KeyframeEntry fromFile(String fileName) throws IOException {
            return new KeyframeEntry(new ByteBufferKaitaiStream(fileName));
        }

        public KeyframeEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public KeyframeEntry(KaitaiStream _io, Lip _parent) {
            this(_io, _parent, null);
        }

        public KeyframeEntry(KaitaiStream _io, Lip _parent, Lip _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.timestamp = this._io.readF4le();
            this.shape = BiowareCommon.BiowareLipVisemeId.byId(this._io.readU1());
        }

        public void _fetchInstances() {
        }
        private float timestamp;
        private BiowareCommon.BiowareLipVisemeId shape;
        private Lip _root;
        private Lip _parent;

        /**
         * Seconds from animation start. Must be >= 0 and <= length.
         * Keyframes should be sorted ascending by timestamp.
         */
        public float timestamp() { return timestamp; }

        /**
         * Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
         * `bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).
         */
        public BiowareCommon.BiowareLipVisemeId shape() { return shape; }
        public Lip _root() { return _root; }
        public Lip _parent() { return _parent; }
    }
    private String fileType;
    private String fileVersion;
    private float length;
    private long numKeyframes;
    private List<KeyframeEntry> keyframes;
    private Lip _root;
    private KaitaiStruct _parent;

    /**
     * File type signature. Must be "LIP " (space-padded) for LIP files.
     */
    public String fileType() { return fileType; }

    /**
     * File format version. Must be "V1.0" for LIP files.
     */
    public String fileVersion() { return fileVersion; }

    /**
     * Duration in seconds. Must equal the paired WAV file playback time for
     * glitch-free animation. This is the total length of the lip sync animation.
     */
    public float length() { return length; }

    /**
     * Number of keyframes immediately following. Each keyframe contains a timestamp
     * and a viseme shape index. Keyframes should be sorted ascending by timestamp.
     */
    public long numKeyframes() { return numKeyframes; }

    /**
     * Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
     * Entries must be stored in chronological order (ascending by timestamp).
     */
    public List<KeyframeEntry> keyframes() { return keyframes; }
    public Lip _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
