// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
    /// per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
    /// 
    /// Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
    /// </summary>
    public partial class TgaCommon : KaitaiStruct
    {
        public static TgaCommon FromFile(string fileName)
        {
            return new TgaCommon(new KaitaiStream(fileName));
        }


        public enum TgaColorMapType
        {
            None = 0,
            Present = 1,
        }

        public enum TgaImageType
        {
            NoImageData = 0,
            UncompressedColorMapped = 1,
            UncompressedRgb = 2,
            UncompressedGreyscale = 3,
            RleColorMapped = 9,
            RleRgb = 10,
            RleGreyscale = 11,
        }
        public TgaCommon(KaitaiStream p__io, KaitaiStruct p__parent = null, TgaCommon p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
        }
        private TgaCommon m_root;
        private KaitaiStruct m_parent;
        public TgaCommon M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
