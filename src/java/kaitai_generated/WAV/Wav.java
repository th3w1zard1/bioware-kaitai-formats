// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.ArrayList;
import java.nio.charset.StandardCharsets;
import java.util.List;


/**
 * **KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
 * MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
 * 20-byte VO prefixes are application-level.
 * 
 * `wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.
 * 
 * The `xoreos-tools` tree does not ship a RIFF/WAVE wire parser on `master` (see `meta.xref.xoreos_tools_wav_note`); use xoreos `wave.cpp` / `sound.cpp` and PyKotor `io_wav.py` for chunk behavior.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav">PyKotor wiki — WAV</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L43-L187">PyKotor — `io_wav` (Kaitai RIFF parse + `WAVBinaryReader.load` + legacy)</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/audio/format/wavreader.cpp#L30-L72">reone — `WavReader` (fake header + chunk loop)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106">xoreos — `makeWAVStream` / chunk scan</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp#L256-L340">xoreos — `SoundManager::makeAudioStream` KotOR WAVE quirks</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L62">xoreos — `kFileTypeWAV` (numeric id)</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/audio/AudioFile.ts#L10-L145">KotOR.js — `AudioFile` (prefix + MP3-in-WAV)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree (no dedicated WAV PDF; discoverability anchor)</a>
 */
public class Wav extends KaitaiStruct {
    public static Wav fromFile(String fileName) throws IOException {
        return new Wav(new ByteBufferKaitaiStream(fileName));
    }

    public Wav(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Wav(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Wav(KaitaiStream _io, KaitaiStruct _parent, Wav _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.riffHeader = new RiffHeader(this._io, this, _root);
        this.chunks = new ArrayList<Chunk>();
        {
            Chunk _it;
            int i = 0;
            do {
                _it = new Chunk(this._io, this, _root);
                this.chunks.add(_it);
                i++;
            } while (!(_io().isEof()));
        }
    }

    public void _fetchInstances() {
        this.riffHeader._fetchInstances();
        for (int i = 0; i < this.chunks.size(); i++) {
            this.chunks.get(((Number) (i)).intValue())._fetchInstances();
        }
    }
    public static class Chunk extends KaitaiStruct {
        public static Chunk fromFile(String fileName) throws IOException {
            return new Chunk(new ByteBufferKaitaiStream(fileName));
        }

        public Chunk(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Chunk(KaitaiStream _io, Wav _parent) {
            this(_io, _parent, null);
        }

        public Chunk(KaitaiStream _io, Wav _parent, Wav _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.id = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            this.size = this._io.readU4le();
            switch (id()) {
            case "data": {
                this.body = new DataChunkBody(this._io, this, _root);
                break;
            }
            case "fact": {
                this.body = new FactChunkBody(this._io, this, _root);
                break;
            }
            case "fmt ": {
                this.body = new FormatChunkBody(this._io, this, _root);
                break;
            }
            default: {
                this.body = new UnknownChunkBody(this._io, this, _root);
                break;
            }
            }
        }

        public void _fetchInstances() {
            switch (id()) {
            case "data": {
                ((DataChunkBody) (this.body))._fetchInstances();
                break;
            }
            case "fact": {
                ((FactChunkBody) (this.body))._fetchInstances();
                break;
            }
            case "fmt ": {
                ((FormatChunkBody) (this.body))._fetchInstances();
                break;
            }
            default: {
                ((UnknownChunkBody) (this.body))._fetchInstances();
                break;
            }
            }
        }
        private String id;
        private long size;
        private KaitaiStruct body;
        private Wav _root;
        private Wav _parent;

        /**
         * Chunk ID (4-character ASCII string)
         * Common values: "fmt ", "data", "fact", "LIST", etc.
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L58-L72
         */
        public String id() { return id; }

        /**
         * Chunk size in bytes (chunk data only, excluding ID and size fields)
         * Chunks are word-aligned (even byte boundaries)
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
         */
        public long size() { return size; }

        /**
         * Chunk body (content depends on chunk ID)
         */
        public KaitaiStruct body() { return body; }
        public Wav _root() { return _root; }
        public Wav _parent() { return _parent; }
    }
    public static class DataChunkBody extends KaitaiStruct {
        public static DataChunkBody fromFile(String fileName) throws IOException {
            return new DataChunkBody(new ByteBufferKaitaiStream(fileName));
        }

        public DataChunkBody(KaitaiStream _io) {
            this(_io, null, null);
        }

        public DataChunkBody(KaitaiStream _io, Wav.Chunk _parent) {
            this(_io, _parent, null);
        }

        public DataChunkBody(KaitaiStream _io, Wav.Chunk _parent, Wav _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.data = this._io.readBytes(_parent().size());
        }

        public void _fetchInstances() {
        }
        private byte[] data;
        private Wav _root;
        private Wav.Chunk _parent;

        /**
         * Raw audio data (PCM samples or compressed audio)
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L79-L80
         */
        public byte[] data() { return data; }
        public Wav _root() { return _root; }
        public Wav.Chunk _parent() { return _parent; }
    }
    public static class FactChunkBody extends KaitaiStruct {
        public static FactChunkBody fromFile(String fileName) throws IOException {
            return new FactChunkBody(new ByteBufferKaitaiStream(fileName));
        }

        public FactChunkBody(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FactChunkBody(KaitaiStream _io, Wav.Chunk _parent) {
            this(_io, _parent, null);
        }

        public FactChunkBody(KaitaiStream _io, Wav.Chunk _parent, Wav _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.sampleCount = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private long sampleCount;
        private Wav _root;
        private Wav.Chunk _parent;

        /**
         * Sample count (number of samples in compressed audio)
         * Used for compressed formats like ADPCM
         * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L234-L236 (`fact` chunk skip — sample count lives in chunk body)
         */
        public long sampleCount() { return sampleCount; }
        public Wav _root() { return _root; }
        public Wav.Chunk _parent() { return _parent; }
    }
    public static class FormatChunkBody extends KaitaiStruct {
        public static FormatChunkBody fromFile(String fileName) throws IOException {
            return new FormatChunkBody(new ByteBufferKaitaiStream(fileName));
        }

        public FormatChunkBody(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FormatChunkBody(KaitaiStream _io, Wav.Chunk _parent) {
            this(_io, _parent, null);
        }

        public FormatChunkBody(KaitaiStream _io, Wav.Chunk _parent, Wav _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.audioFormat = BiowareCommon.RiffWaveFormatTag.byId(this._io.readU2le());
            this.channels = this._io.readU2le();
            this.sampleRate = this._io.readU4le();
            this.bytesPerSec = this._io.readU4le();
            this.blockAlign = this._io.readU2le();
            this.bitsPerSample = this._io.readU2le();
            if (_parent().size() > 16) {
                this.extraFormatBytes = this._io.readBytes(_parent().size() - 16);
            }
        }

        public void _fetchInstances() {
            if (_parent().size() > 16) {
            }
        }
        private Boolean isImaAdpcm;

        /**
         * True if audio format is IMA ADPCM (compressed)
         */
        public Boolean isImaAdpcm() {
            if (this.isImaAdpcm != null)
                return this.isImaAdpcm;
            this.isImaAdpcm = audioFormat() == BiowareCommon.RiffWaveFormatTag.DVI_IMA_ADPCM;
            return this.isImaAdpcm;
        }
        private Boolean isMp3;

        /**
         * True if audio format is MP3
         */
        public Boolean isMp3() {
            if (this.isMp3 != null)
                return this.isMp3;
            this.isMp3 = audioFormat() == BiowareCommon.RiffWaveFormatTag.MPEG_LAYER3;
            return this.isMp3;
        }
        private Boolean isPcm;

        /**
         * True if audio format is PCM (uncompressed)
         */
        public Boolean isPcm() {
            if (this.isPcm != null)
                return this.isPcm;
            this.isPcm = audioFormat() == BiowareCommon.RiffWaveFormatTag.PCM;
            return this.isPcm;
        }
        private BiowareCommon.RiffWaveFormatTag audioFormat;
        private int channels;
        private long sampleRate;
        private long bytesPerSec;
        private int blockAlign;
        private int bitsPerSample;
        private byte[] extraFormatBytes;
        private Wav _root;
        private Wav.Chunk _parent;

        /**
         * RIFF `fmt ` / `WAVEFORMATEX.wFormatTag` (`u2` LE). Canonical: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`
         * (Microsoft `WAVEFORMATEX`; KotOR usage: PyKotor WAV wiki, xoreos `wave.cpp`).
         */
        public BiowareCommon.RiffWaveFormatTag audioFormat() { return audioFormat; }

        /**
         * Number of audio channels:
         * - 1 = mono
         * - 2 = stereo
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public int channels() { return channels; }

        /**
         * Sample rate in Hz
         * Typical values:
         * - 22050 Hz for SFX
         * - 44100 Hz for VO
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public long sampleRate() { return sampleRate; }

        /**
         * Byte rate (average bytes per second)
         * Formula: sample_rate × block_align
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public long bytesPerSec() { return bytesPerSec; }

        /**
         * Block alignment (bytes per sample frame)
         * Formula for PCM: channels × (bits_per_sample / 8)
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public int blockAlign() { return blockAlign; }

        /**
         * Bits per sample
         * Common values: 8, 16
         * For PCM: typically 16-bit
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public int bitsPerSample() { return bitsPerSample; }

        /**
         * Extra format bytes (present when fmt chunk size > 16)
         * For IMA ADPCM and other compressed formats, contains:
         * - Extra format size (u2)
         * - Format-specific data (e.g., ADPCM coefficients)
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
         */
        public byte[] extraFormatBytes() { return extraFormatBytes; }
        public Wav _root() { return _root; }
        public Wav.Chunk _parent() { return _parent; }
    }
    public static class RiffHeader extends KaitaiStruct {
        public static RiffHeader fromFile(String fileName) throws IOException {
            return new RiffHeader(new ByteBufferKaitaiStream(fileName));
        }

        public RiffHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public RiffHeader(KaitaiStream _io, Wav _parent) {
            this(_io, _parent, null);
        }

        public RiffHeader(KaitaiStream _io, Wav _parent, Wav _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.riffId = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.riffId.equals("RIFF"))) {
                throw new KaitaiStream.ValidationNotEqualError("RIFF", this.riffId, this._io, "/types/riff_header/seq/0");
            }
            this.riffSize = this._io.readU4le();
            this.waveId = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.waveId.equals("WAVE"))) {
                throw new KaitaiStream.ValidationNotEqualError("WAVE", this.waveId, this._io, "/types/riff_header/seq/2");
            }
        }

        public void _fetchInstances() {
        }
        private Boolean isMp3InWav;

        /**
         * MP3-in-WAV format detected when RIFF size = 50
         * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)
         */
        public Boolean isMp3InWav() {
            if (this.isMp3InWav != null)
                return this.isMp3InWav;
            this.isMp3InWav = riffSize() == 50;
            return this.isMp3InWav;
        }
        private String riffId;
        private long riffSize;
        private String waveId;
        private Wav _root;
        private Wav _parent;

        /**
         * RIFF chunk ID: "RIFF"
         */
        public String riffId() { return riffId; }

        /**
         * File size minus 8 bytes (RIFF_ID + RIFF_SIZE itself)
         * For MP3-in-WAV format, this is 50
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public long riffSize() { return riffSize; }

        /**
         * Format tag: "WAVE"
         */
        public String waveId() { return waveId; }
        public Wav _root() { return _root; }
        public Wav _parent() { return _parent; }
    }
    public static class UnknownChunkBody extends KaitaiStruct {
        public static UnknownChunkBody fromFile(String fileName) throws IOException {
            return new UnknownChunkBody(new ByteBufferKaitaiStream(fileName));
        }

        public UnknownChunkBody(KaitaiStream _io) {
            this(_io, null, null);
        }

        public UnknownChunkBody(KaitaiStream _io, Wav.Chunk _parent) {
            this(_io, _parent, null);
        }

        public UnknownChunkBody(KaitaiStream _io, Wav.Chunk _parent, Wav _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.data = this._io.readBytes(_parent().size());
            if (KaitaiStream.mod(_parent().size(), 2) == 1) {
                this.padding = this._io.readU1();
            }
        }

        public void _fetchInstances() {
            if (KaitaiStream.mod(_parent().size(), 2) == 1) {
            }
        }
        private byte[] data;
        private Integer padding;
        private Wav _root;
        private Wav.Chunk _parent;

        /**
         * Unknown chunk body (skip for compatibility)
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L53-L54
         */
        public byte[] data() { return data; }

        /**
         * Padding byte to align to word boundary (only if chunk size is odd)
         * RIFF chunks must be aligned to 2-byte boundaries
         * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L243-L245 (unknown chunk skip + optional 1-byte word alignment)
         */
        public Integer padding() { return padding; }
        public Wav _root() { return _root; }
        public Wav.Chunk _parent() { return _parent; }
    }
    private RiffHeader riffHeader;
    private List<Chunk> chunks;
    private Wav _root;
    private KaitaiStruct _parent;

    /**
     * RIFF container header
     */
    public RiffHeader riffHeader() { return riffHeader; }

    /**
     * RIFF chunks in sequence (fmt, fact, data, etc.)
     * Parsed until end of file
     * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L46-L55
     */
    public List<Chunk> chunks() { return chunks; }
    public Wav _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
