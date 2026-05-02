// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
    /// MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
    /// 20-byte VO prefixes are application-level.
    /// 
    /// `wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.
    /// 
    /// The `xoreos-tools` tree does not ship a RIFF/WAVE wire parser on `master` (see `meta.xref.xoreos_tools_wav_note`); use xoreos `wave.cpp` / `sound.cpp` and PyKotor `io_wav.py` for chunk behavior.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav">PyKotor wiki — WAV</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L43-L187">PyKotor — `io_wav` (Kaitai RIFF parse + `WAVBinaryReader.load` + legacy)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/audio/format/wavreader.cpp#L30-L72">reone — `WavReader` (fake header + chunk loop)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106">xoreos — `makeWAVStream` / chunk scan</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp#L256-L340">xoreos — `SoundManager::makeAudioStream` KotOR WAVE quirks</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L62">xoreos — `kFileTypeWAV` (numeric id)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/audio/AudioFile.ts#L10-L145">KotOR.js — `AudioFile` (prefix + MP3-in-WAV)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree (no dedicated WAV PDF; discoverability anchor)</a>
    /// </remarks>
    public partial class Wav : KaitaiStruct
    {
        public static Wav FromFile(string fileName)
        {
            return new Wav(new KaitaiStream(fileName));
        }

        public Wav(KaitaiStream p__io, KaitaiStruct p__parent = null, Wav p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _riffHeader = new RiffHeader(m_io, this, m_root);
            _chunks = new List<Chunk>();
            {
                var i = 0;
                Chunk M_;
                do {
                    M_ = new Chunk(m_io, this, m_root);
                    _chunks.Add(M_);
                    i++;
                } while (!(M_Io.IsEof));
            }
        }
        public partial class Chunk : KaitaiStruct
        {
            public static Chunk FromFile(string fileName)
            {
                return new Chunk(new KaitaiStream(fileName));
            }

            public Chunk(KaitaiStream p__io, Wav p__parent = null, Wav p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _id = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                _size = m_io.ReadU4le();
                switch (Id) {
                case "data": {
                    _body = new DataChunkBody(m_io, this, m_root);
                    break;
                }
                case "fact": {
                    _body = new FactChunkBody(m_io, this, m_root);
                    break;
                }
                case "fmt ": {
                    _body = new FormatChunkBody(m_io, this, m_root);
                    break;
                }
                default: {
                    _body = new UnknownChunkBody(m_io, this, m_root);
                    break;
                }
                }
            }
            private string _id;
            private uint _size;
            private KaitaiStruct _body;
            private Wav m_root;
            private Wav m_parent;

            /// <summary>
            /// Chunk ID (4-character ASCII string)
            /// Common values: &quot;fmt &quot;, &quot;data&quot;, &quot;fact&quot;, &quot;LIST&quot;, etc.
            /// Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L58-L72
            /// </summary>
            public string Id { get { return _id; } }

            /// <summary>
            /// Chunk size in bytes (chunk data only, excluding ID and size fields)
            /// Chunks are word-aligned (even byte boundaries)
            /// Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
            /// </summary>
            public uint Size { get { return _size; } }

            /// <summary>
            /// Chunk body (content depends on chunk ID)
            /// </summary>
            public KaitaiStruct Body { get { return _body; } }
            public Wav M_Root { get { return m_root; } }
            public Wav M_Parent { get { return m_parent; } }
        }
        public partial class DataChunkBody : KaitaiStruct
        {
            public static DataChunkBody FromFile(string fileName)
            {
                return new DataChunkBody(new KaitaiStream(fileName));
            }

            public DataChunkBody(KaitaiStream p__io, Wav.Chunk p__parent = null, Wav p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _data = m_io.ReadBytes(M_Parent.Size);
            }
            private byte[] _data;
            private Wav m_root;
            private Wav.Chunk m_parent;

            /// <summary>
            /// Raw audio data (PCM samples or compressed audio)
            /// Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L79-L80
            /// </summary>
            public byte[] Data { get { return _data; } }
            public Wav M_Root { get { return m_root; } }
            public Wav.Chunk M_Parent { get { return m_parent; } }
        }
        public partial class FactChunkBody : KaitaiStruct
        {
            public static FactChunkBody FromFile(string fileName)
            {
                return new FactChunkBody(new KaitaiStream(fileName));
            }

            public FactChunkBody(KaitaiStream p__io, Wav.Chunk p__parent = null, Wav p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _sampleCount = m_io.ReadU4le();
            }
            private uint _sampleCount;
            private Wav m_root;
            private Wav.Chunk m_parent;

            /// <summary>
            /// Sample count (number of samples in compressed audio)
            /// Used for compressed formats like ADPCM
            /// Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L234-L236 (`fact` chunk skip — sample count lives in chunk body)
            /// </summary>
            public uint SampleCount { get { return _sampleCount; } }
            public Wav M_Root { get { return m_root; } }
            public Wav.Chunk M_Parent { get { return m_parent; } }
        }
        public partial class FormatChunkBody : KaitaiStruct
        {
            public static FormatChunkBody FromFile(string fileName)
            {
                return new FormatChunkBody(new KaitaiStream(fileName));
            }

            public FormatChunkBody(KaitaiStream p__io, Wav.Chunk p__parent = null, Wav p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_isImaAdpcm = false;
                f_isMp3 = false;
                f_isPcm = false;
                _read();
            }
            private void _read()
            {
                _audioFormat = ((BiowareCommon.RiffWaveFormatTag) m_io.ReadU2le());
                _channels = m_io.ReadU2le();
                _sampleRate = m_io.ReadU4le();
                _bytesPerSec = m_io.ReadU4le();
                _blockAlign = m_io.ReadU2le();
                _bitsPerSample = m_io.ReadU2le();
                if (M_Parent.Size > 16) {
                    _extraFormatBytes = m_io.ReadBytes(M_Parent.Size - 16);
                }
            }
            private bool f_isImaAdpcm;
            private bool _isImaAdpcm;

            /// <summary>
            /// True if audio format is IMA ADPCM (compressed)
            /// </summary>
            public bool IsImaAdpcm
            {
                get
                {
                    if (f_isImaAdpcm)
                        return _isImaAdpcm;
                    f_isImaAdpcm = true;
                    _isImaAdpcm = (bool) (AudioFormat == BiowareCommon.RiffWaveFormatTag.DviImaAdpcm);
                    return _isImaAdpcm;
                }
            }
            private bool f_isMp3;
            private bool _isMp3;

            /// <summary>
            /// True if audio format is MP3
            /// </summary>
            public bool IsMp3
            {
                get
                {
                    if (f_isMp3)
                        return _isMp3;
                    f_isMp3 = true;
                    _isMp3 = (bool) (AudioFormat == BiowareCommon.RiffWaveFormatTag.MpegLayer3);
                    return _isMp3;
                }
            }
            private bool f_isPcm;
            private bool _isPcm;

            /// <summary>
            /// True if audio format is PCM (uncompressed)
            /// </summary>
            public bool IsPcm
            {
                get
                {
                    if (f_isPcm)
                        return _isPcm;
                    f_isPcm = true;
                    _isPcm = (bool) (AudioFormat == BiowareCommon.RiffWaveFormatTag.Pcm);
                    return _isPcm;
                }
            }
            private BiowareCommon.RiffWaveFormatTag _audioFormat;
            private ushort _channels;
            private uint _sampleRate;
            private uint _bytesPerSec;
            private ushort _blockAlign;
            private ushort _bitsPerSample;
            private byte[] _extraFormatBytes;
            private Wav m_root;
            private Wav.Chunk m_parent;

            /// <summary>
            /// RIFF `fmt ` / `WAVEFORMATEX.wFormatTag` (`u2` LE). Canonical: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`
            /// (Microsoft `WAVEFORMATEX`; KotOR usage: PyKotor WAV wiki, xoreos `wave.cpp`).
            /// </summary>
            public BiowareCommon.RiffWaveFormatTag AudioFormat { get { return _audioFormat; } }

            /// <summary>
            /// Number of audio channels:
            /// - 1 = mono
            /// - 2 = stereo
            /// Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
            /// </summary>
            public ushort Channels { get { return _channels; } }

            /// <summary>
            /// Sample rate in Hz
            /// Typical values:
            /// - 22050 Hz for SFX
            /// - 44100 Hz for VO
            /// Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
            /// </summary>
            public uint SampleRate { get { return _sampleRate; } }

            /// <summary>
            /// Byte rate (average bytes per second)
            /// Formula: sample_rate × block_align
            /// Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
            /// </summary>
            public uint BytesPerSec { get { return _bytesPerSec; } }

            /// <summary>
            /// Block alignment (bytes per sample frame)
            /// Formula for PCM: channels × (bits_per_sample / 8)
            /// Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
            /// </summary>
            public ushort BlockAlign { get { return _blockAlign; } }

            /// <summary>
            /// Bits per sample
            /// Common values: 8, 16
            /// For PCM: typically 16-bit
            /// Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
            /// </summary>
            public ushort BitsPerSample { get { return _bitsPerSample; } }

            /// <summary>
            /// Extra format bytes (present when fmt chunk size &gt; 16)
            /// For IMA ADPCM and other compressed formats, contains:
            /// - Extra format size (u2)
            /// - Format-specific data (e.g., ADPCM coefficients)
            /// Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
            /// </summary>
            public byte[] ExtraFormatBytes { get { return _extraFormatBytes; } }
            public Wav M_Root { get { return m_root; } }
            public Wav.Chunk M_Parent { get { return m_parent; } }
        }
        public partial class RiffHeader : KaitaiStruct
        {
            public static RiffHeader FromFile(string fileName)
            {
                return new RiffHeader(new KaitaiStream(fileName));
            }

            public RiffHeader(KaitaiStream p__io, Wav p__parent = null, Wav p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_isMp3InWav = false;
                _read();
            }
            private void _read()
            {
                _riffId = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!(_riffId == "RIFF"))
                {
                    throw new ValidationNotEqualError("RIFF", _riffId, m_io, "/types/riff_header/seq/0");
                }
                _riffSize = m_io.ReadU4le();
                _waveId = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!(_waveId == "WAVE"))
                {
                    throw new ValidationNotEqualError("WAVE", _waveId, m_io, "/types/riff_header/seq/2");
                }
            }
            private bool f_isMp3InWav;
            private bool _isMp3InWav;

            /// <summary>
            /// MP3-in-WAV format detected when RIFF size = 50
            /// Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)
            /// </summary>
            public bool IsMp3InWav
            {
                get
                {
                    if (f_isMp3InWav)
                        return _isMp3InWav;
                    f_isMp3InWav = true;
                    _isMp3InWav = (bool) (RiffSize == 50);
                    return _isMp3InWav;
                }
            }
            private string _riffId;
            private uint _riffSize;
            private string _waveId;
            private Wav m_root;
            private Wav m_parent;

            /// <summary>
            /// RIFF chunk ID: &quot;RIFF&quot;
            /// </summary>
            public string RiffId { get { return _riffId; } }

            /// <summary>
            /// File size minus 8 bytes (RIFF_ID + RIFF_SIZE itself)
            /// For MP3-in-WAV format, this is 50
            /// Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
            /// </summary>
            public uint RiffSize { get { return _riffSize; } }

            /// <summary>
            /// Format tag: &quot;WAVE&quot;
            /// </summary>
            public string WaveId { get { return _waveId; } }
            public Wav M_Root { get { return m_root; } }
            public Wav M_Parent { get { return m_parent; } }
        }
        public partial class UnknownChunkBody : KaitaiStruct
        {
            public static UnknownChunkBody FromFile(string fileName)
            {
                return new UnknownChunkBody(new KaitaiStream(fileName));
            }

            public UnknownChunkBody(KaitaiStream p__io, Wav.Chunk p__parent = null, Wav p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _data = m_io.ReadBytes(M_Parent.Size);
                if (KaitaiStream.Mod(M_Parent.Size, 2) == 1) {
                    _padding = m_io.ReadU1();
                }
            }
            private byte[] _data;
            private byte? _padding;
            private Wav m_root;
            private Wav.Chunk m_parent;

            /// <summary>
            /// Unknown chunk body (skip for compatibility)
            /// Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L53-L54
            /// </summary>
            public byte[] Data { get { return _data; } }

            /// <summary>
            /// Padding byte to align to word boundary (only if chunk size is odd)
            /// RIFF chunks must be aligned to 2-byte boundaries
            /// Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L243-L245 (unknown chunk skip + optional 1-byte word alignment)
            /// </summary>
            public byte? Padding { get { return _padding; } }
            public Wav M_Root { get { return m_root; } }
            public Wav.Chunk M_Parent { get { return m_parent; } }
        }
        private RiffHeader _riffHeader;
        private List<Chunk> _chunks;
        private Wav m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// RIFF container header
        /// </summary>
        public RiffHeader RiffHeader { get { return _riffHeader; } }

        /// <summary>
        /// RIFF chunks in sequence (fmt, fact, data, etc.)
        /// Parsed until end of file
        /// Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L46-L55
        /// </summary>
        public List<Chunk> Chunks { get { return _chunks; } }
        public Wav M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
