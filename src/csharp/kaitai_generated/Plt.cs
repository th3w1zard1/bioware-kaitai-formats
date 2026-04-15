// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
    /// palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
    /// that reference external palette files, enabling dynamic color customization for character models
    /// (skin, hair, armor colors, etc.).
    /// 
    /// **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
    /// resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
    /// does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
    /// including character models. This documentation is provided for reference only.
    /// 
    /// Binary Format Structure:
    /// - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
    /// - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)
    /// 
    /// Palette System:
    /// PLT files work in conjunction with external palette files (.pal files) that contain the actual
    /// color values. The PLT file itself stores:
    /// 1. Palette Group index (0-9): Which palette group to use for each pixel
    /// 2. Color index (0-255): Which color within the selected palette to use
    /// 
    /// At runtime, the game:
    /// 1. Loads the appropriate palette file for the selected palette group
    /// 2. Uses the palette index (supplied by the content creator) to select a row in the palette file
    /// 3. Uses the color index from the PLT file to retrieve the final color value
    /// 
    /// Palette Groups (10 total):
    /// 0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
    /// 6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2
    /// 
    /// References:
    /// - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
    /// - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
    /// - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp
    /// </summary>
    public partial class Plt : KaitaiStruct
    {
        public static Plt FromFile(string fileName)
        {
            return new Plt(new KaitaiStream(fileName));
        }

        public Plt(KaitaiStream p__io, KaitaiStruct p__parent = null, Plt p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _header = new PltHeader(m_io, this, m_root);
            _pixelData = new PixelDataSection(m_io, this, m_root);
        }
        public partial class PixelDataSection : KaitaiStruct
        {
            public static PixelDataSection FromFile(string fileName)
            {
                return new PixelDataSection(new KaitaiStream(fileName));
            }

            public PixelDataSection(KaitaiStream p__io, Plt p__parent = null, Plt p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _pixels = new List<PltPixel>();
                for (var i = 0; i < M_Root.Header.Width * M_Root.Header.Height; i++)
                {
                    _pixels.Add(new PltPixel(m_io, this, m_root));
                }
            }
            private List<PltPixel> _pixels;
            private Plt m_root;
            private Plt m_parent;

            /// <summary>
            /// Array of pixel entries, stored row by row, left to right, top to bottom.
            /// Total size = width × height × 2 bytes.
            /// Each pixel entry contains a color index and palette group index.
            /// </summary>
            public List<PltPixel> Pixels { get { return _pixels; } }
            public Plt M_Root { get { return m_root; } }
            public Plt M_Parent { get { return m_parent; } }
        }
        public partial class PltHeader : KaitaiStruct
        {
            public static PltHeader FromFile(string fileName)
            {
                return new PltHeader(new KaitaiStream(fileName));
            }

            public PltHeader(KaitaiStream p__io, Plt p__parent = null, Plt p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _signature = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!(_signature == "PLT "))
                {
                    throw new ValidationNotEqualError("PLT ", _signature, m_io, "/types/plt_header/seq/0");
                }
                _version = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!(_version == "V1  "))
                {
                    throw new ValidationNotEqualError("V1  ", _version, m_io, "/types/plt_header/seq/1");
                }
                _unknown1 = m_io.ReadU4le();
                _unknown2 = m_io.ReadU4le();
                _width = m_io.ReadU4le();
                _height = m_io.ReadU4le();
            }
            private string _signature;
            private string _version;
            private uint _unknown1;
            private uint _unknown2;
            private uint _width;
            private uint _height;
            private Plt m_root;
            private Plt m_parent;

            /// <summary>
            /// File signature. Must be &quot;PLT &quot; (space-padded).
            /// This identifies the file as a PLT palette texture.
            /// </summary>
            public string Signature { get { return _signature; } }

            /// <summary>
            /// File format version. Must be &quot;V1  &quot; (space-padded).
            /// This is the only known version of the PLT format.
            /// </summary>
            public string Version { get { return _version; } }

            /// <summary>
            /// Unknown field (4 bytes).
            /// Purpose is unknown, may be reserved for future use or internal engine flags.
            /// </summary>
            public uint Unknown1 { get { return _unknown1; } }

            /// <summary>
            /// Unknown field (4 bytes).
            /// Purpose is unknown, may be reserved for future use or internal engine flags.
            /// </summary>
            public uint Unknown2 { get { return _unknown2; } }

            /// <summary>
            /// Texture width in pixels (uint32).
            /// Used to calculate the number of pixel entries in the pixel data section.
            /// </summary>
            public uint Width { get { return _width; } }

            /// <summary>
            /// Texture height in pixels (uint32).
            /// Used to calculate the number of pixel entries in the pixel data section.
            /// Total pixel count = width × height
            /// </summary>
            public uint Height { get { return _height; } }
            public Plt M_Root { get { return m_root; } }
            public Plt M_Parent { get { return m_parent; } }
        }
        public partial class PltPixel : KaitaiStruct
        {
            public static PltPixel FromFile(string fileName)
            {
                return new PltPixel(new KaitaiStream(fileName));
            }

            public PltPixel(KaitaiStream p__io, Plt.PixelDataSection p__parent = null, Plt p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _colorIndex = m_io.ReadU1();
                _paletteGroupIndex = m_io.ReadU1();
            }
            private byte _colorIndex;
            private byte _paletteGroupIndex;
            private Plt m_root;
            private Plt.PixelDataSection m_parent;

            /// <summary>
            /// Color index (0-255) within the selected palette.
            /// This value selects which color from the palette file row to use.
            /// The palette file contains 256 rows (one for each palette index 0-255),
            /// and each row contains 256 color values (one for each color index 0-255).
            /// </summary>
            public byte ColorIndex { get { return _colorIndex; } }

            /// <summary>
            /// Palette group index (0-9) that determines which palette file to use.
            /// Palette groups:
            /// 0 = Skin (pal_skin01.jpg)
            /// 1 = Hair (pal_hair01.jpg)
            /// 2 = Metal 1 (pal_armor01.jpg)
            /// 3 = Metal 2 (pal_armor02.jpg)
            /// 4 = Cloth 1 (pal_cloth01.jpg)
            /// 5 = Cloth 2 (pal_cloth01.jpg)
            /// 6 = Leather 1 (pal_leath01.jpg)
            /// 7 = Leather 2 (pal_leath01.jpg)
            /// 8 = Tattoo 1 (pal_tattoo01.jpg)
            /// 9 = Tattoo 2 (pal_tattoo01.jpg)
            /// </summary>
            public byte PaletteGroupIndex { get { return _paletteGroupIndex; } }
            public Plt M_Root { get { return m_root; } }
            public Plt.PixelDataSection M_Parent { get { return m_parent; } }
        }
        private PltHeader _header;
        private PixelDataSection _pixelData;
        private Plt m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// PLT file header (24 bytes)
        /// </summary>
        public PltHeader Header { get { return _header; } }

        /// <summary>
        /// Array of pixel entries (width × height entries, 2 bytes each)
        /// </summary>
        public PixelDataSection PixelData { get { return _pixelData; } }
        public Plt M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
