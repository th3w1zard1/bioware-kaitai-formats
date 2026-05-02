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
use super::tga_common::TgaCommon_TgaColorMapType;
use super::tga_common::TgaCommon_TgaImageType;

/**
 * **TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
 * converts authoring TGAs to **TPC** for shipping.
 * 
 * Shared header enums: `formats/Common/tga_common.ksy`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — textures (TPC/TGA pipeline)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40 PyKotor — compact TGA reader (`tga.py`)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120 PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177 xoreos — `TGA::readHeader`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L241 xoreos-tools — `TGA::load` through `readRLE` (tooling reader)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)
 * \sa https://github.com/lachjames/NorthernLights lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)
 */

#[derive(Default, Debug, Clone)]
pub struct Tga {
    pub _root: SharedType<Tga>,
    pub _parent: SharedType<Tga>,
    pub _self: SharedType<Self>,
    id_length: RefCell<u8>,
    color_map_type: RefCell<TgaCommon_TgaColorMapType>,
    image_type: RefCell<TgaCommon_TgaImageType>,
    color_map_spec: RefCell<OptRc<Tga_ColorMapSpecification>>,
    image_spec: RefCell<OptRc<Tga_ImageSpecification>>,
    image_id: RefCell<String>,
    color_map_data: RefCell<Vec<u8>>,
    image_data: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Tga {
    type Root = Tga;
    type Parent = Tga;

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
        *self_rc.id_length.borrow_mut() = _io.read_u1()?.into();
        *self_rc.color_map_type.borrow_mut() = (_io.read_u1()? as i64).try_into()?;
        *self_rc.image_type.borrow_mut() = (_io.read_u1()? as i64).try_into()?;
        if *self_rc.color_map_type() == TgaCommon_TgaColorMapType::Present {
            let t = Self::read_into::<_, Tga_ColorMapSpecification>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.color_map_spec.borrow_mut() = t;
        }
        let t = Self::read_into::<_, Tga_ImageSpecification>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.image_spec.borrow_mut() = t;
        if ((*self_rc.id_length() as u8) > (0 as u8)) {
            *self_rc.image_id.borrow_mut() = bytes_to_str(&_io.read_bytes(*self_rc.id_length() as usize)?.into(), "ASCII")?;
        }
        if *self_rc.color_map_type() == TgaCommon_TgaColorMapType::Present {
            *self_rc.color_map_data.borrow_mut() = Vec::new();
            let l_color_map_data = *self_rc.color_map_spec().length();
            for _i in 0..l_color_map_data {
                self_rc.color_map_data.borrow_mut().push(_io.read_u1()?.into());
            }
        }
        *self_rc.image_data.borrow_mut() = Vec::new();
        {
            let mut _i = 0;
            while !_io.is_eof() {
                self_rc.image_data.borrow_mut().push(_io.read_u1()?.into());
                _i += 1;
            }
        }
        Ok(())
    }
}
impl Tga {
}

/**
 * Length of image ID field (0-255 bytes)
 */
impl Tga {
    pub fn id_length(&self) -> Ref<'_, u8> {
        self.id_length.borrow()
    }
}

/**
 * Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.
 */
impl Tga {
    pub fn color_map_type(&self) -> Ref<'_, TgaCommon_TgaColorMapType> {
        self.color_map_type.borrow()
    }
}

/**
 * Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.
 */
impl Tga {
    pub fn image_type(&self) -> Ref<'_, TgaCommon_TgaImageType> {
        self.image_type.borrow()
    }
}

/**
 * Color map specification (only present if color_map_type == present)
 */
impl Tga {
    pub fn color_map_spec(&self) -> Ref<'_, OptRc<Tga_ColorMapSpecification>> {
        self.color_map_spec.borrow()
    }
}

/**
 * Image specification (dimensions and pixel format)
 */
impl Tga {
    pub fn image_spec(&self) -> Ref<'_, OptRc<Tga_ImageSpecification>> {
        self.image_spec.borrow()
    }
}

/**
 * Image identification field (optional ASCII string)
 */
impl Tga {
    pub fn image_id(&self) -> Ref<'_, String> {
        self.image_id.borrow()
    }
}

/**
 * Color map data (palette entries)
 */
impl Tga {
    pub fn color_map_data(&self) -> Ref<'_, Vec<u8>> {
        self.color_map_data.borrow()
    }
}

/**
 * Image pixel data (raw or RLE-compressed).
 * Size depends on image dimensions, pixel format, and compression.
 * For uncompressed formats: width × height × bytes_per_pixel
 * For RLE formats: Variable size depending on compression ratio
 */
impl Tga {
    pub fn image_data(&self) -> Ref<'_, Vec<u8>> {
        self.image_data.borrow()
    }
}
impl Tga {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Tga_ColorMapSpecification {
    pub _root: SharedType<Tga>,
    pub _parent: SharedType<Tga>,
    pub _self: SharedType<Self>,
    first_entry_index: RefCell<u16>,
    length: RefCell<u16>,
    entry_size: RefCell<u8>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Tga_ColorMapSpecification {
    type Root = Tga;
    type Parent = Tga;

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
        *self_rc.first_entry_index.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.length.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.entry_size.borrow_mut() = _io.read_u1()?.into();
        Ok(())
    }
}
impl Tga_ColorMapSpecification {
}

/**
 * Index of first color map entry
 */
impl Tga_ColorMapSpecification {
    pub fn first_entry_index(&self) -> Ref<'_, u16> {
        self.first_entry_index.borrow()
    }
}

/**
 * Number of color map entries
 */
impl Tga_ColorMapSpecification {
    pub fn length(&self) -> Ref<'_, u16> {
        self.length.borrow()
    }
}

/**
 * Size of each color map entry in bits (15, 16, 24, or 32)
 */
impl Tga_ColorMapSpecification {
    pub fn entry_size(&self) -> Ref<'_, u8> {
        self.entry_size.borrow()
    }
}
impl Tga_ColorMapSpecification {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Tga_ImageSpecification {
    pub _root: SharedType<Tga>,
    pub _parent: SharedType<Tga>,
    pub _self: SharedType<Self>,
    x_origin: RefCell<u16>,
    y_origin: RefCell<u16>,
    width: RefCell<u16>,
    height: RefCell<u16>,
    pixel_depth: RefCell<u8>,
    image_descriptor: RefCell<u8>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Tga_ImageSpecification {
    type Root = Tga;
    type Parent = Tga;

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
        *self_rc.x_origin.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.y_origin.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.width.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.height.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.pixel_depth.borrow_mut() = _io.read_u1()?.into();
        *self_rc.image_descriptor.borrow_mut() = _io.read_u1()?.into();
        Ok(())
    }
}
impl Tga_ImageSpecification {
}

/**
 * X coordinate of lower-left corner of image
 */
impl Tga_ImageSpecification {
    pub fn x_origin(&self) -> Ref<'_, u16> {
        self.x_origin.borrow()
    }
}

/**
 * Y coordinate of lower-left corner of image
 */
impl Tga_ImageSpecification {
    pub fn y_origin(&self) -> Ref<'_, u16> {
        self.y_origin.borrow()
    }
}

/**
 * Image width in pixels
 */
impl Tga_ImageSpecification {
    pub fn width(&self) -> Ref<'_, u16> {
        self.width.borrow()
    }
}

/**
 * Image height in pixels
 */
impl Tga_ImageSpecification {
    pub fn height(&self) -> Ref<'_, u16> {
        self.height.borrow()
    }
}

/**
 * Bits per pixel:
 * - 8 = Greyscale or indexed
 * - 16 = RGB 5-5-5 or RGBA 1-5-5-5
 * - 24 = RGB
 * - 32 = RGBA
 */
impl Tga_ImageSpecification {
    pub fn pixel_depth(&self) -> Ref<'_, u8> {
        self.pixel_depth.borrow()
    }
}

/**
 * Image descriptor byte:
 * - Bits 0-3: Number of attribute bits per pixel (alpha channel)
 * - Bit 4: Reserved
 * - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
 * - Bits 6-7: Interleaving (usually 0)
 */
impl Tga_ImageSpecification {
    pub fn image_descriptor(&self) -> Ref<'_, u8> {
        self.image_descriptor.borrow()
    }
}
impl Tga_ImageSpecification {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
