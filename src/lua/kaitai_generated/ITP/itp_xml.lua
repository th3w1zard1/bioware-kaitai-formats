-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
-- ITP files use GFF format (FileType "ITP " in GFF header).
-- Uses GFF XML structure with root element <gff3> containing <struct> elements.
-- Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).
-- 
-- Canonical links: `meta.doc-ref` and `meta.xref`.
-- See also: PyKotor wiki — GFF (ITP is GFF-shaped) (https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format)
-- See also: xoreos — `GFF3File::readHeader` (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63)
-- See also: reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`) (https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225)
-- See also: xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP) (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf)
-- See also: xoreos-docs — Torlack ITP / MultiMap (GFF-family context) (https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49)
-- See also: xoreos-docs — BioWare specs PDF tree (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
ItpXml = class.class(KaitaiStruct)

function ItpXml:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function ItpXml:_read()
  self.xml_content = str_decode.decode(self._io:read_bytes_full(), "UTF-8")
end

-- 
-- XML document content as UTF-8 text.

