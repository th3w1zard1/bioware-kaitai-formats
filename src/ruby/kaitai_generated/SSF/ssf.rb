# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# SSF (Sound Set File) files store sound string references (StrRefs) for character voice sets.
# Each SSF file contains exactly 28 sound slots, mapping to different game events and actions.
# 
# Binary Format:
# - Header (12 bytes): File type signature, version, and offset to sounds array (usually 12)
# - Sounds Array (112 bytes at sounds_offset): 28 uint32 values representing StrRefs (0xFFFFFFFF = -1 = no sound)
# 
# Vanilla KotOR SSFs are typically 136 bytes total: after the 28 StrRefs, many files append 12 bytes
# of 0xFFFFFFFF padding; that trailer is not part of the header and is not modeled here.
# 
# Sound Slots (in order):
# 0-5: Battle Cry 1-6
# 6-8: Select 1-3
# 9-11: Attack Grunt 1-3
# 12-13: Pain Grunt 1-2
# 14: Low Health
# 15: Dead
# 16: Critical Hit
# 17: Target Immune
# 18: Lay Mine
# 19: Disarm Mine
# 20: Begin Stealth
# 21: Begin Search
# 22: Begin Unlock
# 23: Unlock Failed
# 24: Unlock Success
# 25: Separated From Party
# 26: Rejoined Party
# 27: Poisoned
# 
# Authoritative implementations: `meta.xref` and `doc-ref` (PyKotor `io_ssf`, xoreos `ssffile.cpp`, xoreos-tools `ssf2xml` / `xml2ssf`, xoreos-docs `SSF_Format.pdf`, reone `SsfReader`).
# @see https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf PyKotor wiki — SSF
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf.py#L102-L166 PyKotor — `io_ssf` (Kaitai bridge + binary read/write)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L126 xoreos — `kFileTypeSSF`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L72-L141 xoreos — `SSFFile::load` + `readSSFHeader` + `readEntries`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L165-L170 xoreos — `readEntriesKotOR`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/ssf2xml.cpp#L51-L70 xoreos-tools — `ssf2xml` CLI
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/xml2ssf.cpp#L54-L75 xoreos-tools — `xml2ssf` CLI (`main`)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/xml/ssfdumper.cpp#L133-L167 xoreos-tools — `SSFDumper::dump` (XML mapping for `ssf2xml`)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/xml/ssfcreator.cpp#L38-L74 xoreos-tools — `SSFCreator::create` (XML mapping for `xml2ssf`)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/SSF_Format.pdf xoreos-docs — SSF_Format.pdf
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/ssfreader.cpp#L26-L32 reone — `SsfReader::load`
class Ssf < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotEqualError.new("SSF ", @file_type, @_io, "/seq/0") if not @file_type == "SSF "
    @file_version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotEqualError.new("V1.1", @file_version, @_io, "/seq/1") if not @file_version == "V1.1"
    @sounds_offset = @_io.read_u4le
    self
  end
  class SoundArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (28).times { |i|
        @entries << SoundEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of exactly 28 sound entries, one for each SSFSound enum value.
    # Each entry is a uint32 representing a StrRef (string reference).
    # Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
    # 
    # Entry indices map to SSFSound enum:
    # - 0-5: Battle Cry 1-6
    # - 6-8: Select 1-3
    # - 9-11: Attack Grunt 1-3
    # - 12-13: Pain Grunt 1-2
    # - 14: Low Health
    # - 15: Dead
    # - 16: Critical Hit
    # - 17: Target Immune
    # - 18: Lay Mine
    # - 19: Disarm Mine
    # - 20: Begin Stealth
    # - 21: Begin Search
    # - 22: Begin Unlock
    # - 23: Unlock Failed
    # - 24: Unlock Success
    # - 25: Separated From Party
    # - 26: Rejoined Party
    # - 27: Poisoned
    attr_reader :entries
  end
  class SoundEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @strref_raw = @_io.read_u4le
      self
    end

    ##
    # True if this entry represents "no sound" (0xFFFFFFFF).
    # False if this entry contains a valid StrRef value.
    def is_no_sound
      return @is_no_sound unless @is_no_sound.nil?
      @is_no_sound = strref_raw == 4294967295
      @is_no_sound
    end

    ##
    # Raw uint32 value representing the StrRef.
    # Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
    # All other values are valid StrRefs (typically 0-999999).
    # The conversion from 0xFFFFFFFF to -1 is handled by SSFBinaryReader.ReadInt32MaxNeg1().
    attr_reader :strref_raw
  end

  ##
  # Array of 28 sound string references (StrRefs)
  def sounds
    return @sounds unless @sounds.nil?
    _pos = @_io.pos
    @_io.seek(sounds_offset)
    @sounds = SoundArray.new(@_io, self, @_root)
    @_io.seek(_pos)
    @sounds
  end

  ##
  # File type signature. Must be "SSF " (space-padded).
  # Bytes: 0x53 0x53 0x46 0x20
  attr_reader :file_type

  ##
  # File format version. Always "V1.1" for KotOR SSF files.
  # Bytes: 0x56 0x31 0x2E 0x31
  attr_reader :file_version

  ##
  # Byte offset to the sounds array from the beginning of the file.
  # KotOR files almost always use 12 (0x0C) so the table follows the header immediately, but the
  # field is a real offset; readers must seek here instead of assuming 12.
  attr_reader :sounds_offset
end
