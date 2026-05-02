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
 * **DA2S** (Dragon Age 2 save): Eclipse binary save — `DA2S` signature, `version==1`, length-prefixed strings + tagged
 * blocks (party/inventory/journal/etc.). **Not KotOR** — Andastra serializers under `Game/Games/Eclipse/DragonAge2/Save/` (`meta.xref`).
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408 xoreos — `GameID` (`kGameIDDragonAge2` = 8)
 * \sa https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAge2/Save/DragonAge2SaveSerializer.cs#L24-L180 Andastra — `DragonAge2SaveSerializer`
 * \sa https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126 Andastra — `EclipseSaveSerializer` helpers
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (Dragon Age saves documented via Andastra + `GameID`; no DA2S-specific PDF here)
 */

#[derive(Default, Debug, Clone)]
pub struct Da2s {
    pub _root: SharedType<Da2s>,
    pub _parent: SharedType<Da2s>,
    pub _self: SharedType<Self>,
    signature: RefCell<String>,
    version: RefCell<i32>,
    save_name: RefCell<OptRc<Da2s_LengthPrefixedString>>,
    module_name: RefCell<OptRc<Da2s_LengthPrefixedString>>,
    area_name: RefCell<OptRc<Da2s_LengthPrefixedString>>,
    time_played_seconds: RefCell<i32>,
    timestamp_filetime: RefCell<i64>,
    num_screenshot_data: RefCell<i32>,
    screenshot_data: RefCell<Vec<u8>>,
    num_portrait_data: RefCell<i32>,
    portrait_data: RefCell<Vec<u8>>,
    player_name: RefCell<OptRc<Da2s_LengthPrefixedString>>,
    party_member_count: RefCell<i32>,
    player_level: RefCell<i32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Da2s {
    type Root = Da2s;
    type Parent = Da2s;

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
        *self_rc.signature.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !(*self_rc.signature() == "DA2S".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/0".to_string() }));
        }
        *self_rc.version.borrow_mut() = _io.read_s4le()?.into();
        if !(((*self_rc.version() as i32) == (1 as i32))) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/1".to_string() }));
        }
        let t = Self::read_into::<_, Da2s_LengthPrefixedString>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.save_name.borrow_mut() = t;
        let t = Self::read_into::<_, Da2s_LengthPrefixedString>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.module_name.borrow_mut() = t;
        let t = Self::read_into::<_, Da2s_LengthPrefixedString>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.area_name.borrow_mut() = t;
        *self_rc.time_played_seconds.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.timestamp_filetime.borrow_mut() = _io.read_s8le()?.into();
        *self_rc.num_screenshot_data.borrow_mut() = _io.read_s4le()?.into();
        if ((*self_rc.num_screenshot_data() as i32) > (0 as i32)) {
            *self_rc.screenshot_data.borrow_mut() = Vec::new();
            let l_screenshot_data = *self_rc.num_screenshot_data();
            for _i in 0..l_screenshot_data {
                self_rc.screenshot_data.borrow_mut().push(_io.read_u1()?.into());
            }
        }
        *self_rc.num_portrait_data.borrow_mut() = _io.read_s4le()?.into();
        if ((*self_rc.num_portrait_data() as i32) > (0 as i32)) {
            *self_rc.portrait_data.borrow_mut() = Vec::new();
            let l_portrait_data = *self_rc.num_portrait_data();
            for _i in 0..l_portrait_data {
                self_rc.portrait_data.borrow_mut().push(_io.read_u1()?.into());
            }
        }
        let t = Self::read_into::<_, Da2s_LengthPrefixedString>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.player_name.borrow_mut() = t;
        *self_rc.party_member_count.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.player_level.borrow_mut() = _io.read_s4le()?.into();
        Ok(())
    }
}
impl Da2s {
}

/**
 * File signature. Must be "DA2S" for Dragon Age 2 save files.
 */
impl Da2s {
    pub fn signature(&self) -> Ref<'_, String> {
        self.signature.borrow()
    }
}

/**
 * Save format version. Must be 1 for Dragon Age 2.
 */
impl Da2s {
    pub fn version(&self) -> Ref<'_, i32> {
        self.version.borrow()
    }
}

/**
 * User-entered save name displayed in UI
 */
impl Da2s {
    pub fn save_name(&self) -> Ref<'_, OptRc<Da2s_LengthPrefixedString>> {
        self.save_name.borrow()
    }
}

/**
 * Current module resource name
 */
impl Da2s {
    pub fn module_name(&self) -> Ref<'_, OptRc<Da2s_LengthPrefixedString>> {
        self.module_name.borrow()
    }
}

/**
 * Current area name for display
 */
impl Da2s {
    pub fn area_name(&self) -> Ref<'_, OptRc<Da2s_LengthPrefixedString>> {
        self.area_name.borrow()
    }
}

/**
 * Total play time in seconds
 */
impl Da2s {
    pub fn time_played_seconds(&self) -> Ref<'_, i32> {
        self.time_played_seconds.borrow()
    }
}

/**
 * Save creation timestamp as Windows FILETIME (int64).
 * Convert using DateTime.FromFileTime().
 */
impl Da2s {
    pub fn timestamp_filetime(&self) -> Ref<'_, i64> {
        self.timestamp_filetime.borrow()
    }
}

/**
 * Length of screenshot data in bytes (0 if no screenshot)
 */
impl Da2s {
    pub fn num_screenshot_data(&self) -> Ref<'_, i32> {
        self.num_screenshot_data.borrow()
    }
}

/**
 * Screenshot image data (typically TGA or DDS format)
 */
impl Da2s {
    pub fn screenshot_data(&self) -> Ref<'_, Vec<u8>> {
        self.screenshot_data.borrow()
    }
}

/**
 * Length of portrait data in bytes (0 if no portrait)
 */
impl Da2s {
    pub fn num_portrait_data(&self) -> Ref<'_, i32> {
        self.num_portrait_data.borrow()
    }
}

/**
 * Portrait image data (typically TGA or DDS format)
 */
impl Da2s {
    pub fn portrait_data(&self) -> Ref<'_, Vec<u8>> {
        self.portrait_data.borrow()
    }
}

/**
 * Player character name
 */
impl Da2s {
    pub fn player_name(&self) -> Ref<'_, OptRc<Da2s_LengthPrefixedString>> {
        self.player_name.borrow()
    }
}

/**
 * Number of party members (from PartyState)
 */
impl Da2s {
    pub fn party_member_count(&self) -> Ref<'_, i32> {
        self.party_member_count.borrow()
    }
}

/**
 * Player character level (from PartyState.PlayerCharacter)
 */
impl Da2s {
    pub fn player_level(&self) -> Ref<'_, i32> {
        self.player_level.borrow()
    }
}
impl Da2s {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Da2s_LengthPrefixedString {
    pub _root: SharedType<Da2s>,
    pub _parent: SharedType<Da2s>,
    pub _self: SharedType<Self>,
    length: RefCell<i32>,
    value: RefCell<String>,
    _io: RefCell<BytesReader>,
    f_value_trimmed: Cell<bool>,
    value_trimmed: RefCell<String>,
}
impl KStruct for Da2s_LengthPrefixedString {
    type Root = Da2s;
    type Parent = Da2s;

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
        *self_rc.length.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.value.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(*self_rc.length() as usize)?.into(), 0, false).into(), "UTF-8")?;
        Ok(())
    }
}
impl Da2s_LengthPrefixedString {

    /**
     * String value.
     * Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
     */
    pub fn value_trimmed(
        &self
    ) -> KResult<Ref<'_, String>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_trimmed.get() {
            return Ok(self.value_trimmed.borrow());
        }
        self.f_value_trimmed.set(true);
        *self.value_trimmed.borrow_mut() = self.value().to_string();
        Ok(self.value_trimmed.borrow())
    }
}

/**
 * String length in bytes (UTF-8 encoding).
 * Must be >= 0 and <= 65536 (sanity check).
 */
impl Da2s_LengthPrefixedString {
    pub fn length(&self) -> Ref<'_, i32> {
        self.length.borrow()
    }
}

/**
 * String value (UTF-8 encoded)
 */
impl Da2s_LengthPrefixedString {
    pub fn value(&self) -> Ref<'_, String> {
        self.value.borrow()
    }
}
impl Da2s_LengthPrefixedString {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
