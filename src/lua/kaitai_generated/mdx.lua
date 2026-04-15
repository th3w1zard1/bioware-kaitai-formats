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
-- xoreos interleaved MDX reads: `meta.xref.xoreos_model_kotor_mdx_reads`.
-- See also: PyKotor wiki — MDL/MDX (https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
-- See also: xoreos — Model_KotOR MDX reads (https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L885-L917)
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
-- See `meta.xref.pykotor_wiki_mdl` and `meta.xref.xoreos_model_kotor_mdx_reads`. Skinned meshes add bone weights
-- and indices per vertex as described on the wiki.

