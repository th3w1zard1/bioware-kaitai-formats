// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **DAS** (Dragon Age: Origins save): Eclipse binary save — `DAS ` signature, `version==1`, length-prefixed strings +
    /// tagged blocks. **Not KotOR** — reference serializers live under **Andastra** `Game/Games/Eclipse/...` on GitHub (`meta.xref`), not `Runtime/...`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408">xoreos — `GameID` (`kGameIDDragonAge` = 7)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAgeOrigins/Save/DragonAgeOriginsSaveSerializer.cs#L23-L180">Andastra — `DragonAgeOriginsSaveSerializer` (signature + nfo + archive entrypoints)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126">Andastra — `EclipseSaveSerializer` string + metadata helpers</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (DAO saves via Andastra; no DAS-specific PDF here)</a>
    /// </remarks>
    public partial class Das : KaitaiStruct
    {
        public static Das FromFile(string fileName)
        {
            return new Das(new KaitaiStream(fileName));
        }

        public Das(KaitaiStream p__io, KaitaiStruct p__parent = null, Das p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _signature = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_signature == "DAS "))
            {
                throw new ValidationNotEqualError("DAS ", _signature, m_io, "/seq/0");
            }
            _version = m_io.ReadS4le();
            if (!(_version == 1))
            {
                throw new ValidationNotEqualError(1, _version, m_io, "/seq/1");
            }
            _saveName = new LengthPrefixedString(m_io, this, m_root);
            _moduleName = new LengthPrefixedString(m_io, this, m_root);
            _areaName = new LengthPrefixedString(m_io, this, m_root);
            _timePlayedSeconds = m_io.ReadS4le();
            _timestampFiletime = m_io.ReadS8le();
            _numScreenshotData = m_io.ReadS4le();
            if (NumScreenshotData > 0) {
                _screenshotData = new List<byte>();
                for (var i = 0; i < NumScreenshotData; i++)
                {
                    _screenshotData.Add(m_io.ReadU1());
                }
            }
            _numPortraitData = m_io.ReadS4le();
            if (NumPortraitData > 0) {
                _portraitData = new List<byte>();
                for (var i = 0; i < NumPortraitData; i++)
                {
                    _portraitData.Add(m_io.ReadU1());
                }
            }
            _playerName = new LengthPrefixedString(m_io, this, m_root);
            _partyMemberCount = m_io.ReadS4le();
            _playerLevel = m_io.ReadS4le();
        }
        public partial class LengthPrefixedString : KaitaiStruct
        {
            public static LengthPrefixedString FromFile(string fileName)
            {
                return new LengthPrefixedString(new KaitaiStream(fileName));
            }

            public LengthPrefixedString(KaitaiStream p__io, Das p__parent = null, Das p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_valueTrimmed = false;
                _read();
            }
            private void _read()
            {
                _length = m_io.ReadS4le();
                _value = System.Text.Encoding.GetEncoding("UTF-8").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(Length), 0, false));
            }
            private bool f_valueTrimmed;
            private string _valueTrimmed;

            /// <summary>
            /// String value.
            /// Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
            /// </summary>
            public string ValueTrimmed
            {
                get
                {
                    if (f_valueTrimmed)
                        return _valueTrimmed;
                    f_valueTrimmed = true;
                    _valueTrimmed = (string) (Value);
                    return _valueTrimmed;
                }
            }
            private int _length;
            private string _value;
            private Das m_root;
            private Das m_parent;

            /// <summary>
            /// String length in bytes (UTF-8 encoding).
            /// Must be &gt;= 0 and &lt;= 65536 (sanity check).
            /// </summary>
            public int Length { get { return _length; } }

            /// <summary>
            /// String value (UTF-8 encoded)
            /// </summary>
            public string Value { get { return _value; } }
            public Das M_Root { get { return m_root; } }
            public Das M_Parent { get { return m_parent; } }
        }
        private string _signature;
        private int _version;
        private LengthPrefixedString _saveName;
        private LengthPrefixedString _moduleName;
        private LengthPrefixedString _areaName;
        private int _timePlayedSeconds;
        private long _timestampFiletime;
        private int _numScreenshotData;
        private List<byte> _screenshotData;
        private int _numPortraitData;
        private List<byte> _portraitData;
        private LengthPrefixedString _playerName;
        private int _partyMemberCount;
        private int _playerLevel;
        private Das m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File signature. Must be &quot;DAS &quot; for Dragon Age: Origins save files.
        /// </summary>
        public string Signature { get { return _signature; } }

        /// <summary>
        /// Save format version. Must be 1 for Dragon Age: Origins.
        /// </summary>
        public int Version { get { return _version; } }

        /// <summary>
        /// User-entered save name displayed in UI
        /// </summary>
        public LengthPrefixedString SaveName { get { return _saveName; } }

        /// <summary>
        /// Current module resource name
        /// </summary>
        public LengthPrefixedString ModuleName { get { return _moduleName; } }

        /// <summary>
        /// Current area name for display
        /// </summary>
        public LengthPrefixedString AreaName { get { return _areaName; } }

        /// <summary>
        /// Total play time in seconds
        /// </summary>
        public int TimePlayedSeconds { get { return _timePlayedSeconds; } }

        /// <summary>
        /// Save creation timestamp as Windows FILETIME (int64).
        /// Convert using DateTime.FromFileTime().
        /// </summary>
        public long TimestampFiletime { get { return _timestampFiletime; } }

        /// <summary>
        /// Length of screenshot data in bytes (0 if no screenshot)
        /// </summary>
        public int NumScreenshotData { get { return _numScreenshotData; } }

        /// <summary>
        /// Screenshot image data (typically TGA or DDS format)
        /// </summary>
        public List<byte> ScreenshotData { get { return _screenshotData; } }

        /// <summary>
        /// Length of portrait data in bytes (0 if no portrait)
        /// </summary>
        public int NumPortraitData { get { return _numPortraitData; } }

        /// <summary>
        /// Portrait image data (typically TGA or DDS format)
        /// </summary>
        public List<byte> PortraitData { get { return _portraitData; } }

        /// <summary>
        /// Player character name
        /// </summary>
        public LengthPrefixedString PlayerName { get { return _playerName; } }

        /// <summary>
        /// Number of party members (from PartyState)
        /// </summary>
        public int PartyMemberCount { get { return _partyMemberCount; } }

        /// <summary>
        /// Player character level (from PartyState.PlayerCharacter)
        /// </summary>
        public int PlayerLevel { get { return _playerLevel; } }
        public Das M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
