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
use super::gff::Gff_GffUnionFile;

/**
 * **ARE** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
 * `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
 * `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.
 * 
 * FileType / restype id **2012** — see `bioware_type_ids::xoreos_file_type_id` enum member `are`.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — GFF3 header read
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF binary
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (GFF3 wire)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 */

#[derive(Default, Debug, Clone)]
pub struct GffAre {
    pub _root: SharedType<GffAre>,
    pub _parent: SharedType<GffAre>,
    pub _self: SharedType<Self>,
    contents: RefCell<OptRc<Gff_GffUnionFile>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for GffAre {
    type Root = GffAre;
    type Parent = GffAre;

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
        let t = Self::read_into::<_, Gff_GffUnionFile>(&*_io, None, None)?.into();
        *self_rc.contents.borrow_mut() = t;
        Ok(())
    }
}
impl GffAre {
}

/**
 * Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per ARE template docs / PyKotor `gff_auto`.
 */
impl GffAre {
    pub fn contents(&self) -> Ref<'_, OptRc<Gff_GffUnionFile>> {
        self.contents.borrow()
    }
}
impl GffAre {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
