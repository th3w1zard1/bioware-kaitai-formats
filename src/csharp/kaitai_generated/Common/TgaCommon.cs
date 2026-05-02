// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
    /// per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
    /// 
    /// Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — textures (TGA pipeline)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40">PyKotor — `tga.py` (reader core)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177">xoreos — `TGA::readHeader`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L61">xoreos — `kFileTypeTGA`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L80">xoreos-tools — `TGA::load`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture context)</a>
    /// </remarks>
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
