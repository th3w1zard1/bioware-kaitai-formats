# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
# mobile KotOR ports.
# @see https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression PyKotor wiki — BZF (LZMA BIF)
class Bzf < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotEqualError.new("BZF ", @file_type, @_io, "/seq/0") if not @file_type == "BZF "
    @version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotEqualError.new("V1.0", @version, @_io, "/seq/1") if not @version == "V1.0"
    @compressed_data = @_io.read_bytes_full
    self
  end

  ##
  # File type signature. Must be "BZF " for compressed BIF files.
  attr_reader :file_type

  ##
  # File format version. Always "V1.0" for BZF files.
  attr_reader :version

  ##
  # LZMA-compressed BIF file data (single blob to EOF).
  # Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).
  attr_reader :compressed_data
end
