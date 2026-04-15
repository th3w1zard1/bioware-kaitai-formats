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
 * Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
 * per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
 * 
 * Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
 */

#[derive(Default, Debug, Clone)]
pub struct TgaCommon {
    pub _root: SharedType<TgaCommon>,
    pub _parent: SharedType<TgaCommon>,
    pub _self: SharedType<Self>,
    _io: RefCell<BytesReader>,
}
impl KStruct for TgaCommon {
    type Root = TgaCommon;
    type Parent = TgaCommon;

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
impl TgaCommon {
}
impl TgaCommon {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
#[derive(Debug, PartialEq, Clone)]
pub enum TgaCommon_TgaColorMapType {
    None,
    Present,
    Unknown(i64),
}

impl TryFrom<i64> for TgaCommon_TgaColorMapType {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<TgaCommon_TgaColorMapType> {
        match flag {
            0 => Ok(TgaCommon_TgaColorMapType::None),
            1 => Ok(TgaCommon_TgaColorMapType::Present),
            _ => Ok(TgaCommon_TgaColorMapType::Unknown(flag)),
        }
    }
}

impl From<&TgaCommon_TgaColorMapType> for i64 {
    fn from(v: &TgaCommon_TgaColorMapType) -> Self {
        match *v {
            TgaCommon_TgaColorMapType::None => 0,
            TgaCommon_TgaColorMapType::Present => 1,
            TgaCommon_TgaColorMapType::Unknown(v) => v
        }
    }
}

impl Default for TgaCommon_TgaColorMapType {
    fn default() -> Self { TgaCommon_TgaColorMapType::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum TgaCommon_TgaImageType {
    NoImageData,
    UncompressedColorMapped,
    UncompressedRgb,
    UncompressedGreyscale,
    RleColorMapped,
    RleRgb,
    RleGreyscale,
    Unknown(i64),
}

impl TryFrom<i64> for TgaCommon_TgaImageType {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<TgaCommon_TgaImageType> {
        match flag {
            0 => Ok(TgaCommon_TgaImageType::NoImageData),
            1 => Ok(TgaCommon_TgaImageType::UncompressedColorMapped),
            2 => Ok(TgaCommon_TgaImageType::UncompressedRgb),
            3 => Ok(TgaCommon_TgaImageType::UncompressedGreyscale),
            9 => Ok(TgaCommon_TgaImageType::RleColorMapped),
            10 => Ok(TgaCommon_TgaImageType::RleRgb),
            11 => Ok(TgaCommon_TgaImageType::RleGreyscale),
            _ => Ok(TgaCommon_TgaImageType::Unknown(flag)),
        }
    }
}

impl From<&TgaCommon_TgaImageType> for i64 {
    fn from(v: &TgaCommon_TgaImageType) -> Self {
        match *v {
            TgaCommon_TgaImageType::NoImageData => 0,
            TgaCommon_TgaImageType::UncompressedColorMapped => 1,
            TgaCommon_TgaImageType::UncompressedRgb => 2,
            TgaCommon_TgaImageType::UncompressedGreyscale => 3,
            TgaCommon_TgaImageType::RleColorMapped => 9,
            TgaCommon_TgaImageType::RleRgb => 10,
            TgaCommon_TgaImageType::RleGreyscale => 11,
            TgaCommon_TgaImageType::Unknown(v) => v
        }
    }
}

impl Default for TgaCommon_TgaImageType {
    fn default() -> Self { TgaCommon_TgaImageType::Unknown(0) }
}

