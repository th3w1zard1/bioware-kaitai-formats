// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// SSF (Sound Set File) files store sound string references (StrRefs) for character voice sets.
    /// Each SSF file contains exactly 28 sound slots, mapping to different game events and actions.
    /// 
    /// Binary Format:
    /// - Header (12 bytes): File type signature, version, and offset to sounds array (usually 12)
    /// - Sounds Array (112 bytes at sounds_offset): 28 uint32 values representing StrRefs (0xFFFFFFFF = -1 = no sound)
    /// 
    /// Vanilla KotOR SSFs are typically 136 bytes total: after the 28 StrRefs, many files append 12 bytes
    /// of 0xFFFFFFFF padding; that trailer is not part of the header and is not modeled here.
    /// 
    /// Sound Slots (in order):
    /// 0-5: Battle Cry 1-6
    /// 6-8: Select 1-3
    /// 9-11: Attack Grunt 1-3
    /// 12-13: Pain Grunt 1-2
    /// 14: Low Health
    /// 15: Dead
    /// 16: Critical Hit
    /// 17: Target Immune
    /// 18: Lay Mine
    /// 19: Disarm Mine
    /// 20: Begin Stealth
    /// 21: Begin Search
    /// 22: Begin Unlock
    /// 23: Unlock Failed
    /// 24: Unlock Success
    /// 25: Separated From Party
    /// 26: Rejoined Party
    /// 27: Poisoned
    /// 
    /// Authoritative implementations: `meta.xref` and `doc-ref` (PyKotor `io_ssf`, xoreos `ssffile.cpp`, xoreos-tools `ssf2xml` / `xml2ssf`, xoreos-docs `SSF_Format.pdf`, reone `SsfReader`).
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf">PyKotor wiki — SSF</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf.py#L102-L166">PyKotor — `io_ssf` (Kaitai bridge + binary read/write)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L126">xoreos — `kFileTypeSSF`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L72-L141">xoreos — `SSFFile::load` + `readSSFHeader` + `readEntries`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L165-L170">xoreos — `readEntriesKotOR`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/ssf2xml.cpp#L51-L70">xoreos-tools — `ssf2xml` CLI</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml2ssf.cpp#L54-L75">xoreos-tools — `xml2ssf` CLI (`main`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/ssfdumper.cpp#L133-L167">xoreos-tools — `SSFDumper::dump` (XML mapping for `ssf2xml`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/ssfcreator.cpp#L38-L74">xoreos-tools — `SSFCreator::create` (XML mapping for `xml2ssf`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/SSF_Format.pdf">xoreos-docs — SSF_Format.pdf</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/ssfreader.cpp#L26-L32">reone — `SsfReader::load`</a>
    /// </remarks>
    public partial class Ssf : KaitaiStruct
    {
        public static Ssf FromFile(string fileName)
        {
            return new Ssf(new KaitaiStream(fileName));
        }

        public Ssf(KaitaiStream p__io, KaitaiStruct p__parent = null, Ssf p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            f_sounds = false;
            _read();
        }
        private void _read()
        {
            _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_fileType == "SSF "))
            {
                throw new ValidationNotEqualError("SSF ", _fileType, m_io, "/seq/0");
            }
            _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_fileVersion == "V1.1"))
            {
                throw new ValidationNotEqualError("V1.1", _fileVersion, m_io, "/seq/1");
            }
            _soundsOffset = m_io.ReadU4le();
        }
        public partial class SoundArray : KaitaiStruct
        {
            public static SoundArray FromFile(string fileName)
            {
                return new SoundArray(new KaitaiStream(fileName));
            }

            public SoundArray(KaitaiStream p__io, Ssf p__parent = null, Ssf p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<SoundEntry>();
                for (var i = 0; i < 28; i++)
                {
                    _entries.Add(new SoundEntry(m_io, this, m_root));
                }
            }
            private List<SoundEntry> _entries;
            private Ssf m_root;
            private Ssf m_parent;

            /// <summary>
            /// Array of exactly 28 sound entries, one for each SSFSound enum value.
            /// Each entry is a uint32 representing a StrRef (string reference).
            /// Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
            /// 
            /// Entry indices map to SSFSound enum:
            /// - 0-5: Battle Cry 1-6
            /// - 6-8: Select 1-3
            /// - 9-11: Attack Grunt 1-3
            /// - 12-13: Pain Grunt 1-2
            /// - 14: Low Health
            /// - 15: Dead
            /// - 16: Critical Hit
            /// - 17: Target Immune
            /// - 18: Lay Mine
            /// - 19: Disarm Mine
            /// - 20: Begin Stealth
            /// - 21: Begin Search
            /// - 22: Begin Unlock
            /// - 23: Unlock Failed
            /// - 24: Unlock Success
            /// - 25: Separated From Party
            /// - 26: Rejoined Party
            /// - 27: Poisoned
            /// </summary>
            public List<SoundEntry> Entries { get { return _entries; } }
            public Ssf M_Root { get { return m_root; } }
            public Ssf M_Parent { get { return m_parent; } }
        }
        public partial class SoundEntry : KaitaiStruct
        {
            public static SoundEntry FromFile(string fileName)
            {
                return new SoundEntry(new KaitaiStream(fileName));
            }

            public SoundEntry(KaitaiStream p__io, Ssf.SoundArray p__parent = null, Ssf p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_isNoSound = false;
                _read();
            }
            private void _read()
            {
                _strrefRaw = m_io.ReadU4le();
            }
            private bool f_isNoSound;
            private bool _isNoSound;

            /// <summary>
            /// True if this entry represents &quot;no sound&quot; (0xFFFFFFFF).
            /// False if this entry contains a valid StrRef value.
            /// </summary>
            public bool IsNoSound
            {
                get
                {
                    if (f_isNoSound)
                        return _isNoSound;
                    f_isNoSound = true;
                    _isNoSound = (bool) (StrrefRaw == 4294967295);
                    return _isNoSound;
                }
            }
            private uint _strrefRaw;
            private Ssf m_root;
            private Ssf.SoundArray m_parent;

            /// <summary>
            /// Raw uint32 value representing the StrRef.
            /// Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
            /// All other values are valid StrRefs (typically 0-999999).
            /// The conversion from 0xFFFFFFFF to -1 is handled by SSFBinaryReader.ReadInt32MaxNeg1().
            /// </summary>
            public uint StrrefRaw { get { return _strrefRaw; } }
            public Ssf M_Root { get { return m_root; } }
            public Ssf.SoundArray M_Parent { get { return m_parent; } }
        }
        private bool f_sounds;
        private SoundArray _sounds;

        /// <summary>
        /// Array of 28 sound string references (StrRefs)
        /// </summary>
        public SoundArray Sounds
        {
            get
            {
                if (f_sounds)
                    return _sounds;
                f_sounds = true;
                long _pos = m_io.Pos;
                m_io.Seek(SoundsOffset);
                _sounds = new SoundArray(m_io, this, m_root);
                m_io.Seek(_pos);
                return _sounds;
            }
        }
        private string _fileType;
        private string _fileVersion;
        private uint _soundsOffset;
        private Ssf m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File type signature. Must be &quot;SSF &quot; (space-padded).
        /// Bytes: 0x53 0x53 0x46 0x20
        /// </summary>
        public string FileType { get { return _fileType; } }

        /// <summary>
        /// File format version. Always &quot;V1.1&quot; for KotOR SSF files.
        /// Bytes: 0x56 0x31 0x2E 0x31
        /// </summary>
        public string FileVersion { get { return _fileVersion; } }

        /// <summary>
        /// Byte offset to the sounds array from the beginning of the file.
        /// KotOR files almost always use 12 (0x0C) so the table follows the header immediately, but the
        /// field is a real offset; readers must seek here instead of assuming 12.
        /// </summary>
        public uint SoundsOffset { get { return _soundsOffset; } }
        public Ssf M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
