# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# TLK (Talk Table) files contain all text strings used in the game, both written and spoken.
# They enable easy localization by providing a lookup table from string reference numbers (StrRef)
# to localized text and associated voice-over audio files.
# 
# Binary Format Structure:
# - File Header (20 bytes): File type signature, version, language ID, string count, entries offset
# - String Data Table (40 bytes per entry): Metadata for each string entry (flags, sound ResRef, offsets, lengths)
# - String Entries (variable size): Sequential null-terminated text strings starting at entries_offset
# 
# The format uses a two-level structure:
# 1. String Data Table: Contains metadata (flags, sound filename, text offset/length) for each entry
# 2. String Entries: Actual text data stored sequentially, referenced by offsets in the data table
# 
# String references (StrRef) are 0-based indices into the string_data_table array. StrRef 0 refers to
# the first entry, StrRef 1 to the second, etc. StrRef -1 indicates no string reference.
# 
# Authoritative index: `meta.xref` and `doc-ref` (PyKotor, xoreos `talktable*` + `talktable_tlk`, xoreos-tools CLIs, reone, KotOR.js, NickHugi/Kotor.NET). Legacy Perl / archived community URLs are omitted when they no longer resolve on GitHub.
# @see https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk PyKotor wiki — TLK
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk.py#L23-L196 PyKotor — `io_tlk` (sizes, Kaitai + legacy + write)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp#L35-L69 xoreos — `TalkTable::load` (factory dispatch)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L40-L114 xoreos — TLK id/version + `TalkTable_TLK::load` + V3/V4 entry tables
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L87 xoreos — `kFileTypeTLK`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73 xoreos — `Language` / `LanguageGender` (TLK `language_id` / substring packing)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/tlk2xml.cpp#L56-L80 xoreos-tools — `tlk2xml` CLI (`main`)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/xml2tlk.cpp#L58-L85 xoreos-tools — `xml2tlk` CLI (`main`)
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/tlkreader.cpp#L27-L67 reone — `TlkReader`
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TLKObject.ts#L16-L77 KotOR.js — `TLKObject`
# @see https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorTLK/TLKBinaryReader.cs NickHugi/Kotor.NET — `TLKBinaryReader`
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/TalkTable_Format.pdf xoreos-docs — TalkTable_Format.pdf
class Tlk < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = TlkHeader.new(@_io, self, @_root)
    @string_data_table = StringDataTable.new(@_io, self, @_root)
    self
  end
  class StringDataEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @flags = @_io.read_u4le
      @sound_resref = (@_io.read_bytes(16)).force_encoding("ASCII").encode('UTF-8')
      @volume_variance = @_io.read_u4le
      @pitch_variance = @_io.read_u4le
      @text_offset = @_io.read_u4le
      @text_length = @_io.read_u4le
      @sound_length = @_io.read_f4le
      self
    end

    ##
    # Size of each string_data_entry in bytes.
    # Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
    # text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.
    def entry_size
      return @entry_size unless @entry_size.nil?
      @entry_size = 40
      @entry_size
    end

    ##
    # Whether sound length is valid (bit 2 of flags)
    def sound_length_present
      return @sound_length_present unless @sound_length_present.nil?
      @sound_length_present = flags & 4 != 0
      @sound_length_present
    end

    ##
    # Whether voice-over audio exists (bit 1 of flags)
    def sound_present
      return @sound_present unless @sound_present.nil?
      @sound_present = flags & 2 != 0
      @sound_present
    end

    ##
    # Text string data as raw bytes (read as ASCII for byte-level access).
    # The actual encoding depends on the language_id in the header.
    # Common encodings:
    # - English/French/German/Italian/Spanish: Windows-1252 (cp1252)
    # - Polish: Windows-1250 (cp1250)
    # - Korean: EUC-KR (cp949)
    # - Chinese Traditional: Big5 (cp950)
    # - Chinese Simplified: GB2312 (cp936)
    # - Japanese: Shift-JIS (cp932)
    # 
    # Note: This field reads the raw bytes as ASCII string for byte-level access.
    # The application layer should decode based on the language_id field in the header.
    # To get raw bytes, access the underlying byte representation of this string.
    # 
    # In practice, strings are stored sequentially starting at entries_offset,
    # so text_offset values are relative to entries_offset (0, len1, len1+len2, etc.).
    # 
    # Strings may be null-terminated, but text_length includes the null terminator.
    # Application code should trim null bytes when decoding.
    # 
    # If text_present flag (bit 0) is not set, this field may contain garbage data
    # or be empty. Always check text_present before using this data.
    def text_data
      return @text_data unless @text_data.nil?
      _pos = @_io.pos
      @_io.seek(text_file_offset)
      @text_data = (@_io.read_bytes(text_length)).force_encoding("ASCII").encode('UTF-8')
      @_io.seek(_pos)
      @text_data
    end

    ##
    # Absolute file offset to the text string.
    # Calculated as entries_offset (from header) + text_offset (from entry).
    def text_file_offset
      return @text_file_offset unless @text_file_offset.nil?
      @text_file_offset = _root.header.entries_offset + text_offset
      @text_file_offset
    end

    ##
    # Whether text content exists (bit 0 of flags)
    def text_present
      return @text_present unless @text_present.nil?
      @text_present = flags & 1 != 0
      @text_present
    end

    ##
    # Bit flags indicating what data is present:
    # - bit 0 (0x0001): Text present - string has text content
    # - bit 1 (0x0002): Sound present - string has associated voice-over audio
    # - bit 2 (0x0004): Sound length present - sound length field is valid
    # 
    # Common flag combinations:
    # - 0x0001: Text only (menu options, item descriptions)
    # - 0x0003: Text + Sound (voiced dialog lines)
    # - 0x0007: Text + Sound + Length (fully voiced with duration)
    # - 0x0000: Empty entry (unused StrRef slots)
    attr_reader :flags

    ##
    # Voice-over audio filename (ResRef), null-terminated ASCII, max 16 chars.
    # If the string is shorter than 16 bytes, it is null-padded.
    # Empty string (all nulls) indicates no voice-over audio.
    attr_reader :sound_resref

    ##
    # Volume variance (unused in KotOR, always 0).
    # Legacy field from Neverwinter Nights, not used by KotOR engine.
    attr_reader :volume_variance

    ##
    # Pitch variance (unused in KotOR, always 0).
    # Legacy field from Neverwinter Nights, not used by KotOR engine.
    attr_reader :pitch_variance

    ##
    # Offset to string text relative to entries_offset.
    # The actual file offset is: header.entries_offset + text_offset.
    # First string starts at offset 0, subsequent strings follow sequentially.
    attr_reader :text_offset

    ##
    # Length of string text in bytes (not characters).
    # For single-byte encodings (Windows-1252, etc.), byte length equals character count.
    # For multi-byte encodings (UTF-8, etc.), byte length may be greater than character count.
    attr_reader :text_length

    ##
    # Duration of voice-over audio in seconds (float).
    # Only valid if sound_length_present flag (bit 2) is set.
    # Used by the engine to determine how long to wait before auto-advancing dialog.
    attr_reader :sound_length
  end
  class StringDataTable < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.string_count).times { |i|
        @entries << StringDataEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of string data entries, one per string in the file
    attr_reader :entries
  end
  class TlkHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      @file_version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      @language_id = @_io.read_u4le
      @string_count = @_io.read_u4le
      @entries_offset = @_io.read_u4le
      self
    end

    ##
    # Expected offset to string entries (header + string data table).
    # Used for validation.
    def expected_entries_offset
      return @expected_entries_offset unless @expected_entries_offset.nil?
      @expected_entries_offset = 20 + string_count * 40
      @expected_entries_offset
    end

    ##
    # Size of the TLK header in bytes
    def header_size
      return @header_size unless @header_size.nil?
      @header_size = 20
      @header_size
    end

    ##
    # File type signature. Must be "TLK " (space-padded).
    # Validates that this is a TLK file.
    # Note: Validation removed temporarily due to Kaitai Struct parser issues.
    attr_reader :file_type

    ##
    # File format version. "V3.0" for KotOR, "V4.0" for Jade Empire.
    # KotOR games use V3.0. Jade Empire uses V4.0.
    # Note: Validation removed due to Kaitai Struct parser limitations with period in string.
    attr_reader :file_version

    ##
    # Language identifier:
    # - 0 = English
    # - 1 = French
    # - 2 = German
    # - 3 = Italian
    # - 4 = Spanish
    # - 5 = Polish
    # - 128 = Korean
    # - 129 = Chinese Traditional
    # - 130 = Chinese Simplified
    # - 131 = Japanese
    # See Language enum for complete list.
    attr_reader :language_id

    ##
    # Number of string entries in the file.
    # Determines the number of entries in string_data_table.
    attr_reader :string_count

    ##
    # Byte offset to string entries array from the beginning of the file.
    # Typically 20 + (string_count * 40) = header size + string data table size.
    # Points to where the actual text strings begin.
    attr_reader :entries_offset
  end

  ##
  # TLK file header (20 bytes) - contains file signature, version, language, and counts
  attr_reader :header

  ##
  # Array of string data entries (metadata for each string) - 40 bytes per entry
  attr_reader :string_data_table
end
