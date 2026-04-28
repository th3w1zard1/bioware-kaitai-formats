-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")

-- 
-- **MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
-- Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
-- opaque `size-eos` span — per-attribute layouts are MDL-driven.
-- 
-- Cross-implementations: xoreos reads trimesh MDX stride and interleaved streams in `meta.xref.xoreos_model_kotor_*`;
-- reone parses mesh MDX in `meta.xref.reone_mdlmdxreader_read_mesh`; KotOR.js uses `OdysseyModelNodeMesh` and
-- `OdysseyModelMDXFlag` (`meta.xref.kotor_js_*`). Shared bitmask names: imported `bioware_mdl_common::mdx_vertex_stream_flag`.
-- See also: PyKotor wiki — MDL/MDX (https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
-- See also: PyKotor — `MDLBinaryReader` / MDX tail read path (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408)
-- See also: xoreos — trimesh MDX header fields (mdxStructSize, UV offsets, counts) (https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L809-L842)
-- See also: xoreos — interleaved MDX vertex loop (https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L864-L917)
-- See also: xoreos — `kFileTypeMDX` (3008) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192)
-- See also: xoreos — `kFileTypeMDX2` (3016) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L201)
-- See also: xoreos-tools — shipped CLI inventory (no MDX-specific tool) (https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43)
-- See also: xoreos-docs — KotOR MDL/MDX overview (https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html)
-- See also: xoreos-docs — Torlack binmdl (MDX-related controller / mesh background) (https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html)
-- See also: reone — MdlMdxReader::readMesh (MDX consumption) (https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L197-L487)
-- See also: KotOR.js — MDX stream flag enum (https://github.com/KobaltBlu/KotOR.js/blob/master/src/enums/odyssey/OdysseyModelMDXFlag.ts)
Mdx = class.class(KaitaiStruct)

function Mdx:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Mdx:_read()
  self.vertex_data = self._io:read_bytes_full()
end

-- 
-- Raw vertex data bytes; layout follows the trimesh header in the paired MDL (`mdx_data_offset`, `mdx_vertex_size`,
-- `mdx_data_flags`). Bit names for `mdx_data_flags`: `bioware_mdl_common::mdx_vertex_stream_flag` (bitmask on wire).
-- 
-- See `meta.xref.pykotor_wiki_mdl`, `meta.xref.xoreos_model_kotor_trimesh_mdx_fields`, and
-- `meta.xref.xoreos_model_kotor_mdx_interleaved_vertices`. Skinned meshes add bone weights
-- and indices per vertex as described on the wiki.

