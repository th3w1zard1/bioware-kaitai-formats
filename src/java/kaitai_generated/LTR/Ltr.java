// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


/**
 * **LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
 * `letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
 * `bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format">PyKotor wiki — LTR</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ltr/io_ltr.py#L44-L155">PyKotor — `io_ltr` reader/writer (start of `write`)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L101">xoreos — `kFileTypeLTR`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L121-L133">xoreos — `LTRFile::readLetterSet`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L135-L168">xoreos — `LTRFile::load`</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/ltrreader.cpp#L27-L74">reone — `LtrReader::load` + `readLetterSet`</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LTRObject.ts#L51-L122">KotOR.js — `LTRObject.readBuffer`</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no dedicated LTR Torlack page; use `ltrfile.cpp` + PyKotor)</a>
 */
public class Ltr extends KaitaiStruct {
    public static Ltr fromFile(String fileName) throws IOException {
        return new Ltr(new ByteBufferKaitaiStream(fileName));
    }

    public Ltr(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Ltr(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Ltr(KaitaiStream _io, KaitaiStruct _parent, Ltr _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        this.fileVersion = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        this.letterCount = BiowareCommon.BiowareLtrAlphabetLength.byId(this._io.readU1());
        this.singleLetterBlock = new LetterBlock(this._io, this, _root);
        this.doubleLetterBlocks = new DoubleLetterBlocksArray(this._io, this, _root);
        this.tripleLetterBlocks = new TripleLetterBlocksArray(this._io, this, _root);
    }

    public void _fetchInstances() {
        this.singleLetterBlock._fetchInstances();
        this.doubleLetterBlocks._fetchInstances();
        this.tripleLetterBlocks._fetchInstances();
    }

    /**
     * Array of double-letter blocks. One block per character in the alphabet.
     * Each block is indexed by the previous character (context length 1).
     */
    public static class DoubleLetterBlocksArray extends KaitaiStruct {
        public static DoubleLetterBlocksArray fromFile(String fileName) throws IOException {
            return new DoubleLetterBlocksArray(new ByteBufferKaitaiStream(fileName));
        }

        public DoubleLetterBlocksArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public DoubleLetterBlocksArray(KaitaiStream _io, Ltr _parent) {
            this(_io, _parent, null);
        }

        public DoubleLetterBlocksArray(KaitaiStream _io, Ltr _parent, Ltr _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.blocks = new ArrayList<LetterBlock>();
            for (int i = 0; i < _root().letterCount().id(); i++) {
                this.blocks.add(new LetterBlock(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.blocks.size(); i++) {
                this.blocks.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<LetterBlock> blocks;
        private Ltr _root;
        private Ltr _parent;

        /**
         * Array of letter_count blocks, each containing start/middle/end probability arrays.
         * Block index corresponds to the previous character in the alphabet.
         */
        public List<LetterBlock> blocks() { return blocks; }
        public Ltr _root() { return _root; }
        public Ltr _parent() { return _parent; }
    }

    /**
     * A probability block containing three arrays of probabilities (start, middle, end).
     * Each array has letter_count floats representing cumulative probabilities for each character
     * in the alphabet appearing at that position (start, middle, or end of name).
     * 
     * Blocks store cumulative probabilities (monotonically increasing floats) that are compared
     * against random roll values during name generation.
     */
    public static class LetterBlock extends KaitaiStruct {
        public static LetterBlock fromFile(String fileName) throws IOException {
            return new LetterBlock(new ByteBufferKaitaiStream(fileName));
        }

        public LetterBlock(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LetterBlock(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public LetterBlock(KaitaiStream _io, KaitaiStruct _parent, Ltr _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.startProbabilities = new ArrayList<Float>();
            for (int i = 0; i < _root().letterCount().id(); i++) {
                this.startProbabilities.add(this._io.readF4le());
            }
            this.middleProbabilities = new ArrayList<Float>();
            for (int i = 0; i < _root().letterCount().id(); i++) {
                this.middleProbabilities.add(this._io.readF4le());
            }
            this.endProbabilities = new ArrayList<Float>();
            for (int i = 0; i < _root().letterCount().id(); i++) {
                this.endProbabilities.add(this._io.readF4le());
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.startProbabilities.size(); i++) {
            }
            for (int i = 0; i < this.middleProbabilities.size(); i++) {
            }
            for (int i = 0; i < this.endProbabilities.size(); i++) {
            }
        }
        private List<Float> startProbabilities;
        private List<Float> middleProbabilities;
        private List<Float> endProbabilities;
        private Ltr _root;
        private KaitaiStruct _parent;

        /**
         * Array of start probabilities. One float per character in alphabet.
         * Probability of each letter starting a name (no context for singles,
         * after previous character for doubles, after previous two for triples).
         */
        public List<Float> startProbabilities() { return startProbabilities; }

        /**
         * Array of middle probabilities. One float per character in alphabet.
         * Probability of each letter appearing in the middle of a name.
         */
        public List<Float> middleProbabilities() { return middleProbabilities; }

        /**
         * Array of end probabilities. One float per character in alphabet.
         * Probability of each letter ending a name.
         */
        public List<Float> endProbabilities() { return endProbabilities; }
        public Ltr _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
     * Each block is indexed by the previous two characters (context length 2).
     */
    public static class TripleLetterBlocksArray extends KaitaiStruct {
        public static TripleLetterBlocksArray fromFile(String fileName) throws IOException {
            return new TripleLetterBlocksArray(new ByteBufferKaitaiStream(fileName));
        }

        public TripleLetterBlocksArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public TripleLetterBlocksArray(KaitaiStream _io, Ltr _parent) {
            this(_io, _parent, null);
        }

        public TripleLetterBlocksArray(KaitaiStream _io, Ltr _parent, Ltr _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.rows = new ArrayList<TripleLetterRow>();
            for (int i = 0; i < _root().letterCount().id(); i++) {
                this.rows.add(new TripleLetterRow(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.rows.size(); i++) {
                this.rows.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<TripleLetterRow> rows;
        private Ltr _root;
        private Ltr _parent;

        /**
         * Array of letter_count rows, each containing letter_count blocks.
         * First index corresponds to the second-to-last character.
         * Second index corresponds to the last character.
         */
        public List<TripleLetterRow> rows() { return rows; }
        public Ltr _root() { return _root; }
        public Ltr _parent() { return _parent; }
    }

    /**
     * A row in the triple-letter blocks array. Contains letter_count blocks,
     * each indexed by the last character in the two-character context.
     */
    public static class TripleLetterRow extends KaitaiStruct {
        public static TripleLetterRow fromFile(String fileName) throws IOException {
            return new TripleLetterRow(new ByteBufferKaitaiStream(fileName));
        }

        public TripleLetterRow(KaitaiStream _io) {
            this(_io, null, null);
        }

        public TripleLetterRow(KaitaiStream _io, Ltr.TripleLetterBlocksArray _parent) {
            this(_io, _parent, null);
        }

        public TripleLetterRow(KaitaiStream _io, Ltr.TripleLetterBlocksArray _parent, Ltr _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.blocks = new ArrayList<LetterBlock>();
            for (int i = 0; i < _root().letterCount().id(); i++) {
                this.blocks.add(new LetterBlock(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.blocks.size(); i++) {
                this.blocks.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<LetterBlock> blocks;
        private Ltr _root;
        private Ltr.TripleLetterBlocksArray _parent;

        /**
         * Array of letter_count blocks, each containing start/middle/end probability arrays.
         * Block index corresponds to the last character in the two-character context.
         */
        public List<LetterBlock> blocks() { return blocks; }
        public Ltr _root() { return _root; }
        public Ltr.TripleLetterBlocksArray _parent() { return _parent; }
    }
    private String fileType;
    private String fileVersion;
    private BiowareCommon.BiowareLtrAlphabetLength letterCount;
    private LetterBlock singleLetterBlock;
    private DoubleLetterBlocksArray doubleLetterBlocks;
    private TripleLetterBlocksArray tripleLetterBlocks;
    private Ltr _root;
    private KaitaiStruct _parent;

    /**
     * File type signature. Must be "LTR " (space-padded) for LTR files.
     */
    public String fileType() { return fileType; }

    /**
     * File format version. Must be "V1.0" for LTR files.
     */
    public String fileVersion() { return fileVersion; }

    /**
     * Alphabet size (`u1`). Canonical enum: `formats/Common/bioware_common.ksy` → `bioware_ltr_alphabet_length`
     * (26 = NWN `a-z`; 28 = KotOR `a-z` + `'` + `-`). For `repeat-expr` counts use `letter_count.to_i` (Kaitai: enum → int, user guide section 6.4.5).
     */
    public BiowareCommon.BiowareLtrAlphabetLength letterCount() { return letterCount; }

    /**
     * Single-letter probability block (no context).
     * Used for generating the first character of names.
     * Contains start/middle/end probability arrays, each with letter_count floats.
     * Total size: letter_count × 3 × 4 bytes = 336 bytes for KotOR (28 chars).
     */
    public LetterBlock singleLetterBlock() { return singleLetterBlock; }

    /**
     * Double-letter probability blocks (1-character context).
     * Array of letter_count blocks, each indexed by the previous character.
     * Used for generating the second character based on the first character.
     * Each block contains start/middle/end probability arrays.
     * Total size: letter_count × 3 × letter_count × 4 bytes = 9,408 bytes for KotOR.
     */
    public DoubleLetterBlocksArray doubleLetterBlocks() { return doubleLetterBlocks; }

    /**
     * Triple-letter probability blocks (2-character context).
     * Two-dimensional array of letter_count × letter_count blocks.
     * Each block is indexed by the previous two characters.
     * Used for generating third and subsequent characters.
     * Each block contains start/middle/end probability arrays.
     * Total size: letter_count × letter_count × 3 × letter_count × 4 bytes = 73,472 bytes for KotOR.
     */
    public TripleLetterBlocksArray tripleLetterBlocks() { return tripleLetterBlocks; }
    public Ltr _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
