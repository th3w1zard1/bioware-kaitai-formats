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
 * Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).
 * 
 * - `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
 *   (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
 * - `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
 *   decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
 * - `ncs_program_size_marker` is the fixed header byte after `"V1.0"` in retail KotOR NCS blobs (`0x42`).
 * 
 * **Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
 * duplicating opcode lists.
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L115 PyKotor — NCSByteCode
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L118-L140 PyKotor — NCSInstructionQualifier
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format PyKotor wiki — NCS
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355 xoreos — NCSFile::load
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137 xoreos-tools — NCSFile::load
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html xoreos-docs — Torlack ncs.html
 * \sa https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40 reone — NcsReader::load
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareNcsCommon {
    pub _root: SharedType<BiowareNcsCommon>,
    pub _parent: SharedType<BiowareNcsCommon>,
    pub _self: SharedType<Self>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareNcsCommon {
    type Root = BiowareNcsCommon;
    type Parent = BiowareNcsCommon;

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
impl BiowareNcsCommon {
}
impl BiowareNcsCommon {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
#[derive(Debug, PartialEq, Clone)]
pub enum BiowareNcsCommon_NcsBytecode {
    ReservedBc,
    Cpdownsp,
    Rsaddx,
    Cptopsp,
    Constx,
    Action,
    Logandxx,
    Logorxx,
    Incorxx,
    Excorxx,
    Boolandxx,
    Equalxx,
    Nequalxx,
    Geqxx,
    Gtxx,
    Ltxx,
    Leqxx,
    Shleftxx,
    Shrightxx,
    Ushrightxx,
    Addxx,
    Subxx,
    Mulxx,
    Divxx,
    Modxx,
    Negx,
    Compx,
    Movsp,
    UnusedGap,
    Jmp,
    Jsr,
    Jz,
    Retn,
    Destruct,
    Notx,
    Decxsp,
    Incxsp,
    Jnz,
    Cpdownbp,
    Cptopbp,
    Decxbp,
    Incxbp,
    Savebp,
    Restorebp,
    StoreState,
    Nop,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareNcsCommon_NcsBytecode {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareNcsCommon_NcsBytecode> {
        match flag {
            0 => Ok(BiowareNcsCommon_NcsBytecode::ReservedBc),
            1 => Ok(BiowareNcsCommon_NcsBytecode::Cpdownsp),
            2 => Ok(BiowareNcsCommon_NcsBytecode::Rsaddx),
            3 => Ok(BiowareNcsCommon_NcsBytecode::Cptopsp),
            4 => Ok(BiowareNcsCommon_NcsBytecode::Constx),
            5 => Ok(BiowareNcsCommon_NcsBytecode::Action),
            6 => Ok(BiowareNcsCommon_NcsBytecode::Logandxx),
            7 => Ok(BiowareNcsCommon_NcsBytecode::Logorxx),
            8 => Ok(BiowareNcsCommon_NcsBytecode::Incorxx),
            9 => Ok(BiowareNcsCommon_NcsBytecode::Excorxx),
            10 => Ok(BiowareNcsCommon_NcsBytecode::Boolandxx),
            11 => Ok(BiowareNcsCommon_NcsBytecode::Equalxx),
            12 => Ok(BiowareNcsCommon_NcsBytecode::Nequalxx),
            13 => Ok(BiowareNcsCommon_NcsBytecode::Geqxx),
            14 => Ok(BiowareNcsCommon_NcsBytecode::Gtxx),
            15 => Ok(BiowareNcsCommon_NcsBytecode::Ltxx),
            16 => Ok(BiowareNcsCommon_NcsBytecode::Leqxx),
            17 => Ok(BiowareNcsCommon_NcsBytecode::Shleftxx),
            18 => Ok(BiowareNcsCommon_NcsBytecode::Shrightxx),
            19 => Ok(BiowareNcsCommon_NcsBytecode::Ushrightxx),
            20 => Ok(BiowareNcsCommon_NcsBytecode::Addxx),
            21 => Ok(BiowareNcsCommon_NcsBytecode::Subxx),
            22 => Ok(BiowareNcsCommon_NcsBytecode::Mulxx),
            23 => Ok(BiowareNcsCommon_NcsBytecode::Divxx),
            24 => Ok(BiowareNcsCommon_NcsBytecode::Modxx),
            25 => Ok(BiowareNcsCommon_NcsBytecode::Negx),
            26 => Ok(BiowareNcsCommon_NcsBytecode::Compx),
            27 => Ok(BiowareNcsCommon_NcsBytecode::Movsp),
            28 => Ok(BiowareNcsCommon_NcsBytecode::UnusedGap),
            29 => Ok(BiowareNcsCommon_NcsBytecode::Jmp),
            30 => Ok(BiowareNcsCommon_NcsBytecode::Jsr),
            31 => Ok(BiowareNcsCommon_NcsBytecode::Jz),
            32 => Ok(BiowareNcsCommon_NcsBytecode::Retn),
            33 => Ok(BiowareNcsCommon_NcsBytecode::Destruct),
            34 => Ok(BiowareNcsCommon_NcsBytecode::Notx),
            35 => Ok(BiowareNcsCommon_NcsBytecode::Decxsp),
            36 => Ok(BiowareNcsCommon_NcsBytecode::Incxsp),
            37 => Ok(BiowareNcsCommon_NcsBytecode::Jnz),
            38 => Ok(BiowareNcsCommon_NcsBytecode::Cpdownbp),
            39 => Ok(BiowareNcsCommon_NcsBytecode::Cptopbp),
            40 => Ok(BiowareNcsCommon_NcsBytecode::Decxbp),
            41 => Ok(BiowareNcsCommon_NcsBytecode::Incxbp),
            42 => Ok(BiowareNcsCommon_NcsBytecode::Savebp),
            43 => Ok(BiowareNcsCommon_NcsBytecode::Restorebp),
            44 => Ok(BiowareNcsCommon_NcsBytecode::StoreState),
            45 => Ok(BiowareNcsCommon_NcsBytecode::Nop),
            _ => Ok(BiowareNcsCommon_NcsBytecode::Unknown(flag)),
        }
    }
}

impl From<&BiowareNcsCommon_NcsBytecode> for i64 {
    fn from(v: &BiowareNcsCommon_NcsBytecode) -> Self {
        match *v {
            BiowareNcsCommon_NcsBytecode::ReservedBc => 0,
            BiowareNcsCommon_NcsBytecode::Cpdownsp => 1,
            BiowareNcsCommon_NcsBytecode::Rsaddx => 2,
            BiowareNcsCommon_NcsBytecode::Cptopsp => 3,
            BiowareNcsCommon_NcsBytecode::Constx => 4,
            BiowareNcsCommon_NcsBytecode::Action => 5,
            BiowareNcsCommon_NcsBytecode::Logandxx => 6,
            BiowareNcsCommon_NcsBytecode::Logorxx => 7,
            BiowareNcsCommon_NcsBytecode::Incorxx => 8,
            BiowareNcsCommon_NcsBytecode::Excorxx => 9,
            BiowareNcsCommon_NcsBytecode::Boolandxx => 10,
            BiowareNcsCommon_NcsBytecode::Equalxx => 11,
            BiowareNcsCommon_NcsBytecode::Nequalxx => 12,
            BiowareNcsCommon_NcsBytecode::Geqxx => 13,
            BiowareNcsCommon_NcsBytecode::Gtxx => 14,
            BiowareNcsCommon_NcsBytecode::Ltxx => 15,
            BiowareNcsCommon_NcsBytecode::Leqxx => 16,
            BiowareNcsCommon_NcsBytecode::Shleftxx => 17,
            BiowareNcsCommon_NcsBytecode::Shrightxx => 18,
            BiowareNcsCommon_NcsBytecode::Ushrightxx => 19,
            BiowareNcsCommon_NcsBytecode::Addxx => 20,
            BiowareNcsCommon_NcsBytecode::Subxx => 21,
            BiowareNcsCommon_NcsBytecode::Mulxx => 22,
            BiowareNcsCommon_NcsBytecode::Divxx => 23,
            BiowareNcsCommon_NcsBytecode::Modxx => 24,
            BiowareNcsCommon_NcsBytecode::Negx => 25,
            BiowareNcsCommon_NcsBytecode::Compx => 26,
            BiowareNcsCommon_NcsBytecode::Movsp => 27,
            BiowareNcsCommon_NcsBytecode::UnusedGap => 28,
            BiowareNcsCommon_NcsBytecode::Jmp => 29,
            BiowareNcsCommon_NcsBytecode::Jsr => 30,
            BiowareNcsCommon_NcsBytecode::Jz => 31,
            BiowareNcsCommon_NcsBytecode::Retn => 32,
            BiowareNcsCommon_NcsBytecode::Destruct => 33,
            BiowareNcsCommon_NcsBytecode::Notx => 34,
            BiowareNcsCommon_NcsBytecode::Decxsp => 35,
            BiowareNcsCommon_NcsBytecode::Incxsp => 36,
            BiowareNcsCommon_NcsBytecode::Jnz => 37,
            BiowareNcsCommon_NcsBytecode::Cpdownbp => 38,
            BiowareNcsCommon_NcsBytecode::Cptopbp => 39,
            BiowareNcsCommon_NcsBytecode::Decxbp => 40,
            BiowareNcsCommon_NcsBytecode::Incxbp => 41,
            BiowareNcsCommon_NcsBytecode::Savebp => 42,
            BiowareNcsCommon_NcsBytecode::Restorebp => 43,
            BiowareNcsCommon_NcsBytecode::StoreState => 44,
            BiowareNcsCommon_NcsBytecode::Nop => 45,
            BiowareNcsCommon_NcsBytecode::Unknown(v) => v
        }
    }
}

impl Default for BiowareNcsCommon_NcsBytecode {
    fn default() -> Self { BiowareNcsCommon_NcsBytecode::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareNcsCommon_NcsInstructionQualifier {
    None,
    UnaryOperandLayout,
    IntType,
    FloatType,
    StringType,
    ObjectType,
    EffectType,
    EventType,
    LocationType,
    TalentType,
    IntInt,
    FloatFloat,
    ObjectObject,
    StringString,
    StructStruct,
    IntFloat,
    FloatInt,
    EffectEffect,
    EventEvent,
    LocationLocation,
    TalentTalent,
    VectorVector,
    VectorFloat,
    FloatVector,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareNcsCommon_NcsInstructionQualifier {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareNcsCommon_NcsInstructionQualifier> {
        match flag {
            0 => Ok(BiowareNcsCommon_NcsInstructionQualifier::None),
            1 => Ok(BiowareNcsCommon_NcsInstructionQualifier::UnaryOperandLayout),
            3 => Ok(BiowareNcsCommon_NcsInstructionQualifier::IntType),
            4 => Ok(BiowareNcsCommon_NcsInstructionQualifier::FloatType),
            5 => Ok(BiowareNcsCommon_NcsInstructionQualifier::StringType),
            6 => Ok(BiowareNcsCommon_NcsInstructionQualifier::ObjectType),
            16 => Ok(BiowareNcsCommon_NcsInstructionQualifier::EffectType),
            17 => Ok(BiowareNcsCommon_NcsInstructionQualifier::EventType),
            18 => Ok(BiowareNcsCommon_NcsInstructionQualifier::LocationType),
            19 => Ok(BiowareNcsCommon_NcsInstructionQualifier::TalentType),
            32 => Ok(BiowareNcsCommon_NcsInstructionQualifier::IntInt),
            33 => Ok(BiowareNcsCommon_NcsInstructionQualifier::FloatFloat),
            34 => Ok(BiowareNcsCommon_NcsInstructionQualifier::ObjectObject),
            35 => Ok(BiowareNcsCommon_NcsInstructionQualifier::StringString),
            36 => Ok(BiowareNcsCommon_NcsInstructionQualifier::StructStruct),
            37 => Ok(BiowareNcsCommon_NcsInstructionQualifier::IntFloat),
            38 => Ok(BiowareNcsCommon_NcsInstructionQualifier::FloatInt),
            48 => Ok(BiowareNcsCommon_NcsInstructionQualifier::EffectEffect),
            49 => Ok(BiowareNcsCommon_NcsInstructionQualifier::EventEvent),
            50 => Ok(BiowareNcsCommon_NcsInstructionQualifier::LocationLocation),
            51 => Ok(BiowareNcsCommon_NcsInstructionQualifier::TalentTalent),
            58 => Ok(BiowareNcsCommon_NcsInstructionQualifier::VectorVector),
            59 => Ok(BiowareNcsCommon_NcsInstructionQualifier::VectorFloat),
            60 => Ok(BiowareNcsCommon_NcsInstructionQualifier::FloatVector),
            _ => Ok(BiowareNcsCommon_NcsInstructionQualifier::Unknown(flag)),
        }
    }
}

impl From<&BiowareNcsCommon_NcsInstructionQualifier> for i64 {
    fn from(v: &BiowareNcsCommon_NcsInstructionQualifier) -> Self {
        match *v {
            BiowareNcsCommon_NcsInstructionQualifier::None => 0,
            BiowareNcsCommon_NcsInstructionQualifier::UnaryOperandLayout => 1,
            BiowareNcsCommon_NcsInstructionQualifier::IntType => 3,
            BiowareNcsCommon_NcsInstructionQualifier::FloatType => 4,
            BiowareNcsCommon_NcsInstructionQualifier::StringType => 5,
            BiowareNcsCommon_NcsInstructionQualifier::ObjectType => 6,
            BiowareNcsCommon_NcsInstructionQualifier::EffectType => 16,
            BiowareNcsCommon_NcsInstructionQualifier::EventType => 17,
            BiowareNcsCommon_NcsInstructionQualifier::LocationType => 18,
            BiowareNcsCommon_NcsInstructionQualifier::TalentType => 19,
            BiowareNcsCommon_NcsInstructionQualifier::IntInt => 32,
            BiowareNcsCommon_NcsInstructionQualifier::FloatFloat => 33,
            BiowareNcsCommon_NcsInstructionQualifier::ObjectObject => 34,
            BiowareNcsCommon_NcsInstructionQualifier::StringString => 35,
            BiowareNcsCommon_NcsInstructionQualifier::StructStruct => 36,
            BiowareNcsCommon_NcsInstructionQualifier::IntFloat => 37,
            BiowareNcsCommon_NcsInstructionQualifier::FloatInt => 38,
            BiowareNcsCommon_NcsInstructionQualifier::EffectEffect => 48,
            BiowareNcsCommon_NcsInstructionQualifier::EventEvent => 49,
            BiowareNcsCommon_NcsInstructionQualifier::LocationLocation => 50,
            BiowareNcsCommon_NcsInstructionQualifier::TalentTalent => 51,
            BiowareNcsCommon_NcsInstructionQualifier::VectorVector => 58,
            BiowareNcsCommon_NcsInstructionQualifier::VectorFloat => 59,
            BiowareNcsCommon_NcsInstructionQualifier::FloatVector => 60,
            BiowareNcsCommon_NcsInstructionQualifier::Unknown(v) => v
        }
    }
}

impl Default for BiowareNcsCommon_NcsInstructionQualifier {
    fn default() -> Self { BiowareNcsCommon_NcsInstructionQualifier::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareNcsCommon_NcsProgramSizeMarker {
    ProgramSizePrefix,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareNcsCommon_NcsProgramSizeMarker {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareNcsCommon_NcsProgramSizeMarker> {
        match flag {
            66 => Ok(BiowareNcsCommon_NcsProgramSizeMarker::ProgramSizePrefix),
            _ => Ok(BiowareNcsCommon_NcsProgramSizeMarker::Unknown(flag)),
        }
    }
}

impl From<&BiowareNcsCommon_NcsProgramSizeMarker> for i64 {
    fn from(v: &BiowareNcsCommon_NcsProgramSizeMarker) -> Self {
        match *v {
            BiowareNcsCommon_NcsProgramSizeMarker::ProgramSizePrefix => 66,
            BiowareNcsCommon_NcsProgramSizeMarker::Unknown(v) => v
        }
    }
}

impl Default for BiowareNcsCommon_NcsProgramSizeMarker {
    fn default() -> Self { BiowareNcsCommon_NcsProgramSizeMarker::Unknown(0) }
}

