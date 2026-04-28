# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'tga_common'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
# converts authoring TGAs to **TPC** for shipping.
# 
# Shared header enums: `formats/Common/tga_common.ksy`.
# @see https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — textures (TPC/TGA pipeline)
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40 PyKotor — compact TGA reader (`tga.py`)
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120 PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`)
# @see https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177 xoreos — `TGA::readHeader`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L241 xoreos-tools — `TGA::load` through `readRLE` (tooling reader)
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
# @see https://github.com/lachjames/NorthernLights lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)
class Tga < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @id_length = @_io.read_u1
    @color_map_type = Kaitai::Struct::Stream::resolve_enum(TgaCommon::TGA_COLOR_MAP_TYPE, @_io.read_u1)
    @image_type = Kaitai::Struct::Stream::resolve_enum(TgaCommon::TGA_IMAGE_TYPE, @_io.read_u1)
    if color_map_type == :tga_color_map_type_present
      @color_map_spec = ColorMapSpecification.new(@_io, self, @_root)
    end
    @image_spec = ImageSpecification.new(@_io, self, @_root)
    if id_length > 0
      @image_id = (@_io.read_bytes(id_length)).force_encoding("ASCII").encode('UTF-8')
    end
    if color_map_type == :tga_color_map_type_present
      @color_map_data = []
      (color_map_spec.length).times { |i|
        @color_map_data << @_io.read_u1
      }
    end
    @image_data = []
    i = 0
    while not @_io.eof?
      @image_data << @_io.read_u1
      i += 1
    end
    self
  end
  class ColorMapSpecification < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @first_entry_index = @_io.read_u2le
      @length = @_io.read_u2le
      @entry_size = @_io.read_u1
      self
    end

    ##
    # Index of first color map entry
    attr_reader :first_entry_index

    ##
    # Number of color map entries
    attr_reader :length

    ##
    # Size of each color map entry in bits (15, 16, 24, or 32)
    attr_reader :entry_size
  end
  class ImageSpecification < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @x_origin = @_io.read_u2le
      @y_origin = @_io.read_u2le
      @width = @_io.read_u2le
      @height = @_io.read_u2le
      @pixel_depth = @_io.read_u1
      @image_descriptor = @_io.read_u1
      self
    end

    ##
    # X coordinate of lower-left corner of image
    attr_reader :x_origin

    ##
    # Y coordinate of lower-left corner of image
    attr_reader :y_origin

    ##
    # Image width in pixels
    attr_reader :width

    ##
    # Image height in pixels
    attr_reader :height

    ##
    # Bits per pixel:
    # - 8 = Greyscale or indexed
    # - 16 = RGB 5-5-5 or RGBA 1-5-5-5
    # - 24 = RGB
    # - 32 = RGBA
    attr_reader :pixel_depth

    ##
    # Image descriptor byte:
    # - Bits 0-3: Number of attribute bits per pixel (alpha channel)
    # - Bit 4: Reserved
    # - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
    # - Bits 6-7: Interleaving (usually 0)
    attr_reader :image_descriptor
  end

  ##
  # Length of image ID field (0-255 bytes)
  attr_reader :id_length

  ##
  # Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.
  attr_reader :color_map_type

  ##
  # Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.
  attr_reader :image_type

  ##
  # Color map specification (only present if color_map_type == present)
  attr_reader :color_map_spec

  ##
  # Image specification (dimensions and pixel format)
  attr_reader :image_spec

  ##
  # Image identification field (optional ASCII string)
  attr_reader :image_id

  ##
  # Color map data (palette entries)
  attr_reader :color_map_data

  ##
  # Image pixel data (raw or RLE-compressed).
  # Size depends on image dimensions, pixel format, and compression.
  # For uncompressed formats: width × height × bytes_per_pixel
  # For RLE formats: Variable size depending on compression ratio
  attr_reader :image_data
end
