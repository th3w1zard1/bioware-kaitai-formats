// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// **BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
    /// mobile KotOR ports.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression">PyKotor wiki — BZF (LZMA BIF)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L26-L54">PyKotor — `_decompress_bzf_payload`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/bzffile.cpp#L41-L83">xoreos — `kBZFID` quirk + `BZFFile::load`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L207">xoreos-tools — `.bzf` → `BZFFile`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf">xoreos-docs — KeyBIF_Format.pdf</a>
    /// </remarks>
    public partial class Bzf : KaitaiStruct
    {
        public static Bzf FromFile(string fileName)
        {
            return new Bzf(new KaitaiStream(fileName));
        }

        public Bzf(KaitaiStream p__io, KaitaiStruct p__parent = null, Bzf p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_fileType == "BZF "))
            {
                throw new ValidationNotEqualError("BZF ", _fileType, m_io, "/seq/0");
            }
            _version = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_version == "V1.0"))
            {
                throw new ValidationNotEqualError("V1.0", _version, m_io, "/seq/1");
            }
            _compressedData = m_io.ReadBytesFull();
        }
        private string _fileType;
        private string _version;
        private byte[] _compressedData;
        private Bzf m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File type signature. Must be &quot;BZF &quot; for compressed BIF files.
        /// </summary>
        public string FileType { get { return _fileType; } }

        /// <summary>
        /// File format version. Always &quot;V1.0&quot; for BZF files.
        /// </summary>
        public string Version { get { return _version; } }

        /// <summary>
        /// LZMA-compressed BIF file data (single blob to EOF).
        /// Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).
        /// </summary>
        public byte[] CompressedData { get { return _compressedData; } }
        public Bzf M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
