# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **DAS** (Dragon Age: Origins save): Eclipse binary save — `DAS ` signature, `version==1`, length-prefixed strings +
# tagged blocks. **Not KotOR** — reference serializers live under **Andastra** `Game/Games/Eclipse/...` on GitHub (`meta.xref`), not `Runtime/...`.
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408 xoreos — `GameID` (`kGameIDDragonAge` = 7)
# @see https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAgeOrigins/Save/DragonAgeOriginsSaveSerializer.cs#L23-L180 Andastra — `DragonAgeOriginsSaveSerializer` (signature + nfo + archive entrypoints)
# @see https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126 Andastra — `EclipseSaveSerializer` string + metadata helpers
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (DAO saves via Andastra; no DAS-specific PDF here)
class Das < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @signature = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotEqualError.new("DAS ", @signature, @_io, "/seq/0") if not @signature == "DAS "
    @version = @_io.read_s4le
    raise Kaitai::Struct::ValidationNotEqualError.new(1, @version, @_io, "/seq/1") if not @version == 1
    @save_name = LengthPrefixedString.new(@_io, self, @_root)
    @module_name = LengthPrefixedString.new(@_io, self, @_root)
    @area_name = LengthPrefixedString.new(@_io, self, @_root)
    @time_played_seconds = @_io.read_s4le
    @timestamp_filetime = @_io.read_s8le
    @num_screenshot_data = @_io.read_s4le
    if num_screenshot_data > 0
      @screenshot_data = []
      (num_screenshot_data).times { |i|
        @screenshot_data << @_io.read_u1
      }
    end
    @num_portrait_data = @_io.read_s4le
    if num_portrait_data > 0
      @portrait_data = []
      (num_portrait_data).times { |i|
        @portrait_data << @_io.read_u1
      }
    end
    @player_name = LengthPrefixedString.new(@_io, self, @_root)
    @party_member_count = @_io.read_s4le
    @player_level = @_io.read_s4le
    self
  end
  class LengthPrefixedString < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @length = @_io.read_s4le
      @value = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(length), 0, false)).force_encoding("UTF-8")
      self
    end

    ##
    # String value.
    # Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
    def value_trimmed
      return @value_trimmed unless @value_trimmed.nil?
      @value_trimmed = value
      @value_trimmed
    end

    ##
    # String length in bytes (UTF-8 encoding).
    # Must be >= 0 and <= 65536 (sanity check).
    attr_reader :length

    ##
    # String value (UTF-8 encoded)
    attr_reader :value
  end

  ##
  # File signature. Must be "DAS " for Dragon Age: Origins save files.
  attr_reader :signature

  ##
  # Save format version. Must be 1 for Dragon Age: Origins.
  attr_reader :version

  ##
  # User-entered save name displayed in UI
  attr_reader :save_name

  ##
  # Current module resource name
  attr_reader :module_name

  ##
  # Current area name for display
  attr_reader :area_name

  ##
  # Total play time in seconds
  attr_reader :time_played_seconds

  ##
  # Save creation timestamp as Windows FILETIME (int64).
  # Convert using DateTime.FromFileTime().
  attr_reader :timestamp_filetime

  ##
  # Length of screenshot data in bytes (0 if no screenshot)
  attr_reader :num_screenshot_data

  ##
  # Screenshot image data (typically TGA or DDS format)
  attr_reader :screenshot_data

  ##
  # Length of portrait data in bytes (0 if no portrait)
  attr_reader :num_portrait_data

  ##
  # Portrait image data (typically TGA or DDS format)
  attr_reader :portrait_data

  ##
  # Player character name
  attr_reader :player_name

  ##
  # Number of party members (from PartyState)
  attr_reader :party_member_count

  ##
  # Player character level (from PartyState.PlayerCharacter)
  attr_reader :player_level
end
