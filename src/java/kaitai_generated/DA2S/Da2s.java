// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


/**
 * **DA2S** (Dragon Age 2 save): Eclipse binary save — `DA2S` signature, `version==1`, length-prefixed strings + tagged
 * blocks (party/inventory/journal/etc.). **Not KotOR** — Andastra serializers under `Game/Games/Eclipse/DragonAge2/Save/` (`meta.xref`).
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408">xoreos — `GameID` (`kGameIDDragonAge2` = 8)</a>
 * @see <a href="https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAge2/Save/DragonAge2SaveSerializer.cs#L24-L180">Andastra — `DragonAge2SaveSerializer`</a>
 * @see <a href="https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126">Andastra — `EclipseSaveSerializer` helpers</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (Dragon Age saves documented via Andastra + `GameID`; no DA2S-specific PDF here)</a>
 */
public class Da2s extends KaitaiStruct {
    public static Da2s fromFile(String fileName) throws IOException {
        return new Da2s(new ByteBufferKaitaiStream(fileName));
    }

    public Da2s(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Da2s(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Da2s(KaitaiStream _io, KaitaiStruct _parent, Da2s _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.signature = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!(this.signature.equals("DA2S"))) {
            throw new KaitaiStream.ValidationNotEqualError("DA2S", this.signature, this._io, "/seq/0");
        }
        this.version = this._io.readS4le();
        if (!(this.version == 1)) {
            throw new KaitaiStream.ValidationNotEqualError(1, this.version, this._io, "/seq/1");
        }
        this.saveName = new LengthPrefixedString(this._io, this, _root);
        this.moduleName = new LengthPrefixedString(this._io, this, _root);
        this.areaName = new LengthPrefixedString(this._io, this, _root);
        this.timePlayedSeconds = this._io.readS4le();
        this.timestampFiletime = this._io.readS8le();
        this.numScreenshotData = this._io.readS4le();
        if (numScreenshotData() > 0) {
            this.screenshotData = new ArrayList<Integer>();
            for (int i = 0; i < numScreenshotData(); i++) {
                this.screenshotData.add(this._io.readU1());
            }
        }
        this.numPortraitData = this._io.readS4le();
        if (numPortraitData() > 0) {
            this.portraitData = new ArrayList<Integer>();
            for (int i = 0; i < numPortraitData(); i++) {
                this.portraitData.add(this._io.readU1());
            }
        }
        this.playerName = new LengthPrefixedString(this._io, this, _root);
        this.partyMemberCount = this._io.readS4le();
        this.playerLevel = this._io.readS4le();
    }

    public void _fetchInstances() {
        this.saveName._fetchInstances();
        this.moduleName._fetchInstances();
        this.areaName._fetchInstances();
        if (numScreenshotData() > 0) {
            for (int i = 0; i < this.screenshotData.size(); i++) {
            }
        }
        if (numPortraitData() > 0) {
            for (int i = 0; i < this.portraitData.size(); i++) {
            }
        }
        this.playerName._fetchInstances();
    }
    public static class LengthPrefixedString extends KaitaiStruct {
        public static LengthPrefixedString fromFile(String fileName) throws IOException {
            return new LengthPrefixedString(new ByteBufferKaitaiStream(fileName));
        }

        public LengthPrefixedString(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LengthPrefixedString(KaitaiStream _io, Da2s _parent) {
            this(_io, _parent, null);
        }

        public LengthPrefixedString(KaitaiStream _io, Da2s _parent, Da2s _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.length = this._io.readS4le();
            this.value = new String(KaitaiStream.bytesTerminate(this._io.readBytes(length()), (byte) 0, false), StandardCharsets.UTF_8);
        }

        public void _fetchInstances() {
        }
        private String valueTrimmed;

        /**
         * String value.
         * Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
         */
        public String valueTrimmed() {
            if (this.valueTrimmed != null)
                return this.valueTrimmed;
            this.valueTrimmed = value();
            return this.valueTrimmed;
        }
        private int length;
        private String value;
        private Da2s _root;
        private Da2s _parent;

        /**
         * String length in bytes (UTF-8 encoding).
         * Must be >= 0 and <= 65536 (sanity check).
         */
        public int length() { return length; }

        /**
         * String value (UTF-8 encoded)
         */
        public String value() { return value; }
        public Da2s _root() { return _root; }
        public Da2s _parent() { return _parent; }
    }
    private String signature;
    private int version;
    private LengthPrefixedString saveName;
    private LengthPrefixedString moduleName;
    private LengthPrefixedString areaName;
    private int timePlayedSeconds;
    private long timestampFiletime;
    private int numScreenshotData;
    private List<Integer> screenshotData;
    private int numPortraitData;
    private List<Integer> portraitData;
    private LengthPrefixedString playerName;
    private int partyMemberCount;
    private int playerLevel;
    private Da2s _root;
    private KaitaiStruct _parent;

    /**
     * File signature. Must be "DA2S" for Dragon Age 2 save files.
     */
    public String signature() { return signature; }

    /**
     * Save format version. Must be 1 for Dragon Age 2.
     */
    public int version() { return version; }

    /**
     * User-entered save name displayed in UI
     */
    public LengthPrefixedString saveName() { return saveName; }

    /**
     * Current module resource name
     */
    public LengthPrefixedString moduleName() { return moduleName; }

    /**
     * Current area name for display
     */
    public LengthPrefixedString areaName() { return areaName; }

    /**
     * Total play time in seconds
     */
    public int timePlayedSeconds() { return timePlayedSeconds; }

    /**
     * Save creation timestamp as Windows FILETIME (int64).
     * Convert using DateTime.FromFileTime().
     */
    public long timestampFiletime() { return timestampFiletime; }

    /**
     * Length of screenshot data in bytes (0 if no screenshot)
     */
    public int numScreenshotData() { return numScreenshotData; }

    /**
     * Screenshot image data (typically TGA or DDS format)
     */
    public List<Integer> screenshotData() { return screenshotData; }

    /**
     * Length of portrait data in bytes (0 if no portrait)
     */
    public int numPortraitData() { return numPortraitData; }

    /**
     * Portrait image data (typically TGA or DDS format)
     */
    public List<Integer> portraitData() { return portraitData; }

    /**
     * Player character name
     */
    public LengthPrefixedString playerName() { return playerName; }

    /**
     * Number of party members (from PartyState)
     */
    public int partyMemberCount() { return partyMemberCount; }

    /**
     * Player character level (from PartyState.PlayerCharacter)
     */
    public int playerLevel() { return playerLevel; }
    public Da2s _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
