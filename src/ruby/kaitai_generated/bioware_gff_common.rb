# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).
# 
# Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
# (Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).
class BiowareGffCommon < Kaitai::Struct::Struct

  GFF_FIELD_TYPE = {
    0 => :gff_field_type_uint8,
    1 => :gff_field_type_int8,
    2 => :gff_field_type_uint16,
    3 => :gff_field_type_int16,
    4 => :gff_field_type_uint32,
    5 => :gff_field_type_int32,
    6 => :gff_field_type_uint64,
    7 => :gff_field_type_int64,
    8 => :gff_field_type_single,
    9 => :gff_field_type_double,
    10 => :gff_field_type_string,
    11 => :gff_field_type_resref,
    12 => :gff_field_type_localized_string,
    13 => :gff_field_type_binary,
    14 => :gff_field_type_struct,
    15 => :gff_field_type_list,
    16 => :gff_field_type_vector4,
    17 => :gff_field_type_vector3,
    18 => :gff_field_type_str_ref,
  }
  I__GFF_FIELD_TYPE = GFF_FIELD_TYPE.invert
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    self
  end
end
