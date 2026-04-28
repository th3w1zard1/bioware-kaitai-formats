// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
    /// converts authoring TGAs to **TPC** for shipping.
    /// 
    /// Shared header enums: `formats/Common/tga_common.ksy`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — textures (TPC/TGA pipeline)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40">PyKotor — compact TGA reader (`tga.py`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120">PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177">xoreos — `TGA::readHeader`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L241">xoreos-tools — `TGA::load` through `readRLE` (tooling reader)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture pipeline context)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/lachjames/NorthernLights">lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)</a>
    /// </remarks>
    public partial class Tga : KaitaiStruct
    {
        public static Tga FromFile(string fileName)
        {
            return new Tga(new KaitaiStream(fileName));
        }

        public Tga(KaitaiStream p__io, KaitaiStruct p__parent = null, Tga p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _idLength = m_io.ReadU1();
            _colorMapType = ((TgaCommon.TgaColorMapType) m_io.ReadU1());
            _imageType = ((TgaCommon.TgaImageType) m_io.ReadU1());
            if (ColorMapType == TgaCommon.TgaColorMapType.Present) {
                _colorMapSpec = new ColorMapSpecification(m_io, this, m_root);
            }
            _imageSpec = new ImageSpecification(m_io, this, m_root);
            if (IdLength > 0) {
                _imageId = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(IdLength));
            }
            if (ColorMapType == TgaCommon.TgaColorMapType.Present) {
                _colorMapData = new List<byte>();
                for (var i = 0; i < ColorMapSpec.Length; i++)
                {
                    _colorMapData.Add(m_io.ReadU1());
                }
            }
            _imageData = new List<byte>();
            {
                var i = 0;
                while (!m_io.IsEof) {
                    _imageData.Add(m_io.ReadU1());
                    i++;
                }
            }
        }
        public partial class ColorMapSpecification : KaitaiStruct
        {
            public static ColorMapSpecification FromFile(string fileName)
            {
                return new ColorMapSpecification(new KaitaiStream(fileName));
            }

            public ColorMapSpecification(KaitaiStream p__io, Tga p__parent = null, Tga p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _firstEntryIndex = m_io.ReadU2le();
                _length = m_io.ReadU2le();
                _entrySize = m_io.ReadU1();
            }
            private ushort _firstEntryIndex;
            private ushort _length;
            private byte _entrySize;
            private Tga m_root;
            private Tga m_parent;

            /// <summary>
            /// Index of first color map entry
            /// </summary>
            public ushort FirstEntryIndex { get { return _firstEntryIndex; } }

            /// <summary>
            /// Number of color map entries
            /// </summary>
            public ushort Length { get { return _length; } }

            /// <summary>
            /// Size of each color map entry in bits (15, 16, 24, or 32)
            /// </summary>
            public byte EntrySize { get { return _entrySize; } }
            public Tga M_Root { get { return m_root; } }
            public Tga M_Parent { get { return m_parent; } }
        }
        public partial class ImageSpecification : KaitaiStruct
        {
            public static ImageSpecification FromFile(string fileName)
            {
                return new ImageSpecification(new KaitaiStream(fileName));
            }

            public ImageSpecification(KaitaiStream p__io, Tga p__parent = null, Tga p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _xOrigin = m_io.ReadU2le();
                _yOrigin = m_io.ReadU2le();
                _width = m_io.ReadU2le();
                _height = m_io.ReadU2le();
                _pixelDepth = m_io.ReadU1();
                _imageDescriptor = m_io.ReadU1();
            }
            private ushort _xOrigin;
            private ushort _yOrigin;
            private ushort _width;
            private ushort _height;
            private byte _pixelDepth;
            private byte _imageDescriptor;
            private Tga m_root;
            private Tga m_parent;

            /// <summary>
            /// X coordinate of lower-left corner of image
            /// </summary>
            public ushort XOrigin { get { return _xOrigin; } }

            /// <summary>
            /// Y coordinate of lower-left corner of image
            /// </summary>
            public ushort YOrigin { get { return _yOrigin; } }

            /// <summary>
            /// Image width in pixels
            /// </summary>
            public ushort Width { get { return _width; } }

            /// <summary>
            /// Image height in pixels
            /// </summary>
            public ushort Height { get { return _height; } }

            /// <summary>
            /// Bits per pixel:
            /// - 8 = Greyscale or indexed
            /// - 16 = RGB 5-5-5 or RGBA 1-5-5-5
            /// - 24 = RGB
            /// - 32 = RGBA
            /// </summary>
            public byte PixelDepth { get { return _pixelDepth; } }

            /// <summary>
            /// Image descriptor byte:
            /// - Bits 0-3: Number of attribute bits per pixel (alpha channel)
            /// - Bit 4: Reserved
            /// - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
            /// - Bits 6-7: Interleaving (usually 0)
            /// </summary>
            public byte ImageDescriptor { get { return _imageDescriptor; } }
            public Tga M_Root { get { return m_root; } }
            public Tga M_Parent { get { return m_parent; } }
        }
        private byte _idLength;
        private TgaCommon.TgaColorMapType _colorMapType;
        private TgaCommon.TgaImageType _imageType;
        private ColorMapSpecification _colorMapSpec;
        private ImageSpecification _imageSpec;
        private string _imageId;
        private List<byte> _colorMapData;
        private List<byte> _imageData;
        private Tga m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// Length of image ID field (0-255 bytes)
        /// </summary>
        public byte IdLength { get { return _idLength; } }

        /// <summary>
        /// Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.
        /// </summary>
        public TgaCommon.TgaColorMapType ColorMapType { get { return _colorMapType; } }

        /// <summary>
        /// Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.
        /// </summary>
        public TgaCommon.TgaImageType ImageType { get { return _imageType; } }

        /// <summary>
        /// Color map specification (only present if color_map_type == present)
        /// </summary>
        public ColorMapSpecification ColorMapSpec { get { return _colorMapSpec; } }

        /// <summary>
        /// Image specification (dimensions and pixel format)
        /// </summary>
        public ImageSpecification ImageSpec { get { return _imageSpec; } }

        /// <summary>
        /// Image identification field (optional ASCII string)
        /// </summary>
        public string ImageId { get { return _imageId; } }

        /// <summary>
        /// Color map data (palette entries)
        /// </summary>
        public List<byte> ColorMapData { get { return _colorMapData; } }

        /// <summary>
        /// Image pixel data (raw or RLE-compressed).
        /// Size depends on image dimensions, pixel format, and compression.
        /// For uncompressed formats: width × height × bytes_per_pixel
        /// For RLE formats: Variable size depending on compression ratio
        /// </summary>
        public List<byte> ImageData { get { return _imageData; } }
        public Tga M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
