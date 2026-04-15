# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'gff'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
# (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
# 
# G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
# 
# **reone:** not applicable for GDA wire ingestion on the KotOR fork (`meta.xref.reone_gda_consumer_note`).
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305 xoreos — `GDAFile::load`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L87-L93 xoreos — `GFF4File` stream ctor (type dispatch)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4fields.h#L1230-L1260 xoreos — G2DA column field ids (excerpt)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L136-L140 xoreos — `TwoDAFile(const GDAFile &)`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L343-L400 xoreos — `TwoDAFile::load(const GDAFile &)`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86 xoreos-tools — `main`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159 xoreos-tools — `get2DAGDA`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L167-L181 xoreos-tools — multi-file `GDAFile` merge
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L1466-L1472 PyKotor — `ResourceType.GDA`
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (GFF4 family; G2DA container)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf xoreos-docs — 2DA_Format.pdf (classic `.2da`; contrast with GDA)
class Gda < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @as_gff4 = Gff::Gff4File.new(@_io)
    self
  end

  ##
  # On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
  # (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).
  attr_reader :as_gff4
end
