# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_common'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
# (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.
# 
# BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.
# @see https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds PyKotor wiki — DDS
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130 PyKotor — `TPCDDSReader` / `io_dds`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L98 xoreos — `kFileTypeDDS`
# @see https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L55-L67 xoreos — `dds.cpp` load entry
# @see https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L141-L210 xoreos — BioWare headerless / Microsoft DDS branches
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/images/dds.cpp#L69-L158 xoreos-tools — `dds.cpp` (image tooling)
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree (texture-adjacent PDFs)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (engine texture pipeline context)
# @see https://github.com/lachjames/NorthernLights lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)
# @see https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L57 reone — `ResourceType::Dds` (type id; TPC path in `tpcreader.cpp`)
class Dds < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @magic = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotAnyOfError.new(@magic, @_io, "/seq/0") if not  ((@magic == "DDS ") || (@magic == "    ")) 
    if magic == "DDS "
      @header = DdsHeader.new(@_io, self, @_root)
    end
    if magic != "DDS "
      @bioware_header = BiowareDdsHeader.new(@_io, self, @_root)
    end
    @pixel_data = @_io.read_bytes_full
    self
  end
  class BiowareDdsHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @width = @_io.read_u4le
      @height = @_io.read_u4le
      @bytes_per_pixel = Kaitai::Struct::Stream::resolve_enum(BiowareCommon::BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL, @_io.read_u4le)
      @data_size = @_io.read_u4le
      @unused_float = @_io.read_f4le
      self
    end

    ##
    # Image width in pixels (must be power of two, < 0x8000)
    attr_reader :width

    ##
    # Image height in pixels (must be power of two, < 0x8000)
    attr_reader :height

    ##
    # BioWare variant "bytes per pixel" (`u4`): DXT1 vs DXT5 block stride hint. Canonical: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
    attr_reader :bytes_per_pixel

    ##
    # Total compressed data size.
    # Must match (width*height)/2 for DXT1 or width*height for DXT5
    attr_reader :data_size

    ##
    # Unused float field (typically 0.0)
    attr_reader :unused_float
  end
  class Ddpixelformat < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @size = @_io.read_u4le
      raise Kaitai::Struct::ValidationNotEqualError.new(32, @size, @_io, "/types/ddpixelformat/seq/0") if not @size == 32
      @flags = @_io.read_u4le
      @fourcc = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      @rgb_bit_count = @_io.read_u4le
      @r_bit_mask = @_io.read_u4le
      @g_bit_mask = @_io.read_u4le
      @b_bit_mask = @_io.read_u4le
      @a_bit_mask = @_io.read_u4le
      self
    end

    ##
    # Structure size (must be 32)
    attr_reader :size

    ##
    # Pixel format flags:
    # - 0x00000001 = DDPF_ALPHAPIXELS
    # - 0x00000002 = DDPF_ALPHA
    # - 0x00000004 = DDPF_FOURCC
    # - 0x00000040 = DDPF_RGB
    # - 0x00000200 = DDPF_YUV
    # - 0x00080000 = DDPF_LUMINANCE
    attr_reader :flags

    ##
    # Four-character code for compressed formats:
    # - "DXT1" = DXT1 compression
    # - "DXT3" = DXT3 compression
    # - "DXT5" = DXT5 compression
    # - "    " = Uncompressed format
    attr_reader :fourcc

    ##
    # Bits per pixel for uncompressed formats (16, 24, or 32)
    attr_reader :rgb_bit_count

    ##
    # Red channel bit mask (for uncompressed formats)
    attr_reader :r_bit_mask

    ##
    # Green channel bit mask (for uncompressed formats)
    attr_reader :g_bit_mask

    ##
    # Blue channel bit mask (for uncompressed formats)
    attr_reader :b_bit_mask

    ##
    # Alpha channel bit mask (for uncompressed formats)
    attr_reader :a_bit_mask
  end
  class DdsHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @size = @_io.read_u4le
      raise Kaitai::Struct::ValidationNotEqualError.new(124, @size, @_io, "/types/dds_header/seq/0") if not @size == 124
      @flags = @_io.read_u4le
      @height = @_io.read_u4le
      @width = @_io.read_u4le
      @pitch_or_linear_size = @_io.read_u4le
      @depth = @_io.read_u4le
      @mipmap_count = @_io.read_u4le
      @reserved1 = []
      (11).times { |i|
        @reserved1 << @_io.read_u4le
      }
      @pixel_format = Ddpixelformat.new(@_io, self, @_root)
      @caps = @_io.read_u4le
      @caps2 = @_io.read_u4le
      @caps3 = @_io.read_u4le
      @caps4 = @_io.read_u4le
      @reserved2 = @_io.read_u4le
      self
    end

    ##
    # Header size (must be 124)
    attr_reader :size

    ##
    # DDS flags bitfield:
    # - 0x00001007 = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT
    # - 0x00020000 = DDSD_MIPMAPCOUNT (if mipmaps present)
    attr_reader :flags

    ##
    # Image height in pixels
    attr_reader :height

    ##
    # Image width in pixels
    attr_reader :width

    ##
    # Pitch (uncompressed) or linear size (compressed).
    # For compressed formats: total size of all mip levels
    attr_reader :pitch_or_linear_size

    ##
    # Depth for volume textures (usually 0 for 2D textures)
    attr_reader :depth

    ##
    # Number of mipmap levels (0 or 1 = no mipmaps)
    attr_reader :mipmap_count

    ##
    # Reserved fields (unused)
    attr_reader :reserved1

    ##
    # Pixel format structure
    attr_reader :pixel_format

    ##
    # Capability flags:
    # - 0x00001000 = DDSCAPS_TEXTURE
    # - 0x00000008 = DDSCAPS_MIPMAP
    # - 0x00000200 = DDSCAPS2_CUBEMAP
    attr_reader :caps

    ##
    # Additional capability flags:
    # - 0x00000200 = DDSCAPS2_CUBEMAP
    # - 0x00000FC00 = Cube map face flags
    attr_reader :caps2

    ##
    # Reserved capability flags
    attr_reader :caps3

    ##
    # Reserved capability flags
    attr_reader :caps4

    ##
    # Reserved field
    attr_reader :reserved2
  end

  ##
  # File magic. Either "DDS " (0x44445320) for standard DDS,
  # or check for BioWare variant (no magic, starts with width/height).
  attr_reader :magic

  ##
  # Standard DDS header (124 bytes) - only present if magic is "DDS "
  attr_reader :header

  ##
  # BioWare DDS variant header - only present if magic is not "DDS "
  attr_reader :bioware_header

  ##
  # Pixel data (compressed or uncompressed); single blob to EOF.
  # For standard DDS: format determined by DDPIXELFORMAT.
  # For BioWare DDS: DXT1 or DXT5 compressed data.
  attr_reader :pixel_data
end
