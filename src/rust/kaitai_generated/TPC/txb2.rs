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
use super::tpc::Tpc_TpcHeader;

/**
 * **TXB2** (`kFileTypeTXB2` **3017**): second-generation TXB id in `types.h`; treated like **TXB** / **TPC** by engine
 * texture stacks. This capsule mirrors `TXB.ksy` (TPC header + opaque tail) until a divergent wire is proven.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192 xoreos — `kFileTypeTXB2`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66 xoreos — `TPC::load` (texture family)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — texture family
 */

#[derive(Default, Debug, Clone)]
pub struct Txb2 {
    pub _root: SharedType<Txb2>,
    pub _parent: SharedType<Txb2>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Tpc_TpcHeader>>,
    body: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Txb2 {
    type Root = Txb2;
    type Parent = Txb2;

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
        let t = Self::read_into::<_, Tpc_TpcHeader>(&*_io, None, None)?.into();
        *self_rc.header.borrow_mut() = t;
        *self_rc.body.borrow_mut() = _io.read_bytes_full()?.into();
        Ok(())
    }
}
impl Txb2 {
}
impl Txb2 {
    pub fn header(&self) -> Ref<'_, OptRc<Tpc_TpcHeader>> {
        self.header.borrow()
    }
}
impl Txb2 {
    pub fn body(&self) -> Ref<'_, Vec<u8>> {
        self.body.borrow()
    }
}
impl Txb2 {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
