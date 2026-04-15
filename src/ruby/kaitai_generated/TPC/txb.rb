# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'tpc'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
# (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.
# 
# This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
# variant diverges, split a dedicated header type and cite Ghidra / binary evidence (`TODO: VERIFY`).
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182 xoreos — `kFileTypeTXB`
# @see https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66 xoreos — `TPC::load` (texture family)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
# @see https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — texture family (cross-check TXB)
class Txb < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = Tpc::TpcHeader.new(@_io)
    @body = @_io.read_bytes_full
    self
  end

  ##
  # Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
  attr_reader :header

  ##
  # Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.
  attr_reader :body
end
