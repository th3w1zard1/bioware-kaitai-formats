# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
# per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
# 
# Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
class TgaCommon < Kaitai::Struct::Struct

  TGA_COLOR_MAP_TYPE = {
    0 => :tga_color_map_type_none,
    1 => :tga_color_map_type_present,
  }
  I__TGA_COLOR_MAP_TYPE = TGA_COLOR_MAP_TYPE.invert

  TGA_IMAGE_TYPE = {
    0 => :tga_image_type_no_image_data,
    1 => :tga_image_type_uncompressed_color_mapped,
    2 => :tga_image_type_uncompressed_rgb,
    3 => :tga_image_type_uncompressed_greyscale,
    9 => :tga_image_type_rle_color_mapped,
    10 => :tga_image_type_rle_rgb,
    11 => :tga_image_type_rle_greyscale,
  }
  I__TGA_IMAGE_TYPE = TGA_IMAGE_TYPE.invert
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    self
  end
end
