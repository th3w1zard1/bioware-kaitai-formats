-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("gff")

-- 
-- **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
-- (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
-- 
-- G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
-- See also: xoreos — GDAFile::load (https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305)
Gda = class.class(KaitaiStruct)

function Gda:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Gda:_read()
  self.as_gff4 = Gff.Gff4File(self._io)
end

-- 
-- On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
-- (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).

