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
use super::bioware_common::BiowareCommon_BiowareTpcPixelFormatId;

/**
 * **TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
 * (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
 * (`meta.xref`).
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — TPC
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303 PyKotor — `TPCBinaryReader` + `load`
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120 PyKotor — `TPCTextureFormat` (opening)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520 PyKotor — `class TPC` (opening)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105 reone — `TpcReader` (body + TXI features)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L183 xoreos — `kFileTypeTPC`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L362 xoreos — `TPC::load` through `readTXI` entrypoints
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts#L290-L380 KotOR.js — `TPCObject.readHeader`
 */

#[derive(Default, Debug, Clone)]
pub struct Tpc {
    pub _root: SharedType<Tpc>,
    pub _parent: SharedType<Tpc>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Tpc_TpcHeader>>,
    body: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Tpc {
    type Root = Tpc;
    type Parent = Tpc;

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
        let t = Self::read_into::<_, Tpc_TpcHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        *self_rc.body.borrow_mut() = _io.read_bytes_full()?.into();
        Ok(())
    }
}
impl Tpc {
}

/**
 * TPC file header (128 bytes total)
 */
impl Tpc {
    pub fn header(&self) -> Ref<'_, OptRc<Tpc_TpcHeader>> {
        self.header.borrow()
    }
}

/**
 * Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).
 */
impl Tpc {
    pub fn body(&self) -> Ref<'_, Vec<u8>> {
        self.body.borrow()
    }
}
impl Tpc {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Tpc_TpcHeader {
    pub _root: SharedType<Tpc>,
    pub _parent: SharedType<Tpc>,
    pub _self: SharedType<Self>,
    data_size: RefCell<u32>,
    alpha_test: RefCell<f32>,
    width: RefCell<u16>,
    height: RefCell<u16>,
    pixel_encoding: RefCell<BiowareCommon_BiowareTpcPixelFormatId>,
    mipmap_count: RefCell<u8>,
    reserved: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
    f_is_compressed: Cell<bool>,
    is_compressed: RefCell<bool>,
    f_is_uncompressed: Cell<bool>,
    is_uncompressed: RefCell<bool>,
}
impl KStruct for Tpc_TpcHeader {
    type Root = Tpc;
    type Parent = Tpc;

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
        *self_rc.data_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.alpha_test.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.width.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.height.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.pixel_encoding.borrow_mut() = (_io.read_u1()? as i64).try_into()?;
        *self_rc.mipmap_count.borrow_mut() = _io.read_u1()?.into();
        *self_rc.reserved.borrow_mut() = Vec::new();
        let l_reserved = 114;
        for _i in 0..l_reserved {
            self_rc.reserved.borrow_mut().push(_io.read_u1()?.into());
        }
        Ok(())
    }
}
impl Tpc_TpcHeader {

    /**
     * True if texture data is compressed (DXT format)
     */
    pub fn is_compressed(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_compressed.get() {
            return Ok(self.is_compressed.borrow());
        }
        self.f_is_compressed.set(true);
        *self.is_compressed.borrow_mut() = (((*self.data_size() as u32) != (0 as u32))) as bool;
        Ok(self.is_compressed.borrow())
    }

    /**
     * True if texture data is uncompressed (raw pixels)
     */
    pub fn is_uncompressed(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_uncompressed.get() {
            return Ok(self.is_uncompressed.borrow());
        }
        self.f_is_uncompressed.set(true);
        *self.is_uncompressed.borrow_mut() = (((*self.data_size() as u32) == (0 as u32))) as bool;
        Ok(self.is_uncompressed.borrow())
    }
}

/**
 * Total compressed payload size. If non-zero, texture is compressed (DXT).
 * If zero, texture is uncompressed and size is derived from format/width/height.
 */
impl Tpc_TpcHeader {
    pub fn data_size(&self) -> Ref<'_, u32> {
        self.data_size.borrow()
    }
}

/**
 * Float threshold used by punch-through rendering.
 * Commonly 0.0 or 0.5.
 */
impl Tpc_TpcHeader {
    pub fn alpha_test(&self) -> Ref<'_, f32> {
        self.alpha_test.borrow()
    }
}

/**
 * Texture width in pixels (uint16).
 * Must be power-of-two for compressed formats.
 */
impl Tpc_TpcHeader {
    pub fn width(&self) -> Ref<'_, u16> {
        self.width.borrow()
    }
}

/**
 * Texture height in pixels (uint16).
 * For cube maps, this is 6x the face width.
 * Must be power-of-two for compressed formats.
 */
impl Tpc_TpcHeader {
    pub fn height(&self) -> Ref<'_, u16> {
        self.height.borrow()
    }
}

/**
 * Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
 * `bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).
 */
impl Tpc_TpcHeader {
    pub fn pixel_encoding(&self) -> Ref<'_, BiowareCommon_BiowareTpcPixelFormatId> {
        self.pixel_encoding.borrow()
    }
}

/**
 * Number of mip levels per layer (minimum 1).
 * Each mip level is half the size of the previous level.
 */
impl Tpc_TpcHeader {
    pub fn mipmap_count(&self) -> Ref<'_, u8> {
        self.mipmap_count.borrow()
    }
}

/**
 * Reserved/padding bytes (0x72 = 114 bytes).
 * KotOR stores platform hints here but all implementations skip them.
 */
impl Tpc_TpcHeader {
    pub fn reserved(&self) -> Ref<'_, Vec<u8>> {
        self.reserved.borrow()
    }
}
impl Tpc_TpcHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
