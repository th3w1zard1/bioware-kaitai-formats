# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_common'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
# `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
# 
# xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
# @see https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP
# @see https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L42 reone — LIPReader
class Lip < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    @file_version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    @length = @_io.read_f4le
    @num_keyframes = @_io.read_u4le
    @keyframes = []
    (num_keyframes).times { |i|
      @keyframes << KeyframeEntry.new(@_io, self, @_root)
    }
    self
  end

  ##
  # A single keyframe entry mapping a timestamp to a viseme (mouth shape).
  # Keyframes are used by the engine to interpolate between mouth shapes during
  # audio playback to create lip sync animation.
  class KeyframeEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @timestamp = @_io.read_f4le
      @shape = Kaitai::Struct::Stream::resolve_enum(BiowareCommon::BIOWARE_LIP_VISEME_ID, @_io.read_u1)
      self
    end

    ##
    # Seconds from animation start. Must be >= 0 and <= length.
    # Keyframes should be sorted ascending by timestamp.
    attr_reader :timestamp

    ##
    # Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
    # `bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).
    attr_reader :shape
  end

  ##
  # File type signature. Must be "LIP " (space-padded) for LIP files.
  attr_reader :file_type

  ##
  # File format version. Must be "V1.0" for LIP files.
  attr_reader :file_version

  ##
  # Duration in seconds. Must equal the paired WAV file playback time for
  # glitch-free animation. This is the total length of the lip sync animation.
  attr_reader :length

  ##
  # Number of keyframes immediately following. Each keyframe contains a timestamp
  # and a viseme shape index. Keyframes should be sorted ascending by timestamp.
  attr_reader :num_keyframes

  ##
  # Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
  # Entries must be stored in chronological order (ascending by timestamp).
  attr_reader :keyframes
end
