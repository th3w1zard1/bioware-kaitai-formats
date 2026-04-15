// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// **MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
    /// Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
    /// opaque `size-eos` span — per-attribute layouts are MDL-driven.
    /// 
    /// xoreos interleaved MDX reads: `meta.xref.xoreos_model_kotor_mdx_reads`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format">PyKotor wiki — MDL/MDX</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L885-L917">xoreos — Model_KotOR MDX reads</a>
    /// </remarks>
    public partial class Mdx : KaitaiStruct
    {
        public static Mdx FromFile(string fileName)
        {
            return new Mdx(new KaitaiStream(fileName));
        }

        public Mdx(KaitaiStream p__io, KaitaiStruct p__parent = null, Mdx p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _vertexData = m_io.ReadBytesFull();
        }
        private byte[] _vertexData;
        private Mdx m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// Raw vertex data bytes; layout follows the trimesh header in the paired MDL (`mdx_data_offset`, `mdx_vertex_size`,
        /// `mdx_data_flags`). Bit names for `mdx_data_flags`: `bioware_mdl_common::mdx_vertex_stream_flag` (bitmask on wire).
        /// 
        /// See `meta.xref.pykotor_wiki_mdl` and `meta.xref.xoreos_model_kotor_mdx_reads`. Skinned meshes add bone weights
        /// and indices per vertex as described on the wiki.
        /// </summary>
        public byte[] VertexData { get { return _vertexData; } }
        public Mdx M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
