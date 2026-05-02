-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("gff")

-- 
-- **UTG** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
-- `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
-- `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.
-- 
-- FileType / restype id **2055** — see `bioware_type_ids::xoreos_file_type_id` enum member `utg`.
-- See also: xoreos — GFF3 header read (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63)
-- See also: PyKotor wiki — GFF binary (https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format)
-- See also: xoreos-docs — GFF_Format.pdf (GFF3 wire) (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf)
-- See also: xoreos-docs — CommonGFFStructs.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf)
-- See also: xoreos-docs — BioWare specs PDF tree (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
GffUtg = class.class(KaitaiStruct)

function GffUtg:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function GffUtg:_read()
  self.contents = Gff.GffUnionFile(self._io)
end

-- 
-- Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per UTG template docs / PyKotor `gff_auto`.

