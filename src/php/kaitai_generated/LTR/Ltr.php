<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
 * `letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
 * `bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).
 */

namespace {
    class Ltr extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Ltr $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_fileVersion = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_letterCount = $this->_io->readU1();
            $this->_m_singleLetterBlock = new \Ltr\LetterBlock($this->_io, $this, $this->_root);
            $this->_m_doubleLetterBlocks = new \Ltr\DoubleLetterBlocksArray($this->_io, $this, $this->_root);
            $this->_m_tripleLetterBlocks = new \Ltr\TripleLetterBlocksArray($this->_io, $this, $this->_root);
        }
        protected $_m_fileType;
        protected $_m_fileVersion;
        protected $_m_letterCount;
        protected $_m_singleLetterBlock;
        protected $_m_doubleLetterBlocks;
        protected $_m_tripleLetterBlocks;

        /**
         * File type signature. Must be "LTR " (space-padded) for LTR files.
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. Must be "V1.0" for LTR files.
         */
        public function fileVersion() { return $this->_m_fileVersion; }

        /**
         * Alphabet size (`u1`). Canonical enum: `formats/Common/bioware_common.ksy` → `bioware_ltr_alphabet_length`
         * (26 = NWN `a-z`; 28 = KotOR `a-z` + `'` + `-`). For `repeat-expr` counts use `letter_count.to_i` (Kaitai: enum → int, user guide section 6.4.5).
         */
        public function letterCount() { return $this->_m_letterCount; }

        /**
         * Single-letter probability block (no context).
         * Used for generating the first character of names.
         * Contains start/middle/end probability arrays, each with letter_count floats.
         * Total size: letter_count × 3 × 4 bytes = 336 bytes for KotOR (28 chars).
         */
        public function singleLetterBlock() { return $this->_m_singleLetterBlock; }

        /**
         * Double-letter probability blocks (1-character context).
         * Array of letter_count blocks, each indexed by the previous character.
         * Used for generating the second character based on the first character.
         * Each block contains start/middle/end probability arrays.
         * Total size: letter_count × 3 × letter_count × 4 bytes = 9,408 bytes for KotOR.
         */
        public function doubleLetterBlocks() { return $this->_m_doubleLetterBlocks; }

        /**
         * Triple-letter probability blocks (2-character context).
         * Two-dimensional array of letter_count × letter_count blocks.
         * Each block is indexed by the previous two characters.
         * Used for generating third and subsequent characters.
         * Each block contains start/middle/end probability arrays.
         * Total size: letter_count × letter_count × 3 × letter_count × 4 bytes = 73,472 bytes for KotOR.
         */
        public function tripleLetterBlocks() { return $this->_m_tripleLetterBlocks; }
    }
}

/**
 * Array of double-letter blocks. One block per character in the alphabet.
 * Each block is indexed by the previous character (context length 1).
 */

namespace Ltr {
    class DoubleLetterBlocksArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Ltr $_parent = null, ?\Ltr $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_blocks = [];
            $n = $this->_root()->letterCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_blocks[] = new \Ltr\LetterBlock($this->_io, $this, $this->_root);
            }
        }
        protected $_m_blocks;

        /**
         * Array of letter_count blocks, each containing start/middle/end probability arrays.
         * Block index corresponds to the previous character in the alphabet.
         */
        public function blocks() { return $this->_m_blocks; }
    }
}

/**
 * A probability block containing three arrays of probabilities (start, middle, end).
 * Each array has letter_count floats representing cumulative probabilities for each character
 * in the alphabet appearing at that position (start, middle, or end of name).
 * 
 * Blocks store cumulative probabilities (monotonically increasing floats) that are compared
 * against random roll values during name generation.
 */

namespace Ltr {
    class LetterBlock extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Ltr $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_startProbabilities = [];
            $n = $this->_root()->letterCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_startProbabilities[] = $this->_io->readF4le();
            }
            $this->_m_middleProbabilities = [];
            $n = $this->_root()->letterCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_middleProbabilities[] = $this->_io->readF4le();
            }
            $this->_m_endProbabilities = [];
            $n = $this->_root()->letterCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_endProbabilities[] = $this->_io->readF4le();
            }
        }
        protected $_m_startProbabilities;
        protected $_m_middleProbabilities;
        protected $_m_endProbabilities;

        /**
         * Array of start probabilities. One float per character in alphabet.
         * Probability of each letter starting a name (no context for singles,
         * after previous character for doubles, after previous two for triples).
         */
        public function startProbabilities() { return $this->_m_startProbabilities; }

        /**
         * Array of middle probabilities. One float per character in alphabet.
         * Probability of each letter appearing in the middle of a name.
         */
        public function middleProbabilities() { return $this->_m_middleProbabilities; }

        /**
         * Array of end probabilities. One float per character in alphabet.
         * Probability of each letter ending a name.
         */
        public function endProbabilities() { return $this->_m_endProbabilities; }
    }
}

/**
 * Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
 * Each block is indexed by the previous two characters (context length 2).
 */

namespace Ltr {
    class TripleLetterBlocksArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Ltr $_parent = null, ?\Ltr $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_rows = [];
            $n = $this->_root()->letterCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_rows[] = new \Ltr\TripleLetterRow($this->_io, $this, $this->_root);
            }
        }
        protected $_m_rows;

        /**
         * Array of letter_count rows, each containing letter_count blocks.
         * First index corresponds to the second-to-last character.
         * Second index corresponds to the last character.
         */
        public function rows() { return $this->_m_rows; }
    }
}

/**
 * A row in the triple-letter blocks array. Contains letter_count blocks,
 * each indexed by the last character in the two-character context.
 */

namespace Ltr {
    class TripleLetterRow extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Ltr\TripleLetterBlocksArray $_parent = null, ?\Ltr $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_blocks = [];
            $n = $this->_root()->letterCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_blocks[] = new \Ltr\LetterBlock($this->_io, $this, $this->_root);
            }
        }
        protected $_m_blocks;

        /**
         * Array of letter_count blocks, each containing start/middle/end probability arrays.
         * Block index corresponds to the last character in the two-character context.
         */
        public function blocks() { return $this->_m_blocks; }
    }
}
