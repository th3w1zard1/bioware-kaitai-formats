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
 * **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
 * framed wire lives in `LIP.ksy`.
 * 
 * **TODO: VERIFY** full BIP layout against Odyssey Ghidra (`user-agdec-http`) and PyKotor; until then this spec
 * exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198 xoreos — `kFileTypeBIP`
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP family
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; placeholder wire — verify in Ghidra)
 */

#[derive(Default, Debug, Clone)]
pub struct Bip {
    pub _root: SharedType<Bip>,
    pub _parent: SharedType<Bip>,
    pub _self: SharedType<Self>,
    payload: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bip {
    type Root = Bip;
    type Parent = Bip;

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
        *self_rc.payload.borrow_mut() = _io.read_bytes_full()?.into();
        Ok(())
    }
}
impl Bip {
}

/**
 * Opaque binary LIP payload — replace with structured fields after verification.
 */
impl Bip {
    pub fn payload(&self) -> Ref<'_, Vec<u8>> {
        self.payload.borrow()
    }
}
impl Bip {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
