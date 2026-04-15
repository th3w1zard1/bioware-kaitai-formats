// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).
    /// 
    /// Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
    /// (Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).
    /// </summary>
    public partial class BiowareGffCommon : KaitaiStruct
    {
        public static BiowareGffCommon FromFile(string fileName)
        {
            return new BiowareGffCommon(new KaitaiStream(fileName));
        }


        public enum GffFieldType
        {
            Uint8 = 0,
            Int8 = 1,
            Uint16 = 2,
            Int16 = 3,
            Uint32 = 4,
            Int32 = 5,
            Uint64 = 6,
            Int64 = 7,
            Single = 8,
            Double = 9,
            String = 10,
            Resref = 11,
            LocalizedString = 12,
            Binary = 13,
            Struct = 14,
            List = 15,
            Vector4 = 16,
            Vector3 = 17,
            StrRef = 18,
        }
        public BiowareGffCommon(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareGffCommon p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
        }
        private BiowareGffCommon m_root;
        private KaitaiStruct m_parent;
        public BiowareGffCommon M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
