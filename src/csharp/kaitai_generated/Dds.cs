// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
    /// (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.
    /// 
    /// BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds">PyKotor wiki — DDS</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130">PyKotor — TPCDDSReader</a>
    /// </remarks>
    public partial class Dds : KaitaiStruct
    {
        public static Dds FromFile(string fileName)
        {
            return new Dds(new KaitaiStream(fileName));
        }

        public Dds(KaitaiStream p__io, KaitaiStruct p__parent = null, Dds p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _magic = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!( ((_magic == "DDS ") || (_magic == "    ")) ))
            {
                throw new ValidationNotAnyOfError(_magic, m_io, "/seq/0");
            }
            if (Magic == "DDS ") {
                _header = new DdsHeader(m_io, this, m_root);
            }
            if (Magic != "DDS ") {
                _biowareHeader = new BiowareDdsHeader(m_io, this, m_root);
            }
            _pixelData = m_io.ReadBytesFull();
        }
        public partial class BiowareDdsHeader : KaitaiStruct
        {
            public static BiowareDdsHeader FromFile(string fileName)
            {
                return new BiowareDdsHeader(new KaitaiStream(fileName));
            }

            public BiowareDdsHeader(KaitaiStream p__io, Dds p__parent = null, Dds p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _width = m_io.ReadU4le();
                _height = m_io.ReadU4le();
                _bytesPerPixel = ((BiowareCommon.BiowareDdsVariantBytesPerPixel) m_io.ReadU4le());
                _dataSize = m_io.ReadU4le();
                _unusedFloat = m_io.ReadF4le();
            }
            private uint _width;
            private uint _height;
            private BiowareCommon.BiowareDdsVariantBytesPerPixel _bytesPerPixel;
            private uint _dataSize;
            private float _unusedFloat;
            private Dds m_root;
            private Dds m_parent;

            /// <summary>
            /// Image width in pixels (must be power of two, &lt; 0x8000)
            /// </summary>
            public uint Width { get { return _width; } }

            /// <summary>
            /// Image height in pixels (must be power of two, &lt; 0x8000)
            /// </summary>
            public uint Height { get { return _height; } }

            /// <summary>
            /// BioWare variant “bytes per pixel” (`u4`): DXT1 vs DXT5 block stride hint. Canonical: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
            /// </summary>
            public BiowareCommon.BiowareDdsVariantBytesPerPixel BytesPerPixel { get { return _bytesPerPixel; } }

            /// <summary>
            /// Total compressed data size.
            /// Must match (width*height)/2 for DXT1 or width*height for DXT5
            /// </summary>
            public uint DataSize { get { return _dataSize; } }

            /// <summary>
            /// Unused float field (typically 0.0)
            /// </summary>
            public float UnusedFloat { get { return _unusedFloat; } }
            public Dds M_Root { get { return m_root; } }
            public Dds M_Parent { get { return m_parent; } }
        }
        public partial class Ddpixelformat : KaitaiStruct
        {
            public static Ddpixelformat FromFile(string fileName)
            {
                return new Ddpixelformat(new KaitaiStream(fileName));
            }

            public Ddpixelformat(KaitaiStream p__io, Dds.DdsHeader p__parent = null, Dds p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _size = m_io.ReadU4le();
                if (!(_size == 32))
                {
                    throw new ValidationNotEqualError(32, _size, m_io, "/types/ddpixelformat/seq/0");
                }
                _flags = m_io.ReadU4le();
                _fourcc = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                _rgbBitCount = m_io.ReadU4le();
                _rBitMask = m_io.ReadU4le();
                _gBitMask = m_io.ReadU4le();
                _bBitMask = m_io.ReadU4le();
                _aBitMask = m_io.ReadU4le();
            }
            private uint _size;
            private uint _flags;
            private string _fourcc;
            private uint _rgbBitCount;
            private uint _rBitMask;
            private uint _gBitMask;
            private uint _bBitMask;
            private uint _aBitMask;
            private Dds m_root;
            private Dds.DdsHeader m_parent;

            /// <summary>
            /// Structure size (must be 32)
            /// </summary>
            public uint Size { get { return _size; } }

            /// <summary>
            /// Pixel format flags:
            /// - 0x00000001 = DDPF_ALPHAPIXELS
            /// - 0x00000002 = DDPF_ALPHA
            /// - 0x00000004 = DDPF_FOURCC
            /// - 0x00000040 = DDPF_RGB
            /// - 0x00000200 = DDPF_YUV
            /// - 0x00080000 = DDPF_LUMINANCE
            /// </summary>
            public uint Flags { get { return _flags; } }

            /// <summary>
            /// Four-character code for compressed formats:
            /// - &quot;DXT1&quot; = DXT1 compression
            /// - &quot;DXT3&quot; = DXT3 compression
            /// - &quot;DXT5&quot; = DXT5 compression
            /// - &quot;    &quot; = Uncompressed format
            /// </summary>
            public string Fourcc { get { return _fourcc; } }

            /// <summary>
            /// Bits per pixel for uncompressed formats (16, 24, or 32)
            /// </summary>
            public uint RgbBitCount { get { return _rgbBitCount; } }

            /// <summary>
            /// Red channel bit mask (for uncompressed formats)
            /// </summary>
            public uint RBitMask { get { return _rBitMask; } }

            /// <summary>
            /// Green channel bit mask (for uncompressed formats)
            /// </summary>
            public uint GBitMask { get { return _gBitMask; } }

            /// <summary>
            /// Blue channel bit mask (for uncompressed formats)
            /// </summary>
            public uint BBitMask { get { return _bBitMask; } }

            /// <summary>
            /// Alpha channel bit mask (for uncompressed formats)
            /// </summary>
            public uint ABitMask { get { return _aBitMask; } }
            public Dds M_Root { get { return m_root; } }
            public Dds.DdsHeader M_Parent { get { return m_parent; } }
        }
        public partial class DdsHeader : KaitaiStruct
        {
            public static DdsHeader FromFile(string fileName)
            {
                return new DdsHeader(new KaitaiStream(fileName));
            }

            public DdsHeader(KaitaiStream p__io, Dds p__parent = null, Dds p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _size = m_io.ReadU4le();
                if (!(_size == 124))
                {
                    throw new ValidationNotEqualError(124, _size, m_io, "/types/dds_header/seq/0");
                }
                _flags = m_io.ReadU4le();
                _height = m_io.ReadU4le();
                _width = m_io.ReadU4le();
                _pitchOrLinearSize = m_io.ReadU4le();
                _depth = m_io.ReadU4le();
                _mipmapCount = m_io.ReadU4le();
                _reserved1 = new List<uint>();
                for (var i = 0; i < 11; i++)
                {
                    _reserved1.Add(m_io.ReadU4le());
                }
                _pixelFormat = new Ddpixelformat(m_io, this, m_root);
                _caps = m_io.ReadU4le();
                _caps2 = m_io.ReadU4le();
                _caps3 = m_io.ReadU4le();
                _caps4 = m_io.ReadU4le();
                _reserved2 = m_io.ReadU4le();
            }
            private uint _size;
            private uint _flags;
            private uint _height;
            private uint _width;
            private uint _pitchOrLinearSize;
            private uint _depth;
            private uint _mipmapCount;
            private List<uint> _reserved1;
            private Ddpixelformat _pixelFormat;
            private uint _caps;
            private uint _caps2;
            private uint _caps3;
            private uint _caps4;
            private uint _reserved2;
            private Dds m_root;
            private Dds m_parent;

            /// <summary>
            /// Header size (must be 124)
            /// </summary>
            public uint Size { get { return _size; } }

            /// <summary>
            /// DDS flags bitfield:
            /// - 0x00001007 = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT
            /// - 0x00020000 = DDSD_MIPMAPCOUNT (if mipmaps present)
            /// </summary>
            public uint Flags { get { return _flags; } }

            /// <summary>
            /// Image height in pixels
            /// </summary>
            public uint Height { get { return _height; } }

            /// <summary>
            /// Image width in pixels
            /// </summary>
            public uint Width { get { return _width; } }

            /// <summary>
            /// Pitch (uncompressed) or linear size (compressed).
            /// For compressed formats: total size of all mip levels
            /// </summary>
            public uint PitchOrLinearSize { get { return _pitchOrLinearSize; } }

            /// <summary>
            /// Depth for volume textures (usually 0 for 2D textures)
            /// </summary>
            public uint Depth { get { return _depth; } }

            /// <summary>
            /// Number of mipmap levels (0 or 1 = no mipmaps)
            /// </summary>
            public uint MipmapCount { get { return _mipmapCount; } }

            /// <summary>
            /// Reserved fields (unused)
            /// </summary>
            public List<uint> Reserved1 { get { return _reserved1; } }

            /// <summary>
            /// Pixel format structure
            /// </summary>
            public Ddpixelformat PixelFormat { get { return _pixelFormat; } }

            /// <summary>
            /// Capability flags:
            /// - 0x00001000 = DDSCAPS_TEXTURE
            /// - 0x00000008 = DDSCAPS_MIPMAP
            /// - 0x00000200 = DDSCAPS2_CUBEMAP
            /// </summary>
            public uint Caps { get { return _caps; } }

            /// <summary>
            /// Additional capability flags:
            /// - 0x00000200 = DDSCAPS2_CUBEMAP
            /// - 0x00000FC00 = Cube map face flags
            /// </summary>
            public uint Caps2 { get { return _caps2; } }

            /// <summary>
            /// Reserved capability flags
            /// </summary>
            public uint Caps3 { get { return _caps3; } }

            /// <summary>
            /// Reserved capability flags
            /// </summary>
            public uint Caps4 { get { return _caps4; } }

            /// <summary>
            /// Reserved field
            /// </summary>
            public uint Reserved2 { get { return _reserved2; } }
            public Dds M_Root { get { return m_root; } }
            public Dds M_Parent { get { return m_parent; } }
        }
        private string _magic;
        private DdsHeader _header;
        private BiowareDdsHeader _biowareHeader;
        private byte[] _pixelData;
        private Dds m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File magic. Either &quot;DDS &quot; (0x44445320) for standard DDS,
        /// or check for BioWare variant (no magic, starts with width/height).
        /// </summary>
        public string Magic { get { return _magic; } }

        /// <summary>
        /// Standard DDS header (124 bytes) - only present if magic is &quot;DDS &quot;
        /// </summary>
        public DdsHeader Header { get { return _header; } }

        /// <summary>
        /// BioWare DDS variant header - only present if magic is not &quot;DDS &quot;
        /// </summary>
        public BiowareDdsHeader BiowareHeader { get { return _biowareHeader; } }

        /// <summary>
        /// Pixel data (compressed or uncompressed); single blob to EOF.
        /// For standard DDS: format determined by DDPIXELFORMAT.
        /// For BioWare DDS: DXT1 or DXT5 compressed data.
        /// </summary>
        public byte[] PixelData { get { return _pixelData; } }
        public Dds M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
