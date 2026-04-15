# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'gff'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **ARE** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
# `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
# `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.
# 
# FileType / restype id **2012** — see `bioware_type_ids::xoreos_file_type_id` enum member `are`.
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — GFF3 header read
# @see https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF binary
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (GFF3 wire)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
class GffAre < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @contents = Gff::GffUnionFile.new(@_io)
    self
  end

  ##
  # Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per ARE template docs / PyKotor `gff_auto`.
  attr_reader :contents
end
