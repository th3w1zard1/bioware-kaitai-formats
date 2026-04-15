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
use super::gff::Gff_Gff4File;

/**
 * **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
 * (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
 * 
 * G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305 xoreos — GDAFile::load
 */

#[derive(Default, Debug, Clone)]
pub struct Gda {
    pub _root: SharedType<Gda>,
    pub _parent: SharedType<Gda>,
    pub _self: SharedType<Self>,
    as_gff4: RefCell<OptRc<Gff_Gff4File>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gda {
    type Root = Gda;
    type Parent = Gda;

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
        let t = Self::read_into::<_, Gff_Gff4File>(&*_io, None, None)?.into();
        *self_rc.as_gff4.borrow_mut() = t;
        Ok(())
    }
}
impl Gda {
}

/**
 * On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
 * (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).
 */
impl Gda {
    pub fn as_gff4(&self) -> Ref<'_, OptRc<Gff_Gff4File>> {
        self.as_gff4.borrow()
    }
}
impl Gda {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
