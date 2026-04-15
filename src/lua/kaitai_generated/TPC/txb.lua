-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("tpc")

-- 
-- **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
-- (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.
-- 
-- This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
-- variant diverges, split a dedicated header type and cite Ghidra / binary evidence (`TODO: VERIFY`).
-- See also: xoreos — `kFileTypeTXB` (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182)
-- See also: xoreos — `TPC::load` (texture family) (https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66)
-- See also: xoreos-tools — `TPC::load` (https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68)
-- See also: xoreos-tools — `TPC::readHeader` (https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224)
-- See also: xoreos-docs — BioWare specs PDF tree (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
-- See also: xoreos-docs — KotOR MDL overview (texture pipeline context) (https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html)
-- See also: PyKotor wiki — texture family (cross-check TXB) (https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
Txb = class.class(KaitaiStruct)

function Txb:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Txb:_read()
  self.header = Tpc.TpcHeader(self._io)
  self.body = self._io:read_bytes_full()
end

-- 
-- Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
-- 
-- Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.

