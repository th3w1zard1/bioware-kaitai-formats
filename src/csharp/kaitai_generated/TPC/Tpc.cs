// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
    /// (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
    /// (`meta.xref`).
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — TPC</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303">PyKotor — `TPCBinaryReader` + `load`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120">PyKotor — `TPCTextureFormat` (opening)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520">PyKotor — `class TPC` (opening)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105">reone — `TpcReader` (body + TXI features)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L183">xoreos — `kFileTypeTPC`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L362">xoreos — `TPC::load` through `readTXI` entrypoints</a>
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
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts#L290-L380">KotOR.js — `TPCObject.readHeader`</a>
    /// </remarks>
    public partial class Tpc : KaitaiStruct
    {
        public static Tpc FromFile(string fileName)
        {
            return new Tpc(new KaitaiStream(fileName));
        }

        public Tpc(KaitaiStream p__io, KaitaiStruct p__parent = null, Tpc p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _header = new TpcHeader(m_io, this, m_root);
            _body = m_io.ReadBytesFull();
        }
        public partial class TpcHeader : KaitaiStruct
        {
            public static TpcHeader FromFile(string fileName)
            {
                return new TpcHeader(new KaitaiStream(fileName));
            }

            public TpcHeader(KaitaiStream p__io, Tpc p__parent = null, Tpc p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_isCompressed = false;
                f_isUncompressed = false;
                _read();
            }
            private void _read()
            {
                _dataSize = m_io.ReadU4le();
                _alphaTest = m_io.ReadF4le();
                _width = m_io.ReadU2le();
                _height = m_io.ReadU2le();
                _pixelEncoding = ((BiowareCommon.BiowareTpcPixelFormatId) m_io.ReadU1());
                _mipmapCount = m_io.ReadU1();
                _reserved = new List<byte>();
                for (var i = 0; i < 114; i++)
                {
                    _reserved.Add(m_io.ReadU1());
                }
            }
            private bool f_isCompressed;
            private bool _isCompressed;

            /// <summary>
            /// True if texture data is compressed (DXT format)
            /// </summary>
            public bool IsCompressed
            {
                get
                {
                    if (f_isCompressed)
                        return _isCompressed;
                    f_isCompressed = true;
                    _isCompressed = (bool) (DataSize != 0);
                    return _isCompressed;
                }
            }
            private bool f_isUncompressed;
            private bool _isUncompressed;

            /// <summary>
            /// True if texture data is uncompressed (raw pixels)
            /// </summary>
            public bool IsUncompressed
            {
                get
                {
                    if (f_isUncompressed)
                        return _isUncompressed;
                    f_isUncompressed = true;
                    _isUncompressed = (bool) (DataSize == 0);
                    return _isUncompressed;
                }
            }
            private uint _dataSize;
            private float _alphaTest;
            private ushort _width;
            private ushort _height;
            private BiowareCommon.BiowareTpcPixelFormatId _pixelEncoding;
            private byte _mipmapCount;
            private List<byte> _reserved;
            private Tpc m_root;
            private Tpc m_parent;

            /// <summary>
            /// Total compressed payload size. If non-zero, texture is compressed (DXT).
            /// If zero, texture is uncompressed and size is derived from format/width/height.
            /// </summary>
            public uint DataSize { get { return _dataSize; } }

            /// <summary>
            /// Float threshold used by punch-through rendering.
            /// Commonly 0.0 or 0.5.
            /// </summary>
            public float AlphaTest { get { return _alphaTest; } }

            /// <summary>
            /// Texture width in pixels (uint16).
            /// Must be power-of-two for compressed formats.
            /// </summary>
            public ushort Width { get { return _width; } }

            /// <summary>
            /// Texture height in pixels (uint16).
            /// For cube maps, this is 6x the face width.
            /// Must be power-of-two for compressed formats.
            /// </summary>
            public ushort Height { get { return _height; } }

            /// <summary>
            /// Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
            /// `bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).
            /// </summary>
            public BiowareCommon.BiowareTpcPixelFormatId PixelEncoding { get { return _pixelEncoding; } }

            /// <summary>
            /// Number of mip levels per layer (minimum 1).
            /// Each mip level is half the size of the previous level.
            /// </summary>
            public byte MipmapCount { get { return _mipmapCount; } }

            /// <summary>
            /// Reserved/padding bytes (0x72 = 114 bytes).
            /// KotOR stores platform hints here but all implementations skip them.
            /// </summary>
            public List<byte> Reserved { get { return _reserved; } }
            public Tpc M_Root { get { return m_root; } }
            public Tpc M_Parent { get { return m_parent; } }
        }
        private TpcHeader _header;
        private byte[] _body;
        private Tpc m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// TPC file header (128 bytes total)
        /// </summary>
        public TpcHeader Header { get { return _header; } }

        /// <summary>
        /// Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).
        /// </summary>
        public byte[] Body { get { return _body; } }
        public Tpc M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
