# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
# palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
# that reference external palette files, enabling dynamic color customization for character models
# (skin, hair, armor colors, etc.).
# 
# **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
# resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
# does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
# including character models. This documentation is provided for reference only.
# 
# Binary Format Structure:
# - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
# - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)
# 
# Palette System:
# PLT files work in conjunction with external palette files (.pal files) that contain the actual
# color values. The PLT file itself stores:
# 1. Palette Group index (0-9): Which palette group to use for each pixel
# 2. Color index (0-255): Which color within the selected palette to use
# 
# At runtime, the game:
# 1. Loads the appropriate palette file for the selected palette group
# 2. Uses the palette index (supplied by the content creator) to select a row in the palette file
# 3. Uses the color index from the PLT file to retrieve the final color value
# 
# Palette Groups (10 total):
# 0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
# 6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2
# 
# References:
# - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
# - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
# - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp
class Plt < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = PltHeader.new(@_io, self, @_root)
    @pixel_data = PixelDataSection.new(@_io, self, @_root)
    self
  end
  class PixelDataSection < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @pixels = []
      (_root.header.width * _root.header.height).times { |i|
        @pixels << PltPixel.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of pixel entries, stored row by row, left to right, top to bottom.
    # Total size = width × height × 2 bytes.
    # Each pixel entry contains a color index and palette group index.
    attr_reader :pixels
  end
  class PltHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @signature = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotEqualError.new("PLT ", @signature, @_io, "/types/plt_header/seq/0") if not @signature == "PLT "
      @version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotEqualError.new("V1  ", @version, @_io, "/types/plt_header/seq/1") if not @version == "V1  "
      @unknown1 = @_io.read_u4le
      @unknown2 = @_io.read_u4le
      @width = @_io.read_u4le
      @height = @_io.read_u4le
      self
    end

    ##
    # File signature. Must be "PLT " (space-padded).
    # This identifies the file as a PLT palette texture.
    attr_reader :signature

    ##
    # File format version. Must be "V1  " (space-padded).
    # This is the only known version of the PLT format.
    attr_reader :version

    ##
    # Unknown field (4 bytes).
    # Purpose is unknown, may be reserved for future use or internal engine flags.
    attr_reader :unknown1

    ##
    # Unknown field (4 bytes).
    # Purpose is unknown, may be reserved for future use or internal engine flags.
    attr_reader :unknown2

    ##
    # Texture width in pixels (uint32).
    # Used to calculate the number of pixel entries in the pixel data section.
    attr_reader :width

    ##
    # Texture height in pixels (uint32).
    # Used to calculate the number of pixel entries in the pixel data section.
    # Total pixel count = width × height
    attr_reader :height
  end
  class PltPixel < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @color_index = @_io.read_u1
      @palette_group_index = @_io.read_u1
      self
    end

    ##
    # Color index (0-255) within the selected palette.
    # This value selects which color from the palette file row to use.
    # The palette file contains 256 rows (one for each palette index 0-255),
    # and each row contains 256 color values (one for each color index 0-255).
    attr_reader :color_index

    ##
    # Palette group index (0-9) that determines which palette file to use.
    # Palette groups:
    # 0 = Skin (pal_skin01.jpg)
    # 1 = Hair (pal_hair01.jpg)
    # 2 = Metal 1 (pal_armor01.jpg)
    # 3 = Metal 2 (pal_armor02.jpg)
    # 4 = Cloth 1 (pal_cloth01.jpg)
    # 5 = Cloth 2 (pal_cloth01.jpg)
    # 6 = Leather 1 (pal_leath01.jpg)
    # 7 = Leather 2 (pal_leath01.jpg)
    # 8 = Tattoo 1 (pal_tattoo01.jpg)
    # 9 = Tattoo 2 (pal_tattoo01.jpg)
    attr_reader :palette_group_index
  end

  ##
  # PLT file header (24 bytes)
  attr_reader :header

  ##
  # Array of pixel entries (width × height entries, 2 bytes each)
  attr_reader :pixel_data
end
