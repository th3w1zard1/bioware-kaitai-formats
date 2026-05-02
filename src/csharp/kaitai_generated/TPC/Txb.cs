// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
    /// (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.
    /// 
    /// This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
    /// variant diverges, split a dedicated header type and cite **observed behavior** / tooling evidence (`TODO: VERIFY`).
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182">xoreos — `kFileTypeTXB`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66">xoreos — `TPC::load` (texture family)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68">xoreos-tools — `TPC::load`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224">xoreos-tools — `TPC::readHeader`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture pipeline context)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — texture family (cross-check TXB)</a>
    /// </remarks>
    public partial class Txb : KaitaiStruct
    {
        public static Txb FromFile(string fileName)
        {
            return new Txb(new KaitaiStream(fileName));
        }

        public Txb(KaitaiStream p__io, KaitaiStruct p__parent = null, Txb p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _header = new Tpc.TpcHeader(m_io);
            _body = m_io.ReadBytesFull();
        }
        private Tpc.TpcHeader _header;
        private byte[] _body;
        private Txb m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
        /// </summary>
        public Tpc.TpcHeader Header { get { return _header; } }

        /// <summary>
        /// Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.
        /// </summary>
        public byte[] Body { get { return _body; } }
        public Txb M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
