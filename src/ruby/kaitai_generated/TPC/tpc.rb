# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_common'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
# (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
# (`meta.xref`).
# @see https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — TPC
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303 PyKotor — `TPCBinaryReader` + `load`
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120 PyKotor — `TPCTextureFormat` (opening)
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520 PyKotor — `class TPC` (opening)
# @see https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105 reone — `TpcReader` (body + TXI features)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L183 xoreos — `kFileTypeTPC`
# @see https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L362 xoreos — `TPC::load` through `readTXI` entrypoints
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts#L290-L380 KotOR.js — `TPCObject.readHeader`
class Tpc < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = TpcHeader.new(@_io, self, @_root)
    @body = @_io.read_bytes_full
    self
  end
  class TpcHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @data_size = @_io.read_u4le
      @alpha_test = @_io.read_f4le
      @width = @_io.read_u2le
      @height = @_io.read_u2le
      @pixel_encoding = Kaitai::Struct::Stream::resolve_enum(BiowareCommon::BIOWARE_TPC_PIXEL_FORMAT_ID, @_io.read_u1)
      @mipmap_count = @_io.read_u1
      @reserved = []
      (114).times { |i|
        @reserved << @_io.read_u1
      }
      self
    end

    ##
    # True if texture data is compressed (DXT format)
    def is_compressed
      return @is_compressed unless @is_compressed.nil?
      @is_compressed = data_size != 0
      @is_compressed
    end

    ##
    # True if texture data is uncompressed (raw pixels)
    def is_uncompressed
      return @is_uncompressed unless @is_uncompressed.nil?
      @is_uncompressed = data_size == 0
      @is_uncompressed
    end

    ##
    # Total compressed payload size. If non-zero, texture is compressed (DXT).
    # If zero, texture is uncompressed and size is derived from format/width/height.
    attr_reader :data_size

    ##
    # Float threshold used by punch-through rendering.
    # Commonly 0.0 or 0.5.
    attr_reader :alpha_test

    ##
    # Texture width in pixels (uint16).
    # Must be power-of-two for compressed formats.
    attr_reader :width

    ##
    # Texture height in pixels (uint16).
    # For cube maps, this is 6x the face width.
    # Must be power-of-two for compressed formats.
    attr_reader :height

    ##
    # Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
    # `bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).
    attr_reader :pixel_encoding

    ##
    # Number of mip levels per layer (minimum 1).
    # Each mip level is half the size of the previous level.
    attr_reader :mipmap_count

    ##
    # Reserved/padding bytes (0x72 = 114 bytes).
    # KotOR stores platform hints here but all implementations skip them.
    attr_reader :reserved
  end

  ##
  # TPC file header (128 bytes total)
  attr_reader :header

  ##
  # Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).
  attr_reader :body
end
