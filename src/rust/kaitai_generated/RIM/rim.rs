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
use super::bioware_type_ids::BiowareTypeIds_XoreosFileTypeId;

/**
 * RIM (Resource Information Manager) files are self-contained archives used for module templates.
 * RIM files are similar to ERF files but are read-only from the game's perspective. The game
 * loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
 * RIM files store all resources inline with metadata, making them self-contained archives.
 * 
 * Format Variants:
 * - Standard RIM: Basic module template files
 * - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
 * 
 * Binary Format (KotOR / PyKotor):
 * - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
 * - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
 * - Key / resource entry table (32 bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
 * - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
 * 
 * Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim PyKotor wiki — RIM
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128 PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L35-L91 xoreos — `RIMFile::load` + `readResList`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/unrim.cpp#L55-L85 xoreos-tools — `unrim` CLI (`main`)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/rim.cpp#L43-L84 xoreos-tools — `rim` packer CLI (`main`)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html xoreos-docs — Torlack mod.html (MOD/RIM family)
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/RIMObject.ts#L69-L93 KotOR.js — `RIMObject`
 * \sa https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs NickHugi/Kotor.NET — `RIMBinaryStructure`
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/rimreader.cpp#L26-L58 reone — `RimReader`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394 xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py PyKotor — `ResourceType` (tooling superset)
 */

#[derive(Default, Debug, Clone)]
pub struct Rim {
    pub _root: SharedType<Rim>,
    pub _parent: SharedType<Rim>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Rim_RimHeader>>,
    gap_before_key_table_implicit: RefCell<Vec<u8>>,
    gap_before_key_table_explicit: RefCell<Vec<u8>>,
    resource_entry_table: RefCell<OptRc<Rim_ResourceEntryTable>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Rim {
    type Root = Rim;
    type Parent = Rim;

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
        let t = Self::read_into::<_, Rim_RimHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        if ((*self_rc.header().offset_to_resource_table() as u32) == (0 as u32)) {
            *self_rc.gap_before_key_table_implicit.borrow_mut() = _io.read_bytes(96 as usize)?.into();
        }
        if ((*self_rc.header().offset_to_resource_table() as u32) != (0 as u32)) {
            *self_rc.gap_before_key_table_explicit.borrow_mut() = _io.read_bytes(((*self_rc.header().offset_to_resource_table() as u32) - (24 as u32)) as usize)?.into();
        }
        if ((*self_rc.header().resource_count() as u32) > (0 as u32)) {
            let t = Self::read_into::<_, Rim_ResourceEntryTable>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.resource_entry_table.borrow_mut() = t;
        }
        Ok(())
    }
}
impl Rim {
}

/**
 * RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
 */
impl Rim {
    pub fn header(&self) -> Ref<'_, OptRc<Rim_RimHeader>> {
        self.header.borrow()
    }
}

/**
 * When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
 * After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
 */
impl Rim {
    pub fn gap_before_key_table_implicit(&self) -> Ref<'_, Vec<u8>> {
        self.gap_before_key_table_implicit.borrow()
    }
}

/**
 * When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
 * Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
 */
impl Rim {
    pub fn gap_before_key_table_explicit(&self) -> Ref<'_, Vec<u8>> {
        self.gap_before_key_table_explicit.borrow()
    }
}

/**
 * Array of resource entries mapping ResRefs to resource data
 */
impl Rim {
    pub fn resource_entry_table(&self) -> Ref<'_, OptRc<Rim_ResourceEntryTable>> {
        self.resource_entry_table.borrow()
    }
}
impl Rim {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Rim_ResourceEntry {
    pub _root: SharedType<Rim>,
    pub _parent: SharedType<Rim_ResourceEntryTable>,
    pub _self: SharedType<Self>,
    resref: RefCell<String>,
    resource_type: RefCell<BiowareTypeIds_XoreosFileTypeId>,
    resource_id: RefCell<u32>,
    offset_to_data: RefCell<u32>,
    num_data: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_data: Cell<bool>,
    data: RefCell<Vec<u8>>,
}
impl KStruct for Rim_ResourceEntry {
    type Root = Rim;
    type Parent = Rim_ResourceEntryTable;

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
        *self_rc.resref.borrow_mut() = bytes_to_str(&_io.read_bytes(16 as usize)?.into(), "ASCII")?;
        *self_rc.resource_type.borrow_mut() = (_io.read_u4le()? as i64).try_into()?;
        *self_rc.resource_id.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.offset_to_data.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.num_data.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Rim_ResourceEntry {

    /**
     * Raw binary data for this resource (read at specified offset)
     */
    pub fn data(
        &self
    ) -> KResult<Ref<'_, Vec<u8>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_data.get() {
            return Ok(self.data.borrow());
        }
        self.f_data.set(true);
        let _pos = _io.pos();
        _io.seek(*self.offset_to_data() as usize)?;
        *self.data.borrow_mut() = Vec::new();
        let l_data = *self.num_data();
        for _i in 0..l_data {
            self.data.borrow_mut().push(_io.read_u1()?.into());
        }
        _io.seek(_pos)?;
        Ok(self.data.borrow())
    }
}

/**
 * Resource filename (ResRef), null-padded to 16 bytes.
 * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
 * Resource names can be mixed case, though most are lowercase in practice.
 * The game engine typically lowercases ResRefs when loading.
 */
impl Rim_ResourceEntry {
    pub fn resref(&self) -> Ref<'_, String> {
        self.resref.borrow()
    }
}

/**
 * Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
 * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
 */
impl Rim_ResourceEntry {
    pub fn resource_type(&self) -> Ref<'_, BiowareTypeIds_XoreosFileTypeId> {
        self.resource_type.borrow()
    }
}

/**
 * Resource ID (index, usually sequential).
 * Typically matches the index of this entry in the resource_entry_table.
 * Used for internal reference, but not critical for parsing.
 */
impl Rim_ResourceEntry {
    pub fn resource_id(&self) -> Ref<'_, u32> {
        self.resource_id.borrow()
    }
}

/**
 * Byte offset to resource data from the beginning of the file.
 * Points to the actual binary data for this resource in resource_data_section.
 */
impl Rim_ResourceEntry {
    pub fn offset_to_data(&self) -> Ref<'_, u32> {
        self.offset_to_data.borrow()
    }
}

/**
 * Size of resource data in bytes (repeat count for raw `data` bytes).
 * Uncompressed size of the resource.
 */
impl Rim_ResourceEntry {
    pub fn num_data(&self) -> Ref<'_, u32> {
        self.num_data.borrow()
    }
}
impl Rim_ResourceEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Rim_ResourceEntryTable {
    pub _root: SharedType<Rim>,
    pub _parent: SharedType<Rim>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Rim_ResourceEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Rim_ResourceEntryTable {
    type Root = Rim;
    type Parent = Rim;

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
        let l_entries = *_r.header().resource_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Rim_ResourceEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Rim_ResourceEntryTable {
}

/**
 * Array of resource entries, one per resource in the archive
 */
impl Rim_ResourceEntryTable {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Rim_ResourceEntry>>> {
        self.entries.borrow()
    }
}
impl Rim_ResourceEntryTable {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Rim_RimHeader {
    pub _root: SharedType<Rim>,
    pub _parent: SharedType<Rim>,
    pub _self: SharedType<Self>,
    file_type: RefCell<String>,
    file_version: RefCell<String>,
    reserved: RefCell<u32>,
    resource_count: RefCell<u32>,
    offset_to_resource_table: RefCell<u32>,
    offset_to_resources: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_has_resources: Cell<bool>,
    has_resources: RefCell<bool>,
}
impl KStruct for Rim_RimHeader {
    type Root = Rim;
    type Parent = Rim;

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
        if !(*self_rc.file_type() == "RIM ".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/rim_header/seq/0".to_string() }));
        }
        *self_rc.file_version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !(*self_rc.file_version() == "V1.0".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/rim_header/seq/1".to_string() }));
        }
        *self_rc.reserved.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.resource_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.offset_to_resource_table.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.offset_to_resources.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Rim_RimHeader {

    /**
     * Whether the RIM file contains any resources
     */
    pub fn has_resources(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_resources.get() {
            return Ok(self.has_resources.borrow());
        }
        self.f_has_resources.set(true);
        *self.has_resources.borrow_mut() = (((*self.resource_count() as u32) > (0 as u32))) as bool;
        Ok(self.has_resources.borrow())
    }
}

/**
 * File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
 * This identifies the file as a RIM archive.
 */
impl Rim_RimHeader {
    pub fn file_type(&self) -> Ref<'_, String> {
        self.file_type.borrow()
    }
}

/**
 * File format version. Always "V1.0" for KotOR RIM files.
 * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
 */
impl Rim_RimHeader {
    pub fn file_version(&self) -> Ref<'_, String> {
        self.file_version.borrow()
    }
}

/**
 * Reserved field (typically 0x00000000).
 * Unknown purpose, but always set to 0 in practice.
 */
impl Rim_RimHeader {
    pub fn reserved(&self) -> Ref<'_, u32> {
        self.reserved.borrow()
    }
}

/**
 * Number of resources in the archive. This determines:
 * - Number of entries in resource_entry_table
 * - Number of resources in resource_data_section
 */
impl Rim_RimHeader {
    pub fn resource_count(&self) -> Ref<'_, u32> {
        self.resource_count.borrow()
    }
}

/**
 * Byte offset to the key / resource entry table from the beginning of the file.
 * 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
 * When non-zero, this offset is used directly (commonly 120).
 */
impl Rim_RimHeader {
    pub fn offset_to_resource_table(&self) -> Ref<'_, u32> {
        self.offset_to_resource_table.borrow()
    }
}

/**
 * Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
 * taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
 */
impl Rim_RimHeader {
    pub fn offset_to_resources(&self) -> Ref<'_, u32> {
        self.offset_to_resources.borrow()
    }
}
impl Rim_RimHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
