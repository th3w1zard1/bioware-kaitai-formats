// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
    /// (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
    /// 
    /// G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305">xoreos — GDAFile::load</a>
    /// </remarks>
    public partial class Gda : KaitaiStruct
    {
        public static Gda FromFile(string fileName)
        {
            return new Gda(new KaitaiStream(fileName));
        }

        public Gda(KaitaiStream p__io, KaitaiStruct p__parent = null, Gda p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _asGff4 = new Gff.Gff4File(m_io);
        }
        private Gff.Gff4File _asGff4;
        private Gda m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
        /// (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).
        /// </summary>
        public Gff.Gff4File AsGff4 { get { return _asGff4; } }
        public Gda M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
