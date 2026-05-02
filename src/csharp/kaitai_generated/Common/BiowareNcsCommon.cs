// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).
    /// 
    /// - `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
    ///   (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
    /// - `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
    ///   decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
    /// - `ncs_program_size_marker` is the fixed header byte after `&quot;V1.0&quot;` in retail KotOR NCS blobs (`0x42`).
    /// 
    /// **Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
    /// duplicating opcode lists.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L115">PyKotor — NCSByteCode</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L118-L140">PyKotor — NCSInstructionQualifier</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format">PyKotor wiki — NCS</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355">xoreos — NCSFile::load</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137">xoreos-tools — NCSFile::load</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html">xoreos-docs — Torlack ncs.html</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40">reone — NcsReader::load</a>
    /// </remarks>
    public partial class BiowareNcsCommon : KaitaiStruct
    {
        public static BiowareNcsCommon FromFile(string fileName)
        {
            return new BiowareNcsCommon(new KaitaiStream(fileName));
        }


        public enum NcsBytecode
        {
            ReservedBc = 0,
            Cpdownsp = 1,
            Rsaddx = 2,
            Cptopsp = 3,
            Constx = 4,
            Action = 5,
            Logandxx = 6,
            Logorxx = 7,
            Incorxx = 8,
            Excorxx = 9,
            Boolandxx = 10,
            Equalxx = 11,
            Nequalxx = 12,
            Geqxx = 13,
            Gtxx = 14,
            Ltxx = 15,
            Leqxx = 16,
            Shleftxx = 17,
            Shrightxx = 18,
            Ushrightxx = 19,
            Addxx = 20,
            Subxx = 21,
            Mulxx = 22,
            Divxx = 23,
            Modxx = 24,
            Negx = 25,
            Compx = 26,
            Movsp = 27,
            UnusedGap = 28,
            Jmp = 29,
            Jsr = 30,
            Jz = 31,
            Retn = 32,
            Destruct = 33,
            Notx = 34,
            Decxsp = 35,
            Incxsp = 36,
            Jnz = 37,
            Cpdownbp = 38,
            Cptopbp = 39,
            Decxbp = 40,
            Incxbp = 41,
            Savebp = 42,
            Restorebp = 43,
            StoreState = 44,
            Nop = 45,
        }

        public enum NcsInstructionQualifier
        {
            None = 0,
            UnaryOperandLayout = 1,
            IntType = 3,
            FloatType = 4,
            StringType = 5,
            ObjectType = 6,
            EffectType = 16,
            EventType = 17,
            LocationType = 18,
            TalentType = 19,
            IntInt = 32,
            FloatFloat = 33,
            ObjectObject = 34,
            StringString = 35,
            StructStruct = 36,
            IntFloat = 37,
            FloatInt = 38,
            EffectEffect = 48,
            EventEvent = 49,
            LocationLocation = 50,
            TalentTalent = 51,
            VectorVector = 58,
            VectorFloat = 59,
            FloatVector = 60,
        }

        public enum NcsProgramSizeMarker
        {
            ProgramSizePrefix = 66,
        }
        public BiowareNcsCommon(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareNcsCommon p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
        }
        private BiowareNcsCommon m_root;
        private KaitaiStruct m_parent;
        public BiowareNcsCommon M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
