// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
    /// ITP files use GFF format (FileType &quot;ITP &quot; in GFF header).
    /// Uses GFF XML structure with root element &lt;gff3&gt; containing &lt;struct&gt; elements.
    /// Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).
    /// 
    /// Canonical links: `meta.doc-ref` and `meta.xref`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format">PyKotor wiki — GFF (ITP is GFF-shaped)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — `GFF3File::readHeader`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225">reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49">xoreos-docs — Torlack ITP / MultiMap (GFF-family context)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
    /// </remarks>
    public partial class ItpXml : KaitaiStruct
    {
        public static ItpXml FromFile(string fileName)
        {
            return new ItpXml(new KaitaiStream(fileName));
        }

        public ItpXml(KaitaiStream p__io, KaitaiStruct p__parent = null, ItpXml p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _xmlContent = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytesFull());
        }
        private string _xmlContent;
        private ItpXml m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// XML document content as UTF-8 text
        /// </summary>
        public string XmlContent { get { return _xmlContent; } }
        public ItpXml M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
