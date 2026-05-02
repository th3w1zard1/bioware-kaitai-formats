// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// **LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
    /// `letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
    /// `bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format">PyKotor wiki — LTR</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ltr/io_ltr.py#L44-L155">PyKotor — `io_ltr` reader/writer (start of `write`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L101">xoreos — `kFileTypeLTR`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L121-L133">xoreos — `LTRFile::readLetterSet`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L135-L168">xoreos — `LTRFile::load`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/ltrreader.cpp#L27-L74">reone — `LtrReader::load` + `readLetterSet`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LTRObject.ts#L51-L122">KotOR.js — `LTRObject.readBuffer`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no dedicated LTR Torlack page; use `ltrfile.cpp` + PyKotor)</a>
    /// </remarks>
    public partial class Ltr : KaitaiStruct
    {
        public static Ltr FromFile(string fileName)
        {
            return new Ltr(new KaitaiStream(fileName));
        }

        public Ltr(KaitaiStream p__io, KaitaiStruct p__parent = null, Ltr p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            _letterCount = ((BiowareCommon.BiowareLtrAlphabetLength) m_io.ReadU1());
            _singleLetterBlock = new LetterBlock(m_io, this, m_root);
            _doubleLetterBlocks = new DoubleLetterBlocksArray(m_io, this, m_root);
            _tripleLetterBlocks = new TripleLetterBlocksArray(m_io, this, m_root);
        }

        /// <summary>
        /// Array of double-letter blocks. One block per character in the alphabet.
        /// Each block is indexed by the previous character (context length 1).
        /// </summary>
        public partial class DoubleLetterBlocksArray : KaitaiStruct
        {
            public static DoubleLetterBlocksArray FromFile(string fileName)
            {
                return new DoubleLetterBlocksArray(new KaitaiStream(fileName));
            }

            public DoubleLetterBlocksArray(KaitaiStream p__io, Ltr p__parent = null, Ltr p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _blocks = new List<LetterBlock>();
                for (var i = 0; i < ((int) M_Root.LetterCount); i++)
                {
                    _blocks.Add(new LetterBlock(m_io, this, m_root));
                }
            }
            private List<LetterBlock> _blocks;
            private Ltr m_root;
            private Ltr m_parent;

            /// <summary>
            /// Array of letter_count blocks, each containing start/middle/end probability arrays.
            /// Block index corresponds to the previous character in the alphabet.
            /// </summary>
            public List<LetterBlock> Blocks { get { return _blocks; } }
            public Ltr M_Root { get { return m_root; } }
            public Ltr M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// A probability block containing three arrays of probabilities (start, middle, end).
        /// Each array has letter_count floats representing cumulative probabilities for each character
        /// in the alphabet appearing at that position (start, middle, or end of name).
        /// 
        /// Blocks store cumulative probabilities (monotonically increasing floats) that are compared
        /// against random roll values during name generation.
        /// </summary>
        public partial class LetterBlock : KaitaiStruct
        {
            public static LetterBlock FromFile(string fileName)
            {
                return new LetterBlock(new KaitaiStream(fileName));
            }

            public LetterBlock(KaitaiStream p__io, KaitaiStruct p__parent = null, Ltr p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _startProbabilities = new List<float>();
                for (var i = 0; i < ((int) M_Root.LetterCount); i++)
                {
                    _startProbabilities.Add(m_io.ReadF4le());
                }
                _middleProbabilities = new List<float>();
                for (var i = 0; i < ((int) M_Root.LetterCount); i++)
                {
                    _middleProbabilities.Add(m_io.ReadF4le());
                }
                _endProbabilities = new List<float>();
                for (var i = 0; i < ((int) M_Root.LetterCount); i++)
                {
                    _endProbabilities.Add(m_io.ReadF4le());
                }
            }
            private List<float> _startProbabilities;
            private List<float> _middleProbabilities;
            private List<float> _endProbabilities;
            private Ltr m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Array of start probabilities. One float per character in alphabet.
            /// Probability of each letter starting a name (no context for singles,
            /// after previous character for doubles, after previous two for triples).
            /// </summary>
            public List<float> StartProbabilities { get { return _startProbabilities; } }

            /// <summary>
            /// Array of middle probabilities. One float per character in alphabet.
            /// Probability of each letter appearing in the middle of a name.
            /// </summary>
            public List<float> MiddleProbabilities { get { return _middleProbabilities; } }

            /// <summary>
            /// Array of end probabilities. One float per character in alphabet.
            /// Probability of each letter ending a name.
            /// </summary>
            public List<float> EndProbabilities { get { return _endProbabilities; } }
            public Ltr M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
        /// Each block is indexed by the previous two characters (context length 2).
        /// </summary>
        public partial class TripleLetterBlocksArray : KaitaiStruct
        {
            public static TripleLetterBlocksArray FromFile(string fileName)
            {
                return new TripleLetterBlocksArray(new KaitaiStream(fileName));
            }

            public TripleLetterBlocksArray(KaitaiStream p__io, Ltr p__parent = null, Ltr p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _rows = new List<TripleLetterRow>();
                for (var i = 0; i < ((int) M_Root.LetterCount); i++)
                {
                    _rows.Add(new TripleLetterRow(m_io, this, m_root));
                }
            }
            private List<TripleLetterRow> _rows;
            private Ltr m_root;
            private Ltr m_parent;

            /// <summary>
            /// Array of letter_count rows, each containing letter_count blocks.
            /// First index corresponds to the second-to-last character.
            /// Second index corresponds to the last character.
            /// </summary>
            public List<TripleLetterRow> Rows { get { return _rows; } }
            public Ltr M_Root { get { return m_root; } }
            public Ltr M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// A row in the triple-letter blocks array. Contains letter_count blocks,
        /// each indexed by the last character in the two-character context.
        /// </summary>
        public partial class TripleLetterRow : KaitaiStruct
        {
            public static TripleLetterRow FromFile(string fileName)
            {
                return new TripleLetterRow(new KaitaiStream(fileName));
            }

            public TripleLetterRow(KaitaiStream p__io, Ltr.TripleLetterBlocksArray p__parent = null, Ltr p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _blocks = new List<LetterBlock>();
                for (var i = 0; i < ((int) M_Root.LetterCount); i++)
                {
                    _blocks.Add(new LetterBlock(m_io, this, m_root));
                }
            }
            private List<LetterBlock> _blocks;
            private Ltr m_root;
            private Ltr.TripleLetterBlocksArray m_parent;

            /// <summary>
            /// Array of letter_count blocks, each containing start/middle/end probability arrays.
            /// Block index corresponds to the last character in the two-character context.
            /// </summary>
            public List<LetterBlock> Blocks { get { return _blocks; } }
            public Ltr M_Root { get { return m_root; } }
            public Ltr.TripleLetterBlocksArray M_Parent { get { return m_parent; } }
        }
        private string _fileType;
        private string _fileVersion;
        private BiowareCommon.BiowareLtrAlphabetLength _letterCount;
        private LetterBlock _singleLetterBlock;
        private DoubleLetterBlocksArray _doubleLetterBlocks;
        private TripleLetterBlocksArray _tripleLetterBlocks;
        private Ltr m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File type signature. Must be &quot;LTR &quot; (space-padded) for LTR files.
        /// </summary>
        public string FileType { get { return _fileType; } }

        /// <summary>
        /// File format version. Must be &quot;V1.0&quot; for LTR files.
        /// </summary>
        public string FileVersion { get { return _fileVersion; } }

        /// <summary>
        /// Alphabet size (`u1`). Canonical enum: `formats/Common/bioware_common.ksy` → `bioware_ltr_alphabet_length`
        /// (26 = NWN `a-z`; 28 = KotOR `a-z` + `'` + `-`). For `repeat-expr` counts use `letter_count.to_i` (Kaitai: enum → int, user guide section 6.4.5).
        /// </summary>
        public BiowareCommon.BiowareLtrAlphabetLength LetterCount { get { return _letterCount; } }

        /// <summary>
        /// Single-letter probability block (no context).
        /// Used for generating the first character of names.
        /// Contains start/middle/end probability arrays, each with letter_count floats.
        /// Total size: letter_count × 3 × 4 bytes = 336 bytes for KotOR (28 chars).
        /// </summary>
        public LetterBlock SingleLetterBlock { get { return _singleLetterBlock; } }

        /// <summary>
        /// Double-letter probability blocks (1-character context).
        /// Array of letter_count blocks, each indexed by the previous character.
        /// Used for generating the second character based on the first character.
        /// Each block contains start/middle/end probability arrays.
        /// Total size: letter_count × 3 × letter_count × 4 bytes = 9,408 bytes for KotOR.
        /// </summary>
        public DoubleLetterBlocksArray DoubleLetterBlocks { get { return _doubleLetterBlocks; } }

        /// <summary>
        /// Triple-letter probability blocks (2-character context).
        /// Two-dimensional array of letter_count × letter_count blocks.
        /// Each block is indexed by the previous two characters.
        /// Used for generating third and subsequent characters.
        /// Each block contains start/middle/end probability arrays.
        /// Total size: letter_count × letter_count × 3 × letter_count × 4 bytes = 73,472 bytes for KotOR.
        /// </summary>
        public TripleLetterBlocksArray TripleLetterBlocks { get { return _tripleLetterBlocks; } }
        public Ltr M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
