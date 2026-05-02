// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
    /// (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
    /// 
    /// G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
    /// 
    /// **reone:** not applicable for GDA wire ingestion on the KotOR fork (`meta.xref.reone_gda_consumer_note`).
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305">xoreos — `GDAFile::load`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L87-L93">xoreos — `GFF4File` stream ctor (type dispatch)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4fields.h#L1230-L1260">xoreos — G2DA column field ids (excerpt)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L136-L140">xoreos — `TwoDAFile(const GDAFile &)`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L343-L400">xoreos — `TwoDAFile::load(const GDAFile &)`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86">xoreos-tools — `main`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159">xoreos-tools — `get2DAGDA`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L167-L181">xoreos-tools — multi-file `GDAFile` merge</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L1466-L1472">PyKotor — `ResourceType.GDA`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf (GFF4 family; G2DA container)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf">xoreos-docs — CommonGFFStructs.pdf</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf">xoreos-docs — 2DA_Format.pdf (classic `.2da`; contrast with GDA)</a>
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
