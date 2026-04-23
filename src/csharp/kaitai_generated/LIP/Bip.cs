// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
    /// framed wire lives in `LIP.ksy`.
    /// 
    /// **TODO: VERIFY** full BIP layout against a KotOR PC build and PyKotor; until then this spec
    /// exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198">xoreos — `kFileTypeBIP`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip">PyKotor wiki — LIP family</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; verify wire with PyKotor / **observed behavior** on shipped builds when possible)</a>
    /// </remarks>
    public partial class Bip : KaitaiStruct
    {
        public static Bip FromFile(string fileName)
        {
            return new Bip(new KaitaiStream(fileName));
        }

        public Bip(KaitaiStream p__io, KaitaiStruct p__parent = null, Bip p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _payload = m_io.ReadBytesFull();
        }
        private byte[] _payload;
        private Bip m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// Opaque binary LIP payload — replace with structured fields after verification.
        /// </summary>
        public byte[] Payload { get { return _payload; } }
        public Bip M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
