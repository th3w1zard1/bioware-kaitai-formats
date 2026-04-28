-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")

-- 
-- **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
-- framed wire lives in `LIP.ksy`.
-- 
-- **TODO: VERIFY** full BIP layout against a KotOR PC build and PyKotor; until then this spec
-- exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.
-- See also: xoreos — `kFileTypeBIP` (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198)
-- See also: PyKotor wiki — LIP family (https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip)
-- See also: xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; verify wire with PyKotor / **observed behavior** on shipped builds when possible) (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
Bip = class.class(KaitaiStruct)

function Bip:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Bip:_read()
  self.payload = self._io:read_bytes_full()
end

-- 
-- Opaque binary LIP payload — replace with structured fields after verification.

