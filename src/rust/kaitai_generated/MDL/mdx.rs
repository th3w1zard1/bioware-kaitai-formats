// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#![allow(unused_imports)]
#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(irrefutable_let_patterns)]
#![allow(unused_comparisons)]

extern crate kaitai;
use kaitai::*;
use std::convert::{TryFrom, TryInto};
use std::cell::{Ref, Cell, RefCell};
use std::rc::{Rc, Weak};

/**
 * **MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
 * Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
 * opaque `size-eos` span — per-attribute layouts are MDL-driven.
 * 
 * Cross-implementations: xoreos reads trimesh MDX stride and interleaved streams in `meta.xref.xoreos_model_kotor_*`;
 * reone parses mesh MDX in `meta.xref.reone_mdlmdxreader_read_mesh`; KotOR.js uses `OdysseyModelNodeMesh` and
 * `OdysseyModelMDXFlag` (`meta.xref.kotor_js_*`). Shared bitmask names: imported `bioware_mdl_common::mdx_vertex_stream_flag`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408 PyKotor — `MDLBinaryReader` / MDX tail read path
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L809-L842 xoreos — trimesh MDX header fields (mdxStructSize, UV offsets, counts)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L864-L917 xoreos — interleaved MDX vertex loop
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192 xoreos — `kFileTypeMDX` (3008)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L201 xoreos — `kFileTypeMDX2` (3016)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDX-specific tool)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL/MDX overview
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (MDX-related controller / mesh background)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L197-L487 reone — MdlMdxReader::readMesh (MDX consumption)
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/enums/odyssey/OdysseyModelMDXFlag.ts KotOR.js — MDX stream flag enum
 */

#[derive(Default, Debug, Clone)]
pub struct Mdx {
    pub _root: SharedType<Mdx>,
    pub _parent: SharedType<Mdx>,
    pub _self: SharedType<Self>,
    vertex_data: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdx {
    type Root = Mdx;
    type Parent = Mdx;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.vertex_data.borrow_mut() = _io.read_bytes_full()?.into();
        Ok(())
    }
}
impl Mdx {
}

/**
 * Raw vertex data bytes; layout follows the trimesh header in the paired MDL (`mdx_data_offset`, `mdx_vertex_size`,
 * `mdx_data_flags`). Bit names for `mdx_data_flags`: `bioware_mdl_common::mdx_vertex_stream_flag` (bitmask on wire).
 * 
 * See `meta.xref.pykotor_wiki_mdl`, `meta.xref.xoreos_model_kotor_trimesh_mdx_fields`, and
 * `meta.xref.xoreos_model_kotor_mdx_interleaved_vertices`. Skinned meshes add bone weights
 * and indices per vertex as described on the wiki.
 */
impl Mdx {
    pub fn vertex_data(&self) -> Ref<'_, Vec<u8>> {
        self.vertex_data.borrow()
    }
}
impl Mdx {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
