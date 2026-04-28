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
 * **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
 * (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.
 * 
 * This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
 * variant diverges, split a dedicated header type and cite **observed behavior** / tooling evidence (`TODO: VERIFY`).
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182 xoreos — `kFileTypeTXB`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66 xoreos — `TPC::load` (texture family)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — texture family (cross-check TXB)
 */

#[derive(Default, Debug, Clone)]
pub struct Txb {
    pub _root: SharedType<Txb>,
    pub _parent: SharedType<Txb>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Tpc_TpcHeader>>,
    body: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Txb {
    type Root = Txb;
    type Parent = Txb;

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
impl Txb {
}

/**
 * Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
 */
impl Txb {
    pub fn header(&self) -> Ref<'_, OptRc<Tpc_TpcHeader>> {
        self.header.borrow()
    }
}

/**
 * Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.
 */
impl Txb {
    pub fn body(&self) -> Ref<'_, Vec<u8>> {
        self.body.borrow()
    }
}
impl Txb {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
