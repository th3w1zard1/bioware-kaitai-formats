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
 * **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
 * the paired **KEY** (`KEY.ksy`), not in the BIF.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif PyKotor wiki — BIF
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L57-L215 PyKotor — `io_bif` (Kaitai + legacy + reader)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py#L59-L71 PyKotor — `BIFType`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L97 xoreos — `BIFFile::load` + `readVarResTable`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L208 xoreos — `kFileTypeBIF`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L209 xoreos-tools — `unkeybif` (non-`.bzf` → `BIFFile`)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/bifreader.cpp#L26-L63 reone — `BifReader`
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/BIFObject.ts KotOR.js — `BIFObject`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/bif.html xoreos-docs — Torlack bif.html
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf
 */

#[derive(Default, Debug, Clone)]
pub struct Bif {
    pub _root: SharedType<Bif>,
    pub _parent: SharedType<Bif>,
    pub _self: SharedType<Self>,
    file_type: RefCell<String>,
    version: RefCell<String>,
    var_res_count: RefCell<u32>,
    fixed_res_count: RefCell<u32>,
    var_table_offset: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_var_resource_table: Cell<bool>,
    var_resource_table: RefCell<OptRc<Bif_VarResourceTable>>,
}
impl KStruct for Bif {
    type Root = Bif;
    type Parent = Bif;

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
        if !(*self_rc.file_type() == "BIFF".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/0".to_string() }));
        }
        *self_rc.version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !( ((*self_rc.version() == "V1  ".to_string()) || (*self_rc.version() == "V1.1".to_string())) ) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/seq/1".to_string() }));
        }
        *self_rc.var_res_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.fixed_res_count.borrow_mut() = _io.read_u4le()?.into();
        if !(((*self_rc.fixed_res_count() as u32) == (0 as u32))) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/3".to_string() }));
        }
        *self_rc.var_table_offset.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Bif {

    /**
     * Variable resource table containing entries for each resource.
     */
    pub fn var_resource_table(
        &self
    ) -> KResult<Ref<'_, OptRc<Bif_VarResourceTable>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_var_resource_table.get() {
            return Ok(self.var_resource_table.borrow());
        }
        if ((*self.var_res_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.var_table_offset() as usize)?;
            let t = Self::read_into::<_, Bif_VarResourceTable>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.var_resource_table.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.var_resource_table.borrow())
    }
}

/**
 * File type signature. Must be "BIFF" for BIF files.
 */
impl Bif {
    pub fn file_type(&self) -> Ref<'_, String> {
        self.file_type.borrow()
    }
}

/**
 * File format version. Typically "V1  " or "V1.1".
 */
impl Bif {
    pub fn version(&self) -> Ref<'_, String> {
        self.version.borrow()
    }
}

/**
 * Number of variable-size resources in this file.
 */
impl Bif {
    pub fn var_res_count(&self) -> Ref<'_, u32> {
        self.var_res_count.borrow()
    }
}

/**
 * Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
 */
impl Bif {
    pub fn fixed_res_count(&self) -> Ref<'_, u32> {
        self.fixed_res_count.borrow()
    }
}

/**
 * Byte offset to the variable resource table from the beginning of the file.
 */
impl Bif {
    pub fn var_table_offset(&self) -> Ref<'_, u32> {
        self.var_table_offset.borrow()
    }
}
impl Bif {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bif_VarResourceEntry {
    pub _root: SharedType<Bif>,
    pub _parent: SharedType<Bif_VarResourceTable>,
    pub _self: SharedType<Self>,
    resource_id: RefCell<u32>,
    offset: RefCell<u32>,
    file_size: RefCell<u32>,
    resource_type: RefCell<BiowareTypeIds_XoreosFileTypeId>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bif_VarResourceEntry {
    type Root = Bif;
    type Parent = Bif_VarResourceTable;

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
        *self_rc.resource_id.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.file_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.resource_type.borrow_mut() = (_io.read_u4le()? as i64).try_into()?;
        Ok(())
    }
}
impl Bif_VarResourceEntry {
}

/**
 * Resource ID (matches KEY file entry).
 * Encodes BIF index (bits 31-20) and resource index (bits 19-0).
 * Formula: resource_id = (bif_index << 20) | resource_index
 */
impl Bif_VarResourceEntry {
    pub fn resource_id(&self) -> Ref<'_, u32> {
        self.resource_id.borrow()
    }
}

/**
 * Byte offset to resource data in file (absolute file offset).
 */
impl Bif_VarResourceEntry {
    pub fn offset(&self) -> Ref<'_, u32> {
        self.offset.borrow()
    }
}

/**
 * Uncompressed size of resource data in bytes.
 */
impl Bif_VarResourceEntry {
    pub fn file_size(&self) -> Ref<'_, u32> {
        self.file_size.borrow()
    }
}

/**
 * Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
 * read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
 * `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.
 */
impl Bif_VarResourceEntry {
    pub fn resource_type(&self) -> Ref<'_, BiowareTypeIds_XoreosFileTypeId> {
        self.resource_type.borrow()
    }
}
impl Bif_VarResourceEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bif_VarResourceTable {
    pub _root: SharedType<Bif>,
    pub _parent: SharedType<Bif>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Bif_VarResourceEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bif_VarResourceTable {
    type Root = Bif;
    type Parent = Bif;

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
        let l_entries = *_r.var_res_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Bif_VarResourceEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Bif_VarResourceTable {
}

/**
 * Array of variable resource entries.
 */
impl Bif_VarResourceTable {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Bif_VarResourceEntry>>> {
        self.entries.borrow()
    }
}
impl Bif_VarResourceTable {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
