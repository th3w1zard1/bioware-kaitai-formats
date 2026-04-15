// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
    /// Scripts run inside a stack-based virtual machine shared across Aurora engine games.
    /// 
    /// Format Structure:
    /// - Header (13 bytes): Signature &quot;NCS &quot;, version &quot;V1.0&quot;, size marker (0x42), file size
    /// - Instruction Stream: Sequence of bytecode instructions
    /// 
    /// All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).
    /// 
    /// References:
    /// - https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format - Complete NCS format documentation
    /// - NSS.ksy - NWScript source code that compiles to NCS
    /// </summary>
    public partial class Ncs : KaitaiStruct
    {
        public static Ncs FromFile(string fileName)
        {
            return new Ncs(new KaitaiStream(fileName));
        }

        public Ncs(KaitaiStream p__io, KaitaiStruct p__parent = null, Ncs p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_fileType == "NCS "))
            {
                throw new ValidationNotEqualError("NCS ", _fileType, m_io, "/seq/0");
            }
            _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_fileVersion == "V1.0"))
            {
                throw new ValidationNotEqualError("V1.0", _fileVersion, m_io, "/seq/1");
            }
            _sizeMarker = m_io.ReadU1();
            if (!(_sizeMarker == 66))
            {
                throw new ValidationNotEqualError(66, _sizeMarker, m_io, "/seq/2");
            }
            _fileSize = m_io.ReadU4be();
            _instructions = new List<Instruction>();
            {
                var i = 0;
                Instruction M_;
                do {
                    M_ = new Instruction(m_io, this, m_root);
                    _instructions.Add(M_);
                    i++;
                } while (!(M_Io.Pos >= FileSize));
            }
        }

        /// <summary>
        /// NWScript bytecode instruction.
        /// Format: &lt;opcode: uint8&gt; &lt;qualifier: uint8&gt; &lt;arguments: variable&gt;
        /// 
        /// Instruction size varies by opcode:
        /// - Base: 2 bytes (opcode + qualifier)
        /// - Arguments: 0 to variable bytes depending on instruction type
        /// 
        /// Common instruction types:
        /// - Constants: CONSTI (6B), CONSTF (6B), CONSTS (2+N B), CONSTO (6B)
        /// - Stack ops: CPDOWNSP, CPTOPSP, MOVSP (variable size)
        /// - Arithmetic: ADDxx, SUBxx, MULxx, DIVxx (2B)
        /// - Control flow: JMP, JSR, JZ, JNZ (6B), RETN (2B)
        /// - Function calls: ACTION (5B)
        /// - And many more (see NCS format documentation)
        /// </summary>
        public partial class Instruction : KaitaiStruct
        {
            public static Instruction FromFile(string fileName)
            {
                return new Instruction(new KaitaiStream(fileName));
            }

            public Instruction(KaitaiStream p__io, Ncs p__parent = null, Ncs p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _opcode = m_io.ReadU1();
                _qualifier = m_io.ReadU1();
                _arguments = new List<byte>();
                {
                    var i = 0;
                    byte M_;
                    do {
                        M_ = m_io.ReadU1();
                        _arguments.Add(M_);
                        i++;
                    } while (!(M_Io.Pos >= M_Io.Size));
                }
            }
            private byte _opcode;
            private byte _qualifier;
            private List<byte> _arguments;
            private Ncs m_root;
            private Ncs m_parent;

            /// <summary>
            /// Instruction opcode (0x01-0x2D, excluding 0x42 which is reserved for size marker).
            /// Determines the instruction type and argument format.
            /// </summary>
            public byte Opcode { get { return _opcode; } }

            /// <summary>
            /// Qualifier byte that refines the instruction to specific operand types.
            /// Examples: 0x03=Int, 0x04=Float, 0x05=String, 0x06=Object, 0x24=Structure
            /// </summary>
            public byte Qualifier { get { return _qualifier; } }

            /// <summary>
            /// Instruction arguments (variable size).
            /// Format depends on opcode:
            /// - No args: None (total 2B)
            /// - Int/Float/Object: 4 bytes (total 6B)
            /// - String: 2B length + data (total 2+N B)
            /// - Jump: 4B signed offset (total 6B)
            /// - Stack copy: 4B offset + 2B size (total 8B)
            /// - ACTION: 2B routine + 1B argCount (total 5B)
            /// - DESTRUCT: 2B size + 2B offset + 2B sizeNoDestroy (total 8B)
            /// - STORE_STATE: 4B size + 4B sizeLocals (total 10B)
            /// - And others (see documentation)
            /// </summary>
            public List<byte> Arguments { get { return _arguments; } }
            public Ncs M_Root { get { return m_root; } }
            public Ncs M_Parent { get { return m_parent; } }
        }
        private string _fileType;
        private string _fileVersion;
        private byte _sizeMarker;
        private uint _fileSize;
        private List<Instruction> _instructions;
        private Ncs m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File type signature. Must be &quot;NCS &quot; (0x4E 0x43 0x53 0x20).
        /// </summary>
        public string FileType { get { return _fileType; } }

        /// <summary>
        /// File format version. Must be &quot;V1.0&quot; (0x56 0x31 0x2E 0x30).
        /// </summary>
        public string FileVersion { get { return _fileVersion; } }

        /// <summary>
        /// Program size marker opcode. Must be 0x42.
        /// This is not a real instruction but a metadata field containing the total file size.
        /// All implementations validate this marker before parsing instructions.
        /// </summary>
        public byte SizeMarker { get { return _sizeMarker; } }

        /// <summary>
        /// Total file size in bytes (big-endian).
        /// This value should match the actual file size.
        /// </summary>
        public uint FileSize { get { return _fileSize; } }

        /// <summary>
        /// Stream of bytecode instructions.
        /// Execution begins at offset 13 (0x0D) after the header.
        /// Instructions continue until end of file.
        /// </summary>
        public List<Instruction> Instructions { get { return _instructions; } }
        public Ncs M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
