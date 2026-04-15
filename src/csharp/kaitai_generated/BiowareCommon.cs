// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// Shared enums and &quot;common objects&quot; used across the BioWare ecosystem that also appear
    /// in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).
    /// 
    /// This file is intended to be imported by other `.ksy` files to avoid repeating:
    /// - Language IDs (used in TLK headers and GFF LocalizedString substrings)
    /// - Gender IDs (used in GFF LocalizedString substrings)
    /// - The CExoLocString / LocalizedString binary layout
    /// 
    /// References:
    /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py
    /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py
    /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py
    /// - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h
    /// - https://github.com/seedhartha/reone/blob/master/include/reone/resource/types.h
    /// </summary>
    public partial class BiowareCommon : KaitaiStruct
    {
        public static BiowareCommon FromFile(string fileName)
        {
            return new BiowareCommon(new KaitaiStream(fileName));
        }


        public enum BiowareDdsVariantBytesPerPixel
        {
            Dxt1 = 3,
            Dxt5 = 4,
        }

        public enum BiowareEquipmentSlotFlag
        {
            Invalid = 0,
            Head = 1,
            Armor = 2,
            Gauntlet = 8,
            RightHand = 16,
            LeftHand = 32,
            RightArm = 128,
            LeftArm = 256,
            Implant = 512,
            Belt = 1024,
            Claw1 = 16384,
            Claw2 = 32768,
            Claw3 = 65536,
            Hide = 131072,
            RightHand2 = 262144,
            LeftHand2 = 524288,
        }

        public enum BiowareGameId
        {
            K1 = 1,
            K2 = 2,
            K1Xbox = 3,
            K2Xbox = 4,
            K1Ios = 5,
            K2Ios = 6,
            K1Android = 7,
            K2Android = 8,
        }

        public enum BiowareGenderId
        {
            Male = 0,
            Female = 1,
        }

        public enum BiowareLanguageId
        {
            English = 0,
            French = 1,
            German = 2,
            Italian = 3,
            Spanish = 4,
            Polish = 5,
            Afrikaans = 6,
            Basque = 7,
            Breton = 9,
            Catalan = 10,
            Chamorro = 11,
            Chichewa = 12,
            Corsican = 13,
            Danish = 14,
            Dutch = 15,
            Faroese = 16,
            Filipino = 18,
            Finnish = 19,
            Flemish = 20,
            Frisian = 21,
            Galician = 22,
            Ganda = 23,
            HaitianCreole = 24,
            HausaLatin = 25,
            Hawaiian = 26,
            Icelandic = 27,
            Ido = 28,
            Indonesian = 29,
            Igbo = 30,
            Irish = 31,
            Interlingua = 32,
            JavaneseLatin = 33,
            Latin = 34,
            Luxembourgish = 35,
            Maltese = 36,
            Norwegian = 37,
            Occitan = 38,
            Portuguese = 39,
            Scots = 40,
            ScottishGaelic = 41,
            Shona = 42,
            Soto = 43,
            SundaneseLatin = 44,
            Swahili = 45,
            Swedish = 46,
            Tagalog = 47,
            Tahitian = 48,
            Tongan = 49,
            UzbekLatin = 50,
            Walloon = 51,
            Xhosa = 52,
            Yoruba = 53,
            Welsh = 54,
            Zulu = 55,
            Bulgarian = 58,
            Belarisian = 59,
            Macedonian = 60,
            Russian = 61,
            SerbianCyrillic = 62,
            Tajik = 63,
            TatarCyrillic = 64,
            Ukrainian = 66,
            Uzbek = 67,
            Albanian = 68,
            BosnianLatin = 69,
            Czech = 70,
            Slovak = 71,
            Slovene = 72,
            Croatian = 73,
            Hungarian = 75,
            Romanian = 76,
            Greek = 77,
            Esperanto = 78,
            AzerbaijaniLatin = 79,
            Turkish = 81,
            TurkmenLatin = 82,
            Hebrew = 83,
            Arabic = 84,
            Estonian = 85,
            Latvian = 86,
            Lithuanian = 87,
            Vietnamese = 88,
            Thai = 89,
            Aymara = 90,
            Kinyarwanda = 91,
            KurdishLatin = 92,
            Malagasy = 93,
            MalayLatin = 94,
            Maori = 95,
            MoldovanLatin = 96,
            Samoan = 97,
            Somali = 98,
            Korean = 128,
            ChineseTraditional = 129,
            ChineseSimplified = 130,
            Japanese = 131,
            Unknown = 2147483646,
        }

        public enum BiowareLipVisemeId
        {
            Neutral = 0,
            Ee = 1,
            Eh = 2,
            Ah = 3,
            Oh = 4,
            Ooh = 5,
            Y = 6,
            Sts = 7,
            Fv = 8,
            Ng = 9,
            Th = 10,
            Mpb = 11,
            Td = 12,
            Sh = 13,
            L = 14,
            Kg = 15,
        }

        public enum BiowareLtrAlphabetLength
        {
            NeverwinterNights = 26,
            Kotor = 28,
        }

        public enum BiowareObjectTypeId
        {
            Invalid = 0,
            Creature = 1,
            Door = 2,
            Item = 3,
            Trigger = 4,
            Placeable = 5,
            Waypoint = 6,
            Encounter = 7,
            Store = 8,
            Area = 9,
            Sound = 10,
            Camera = 11,
        }

        public enum BiowarePccCompressionCodec
        {
            None = 0,
            Zlib = 1,
            Lzo = 2,
        }

        public enum BiowarePccPackageKind
        {
            NormalPackage = 0,
            PatchPackage = 1,
        }

        public enum BiowareTpcPixelFormatId
        {
            Greyscale = 1,
            RgbOrDxt1 = 2,
            RgbaOrDxt5 = 4,
            BgraXboxSwizzle = 12,
        }

        public enum RiffWaveFormatTag
        {
            Pcm = 1,
            AdpcmMs = 2,
            IeeeFloat = 3,
            Alaw = 6,
            Mulaw = 7,
            DviImaAdpcm = 17,
            MpegLayer3 = 85,
            WaveFormatExtensible = 65534,
        }
        public BiowareCommon(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareCommon p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
        }

        /// <summary>
        /// Variable-length binary data with 4-byte length prefix.
        /// Used for Void/Binary fields in GFF files.
        /// </summary>
        public partial class BiowareBinaryData : KaitaiStruct
        {
            public static BiowareBinaryData FromFile(string fileName)
            {
                return new BiowareBinaryData(new KaitaiStream(fileName));
            }

            public BiowareBinaryData(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _lenValue = m_io.ReadU4le();
                _value = m_io.ReadBytes(LenValue);
            }
            private uint _lenValue;
            private byte[] _value;
            private BiowareCommon m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Length of binary data in bytes
            /// </summary>
            public uint LenValue { get { return _lenValue; } }

            /// <summary>
            /// Binary data
            /// </summary>
            public byte[] Value { get { return _value; } }
            public BiowareCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// BioWare CExoString - variable-length string with 4-byte length prefix.
        /// Used for string fields in GFF files.
        /// </summary>
        public partial class BiowareCexoString : KaitaiStruct
        {
            public static BiowareCexoString FromFile(string fileName)
            {
                return new BiowareCexoString(new KaitaiStream(fileName));
            }

            public BiowareCexoString(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _lenString = m_io.ReadU4le();
                _value = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytes(LenString));
            }
            private uint _lenString;
            private string _value;
            private BiowareCommon m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Length of string in bytes
            /// </summary>
            public uint LenString { get { return _lenString; } }

            /// <summary>
            /// String data (UTF-8)
            /// </summary>
            public string Value { get { return _value; } }
            public BiowareCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// BioWare &quot;CExoLocString&quot; (LocalizedString) binary layout, as embedded inside the GFF field-data
        /// section for field type &quot;LocalizedString&quot;.
        /// </summary>
        public partial class BiowareLocstring : KaitaiStruct
        {
            public static BiowareLocstring FromFile(string fileName)
            {
                return new BiowareLocstring(new KaitaiStream(fileName));
            }

            public BiowareLocstring(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_hasStrref = false;
                _read();
            }
            private void _read()
            {
                _totalSize = m_io.ReadU4le();
                _stringRef = m_io.ReadU4le();
                _numSubstrings = m_io.ReadU4le();
                _substrings = new List<Substring>();
                for (var i = 0; i < NumSubstrings; i++)
                {
                    _substrings.Add(new Substring(m_io, this, m_root));
                }
            }
            private bool f_hasStrref;
            private bool _hasStrref;

            /// <summary>
            /// True if this locstring references dialog.tlk
            /// </summary>
            public bool HasStrref
            {
                get
                {
                    if (f_hasStrref)
                        return _hasStrref;
                    f_hasStrref = true;
                    _hasStrref = (bool) (StringRef != 4294967295);
                    return _hasStrref;
                }
            }
            private uint _totalSize;
            private uint _stringRef;
            private uint _numSubstrings;
            private List<Substring> _substrings;
            private BiowareCommon m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Total size of the structure in bytes (excluding this field).
            /// </summary>
            public uint TotalSize { get { return _totalSize; } }

            /// <summary>
            /// StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).
            /// </summary>
            public uint StringRef { get { return _stringRef; } }

            /// <summary>
            /// Number of substring entries that follow.
            /// </summary>
            public uint NumSubstrings { get { return _numSubstrings; } }

            /// <summary>
            /// Language/gender-specific substring entries.
            /// </summary>
            public List<Substring> Substrings { get { return _substrings; } }
            public BiowareCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
        /// Used throughout GFF files to reference game resources by name.
        /// </summary>
        public partial class BiowareResref : KaitaiStruct
        {
            public static BiowareResref FromFile(string fileName)
            {
                return new BiowareResref(new KaitaiStream(fileName));
            }

            public BiowareResref(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _lenResref = m_io.ReadU1();
                if (!(_lenResref <= 16))
                {
                    throw new ValidationGreaterThanError(16, _lenResref, m_io, "/types/bioware_resref/seq/0");
                }
                _value = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(LenResref));
            }
            private byte _lenResref;
            private string _value;
            private BiowareCommon m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Length of ResRef string (0-16 characters)
            /// </summary>
            public byte LenResref { get { return _lenResref; } }

            /// <summary>
            /// ResRef string data (ASCII, lowercase recommended)
            /// </summary>
            public string Value { get { return _value; } }
            public BiowareCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// 3D vector (X, Y, Z coordinates).
        /// Used for positions, directions, etc. in game files.
        /// </summary>
        public partial class BiowareVector3 : KaitaiStruct
        {
            public static BiowareVector3 FromFile(string fileName)
            {
                return new BiowareVector3(new KaitaiStream(fileName));
            }

            public BiowareVector3(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _x = m_io.ReadF4le();
                _y = m_io.ReadF4le();
                _z = m_io.ReadF4le();
            }
            private float _x;
            private float _y;
            private float _z;
            private BiowareCommon m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// X coordinate
            /// </summary>
            public float X { get { return _x; } }

            /// <summary>
            /// Y coordinate
            /// </summary>
            public float Y { get { return _y; } }

            /// <summary>
            /// Z coordinate
            /// </summary>
            public float Z { get { return _z; } }
            public BiowareCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// 4D vector / Quaternion (X, Y, Z, W components).
        /// Used for orientations/rotations in game files.
        /// </summary>
        public partial class BiowareVector4 : KaitaiStruct
        {
            public static BiowareVector4 FromFile(string fileName)
            {
                return new BiowareVector4(new KaitaiStream(fileName));
            }

            public BiowareVector4(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _x = m_io.ReadF4le();
                _y = m_io.ReadF4le();
                _z = m_io.ReadF4le();
                _w = m_io.ReadF4le();
            }
            private float _x;
            private float _y;
            private float _z;
            private float _w;
            private BiowareCommon m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// X component
            /// </summary>
            public float X { get { return _x; } }

            /// <summary>
            /// Y component
            /// </summary>
            public float Y { get { return _y; } }

            /// <summary>
            /// Z component
            /// </summary>
            public float Z { get { return _z; } }

            /// <summary>
            /// W component
            /// </summary>
            public float W { get { return _w; } }
            public BiowareCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        public partial class Substring : KaitaiStruct
        {
            public static Substring FromFile(string fileName)
            {
                return new Substring(new KaitaiStream(fileName));
            }

            public Substring(KaitaiStream p__io, BiowareCommon.BiowareLocstring p__parent = null, BiowareCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_gender = false;
                f_genderRaw = false;
                f_language = false;
                f_languageRaw = false;
                _read();
            }
            private void _read()
            {
                _substringId = m_io.ReadU4le();
                _lenText = m_io.ReadU4le();
                _text = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytes(LenText));
            }
            private bool f_gender;
            private BiowareGenderId _gender;

            /// <summary>
            /// Gender as enum value
            /// </summary>
            public BiowareGenderId Gender
            {
                get
                {
                    if (f_gender)
                        return _gender;
                    f_gender = true;
                    _gender = (BiowareGenderId) (((BiowareCommon.BiowareGenderId) GenderRaw));
                    return _gender;
                }
            }
            private bool f_genderRaw;
            private int _genderRaw;

            /// <summary>
            /// Raw gender ID (0..255).
            /// </summary>
            public int GenderRaw
            {
                get
                {
                    if (f_genderRaw)
                        return _genderRaw;
                    f_genderRaw = true;
                    _genderRaw = (int) (SubstringId & 255);
                    return _genderRaw;
                }
            }
            private bool f_language;
            private BiowareLanguageId _language;

            /// <summary>
            /// Language as enum value
            /// </summary>
            public BiowareLanguageId Language
            {
                get
                {
                    if (f_language)
                        return _language;
                    f_language = true;
                    _language = (BiowareLanguageId) (((BiowareCommon.BiowareLanguageId) LanguageRaw));
                    return _language;
                }
            }
            private bool f_languageRaw;
            private int _languageRaw;

            /// <summary>
            /// Raw language ID (0..255).
            /// </summary>
            public int LanguageRaw
            {
                get
                {
                    if (f_languageRaw)
                        return _languageRaw;
                    f_languageRaw = true;
                    _languageRaw = (int) (SubstringId >> 8 & 255);
                    return _languageRaw;
                }
            }
            private uint _substringId;
            private uint _lenText;
            private string _text;
            private BiowareCommon m_root;
            private BiowareCommon.BiowareLocstring m_parent;

            /// <summary>
            /// Packed language+gender identifier:
            /// - bits 0..7: gender
            /// - bits 8..15: language
            /// </summary>
            public uint SubstringId { get { return _substringId; } }

            /// <summary>
            /// Length of text in bytes.
            /// </summary>
            public uint LenText { get { return _lenText; } }

            /// <summary>
            /// Substring text.
            /// </summary>
            public string Text { get { return _text; } }
            public BiowareCommon M_Root { get { return m_root; } }
            public BiowareCommon.BiowareLocstring M_Parent { get { return m_parent; } }
        }
        private BiowareCommon m_root;
        private KaitaiStruct m_parent;
        public BiowareCommon M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
