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
use super::bioware_common::BiowareCommon_BiowareDdsVariantBytesPerPixel;

/**
 * **DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
 * (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.
 * 
 * BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds PyKotor wiki — DDS
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130 PyKotor — `TPCDDSReader` / `io_dds`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L98 xoreos — `kFileTypeDDS`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L55-L67 xoreos — `dds.cpp` load entry
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L141-L210 xoreos — BioWare headerless / Microsoft DDS branches
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/images/dds.cpp#L69-L158 xoreos-tools — `dds.cpp` (image tooling)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree (texture-adjacent PDFs)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (engine texture pipeline context)
 * \sa https://github.com/lachjames/NorthernLights lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)
 * \sa https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L57 reone — `ResourceType::Dds` (type id; TPC path in `tpcreader.cpp`)
 */

#[derive(Default, Debug, Clone)]
pub struct Dds {
    pub _root: SharedType<Dds>,
    pub _parent: SharedType<Dds>,
    pub _self: SharedType<Self>,
    magic: RefCell<String>,
    header: RefCell<OptRc<Dds_DdsHeader>>,
    bioware_header: RefCell<OptRc<Dds_BiowareDdsHeader>>,
    pixel_data: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Dds {
    type Root = Dds;
    type Parent = Dds;

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
        *self_rc.magic.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !( ((*self_rc.magic() == "DDS ".to_string()) || (*self_rc.magic() == "    ".to_string())) ) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/seq/0".to_string() }));
        }
        if *self_rc.magic() == "DDS ".to_string() {
            let t = Self::read_into::<_, Dds_DdsHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.header.borrow_mut() = t;
        }
        if *self_rc.magic() != "DDS ".to_string() {
            let t = Self::read_into::<_, Dds_BiowareDdsHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.bioware_header.borrow_mut() = t;
        }
        *self_rc.pixel_data.borrow_mut() = _io.read_bytes_full()?.into();
        Ok(())
    }
}
impl Dds {
}

/**
 * File magic. Either "DDS " (0x44445320) for standard DDS,
 * or check for BioWare variant (no magic, starts with width/height).
 */
impl Dds {
    pub fn magic(&self) -> Ref<'_, String> {
        self.magic.borrow()
    }
}

/**
 * Standard DDS header (124 bytes) - only present if magic is "DDS "
 */
impl Dds {
    pub fn header(&self) -> Ref<'_, OptRc<Dds_DdsHeader>> {
        self.header.borrow()
    }
}

/**
 * BioWare DDS variant header - only present if magic is not "DDS "
 */
impl Dds {
    pub fn bioware_header(&self) -> Ref<'_, OptRc<Dds_BiowareDdsHeader>> {
        self.bioware_header.borrow()
    }
}

/**
 * Pixel data (compressed or uncompressed); single blob to EOF.
 * For standard DDS: format determined by DDPIXELFORMAT.
 * For BioWare DDS: DXT1 or DXT5 compressed data.
 */
impl Dds {
    pub fn pixel_data(&self) -> Ref<'_, Vec<u8>> {
        self.pixel_data.borrow()
    }
}
impl Dds {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Dds_BiowareDdsHeader {
    pub _root: SharedType<Dds>,
    pub _parent: SharedType<Dds>,
    pub _self: SharedType<Self>,
    width: RefCell<u32>,
    height: RefCell<u32>,
    bytes_per_pixel: RefCell<BiowareCommon_BiowareDdsVariantBytesPerPixel>,
    data_size: RefCell<u32>,
    unused_float: RefCell<f32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Dds_BiowareDdsHeader {
    type Root = Dds;
    type Parent = Dds;

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
        *self_rc.width.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.height.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.bytes_per_pixel.borrow_mut() = (_io.read_u4le()? as i64).try_into()?;
        *self_rc.data_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unused_float.borrow_mut() = _io.read_f4le()?.into();
        Ok(())
    }
}
impl Dds_BiowareDdsHeader {
}

/**
 * Image width in pixels (must be power of two, < 0x8000)
 */
impl Dds_BiowareDdsHeader {
    pub fn width(&self) -> Ref<'_, u32> {
        self.width.borrow()
    }
}

/**
 * Image height in pixels (must be power of two, < 0x8000)
 */
impl Dds_BiowareDdsHeader {
    pub fn height(&self) -> Ref<'_, u32> {
        self.height.borrow()
    }
}

/**
 * BioWare variant "bytes per pixel" (`u4`): DXT1 vs DXT5 block stride hint. Canonical: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
 */
impl Dds_BiowareDdsHeader {
    pub fn bytes_per_pixel(&self) -> Ref<'_, BiowareCommon_BiowareDdsVariantBytesPerPixel> {
        self.bytes_per_pixel.borrow()
    }
}

/**
 * Total compressed data size.
 * Must match (width*height)/2 for DXT1 or width*height for DXT5
 */
impl Dds_BiowareDdsHeader {
    pub fn data_size(&self) -> Ref<'_, u32> {
        self.data_size.borrow()
    }
}

/**
 * Unused float field (typically 0.0)
 */
impl Dds_BiowareDdsHeader {
    pub fn unused_float(&self) -> Ref<'_, f32> {
        self.unused_float.borrow()
    }
}
impl Dds_BiowareDdsHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Dds_Ddpixelformat {
    pub _root: SharedType<Dds>,
    pub _parent: SharedType<Dds_DdsHeader>,
    pub _self: SharedType<Self>,
    size: RefCell<u32>,
    flags: RefCell<u32>,
    fourcc: RefCell<String>,
    rgb_bit_count: RefCell<u32>,
    r_bit_mask: RefCell<u32>,
    g_bit_mask: RefCell<u32>,
    b_bit_mask: RefCell<u32>,
    a_bit_mask: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Dds_Ddpixelformat {
    type Root = Dds;
    type Parent = Dds_DdsHeader;

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
        *self_rc.size.borrow_mut() = _io.read_u4le()?.into();
        if !(((*self_rc.size() as u32) == (32 as u32))) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/ddpixelformat/seq/0".to_string() }));
        }
        *self_rc.flags.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.fourcc.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        *self_rc.rgb_bit_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.r_bit_mask.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.g_bit_mask.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.b_bit_mask.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.a_bit_mask.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Dds_Ddpixelformat {
}

/**
 * Structure size (must be 32)
 */
impl Dds_Ddpixelformat {
    pub fn size(&self) -> Ref<'_, u32> {
        self.size.borrow()
    }
}

/**
 * Pixel format flags:
 * - 0x00000001 = DDPF_ALPHAPIXELS
 * - 0x00000002 = DDPF_ALPHA
 * - 0x00000004 = DDPF_FOURCC
 * - 0x00000040 = DDPF_RGB
 * - 0x00000200 = DDPF_YUV
 * - 0x00080000 = DDPF_LUMINANCE
 */
impl Dds_Ddpixelformat {
    pub fn flags(&self) -> Ref<'_, u32> {
        self.flags.borrow()
    }
}

/**
 * Four-character code for compressed formats:
 * - "DXT1" = DXT1 compression
 * - "DXT3" = DXT3 compression
 * - "DXT5" = DXT5 compression
 * - "    " = Uncompressed format
 */
impl Dds_Ddpixelformat {
    pub fn fourcc(&self) -> Ref<'_, String> {
        self.fourcc.borrow()
    }
}

/**
 * Bits per pixel for uncompressed formats (16, 24, or 32)
 */
impl Dds_Ddpixelformat {
    pub fn rgb_bit_count(&self) -> Ref<'_, u32> {
        self.rgb_bit_count.borrow()
    }
}

/**
 * Red channel bit mask (for uncompressed formats)
 */
impl Dds_Ddpixelformat {
    pub fn r_bit_mask(&self) -> Ref<'_, u32> {
        self.r_bit_mask.borrow()
    }
}

/**
 * Green channel bit mask (for uncompressed formats)
 */
impl Dds_Ddpixelformat {
    pub fn g_bit_mask(&self) -> Ref<'_, u32> {
        self.g_bit_mask.borrow()
    }
}

/**
 * Blue channel bit mask (for uncompressed formats)
 */
impl Dds_Ddpixelformat {
    pub fn b_bit_mask(&self) -> Ref<'_, u32> {
        self.b_bit_mask.borrow()
    }
}

/**
 * Alpha channel bit mask (for uncompressed formats)
 */
impl Dds_Ddpixelformat {
    pub fn a_bit_mask(&self) -> Ref<'_, u32> {
        self.a_bit_mask.borrow()
    }
}
impl Dds_Ddpixelformat {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Dds_DdsHeader {
    pub _root: SharedType<Dds>,
    pub _parent: SharedType<Dds>,
    pub _self: SharedType<Self>,
    size: RefCell<u32>,
    flags: RefCell<u32>,
    height: RefCell<u32>,
    width: RefCell<u32>,
    pitch_or_linear_size: RefCell<u32>,
    depth: RefCell<u32>,
    mipmap_count: RefCell<u32>,
    reserved1: RefCell<Vec<u32>>,
    pixel_format: RefCell<OptRc<Dds_Ddpixelformat>>,
    caps: RefCell<u32>,
    caps2: RefCell<u32>,
    caps3: RefCell<u32>,
    caps4: RefCell<u32>,
    reserved2: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Dds_DdsHeader {
    type Root = Dds;
    type Parent = Dds;

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
        *self_rc.size.borrow_mut() = _io.read_u4le()?.into();
        if !(((*self_rc.size() as u32) == (124 as u32))) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/dds_header/seq/0".to_string() }));
        }
        *self_rc.flags.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.height.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.width.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.pitch_or_linear_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.depth.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.mipmap_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.reserved1.borrow_mut() = Vec::new();
        let l_reserved1 = 11;
        for _i in 0..l_reserved1 {
            self_rc.reserved1.borrow_mut().push(_io.read_u4le()?.into());
        }
        let t = Self::read_into::<_, Dds_Ddpixelformat>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.pixel_format.borrow_mut() = t;
        *self_rc.caps.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.caps2.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.caps3.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.caps4.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.reserved2.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Dds_DdsHeader {
}

/**
 * Header size (must be 124)
 */
impl Dds_DdsHeader {
    pub fn size(&self) -> Ref<'_, u32> {
        self.size.borrow()
    }
}

/**
 * DDS flags bitfield:
 * - 0x00001007 = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT
 * - 0x00020000 = DDSD_MIPMAPCOUNT (if mipmaps present)
 */
impl Dds_DdsHeader {
    pub fn flags(&self) -> Ref<'_, u32> {
        self.flags.borrow()
    }
}

/**
 * Image height in pixels
 */
impl Dds_DdsHeader {
    pub fn height(&self) -> Ref<'_, u32> {
        self.height.borrow()
    }
}

/**
 * Image width in pixels
 */
impl Dds_DdsHeader {
    pub fn width(&self) -> Ref<'_, u32> {
        self.width.borrow()
    }
}

/**
 * Pitch (uncompressed) or linear size (compressed).
 * For compressed formats: total size of all mip levels
 */
impl Dds_DdsHeader {
    pub fn pitch_or_linear_size(&self) -> Ref<'_, u32> {
        self.pitch_or_linear_size.borrow()
    }
}

/**
 * Depth for volume textures (usually 0 for 2D textures)
 */
impl Dds_DdsHeader {
    pub fn depth(&self) -> Ref<'_, u32> {
        self.depth.borrow()
    }
}

/**
 * Number of mipmap levels (0 or 1 = no mipmaps)
 */
impl Dds_DdsHeader {
    pub fn mipmap_count(&self) -> Ref<'_, u32> {
        self.mipmap_count.borrow()
    }
}

/**
 * Reserved fields (unused)
 */
impl Dds_DdsHeader {
    pub fn reserved1(&self) -> Ref<'_, Vec<u32>> {
        self.reserved1.borrow()
    }
}

/**
 * Pixel format structure
 */
impl Dds_DdsHeader {
    pub fn pixel_format(&self) -> Ref<'_, OptRc<Dds_Ddpixelformat>> {
        self.pixel_format.borrow()
    }
}

/**
 * Capability flags:
 * - 0x00001000 = DDSCAPS_TEXTURE
 * - 0x00000008 = DDSCAPS_MIPMAP
 * - 0x00000200 = DDSCAPS2_CUBEMAP
 */
impl Dds_DdsHeader {
    pub fn caps(&self) -> Ref<'_, u32> {
        self.caps.borrow()
    }
}

/**
 * Additional capability flags:
 * - 0x00000200 = DDSCAPS2_CUBEMAP
 * - 0x00000FC00 = Cube map face flags
 */
impl Dds_DdsHeader {
    pub fn caps2(&self) -> Ref<'_, u32> {
        self.caps2.borrow()
    }
}

/**
 * Reserved capability flags
 */
impl Dds_DdsHeader {
    pub fn caps3(&self) -> Ref<'_, u32> {
        self.caps3.borrow()
    }
}

/**
 * Reserved capability flags
 */
impl Dds_DdsHeader {
    pub fn caps4(&self) -> Ref<'_, u32> {
        self.caps4.borrow()
    }
}

/**
 * Reserved field
 */
impl Dds_DdsHeader {
    pub fn reserved2(&self) -> Ref<'_, u32> {
        self.reserved2.borrow()
    }
}
impl Dds_DdsHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
