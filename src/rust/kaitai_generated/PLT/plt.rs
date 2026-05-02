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
 * PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
 * palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
 * that reference external palette files, enabling dynamic color customization for character models
 * (skin, hair, armor colors, etc.).
 * 
 * **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
 * resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
 * does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
 * including character models. This documentation is provided for reference only.
 * 
 * **reone:** the KotOR-focused fork does not ship a standalone PLT body reader; see `meta.xref.reone_resource_type_plt_note` for the numeric `Plt` type id only.
 * 
 * Binary Format Structure:
 * - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
 * - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)
 * 
 * Palette System:
 * PLT files work in conjunction with external palette files (.pal files) that contain the actual
 * color values. The PLT file itself stores:
 * 1. Palette Group index (0-9): Which palette group to use for each pixel
 * 2. Color index (0-255): Which color within the selected palette to use
 * 
 * At runtime, the game:
 * 1. Loads the appropriate palette file for the selected palette group
 * 2. Uses the palette index (supplied by the content creator) to select a row in the palette file
 * 3. Uses the color index from the PLT file to retrieve the final color value
 * 
 * Palette Groups (10 total):
 * 0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
 * 6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L374-L380 PyKotor — `ResourceType.PLT`
 * - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
 * - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy PyKotor wiki — PLT (NWN legacy)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html xoreos-docs — Torlack plt.html
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L63 xoreos — `kFileTypePLT`
 * \sa https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L35 reone — `ResourceType::Plt` (id 6; no `.plt` wire reader on default branch)
 */

#[derive(Default, Debug, Clone)]
pub struct Plt {
    pub _root: SharedType<Plt>,
    pub _parent: SharedType<Plt>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Plt_PltHeader>>,
    pixel_data: RefCell<OptRc<Plt_PixelDataSection>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Plt {
    type Root = Plt;
    type Parent = Plt;

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
        let t = Self::read_into::<_, Plt_PltHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        let t = Self::read_into::<_, Plt_PixelDataSection>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.pixel_data.borrow_mut() = t;
        Ok(())
    }
}
impl Plt {
}

/**
 * PLT file header (24 bytes)
 */
impl Plt {
    pub fn header(&self) -> Ref<'_, OptRc<Plt_PltHeader>> {
        self.header.borrow()
    }
}

/**
 * Array of pixel entries (width × height entries, 2 bytes each)
 */
impl Plt {
    pub fn pixel_data(&self) -> Ref<'_, OptRc<Plt_PixelDataSection>> {
        self.pixel_data.borrow()
    }
}
impl Plt {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Plt_PixelDataSection {
    pub _root: SharedType<Plt>,
    pub _parent: SharedType<Plt>,
    pub _self: SharedType<Self>,
    pixels: RefCell<Vec<OptRc<Plt_PltPixel>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Plt_PixelDataSection {
    type Root = Plt;
    type Parent = Plt;

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
        *self_rc.pixels.borrow_mut() = Vec::new();
        let l_pixels = ((*_r.header().width() as u32) * (*_r.header().height() as u32));
        for _i in 0..l_pixels {
            let t = Self::read_into::<_, Plt_PltPixel>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.pixels.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Plt_PixelDataSection {
}

/**
 * Array of pixel entries, stored row by row, left to right, top to bottom.
 * Total size = width × height × 2 bytes.
 * Each pixel entry contains a color index and palette group index.
 */
impl Plt_PixelDataSection {
    pub fn pixels(&self) -> Ref<'_, Vec<OptRc<Plt_PltPixel>>> {
        self.pixels.borrow()
    }
}
impl Plt_PixelDataSection {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Plt_PltHeader {
    pub _root: SharedType<Plt>,
    pub _parent: SharedType<Plt>,
    pub _self: SharedType<Self>,
    signature: RefCell<String>,
    version: RefCell<String>,
    unknown1: RefCell<u32>,
    unknown2: RefCell<u32>,
    width: RefCell<u32>,
    height: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Plt_PltHeader {
    type Root = Plt;
    type Parent = Plt;

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
        if !(*self_rc.signature() == "PLT ".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/plt_header/seq/0".to_string() }));
        }
        *self_rc.version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !(*self_rc.version() == "V1  ".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/plt_header/seq/1".to_string() }));
        }
        *self_rc.unknown1.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown2.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.width.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.height.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Plt_PltHeader {
}

/**
 * File signature. Must be "PLT " (space-padded).
 * This identifies the file as a PLT palette texture.
 */
impl Plt_PltHeader {
    pub fn signature(&self) -> Ref<'_, String> {
        self.signature.borrow()
    }
}

/**
 * File format version. Must be "V1  " (space-padded).
 * This is the only known version of the PLT format.
 */
impl Plt_PltHeader {
    pub fn version(&self) -> Ref<'_, String> {
        self.version.borrow()
    }
}

/**
 * Unknown field (4 bytes).
 * Purpose is unknown, may be reserved for future use or internal engine flags.
 */
impl Plt_PltHeader {
    pub fn unknown1(&self) -> Ref<'_, u32> {
        self.unknown1.borrow()
    }
}

/**
 * Unknown field (4 bytes).
 * Purpose is unknown, may be reserved for future use or internal engine flags.
 */
impl Plt_PltHeader {
    pub fn unknown2(&self) -> Ref<'_, u32> {
        self.unknown2.borrow()
    }
}

/**
 * Texture width in pixels (uint32).
 * Used to calculate the number of pixel entries in the pixel data section.
 */
impl Plt_PltHeader {
    pub fn width(&self) -> Ref<'_, u32> {
        self.width.borrow()
    }
}

/**
 * Texture height in pixels (uint32).
 * Used to calculate the number of pixel entries in the pixel data section.
 * Total pixel count = width × height
 */
impl Plt_PltHeader {
    pub fn height(&self) -> Ref<'_, u32> {
        self.height.borrow()
    }
}
impl Plt_PltHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Plt_PltPixel {
    pub _root: SharedType<Plt>,
    pub _parent: SharedType<Plt_PixelDataSection>,
    pub _self: SharedType<Self>,
    color_index: RefCell<u8>,
    palette_group_index: RefCell<u8>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Plt_PltPixel {
    type Root = Plt;
    type Parent = Plt_PixelDataSection;

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
        *self_rc.color_index.borrow_mut() = _io.read_u1()?.into();
        *self_rc.palette_group_index.borrow_mut() = _io.read_u1()?.into();
        Ok(())
    }
}
impl Plt_PltPixel {
}

/**
 * Color index (0-255) within the selected palette.
 * This value selects which color from the palette file row to use.
 * The palette file contains 256 rows (one for each palette index 0-255),
 * and each row contains 256 color values (one for each color index 0-255).
 */
impl Plt_PltPixel {
    pub fn color_index(&self) -> Ref<'_, u8> {
        self.color_index.borrow()
    }
}

/**
 * Palette group index (0-9) that determines which palette file to use.
 * Palette groups:
 * 0 = Skin (pal_skin01.jpg)
 * 1 = Hair (pal_hair01.jpg)
 * 2 = Metal 1 (pal_armor01.jpg)
 * 3 = Metal 2 (pal_armor02.jpg)
 * 4 = Cloth 1 (pal_cloth01.jpg)
 * 5 = Cloth 2 (pal_cloth01.jpg)
 * 6 = Leather 1 (pal_leath01.jpg)
 * 7 = Leather 2 (pal_leath01.jpg)
 * 8 = Tattoo 1 (pal_tattoo01.jpg)
 * 9 = Tattoo 2 (pal_tattoo01.jpg)
 */
impl Plt_PltPixel {
    pub fn palette_group_index(&self) -> Ref<'_, u8> {
        self.palette_group_index.borrow()
    }
}
impl Plt_PltPixel {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
