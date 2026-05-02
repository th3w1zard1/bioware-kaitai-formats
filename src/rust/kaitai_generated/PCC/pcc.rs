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
use super::bioware_common::BiowareCommon_BiowarePccCompressionCodec;
use super::bioware_common::BiowareCommon_BiowarePccPackageKind;

/**
 * **PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
 * tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).
 * 
 * **Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60 xoreos — `FileType` enum start (Aurora/BioWare family IDs; **PCC/Unreal packages are not in this table** — included only as canonical upstream anchor for “what this repo’s xoreos stack is”)
 * \sa https://github.com/ME3Tweaks/LegendaryExplorer/wiki/PCC-File-Format ME3Tweaks — PCC file format
 * \sa https://github.com/ME3Tweaks/LegendaryExplorer/wiki/Package-Handling ME3Tweaks — Package handling (export/import tables, UE3-era BioWare packages)
 * \sa https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/docs/XOREOS_FORMAT_COVERAGE.md In-tree — coverage matrix (PCC is out-of-xoreos Aurora scope; see table)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (KotOR-era PDFs; PCC is Mass Effect / UE3 — use LegendaryExplorer wiki as wire authority)
 */

#[derive(Default, Debug, Clone)]
pub struct Pcc {
    pub _root: SharedType<Pcc>,
    pub _parent: SharedType<Pcc>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Pcc_FileHeader>>,
    _io: RefCell<BytesReader>,
    f_compression_type: Cell<bool>,
    compression_type: RefCell<BiowareCommon_BiowarePccCompressionCodec>,
    f_export_table: Cell<bool>,
    export_table: RefCell<OptRc<Pcc_ExportTable>>,
    f_import_table: Cell<bool>,
    import_table: RefCell<OptRc<Pcc_ImportTable>>,
    f_is_compressed: Cell<bool>,
    is_compressed: RefCell<bool>,
    f_name_table: Cell<bool>,
    name_table: RefCell<OptRc<Pcc_NameTable>>,
}
impl KStruct for Pcc {
    type Root = Pcc;
    type Parent = Pcc;

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
        let t = Self::read_into::<_, Pcc_FileHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        Ok(())
    }
}
impl Pcc {

    /**
     * Compression algorithm used (0=None, 1=Zlib, 2=LZO).
     */
    pub fn compression_type(
        &self
    ) -> KResult<Ref<'_, BiowareCommon_BiowarePccCompressionCodec>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_compression_type.get() {
            return Ok(self.compression_type.borrow());
        }
        self.f_compression_type.set(true);
        *self.compression_type.borrow_mut() = self.header().compression_type();
        Ok(self.compression_type.borrow())
    }

    /**
     * Table containing all objects exported from this package.
     */
    pub fn export_table(
        &self
    ) -> KResult<Ref<'_, OptRc<Pcc_ExportTable>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_export_table.get() {
            return Ok(self.export_table.borrow());
        }
        if ((*self.header().export_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().export_table_offset() as usize)?;
            let t = Self::read_into::<_, Pcc_ExportTable>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.export_table.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.export_table.borrow())
    }

    /**
     * Table containing references to external packages and classes.
     */
    pub fn import_table(
        &self
    ) -> KResult<Ref<'_, OptRc<Pcc_ImportTable>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_import_table.get() {
            return Ok(self.import_table.borrow());
        }
        if ((*self.header().import_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().import_table_offset() as usize)?;
            let t = Self::read_into::<_, Pcc_ImportTable>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.import_table.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.import_table.borrow())
    }

    /**
     * True if package uses compressed chunks (bit 25 of package_flags).
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
        *self.is_compressed.borrow_mut() = (((((*self.header().package_flags() as i32) & (33554432 as i32)) as i32) != (0 as i32))) as bool;
        Ok(self.is_compressed.borrow())
    }

    /**
     * Table containing all string names used in the package.
     */
    pub fn name_table(
        &self
    ) -> KResult<Ref<'_, OptRc<Pcc_NameTable>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_name_table.get() {
            return Ok(self.name_table.borrow());
        }
        if ((*self.header().name_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().name_table_offset() as usize)?;
            let t = Self::read_into::<_, Pcc_NameTable>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.name_table.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.name_table.borrow())
    }
}

/**
 * File header containing format metadata and table offsets.
 */
impl Pcc {
    pub fn header(&self) -> Ref<'_, OptRc<Pcc_FileHeader>> {
        self.header.borrow()
    }
}
impl Pcc {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Pcc_ExportEntry {
    pub _root: SharedType<Pcc>,
    pub _parent: SharedType<Pcc_ExportTable>,
    pub _self: SharedType<Self>,
    class_index: RefCell<i32>,
    super_class_index: RefCell<i32>,
    link: RefCell<i32>,
    object_name_index: RefCell<i32>,
    object_name_number: RefCell<i32>,
    archetype_index: RefCell<i32>,
    object_flags: RefCell<u64>,
    data_size: RefCell<u32>,
    data_offset: RefCell<u32>,
    unknown1: RefCell<u32>,
    num_components: RefCell<i32>,
    unknown2: RefCell<u32>,
    guid: RefCell<OptRc<Pcc_Guid>>,
    components: RefCell<Vec<i32>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Pcc_ExportEntry {
    type Root = Pcc;
    type Parent = Pcc_ExportTable;

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
        *self_rc.class_index.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.super_class_index.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.link.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.object_name_index.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.object_name_number.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.archetype_index.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.object_flags.borrow_mut() = _io.read_u8le()?.into();
        *self_rc.data_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.data_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown1.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.num_components.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.unknown2.borrow_mut() = _io.read_u4le()?.into();
        let t = Self::read_into::<_, Pcc_Guid>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.guid.borrow_mut() = t;
        if ((*self_rc.num_components() as i32) > (0 as i32)) {
            *self_rc.components.borrow_mut() = Vec::new();
            let l_components = *self_rc.num_components();
            for _i in 0..l_components {
                self_rc.components.borrow_mut().push(_io.read_s4le()?.into());
            }
        }
        Ok(())
    }
}
impl Pcc_ExportEntry {
}

/**
 * Object index for the class.
 * Negative = import table index
 * Positive = export table index
 * Zero = no class
 */
impl Pcc_ExportEntry {
    pub fn class_index(&self) -> Ref<'_, i32> {
        self.class_index.borrow()
    }
}

/**
 * Object index for the super class.
 * Negative = import table index
 * Positive = export table index
 * Zero = no super class
 */
impl Pcc_ExportEntry {
    pub fn super_class_index(&self) -> Ref<'_, i32> {
        self.super_class_index.borrow()
    }
}

/**
 * Link to other objects (internal reference).
 */
impl Pcc_ExportEntry {
    pub fn link(&self) -> Ref<'_, i32> {
        self.link.borrow()
    }
}

/**
 * Index into name table for the object name.
 */
impl Pcc_ExportEntry {
    pub fn object_name_index(&self) -> Ref<'_, i32> {
        self.object_name_index.borrow()
    }
}

/**
 * Object name number (for duplicate names).
 */
impl Pcc_ExportEntry {
    pub fn object_name_number(&self) -> Ref<'_, i32> {
        self.object_name_number.borrow()
    }
}

/**
 * Object index for the archetype.
 * Negative = import table index
 * Positive = export table index
 * Zero = no archetype
 */
impl Pcc_ExportEntry {
    pub fn archetype_index(&self) -> Ref<'_, i32> {
        self.archetype_index.borrow()
    }
}

/**
 * Object flags bitfield (64-bit).
 */
impl Pcc_ExportEntry {
    pub fn object_flags(&self) -> Ref<'_, u64> {
        self.object_flags.borrow()
    }
}

/**
 * Size of the export data in bytes.
 */
impl Pcc_ExportEntry {
    pub fn data_size(&self) -> Ref<'_, u32> {
        self.data_size.borrow()
    }
}

/**
 * Byte offset to the export data from the beginning of the file.
 */
impl Pcc_ExportEntry {
    pub fn data_offset(&self) -> Ref<'_, u32> {
        self.data_offset.borrow()
    }
}

/**
 * Unknown field.
 */
impl Pcc_ExportEntry {
    pub fn unknown1(&self) -> Ref<'_, u32> {
        self.unknown1.borrow()
    }
}

/**
 * Number of component entries (can be negative).
 */
impl Pcc_ExportEntry {
    pub fn num_components(&self) -> Ref<'_, i32> {
        self.num_components.borrow()
    }
}

/**
 * Unknown field.
 */
impl Pcc_ExportEntry {
    pub fn unknown2(&self) -> Ref<'_, u32> {
        self.unknown2.borrow()
    }
}

/**
 * GUID for this export object.
 */
impl Pcc_ExportEntry {
    pub fn guid(&self) -> Ref<'_, OptRc<Pcc_Guid>> {
        self.guid.borrow()
    }
}

/**
 * Array of component indices.
 * Only present if num_components > 0.
 */
impl Pcc_ExportEntry {
    pub fn components(&self) -> Ref<'_, Vec<i32>> {
        self.components.borrow()
    }
}
impl Pcc_ExportEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Pcc_ExportTable {
    pub _root: SharedType<Pcc>,
    pub _parent: SharedType<Pcc>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Pcc_ExportEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Pcc_ExportTable {
    type Root = Pcc;
    type Parent = Pcc;

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
        let l_entries = *_r.header().export_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Pcc_ExportEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Pcc_ExportTable {
}

/**
 * Array of export entries.
 */
impl Pcc_ExportTable {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Pcc_ExportEntry>>> {
        self.entries.borrow()
    }
}
impl Pcc_ExportTable {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Pcc_FileHeader {
    pub _root: SharedType<Pcc>,
    pub _parent: SharedType<Pcc>,
    pub _self: SharedType<Self>,
    magic: RefCell<u32>,
    version: RefCell<u32>,
    licensee_version: RefCell<u32>,
    header_size: RefCell<i32>,
    package_name: RefCell<String>,
    package_flags: RefCell<u32>,
    package_type: RefCell<BiowareCommon_BiowarePccPackageKind>,
    name_count: RefCell<u32>,
    name_table_offset: RefCell<u32>,
    export_count: RefCell<u32>,
    export_table_offset: RefCell<u32>,
    import_count: RefCell<u32>,
    import_table_offset: RefCell<u32>,
    depend_offset: RefCell<u32>,
    depend_count: RefCell<u32>,
    guid_part1: RefCell<u32>,
    guid_part2: RefCell<u32>,
    guid_part3: RefCell<u32>,
    guid_part4: RefCell<u32>,
    generations: RefCell<u32>,
    export_count_dup: RefCell<u32>,
    name_count_dup: RefCell<u32>,
    unknown1: RefCell<u32>,
    engine_version: RefCell<u32>,
    cooker_version: RefCell<u32>,
    compression_flags: RefCell<u32>,
    package_source: RefCell<u32>,
    compression_type: RefCell<BiowareCommon_BiowarePccCompressionCodec>,
    chunk_count: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Pcc_FileHeader {
    type Root = Pcc;
    type Parent = Pcc;

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
        *self_rc.magic.borrow_mut() = _io.read_u4le()?.into();
        if !(((*self_rc.magic() as i32) == (2653586369 as i32))) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/file_header/seq/0".to_string() }));
        }
        *self_rc.version.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.licensee_version.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.header_size.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.package_name.borrow_mut() = bytes_to_str(&_io.read_bytes(10 as usize)?.into(), "UTF-16LE")?;
        *self_rc.package_flags.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.package_type.borrow_mut() = (_io.read_u4le()? as i64).try_into()?;
        *self_rc.name_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.name_table_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.export_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.export_table_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.import_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.import_table_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.depend_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.depend_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.guid_part1.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.guid_part2.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.guid_part3.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.guid_part4.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.generations.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.export_count_dup.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.name_count_dup.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown1.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.engine_version.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.cooker_version.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.compression_flags.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.package_source.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.compression_type.borrow_mut() = (_io.read_u4le()? as i64).try_into()?;
        *self_rc.chunk_count.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Pcc_FileHeader {
}

/**
 * Magic number identifying PCC format. Must be 0x9E2A83C1.
 */
impl Pcc_FileHeader {
    pub fn magic(&self) -> Ref<'_, u32> {
        self.magic.borrow()
    }
}

/**
 * File format version.
 * Encoded as: (major << 16) | (minor << 8) | patch
 * Example: 0xC202AC = 194/684 (major=194, minor=684)
 */
impl Pcc_FileHeader {
    pub fn version(&self) -> Ref<'_, u32> {
        self.version.borrow()
    }
}

/**
 * Licensee-specific version field (typically 0x67C).
 */
impl Pcc_FileHeader {
    pub fn licensee_version(&self) -> Ref<'_, u32> {
        self.licensee_version.borrow()
    }
}

/**
 * Header size field (typically -5 = 0xFFFFFFFB).
 */
impl Pcc_FileHeader {
    pub fn header_size(&self) -> Ref<'_, i32> {
        self.header_size.borrow()
    }
}

/**
 * Package name (typically "None" = 0x4E006F006E006500).
 */
impl Pcc_FileHeader {
    pub fn package_name(&self) -> Ref<'_, String> {
        self.package_name.borrow()
    }
}

/**
 * Package flags bitfield.
 * Bit 25 (0x2000000): Compressed package
 * Bit 20 (0x100000): ME3Explorer edited format flag
 * Other bits: Various package attributes
 */
impl Pcc_FileHeader {
    pub fn package_flags(&self) -> Ref<'_, u32> {
        self.package_flags.borrow()
    }
}

/**
 * Package type indicator (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_package_kind`
 * (LegendaryExplorer PCC wiki).
 */
impl Pcc_FileHeader {
    pub fn package_type(&self) -> Ref<'_, BiowareCommon_BiowarePccPackageKind> {
        self.package_type.borrow()
    }
}

/**
 * Number of entries in the name table.
 */
impl Pcc_FileHeader {
    pub fn name_count(&self) -> Ref<'_, u32> {
        self.name_count.borrow()
    }
}

/**
 * Byte offset to the name table from the beginning of the file.
 */
impl Pcc_FileHeader {
    pub fn name_table_offset(&self) -> Ref<'_, u32> {
        self.name_table_offset.borrow()
    }
}

/**
 * Number of entries in the export table.
 */
impl Pcc_FileHeader {
    pub fn export_count(&self) -> Ref<'_, u32> {
        self.export_count.borrow()
    }
}

/**
 * Byte offset to the export table from the beginning of the file.
 */
impl Pcc_FileHeader {
    pub fn export_table_offset(&self) -> Ref<'_, u32> {
        self.export_table_offset.borrow()
    }
}

/**
 * Number of entries in the import table.
 */
impl Pcc_FileHeader {
    pub fn import_count(&self) -> Ref<'_, u32> {
        self.import_count.borrow()
    }
}

/**
 * Byte offset to the import table from the beginning of the file.
 */
impl Pcc_FileHeader {
    pub fn import_table_offset(&self) -> Ref<'_, u32> {
        self.import_table_offset.borrow()
    }
}

/**
 * Offset to dependency table (typically 0x664).
 */
impl Pcc_FileHeader {
    pub fn depend_offset(&self) -> Ref<'_, u32> {
        self.depend_offset.borrow()
    }
}

/**
 * Number of dependencies (typically 0x67C).
 */
impl Pcc_FileHeader {
    pub fn depend_count(&self) -> Ref<'_, u32> {
        self.depend_count.borrow()
    }
}

/**
 * First 32 bits of package GUID.
 */
impl Pcc_FileHeader {
    pub fn guid_part1(&self) -> Ref<'_, u32> {
        self.guid_part1.borrow()
    }
}

/**
 * Second 32 bits of package GUID.
 */
impl Pcc_FileHeader {
    pub fn guid_part2(&self) -> Ref<'_, u32> {
        self.guid_part2.borrow()
    }
}

/**
 * Third 32 bits of package GUID.
 */
impl Pcc_FileHeader {
    pub fn guid_part3(&self) -> Ref<'_, u32> {
        self.guid_part3.borrow()
    }
}

/**
 * Fourth 32 bits of package GUID.
 */
impl Pcc_FileHeader {
    pub fn guid_part4(&self) -> Ref<'_, u32> {
        self.guid_part4.borrow()
    }
}

/**
 * Number of generation entries.
 */
impl Pcc_FileHeader {
    pub fn generations(&self) -> Ref<'_, u32> {
        self.generations.borrow()
    }
}

/**
 * Duplicate export count (should match export_count).
 */
impl Pcc_FileHeader {
    pub fn export_count_dup(&self) -> Ref<'_, u32> {
        self.export_count_dup.borrow()
    }
}

/**
 * Duplicate name count (should match name_count).
 */
impl Pcc_FileHeader {
    pub fn name_count_dup(&self) -> Ref<'_, u32> {
        self.name_count_dup.borrow()
    }
}

/**
 * Unknown field (typically 0x0).
 */
impl Pcc_FileHeader {
    pub fn unknown1(&self) -> Ref<'_, u32> {
        self.unknown1.borrow()
    }
}

/**
 * Engine version (typically 0x18EF = 6383).
 */
impl Pcc_FileHeader {
    pub fn engine_version(&self) -> Ref<'_, u32> {
        self.engine_version.borrow()
    }
}

/**
 * Cooker version (typically 0x3006B = 196715).
 */
impl Pcc_FileHeader {
    pub fn cooker_version(&self) -> Ref<'_, u32> {
        self.cooker_version.borrow()
    }
}

/**
 * Compression flags (typically 0x15330000).
 */
impl Pcc_FileHeader {
    pub fn compression_flags(&self) -> Ref<'_, u32> {
        self.compression_flags.borrow()
    }
}

/**
 * Package source identifier (typically 0x8AA0000).
 */
impl Pcc_FileHeader {
    pub fn package_source(&self) -> Ref<'_, u32> {
        self.package_source.borrow()
    }
}

/**
 * Compression codec when package is compressed (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_compression_codec`
 * (LegendaryExplorer PCC wiki). Unused / undefined when uncompressed.
 */
impl Pcc_FileHeader {
    pub fn compression_type(&self) -> Ref<'_, BiowareCommon_BiowarePccCompressionCodec> {
        self.compression_type.borrow()
    }
}

/**
 * Number of compressed chunks (0 for uncompressed, 1 for compressed).
 * If > 0, file uses compressed structure with chunks.
 */
impl Pcc_FileHeader {
    pub fn chunk_count(&self) -> Ref<'_, u32> {
        self.chunk_count.borrow()
    }
}
impl Pcc_FileHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Pcc_Guid {
    pub _root: SharedType<Pcc>,
    pub _parent: SharedType<Pcc_ExportEntry>,
    pub _self: SharedType<Self>,
    part1: RefCell<u32>,
    part2: RefCell<u32>,
    part3: RefCell<u32>,
    part4: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Pcc_Guid {
    type Root = Pcc;
    type Parent = Pcc_ExportEntry;

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
        *self_rc.part1.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.part2.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.part3.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.part4.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Pcc_Guid {
}

/**
 * First 32 bits of GUID.
 */
impl Pcc_Guid {
    pub fn part1(&self) -> Ref<'_, u32> {
        self.part1.borrow()
    }
}

/**
 * Second 32 bits of GUID.
 */
impl Pcc_Guid {
    pub fn part2(&self) -> Ref<'_, u32> {
        self.part2.borrow()
    }
}

/**
 * Third 32 bits of GUID.
 */
impl Pcc_Guid {
    pub fn part3(&self) -> Ref<'_, u32> {
        self.part3.borrow()
    }
}

/**
 * Fourth 32 bits of GUID.
 */
impl Pcc_Guid {
    pub fn part4(&self) -> Ref<'_, u32> {
        self.part4.borrow()
    }
}
impl Pcc_Guid {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Pcc_ImportEntry {
    pub _root: SharedType<Pcc>,
    pub _parent: SharedType<Pcc_ImportTable>,
    pub _self: SharedType<Self>,
    package_name_index: RefCell<i64>,
    class_name_index: RefCell<i32>,
    link: RefCell<i64>,
    import_name_index: RefCell<i64>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Pcc_ImportEntry {
    type Root = Pcc;
    type Parent = Pcc_ImportTable;

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
        *self_rc.package_name_index.borrow_mut() = _io.read_s8le()?.into();
        *self_rc.class_name_index.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.link.borrow_mut() = _io.read_s8le()?.into();
        *self_rc.import_name_index.borrow_mut() = _io.read_s8le()?.into();
        Ok(())
    }
}
impl Pcc_ImportEntry {
}

/**
 * Index into name table for package name.
 * Negative value indicates import from external package.
 * Positive value indicates import from this package.
 */
impl Pcc_ImportEntry {
    pub fn package_name_index(&self) -> Ref<'_, i64> {
        self.package_name_index.borrow()
    }
}

/**
 * Index into name table for class name.
 */
impl Pcc_ImportEntry {
    pub fn class_name_index(&self) -> Ref<'_, i32> {
        self.class_name_index.borrow()
    }
}

/**
 * Link to import/export table entry.
 * Used to resolve the actual object reference.
 */
impl Pcc_ImportEntry {
    pub fn link(&self) -> Ref<'_, i64> {
        self.link.borrow()
    }
}

/**
 * Index into name table for the imported object name.
 */
impl Pcc_ImportEntry {
    pub fn import_name_index(&self) -> Ref<'_, i64> {
        self.import_name_index.borrow()
    }
}
impl Pcc_ImportEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Pcc_ImportTable {
    pub _root: SharedType<Pcc>,
    pub _parent: SharedType<Pcc>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Pcc_ImportEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Pcc_ImportTable {
    type Root = Pcc;
    type Parent = Pcc;

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
        let l_entries = *_r.header().import_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Pcc_ImportEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Pcc_ImportTable {
}

/**
 * Array of import entries.
 */
impl Pcc_ImportTable {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Pcc_ImportEntry>>> {
        self.entries.borrow()
    }
}
impl Pcc_ImportTable {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Pcc_NameEntry {
    pub _root: SharedType<Pcc>,
    pub _parent: SharedType<Pcc_NameTable>,
    pub _self: SharedType<Self>,
    length: RefCell<i32>,
    name: RefCell<String>,
    _io: RefCell<BytesReader>,
    f_abs_length: Cell<bool>,
    abs_length: RefCell<i32>,
    f_name_size: Cell<bool>,
    name_size: RefCell<i32>,
}
impl KStruct for Pcc_NameEntry {
    type Root = Pcc;
    type Parent = Pcc_NameTable;

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
        *self_rc.name.borrow_mut() = bytes_to_str(&_io.read_bytes(((if ((*self_rc.length() as i32) < (0 as i32)) { -(*self_rc.length()) } else { *self_rc.length() } as i32) * (2 as i32)) as usize)?.into(), "UTF-16LE")?;
        Ok(())
    }
}
impl Pcc_NameEntry {

    /**
     * Absolute value of length for size calculation
     */
    pub fn abs_length(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_abs_length.get() {
            return Ok(self.abs_length.borrow());
        }
        self.f_abs_length.set(true);
        *self.abs_length.borrow_mut() = (if ((*self.length() as i32) < (0 as i32)) { -(*self.length()) } else { *self.length() }) as i32;
        Ok(self.abs_length.borrow())
    }

    /**
     * Size of name string in bytes (absolute length * 2 bytes per WCHAR)
     */
    pub fn name_size(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_name_size.get() {
            return Ok(self.name_size.borrow());
        }
        self.f_name_size.set(true);
        *self.name_size.borrow_mut() = (((*self.abs_length()? as i32) * (2 as i32))) as i32;
        Ok(self.name_size.borrow())
    }
}

/**
 * Length of the name string in characters (signed).
 * Negative value indicates the number of WCHAR characters.
 * Positive value is also valid but less common.
 */
impl Pcc_NameEntry {
    pub fn length(&self) -> Ref<'_, i32> {
        self.length.borrow()
    }
}

/**
 * Name string encoded as UTF-16LE (WCHAR).
 * Size is absolute value of length * 2 bytes per character.
 * Negative length indicates WCHAR count (use absolute value).
 */
impl Pcc_NameEntry {
    pub fn name(&self) -> Ref<'_, String> {
        self.name.borrow()
    }
}
impl Pcc_NameEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Pcc_NameTable {
    pub _root: SharedType<Pcc>,
    pub _parent: SharedType<Pcc>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Pcc_NameEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Pcc_NameTable {
    type Root = Pcc;
    type Parent = Pcc;

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
        let l_entries = *_r.header().name_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Pcc_NameEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Pcc_NameTable {
}

/**
 * Array of name entries.
 */
impl Pcc_NameTable {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Pcc_NameEntry>>> {
        self.entries.borrow()
    }
}
impl Pcc_NameTable {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
