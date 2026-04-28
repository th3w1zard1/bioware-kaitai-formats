# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
# ITP files use GFF format (FileType "ITP " in GFF header).
# Uses GFF XML structure with root element <gff3> containing <struct> elements.
# Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).
# 
# Canonical links: `meta.doc-ref` and `meta.xref`.
# @see https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF (ITP is GFF-shaped)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — `GFF3File::readHeader`
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225 reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 xoreos-docs — Torlack ITP / MultiMap (GFF-family context)
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
class ItpXml < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @xml_content = (@_io.read_bytes_full).force_encoding("UTF-8")
    self
  end

  ##
  # XML document content as UTF-8 text
  attr_reader :xml_content
end
