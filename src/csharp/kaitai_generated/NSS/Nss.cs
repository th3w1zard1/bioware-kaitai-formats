// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// NSS (NWScript Source) files contain human-readable NWScript source code
    /// that compiles to NCS bytecode. NWScript is the scripting language used
    /// in KotOR, TSL, and Neverwinter Nights.
    /// 
    /// NSS files are plain text files (typically Windows-1252 or UTF-8 encoding)
    /// containing NWScript source code. The nwscript.nss file defines all
    /// engine-exposed functions and constants available to scripts.
    /// 
    /// Format:
    /// - Plain text source code
    /// - May include BOM (Byte Order Mark) for UTF-8 files
    /// - Lines are typically terminated with CRLF (\r\n) or LF (\n)
    /// - Comments: // for single-line, /* */ for multi-line
    /// - Preprocessor directives: #include, #define, etc.
    /// 
    /// Authoritative links: `meta.doc-ref` (PyKotor wiki, xoreos `types.h` `kFileTypeNSS`, xoreos-tools `NCSFile`, reone `NssWriter`).
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/NSS-File-Format">PyKotor wiki — NSS</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L85-L86">xoreos — `kFileTypeNSS` / `kFileTypeNCS` (Aurora `FileType` IDs; NSS plaintext, NCS bytecode)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137">xoreos-tools — `NCSFile`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/tools/script/format/nsswriter.cpp#L33-L45">reone — `NssWriter::save`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html">xoreos-docs — Torlack NCS (bytecode companion to plaintext NSS)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree</a>
    /// </remarks>
    public partial class Nss : KaitaiStruct
    {
        public static Nss FromFile(string fileName)
        {
            return new Nss(new KaitaiStream(fileName));
        }

        public Nss(KaitaiStream p__io, KaitaiStruct p__parent = null, Nss p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            if (M_Io.Pos == 0) {
                _bom = m_io.ReadU2le();
                if (!( ((_bom == 65279) || (_bom == 0)) ))
                {
                    throw new ValidationNotAnyOfError(_bom, m_io, "/seq/0");
                }
            }
            _sourceCode = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytesFull());
        }

        /// <summary>
        /// NWScript source code structure.
        /// This is primarily a text format, so the main content is the source_code string.
        /// 
        /// The source can be parsed into:
        /// - Tokens (keywords, identifiers, operators, literals)
        /// - Statements (declarations, assignments, control flow)
        /// - Functions (definitions with parameters and body)
        /// - Preprocessor directives (#include, #define)
        /// </summary>
        public partial class NssSource : KaitaiStruct
        {
            public static NssSource FromFile(string fileName)
            {
                return new NssSource(new KaitaiStream(fileName));
            }

            public NssSource(KaitaiStream p__io, KaitaiStruct p__parent = null, Nss p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _content = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytesFull());
            }
            private string _content;
            private Nss m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Complete source code content.
            /// </summary>
            public string Content { get { return _content; } }
            public Nss M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        private ushort? _bom;
        private string _sourceCode;
        private Nss m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// Optional UTF-8 BOM (Byte Order Mark) at the start of the file.
        /// If present, will be 0xFEFF (UTF-8 BOM).
        /// Most NSS files do not include a BOM.
        /// </summary>
        public ushort? Bom { get { return _bom; } }

        /// <summary>
        /// Complete NWScript source code.
        /// Contains function definitions, variable declarations, control flow
        /// statements, and engine function calls.
        /// 
        /// Common elements:
        /// - Function definitions: void function_name() { ... }
        /// - Variable declarations: int variable_name;
        /// - Control flow: if, while, for, switch
        /// - Engine function calls: GetFirstObject(), GetObjectByTag(), etc.
        /// - Constants: OBJECT_SELF, OBJECT_INVALID, etc.
        /// 
        /// The source code is compiled to NCS bytecode by the NWScript compiler.
        /// </summary>
        public string SourceCode { get { return _sourceCode; } }
        public Nss M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
