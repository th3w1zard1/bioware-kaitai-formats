// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// Enums and small helper types used by installation/extraction tooling.
    /// 
    /// References:
    /// - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/installation.py
    /// </summary>
    public partial class BiowareExtractCommon : KaitaiStruct
    {
        public static BiowareExtractCommon FromFile(string fileName)
        {
            return new BiowareExtractCommon(new KaitaiStream(fileName));
        }


        public enum BiowareSearchLocationId
        {
            Override = 0,
            Modules = 1,
            Chitin = 2,
            TexturesTpa = 3,
            TexturesTpb = 4,
            TexturesTpc = 5,
            TexturesGui = 6,
            Music = 7,
            Sound = 8,
            Voice = 9,
            Lips = 10,
            Rims = 11,
            CustomModules = 12,
            CustomFolders = 13,
        }
        public BiowareExtractCommon(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareExtractCommon p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
        }

        /// <summary>
        /// String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
        /// </summary>
        public partial class BiowareTexturePackNameStr : KaitaiStruct
        {
            public static BiowareTexturePackNameStr FromFile(string fileName)
            {
                return new BiowareTexturePackNameStr(new KaitaiStream(fileName));
            }

            public BiowareTexturePackNameStr(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareExtractCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _value = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesTerm(0, false, true, true));
                if (!( ((_value == "swpc_tex_tpa.erf") || (_value == "swpc_tex_tpb.erf") || (_value == "swpc_tex_tpc.erf") || (_value == "swpc_tex_gui.erf")) ))
                {
                    throw new ValidationNotAnyOfError(_value, m_io, "/types/bioware_texture_pack_name_str/seq/0");
                }
            }
            private string _value;
            private BiowareExtractCommon m_root;
            private KaitaiStruct m_parent;
            public string Value { get { return _value; } }
            public BiowareExtractCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        private BiowareExtractCommon m_root;
        private KaitaiStruct m_parent;
        public BiowareExtractCommon M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
