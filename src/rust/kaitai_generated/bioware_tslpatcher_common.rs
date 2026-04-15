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
 * Shared enums and small helper types used by TSLPatcher-style tooling.
 * 
 * Notes:
 * - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
 *   so string-valued enums are modeled here as small string wrapper types with `valid` constraints.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareTslpatcherCommon {
    pub _root: SharedType<BiowareTslpatcherCommon>,
    pub _parent: SharedType<BiowareTslpatcherCommon>,
    pub _self: SharedType<Self>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareTslpatcherCommon {
    type Root = BiowareTslpatcherCommon;
    type Parent = BiowareTslpatcherCommon;

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
impl BiowareTslpatcherCommon {
}
impl BiowareTslpatcherCommon {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
#[derive(Debug, PartialEq, Clone)]
pub enum BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId {
    Verbose,
    Note,
    Warning,
    Error,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId> {
        match flag {
            0 => Ok(BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Verbose),
            1 => Ok(BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Note),
            2 => Ok(BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Warning),
            3 => Ok(BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Error),
            _ => Ok(BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Unknown(flag)),
        }
    }
}

impl From<&BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId> for i64 {
    fn from(v: &BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId) -> Self {
        match *v {
            BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Verbose => 0,
            BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Note => 1,
            BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Warning => 2,
            BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Error => 3,
            BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Unknown(v) => v
        }
    }
}

impl Default for BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId {
    fn default() -> Self { BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId {
    RowIndex,
    RowLabel,
    LabelColumn,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId> {
        match flag {
            0 => Ok(BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId::RowIndex),
            1 => Ok(BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId::RowLabel),
            2 => Ok(BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId::LabelColumn),
            _ => Ok(BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId::Unknown(flag)),
        }
    }
}

impl From<&BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId> for i64 {
    fn from(v: &BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId) -> Self {
        match *v {
            BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId::RowIndex => 0,
            BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId::RowLabel => 1,
            BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId::LabelColumn => 2,
            BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId::Unknown(v) => v
        }
    }
}

impl Default for BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId {
    fn default() -> Self { BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId::Unknown(0) }
}


/**
 * String-valued enum equivalent for DiffFormat (null-terminated ASCII).
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareTslpatcherCommon_BiowareDiffFormatStr {
    pub _root: SharedType<BiowareTslpatcherCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    value: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareTslpatcherCommon_BiowareDiffFormatStr {
    type Root = BiowareTslpatcherCommon;
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
        if !( ((*self_rc.value() == "default".to_string()) || (*self_rc.value() == "unified".to_string()) || (*self_rc.value() == "context".to_string()) || (*self_rc.value() == "side_by_side".to_string())) ) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/types/bioware_diff_format_str/seq/0".to_string() }));
        }
        Ok(())
    }
}
impl BiowareTslpatcherCommon_BiowareDiffFormatStr {
}
impl BiowareTslpatcherCommon_BiowareDiffFormatStr {
    pub fn value(&self) -> Ref<'_, String> {
        self.value.borrow()
    }
}
impl BiowareTslpatcherCommon_BiowareDiffFormatStr {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareTslpatcherCommon_BiowareDiffResourceTypeStr {
    pub _root: SharedType<BiowareTslpatcherCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    value: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareTslpatcherCommon_BiowareDiffResourceTypeStr {
    type Root = BiowareTslpatcherCommon;
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
        if !( ((*self_rc.value() == "gff".to_string()) || (*self_rc.value() == "2da".to_string()) || (*self_rc.value() == "tlk".to_string()) || (*self_rc.value() == "lip".to_string()) || (*self_rc.value() == "bytes".to_string())) ) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/types/bioware_diff_resource_type_str/seq/0".to_string() }));
        }
        Ok(())
    }
}
impl BiowareTslpatcherCommon_BiowareDiffResourceTypeStr {
}
impl BiowareTslpatcherCommon_BiowareDiffResourceTypeStr {
    pub fn value(&self) -> Ref<'_, String> {
        self.value.borrow()
    }
}
impl BiowareTslpatcherCommon_BiowareDiffResourceTypeStr {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * String-valued enum equivalent for DiffType (null-terminated ASCII).
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareTslpatcherCommon_BiowareDiffTypeStr {
    pub _root: SharedType<BiowareTslpatcherCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    value: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareTslpatcherCommon_BiowareDiffTypeStr {
    type Root = BiowareTslpatcherCommon;
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
        if !( ((*self_rc.value() == "identical".to_string()) || (*self_rc.value() == "modified".to_string()) || (*self_rc.value() == "added".to_string()) || (*self_rc.value() == "removed".to_string()) || (*self_rc.value() == "error".to_string())) ) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/types/bioware_diff_type_str/seq/0".to_string() }));
        }
        Ok(())
    }
}
impl BiowareTslpatcherCommon_BiowareDiffTypeStr {
}
impl BiowareTslpatcherCommon_BiowareDiffTypeStr {
    pub fn value(&self) -> Ref<'_, String> {
        self.value.borrow()
    }
}
impl BiowareTslpatcherCommon_BiowareDiffTypeStr {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareTslpatcherCommon_BiowareNcsTokenTypeStr {
    pub _root: SharedType<BiowareTslpatcherCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    value: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareTslpatcherCommon_BiowareNcsTokenTypeStr {
    type Root = BiowareTslpatcherCommon;
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
        if !( ((*self_rc.value() == "strref".to_string()) || (*self_rc.value() == "strref32".to_string()) || (*self_rc.value() == "2damemory".to_string()) || (*self_rc.value() == "2damemory32".to_string()) || (*self_rc.value() == "uint32".to_string()) || (*self_rc.value() == "uint16".to_string()) || (*self_rc.value() == "uint8".to_string())) ) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/types/bioware_ncs_token_type_str/seq/0".to_string() }));
        }
        Ok(())
    }
}
impl BiowareTslpatcherCommon_BiowareNcsTokenTypeStr {
}
impl BiowareTslpatcherCommon_BiowareNcsTokenTypeStr {
    pub fn value(&self) -> Ref<'_, String> {
        self.value.borrow()
    }
}
impl BiowareTslpatcherCommon_BiowareNcsTokenTypeStr {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
