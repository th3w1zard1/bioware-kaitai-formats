# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
# framed wire lives in `LIP.ksy`.
# 
# **TODO: VERIFY** full BIP layout against a KotOR PC build and PyKotor; until then this spec
# exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198 xoreos — `kFileTypeBIP`
# @see https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP family
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; verify wire with PyKotor / **observed behavior** on shipped builds when possible)
class Bip < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @payload = @_io.read_bytes_full
    self
  end

  ##
  # Opaque binary LIP payload — replace with structured fields after verification.
  attr_reader :payload
end
