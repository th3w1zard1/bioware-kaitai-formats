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
use super::bioware_common::BiowareCommon_BiowareVector4;
use super::bioware_common::BiowareCommon_BiowareCexoString;
use super::bioware_common::BiowareCommon_BiowareResref;
use super::bioware_common::BiowareCommon_BiowareBinaryData;
use super::bioware_common::BiowareCommon_BiowareLocstring;
use super::bioware_gff_common::BiowareGffCommon_GffFieldType;
use super::bioware_common::BiowareCommon_BiowareVector3;

/**
 * BioWare **GFF** (Generic File Format): hierarchical binary game data (KotOR/TSL and Aurora lineage; GFF4 for
 * DA / Eclipse-class payloads in this `.ksy`). Human-readable tables and tutorials: PyKotor wiki (**Further
 * reading**). Wire `gff_field_type` enum: `formats/Common/bioware_gff_common.ksy`.
 * 
 * **Aurora prefix (8 bytes):** `u4be` FourCC + `u4be` version (`AuroraFile::readHeader` — `meta.xref`
 * `xoreos_aurorafile_read_header`).
 * **GFF3:** Twelve LE `u32` counts/offsets as `gff_header_tail` under `gff3_after_aurora`, then lazy arena
 * `instances`.
 * **GFF4:** When version is `V4.0` / `V4.1`, the next field is `platform_id` (`u4be`), not GFF3 `struct_offset`
 * (`gff4_after_aurora`; partial GFF4 graph — `tail` blob still opaque).
 * 
 * **GFF3 wire summary:**
 * - Root `file` → `gff_union_file`; arenas addressed via `gff3.header` offsets.
 * - 12-byte struct rows (`struct_entry`), 12-byte field rows (`field_entry`); root struct index **0**; single-field
 *   vs multi-field vs lists per wiki *Struct array* / *Field indices* / *List indices*.
 * 
 * **Ghidra / VMA:** engine record names and addresses live on the `seq` / `types` nodes they justify, not in this blurb.
 * 
 * **Pinned URLs and tool history:** `meta.xref` (alphabetical keys). Coverage matrix: `docs/XOREOS_FORMAT_COVERAGE.md`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF binary format
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — GFF3File::Header::read
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72 xoreos — GFF4File::Header::read
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 PyKotor — GFFBinaryReader.load
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225 reone — GffReader
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts#L152-L221 KotOR.js — GFFObject.parse
 */

#[derive(Default, Debug, Clone)]
pub struct Gff {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff>,
    pub _self: SharedType<Self>,
    file: RefCell<OptRc<Gff_GffUnionFile>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff {
    type Root = Gff;
    type Parent = Gff;

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
        let t = Self::read_into::<_, Gff_GffUnionFile>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.file.borrow_mut() = t;
        Ok(())
    }
}
impl Gff {
}

/**
 * Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
 * (`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
 * Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
 * mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
 * downstream `pos:` / `_root.file.gff3.header` paths.
 */
impl Gff {
    pub fn file(&self) -> Ref<'_, OptRc<Gff_GffUnionFile>> {
        self.file.borrow()
    }
}
impl Gff {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
 * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_FieldArray {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_Gff3AfterAurora>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Gff_FieldEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_FieldArray {
    type Root = Gff;
    type Parent = Gff_Gff3AfterAurora;

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
        let l_entries = *_r.file().gff3().header().field_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Gff_FieldEntry>(&*_io, Some(self_rc._root.clone()), None)?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Gff_FieldArray {
}

/**
 * Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
 * Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).
 */
impl Gff_FieldArray {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Gff_FieldEntry>>> {
        self.entries.borrow()
    }
}
impl Gff_FieldArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_FieldData {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_Gff3AfterAurora>,
    pub _self: SharedType<Self>,
    raw_data: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_FieldData {
    type Root = Gff;
    type Parent = Gff_Gff3AfterAurora;

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
        *self_rc.raw_data.borrow_mut() = _io.read_bytes(*_r.file().gff3().header().field_data_count() as usize)?.into();
        Ok(())
    }
}
impl Gff_FieldData {
}

/**
 * Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
 * Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
 * Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
 * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
 */
impl Gff_FieldData {
    pub fn raw_data(&self) -> Ref<'_, Vec<u8>> {
        self.raw_data.borrow()
    }
}
impl Gff_FieldData {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
 * `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
 * Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_FieldEntry {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    field_type: RefCell<BiowareGffCommon_GffFieldType>,
    label_index: RefCell<u32>,
    data_or_offset: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_field_data_offset_value: Cell<bool>,
    field_data_offset_value: RefCell<i32>,
    f_is_complex_type: Cell<bool>,
    is_complex_type: RefCell<bool>,
    f_is_list_type: Cell<bool>,
    is_list_type: RefCell<bool>,
    f_is_simple_type: Cell<bool>,
    is_simple_type: RefCell<bool>,
    f_is_struct_type: Cell<bool>,
    is_struct_type: RefCell<bool>,
    f_list_indices_offset_value: Cell<bool>,
    list_indices_offset_value: RefCell<i32>,
    f_struct_index_value: Cell<bool>,
    struct_index_value: RefCell<u32>,
}
impl KStruct for Gff_FieldEntry {
    type Root = Gff;
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
        *self_rc.field_type.borrow_mut() = (_io.read_u4le()? as i64).try_into()?;
        *self_rc.label_index.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.data_or_offset.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Gff_FieldEntry {

    /**
     * Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
     */
    pub fn field_data_offset_value(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_field_data_offset_value.get() {
            return Ok(self.field_data_offset_value.borrow());
        }
        self.f_field_data_offset_value.set(true);
        if *self.is_complex_type()? {
            *self.field_data_offset_value.borrow_mut() = (((*_r.file().gff3().header().field_data_offset() as u32) + (*self.data_or_offset() as u32))) as i32;
        }
        Ok(self.field_data_offset_value.borrow())
    }

    /**
     * Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
     */
    pub fn is_complex_type(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_complex_type.get() {
            return Ok(self.is_complex_type.borrow());
        }
        self.f_is_complex_type.set(true);
        *self.is_complex_type.borrow_mut() = ( ((*self.field_type() == BiowareGffCommon_GffFieldType::Uint64) || (*self.field_type() == BiowareGffCommon_GffFieldType::Int64) || (*self.field_type() == BiowareGffCommon_GffFieldType::Double) || (*self.field_type() == BiowareGffCommon_GffFieldType::String) || (*self.field_type() == BiowareGffCommon_GffFieldType::Resref) || (*self.field_type() == BiowareGffCommon_GffFieldType::LocalizedString) || (*self.field_type() == BiowareGffCommon_GffFieldType::Binary) || (*self.field_type() == BiowareGffCommon_GffFieldType::Vector4) || (*self.field_type() == BiowareGffCommon_GffFieldType::Vector3)) ) as bool;
        Ok(self.is_complex_type.borrow())
    }

    /**
     * Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
     */
    pub fn is_list_type(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_list_type.get() {
            return Ok(self.is_list_type.borrow());
        }
        self.f_is_list_type.set(true);
        *self.is_list_type.borrow_mut() = (*self.field_type() == BiowareGffCommon_GffFieldType::List) as bool;
        Ok(self.is_list_type.borrow())
    }

    /**
     * Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
     * Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
     * **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
     */
    pub fn is_simple_type(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_simple_type.get() {
            return Ok(self.is_simple_type.borrow());
        }
        self.f_is_simple_type.set(true);
        *self.is_simple_type.borrow_mut() = ( ((*self.field_type() == BiowareGffCommon_GffFieldType::Uint8) || (*self.field_type() == BiowareGffCommon_GffFieldType::Int8) || (*self.field_type() == BiowareGffCommon_GffFieldType::Uint16) || (*self.field_type() == BiowareGffCommon_GffFieldType::Int16) || (*self.field_type() == BiowareGffCommon_GffFieldType::Uint32) || (*self.field_type() == BiowareGffCommon_GffFieldType::Int32) || (*self.field_type() == BiowareGffCommon_GffFieldType::Single) || (*self.field_type() == BiowareGffCommon_GffFieldType::StrRef)) ) as bool;
        Ok(self.is_simple_type.borrow())
    }

    /**
     * Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
     */
    pub fn is_struct_type(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_struct_type.get() {
            return Ok(self.is_struct_type.borrow());
        }
        self.f_is_struct_type.set(true);
        *self.is_struct_type.borrow_mut() = (*self.field_type() == BiowareGffCommon_GffFieldType::Struct) as bool;
        Ok(self.is_struct_type.borrow())
    }

    /**
     * Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.
     */
    pub fn list_indices_offset_value(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_list_indices_offset_value.get() {
            return Ok(self.list_indices_offset_value.borrow());
        }
        self.f_list_indices_offset_value.set(true);
        if *self.is_list_type()? {
            *self.list_indices_offset_value.borrow_mut() = (((*_r.file().gff3().header().list_indices_offset() as u32) + (*self.data_or_offset() as u32))) as i32;
        }
        Ok(self.list_indices_offset_value.borrow())
    }

    /**
     * Struct index (same numeric interpretation as `GFFStructData` row index).
     */
    pub fn struct_index_value(
        &self
    ) -> KResult<Ref<'_, u32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_struct_index_value.get() {
            return Ok(self.struct_index_value.borrow());
        }
        self.f_struct_index_value.set(true);
        if *self.is_struct_type()? {
            *self.struct_index_value.borrow_mut() = (*self.data_or_offset()) as u32;
        }
        Ok(self.struct_index_value.borrow())
    }
}

/**
 * Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
 * (ID → storage: inline vs `field_data` vs struct/list indirection).
 * Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
 * Source: Ghidra `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
 * Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
 * PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
 */
impl Gff_FieldEntry {
    pub fn field_type(&self) -> Ref<'_, BiowareGffCommon_GffFieldType> {
        self.field_type.borrow()
    }
}

/**
 * Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
 * Source: Ghidra `GFFFieldData.label_index` @ +0x4 (ulong).
 */
impl Gff_FieldEntry {
    pub fn label_index(&self) -> Ref<'_, u32> {
        self.label_index.borrow()
    }
}

/**
 * Inline data (simple types) or offset/index (complex types):
 * - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
 * - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
 * - Struct (14): Struct index (index into struct_array)
 * - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
 * Source: Ghidra `GFFFieldData.data_or_data_offset` @ +0x8.
 * `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
 */
impl Gff_FieldEntry {
    pub fn data_or_offset(&self) -> Ref<'_, u32> {
        self.data_or_offset.borrow()
    }
}
impl Gff_FieldEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
 * “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_FieldIndicesArray {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_Gff3AfterAurora>,
    pub _self: SharedType<Self>,
    indices: RefCell<Vec<u32>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_FieldIndicesArray {
    type Root = Gff;
    type Parent = Gff_Gff3AfterAurora;

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
        *self_rc.indices.borrow_mut() = Vec::new();
        let l_indices = *_r.file().gff3().header().field_indices_count();
        for _i in 0..l_indices {
            self_rc.indices.borrow_mut().push(_io.read_u4le()?.into());
        }
        Ok(())
    }
}
impl Gff_FieldIndicesArray {
}

/**
 * `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
 * `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
 * Ghidra: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.
 */
impl Gff_FieldIndicesArray {
    pub fn indices(&self) -> Ref<'_, Vec<u32>> {
        self.indices.borrow()
    }
}
impl Gff_FieldIndicesArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_Gff3AfterAurora {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_GffUnionFile>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Gff_GffHeaderTail>>,
    _io: RefCell<BytesReader>,
    f_field_array: Cell<bool>,
    field_array: RefCell<OptRc<Gff_FieldArray>>,
    f_field_data: Cell<bool>,
    field_data: RefCell<OptRc<Gff_FieldData>>,
    f_field_indices_array: Cell<bool>,
    field_indices_array: RefCell<OptRc<Gff_FieldIndicesArray>>,
    f_label_array: Cell<bool>,
    label_array: RefCell<OptRc<Gff_LabelArray>>,
    f_list_indices_array: Cell<bool>,
    list_indices_array: RefCell<OptRc<Gff_ListIndicesArray>>,
    f_root_struct_resolved: Cell<bool>,
    root_struct_resolved: RefCell<OptRc<Gff_ResolvedStruct>>,
    f_struct_array: Cell<bool>,
    struct_array: RefCell<OptRc<Gff_StructArray>>,
}
impl KStruct for Gff_Gff3AfterAurora {
    type Root = Gff;
    type Parent = Gff_GffUnionFile;

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
        let t = Self::read_into::<_, Gff_GffHeaderTail>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        Ok(())
    }
}
impl Gff_Gff3AfterAurora {

    /**
     * Field dictionary: `header.field_count` × 12 B at `header.field_offset`. Ghidra: `GFFFieldData`.
     * `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
     *     PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149
     */
    pub fn field_array(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_FieldArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_field_array.get() {
            return Ok(self.field_array.borrow());
        }
        if ((*self.header().field_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().field_offset() as usize)?;
            let t = Self::read_into::<_, Gff_FieldArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.field_array.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.field_array.borrow())
    }

    /**
     * Complex-type payload heap. Ghidra: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
     *     PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216
     */
    pub fn field_data(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_FieldData>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_field_data.get() {
            return Ok(self.field_data.borrow());
        }
        if ((*self.header().field_data_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().field_data_offset() as usize)?;
            let t = Self::read_into::<_, Gff_FieldData>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.field_data.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.field_data.borrow())
    }

    /**
     * Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
     * Ghidra: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
     *     PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
     */
    pub fn field_indices_array(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_FieldIndicesArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_field_indices_array.get() {
            return Ok(self.field_indices_array.borrow());
        }
        if ((*self.header().field_indices_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().field_indices_offset() as usize)?;
            let t = Self::read_into::<_, Gff_FieldIndicesArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.field_indices_array.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.field_indices_array.borrow())
    }

    /**
     * Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
     * Ghidra: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
     *     PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154
     */
    pub fn label_array(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_LabelArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_label_array.get() {
            return Ok(self.label_array.borrow());
        }
        if ((*self.header().label_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().label_offset() as usize)?;
            let t = Self::read_into::<_, Gff_LabelArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.label_array.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.label_array.borrow())
    }

    /**
     * Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
     * Ghidra: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
     *     PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
     */
    pub fn list_indices_array(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_ListIndicesArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_list_indices_array.get() {
            return Ok(self.list_indices_array.borrow());
        }
        if ((*self.header().list_indices_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().list_indices_offset() as usize)?;
            let t = Self::read_into::<_, Gff_ListIndicesArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.list_indices_array.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.list_indices_array.borrow())
    }

    /**
     * Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
     * Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
     * Implements the access pattern described in meta.doc (single-field vs multi-field structs).
     */
    pub fn root_struct_resolved(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_ResolvedStruct>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_root_struct_resolved.get() {
            return Ok(self.root_struct_resolved.borrow());
        }
        let f = |t : &mut Gff_ResolvedStruct| Ok(t.set_params((0).try_into().map_err(|_| KError::CastError)?));
        let t = Self::read_into_with_init::<_, Gff_ResolvedStruct>(&*_io, Some(self._root.clone()), None, &f)?.into();
        *self.root_struct_resolved.borrow_mut() = t;
        Ok(self.root_struct_resolved.borrow())
    }

    /**
     * Struct table: `header.struct_count` × 12 B at `header.struct_offset`. Ghidra: `GFFStructData` rows.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
     *     PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65
     */
    pub fn struct_array(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_StructArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_struct_array.get() {
            return Ok(self.struct_array.borrow());
        }
        if ((*self.header().struct_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*self.header().struct_offset() as usize)?;
            let t = Self::read_into::<_, Gff_StructArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.struct_array.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.struct_array.borrow())
    }
}

/**
 * Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
 * rows from Struct Array Offset through List Indices Count. Ghidra: `GFFHeaderInfo` @ +0x8 … +0x34.
 */
impl Gff_Gff3AfterAurora {
    pub fn header(&self) -> Ref<'_, OptRc<Gff_GffHeaderTail>> {
        self.header.borrow()
    }
}
impl Gff_Gff3AfterAurora {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
 * PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_Gff4AfterAurora {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    aurora_version: RefCell<u32>,
    platform_id: RefCell<u32>,
    file_type: RefCell<u32>,
    type_version: RefCell<u32>,
    num_struct_templates: RefCell<u32>,
    string_count: RefCell<u32>,
    string_offset: RefCell<u32>,
    data_offset: RefCell<u32>,
    struct_templates: RefCell<Vec<OptRc<Gff_Gff4StructTemplateHeader>>>,
    tail: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_Gff4AfterAurora {
    type Root = Gff;
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
        *self_rc.platform_id.borrow_mut() = _io.read_u4be()?.into();
        *self_rc.file_type.borrow_mut() = _io.read_u4be()?.into();
        *self_rc.type_version.borrow_mut() = _io.read_u4be()?.into();
        *self_rc.num_struct_templates.borrow_mut() = _io.read_u4le()?.into();
        if ((*self_rc.aurora_version() as i32) == (1446260273 as i32)) {
            *self_rc.string_count.borrow_mut() = _io.read_u4le()?.into();
        }
        if ((*self_rc.aurora_version() as i32) == (1446260273 as i32)) {
            *self_rc.string_offset.borrow_mut() = _io.read_u4le()?.into();
        }
        *self_rc.data_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.struct_templates.borrow_mut() = Vec::new();
        let l_struct_templates = *self_rc.num_struct_templates();
        for _i in 0..l_struct_templates {
            let t = Self::read_into::<_, Gff_Gff4StructTemplateHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.struct_templates.borrow_mut().push(t);
        }
        *self_rc.tail.borrow_mut() = _io.read_bytes_full()?.into();
        Ok(())
    }
}
impl Gff_Gff4AfterAurora {
    pub fn aurora_version(&self) -> Ref<'_, u32> {
        self.aurora_version.borrow()
    }
}
impl Gff_Gff4AfterAurora {
    pub fn set_params(&mut self, aurora_version: u32) {
        *self.aurora_version.borrow_mut() = aurora_version;
    }
}
impl Gff_Gff4AfterAurora {
}

/**
 * Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
 * `PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).
 */
impl Gff_Gff4AfterAurora {
    pub fn platform_id(&self) -> Ref<'_, u32> {
        self.platform_id.borrow()
    }
}

/**
 * GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
 * `readUint32BE` on the endian-aware substream (`gff4file.cpp`).
 */
impl Gff_Gff4AfterAurora {
    pub fn file_type(&self) -> Ref<'_, u32> {
        self.file_type.borrow()
    }
}

/**
 * Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).
 */
impl Gff_Gff4AfterAurora {
    pub fn type_version(&self) -> Ref<'_, u32> {
        self.type_version.borrow()
    }
}

/**
 * Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
 * in typical DA assets). xoreos: `_header.structCount`.
 */
impl Gff_Gff4AfterAurora {
    pub fn num_struct_templates(&self) -> Ref<'_, u32> {
        self.num_struct_templates.borrow()
    }
}

/**
 * V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).
 */
impl Gff_Gff4AfterAurora {
    pub fn string_count(&self) -> Ref<'_, u32> {
        self.string_count.borrow()
    }
}

/**
 * V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).
 */
impl Gff_Gff4AfterAurora {
    pub fn string_offset(&self) -> Ref<'_, u32> {
        self.string_offset.borrow()
    }
}

/**
 * Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
 * `readUint32` on the endian substream (`gff4file.cpp`).
 */
impl Gff_Gff4AfterAurora {
    pub fn data_offset(&self) -> Ref<'_, u32> {
        self.data_offset.borrow()
    }
}

/**
 * Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).
 */
impl Gff_Gff4AfterAurora {
    pub fn struct_templates(&self) -> Ref<'_, Vec<OptRc<Gff_Gff4StructTemplateHeader>>> {
        self.struct_templates.borrow()
    }
}

/**
 * Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
 * optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
 * GFF4 graph walker or defer to engine code.
 */
impl Gff_Gff4AfterAurora {
    pub fn tail(&self) -> Ref<'_, Vec<u8>> {
        self.tail.borrow()
    }
}
impl Gff_Gff4AfterAurora {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
 * that expect a single user-type over the whole file.
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_Gff4File {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    aurora_magic: RefCell<u32>,
    aurora_version: RefCell<u32>,
    gff4: RefCell<OptRc<Gff_Gff4AfterAurora>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_Gff4File {
    type Root = Gff;
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
        *self_rc.aurora_magic.borrow_mut() = _io.read_u4be()?.into();
        *self_rc.aurora_version.borrow_mut() = _io.read_u4be()?.into();
        let f = |t : &mut Gff_Gff4AfterAurora| Ok(t.set_params((*self_rc.aurora_version()).try_into().map_err(|_| KError::CastError)?));
        let t = Self::read_into_with_init::<_, Gff_Gff4AfterAurora>(&*_io, Some(self_rc._root.clone()), None, &f)?.into();
        *self_rc.gff4.borrow_mut() = t;
        Ok(())
    }
}
impl Gff_Gff4File {
}

/**
 * Aurora container magic (`GFF ` as `u4be`).
 */
impl Gff_Gff4File {
    pub fn aurora_magic(&self) -> Ref<'_, u32> {
        self.aurora_magic.borrow()
    }
}

/**
 * GFF4 `V4.0` / `V4.1` on-disk tags.
 */
impl Gff_Gff4File {
    pub fn aurora_version(&self) -> Ref<'_, u32> {
        self.aurora_version.borrow()
    }
}

/**
 * GFF4 header tail + struct templates + opaque remainder.
 */
impl Gff_Gff4File {
    pub fn gff4(&self) -> Ref<'_, OptRc<Gff_Gff4AfterAurora>> {
        self.gff4.borrow()
    }
}
impl Gff_Gff4File {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Gff_Gff4StructTemplateHeader {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_Gff4AfterAurora>,
    pub _self: SharedType<Self>,
    struct_label: RefCell<u32>,
    field_count: RefCell<u32>,
    field_offset: RefCell<u32>,
    struct_size: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_Gff4StructTemplateHeader {
    type Root = Gff;
    type Parent = Gff_Gff4AfterAurora;

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
        *self_rc.struct_label.borrow_mut() = _io.read_u4be()?.into();
        *self_rc.field_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.field_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.struct_size.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Gff_Gff4StructTemplateHeader {
}

/**
 * Template label (fourCC style, read `readUint32BE` in `loadStructs`).
 */
impl Gff_Gff4StructTemplateHeader {
    pub fn struct_label(&self) -> Ref<'_, u32> {
        self.struct_label.borrow()
    }
}

/**
 * Number of field declaration records for this template (may be 0).
 */
impl Gff_Gff4StructTemplateHeader {
    pub fn field_count(&self) -> Ref<'_, u32> {
        self.field_count.borrow()
    }
}

/**
 * Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
 * (xoreos `continue`s without reading declarations).
 */
impl Gff_Gff4StructTemplateHeader {
    pub fn field_offset(&self) -> Ref<'_, u32> {
        self.field_offset.borrow()
    }
}

/**
 * Declared on-disk struct size for instances of this template (`strct.size`).
 */
impl Gff_Gff4StructTemplateHeader {
    pub fn struct_size(&self) -> Ref<'_, u32> {
        self.struct_size.borrow()
    }
}
impl Gff_Gff4StructTemplateHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * **GFF3** header continuation: **48 bytes** (twelve LE `u32` dwords) at file offsets **0x08–0x37**, immediately
 * after the shared Aurora 8-byte prefix (`aurora_magic` / `aurora_version` on `gff_union_file`). Same layout as
 * wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) rows from “Struct Array
 * Offset” through “List Indices Count”. Ghidra `/K1/k1_win_gog_swkotor.exe`: `GFFHeaderInfo` @ +0x8 … +0x34.
 * 
 * Sources (same DWORD order on disk after the 8-byte signature):
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 (`file_type`/`file_version` L79–L80 then twelve header `u32`s L93–L106)
 * - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L44 (`GffReader::load` — skips 8-byte signature, reads twelve header `u32`s L30–L41)
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
 * - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 (Aurora/GFF-family background; MultiMap wording)
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_GffHeaderTail {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_Gff3AfterAurora>,
    pub _self: SharedType<Self>,
    struct_offset: RefCell<u32>,
    struct_count: RefCell<u32>,
    field_offset: RefCell<u32>,
    field_count: RefCell<u32>,
    label_offset: RefCell<u32>,
    label_count: RefCell<u32>,
    field_data_offset: RefCell<u32>,
    field_data_count: RefCell<u32>,
    field_indices_offset: RefCell<u32>,
    field_indices_count: RefCell<u32>,
    list_indices_offset: RefCell<u32>,
    list_indices_count: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_GffHeaderTail {
    type Root = Gff;
    type Parent = Gff_Gff3AfterAurora;

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
        *self_rc.struct_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.struct_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.field_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.field_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.label_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.label_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.field_data_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.field_data_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.field_indices_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.field_indices_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.list_indices_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.list_indices_count.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Gff_GffHeaderTail {
}

/**
 * Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
 * Source: Ghidra `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30
 */
impl Gff_GffHeaderTail {
    pub fn struct_offset(&self) -> Ref<'_, u32> {
        self.struct_offset.borrow()
    }
}

/**
 * Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
 * Source: Ghidra `GFFHeaderInfo.struct_count` @ +0xC (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31
 */
impl Gff_GffHeaderTail {
    pub fn struct_count(&self) -> Ref<'_, u32> {
        self.struct_count.borrow()
    }
}

/**
 * Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
 * Source: Ghidra `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32
 */
impl Gff_GffHeaderTail {
    pub fn field_offset(&self) -> Ref<'_, u32> {
        self.field_offset.borrow()
    }
}

/**
 * Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
 * Source: Ghidra `GFFHeaderInfo.field_count` @ +0x14 (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33
 */
impl Gff_GffHeaderTail {
    pub fn field_count(&self) -> Ref<'_, u32> {
        self.field_count.borrow()
    }
}

/**
 * Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
 * Source: Ghidra `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34
 */
impl Gff_GffHeaderTail {
    pub fn label_offset(&self) -> Ref<'_, u32> {
        self.label_offset.borrow()
    }
}

/**
 * Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
 * Source: Ghidra `GFFHeaderInfo.label_count` @ +0x1C (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35
 */
impl Gff_GffHeaderTail {
    pub fn label_count(&self) -> Ref<'_, u32> {
        self.label_count.borrow()
    }
}

/**
 * Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
 * Source: Ghidra `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36
 */
impl Gff_GffHeaderTail {
    pub fn field_data_offset(&self) -> Ref<'_, u32> {
        self.field_data_offset.borrow()
    }
}

/**
 * Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
 * Source: Ghidra `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37
 */
impl Gff_GffHeaderTail {
    pub fn field_data_count(&self) -> Ref<'_, u32> {
        self.field_data_count.borrow()
    }
}

/**
 * Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
 * Source: Ghidra `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38
 */
impl Gff_GffHeaderTail {
    pub fn field_indices_offset(&self) -> Ref<'_, u32> {
        self.field_indices_offset.borrow()
    }
}

/**
 * Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
 * Source: Ghidra `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)
 */
impl Gff_GffHeaderTail {
    pub fn field_indices_count(&self) -> Ref<'_, u32> {
        self.field_indices_count.borrow()
    }
}

/**
 * Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
 * Source: Ghidra `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40
 */
impl Gff_GffHeaderTail {
    pub fn list_indices_offset(&self) -> Ref<'_, u32> {
        self.list_indices_offset.borrow()
    }
}

/**
 * List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
 * Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
 * Source: Ghidra `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
 * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
 */
impl Gff_GffHeaderTail {
    pub fn list_indices_count(&self) -> Ref<'_, u32> {
        self.list_indices_count.borrow()
    }
}
impl Gff_GffHeaderTail {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
 * (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_GffUnionFile {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff>,
    pub _self: SharedType<Self>,
    aurora_magic: RefCell<u32>,
    aurora_version: RefCell<u32>,
    gff3: RefCell<OptRc<Gff_Gff3AfterAurora>>,
    gff4: RefCell<OptRc<Gff_Gff4AfterAurora>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_GffUnionFile {
    type Root = Gff;
    type Parent = Gff;

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
        *self_rc.aurora_magic.borrow_mut() = _io.read_u4be()?.into();
        *self_rc.aurora_version.borrow_mut() = _io.read_u4be()?.into();
        if  ((((*self_rc.aurora_version() as i32) != (1446260272 as i32))) && (((*self_rc.aurora_version() as i32) != (1446260273 as i32))))  {
            let t = Self::read_into::<_, Gff_Gff3AfterAurora>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.gff3.borrow_mut() = t;
        }
        if  ((((*self_rc.aurora_version() as i32) == (1446260272 as i32))) || (((*self_rc.aurora_version() as i32) == (1446260273 as i32))))  {
            let f = |t : &mut Gff_Gff4AfterAurora| Ok(t.set_params((*self_rc.aurora_version()).try_into().map_err(|_| KError::CastError)?));
            let t = Self::read_into_with_init::<_, Gff_Gff4AfterAurora>(&*_io, Some(self_rc._root.clone()), None, &f)?.into();
            *self_rc.gff4.borrow_mut() = t;
        }
        Ok(())
    }
}
impl Gff_GffUnionFile {
}

/**
 * File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
 * legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.
 */
impl Gff_GffUnionFile {
    pub fn aurora_magic(&self) -> Ref<'_, u32> {
        self.aurora_magic.borrow()
    }
}

/**
 * Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
 * `0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.
 */
impl Gff_GffUnionFile {
    pub fn aurora_version(&self) -> Ref<'_, u32> {
        self.aurora_version.borrow()
    }
}

/**
 * **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.
 */
impl Gff_GffUnionFile {
    pub fn gff3(&self) -> Ref<'_, OptRc<Gff_Gff3AfterAurora>> {
        self.gff3.borrow()
    }
}

/**
 * **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.
 */
impl Gff_GffUnionFile {
    pub fn gff4(&self) -> Ref<'_, OptRc<Gff_Gff4AfterAurora>> {
        self.gff4.borrow()
    }
}
impl Gff_GffUnionFile {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
 * Indexed by `GFFFieldData.label_index` (×16). Not a separate Ghidra struct — rows are `char[16]` in bulk.
 * Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_LabelArray {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_Gff3AfterAurora>,
    pub _self: SharedType<Self>,
    labels: RefCell<Vec<OptRc<Gff_LabelEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_LabelArray {
    type Root = Gff;
    type Parent = Gff_Gff3AfterAurora;

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
        *self_rc.labels.borrow_mut() = Vec::new();
        let l_labels = *_r.file().gff3().header().label_count();
        for _i in 0..l_labels {
            let t = Self::read_into::<_, Gff_LabelEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.labels.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Gff_LabelArray {
}

/**
 * Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
 * Index `i` is at file offset `label_offset + i*16`.
 */
impl Gff_LabelArray {
    pub fn labels(&self) -> Ref<'_, Vec<OptRc<Gff_LabelEntry>>> {
        self.labels.borrow()
    }
}
impl Gff_LabelArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_LabelEntry {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_LabelArray>,
    pub _self: SharedType<Self>,
    name: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_LabelEntry {
    type Root = Gff;
    type Parent = Gff_LabelArray;

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
        *self_rc.name.borrow_mut() = bytes_to_str(&_io.read_bytes(16 as usize)?.into(), "ASCII")?;
        Ok(())
    }
}
impl Gff_LabelEntry {
}

/**
 * Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
 * Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
 * Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
 * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
 */
impl Gff_LabelEntry {
    pub fn name(&self) -> Ref<'_, String> {
        self.name.borrow()
    }
}
impl Gff_LabelEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
 * Not a separate Ghidra datatype. Wire cite: `label_entry.name`.
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_LabelEntryTerminated {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_ResolvedField>,
    pub _self: SharedType<Self>,
    name: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_LabelEntryTerminated {
    type Root = Gff;
    type Parent = Gff_ResolvedField;

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
        *self_rc.name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(16 as usize)?.into(), 0, false).into(), "ASCII")?;
        Ok(())
    }
}
impl Gff_LabelEntryTerminated {
}

/**
 * Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.
 */
impl Gff_LabelEntryTerminated {
    pub fn name(&self) -> Ref<'_, String> {
        self.name.borrow()
    }
}
impl Gff_LabelEntryTerminated {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
 * Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_ListEntry {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_ResolvedField>,
    pub _self: SharedType<Self>,
    num_struct_indices: RefCell<u32>,
    struct_indices: RefCell<Vec<u32>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_ListEntry {
    type Root = Gff;
    type Parent = Gff_ResolvedField;

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
        *self_rc.num_struct_indices.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.struct_indices.borrow_mut() = Vec::new();
        let l_struct_indices = *self_rc.num_struct_indices();
        for _i in 0..l_struct_indices {
            self_rc.struct_indices.borrow_mut().push(_io.read_u4le()?.into());
        }
        Ok(())
    }
}
impl Gff_ListEntry {
}

/**
 * Little-endian count of following struct indices (list cardinality).
 * Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
 */
impl Gff_ListEntry {
    pub fn num_struct_indices(&self) -> Ref<'_, u32> {
        self.num_struct_indices.borrow()
    }
}

/**
 * Each value indexes `struct_array.entries[index]` (`GFFStructData` row).
 */
impl Gff_ListEntry {
    pub fn struct_indices(&self) -> Ref<'_, Vec<u32>> {
        self.struct_indices.borrow()
    }
}
impl Gff_ListEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_ListIndicesArray {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_Gff3AfterAurora>,
    pub _self: SharedType<Self>,
    raw_data: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_ListIndicesArray {
    type Root = Gff;
    type Parent = Gff_Gff3AfterAurora;

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
        *self_rc.raw_data.borrow_mut() = _io.read_bytes(*_r.file().gff3().header().list_indices_count() as usize)?.into();
        Ok(())
    }
}
impl Gff_ListIndicesArray {
}

/**
 * Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
 * Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
 * This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.
 */
impl Gff_ListIndicesArray {
    pub fn raw_data(&self) -> Ref<'_, Vec<u8>> {
        self.raw_data.borrow()
    }
}
impl Gff_ListIndicesArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Kaitai composition: one `GFFFieldData` row + label + payload.
 * Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
 * Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
 * For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_ResolvedField {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_ResolvedStruct>,
    pub _self: SharedType<Self>,
    field_index: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_entry: Cell<bool>,
    entry: RefCell<OptRc<Gff_FieldEntry>>,
    f_field_entry_pos: Cell<bool>,
    field_entry_pos: RefCell<i32>,
    f_label: Cell<bool>,
    label: RefCell<OptRc<Gff_LabelEntryTerminated>>,
    f_list_entry: Cell<bool>,
    list_entry: RefCell<OptRc<Gff_ListEntry>>,
    f_list_structs: Cell<bool>,
    list_structs: RefCell<Vec<OptRc<Gff_ResolvedStruct>>>,
    f_value_binary: Cell<bool>,
    value_binary: RefCell<OptRc<BiowareCommon_BiowareBinaryData>>,
    f_value_double: Cell<bool>,
    value_double: RefCell<f64>,
    f_value_int16: Cell<bool>,
    value_int16: RefCell<i16>,
    f_value_int32: Cell<bool>,
    value_int32: RefCell<i32>,
    f_value_int64: Cell<bool>,
    value_int64: RefCell<i64>,
    f_value_int8: Cell<bool>,
    value_int8: RefCell<i8>,
    f_value_localized_string: Cell<bool>,
    value_localized_string: RefCell<OptRc<BiowareCommon_BiowareLocstring>>,
    f_value_resref: Cell<bool>,
    value_resref: RefCell<OptRc<BiowareCommon_BiowareResref>>,
    f_value_single: Cell<bool>,
    value_single: RefCell<f32>,
    f_value_str_ref: Cell<bool>,
    value_str_ref: RefCell<u32>,
    f_value_string: Cell<bool>,
    value_string: RefCell<OptRc<BiowareCommon_BiowareCexoString>>,
    f_value_struct: Cell<bool>,
    value_struct: RefCell<OptRc<Gff_ResolvedStruct>>,
    f_value_uint16: Cell<bool>,
    value_uint16: RefCell<u16>,
    f_value_uint32: Cell<bool>,
    value_uint32: RefCell<u32>,
    f_value_uint64: Cell<bool>,
    value_uint64: RefCell<u64>,
    f_value_uint8: Cell<bool>,
    value_uint8: RefCell<u8>,
    f_value_vector3: Cell<bool>,
    value_vector3: RefCell<OptRc<BiowareCommon_BiowareVector3>>,
    f_value_vector4: Cell<bool>,
    value_vector4: RefCell<OptRc<BiowareCommon_BiowareVector4>>,
}
impl KStruct for Gff_ResolvedField {
    type Root = Gff;
    type Parent = Gff_ResolvedStruct;

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
impl Gff_ResolvedField {
    pub fn field_index(&self) -> Ref<'_, u32> {
        self.field_index.borrow()
    }
}
impl Gff_ResolvedField {
    pub fn set_params(&mut self, field_index: u32) {
        *self.field_index.borrow_mut() = field_index;
    }
}
impl Gff_ResolvedField {

    /**
     * Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).
     */
    pub fn entry(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_FieldEntry>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_entry.get() {
            return Ok(self.entry.borrow());
        }
        let _pos = _io.pos();
        _io.seek(((*_r.file().gff3().header().field_offset() as i32) + (((*self.field_index() as u32) * (12 as u32)) as i32)) as usize)?;
        let t = Self::read_into::<_, Gff_FieldEntry>(&*_io, Some(self._root.clone()), None)?.into();
        *self.entry.borrow_mut() = t;
        _io.seek(_pos)?;
        Ok(self.entry.borrow())
    }

    /**
     * Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).
     */
    pub fn field_entry_pos(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_field_entry_pos.get() {
            return Ok(self.field_entry_pos.borrow());
        }
        self.f_field_entry_pos.set(true);
        *self.field_entry_pos.borrow_mut() = (((*_r.file().gff3().header().field_offset() as i32) + (((*self.field_index() as u32) * (12 as u32)) as i32))) as i32;
        Ok(self.field_entry_pos.borrow())
    }

    /**
     * Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.
     */
    pub fn label(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_LabelEntryTerminated>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_label.get() {
            return Ok(self.label.borrow());
        }
        let _pos = _io.pos();
        _io.seek(((*_r.file().gff3().header().label_offset() as i32) + (((*self.entry()?.label_index() as u32) * (16 as u32)) as i32)) as usize)?;
        let t = Self::read_into::<_, Gff_LabelEntryTerminated>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
        *self.label.borrow_mut() = t;
        _io.seek(_pos)?;
        Ok(self.label.borrow())
    }

    /**
     * `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.
     */
    pub fn list_entry(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_ListEntry>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_list_entry.get() {
            return Ok(self.list_entry.borrow());
        }
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::List {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().list_indices_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            let t = Self::read_into::<_, Gff_ListEntry>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.list_entry.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.list_entry.borrow())
    }

    /**
     * Child structs for this list; indices from `list_entry.struct_indices`.
     */
    pub fn list_structs(
        &self
    ) -> KResult<Ref<'_, Vec<OptRc<Gff_ResolvedStruct>>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_list_structs.get() {
            return Ok(self.list_structs.borrow());
        }
        self.f_list_structs.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::List {
            *self.list_structs.borrow_mut() = Vec::new();
            let l_list_structs = *self.list_entry()?.num_struct_indices();
            for _i in 0..l_list_structs {
                let f = |t : &mut Gff_ResolvedStruct| Ok(t.set_params((self.list_entry()?.struct_indices()[_i as usize]).try_into().map_err(|_| KError::CastError)?));
                let t = Self::read_into_with_init::<_, Gff_ResolvedStruct>(&*_io, Some(self._root.clone()), None, &f)?.into();
                self.list_structs.borrow_mut().push(t);
            }
        }
        Ok(self.list_structs.borrow())
    }

    /**
     * `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
     */
    pub fn value_binary(
        &self
    ) -> KResult<Ref<'_, OptRc<BiowareCommon_BiowareBinaryData>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_binary.get() {
            return Ok(self.value_binary.borrow());
        }
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Binary {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_data_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            let t = Self::read_into::<_, BiowareCommon_BiowareBinaryData>(&*_io, None, None)?.into();
            *self.value_binary.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.value_binary.borrow())
    }

    /**
     * `GFFFieldTypes` 9 (double).
     */
    pub fn value_double(
        &self
    ) -> KResult<Ref<'_, f64>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_double.get() {
            return Ok(self.value_double.borrow());
        }
        self.f_value_double.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Double {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_data_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            *self.value_double.borrow_mut() = _io.read_f8le()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_double.borrow())
    }

    /**
     * `GFFFieldTypes` 3 (INT16 LE at +8).
     */
    pub fn value_int16(
        &self
    ) -> KResult<Ref<'_, i16>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_int16.get() {
            return Ok(self.value_int16.borrow());
        }
        self.f_value_int16.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Int16 {
            let _pos = _io.pos();
            _io.seek(((*self.field_entry_pos()? as i32) + (8 as i32)) as usize)?;
            *self.value_int16.borrow_mut() = _io.read_s2le()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_int16.borrow())
    }

    /**
     * `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
     */
    pub fn value_int32(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_int32.get() {
            return Ok(self.value_int32.borrow());
        }
        self.f_value_int32.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Int32 {
            let _pos = _io.pos();
            _io.seek(((*self.field_entry_pos()? as i32) + (8 as i32)) as usize)?;
            *self.value_int32.borrow_mut() = _io.read_s4le()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_int32.borrow())
    }

    /**
     * `GFFFieldTypes` 7 (INT64).
     */
    pub fn value_int64(
        &self
    ) -> KResult<Ref<'_, i64>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_int64.get() {
            return Ok(self.value_int64.borrow());
        }
        self.f_value_int64.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Int64 {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_data_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            *self.value_int64.borrow_mut() = _io.read_s8le()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_int64.borrow())
    }

    /**
     * `GFFFieldTypes` 1 (INT8 in low byte of slot).
     */
    pub fn value_int8(
        &self
    ) -> KResult<Ref<'_, i8>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_int8.get() {
            return Ok(self.value_int8.borrow());
        }
        self.f_value_int8.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Int8 {
            let _pos = _io.pos();
            _io.seek(((*self.field_entry_pos()? as i32) + (8 as i32)) as usize)?;
            *self.value_int8.borrow_mut() = _io.read_s1()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_int8.borrow())
    }

    /**
     * `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
     */
    pub fn value_localized_string(
        &self
    ) -> KResult<Ref<'_, OptRc<BiowareCommon_BiowareLocstring>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_localized_string.get() {
            return Ok(self.value_localized_string.borrow());
        }
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::LocalizedString {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_data_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            let t = Self::read_into::<_, BiowareCommon_BiowareLocstring>(&*_io, None, None)?.into();
            *self.value_localized_string.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.value_localized_string.borrow())
    }

    /**
     * `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
     */
    pub fn value_resref(
        &self
    ) -> KResult<Ref<'_, OptRc<BiowareCommon_BiowareResref>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_resref.get() {
            return Ok(self.value_resref.borrow());
        }
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Resref {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_data_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            let t = Self::read_into::<_, BiowareCommon_BiowareResref>(&*_io, None, None)?.into();
            *self.value_resref.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.value_resref.borrow())
    }

    /**
     * `GFFFieldTypes` 8 (32-bit float).
     */
    pub fn value_single(
        &self
    ) -> KResult<Ref<'_, f32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_single.get() {
            return Ok(self.value_single.borrow());
        }
        self.f_value_single.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Single {
            let _pos = _io.pos();
            _io.seek(((*self.field_entry_pos()? as i32) + (8 as i32)) as usize)?;
            *self.value_single.borrow_mut() = _io.read_f4le()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_single.borrow())
    }

    /**
     * `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
     * `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
     * **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
     * Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
     * PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
     */
    pub fn value_str_ref(
        &self
    ) -> KResult<Ref<'_, u32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_str_ref.get() {
            return Ok(self.value_str_ref.borrow());
        }
        self.f_value_str_ref.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::StrRef {
            let _pos = _io.pos();
            _io.seek(((*self.field_entry_pos()? as i32) + (8 as i32)) as usize)?;
            *self.value_str_ref.borrow_mut() = _io.read_u4le()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_str_ref.borrow())
    }

    /**
     * `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
     */
    pub fn value_string(
        &self
    ) -> KResult<Ref<'_, OptRc<BiowareCommon_BiowareCexoString>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_string.get() {
            return Ok(self.value_string.borrow());
        }
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::String {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_data_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            let t = Self::read_into::<_, BiowareCommon_BiowareCexoString>(&*_io, None, None)?.into();
            *self.value_string.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.value_string.borrow())
    }

    /**
     * `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.
     */
    pub fn value_struct(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_ResolvedStruct>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_struct.get() {
            return Ok(self.value_struct.borrow());
        }
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Struct {
            let f = |t : &mut Gff_ResolvedStruct| Ok(t.set_params((*self.entry()?.data_or_offset()).try_into().map_err(|_| KError::CastError)?));
            let t = Self::read_into_with_init::<_, Gff_ResolvedStruct>(&*_io, Some(self._root.clone()), None, &f)?.into();
            *self.value_struct.borrow_mut() = t;
        }
        Ok(self.value_struct.borrow())
    }

    /**
     * `GFFFieldTypes` 2 (UINT16 LE at +8).
     */
    pub fn value_uint16(
        &self
    ) -> KResult<Ref<'_, u16>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_uint16.get() {
            return Ok(self.value_uint16.borrow());
        }
        self.f_value_uint16.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Uint16 {
            let _pos = _io.pos();
            _io.seek(((*self.field_entry_pos()? as i32) + (8 as i32)) as usize)?;
            *self.value_uint16.borrow_mut() = _io.read_u2le()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_uint16.borrow())
    }

    /**
     * `GFFFieldTypes` 4 (full inline DWORD).
     */
    pub fn value_uint32(
        &self
    ) -> KResult<Ref<'_, u32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_uint32.get() {
            return Ok(self.value_uint32.borrow());
        }
        self.f_value_uint32.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Uint32 {
            let _pos = _io.pos();
            _io.seek(((*self.field_entry_pos()? as i32) + (8 as i32)) as usize)?;
            *self.value_uint32.borrow_mut() = _io.read_u4le()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_uint32.borrow())
    }

    /**
     * `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
     */
    pub fn value_uint64(
        &self
    ) -> KResult<Ref<'_, u64>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_uint64.get() {
            return Ok(self.value_uint64.borrow());
        }
        self.f_value_uint64.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Uint64 {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_data_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            *self.value_uint64.borrow_mut() = _io.read_u8le()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_uint64.borrow())
    }

    /**
     * `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
     */
    pub fn value_uint8(
        &self
    ) -> KResult<Ref<'_, u8>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_uint8.get() {
            return Ok(self.value_uint8.borrow());
        }
        self.f_value_uint8.set(true);
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Uint8 {
            let _pos = _io.pos();
            _io.seek(((*self.field_entry_pos()? as i32) + (8 as i32)) as usize)?;
            *self.value_uint8.borrow_mut() = _io.read_u1()?.into();
            _io.seek(_pos)?;
        }
        Ok(self.value_uint8.borrow())
    }

    /**
     * `GFFFieldTypes` 17 — three floats (`bioware_vector3`).
     */
    pub fn value_vector3(
        &self
    ) -> KResult<Ref<'_, OptRc<BiowareCommon_BiowareVector3>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_vector3.get() {
            return Ok(self.value_vector3.borrow());
        }
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Vector3 {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_data_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            let t = Self::read_into::<_, BiowareCommon_BiowareVector3>(&*_io, None, None)?.into();
            *self.value_vector3.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.value_vector3.borrow())
    }

    /**
     * `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
     */
    pub fn value_vector4(
        &self
    ) -> KResult<Ref<'_, OptRc<BiowareCommon_BiowareVector4>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_value_vector4.get() {
            return Ok(self.value_vector4.borrow());
        }
        if *self.entry()?.field_type() == BiowareGffCommon_GffFieldType::Vector4 {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_data_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            let t = Self::read_into::<_, BiowareCommon_BiowareVector4>(&*_io, None, None)?.into();
            *self.value_vector4.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.value_vector4.borrow())
    }
}
impl Gff_ResolvedField {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
 * On-disk row remains at `struct_offset + struct_index * 12`.
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_ResolvedStruct {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    struct_index: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_entry: Cell<bool>,
    entry: RefCell<OptRc<Gff_StructEntry>>,
    f_field_indices: Cell<bool>,
    field_indices: RefCell<Vec<u32>>,
    f_fields: Cell<bool>,
    fields: RefCell<Vec<OptRc<Gff_ResolvedField>>>,
    f_single_field: Cell<bool>,
    single_field: RefCell<OptRc<Gff_ResolvedField>>,
}
impl KStruct for Gff_ResolvedStruct {
    type Root = Gff;
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
        Ok(())
    }
}
impl Gff_ResolvedStruct {
    pub fn struct_index(&self) -> Ref<'_, u32> {
        self.struct_index.borrow()
    }
}
impl Gff_ResolvedStruct {
    pub fn set_params(&mut self, struct_index: u32) {
        *self.struct_index.borrow_mut() = struct_index;
    }
}
impl Gff_ResolvedStruct {

    /**
     * Raw `GFFStructData` (Ghidra 12-byte layout).
     */
    pub fn entry(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_StructEntry>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_entry.get() {
            return Ok(self.entry.borrow());
        }
        let _pos = _io.pos();
        _io.seek(((*_r.file().gff3().header().struct_offset() as i32) + (((*self.struct_index() as u32) * (12 as u32)) as i32)) as usize)?;
        let t = Self::read_into::<_, Gff_StructEntry>(&*_io, Some(self._root.clone()), None)?.into();
        *self.entry.borrow_mut() = t;
        _io.seek(_pos)?;
        Ok(self.entry.borrow())
    }

    /**
     * Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
     * Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
     */
    pub fn field_indices(
        &self
    ) -> KResult<Ref<'_, Vec<u32>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_field_indices.get() {
            return Ok(self.field_indices.borrow());
        }
        self.f_field_indices.set(true);
        if ((*self.entry()?.field_count() as u32) > (1 as u32)) {
            let _pos = _io.pos();
            _io.seek(((*_r.file().gff3().header().field_indices_offset() as u32) + (*self.entry()?.data_or_offset() as u32)) as usize)?;
            *self.field_indices.borrow_mut() = Vec::new();
            let l_field_indices = *self.entry()?.field_count();
            for _i in 0..l_field_indices {
                self.field_indices.borrow_mut().push(_io.read_u4le()?.into());
            }
            _io.seek(_pos)?;
        }
        Ok(self.field_indices.borrow())
    }

    /**
     * One `resolved_field` per entry in `field_indices`.
     */
    pub fn fields(
        &self
    ) -> KResult<Ref<'_, Vec<OptRc<Gff_ResolvedField>>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_fields.get() {
            return Ok(self.fields.borrow());
        }
        self.f_fields.set(true);
        if ((*self.entry()?.field_count() as u32) > (1 as u32)) {
            *self.fields.borrow_mut() = Vec::new();
            let l_fields = *self.entry()?.field_count();
            for _i in 0..l_fields {
                let f = |t : &mut Gff_ResolvedField| Ok(t.set_params((self.field_indices()?[_i as usize]).try_into().map_err(|_| KError::CastError)?));
                let t = Self::read_into_with_init::<_, Gff_ResolvedField>(&*_io, Some(self._root.clone()), Some(self._self.clone()), &f)?.into();
                self.fields.borrow_mut().push(t);
            }
        }
        Ok(self.fields.borrow())
    }

    /**
     * `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).
     */
    pub fn single_field(
        &self
    ) -> KResult<Ref<'_, OptRc<Gff_ResolvedField>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_single_field.get() {
            return Ok(self.single_field.borrow());
        }
        if ((*self.entry()?.field_count() as u32) == (1 as u32)) {
            let f = |t : &mut Gff_ResolvedField| Ok(t.set_params((*self.entry()?.data_or_offset()).try_into().map_err(|_| KError::CastError)?));
            let t = Self::read_into_with_init::<_, Gff_ResolvedField>(&*_io, Some(self._root.clone()), Some(self._self.clone()), &f)?.into();
            *self.single_field.borrow_mut() = t;
        }
        Ok(self.single_field.borrow())
    }
}
impl Gff_ResolvedStruct {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Ghidra name `GFFStructData`.
 * Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_StructArray {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<Gff_Gff3AfterAurora>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Gff_StructEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Gff_StructArray {
    type Root = Gff;
    type Parent = Gff_Gff3AfterAurora;

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
        let l_entries = *_r.file().gff3().header().struct_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Gff_StructEntry>(&*_io, Some(self_rc._root.clone()), None)?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Gff_StructArray {
}

/**
 * Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
 * Stride 12 bytes per struct (matches Ghidra component sizes).
 */
impl Gff_StructArray {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Gff_StructEntry>>> {
        self.entries.borrow()
    }
}
impl Gff_StructArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
 */

#[derive(Default, Debug, Clone)]
pub struct Gff_StructEntry {
    pub _root: SharedType<Gff>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    struct_id: RefCell<u32>,
    data_or_offset: RefCell<u32>,
    field_count: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_field_indices_offset: Cell<bool>,
    field_indices_offset: RefCell<u32>,
    f_has_multiple_fields: Cell<bool>,
    has_multiple_fields: RefCell<bool>,
    f_has_single_field: Cell<bool>,
    has_single_field: RefCell<bool>,
    f_single_field_index: Cell<bool>,
    single_field_index: RefCell<u32>,
}
impl KStruct for Gff_StructEntry {
    type Root = Gff;
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
        *self_rc.struct_id.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.data_or_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.field_count.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Gff_StructEntry {

    /**
     * Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.
     */
    pub fn field_indices_offset(
        &self
    ) -> KResult<Ref<'_, u32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_field_indices_offset.get() {
            return Ok(self.field_indices_offset.borrow());
        }
        self.f_field_indices_offset.set(true);
        if *self.has_multiple_fields()? {
            *self.field_indices_offset.borrow_mut() = (*self.data_or_offset()) as u32;
        }
        Ok(self.field_indices_offset.borrow())
    }

    /**
     * Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
     */
    pub fn has_multiple_fields(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_multiple_fields.get() {
            return Ok(self.has_multiple_fields.borrow());
        }
        self.f_has_multiple_fields.set(true);
        *self.has_multiple_fields.borrow_mut() = (((*self.field_count() as u32) > (1 as u32))) as bool;
        Ok(self.has_multiple_fields.borrow())
    }

    /**
     * Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
     * Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
     */
    pub fn has_single_field(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_single_field.get() {
            return Ok(self.has_single_field.borrow());
        }
        self.f_has_single_field.set(true);
        *self.has_single_field.borrow_mut() = (((*self.field_count() as u32) == (1 as u32))) as bool;
        Ok(self.has_single_field.borrow())
    }

    /**
     * Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
     */
    pub fn single_field_index(
        &self
    ) -> KResult<Ref<'_, u32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_single_field_index.get() {
            return Ok(self.single_field_index.borrow());
        }
        self.f_single_field_index.set(true);
        if *self.has_single_field()? {
            *self.single_field_index.borrow_mut() = (*self.data_or_offset()) as u32;
        }
        Ok(self.single_field_index.borrow())
    }
}

/**
 * Structure type identifier.
 * Source: Ghidra `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
 * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
 * 0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.
 */
impl Gff_StructEntry {
    pub fn struct_id(&self) -> Ref<'_, u32> {
        self.struct_id.borrow()
    }
}

/**
 * Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
 * If field_count == 0, this value is unused.
 * Source: Ghidra `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
 */
impl Gff_StructEntry {
    pub fn data_or_offset(&self) -> Ref<'_, u32> {
        self.data_or_offset.borrow()
    }
}

/**
 * Number of fields in this struct:
 * - 0: No fields
 * - 1: Single field, data_or_offset contains the field index directly
 * - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
 * Source: Ghidra `GFFStructData.field_count` @ +0x8 (ulong).
 */
impl Gff_StructEntry {
    pub fn field_count(&self) -> Ref<'_, u32> {
        self.field_count.borrow()
    }
}
impl Gff_StructEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
