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
 * **KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
 * Resource types use `bioware_type_ids`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key PyKotor wiki — KEY
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/key/io_key.py#L26-L183 PyKotor — `io_key` (Kaitai + legacy + header write)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/keyreader.cpp#L26-L80 reone — `KeyReader`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp#L50-L88 xoreos — `KEYFile::load`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L192-L210 xoreos-tools — `openKEYs` / `openKEYDataFiles`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/key.html xoreos-docs — Torlack key.html
 */

#[derive(Default, Debug, Clone)]
pub struct Key {
    pub _root: SharedType<Key>,
    pub _parent: SharedType<Key>,
    pub _self: SharedType<Self>,
    file_type: RefCell<String>,
    file_version: RefCell<String>,
    bif_count: RefCell<u32>,
    key_count: RefCell<u32>,
    file_table_offset: RefCell<u32>,
    key_table_offset: RefCell<u32>,
    build_year: RefCell<u32>,
    build_day: RefCell<u32>,
    reserved: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
    f_file_table: Cell<bool>,
    file_table: RefCell<OptRc<Key_FileTable>>,
    f_key_table: Cell<bool>,
    key_table: RefCell<OptRc<Key_KeyTable>>,
}
impl KStruct for Key {
    type Root = Key;
    type Parent = Key;

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
        if !(*self_rc.file_type() == "KEY ".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/0".to_string() }));
        }
        *self_rc.file_version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !( ((*self_rc.file_version() == "V1  ".to_string()) || (*self_rc.file_version() == "V1.1".to_string())) ) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/seq/1".to_string() }));
        }
        *self_rc.bif_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.key_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.file_table_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.key_table_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.build_year.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.build_day.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.reserved.borrow_mut() = _io.read_bytes(32 as usize)?.into();
        Ok(())
    }
}
impl Key {

    /**
     * File table containing BIF file entries.
     */
    pub fn file_table(
        &self
    ) -> KResult<Ref<'_, OptRc<Key_FileTable>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_file_table.get() {
            return Ok(self.file_table.borrow());
        }
        if ((*self.bif_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.file_table_offset() as usize)?;
            let t = Self::read_into::<_, Key_FileTable>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.file_table.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.file_table.borrow())
    }

    /**
     * KEY table containing resource entries.
     */
    pub fn key_table(
        &self
    ) -> KResult<Ref<'_, OptRc<Key_KeyTable>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_key_table.get() {
            return Ok(self.key_table.borrow());
        }
        if ((*self.key_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.key_table_offset() as usize)?;
            let t = Self::read_into::<_, Key_KeyTable>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.key_table.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.key_table.borrow())
    }
}

/**
 * File type signature. Must be "KEY " (space-padded).
 */
impl Key {
    pub fn file_type(&self) -> Ref<'_, String> {
        self.file_type.borrow()
    }
}

/**
 * File format version. Typically "V1  " or "V1.1".
 */
impl Key {
    pub fn file_version(&self) -> Ref<'_, String> {
        self.file_version.borrow()
    }
}

/**
 * Number of BIF files referenced by this KEY file.
 */
impl Key {
    pub fn bif_count(&self) -> Ref<'_, u32> {
        self.bif_count.borrow()
    }
}

/**
 * Number of resource entries in the KEY table.
 */
impl Key {
    pub fn key_count(&self) -> Ref<'_, u32> {
        self.key_count.borrow()
    }
}

/**
 * Byte offset to the file table from the beginning of the file.
 */
impl Key {
    pub fn file_table_offset(&self) -> Ref<'_, u32> {
        self.file_table_offset.borrow()
    }
}

/**
 * Byte offset to the KEY table from the beginning of the file.
 */
impl Key {
    pub fn key_table_offset(&self) -> Ref<'_, u32> {
        self.key_table_offset.borrow()
    }
}

/**
 * Build year (years since 1900).
 */
impl Key {
    pub fn build_year(&self) -> Ref<'_, u32> {
        self.build_year.borrow()
    }
}

/**
 * Build day (days since January 1).
 */
impl Key {
    pub fn build_day(&self) -> Ref<'_, u32> {
        self.build_day.borrow()
    }
}

/**
 * Reserved padding (usually zeros).
 */
impl Key {
    pub fn reserved(&self) -> Ref<'_, Vec<u8>> {
        self.reserved.borrow()
    }
}
impl Key {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Key_FileEntry {
    pub _root: SharedType<Key>,
    pub _parent: SharedType<Key_FileTable>,
    pub _self: SharedType<Self>,
    file_size: RefCell<u32>,
    filename_offset: RefCell<u32>,
    filename_size: RefCell<u16>,
    drives: RefCell<u16>,
    _io: RefCell<BytesReader>,
    f_filename: Cell<bool>,
    filename: RefCell<String>,
}
impl KStruct for Key_FileEntry {
    type Root = Key;
    type Parent = Key_FileTable;

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
        *self_rc.file_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.filename_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.filename_size.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.drives.borrow_mut() = _io.read_u2le()?.into();
        Ok(())
    }
}
impl Key_FileEntry {

    /**
     * BIF filename string at the absolute filename_offset in the KEY file.
     */
    pub fn filename(
        &self
    ) -> KResult<Ref<'_, String>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_filename.get() {
            return Ok(self.filename.borrow());
        }
        self.f_filename.set(true);
        let _pos = _io.pos();
        _io.seek(*self.filename_offset() as usize)?;
        *self.filename.borrow_mut() = bytes_to_str(&_io.read_bytes(*self.filename_size() as usize)?.into(), "ASCII")?;
        _io.seek(_pos)?;
        Ok(self.filename.borrow())
    }
}

/**
 * Size of the BIF file on disk in bytes.
 */
impl Key_FileEntry {
    pub fn file_size(&self) -> Ref<'_, u32> {
        self.file_size.borrow()
    }
}

/**
 * Absolute byte offset from the start of the KEY file where this BIF's filename is stored
 * (seek(filename_offset), then read filename_size bytes).
 * This is not relative to the file table or to the end of the BIF entry array.
 */
impl Key_FileEntry {
    pub fn filename_offset(&self) -> Ref<'_, u32> {
        self.filename_offset.borrow()
    }
}

/**
 * Length of the filename in bytes (including null terminator).
 */
impl Key_FileEntry {
    pub fn filename_size(&self) -> Ref<'_, u16> {
        self.filename_size.borrow()
    }
}

/**
 * Drive flags indicating which media contains the BIF file.
 * Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
 * Modern distributions typically use 0x0001 (HD) for all files.
 */
impl Key_FileEntry {
    pub fn drives(&self) -> Ref<'_, u16> {
        self.drives.borrow()
    }
}
impl Key_FileEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Key_FileTable {
    pub _root: SharedType<Key>,
    pub _parent: SharedType<Key>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Key_FileEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Key_FileTable {
    type Root = Key;
    type Parent = Key;

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
        let l_entries = *_r.bif_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Key_FileEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Key_FileTable {
}

/**
 * Array of BIF file entries.
 */
impl Key_FileTable {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Key_FileEntry>>> {
        self.entries.borrow()
    }
}
impl Key_FileTable {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Key_FilenameTable {
    pub _root: SharedType<Key>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    filenames: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Key_FilenameTable {
    type Root = Key;
    type Parent = KStructUnit;

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
        *self_rc.filenames.borrow_mut() = bytes_to_str(&_io.read_bytes_full()?.into(), "ASCII")?;
        Ok(())
    }
}
impl Key_FilenameTable {
}

/**
 * Null-terminated BIF filenames concatenated together.
 * Each filename is read using the filename_offset and filename_size
 * from the corresponding file_entry.
 */
impl Key_FilenameTable {
    pub fn filenames(&self) -> Ref<'_, String> {
        self.filenames.borrow()
    }
}
impl Key_FilenameTable {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Key_KeyEntry {
    pub _root: SharedType<Key>,
    pub _parent: SharedType<Key_KeyTable>,
    pub _self: SharedType<Self>,
    resref: RefCell<String>,
    resource_type: RefCell<BiowareTypeIds_XoreosFileTypeId>,
    resource_id: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Key_KeyEntry {
    type Root = Key;
    type Parent = Key_KeyTable;

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
        *self_rc.resource_type.borrow_mut() = (_io.read_u2le()? as i64).try_into()?;
        *self_rc.resource_id.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Key_KeyEntry {
}

/**
 * Resource filename (ResRef) without extension.
 * Null-padded, maximum 16 characters.
 * The game uses this name to access the resource.
 */
impl Key_KeyEntry {
    pub fn resref(&self) -> Ref<'_, String> {
        self.resref.borrow()
    }
}

/**
 * Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
 * `formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).
 */
impl Key_KeyEntry {
    pub fn resource_type(&self) -> Ref<'_, BiowareTypeIds_XoreosFileTypeId> {
        self.resource_type.borrow()
    }
}

/**
 * Encoded resource location.
 * Bits 31-20: BIF index (top 12 bits) - index into file table
 * Bits 19-0: Resource index (bottom 20 bits) - index within the BIF file
 * 
 * Formula: resource_id = (bif_index << 20) | resource_index
 * 
 * Decoding:
 * - bif_index = (resource_id >> 20) & 0xFFF
 * - resource_index = resource_id & 0xFFFFF
 */
impl Key_KeyEntry {
    pub fn resource_id(&self) -> Ref<'_, u32> {
        self.resource_id.borrow()
    }
}
impl Key_KeyEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Key_KeyTable {
    pub _root: SharedType<Key>,
    pub _parent: SharedType<Key>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Key_KeyEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Key_KeyTable {
    type Root = Key;
    type Parent = Key;

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
        let l_entries = *_r.key_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Key_KeyEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Key_KeyTable {
}

/**
 * Array of resource entries.
 */
impl Key_KeyTable {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Key_KeyEntry>>> {
        self.entries.borrow()
    }
}
impl Key_KeyTable {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
