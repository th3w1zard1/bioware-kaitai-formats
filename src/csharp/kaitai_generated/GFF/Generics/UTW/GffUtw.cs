// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// **UTW** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
    /// `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
    /// `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.
    /// 
    /// FileType / restype id **2058** — see `bioware_type_ids::xoreos_file_type_id` enum member `utw`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — GFF3 header read</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format">PyKotor wiki — GFF binary</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf (GFF3 wire)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf">xoreos-docs — CommonGFFStructs.pdf</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
    /// </remarks>
    public partial class GffUtw : KaitaiStruct
    {
        public static GffUtw FromFile(string fileName)
        {
            return new GffUtw(new KaitaiStream(fileName));
        }

        public GffUtw(KaitaiStream p__io, KaitaiStruct p__parent = null, GffUtw p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _contents = new Gff.GffUnionFile(m_io);
        }
        private Gff.GffUnionFile _contents;
        private GffUtw m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per UTW template docs / PyKotor `gff_auto`.
        /// </summary>
        public Gff.GffUnionFile Contents { get { return _contents; } }
        public GffUtw M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
