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
use super::bioware_common::BiowareCommon_BiowareLipVisemeId;

/**
 * **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
 * `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
 * 
 * xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no LIP-specific tool)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116 PyKotor — `io_lip` (Kaitai + legacy read/write)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/lip_data.py#L47-L127 PyKotor — `LIPShape` enum
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L41 reone — `LipReader::load`
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LIPObject.ts#L99-L118 KotOR.js — `LIPObject.readBinary`
 * \sa https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorLIP/LIP.cs NickHugi/Kotor.NET — `LIP`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L180 xoreos — `kFileTypeLIP` (numeric id; no standalone `lipfile.cpp`)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (no dedicated LIP Torlack/PDF; wire from PyKotor/reone)
 */

#[derive(Default, Debug, Clone)]
pub struct Lip {
    pub _root: SharedType<Lip>,
    pub _parent: SharedType<Lip>,
    pub _self: SharedType<Self>,
    file_type: RefCell<String>,
    file_version: RefCell<String>,
    length: RefCell<f32>,
    num_keyframes: RefCell<u32>,
    keyframes: RefCell<Vec<OptRc<Lip_KeyframeEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Lip {
    type Root = Lip;
    type Parent = Lip;

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
        *self_rc.file_version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        *self_rc.length.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.num_keyframes.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.keyframes.borrow_mut() = Vec::new();
        let l_keyframes = *self_rc.num_keyframes();
        for _i in 0..l_keyframes {
            let t = Self::read_into::<_, Lip_KeyframeEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.keyframes.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Lip {
}

/**
 * File type signature. Must be "LIP " (space-padded) for LIP files.
 */
impl Lip {
    pub fn file_type(&self) -> Ref<'_, String> {
        self.file_type.borrow()
    }
}

/**
 * File format version. Must be "V1.0" for LIP files.
 */
impl Lip {
    pub fn file_version(&self) -> Ref<'_, String> {
        self.file_version.borrow()
    }
}

/**
 * Duration in seconds. Must equal the paired WAV file playback time for
 * glitch-free animation. This is the total length of the lip sync animation.
 */
impl Lip {
    pub fn length(&self) -> Ref<'_, f32> {
        self.length.borrow()
    }
}

/**
 * Number of keyframes immediately following. Each keyframe contains a timestamp
 * and a viseme shape index. Keyframes should be sorted ascending by timestamp.
 */
impl Lip {
    pub fn num_keyframes(&self) -> Ref<'_, u32> {
        self.num_keyframes.borrow()
    }
}

/**
 * Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
 * Entries must be stored in chronological order (ascending by timestamp).
 */
impl Lip {
    pub fn keyframes(&self) -> Ref<'_, Vec<OptRc<Lip_KeyframeEntry>>> {
        self.keyframes.borrow()
    }
}
impl Lip {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * A single keyframe entry mapping a timestamp to a viseme (mouth shape).
 * Keyframes are used by the engine to interpolate between mouth shapes during
 * audio playback to create lip sync animation.
 */

#[derive(Default, Debug, Clone)]
pub struct Lip_KeyframeEntry {
    pub _root: SharedType<Lip>,
    pub _parent: SharedType<Lip>,
    pub _self: SharedType<Self>,
    timestamp: RefCell<f32>,
    shape: RefCell<BiowareCommon_BiowareLipVisemeId>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Lip_KeyframeEntry {
    type Root = Lip;
    type Parent = Lip;

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
        *self_rc.timestamp.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.shape.borrow_mut() = (_io.read_u1()? as i64).try_into()?;
        Ok(())
    }
}
impl Lip_KeyframeEntry {
}

/**
 * Seconds from animation start. Must be >= 0 and <= length.
 * Keyframes should be sorted ascending by timestamp.
 */
impl Lip_KeyframeEntry {
    pub fn timestamp(&self) -> Ref<'_, f32> {
        self.timestamp.borrow()
    }
}

/**
 * Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
 * `bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).
 */
impl Lip_KeyframeEntry {
    pub fn shape(&self) -> Ref<'_, BiowareCommon_BiowareLipVisemeId> {
        self.shape.borrow()
    }
}
impl Lip_KeyframeEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
