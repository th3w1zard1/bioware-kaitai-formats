-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("tpc")

-- 
-- **TXB2** (`kFileTypeTXB2` **3017**): second-generation TXB id in `types.h`; treated like **TXB** / **TPC** by engine
-- texture stacks. This capsule mirrors `TXB.ksy` (TPC header + opaque tail) until a divergent wire is proven.
-- See also: xoreos — `kFileTypeTXB2` (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192)
-- See also: xoreos — `TPC::load` (texture family) (https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66)
-- See also: xoreos-tools — `TPC::load` (https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68)
-- See also: xoreos-tools — `TPC::readHeader` (https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224)
-- See also: xoreos-docs — BioWare specs PDF tree (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
-- See also: xoreos-docs — KotOR MDL overview (texture pipeline context) (https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html)
-- See also: PyKotor wiki — texture family (https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
Txb2 = class.class(KaitaiStruct)

function Txb2:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Txb2:_read()
  self.header = Tpc.TpcHeader(self._io)
  self.body = self._io:read_bytes_full()
end


