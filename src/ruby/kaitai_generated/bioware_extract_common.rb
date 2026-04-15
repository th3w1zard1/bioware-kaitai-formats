# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# Enums and small helper types used by installation/extraction tooling.
# 
# References:
# - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/installation.py
class BiowareExtractCommon < Kaitai::Struct::Struct

  BIOWARE_SEARCH_LOCATION_ID = {
    0 => :bioware_search_location_id_override,
    1 => :bioware_search_location_id_modules,
    2 => :bioware_search_location_id_chitin,
    3 => :bioware_search_location_id_textures_tpa,
    4 => :bioware_search_location_id_textures_tpb,
    5 => :bioware_search_location_id_textures_tpc,
    6 => :bioware_search_location_id_textures_gui,
    7 => :bioware_search_location_id_music,
    8 => :bioware_search_location_id_sound,
    9 => :bioware_search_location_id_voice,
    10 => :bioware_search_location_id_lips,
    11 => :bioware_search_location_id_rims,
    12 => :bioware_search_location_id_custom_modules,
    13 => :bioware_search_location_id_custom_folders,
  }
  I__BIOWARE_SEARCH_LOCATION_ID = BIOWARE_SEARCH_LOCATION_ID.invert
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    self
  end

  ##
  # String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
  class BiowareTexturePackNameStr < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @value = (@_io.read_bytes_term(0, false, true, true)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotAnyOfError.new(@value, @_io, "/types/bioware_texture_pack_name_str/seq/0") if not  ((@value == "swpc_tex_tpa.erf") || (@value == "swpc_tex_tpb.erf") || (@value == "swpc_tex_tpc.erf") || (@value == "swpc_tex_gui.erf")) 
      self
    end
    attr_reader :value
  end
end
