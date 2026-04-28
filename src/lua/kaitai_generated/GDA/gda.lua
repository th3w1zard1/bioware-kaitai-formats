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
-- 
-- **reone:** not applicable for GDA wire ingestion on the KotOR fork (`meta.xref.reone_gda_consumer_note`).
-- See also: xoreos — `GDAFile::load` (https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305)
-- See also: xoreos — `GFF4File` stream ctor (type dispatch) (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L87-L93)
-- See also: xoreos — G2DA column field ids (excerpt) (https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4fields.h#L1230-L1260)
-- See also: xoreos — `TwoDAFile(const GDAFile &)` (https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L136-L140)
-- See also: xoreos — `TwoDAFile::load(const GDAFile &)` (https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L343-L400)
-- See also: xoreos-tools — `main` (https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86)
-- See also: xoreos-tools — `get2DAGDA` (https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159)
-- See also: xoreos-tools — multi-file `GDAFile` merge (https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L167-L181)
-- See also: PyKotor — `ResourceType.GDA` (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L1466-L1472)
-- See also: xoreos-docs — GFF_Format.pdf (GFF4 family; G2DA container) (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf)
-- See also: xoreos-docs — CommonGFFStructs.pdf (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf)
-- See also: xoreos-docs — 2DA_Format.pdf (classic `.2da`; contrast with GDA) (https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf)
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

