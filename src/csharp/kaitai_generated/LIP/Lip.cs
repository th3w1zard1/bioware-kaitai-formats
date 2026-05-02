// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
    /// `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
    /// 
    /// xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no LIP-specific tool)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip">PyKotor wiki — LIP</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116">PyKotor — `io_lip` (Kaitai + legacy read/write)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/lip_data.py#L47-L127">PyKotor — `LIPShape` enum</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L41">reone — `LipReader::load`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LIPObject.ts#L99-L118">KotOR.js — `LIPObject.readBinary`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorLIP/LIP.cs">NickHugi/Kotor.NET — `LIP`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L180">xoreos — `kFileTypeLIP` (numeric id; no standalone `lipfile.cpp`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no dedicated LIP Torlack/PDF; wire from PyKotor/reone)</a>
    /// </remarks>
    public partial class Lip : KaitaiStruct
    {
        public static Lip FromFile(string fileName)
        {
            return new Lip(new KaitaiStream(fileName));
        }

        public Lip(KaitaiStream p__io, KaitaiStruct p__parent = null, Lip p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            _length = m_io.ReadF4le();
            _numKeyframes = m_io.ReadU4le();
            _keyframes = new List<KeyframeEntry>();
            for (var i = 0; i < NumKeyframes; i++)
            {
                _keyframes.Add(new KeyframeEntry(m_io, this, m_root));
            }
        }

        /// <summary>
        /// A single keyframe entry mapping a timestamp to a viseme (mouth shape).
        /// Keyframes are used by the engine to interpolate between mouth shapes during
        /// audio playback to create lip sync animation.
        /// </summary>
        public partial class KeyframeEntry : KaitaiStruct
        {
            public static KeyframeEntry FromFile(string fileName)
            {
                return new KeyframeEntry(new KaitaiStream(fileName));
            }

            public KeyframeEntry(KaitaiStream p__io, Lip p__parent = null, Lip p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _timestamp = m_io.ReadF4le();
                _shape = ((BiowareCommon.BiowareLipVisemeId) m_io.ReadU1());
            }
            private float _timestamp;
            private BiowareCommon.BiowareLipVisemeId _shape;
            private Lip m_root;
            private Lip m_parent;

            /// <summary>
            /// Seconds from animation start. Must be &gt;= 0 and &lt;= length.
            /// Keyframes should be sorted ascending by timestamp.
            /// </summary>
            public float Timestamp { get { return _timestamp; } }

            /// <summary>
            /// Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
            /// `bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).
            /// </summary>
            public BiowareCommon.BiowareLipVisemeId Shape { get { return _shape; } }
            public Lip M_Root { get { return m_root; } }
            public Lip M_Parent { get { return m_parent; } }
        }
        private string _fileType;
        private string _fileVersion;
        private float _length;
        private uint _numKeyframes;
        private List<KeyframeEntry> _keyframes;
        private Lip m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File type signature. Must be &quot;LIP &quot; (space-padded) for LIP files.
        /// </summary>
        public string FileType { get { return _fileType; } }

        /// <summary>
        /// File format version. Must be &quot;V1.0&quot; for LIP files.
        /// </summary>
        public string FileVersion { get { return _fileVersion; } }

        /// <summary>
        /// Duration in seconds. Must equal the paired WAV file playback time for
        /// glitch-free animation. This is the total length of the lip sync animation.
        /// </summary>
        public float Length { get { return _length; } }

        /// <summary>
        /// Number of keyframes immediately following. Each keyframe contains a timestamp
        /// and a viseme shape index. Keyframes should be sorted ascending by timestamp.
        /// </summary>
        public uint NumKeyframes { get { return _numKeyframes; } }

        /// <summary>
        /// Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
        /// Entries must be stored in chronological order (ascending by timestamp).
        /// </summary>
        public List<KeyframeEntry> Keyframes { get { return _keyframes; } }
        public Lip M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
