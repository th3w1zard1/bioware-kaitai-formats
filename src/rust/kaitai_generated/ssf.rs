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
 * SSF (Sound Set File) files store sound string references (StrRefs) for character voice sets.
 * Each SSF file contains exactly 28 sound slots, mapping to different game events and actions.
 * 
 * Binary Format:
 * - Header (12 bytes): File type signature, version, and offset to sounds array (usually 12)
 * - Sounds Array (112 bytes at sounds_offset): 28 uint32 values representing StrRefs (0xFFFFFFFF = -1 = no sound)
 * 
 * Vanilla KotOR SSFs are typically 136 bytes total: after the 28 StrRefs, many files append 12 bytes
 * of 0xFFFFFFFF padding; that trailer is not part of the header and is not modeled here.
 * 
 * Sound Slots (in order):
 * 0-5: Battle Cry 1-6
 * 6-8: Select 1-3
 * 9-11: Attack Grunt 1-3
 * 12-13: Pain Grunt 1-2
 * 14: Low Health
 * 15: Dead
 * 16: Critical Hit
 * 17: Target Immune
 * 18: Lay Mine
 * 19: Disarm Mine
 * 20: Begin Stealth
 * 21: Begin Search
 * 22: Begin Unlock
 * 23: Unlock Failed
 * 24: Unlock Success
 * 25: Separated From Party
 * 26: Rejoined Party
 * 27: Poisoned
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/ssf_binary_reader.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/ssf_binary_writer.py
 */

#[derive(Default, Debug, Clone)]
pub struct Ssf {
    pub _root: SharedType<Ssf>,
    pub _parent: SharedType<Ssf>,
    pub _self: SharedType<Self>,
    file_type: RefCell<String>,
    file_version: RefCell<String>,
    sounds_offset: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_sounds: Cell<bool>,
    sounds: RefCell<OptRc<Ssf_SoundArray>>,
}
impl KStruct for Ssf {
    type Root = Ssf;
    type Parent = Ssf;

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
        *self_rc.file_type.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !(*self_rc.file_type() == "SSF ".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/0".to_string() }));
        }
        *self_rc.file_version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !(*self_rc.file_version() == "V1.1".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/1".to_string() }));
        }
        *self_rc.sounds_offset.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Ssf {

    /**
     * Array of 28 sound string references (StrRefs)
     */
    pub fn sounds(
        &self
    ) -> KResult<Ref<'_, OptRc<Ssf_SoundArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_sounds.get() {
            return Ok(self.sounds.borrow());
        }
        let _pos = _io.pos();
        _io.seek(*self.sounds_offset() as usize)?;
        let t = Self::read_into::<_, Ssf_SoundArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
        *self.sounds.borrow_mut() = t;
        _io.seek(_pos)?;
        Ok(self.sounds.borrow())
    }
}

/**
 * File type signature. Must be "SSF " (space-padded).
 * Bytes: 0x53 0x53 0x46 0x20
 */
impl Ssf {
    pub fn file_type(&self) -> Ref<'_, String> {
        self.file_type.borrow()
    }
}

/**
 * File format version. Always "V1.1" for KotOR SSF files.
 * Bytes: 0x56 0x31 0x2E 0x31
 */
impl Ssf {
    pub fn file_version(&self) -> Ref<'_, String> {
        self.file_version.borrow()
    }
}

/**
 * Byte offset to the sounds array from the beginning of the file.
 * KotOR files almost always use 12 (0x0C) so the table follows the header immediately, but the
 * field is a real offset; readers must seek here instead of assuming 12.
 */
impl Ssf {
    pub fn sounds_offset(&self) -> Ref<'_, u32> {
        self.sounds_offset.borrow()
    }
}
impl Ssf {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Ssf_SoundArray {
    pub _root: SharedType<Ssf>,
    pub _parent: SharedType<Ssf>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Ssf_SoundEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Ssf_SoundArray {
    type Root = Ssf;
    type Parent = Ssf;

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
        *self_rc.entries.borrow_mut() = Vec::new();
        let l_entries = 28;
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Ssf_SoundEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Ssf_SoundArray {
}

/**
 * Array of exactly 28 sound entries, one for each SSFSound enum value.
 * Each entry is a uint32 representing a StrRef (string reference).
 * Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
 * 
 * Entry indices map to SSFSound enum:
 * - 0-5: Battle Cry 1-6
 * - 6-8: Select 1-3
 * - 9-11: Attack Grunt 1-3
 * - 12-13: Pain Grunt 1-2
 * - 14: Low Health
 * - 15: Dead
 * - 16: Critical Hit
 * - 17: Target Immune
 * - 18: Lay Mine
 * - 19: Disarm Mine
 * - 20: Begin Stealth
 * - 21: Begin Search
 * - 22: Begin Unlock
 * - 23: Unlock Failed
 * - 24: Unlock Success
 * - 25: Separated From Party
 * - 26: Rejoined Party
 * - 27: Poisoned
 */
impl Ssf_SoundArray {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Ssf_SoundEntry>>> {
        self.entries.borrow()
    }
}
impl Ssf_SoundArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Ssf_SoundEntry {
    pub _root: SharedType<Ssf>,
    pub _parent: SharedType<Ssf_SoundArray>,
    pub _self: SharedType<Self>,
    strref_raw: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_is_no_sound: Cell<bool>,
    is_no_sound: RefCell<bool>,
}
impl KStruct for Ssf_SoundEntry {
    type Root = Ssf;
    type Parent = Ssf_SoundArray;

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
        *self_rc.strref_raw.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Ssf_SoundEntry {

    /**
     * True if this entry represents "no sound" (0xFFFFFFFF).
     * False if this entry contains a valid StrRef value.
     */
    pub fn is_no_sound(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_no_sound.get() {
            return Ok(self.is_no_sound.borrow());
        }
        self.f_is_no_sound.set(true);
        *self.is_no_sound.borrow_mut() = (((*self.strref_raw() as i32) == (4294967295 as i32))) as bool;
        Ok(self.is_no_sound.borrow())
    }
}

/**
 * Raw uint32 value representing the StrRef.
 * Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
 * All other values are valid StrRefs (typically 0-999999).
 * The conversion from 0xFFFFFFFF to -1 is handled by SSFBinaryReader.ReadInt32MaxNeg1().
 */
impl Ssf_SoundEntry {
    pub fn strref_raw(&self) -> Ref<'_, u32> {
        self.strref_raw.borrow()
    }
}
impl Ssf_SoundEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
