# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_common'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
# `letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
# `bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).
# @see https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format PyKotor wiki — LTR
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L135-L168 xoreos — LTR::load
class Ltr < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    @file_version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    @letter_count = Kaitai::Struct::Stream::resolve_enum(BiowareCommon::BIOWARE_LTR_ALPHABET_LENGTH, @_io.read_u1)
    @single_letter_block = LetterBlock.new(@_io, self, @_root)
    @double_letter_blocks = DoubleLetterBlocksArray.new(@_io, self, @_root)
    @triple_letter_blocks = TripleLetterBlocksArray.new(@_io, self, @_root)
    self
  end

  ##
  # Array of double-letter blocks. One block per character in the alphabet.
  # Each block is indexed by the previous character (context length 1).
  class DoubleLetterBlocksArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @blocks = []
      ((BiowareCommon::I__BIOWARE_LTR_ALPHABET_LENGTH[_root.letter_count] || _root.letter_count)).times { |i|
        @blocks << LetterBlock.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of letter_count blocks, each containing start/middle/end probability arrays.
    # Block index corresponds to the previous character in the alphabet.
    attr_reader :blocks
  end

  ##
  # A probability block containing three arrays of probabilities (start, middle, end).
  # Each array has letter_count floats representing cumulative probabilities for each character
  # in the alphabet appearing at that position (start, middle, or end of name).
  # 
  # Blocks store cumulative probabilities (monotonically increasing floats) that are compared
  # against random roll values during name generation.
  class LetterBlock < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @start_probabilities = []
      ((BiowareCommon::I__BIOWARE_LTR_ALPHABET_LENGTH[_root.letter_count] || _root.letter_count)).times { |i|
        @start_probabilities << @_io.read_f4le
      }
      @middle_probabilities = []
      ((BiowareCommon::I__BIOWARE_LTR_ALPHABET_LENGTH[_root.letter_count] || _root.letter_count)).times { |i|
        @middle_probabilities << @_io.read_f4le
      }
      @end_probabilities = []
      ((BiowareCommon::I__BIOWARE_LTR_ALPHABET_LENGTH[_root.letter_count] || _root.letter_count)).times { |i|
        @end_probabilities << @_io.read_f4le
      }
      self
    end

    ##
    # Array of start probabilities. One float per character in alphabet.
    # Probability of each letter starting a name (no context for singles,
    # after previous character for doubles, after previous two for triples).
    attr_reader :start_probabilities

    ##
    # Array of middle probabilities. One float per character in alphabet.
    # Probability of each letter appearing in the middle of a name.
    attr_reader :middle_probabilities

    ##
    # Array of end probabilities. One float per character in alphabet.
    # Probability of each letter ending a name.
    attr_reader :end_probabilities
  end

  ##
  # Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
  # Each block is indexed by the previous two characters (context length 2).
  class TripleLetterBlocksArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @rows = []
      ((BiowareCommon::I__BIOWARE_LTR_ALPHABET_LENGTH[_root.letter_count] || _root.letter_count)).times { |i|
        @rows << TripleLetterRow.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of letter_count rows, each containing letter_count blocks.
    # First index corresponds to the second-to-last character.
    # Second index corresponds to the last character.
    attr_reader :rows
  end

  ##
  # A row in the triple-letter blocks array. Contains letter_count blocks,
  # each indexed by the last character in the two-character context.
  class TripleLetterRow < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @blocks = []
      ((BiowareCommon::I__BIOWARE_LTR_ALPHABET_LENGTH[_root.letter_count] || _root.letter_count)).times { |i|
        @blocks << LetterBlock.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of letter_count blocks, each containing start/middle/end probability arrays.
    # Block index corresponds to the last character in the two-character context.
    attr_reader :blocks
  end

  ##
  # File type signature. Must be "LTR " (space-padded) for LTR files.
  attr_reader :file_type

  ##
  # File format version. Must be "V1.0" for LTR files.
  attr_reader :file_version

  ##
  # Alphabet size (`u1`). Canonical enum: `formats/Common/bioware_common.ksy` → `bioware_ltr_alphabet_length`
  # (26 = NWN `a-z`; 28 = KotOR `a-z` + `'` + `-`). For `repeat-expr` counts use `letter_count.to_i` (Kaitai: enum → int, user guide §6.4.5).
  attr_reader :letter_count

  ##
  # Single-letter probability block (no context).
  # Used for generating the first character of names.
  # Contains start/middle/end probability arrays, each with letter_count floats.
  # Total size: letter_count × 3 × 4 bytes = 336 bytes for KotOR (28 chars).
  attr_reader :single_letter_block

  ##
  # Double-letter probability blocks (1-character context).
  # Array of letter_count blocks, each indexed by the previous character.
  # Used for generating the second character based on the first character.
  # Each block contains start/middle/end probability arrays.
  # Total size: letter_count × 3 × letter_count × 4 bytes = 9,408 bytes for KotOR.
  attr_reader :double_letter_blocks

  ##
  # Triple-letter probability blocks (2-character context).
  # Two-dimensional array of letter_count × letter_count blocks.
  # Each block is indexed by the previous two characters.
  # Used for generating third and subsequent characters.
  # Each block contains start/middle/end probability arrays.
  # Total size: letter_count × letter_count × 3 × letter_count × 4 bytes = 73,472 bytes for KotOR.
  attr_reader :triple_letter_blocks
end
