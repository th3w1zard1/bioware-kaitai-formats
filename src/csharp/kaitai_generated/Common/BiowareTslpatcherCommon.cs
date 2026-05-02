// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// Shared enums and small helper types used by TSLPatcher-style tooling.
    /// 
    /// Notes:
    /// - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
    ///   so string-valued enums are modeled here as small string wrapper types with `valid` constraints.
    /// 
    /// References:
    /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
    /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
    /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
    /// - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60">xoreos — `FileType` enum start (engine archive IDs; TSLPatcher enums here are community patch metadata, not read from `swkotor.exe`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/patcher.py#L43-L120">PyKotor — `ModInstaller` (apply / backup entry band)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/memory.py#L1-L80">PyKotor — `memory` (patch address space / token helpers)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/tslpatcher/">PyKotor — `tslpatcher/` package</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py">PyKotor — TwoDA patch helpers</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py">PyKotor — NCS patch helpers</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py">PyKotor — TSLPatcher logging</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py">PyKotor — diff resource objects</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (TSLPatcher metadata; no dedicated PDF)</a>
    /// </remarks>
    public partial class BiowareTslpatcherCommon : KaitaiStruct
    {
        public static BiowareTslpatcherCommon FromFile(string fileName)
        {
            return new BiowareTslpatcherCommon(new KaitaiStream(fileName));
        }


        public enum BiowareTslpatcherLogTypeId
        {
            Verbose = 0,
            Note = 1,
            Warning = 2,
            Error = 3,
        }

        public enum BiowareTslpatcherTargetTypeId
        {
            RowIndex = 0,
            RowLabel = 1,
            LabelColumn = 2,
        }
        public BiowareTslpatcherCommon(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareTslpatcherCommon p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
        }

        /// <summary>
        /// String-valued enum equivalent for DiffFormat (null-terminated ASCII).
        /// </summary>
        public partial class BiowareDiffFormatStr : KaitaiStruct
        {
            public static BiowareDiffFormatStr FromFile(string fileName)
            {
                return new BiowareDiffFormatStr(new KaitaiStream(fileName));
            }

            public BiowareDiffFormatStr(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareTslpatcherCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _value = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesTerm(0, false, true, true));
                if (!( ((_value == "default") || (_value == "unified") || (_value == "context") || (_value == "side_by_side")) ))
                {
                    throw new ValidationNotAnyOfError(_value, m_io, "/types/bioware_diff_format_str/seq/0");
                }
            }
            private string _value;
            private BiowareTslpatcherCommon m_root;
            private KaitaiStruct m_parent;
            public string Value { get { return _value; } }
            public BiowareTslpatcherCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
        /// </summary>
        public partial class BiowareDiffResourceTypeStr : KaitaiStruct
        {
            public static BiowareDiffResourceTypeStr FromFile(string fileName)
            {
                return new BiowareDiffResourceTypeStr(new KaitaiStream(fileName));
            }

            public BiowareDiffResourceTypeStr(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareTslpatcherCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _value = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesTerm(0, false, true, true));
                if (!( ((_value == "gff") || (_value == "2da") || (_value == "tlk") || (_value == "lip") || (_value == "bytes")) ))
                {
                    throw new ValidationNotAnyOfError(_value, m_io, "/types/bioware_diff_resource_type_str/seq/0");
                }
            }
            private string _value;
            private BiowareTslpatcherCommon m_root;
            private KaitaiStruct m_parent;
            public string Value { get { return _value; } }
            public BiowareTslpatcherCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// String-valued enum equivalent for DiffType (null-terminated ASCII).
        /// </summary>
        public partial class BiowareDiffTypeStr : KaitaiStruct
        {
            public static BiowareDiffTypeStr FromFile(string fileName)
            {
                return new BiowareDiffTypeStr(new KaitaiStream(fileName));
            }

            public BiowareDiffTypeStr(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareTslpatcherCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _value = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesTerm(0, false, true, true));
                if (!( ((_value == "identical") || (_value == "modified") || (_value == "added") || (_value == "removed") || (_value == "error")) ))
                {
                    throw new ValidationNotAnyOfError(_value, m_io, "/types/bioware_diff_type_str/seq/0");
                }
            }
            private string _value;
            private BiowareTslpatcherCommon m_root;
            private KaitaiStruct m_parent;
            public string Value { get { return _value; } }
            public BiowareTslpatcherCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
        /// </summary>
        public partial class BiowareNcsTokenTypeStr : KaitaiStruct
        {
            public static BiowareNcsTokenTypeStr FromFile(string fileName)
            {
                return new BiowareNcsTokenTypeStr(new KaitaiStream(fileName));
            }

            public BiowareNcsTokenTypeStr(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareTslpatcherCommon p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _value = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesTerm(0, false, true, true));
                if (!( ((_value == "strref") || (_value == "strref32") || (_value == "2damemory") || (_value == "2damemory32") || (_value == "uint32") || (_value == "uint16") || (_value == "uint8")) ))
                {
                    throw new ValidationNotAnyOfError(_value, m_io, "/types/bioware_ncs_token_type_str/seq/0");
                }
            }
            private string _value;
            private BiowareTslpatcherCommon m_root;
            private KaitaiStruct m_parent;
            public string Value { get { return _value; } }
            public BiowareTslpatcherCommon M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        private BiowareTslpatcherCommon m_root;
        private KaitaiStruct m_parent;
        public BiowareTslpatcherCommon M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
