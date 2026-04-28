# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).
# 
# - `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
#   (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
# - `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
#   decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
# - `ncs_program_size_marker` is the fixed header byte after `"V1.0"` in retail KotOR NCS blobs (`0x42`).
# 
# **Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
# duplicating opcode lists.
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L115 PyKotor — NCSByteCode
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L118-L140 PyKotor — NCSInstructionQualifier
# @see https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format PyKotor wiki — NCS
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355 xoreos — NCSFile::load
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137 xoreos-tools — NCSFile::load
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html xoreos-docs — Torlack ncs.html
# @see https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40 reone — NcsReader::load
class BiowareNcsCommon < Kaitai::Struct::Struct

  NCS_BYTECODE = {
    0 => :ncs_bytecode_reserved_bc,
    1 => :ncs_bytecode_cpdownsp,
    2 => :ncs_bytecode_rsaddx,
    3 => :ncs_bytecode_cptopsp,
    4 => :ncs_bytecode_constx,
    5 => :ncs_bytecode_action,
    6 => :ncs_bytecode_logandxx,
    7 => :ncs_bytecode_logorxx,
    8 => :ncs_bytecode_incorxx,
    9 => :ncs_bytecode_excorxx,
    10 => :ncs_bytecode_boolandxx,
    11 => :ncs_bytecode_equalxx,
    12 => :ncs_bytecode_nequalxx,
    13 => :ncs_bytecode_geqxx,
    14 => :ncs_bytecode_gtxx,
    15 => :ncs_bytecode_ltxx,
    16 => :ncs_bytecode_leqxx,
    17 => :ncs_bytecode_shleftxx,
    18 => :ncs_bytecode_shrightxx,
    19 => :ncs_bytecode_ushrightxx,
    20 => :ncs_bytecode_addxx,
    21 => :ncs_bytecode_subxx,
    22 => :ncs_bytecode_mulxx,
    23 => :ncs_bytecode_divxx,
    24 => :ncs_bytecode_modxx,
    25 => :ncs_bytecode_negx,
    26 => :ncs_bytecode_compx,
    27 => :ncs_bytecode_movsp,
    28 => :ncs_bytecode_unused_gap,
    29 => :ncs_bytecode_jmp,
    30 => :ncs_bytecode_jsr,
    31 => :ncs_bytecode_jz,
    32 => :ncs_bytecode_retn,
    33 => :ncs_bytecode_destruct,
    34 => :ncs_bytecode_notx,
    35 => :ncs_bytecode_decxsp,
    36 => :ncs_bytecode_incxsp,
    37 => :ncs_bytecode_jnz,
    38 => :ncs_bytecode_cpdownbp,
    39 => :ncs_bytecode_cptopbp,
    40 => :ncs_bytecode_decxbp,
    41 => :ncs_bytecode_incxbp,
    42 => :ncs_bytecode_savebp,
    43 => :ncs_bytecode_restorebp,
    44 => :ncs_bytecode_store_state,
    45 => :ncs_bytecode_nop,
  }
  I__NCS_BYTECODE = NCS_BYTECODE.invert

  NCS_INSTRUCTION_QUALIFIER = {
    0 => :ncs_instruction_qualifier_none,
    1 => :ncs_instruction_qualifier_unary_operand_layout,
    3 => :ncs_instruction_qualifier_int_type,
    4 => :ncs_instruction_qualifier_float_type,
    5 => :ncs_instruction_qualifier_string_type,
    6 => :ncs_instruction_qualifier_object_type,
    16 => :ncs_instruction_qualifier_effect_type,
    17 => :ncs_instruction_qualifier_event_type,
    18 => :ncs_instruction_qualifier_location_type,
    19 => :ncs_instruction_qualifier_talent_type,
    32 => :ncs_instruction_qualifier_int_int,
    33 => :ncs_instruction_qualifier_float_float,
    34 => :ncs_instruction_qualifier_object_object,
    35 => :ncs_instruction_qualifier_string_string,
    36 => :ncs_instruction_qualifier_struct_struct,
    37 => :ncs_instruction_qualifier_int_float,
    38 => :ncs_instruction_qualifier_float_int,
    48 => :ncs_instruction_qualifier_effect_effect,
    49 => :ncs_instruction_qualifier_event_event,
    50 => :ncs_instruction_qualifier_location_location,
    51 => :ncs_instruction_qualifier_talent_talent,
    58 => :ncs_instruction_qualifier_vector_vector,
    59 => :ncs_instruction_qualifier_vector_float,
    60 => :ncs_instruction_qualifier_float_vector,
  }
  I__NCS_INSTRUCTION_QUALIFIER = NCS_INSTRUCTION_QUALIFIER.invert

  NCS_PROGRAM_SIZE_MARKER = {
    66 => :ncs_program_size_marker_program_size_prefix,
  }
  I__NCS_PROGRAM_SIZE_MARKER = NCS_PROGRAM_SIZE_MARKER.invert
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    self
  end
end
