// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// TXI (Texture Info) files are compact ASCII descriptors that attach metadata to TPC textures.
    /// They control mipmap usage, filtering, flipbook animation, environment mapping, font atlases,
    /// and platform-specific downsampling. Every TXI file is parsed at runtime to configure how
    /// a TPC image is rendered.
    /// 
    /// Format Structure:
    /// - Line-based ASCII text file (UTF-8 or Windows-1252)
    /// - Commands are case-insensitive but conventionally lowercase
    /// - Empty TXI files (0 bytes) are valid and use default settings
    /// - A TXI can be embedded at the end of a .tpc file or exist as a separate .txi file
    /// 
    /// Command Formats (from PyKotor implementation):
    /// 1. Simple commands: &quot;command value&quot; (e.g., &quot;mipmap 0&quot;, &quot;blending additive&quot;)
    /// 2. Multi-value commands: &quot;command v1 v2 v3&quot; (e.g., &quot;channelscale 1.0 0.5 0.5&quot;)
    /// 3. Coordinate commands: &quot;command count&quot; followed by count coordinate lines
    ///    Coordinate format: &quot;x y z&quot; (normalized floats + int, typically z=0)
    /// 
    /// Parsing Behavior (matches PyKotor TXIReaderMode):
    /// - Lines parsed sequentially, whitespace stripped
    /// - Empty lines ignored
    /// - Commands recognized by uppercase comparison against TXICommand enum
    /// - Invalid commands logged but don't stop parsing
    /// - Coordinate commands switch parser to coordinate mode until count reached
    /// - Commands can interrupt coordinate parsing
    /// 
    /// All Supported Commands (from TXICommand enum in txi_data.py):
    /// - alphamean, arturoheight, arturowidth, baselineheight, blending, bumpmapscaling, bumpmaptexture
    /// - bumpyshinytexture, candownsample, caretindent, channelscale, channeltranslate, clamp, codepage
    /// - cols, compresstexture, controllerscript, cube, decal, defaultbpp, defaultheight, defaultwidth
    /// - distort, distortangle, distortionamplitude, downsamplefactor, downsamplemax, downsamplemin
    /// - envmaptexture, filerange, filter, fontheight, fontwidth, fps, isbumpmap, isdiffusebumpmap
    /// - islightmap, isspecularbumpmap, lowerrightcoords, maxsizehq, maxsizelq, minsizehq, minsizelq
    /// - mipmap, numchars, numcharspersheet, numx, numy, ondemand, priority, proceduretype, rows
    /// - spacingb, spacingr, speed, temporary, texturewidth, unique, upperleftcoords, wateralpha
    /// - waterheight, waterwidth, xbox_downsample
    /// 
    /// References:
    /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/io_txi.py - Complete parser
    /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py - Data structures
    /// - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi - Format documentation
    /// - https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/txireader.cpp - C++ reference implementation
    /// </summary>
    public partial class Txi : KaitaiStruct
    {
        public static Txi FromFile(string fileName)
        {
            return new Txi(new KaitaiStream(fileName));
        }

        public Txi(KaitaiStream p__io, KaitaiStruct p__parent = null, Txi p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _content = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesFull());
        }
        private string _content;
        private Txi m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// Complete TXI file content as raw ASCII text.
        /// The PyKotor parser processes this line-by-line with special handling for:
        /// - Coordinate commands (upperleftcoords, lowerrightcoords) followed by coordinate data
        /// - Multi-value commands (channelscale, channeltranslate, filerange)
        /// - Boolean/numeric/string single-value commands
        /// - Empty files (valid, indicates default settings)
        /// </summary>
        public string Content { get { return _content; } }
        public Txi M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
