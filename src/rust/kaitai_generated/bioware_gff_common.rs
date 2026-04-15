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
 * Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).
 * 
 * Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
 * (Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareGffCommon {
    pub _root: SharedType<BiowareGffCommon>,
    pub _parent: SharedType<BiowareGffCommon>,
    pub _self: SharedType<Self>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareGffCommon {
    type Root = BiowareGffCommon;
    type Parent = BiowareGffCommon;

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
impl BiowareGffCommon {
}
impl BiowareGffCommon {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
#[derive(Debug, PartialEq, Clone)]
pub enum BiowareGffCommon_GffFieldType {

    /**
     * Numeric 0 — UINT8; value in `GFFFieldData.data_or_data_offset` (+8). Ghidra `/K1/k1_win_gog_swkotor.exe`:
     * `GFFFieldTypes` on `GFFFieldData.field_type` @ +0. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
     * PyKotor `GFFBinaryReader._load_field_value_by_id`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L244-L246
     */
    Uint8,

    /**
     * Numeric 1 — INT8 in low byte of the 4-byte inline slot (+8).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L247-L251
     */
    Int8,

    /**
     * Numeric 2 — UINT16 LE at +8.
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L252-L254
     */
    Uint16,

    /**
     * Numeric 3 — INT16 LE at +8.
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L255-L259
     */
    Int16,

    /**
     * Numeric 4 — UINT32; full inline DWORD at +8.
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L260-L262
     */
    Uint32,

    /**
     * Numeric 5 — INT32 inline. Engine: `CResGFF::ReadFieldINT` @ `0x00411c90` (uses `GetField` @ `0x00410990`).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L263-L267
     */
    Int32,

    /**
     * Numeric 6 — UINT64 payload in `field_data` at `field_data_offset` + relative offset from +8.
     * PyKotor (complex-field branch): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L215
     */
    Uint64,

    /**
     * Numeric 7 — INT64 in `field_data`.
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L216-L217
     */
    Int64,

    /**
     * Numeric 8 — 32-bit IEEE float inline at +8.
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L272
     */
    Single,

    /**
     * Numeric 9 — 64-bit IEEE float in `field_data`.
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L218-L219
     */
    Double,

    /**
     * Numeric 10 — CExoString in `field_data` (`bioware_cexo_string` in this repo).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L222
     */
    String,

    /**
     * Numeric 11 — ResRef in `field_data` (`bioware_resref`).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L223-L226
     */
    Resref,

    /**
     * Numeric 12 — CExoLocString in `field_data` (`bioware_locstring`).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L227-L229
     */
    LocalizedString,

    /**
     * Numeric 13 — length-prefixed octets in `field_data` (`bioware_binary_data`).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L230-L232
     */
    Binary,

    /**
     * Numeric 14 — nested struct; +8 word is index into `GFFStructData` table (`struct_offset` + index×12).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L237-L241
     */
    Struct,

    /**
     * Numeric 15 — list; +8 word is byte offset into list-indices arena (`list_indices_offset` + offset).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L242-L243
     */
    List,

    /**
     * Numeric 16 — four floats in `field_data` (`bioware_vector4`).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L235-L236
     */
    Vector4,

    /**
     * Numeric 17 — three floats in `field_data` (`bioware_vector3`).
     * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L233-L234
     */
    Vector3,

    /**
     * Numeric 18 — TLK StrRef (**KotOR / this schema:** inline `u32` at `GFFFieldData.data_or_data_offset`, i.e. file offset `field_offset + row*12 + 8`).
     * KotOR extension; same width as type 5, distinct field kind in data.
     * Ghidra: `GFFFieldTypes` on `/K1/k1_win_gog_swkotor.exe`.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types — row “StrRef”; StrRef semantics: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
     * PyKotor `GFFFieldType` stops at `Vector3 = 17` (no enum member for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367; `GFFBinaryReader` documents missing branch: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
     * reone `Gff::FieldType::StrRef` + `readStrRefFieldData` (**`field_data` blob**, not inline +8): https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204
     * Community threads / mirrors (tool changelogs, VECTOR/ORIENTATION/StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
     */
    StrRef,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareGffCommon_GffFieldType {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareGffCommon_GffFieldType> {
        match flag {
            0 => Ok(BiowareGffCommon_GffFieldType::Uint8),
            1 => Ok(BiowareGffCommon_GffFieldType::Int8),
            2 => Ok(BiowareGffCommon_GffFieldType::Uint16),
            3 => Ok(BiowareGffCommon_GffFieldType::Int16),
            4 => Ok(BiowareGffCommon_GffFieldType::Uint32),
            5 => Ok(BiowareGffCommon_GffFieldType::Int32),
            6 => Ok(BiowareGffCommon_GffFieldType::Uint64),
            7 => Ok(BiowareGffCommon_GffFieldType::Int64),
            8 => Ok(BiowareGffCommon_GffFieldType::Single),
            9 => Ok(BiowareGffCommon_GffFieldType::Double),
            10 => Ok(BiowareGffCommon_GffFieldType::String),
            11 => Ok(BiowareGffCommon_GffFieldType::Resref),
            12 => Ok(BiowareGffCommon_GffFieldType::LocalizedString),
            13 => Ok(BiowareGffCommon_GffFieldType::Binary),
            14 => Ok(BiowareGffCommon_GffFieldType::Struct),
            15 => Ok(BiowareGffCommon_GffFieldType::List),
            16 => Ok(BiowareGffCommon_GffFieldType::Vector4),
            17 => Ok(BiowareGffCommon_GffFieldType::Vector3),
            18 => Ok(BiowareGffCommon_GffFieldType::StrRef),
            _ => Ok(BiowareGffCommon_GffFieldType::Unknown(flag)),
        }
    }
}

impl From<&BiowareGffCommon_GffFieldType> for i64 {
    fn from(v: &BiowareGffCommon_GffFieldType) -> Self {
        match *v {
            BiowareGffCommon_GffFieldType::Uint8 => 0,
            BiowareGffCommon_GffFieldType::Int8 => 1,
            BiowareGffCommon_GffFieldType::Uint16 => 2,
            BiowareGffCommon_GffFieldType::Int16 => 3,
            BiowareGffCommon_GffFieldType::Uint32 => 4,
            BiowareGffCommon_GffFieldType::Int32 => 5,
            BiowareGffCommon_GffFieldType::Uint64 => 6,
            BiowareGffCommon_GffFieldType::Int64 => 7,
            BiowareGffCommon_GffFieldType::Single => 8,
            BiowareGffCommon_GffFieldType::Double => 9,
            BiowareGffCommon_GffFieldType::String => 10,
            BiowareGffCommon_GffFieldType::Resref => 11,
            BiowareGffCommon_GffFieldType::LocalizedString => 12,
            BiowareGffCommon_GffFieldType::Binary => 13,
            BiowareGffCommon_GffFieldType::Struct => 14,
            BiowareGffCommon_GffFieldType::List => 15,
            BiowareGffCommon_GffFieldType::Vector4 => 16,
            BiowareGffCommon_GffFieldType::Vector3 => 17,
            BiowareGffCommon_GffFieldType::StrRef => 18,
            BiowareGffCommon_GffFieldType::Unknown(v) => v
        }
    }
}

impl Default for BiowareGffCommon_GffFieldType {
    fn default() -> Self { BiowareGffCommon_GffFieldType::Unknown(0) }
}

