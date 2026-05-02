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
 * Enums and small helper types used by installation/extraction tooling.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/installation.py
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60 xoreos — `FileType` enum start (Aurora resource type IDs; no dedicated extraction-layout parser — this `.ksy` is tooling-side)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py#L67-L122 PyKotor — `SearchLocation` / `TexturePackNames` (maps to enums in this `.ksy`)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py PyKotor — installation / search helpers (full module)
 * \sa https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/ PyKotor — `extract/` package
 * \sa https://github.com/OldRepublicDevs/Andastra/blob/master/src/andastra/parsing/extract/installation.cs Andastra — Eclipse extraction/installation model
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (tooling enums; no extraction-specific PDF)
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareExtractCommon {
    pub _root: SharedType<BiowareExtractCommon>,
    pub _parent: SharedType<BiowareExtractCommon>,
    pub _self: SharedType<Self>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareExtractCommon {
    type Root = BiowareExtractCommon;
    type Parent = BiowareExtractCommon;

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
        Ok(())
    }
}
impl BiowareExtractCommon {
}
impl BiowareExtractCommon {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
#[derive(Debug, PartialEq, Clone)]
pub enum BiowareExtractCommon_BiowareSearchLocationId {
    Override,
    Modules,
    Chitin,
    TexturesTpa,
    TexturesTpb,
    TexturesTpc,
    TexturesGui,
    Music,
    Sound,
    Voice,
    Lips,
    Rims,
    CustomModules,
    CustomFolders,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareExtractCommon_BiowareSearchLocationId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareExtractCommon_BiowareSearchLocationId> {
        match flag {
            0 => Ok(BiowareExtractCommon_BiowareSearchLocationId::Override),
            1 => Ok(BiowareExtractCommon_BiowareSearchLocationId::Modules),
            2 => Ok(BiowareExtractCommon_BiowareSearchLocationId::Chitin),
            3 => Ok(BiowareExtractCommon_BiowareSearchLocationId::TexturesTpa),
            4 => Ok(BiowareExtractCommon_BiowareSearchLocationId::TexturesTpb),
            5 => Ok(BiowareExtractCommon_BiowareSearchLocationId::TexturesTpc),
            6 => Ok(BiowareExtractCommon_BiowareSearchLocationId::TexturesGui),
            7 => Ok(BiowareExtractCommon_BiowareSearchLocationId::Music),
            8 => Ok(BiowareExtractCommon_BiowareSearchLocationId::Sound),
            9 => Ok(BiowareExtractCommon_BiowareSearchLocationId::Voice),
            10 => Ok(BiowareExtractCommon_BiowareSearchLocationId::Lips),
            11 => Ok(BiowareExtractCommon_BiowareSearchLocationId::Rims),
            12 => Ok(BiowareExtractCommon_BiowareSearchLocationId::CustomModules),
            13 => Ok(BiowareExtractCommon_BiowareSearchLocationId::CustomFolders),
            _ => Ok(BiowareExtractCommon_BiowareSearchLocationId::Unknown(flag)),
        }
    }
}

impl From<&BiowareExtractCommon_BiowareSearchLocationId> for i64 {
    fn from(v: &BiowareExtractCommon_BiowareSearchLocationId) -> Self {
        match *v {
            BiowareExtractCommon_BiowareSearchLocationId::Override => 0,
            BiowareExtractCommon_BiowareSearchLocationId::Modules => 1,
            BiowareExtractCommon_BiowareSearchLocationId::Chitin => 2,
            BiowareExtractCommon_BiowareSearchLocationId::TexturesTpa => 3,
            BiowareExtractCommon_BiowareSearchLocationId::TexturesTpb => 4,
            BiowareExtractCommon_BiowareSearchLocationId::TexturesTpc => 5,
            BiowareExtractCommon_BiowareSearchLocationId::TexturesGui => 6,
            BiowareExtractCommon_BiowareSearchLocationId::Music => 7,
            BiowareExtractCommon_BiowareSearchLocationId::Sound => 8,
            BiowareExtractCommon_BiowareSearchLocationId::Voice => 9,
            BiowareExtractCommon_BiowareSearchLocationId::Lips => 10,
            BiowareExtractCommon_BiowareSearchLocationId::Rims => 11,
            BiowareExtractCommon_BiowareSearchLocationId::CustomModules => 12,
            BiowareExtractCommon_BiowareSearchLocationId::CustomFolders => 13,
            BiowareExtractCommon_BiowareSearchLocationId::Unknown(v) => v
        }
    }
}

impl Default for BiowareExtractCommon_BiowareSearchLocationId {
    fn default() -> Self { BiowareExtractCommon_BiowareSearchLocationId::Unknown(0) }
}


/**
 * String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareExtractCommon_BiowareTexturePackNameStr {
    pub _root: SharedType<BiowareExtractCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    value: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareExtractCommon_BiowareTexturePackNameStr {
    type Root = BiowareExtractCommon;
    type Parent = KStructUnit;

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
        *self_rc.value.borrow_mut() = bytes_to_str(&_io.read_bytes_term(0, false, true, true)?.into(), "ASCII")?;
        if !( ((*self_rc.value() == "swpc_tex_tpa.erf".to_string()) || (*self_rc.value() == "swpc_tex_tpb.erf".to_string()) || (*self_rc.value() == "swpc_tex_tpc.erf".to_string()) || (*self_rc.value() == "swpc_tex_gui.erf".to_string())) ) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/types/bioware_texture_pack_name_str/seq/0".to_string() }));
        }
        Ok(())
    }
}
impl BiowareExtractCommon_BiowareTexturePackNameStr {
}
impl BiowareExtractCommon_BiowareTexturePackNameStr {
    pub fn value(&self) -> Ref<'_, String> {
        self.value.borrow()
    }
}
impl BiowareExtractCommon_BiowareTexturePackNameStr {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
