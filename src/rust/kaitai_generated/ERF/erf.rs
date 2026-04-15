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
 * ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
 * texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
 * ERF files store both resource names (ResRefs) and data in the same file. They also support
 * localized strings for descriptions in multiple languages.
 * 
 * Format Variants:
 * - ERF: Generic encapsulated resource file (texture packs, etc.)
 * - HAK: Hak pak file (contains override resources). Used for mod content distribution
 * - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
 * - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`
 * 
 * All variants use the same binary format structure, differing only in the file type signature.
 * 
 * Archive `resource_type` values use the shared **`bioware_type_ids::xoreos_file_type_id`** enum (xoreos `FileType`); see `formats/Common/bioware_type_ids.ksy`.
 * 
 * Binary Format Structure:
 * - Header (160 bytes): File type, version, entry counts, offsets, build date, description
 * - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
 *   include localized module names for the load screen. Each entry contains language_id (u4),
 *   string_size (u4), and string_data (UTF-8 encoded text)
 * - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
 *   - resref (16 bytes, ASCII, null-padded): Resource filename
 *   - resource_id (u4): Index into resource_list
 *   - resource_type (u2): Resource type identifier (`bioware_type_ids::xoreos_file_type_id`, xoreos `FileType`)
 *   - unused (u2): Padding/unused field (typically 0)
 * - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
 *   - offset_to_data (u4): Byte offset to resource data from beginning of file
 *   - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
 * - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
 *   in resource_list
 * 
 * File Access Pattern:
 * 1. Read header to get entry_count and offsets
 * 2. Read key_list to map ResRefs to resource_ids
 * 3. Use resource_id to index into resource_list
 * 4. Read resource data from offset_to_data with byte length len_data
 * 
 * Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_erf` / `erf_data`, xoreos `ERFFile`, xoreos-tools `unerf` / `erf`, reone `ErfReader`, KotOR.js `ERFObject`, NickHugi `Kotor.NET/Formats/KotorERF`).
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf PyKotor wiki — ERF
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf PyKotor wiki — Aurora ERF notes
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py#L22-L316 PyKotor — `io_erf` (Kaitai + legacy + `ERFBinaryWriter.write`)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L130 PyKotor — `ERFType` + `ERF` model (opening)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L50-L335 xoreos — ERF type tags + `ERFFile::load` + `readV10Header` start
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/unerf.cpp#L69-L106 xoreos-tools — `unerf` CLI (`main`)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/erf.cpp#L49-L96 xoreos-tools — `erf` packer CLI (`main`)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html xoreos-docs — Torlack mod.html
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/erfreader.cpp#L26-L92 reone — `ErfReader`
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/ERFObject.ts#L70-L115 KotOR.js — `ERFObject`
 * \sa https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorERF/ERFBinaryStructure.cs NickHugi/Kotor.NET — `ERFBinaryStructure`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/ERF_Format.pdf xoreos-docs — ERF_Format.pdf
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394 xoreos — `enum FileType` (numeric IDs in KEY/ERF/RIM tables)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py PyKotor — `ResourceType` (tooling superset; overlaps FileType for KotOR rows)
 */

#[derive(Default, Debug, Clone)]
pub struct Erf {
    pub _root: SharedType<Erf>,
    pub _parent: SharedType<Erf>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Erf_ErfHeader>>,
    _io: RefCell<BytesReader>,
    f_key_list: Cell<bool>,
    key_list: RefCell<OptRc<Erf_KeyList>>,
    f_localized_string_list: Cell<bool>,
    localized_string_list: RefCell<OptRc<Erf_LocalizedStringList>>,
    f_resource_list: Cell<bool>,
    resource_list: RefCell<OptRc<Erf_ResourceList>>,
}
impl KStruct for Erf {
    type Root = Erf;
    type Parent = Erf;

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
        let t = Self::read_into::<_, Erf_ErfHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        Ok(())
    }
}
impl Erf {

    /**
     * Array of key entries mapping ResRefs to resource indices
     */
    pub fn key_list(
        &self
    ) -> KResult<Ref<'_, OptRc<Erf_KeyList>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_key_list.get() {
            return Ok(self.key_list.borrow());
        }
        let _pos = _io.pos();
        _io.seek(*self.header().offset_to_key_list() as usize)?;
        let t = Self::read_into::<_, Erf_KeyList>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
        *self.key_list.borrow_mut() = t;
        _io.seek(_pos)?;
        Ok(self.key_list.borrow())
    }

    /**
     * Optional localized string entries for multi-language descriptions
     */
    pub fn localized_string_list(
        &self
    ) -> KResult<Ref<'_, OptRc<Erf_LocalizedStringList>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_localized_string_list.get() {
            return Ok(self.localized_string_list.borrow());
        }
        if ((*self.header().language_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().offset_to_localized_string_list() as usize)?;
            let t = Self::read_into::<_, Erf_LocalizedStringList>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.localized_string_list.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.localized_string_list.borrow())
    }

    /**
     * Array of resource entries containing offset and size information
     */
    pub fn resource_list(
        &self
    ) -> KResult<Ref<'_, OptRc<Erf_ResourceList>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_resource_list.get() {
            return Ok(self.resource_list.borrow());
        }
        let _pos = _io.pos();
        _io.seek(*self.header().offset_to_resource_list() as usize)?;
        let t = Self::read_into::<_, Erf_ResourceList>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
        *self.resource_list.borrow_mut() = t;
        _io.seek(_pos)?;
        Ok(self.resource_list.borrow())
    }
}

/**
 * ERF file header (160 bytes)
 */
impl Erf {
    pub fn header(&self) -> Ref<'_, OptRc<Erf_ErfHeader>> {
        self.header.borrow()
    }
}
impl Erf {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Erf_ErfHeader {
    pub _root: SharedType<Erf>,
    pub _parent: SharedType<Erf>,
    pub _self: SharedType<Self>,
    file_type: RefCell<String>,
    file_version: RefCell<String>,
    language_count: RefCell<u32>,
    localized_string_size: RefCell<u32>,
    entry_count: RefCell<u32>,
    offset_to_localized_string_list: RefCell<u32>,
    offset_to_key_list: RefCell<u32>,
    offset_to_resource_list: RefCell<u32>,
    build_year: RefCell<u32>,
    build_day: RefCell<u32>,
    description_strref: RefCell<i32>,
    reserved: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
    f_is_save_file: Cell<bool>,
    is_save_file: RefCell<bool>,
}
impl KStruct for Erf_ErfHeader {
    type Root = Erf;
    type Parent = Erf;

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
        if !( ((*self_rc.file_type() == "ERF ".to_string()) || (*self_rc.file_type() == "MOD ".to_string()) || (*self_rc.file_type() == "SAV ".to_string()) || (*self_rc.file_type() == "HAK ".to_string())) ) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/types/erf_header/seq/0".to_string() }));
        }
        *self_rc.file_version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !(*self_rc.file_version() == "V1.0".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/erf_header/seq/1".to_string() }));
        }
        *self_rc.language_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.localized_string_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.entry_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.offset_to_localized_string_list.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.offset_to_key_list.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.offset_to_resource_list.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.build_year.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.build_day.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.description_strref.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.reserved.borrow_mut() = _io.read_bytes(116 as usize)?.into();
        Ok(())
    }
}
impl Erf_ErfHeader {

    /**
     * Heuristic to detect save game files.
     * Save games use MOD signature but typically have description_strref = 0.
     */
    pub fn is_save_file(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_save_file.get() {
            return Ok(self.is_save_file.borrow());
        }
        self.f_is_save_file.set(true);
        *self.is_save_file.borrow_mut() = ( ((*self.file_type() == "MOD ".to_string()) && (((*self.description_strref() as i32) == (0 as i32)))) ) as bool;
        Ok(self.is_save_file.borrow())
    }
}

/**
 * File type signature. Must be one of:
 * - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
 * - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
 * - "SAV " (0x53 0x41 0x56 0x20) - Save game file
 * - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
 */
impl Erf_ErfHeader {
    pub fn file_type(&self) -> Ref<'_, String> {
        self.file_type.borrow()
    }
}

/**
 * File format version. Always "V1.0" for KotOR ERF files.
 * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
 */
impl Erf_ErfHeader {
    pub fn file_version(&self) -> Ref<'_, String> {
        self.file_version.borrow()
    }
}

/**
 * Number of localized string entries. Typically 0 for most ERF files.
 * MOD files may include localized module names for the load screen.
 */
impl Erf_ErfHeader {
    pub fn language_count(&self) -> Ref<'_, u32> {
        self.language_count.borrow()
    }
}

/**
 * Total size of localized string data in bytes.
 * Includes all language entries (language_id + string_size + string_data for each).
 */
impl Erf_ErfHeader {
    pub fn localized_string_size(&self) -> Ref<'_, u32> {
        self.localized_string_size.borrow()
    }
}

/**
 * Number of resources in the archive. This determines:
 * - Number of entries in key_list
 * - Number of entries in resource_list
 * - Number of resource data blocks stored at various offsets
 */
impl Erf_ErfHeader {
    pub fn entry_count(&self) -> Ref<'_, u32> {
        self.entry_count.borrow()
    }
}

/**
 * Byte offset to the localized string list from the beginning of the file.
 * Typically 160 (right after header) if present, or 0 if not present.
 */
impl Erf_ErfHeader {
    pub fn offset_to_localized_string_list(&self) -> Ref<'_, u32> {
        self.offset_to_localized_string_list.borrow()
    }
}

/**
 * Byte offset to the key list from the beginning of the file.
 * Typically 160 (right after header) if no localized strings, or after localized strings.
 */
impl Erf_ErfHeader {
    pub fn offset_to_key_list(&self) -> Ref<'_, u32> {
        self.offset_to_key_list.borrow()
    }
}

/**
 * Byte offset to the resource list from the beginning of the file.
 * Located after the key list.
 */
impl Erf_ErfHeader {
    pub fn offset_to_resource_list(&self) -> Ref<'_, u32> {
        self.offset_to_resource_list.borrow()
    }
}

/**
 * Build year (years since 1900).
 * Example: 103 = year 2003
 * Primarily informational, used by development tools to track module versions.
 */
impl Erf_ErfHeader {
    pub fn build_year(&self) -> Ref<'_, u32> {
        self.build_year.borrow()
    }
}

/**
 * Build day (days since January 1, with January 1 = day 1).
 * Example: 247 = September 4th (the 247th day of the year)
 * Primarily informational, used by development tools to track module versions.
 */
impl Erf_ErfHeader {
    pub fn build_day(&self) -> Ref<'_, u32> {
        self.build_day.borrow()
    }
}

/**
 * Description StrRef (TLK string reference) for the archive description.
 * Values vary by file type:
 * - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
 * - SAV files: 0 (typically no description)
 * - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
 */
impl Erf_ErfHeader {
    pub fn description_strref(&self) -> Ref<'_, i32> {
        self.description_strref.borrow()
    }
}

/**
 * Reserved padding (usually zeros).
 * Total header size is 160 bytes:
 * file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
 * entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
 * offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
 * reserved (116) = 160 bytes
 */
impl Erf_ErfHeader {
    pub fn reserved(&self) -> Ref<'_, Vec<u8>> {
        self.reserved.borrow()
    }
}
impl Erf_ErfHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Erf_KeyEntry {
    pub _root: SharedType<Erf>,
    pub _parent: SharedType<Erf_KeyList>,
    pub _self: SharedType<Self>,
    resref: RefCell<String>,
    resource_id: RefCell<u32>,
    resource_type: RefCell<BiowareTypeIds_XoreosFileTypeId>,
    unused: RefCell<u16>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Erf_KeyEntry {
    type Root = Erf;
    type Parent = Erf_KeyList;

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
        *self_rc.resource_id.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.resource_type.borrow_mut() = (_io.read_u2le()? as i64).try_into()?;
        *self_rc.unused.borrow_mut() = _io.read_u2le()?.into();
        Ok(())
    }
}
impl Erf_KeyEntry {
}

/**
 * Resource filename (ResRef), null-padded to 16 bytes.
 * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
 * Resource names can be mixed case, though most are lowercase in practice.
 */
impl Erf_KeyEntry {
    pub fn resref(&self) -> Ref<'_, String> {
        self.resref.borrow()
    }
}

/**
 * Resource ID (index into resource_list).
 * Maps this key entry to the corresponding resource entry.
 */
impl Erf_KeyEntry {
    pub fn resource_id(&self) -> Ref<'_, u32> {
        self.resource_id.borrow()
    }
}

/**
 * Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
 * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
 */
impl Erf_KeyEntry {
    pub fn resource_type(&self) -> Ref<'_, BiowareTypeIds_XoreosFileTypeId> {
        self.resource_type.borrow()
    }
}

/**
 * Padding/unused field (typically 0)
 */
impl Erf_KeyEntry {
    pub fn unused(&self) -> Ref<'_, u16> {
        self.unused.borrow()
    }
}
impl Erf_KeyEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Erf_KeyList {
    pub _root: SharedType<Erf>,
    pub _parent: SharedType<Erf>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Erf_KeyEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Erf_KeyList {
    type Root = Erf;
    type Parent = Erf;

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
        let l_entries = *_r.header().entry_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Erf_KeyEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Erf_KeyList {
}

/**
 * Array of key entries mapping ResRefs to resource indices
 */
impl Erf_KeyList {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Erf_KeyEntry>>> {
        self.entries.borrow()
    }
}
impl Erf_KeyList {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Erf_LocalizedStringEntry {
    pub _root: SharedType<Erf>,
    pub _parent: SharedType<Erf_LocalizedStringList>,
    pub _self: SharedType<Self>,
    language_id: RefCell<u32>,
    string_size: RefCell<u32>,
    string_data: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Erf_LocalizedStringEntry {
    type Root = Erf;
    type Parent = Erf_LocalizedStringList;

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
        *self_rc.language_id.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.string_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.string_data.borrow_mut() = bytes_to_str(&_io.read_bytes(*self_rc.string_size() as usize)?.into(), "UTF-8")?;
        Ok(())
    }
}
impl Erf_LocalizedStringEntry {
}

/**
 * Language identifier:
 * - 0 = English
 * - 1 = French
 * - 2 = German
 * - 3 = Italian
 * - 4 = Spanish
 * - 5 = Polish
 * - Additional languages for Asian releases
 */
impl Erf_LocalizedStringEntry {
    pub fn language_id(&self) -> Ref<'_, u32> {
        self.language_id.borrow()
    }
}

/**
 * Length of string data in bytes
 */
impl Erf_LocalizedStringEntry {
    pub fn string_size(&self) -> Ref<'_, u32> {
        self.string_size.borrow()
    }
}

/**
 * UTF-8 encoded text string
 */
impl Erf_LocalizedStringEntry {
    pub fn string_data(&self) -> Ref<'_, String> {
        self.string_data.borrow()
    }
}
impl Erf_LocalizedStringEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Erf_LocalizedStringList {
    pub _root: SharedType<Erf>,
    pub _parent: SharedType<Erf>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Erf_LocalizedStringEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Erf_LocalizedStringList {
    type Root = Erf;
    type Parent = Erf;

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
        let l_entries = *_r.header().language_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Erf_LocalizedStringEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Erf_LocalizedStringList {
}

/**
 * Array of localized string entries, one per language
 */
impl Erf_LocalizedStringList {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Erf_LocalizedStringEntry>>> {
        self.entries.borrow()
    }
}
impl Erf_LocalizedStringList {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Erf_ResourceEntry {
    pub _root: SharedType<Erf>,
    pub _parent: SharedType<Erf_ResourceList>,
    pub _self: SharedType<Self>,
    offset_to_data: RefCell<u32>,
    len_data: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_data: Cell<bool>,
    data: RefCell<Vec<u8>>,
}
impl KStruct for Erf_ResourceEntry {
    type Root = Erf;
    type Parent = Erf_ResourceList;

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
        *self_rc.offset_to_data.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.len_data.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Erf_ResourceEntry {

    /**
     * Raw binary data for this resource
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
        *self.data.borrow_mut() = _io.read_bytes(*self.len_data() as usize)?.into();
        _io.seek(_pos)?;
        Ok(self.data.borrow())
    }
}

/**
 * Byte offset to resource data from the beginning of the file.
 * Points to the actual binary data for this resource.
 */
impl Erf_ResourceEntry {
    pub fn offset_to_data(&self) -> Ref<'_, u32> {
        self.offset_to_data.borrow()
    }
}

/**
 * Size of resource data in bytes.
 * Uncompressed size of the resource.
 */
impl Erf_ResourceEntry {
    pub fn len_data(&self) -> Ref<'_, u32> {
        self.len_data.borrow()
    }
}
impl Erf_ResourceEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Erf_ResourceList {
    pub _root: SharedType<Erf>,
    pub _parent: SharedType<Erf>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Erf_ResourceEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Erf_ResourceList {
    type Root = Erf;
    type Parent = Erf;

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
        let l_entries = *_r.header().entry_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Erf_ResourceEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Erf_ResourceList {
}

/**
 * Array of resource entries containing offset and size information
 */
impl Erf_ResourceList {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Erf_ResourceEntry>>> {
        self.entries.borrow()
    }
}
impl Erf_ResourceList {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
