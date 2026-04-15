// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareCommon'));
  } else {
    factory(root.Wav || (root.Wav = {}), root.KaitaiStream, root.BiowareCommon || (root.BiowareCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Wav_, KaitaiStream, BiowareCommon_) {
/**
 * **KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
 * MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
 * 20-byte VO prefixes are application-level.
 * 
 * `wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav|PyKotor wiki — WAV}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106|xoreos — wave decoder}
 */

var Wav = (function() {
  function Wav(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Wav.prototype._read = function() {
    this.riffHeader = new RiffHeader(this._io, this, this._root);
    this.chunks = [];
    var i = 0;
    do {
      var _ = new Chunk(this._io, this, this._root);
      this.chunks.push(_);
      i++;
    } while (!(this._io.isEof()));
  }

  var Chunk = Wav.Chunk = (function() {
    function Chunk(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Chunk.prototype._read = function() {
      this.id = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      this.size = this._io.readU4le();
      switch (this.id) {
      case "data":
        this.body = new DataChunkBody(this._io, this, this._root);
        break;
      case "fact":
        this.body = new FactChunkBody(this._io, this, this._root);
        break;
      case "fmt ":
        this.body = new FormatChunkBody(this._io, this, this._root);
        break;
      default:
        this.body = new UnknownChunkBody(this._io, this, this._root);
        break;
      }
    }

    /**
     * Chunk ID (4-character ASCII string)
     * Common values: "fmt ", "data", "fact", "LIST", etc.
     * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L58-L72
     */

    /**
     * Chunk size in bytes (chunk data only, excluding ID and size fields)
     * Chunks are word-aligned (even byte boundaries)
     * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
     */

    /**
     * Chunk body (content depends on chunk ID)
     */

    return Chunk;
  })();

  var DataChunkBody = Wav.DataChunkBody = (function() {
    function DataChunkBody(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    DataChunkBody.prototype._read = function() {
      this.data = this._io.readBytes(this._parent.size);
    }

    /**
     * Raw audio data (PCM samples or compressed audio)
     * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L79-L80
     */

    return DataChunkBody;
  })();

  var FactChunkBody = Wav.FactChunkBody = (function() {
    function FactChunkBody(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FactChunkBody.prototype._read = function() {
      this.sampleCount = this._io.readU4le();
    }

    /**
     * Sample count (number of samples in compressed audio)
     * Used for compressed formats like ADPCM
     * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L234-L236 (`fact` chunk skip — sample count lives in chunk body)
     */

    return FactChunkBody;
  })();

  var FormatChunkBody = Wav.FormatChunkBody = (function() {
    function FormatChunkBody(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FormatChunkBody.prototype._read = function() {
      this.audioFormat = this._io.readU2le();
      this.channels = this._io.readU2le();
      this.sampleRate = this._io.readU4le();
      this.bytesPerSec = this._io.readU4le();
      this.blockAlign = this._io.readU2le();
      this.bitsPerSample = this._io.readU2le();
      if (this._parent.size > 16) {
        this.extraFormatBytes = this._io.readBytes(this._parent.size - 16);
      }
    }

    /**
     * True if audio format is IMA ADPCM (compressed)
     */
    Object.defineProperty(FormatChunkBody.prototype, 'isImaAdpcm', {
      get: function() {
        if (this._m_isImaAdpcm !== undefined)
          return this._m_isImaAdpcm;
        this._m_isImaAdpcm = this.audioFormat == BiowareCommon_.BiowareCommon.RiffWaveFormatTag.DVI_IMA_ADPCM;
        return this._m_isImaAdpcm;
      }
    });

    /**
     * True if audio format is MP3
     */
    Object.defineProperty(FormatChunkBody.prototype, 'isMp3', {
      get: function() {
        if (this._m_isMp3 !== undefined)
          return this._m_isMp3;
        this._m_isMp3 = this.audioFormat == BiowareCommon_.BiowareCommon.RiffWaveFormatTag.MPEG_LAYER3;
        return this._m_isMp3;
      }
    });

    /**
     * True if audio format is PCM (uncompressed)
     */
    Object.defineProperty(FormatChunkBody.prototype, 'isPcm', {
      get: function() {
        if (this._m_isPcm !== undefined)
          return this._m_isPcm;
        this._m_isPcm = this.audioFormat == BiowareCommon_.BiowareCommon.RiffWaveFormatTag.PCM;
        return this._m_isPcm;
      }
    });

    /**
     * RIFF `fmt ` / `WAVEFORMATEX.wFormatTag` (`u2` LE). Canonical: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`
     * (Microsoft `WAVEFORMATEX`; KotOR usage: PyKotor WAV wiki, xoreos `wave.cpp`).
     */

    /**
     * Number of audio channels:
     * - 1 = mono
     * - 2 = stereo
     * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
     */

    /**
     * Sample rate in Hz
     * Typical values:
     * - 22050 Hz for SFX
     * - 44100 Hz for VO
     * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
     */

    /**
     * Byte rate (average bytes per second)
     * Formula: sample_rate × block_align
     * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
     */

    /**
     * Block alignment (bytes per sample frame)
     * Formula for PCM: channels × (bits_per_sample / 8)
     * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
     */

    /**
     * Bits per sample
     * Common values: 8, 16
     * For PCM: typically 16-bit
     * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
     */

    /**
     * Extra format bytes (present when fmt chunk size > 16)
     * For IMA ADPCM and other compressed formats, contains:
     * - Extra format size (u2)
     * - Format-specific data (e.g., ADPCM coefficients)
     * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
     */

    return FormatChunkBody;
  })();

  var RiffHeader = Wav.RiffHeader = (function() {
    function RiffHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    RiffHeader.prototype._read = function() {
      this.riffId = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.riffId == "RIFF")) {
        throw new KaitaiStream.ValidationNotEqualError("RIFF", this.riffId, this._io, "/types/riff_header/seq/0");
      }
      this.riffSize = this._io.readU4le();
      this.waveId = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.waveId == "WAVE")) {
        throw new KaitaiStream.ValidationNotEqualError("WAVE", this.waveId, this._io, "/types/riff_header/seq/2");
      }
    }

    /**
     * MP3-in-WAV format detected when RIFF size = 50
     * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)
     */
    Object.defineProperty(RiffHeader.prototype, 'isMp3InWav', {
      get: function() {
        if (this._m_isMp3InWav !== undefined)
          return this._m_isMp3InWav;
        this._m_isMp3InWav = this.riffSize == 50;
        return this._m_isMp3InWav;
      }
    });

    /**
     * RIFF chunk ID: "RIFF"
     */

    /**
     * File size minus 8 bytes (RIFF_ID + RIFF_SIZE itself)
     * For MP3-in-WAV format, this is 50
     * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
     */

    /**
     * Format tag: "WAVE"
     */

    return RiffHeader;
  })();

  var UnknownChunkBody = Wav.UnknownChunkBody = (function() {
    function UnknownChunkBody(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    UnknownChunkBody.prototype._read = function() {
      this.data = this._io.readBytes(this._parent.size);
      if (KaitaiStream.mod(this._parent.size, 2) == 1) {
        this.padding = this._io.readU1();
      }
    }

    /**
     * Unknown chunk body (skip for compatibility)
     * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L53-L54
     */

    /**
     * Padding byte to align to word boundary (only if chunk size is odd)
     * RIFF chunks must be aligned to 2-byte boundaries
     * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L243-L245 (unknown chunk skip + optional 1-byte word alignment)
     */

    return UnknownChunkBody;
  })();

  /**
   * RIFF container header
   */

  /**
   * RIFF chunks in sequence (fmt, fact, data, etc.)
   * Parsed until end of file
   * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L46-L55
   */

  return Wav;
})();
Wav_.Wav = Wav;
});
