-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_common")
local str_decode = require("string_decode")

-- 
-- **LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
-- `letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
-- `bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).
-- See also: PyKotor wiki — LTR (https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format)
-- See also: xoreos — LTR::load (https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L135-L168)
Ltr = class.class(KaitaiStruct)

function Ltr:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Ltr:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.file_version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.letter_count = BiowareCommon.BiowareLtrAlphabetLength(self._io:read_u1())
  self.single_letter_block = Ltr.LetterBlock(self._io, self, self._root)
  self.double_letter_blocks = Ltr.DoubleLetterBlocksArray(self._io, self, self._root)
  self.triple_letter_blocks = Ltr.TripleLetterBlocksArray(self._io, self, self._root)
end

-- 
-- File type signature. Must be "LTR " (space-padded) for LTR files.
-- 
-- File format version. Must be "V1.0" for LTR files.
-- 
-- Alphabet size (`u1`). Canonical enum: `formats/Common/bioware_common.ksy` → `bioware_ltr_alphabet_length`
-- (26 = NWN `a-z`; 28 = KotOR `a-z` + `'` + `-`). For `repeat-expr` counts use `letter_count.to_i` (Kaitai: enum → int, user guide §6.4.5).
-- 
-- Single-letter probability block (no context).
-- Used for generating the first character of names.
-- Contains start/middle/end probability arrays, each with letter_count floats.
-- Total size: letter_count × 3 × 4 bytes = 336 bytes for KotOR (28 chars).
-- 
-- Double-letter probability blocks (1-character context).
-- Array of letter_count blocks, each indexed by the previous character.
-- Used for generating the second character based on the first character.
-- Each block contains start/middle/end probability arrays.
-- Total size: letter_count × 3 × letter_count × 4 bytes = 9,408 bytes for KotOR.
-- 
-- Triple-letter probability blocks (2-character context).
-- Two-dimensional array of letter_count × letter_count blocks.
-- Each block is indexed by the previous two characters.
-- Used for generating third and subsequent characters.
-- Each block contains start/middle/end probability arrays.
-- Total size: letter_count × letter_count × 3 × letter_count × 4 bytes = 73,472 bytes for KotOR.

-- 
-- Array of double-letter blocks. One block per character in the alphabet.
-- Each block is indexed by the previous character (context length 1).
Ltr.DoubleLetterBlocksArray = class.class(KaitaiStruct)

function Ltr.DoubleLetterBlocksArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Ltr.DoubleLetterBlocksArray:_read()
  self.blocks = {}
  for i = 0, self._root.letter_count.value - 1 do
    self.blocks[i + 1] = Ltr.LetterBlock(self._io, self, self._root)
  end
end

-- 
-- Array of letter_count blocks, each containing start/middle/end probability arrays.
-- Block index corresponds to the previous character in the alphabet.

-- 
-- A probability block containing three arrays of probabilities (start, middle, end).
-- Each array has letter_count floats representing cumulative probabilities for each character
-- in the alphabet appearing at that position (start, middle, or end of name).
-- 
-- Blocks store cumulative probabilities (monotonically increasing floats) that are compared
-- against random roll values during name generation.
Ltr.LetterBlock = class.class(KaitaiStruct)

function Ltr.LetterBlock:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Ltr.LetterBlock:_read()
  self.start_probabilities = {}
  for i = 0, self._root.letter_count.value - 1 do
    self.start_probabilities[i + 1] = self._io:read_f4le()
  end
  self.middle_probabilities = {}
  for i = 0, self._root.letter_count.value - 1 do
    self.middle_probabilities[i + 1] = self._io:read_f4le()
  end
  self.end_probabilities = {}
  for i = 0, self._root.letter_count.value - 1 do
    self.end_probabilities[i + 1] = self._io:read_f4le()
  end
end

-- 
-- Array of start probabilities. One float per character in alphabet.
-- Probability of each letter starting a name (no context for singles,
-- after previous character for doubles, after previous two for triples).
-- 
-- Array of middle probabilities. One float per character in alphabet.
-- Probability of each letter appearing in the middle of a name.
-- 
-- Array of end probabilities. One float per character in alphabet.
-- Probability of each letter ending a name.

-- 
-- Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
-- Each block is indexed by the previous two characters (context length 2).
Ltr.TripleLetterBlocksArray = class.class(KaitaiStruct)

function Ltr.TripleLetterBlocksArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Ltr.TripleLetterBlocksArray:_read()
  self.rows = {}
  for i = 0, self._root.letter_count.value - 1 do
    self.rows[i + 1] = Ltr.TripleLetterRow(self._io, self, self._root)
  end
end

-- 
-- Array of letter_count rows, each containing letter_count blocks.
-- First index corresponds to the second-to-last character.
-- Second index corresponds to the last character.

-- 
-- A row in the triple-letter blocks array. Contains letter_count blocks,
-- each indexed by the last character in the two-character context.
Ltr.TripleLetterRow = class.class(KaitaiStruct)

function Ltr.TripleLetterRow:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Ltr.TripleLetterRow:_read()
  self.blocks = {}
  for i = 0, self._root.letter_count.value - 1 do
    self.blocks[i + 1] = Ltr.LetterBlock(self._io, self, self._root)
  end
end

-- 
-- Array of letter_count blocks, each containing start/middle/end probability arrays.
-- Block index corresponds to the last character in the two-character context.

