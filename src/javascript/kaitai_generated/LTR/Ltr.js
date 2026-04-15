// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareCommon'));
  } else {
    factory(root.Ltr || (root.Ltr = {}), root.KaitaiStream, root.BiowareCommon || (root.BiowareCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Ltr_, KaitaiStream, BiowareCommon_) {
/**
 * **LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
 * `letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
 * `bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format|PyKotor wiki — LTR}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ltr/io_ltr.py#L44-L155|PyKotor — `io_ltr` reader/writer (start of `write`)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L101|xoreos — `kFileTypeLTR`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L121-L133|xoreos — `LTRFile::readLetterSet`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L135-L168|xoreos — `LTRFile::load`}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/resource/format/ltrreader.cpp#L27-L74|reone — `LtrReader::load` + `readLetterSet`}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LTRObject.ts#L51-L122|KotOR.js — `LTRObject.readBuffer`}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs tree (no dedicated LTR Torlack page; use `ltrfile.cpp` + PyKotor)}
 */

var Ltr = (function() {
  function Ltr(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Ltr.prototype._read = function() {
    this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    this.letterCount = this._io.readU1();
    this.singleLetterBlock = new LetterBlock(this._io, this, this._root);
    this.doubleLetterBlocks = new DoubleLetterBlocksArray(this._io, this, this._root);
    this.tripleLetterBlocks = new TripleLetterBlocksArray(this._io, this, this._root);
  }

  /**
   * Array of double-letter blocks. One block per character in the alphabet.
   * Each block is indexed by the previous character (context length 1).
   */

  var DoubleLetterBlocksArray = Ltr.DoubleLetterBlocksArray = (function() {
    function DoubleLetterBlocksArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    DoubleLetterBlocksArray.prototype._read = function() {
      this.blocks = [];
      for (var i = 0; i < this._root.letterCount; i++) {
        this.blocks.push(new LetterBlock(this._io, this, this._root));
      }
    }

    /**
     * Array of letter_count blocks, each containing start/middle/end probability arrays.
     * Block index corresponds to the previous character in the alphabet.
     */

    return DoubleLetterBlocksArray;
  })();

  /**
   * A probability block containing three arrays of probabilities (start, middle, end).
   * Each array has letter_count floats representing cumulative probabilities for each character
   * in the alphabet appearing at that position (start, middle, or end of name).
   * 
   * Blocks store cumulative probabilities (monotonically increasing floats) that are compared
   * against random roll values during name generation.
   */

  var LetterBlock = Ltr.LetterBlock = (function() {
    function LetterBlock(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LetterBlock.prototype._read = function() {
      this.startProbabilities = [];
      for (var i = 0; i < this._root.letterCount; i++) {
        this.startProbabilities.push(this._io.readF4le());
      }
      this.middleProbabilities = [];
      for (var i = 0; i < this._root.letterCount; i++) {
        this.middleProbabilities.push(this._io.readF4le());
      }
      this.endProbabilities = [];
      for (var i = 0; i < this._root.letterCount; i++) {
        this.endProbabilities.push(this._io.readF4le());
      }
    }

    /**
     * Array of start probabilities. One float per character in alphabet.
     * Probability of each letter starting a name (no context for singles,
     * after previous character for doubles, after previous two for triples).
     */

    /**
     * Array of middle probabilities. One float per character in alphabet.
     * Probability of each letter appearing in the middle of a name.
     */

    /**
     * Array of end probabilities. One float per character in alphabet.
     * Probability of each letter ending a name.
     */

    return LetterBlock;
  })();

  /**
   * Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
   * Each block is indexed by the previous two characters (context length 2).
   */

  var TripleLetterBlocksArray = Ltr.TripleLetterBlocksArray = (function() {
    function TripleLetterBlocksArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    TripleLetterBlocksArray.prototype._read = function() {
      this.rows = [];
      for (var i = 0; i < this._root.letterCount; i++) {
        this.rows.push(new TripleLetterRow(this._io, this, this._root));
      }
    }

    /**
     * Array of letter_count rows, each containing letter_count blocks.
     * First index corresponds to the second-to-last character.
     * Second index corresponds to the last character.
     */

    return TripleLetterBlocksArray;
  })();

  /**
   * A row in the triple-letter blocks array. Contains letter_count blocks,
   * each indexed by the last character in the two-character context.
   */

  var TripleLetterRow = Ltr.TripleLetterRow = (function() {
    function TripleLetterRow(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    TripleLetterRow.prototype._read = function() {
      this.blocks = [];
      for (var i = 0; i < this._root.letterCount; i++) {
        this.blocks.push(new LetterBlock(this._io, this, this._root));
      }
    }

    /**
     * Array of letter_count blocks, each containing start/middle/end probability arrays.
     * Block index corresponds to the last character in the two-character context.
     */

    return TripleLetterRow;
  })();

  /**
   * File type signature. Must be "LTR " (space-padded) for LTR files.
   */

  /**
   * File format version. Must be "V1.0" for LTR files.
   */

  /**
   * Alphabet size (`u1`). Canonical enum: `formats/Common/bioware_common.ksy` → `bioware_ltr_alphabet_length`
   * (26 = NWN `a-z`; 28 = KotOR `a-z` + `'` + `-`). For `repeat-expr` counts use `letter_count.to_i` (Kaitai: enum → int, user guide section 6.4.5).
   */

  /**
   * Single-letter probability block (no context).
   * Used for generating the first character of names.
   * Contains start/middle/end probability arrays, each with letter_count floats.
   * Total size: letter_count × 3 × 4 bytes = 336 bytes for KotOR (28 chars).
   */

  /**
   * Double-letter probability blocks (1-character context).
   * Array of letter_count blocks, each indexed by the previous character.
   * Used for generating the second character based on the first character.
   * Each block contains start/middle/end probability arrays.
   * Total size: letter_count × 3 × letter_count × 4 bytes = 9,408 bytes for KotOR.
   */

  /**
   * Triple-letter probability blocks (2-character context).
   * Two-dimensional array of letter_count × letter_count blocks.
   * Each block is indexed by the previous two characters.
   * Used for generating third and subsequent characters.
   * Each block contains start/middle/end probability arrays.
   * Total size: letter_count × letter_count × 3 × letter_count × 4 bytes = 73,472 bytes for KotOR.
   */

  return Ltr;
})();
Ltr_.Ltr = Ltr;
});
