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
 * Shared enums and "common objects" used across the BioWare ecosystem that also appear
 * in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).
 * 
 * This file is intended to be imported by other `.ksy` files to avoid repeating:
 * - Language IDs (used in TLK headers and GFF LocalizedString substrings)
 * - Gender IDs (used in GFF LocalizedString substrings)
 * - The CExoLocString / LocalizedString binary layout
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py
 * - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33
 * - https://github.com/modawan/reone/blob/master/include/reone/resource/types.h
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py PyKotor — Language (substring language IDs)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py PyKotor — Gender / Game / EquipmentSlot
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py PyKotor — ObjectType
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L235 PyKotor — GFF field read path (LocalizedString via reader)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73 xoreos — `Language` / `LanguageGender` (Aurora runtime; compare TLK / substring packing)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L57-L92 xoreos — `TalkTable_TLK::load` (TLK header + language id field)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33 xoreos-tools — `byte` / `uint` typedefs
 * \sa https://github.com/modawan/reone/blob/master/include/reone/resource/types.h reone — resource type / engine constants
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree (discoverability)
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareCommon {
    pub _root: SharedType<BiowareCommon>,
    pub _parent: SharedType<BiowareCommon>,
    pub _self: SharedType<Self>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareCommon {
    type Root = BiowareCommon;
    type Parent = BiowareCommon;

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
impl BiowareCommon {
}
impl BiowareCommon {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowareDdsVariantBytesPerPixel {
    Dxt1,
    Dxt5,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowareDdsVariantBytesPerPixel {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowareDdsVariantBytesPerPixel> {
        match flag {
            3 => Ok(BiowareCommon_BiowareDdsVariantBytesPerPixel::Dxt1),
            4 => Ok(BiowareCommon_BiowareDdsVariantBytesPerPixel::Dxt5),
            _ => Ok(BiowareCommon_BiowareDdsVariantBytesPerPixel::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowareDdsVariantBytesPerPixel> for i64 {
    fn from(v: &BiowareCommon_BiowareDdsVariantBytesPerPixel) -> Self {
        match *v {
            BiowareCommon_BiowareDdsVariantBytesPerPixel::Dxt1 => 3,
            BiowareCommon_BiowareDdsVariantBytesPerPixel::Dxt5 => 4,
            BiowareCommon_BiowareDdsVariantBytesPerPixel::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowareDdsVariantBytesPerPixel {
    fn default() -> Self { BiowareCommon_BiowareDdsVariantBytesPerPixel::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowareEquipmentSlotFlag {
    Invalid,
    Head,
    Armor,
    Gauntlet,
    RightHand,
    LeftHand,
    RightArm,
    LeftArm,
    Implant,
    Belt,
    Claw1,
    Claw2,
    Claw3,
    Hide,
    RightHand2,
    LeftHand2,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowareEquipmentSlotFlag {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowareEquipmentSlotFlag> {
        match flag {
            0 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Invalid),
            1 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Head),
            2 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Armor),
            8 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Gauntlet),
            16 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::RightHand),
            32 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::LeftHand),
            128 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::RightArm),
            256 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::LeftArm),
            512 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Implant),
            1024 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Belt),
            16384 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Claw1),
            32768 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Claw2),
            65536 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Claw3),
            131072 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Hide),
            262144 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::RightHand2),
            524288 => Ok(BiowareCommon_BiowareEquipmentSlotFlag::LeftHand2),
            _ => Ok(BiowareCommon_BiowareEquipmentSlotFlag::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowareEquipmentSlotFlag> for i64 {
    fn from(v: &BiowareCommon_BiowareEquipmentSlotFlag) -> Self {
        match *v {
            BiowareCommon_BiowareEquipmentSlotFlag::Invalid => 0,
            BiowareCommon_BiowareEquipmentSlotFlag::Head => 1,
            BiowareCommon_BiowareEquipmentSlotFlag::Armor => 2,
            BiowareCommon_BiowareEquipmentSlotFlag::Gauntlet => 8,
            BiowareCommon_BiowareEquipmentSlotFlag::RightHand => 16,
            BiowareCommon_BiowareEquipmentSlotFlag::LeftHand => 32,
            BiowareCommon_BiowareEquipmentSlotFlag::RightArm => 128,
            BiowareCommon_BiowareEquipmentSlotFlag::LeftArm => 256,
            BiowareCommon_BiowareEquipmentSlotFlag::Implant => 512,
            BiowareCommon_BiowareEquipmentSlotFlag::Belt => 1024,
            BiowareCommon_BiowareEquipmentSlotFlag::Claw1 => 16384,
            BiowareCommon_BiowareEquipmentSlotFlag::Claw2 => 32768,
            BiowareCommon_BiowareEquipmentSlotFlag::Claw3 => 65536,
            BiowareCommon_BiowareEquipmentSlotFlag::Hide => 131072,
            BiowareCommon_BiowareEquipmentSlotFlag::RightHand2 => 262144,
            BiowareCommon_BiowareEquipmentSlotFlag::LeftHand2 => 524288,
            BiowareCommon_BiowareEquipmentSlotFlag::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowareEquipmentSlotFlag {
    fn default() -> Self { BiowareCommon_BiowareEquipmentSlotFlag::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowareGameId {
    K1,
    K2,
    K1Xbox,
    K2Xbox,
    K1Ios,
    K2Ios,
    K1Android,
    K2Android,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowareGameId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowareGameId> {
        match flag {
            1 => Ok(BiowareCommon_BiowareGameId::K1),
            2 => Ok(BiowareCommon_BiowareGameId::K2),
            3 => Ok(BiowareCommon_BiowareGameId::K1Xbox),
            4 => Ok(BiowareCommon_BiowareGameId::K2Xbox),
            5 => Ok(BiowareCommon_BiowareGameId::K1Ios),
            6 => Ok(BiowareCommon_BiowareGameId::K2Ios),
            7 => Ok(BiowareCommon_BiowareGameId::K1Android),
            8 => Ok(BiowareCommon_BiowareGameId::K2Android),
            _ => Ok(BiowareCommon_BiowareGameId::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowareGameId> for i64 {
    fn from(v: &BiowareCommon_BiowareGameId) -> Self {
        match *v {
            BiowareCommon_BiowareGameId::K1 => 1,
            BiowareCommon_BiowareGameId::K2 => 2,
            BiowareCommon_BiowareGameId::K1Xbox => 3,
            BiowareCommon_BiowareGameId::K2Xbox => 4,
            BiowareCommon_BiowareGameId::K1Ios => 5,
            BiowareCommon_BiowareGameId::K2Ios => 6,
            BiowareCommon_BiowareGameId::K1Android => 7,
            BiowareCommon_BiowareGameId::K2Android => 8,
            BiowareCommon_BiowareGameId::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowareGameId {
    fn default() -> Self { BiowareCommon_BiowareGameId::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowareGenderId {
    Male,
    Female,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowareGenderId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowareGenderId> {
        match flag {
            0 => Ok(BiowareCommon_BiowareGenderId::Male),
            1 => Ok(BiowareCommon_BiowareGenderId::Female),
            _ => Ok(BiowareCommon_BiowareGenderId::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowareGenderId> for i64 {
    fn from(v: &BiowareCommon_BiowareGenderId) -> Self {
        match *v {
            BiowareCommon_BiowareGenderId::Male => 0,
            BiowareCommon_BiowareGenderId::Female => 1,
            BiowareCommon_BiowareGenderId::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowareGenderId {
    fn default() -> Self { BiowareCommon_BiowareGenderId::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowareLanguageId {
    English,
    French,
    German,
    Italian,
    Spanish,
    Polish,
    Afrikaans,
    Basque,
    Breton,
    Catalan,
    Chamorro,
    Chichewa,
    Corsican,
    Danish,
    Dutch,
    Faroese,
    Filipino,
    Finnish,
    Flemish,
    Frisian,
    Galician,
    Ganda,
    HaitianCreole,
    HausaLatin,
    Hawaiian,
    Icelandic,
    Ido,
    Indonesian,
    Igbo,
    Irish,
    Interlingua,
    JavaneseLatin,
    Latin,
    Luxembourgish,
    Maltese,
    Norwegian,
    Occitan,
    Portuguese,
    Scots,
    ScottishGaelic,
    Shona,
    Soto,
    SundaneseLatin,
    Swahili,
    Swedish,
    Tagalog,
    Tahitian,
    Tongan,
    UzbekLatin,
    Walloon,
    Xhosa,
    Yoruba,
    Welsh,
    Zulu,
    Bulgarian,
    Belarisian,
    Macedonian,
    Russian,
    SerbianCyrillic,
    Tajik,
    TatarCyrillic,
    Ukrainian,
    Uzbek,
    Albanian,
    BosnianLatin,
    Czech,
    Slovak,
    Slovene,
    Croatian,
    Hungarian,
    Romanian,
    Greek,
    Esperanto,
    AzerbaijaniLatin,
    Turkish,
    TurkmenLatin,
    Hebrew,
    Arabic,
    Estonian,
    Latvian,
    Lithuanian,
    Vietnamese,
    Thai,
    Aymara,
    Kinyarwanda,
    KurdishLatin,
    Malagasy,
    MalayLatin,
    Maori,
    MoldovanLatin,
    Samoan,
    Somali,
    Korean,
    ChineseTraditional,
    ChineseSimplified,
    Japanese,
    Unknown,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowareLanguageId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowareLanguageId> {
        match flag {
            0 => Ok(BiowareCommon_BiowareLanguageId::English),
            1 => Ok(BiowareCommon_BiowareLanguageId::French),
            2 => Ok(BiowareCommon_BiowareLanguageId::German),
            3 => Ok(BiowareCommon_BiowareLanguageId::Italian),
            4 => Ok(BiowareCommon_BiowareLanguageId::Spanish),
            5 => Ok(BiowareCommon_BiowareLanguageId::Polish),
            6 => Ok(BiowareCommon_BiowareLanguageId::Afrikaans),
            7 => Ok(BiowareCommon_BiowareLanguageId::Basque),
            9 => Ok(BiowareCommon_BiowareLanguageId::Breton),
            10 => Ok(BiowareCommon_BiowareLanguageId::Catalan),
            11 => Ok(BiowareCommon_BiowareLanguageId::Chamorro),
            12 => Ok(BiowareCommon_BiowareLanguageId::Chichewa),
            13 => Ok(BiowareCommon_BiowareLanguageId::Corsican),
            14 => Ok(BiowareCommon_BiowareLanguageId::Danish),
            15 => Ok(BiowareCommon_BiowareLanguageId::Dutch),
            16 => Ok(BiowareCommon_BiowareLanguageId::Faroese),
            18 => Ok(BiowareCommon_BiowareLanguageId::Filipino),
            19 => Ok(BiowareCommon_BiowareLanguageId::Finnish),
            20 => Ok(BiowareCommon_BiowareLanguageId::Flemish),
            21 => Ok(BiowareCommon_BiowareLanguageId::Frisian),
            22 => Ok(BiowareCommon_BiowareLanguageId::Galician),
            23 => Ok(BiowareCommon_BiowareLanguageId::Ganda),
            24 => Ok(BiowareCommon_BiowareLanguageId::HaitianCreole),
            25 => Ok(BiowareCommon_BiowareLanguageId::HausaLatin),
            26 => Ok(BiowareCommon_BiowareLanguageId::Hawaiian),
            27 => Ok(BiowareCommon_BiowareLanguageId::Icelandic),
            28 => Ok(BiowareCommon_BiowareLanguageId::Ido),
            29 => Ok(BiowareCommon_BiowareLanguageId::Indonesian),
            30 => Ok(BiowareCommon_BiowareLanguageId::Igbo),
            31 => Ok(BiowareCommon_BiowareLanguageId::Irish),
            32 => Ok(BiowareCommon_BiowareLanguageId::Interlingua),
            33 => Ok(BiowareCommon_BiowareLanguageId::JavaneseLatin),
            34 => Ok(BiowareCommon_BiowareLanguageId::Latin),
            35 => Ok(BiowareCommon_BiowareLanguageId::Luxembourgish),
            36 => Ok(BiowareCommon_BiowareLanguageId::Maltese),
            37 => Ok(BiowareCommon_BiowareLanguageId::Norwegian),
            38 => Ok(BiowareCommon_BiowareLanguageId::Occitan),
            39 => Ok(BiowareCommon_BiowareLanguageId::Portuguese),
            40 => Ok(BiowareCommon_BiowareLanguageId::Scots),
            41 => Ok(BiowareCommon_BiowareLanguageId::ScottishGaelic),
            42 => Ok(BiowareCommon_BiowareLanguageId::Shona),
            43 => Ok(BiowareCommon_BiowareLanguageId::Soto),
            44 => Ok(BiowareCommon_BiowareLanguageId::SundaneseLatin),
            45 => Ok(BiowareCommon_BiowareLanguageId::Swahili),
            46 => Ok(BiowareCommon_BiowareLanguageId::Swedish),
            47 => Ok(BiowareCommon_BiowareLanguageId::Tagalog),
            48 => Ok(BiowareCommon_BiowareLanguageId::Tahitian),
            49 => Ok(BiowareCommon_BiowareLanguageId::Tongan),
            50 => Ok(BiowareCommon_BiowareLanguageId::UzbekLatin),
            51 => Ok(BiowareCommon_BiowareLanguageId::Walloon),
            52 => Ok(BiowareCommon_BiowareLanguageId::Xhosa),
            53 => Ok(BiowareCommon_BiowareLanguageId::Yoruba),
            54 => Ok(BiowareCommon_BiowareLanguageId::Welsh),
            55 => Ok(BiowareCommon_BiowareLanguageId::Zulu),
            58 => Ok(BiowareCommon_BiowareLanguageId::Bulgarian),
            59 => Ok(BiowareCommon_BiowareLanguageId::Belarisian),
            60 => Ok(BiowareCommon_BiowareLanguageId::Macedonian),
            61 => Ok(BiowareCommon_BiowareLanguageId::Russian),
            62 => Ok(BiowareCommon_BiowareLanguageId::SerbianCyrillic),
            63 => Ok(BiowareCommon_BiowareLanguageId::Tajik),
            64 => Ok(BiowareCommon_BiowareLanguageId::TatarCyrillic),
            66 => Ok(BiowareCommon_BiowareLanguageId::Ukrainian),
            67 => Ok(BiowareCommon_BiowareLanguageId::Uzbek),
            68 => Ok(BiowareCommon_BiowareLanguageId::Albanian),
            69 => Ok(BiowareCommon_BiowareLanguageId::BosnianLatin),
            70 => Ok(BiowareCommon_BiowareLanguageId::Czech),
            71 => Ok(BiowareCommon_BiowareLanguageId::Slovak),
            72 => Ok(BiowareCommon_BiowareLanguageId::Slovene),
            73 => Ok(BiowareCommon_BiowareLanguageId::Croatian),
            75 => Ok(BiowareCommon_BiowareLanguageId::Hungarian),
            76 => Ok(BiowareCommon_BiowareLanguageId::Romanian),
            77 => Ok(BiowareCommon_BiowareLanguageId::Greek),
            78 => Ok(BiowareCommon_BiowareLanguageId::Esperanto),
            79 => Ok(BiowareCommon_BiowareLanguageId::AzerbaijaniLatin),
            81 => Ok(BiowareCommon_BiowareLanguageId::Turkish),
            82 => Ok(BiowareCommon_BiowareLanguageId::TurkmenLatin),
            83 => Ok(BiowareCommon_BiowareLanguageId::Hebrew),
            84 => Ok(BiowareCommon_BiowareLanguageId::Arabic),
            85 => Ok(BiowareCommon_BiowareLanguageId::Estonian),
            86 => Ok(BiowareCommon_BiowareLanguageId::Latvian),
            87 => Ok(BiowareCommon_BiowareLanguageId::Lithuanian),
            88 => Ok(BiowareCommon_BiowareLanguageId::Vietnamese),
            89 => Ok(BiowareCommon_BiowareLanguageId::Thai),
            90 => Ok(BiowareCommon_BiowareLanguageId::Aymara),
            91 => Ok(BiowareCommon_BiowareLanguageId::Kinyarwanda),
            92 => Ok(BiowareCommon_BiowareLanguageId::KurdishLatin),
            93 => Ok(BiowareCommon_BiowareLanguageId::Malagasy),
            94 => Ok(BiowareCommon_BiowareLanguageId::MalayLatin),
            95 => Ok(BiowareCommon_BiowareLanguageId::Maori),
            96 => Ok(BiowareCommon_BiowareLanguageId::MoldovanLatin),
            97 => Ok(BiowareCommon_BiowareLanguageId::Samoan),
            98 => Ok(BiowareCommon_BiowareLanguageId::Somali),
            128 => Ok(BiowareCommon_BiowareLanguageId::Korean),
            129 => Ok(BiowareCommon_BiowareLanguageId::ChineseTraditional),
            130 => Ok(BiowareCommon_BiowareLanguageId::ChineseSimplified),
            131 => Ok(BiowareCommon_BiowareLanguageId::Japanese),
            2147483646 => Ok(BiowareCommon_BiowareLanguageId::Unknown),
            _ => Ok(BiowareCommon_BiowareLanguageId::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowareLanguageId> for i64 {
    fn from(v: &BiowareCommon_BiowareLanguageId) -> Self {
        match *v {
            BiowareCommon_BiowareLanguageId::English => 0,
            BiowareCommon_BiowareLanguageId::French => 1,
            BiowareCommon_BiowareLanguageId::German => 2,
            BiowareCommon_BiowareLanguageId::Italian => 3,
            BiowareCommon_BiowareLanguageId::Spanish => 4,
            BiowareCommon_BiowareLanguageId::Polish => 5,
            BiowareCommon_BiowareLanguageId::Afrikaans => 6,
            BiowareCommon_BiowareLanguageId::Basque => 7,
            BiowareCommon_BiowareLanguageId::Breton => 9,
            BiowareCommon_BiowareLanguageId::Catalan => 10,
            BiowareCommon_BiowareLanguageId::Chamorro => 11,
            BiowareCommon_BiowareLanguageId::Chichewa => 12,
            BiowareCommon_BiowareLanguageId::Corsican => 13,
            BiowareCommon_BiowareLanguageId::Danish => 14,
            BiowareCommon_BiowareLanguageId::Dutch => 15,
            BiowareCommon_BiowareLanguageId::Faroese => 16,
            BiowareCommon_BiowareLanguageId::Filipino => 18,
            BiowareCommon_BiowareLanguageId::Finnish => 19,
            BiowareCommon_BiowareLanguageId::Flemish => 20,
            BiowareCommon_BiowareLanguageId::Frisian => 21,
            BiowareCommon_BiowareLanguageId::Galician => 22,
            BiowareCommon_BiowareLanguageId::Ganda => 23,
            BiowareCommon_BiowareLanguageId::HaitianCreole => 24,
            BiowareCommon_BiowareLanguageId::HausaLatin => 25,
            BiowareCommon_BiowareLanguageId::Hawaiian => 26,
            BiowareCommon_BiowareLanguageId::Icelandic => 27,
            BiowareCommon_BiowareLanguageId::Ido => 28,
            BiowareCommon_BiowareLanguageId::Indonesian => 29,
            BiowareCommon_BiowareLanguageId::Igbo => 30,
            BiowareCommon_BiowareLanguageId::Irish => 31,
            BiowareCommon_BiowareLanguageId::Interlingua => 32,
            BiowareCommon_BiowareLanguageId::JavaneseLatin => 33,
            BiowareCommon_BiowareLanguageId::Latin => 34,
            BiowareCommon_BiowareLanguageId::Luxembourgish => 35,
            BiowareCommon_BiowareLanguageId::Maltese => 36,
            BiowareCommon_BiowareLanguageId::Norwegian => 37,
            BiowareCommon_BiowareLanguageId::Occitan => 38,
            BiowareCommon_BiowareLanguageId::Portuguese => 39,
            BiowareCommon_BiowareLanguageId::Scots => 40,
            BiowareCommon_BiowareLanguageId::ScottishGaelic => 41,
            BiowareCommon_BiowareLanguageId::Shona => 42,
            BiowareCommon_BiowareLanguageId::Soto => 43,
            BiowareCommon_BiowareLanguageId::SundaneseLatin => 44,
            BiowareCommon_BiowareLanguageId::Swahili => 45,
            BiowareCommon_BiowareLanguageId::Swedish => 46,
            BiowareCommon_BiowareLanguageId::Tagalog => 47,
            BiowareCommon_BiowareLanguageId::Tahitian => 48,
            BiowareCommon_BiowareLanguageId::Tongan => 49,
            BiowareCommon_BiowareLanguageId::UzbekLatin => 50,
            BiowareCommon_BiowareLanguageId::Walloon => 51,
            BiowareCommon_BiowareLanguageId::Xhosa => 52,
            BiowareCommon_BiowareLanguageId::Yoruba => 53,
            BiowareCommon_BiowareLanguageId::Welsh => 54,
            BiowareCommon_BiowareLanguageId::Zulu => 55,
            BiowareCommon_BiowareLanguageId::Bulgarian => 58,
            BiowareCommon_BiowareLanguageId::Belarisian => 59,
            BiowareCommon_BiowareLanguageId::Macedonian => 60,
            BiowareCommon_BiowareLanguageId::Russian => 61,
            BiowareCommon_BiowareLanguageId::SerbianCyrillic => 62,
            BiowareCommon_BiowareLanguageId::Tajik => 63,
            BiowareCommon_BiowareLanguageId::TatarCyrillic => 64,
            BiowareCommon_BiowareLanguageId::Ukrainian => 66,
            BiowareCommon_BiowareLanguageId::Uzbek => 67,
            BiowareCommon_BiowareLanguageId::Albanian => 68,
            BiowareCommon_BiowareLanguageId::BosnianLatin => 69,
            BiowareCommon_BiowareLanguageId::Czech => 70,
            BiowareCommon_BiowareLanguageId::Slovak => 71,
            BiowareCommon_BiowareLanguageId::Slovene => 72,
            BiowareCommon_BiowareLanguageId::Croatian => 73,
            BiowareCommon_BiowareLanguageId::Hungarian => 75,
            BiowareCommon_BiowareLanguageId::Romanian => 76,
            BiowareCommon_BiowareLanguageId::Greek => 77,
            BiowareCommon_BiowareLanguageId::Esperanto => 78,
            BiowareCommon_BiowareLanguageId::AzerbaijaniLatin => 79,
            BiowareCommon_BiowareLanguageId::Turkish => 81,
            BiowareCommon_BiowareLanguageId::TurkmenLatin => 82,
            BiowareCommon_BiowareLanguageId::Hebrew => 83,
            BiowareCommon_BiowareLanguageId::Arabic => 84,
            BiowareCommon_BiowareLanguageId::Estonian => 85,
            BiowareCommon_BiowareLanguageId::Latvian => 86,
            BiowareCommon_BiowareLanguageId::Lithuanian => 87,
            BiowareCommon_BiowareLanguageId::Vietnamese => 88,
            BiowareCommon_BiowareLanguageId::Thai => 89,
            BiowareCommon_BiowareLanguageId::Aymara => 90,
            BiowareCommon_BiowareLanguageId::Kinyarwanda => 91,
            BiowareCommon_BiowareLanguageId::KurdishLatin => 92,
            BiowareCommon_BiowareLanguageId::Malagasy => 93,
            BiowareCommon_BiowareLanguageId::MalayLatin => 94,
            BiowareCommon_BiowareLanguageId::Maori => 95,
            BiowareCommon_BiowareLanguageId::MoldovanLatin => 96,
            BiowareCommon_BiowareLanguageId::Samoan => 97,
            BiowareCommon_BiowareLanguageId::Somali => 98,
            BiowareCommon_BiowareLanguageId::Korean => 128,
            BiowareCommon_BiowareLanguageId::ChineseTraditional => 129,
            BiowareCommon_BiowareLanguageId::ChineseSimplified => 130,
            BiowareCommon_BiowareLanguageId::Japanese => 131,
            BiowareCommon_BiowareLanguageId::Unknown => 2147483646,
            BiowareCommon_BiowareLanguageId::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowareLanguageId {
    fn default() -> Self { BiowareCommon_BiowareLanguageId::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowareLipVisemeId {
    Neutral,
    Ee,
    Eh,
    Ah,
    Oh,
    Ooh,
    Y,
    Sts,
    Fv,
    Ng,
    Th,
    Mpb,
    Td,
    Sh,
    L,
    Kg,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowareLipVisemeId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowareLipVisemeId> {
        match flag {
            0 => Ok(BiowareCommon_BiowareLipVisemeId::Neutral),
            1 => Ok(BiowareCommon_BiowareLipVisemeId::Ee),
            2 => Ok(BiowareCommon_BiowareLipVisemeId::Eh),
            3 => Ok(BiowareCommon_BiowareLipVisemeId::Ah),
            4 => Ok(BiowareCommon_BiowareLipVisemeId::Oh),
            5 => Ok(BiowareCommon_BiowareLipVisemeId::Ooh),
            6 => Ok(BiowareCommon_BiowareLipVisemeId::Y),
            7 => Ok(BiowareCommon_BiowareLipVisemeId::Sts),
            8 => Ok(BiowareCommon_BiowareLipVisemeId::Fv),
            9 => Ok(BiowareCommon_BiowareLipVisemeId::Ng),
            10 => Ok(BiowareCommon_BiowareLipVisemeId::Th),
            11 => Ok(BiowareCommon_BiowareLipVisemeId::Mpb),
            12 => Ok(BiowareCommon_BiowareLipVisemeId::Td),
            13 => Ok(BiowareCommon_BiowareLipVisemeId::Sh),
            14 => Ok(BiowareCommon_BiowareLipVisemeId::L),
            15 => Ok(BiowareCommon_BiowareLipVisemeId::Kg),
            _ => Ok(BiowareCommon_BiowareLipVisemeId::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowareLipVisemeId> for i64 {
    fn from(v: &BiowareCommon_BiowareLipVisemeId) -> Self {
        match *v {
            BiowareCommon_BiowareLipVisemeId::Neutral => 0,
            BiowareCommon_BiowareLipVisemeId::Ee => 1,
            BiowareCommon_BiowareLipVisemeId::Eh => 2,
            BiowareCommon_BiowareLipVisemeId::Ah => 3,
            BiowareCommon_BiowareLipVisemeId::Oh => 4,
            BiowareCommon_BiowareLipVisemeId::Ooh => 5,
            BiowareCommon_BiowareLipVisemeId::Y => 6,
            BiowareCommon_BiowareLipVisemeId::Sts => 7,
            BiowareCommon_BiowareLipVisemeId::Fv => 8,
            BiowareCommon_BiowareLipVisemeId::Ng => 9,
            BiowareCommon_BiowareLipVisemeId::Th => 10,
            BiowareCommon_BiowareLipVisemeId::Mpb => 11,
            BiowareCommon_BiowareLipVisemeId::Td => 12,
            BiowareCommon_BiowareLipVisemeId::Sh => 13,
            BiowareCommon_BiowareLipVisemeId::L => 14,
            BiowareCommon_BiowareLipVisemeId::Kg => 15,
            BiowareCommon_BiowareLipVisemeId::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowareLipVisemeId {
    fn default() -> Self { BiowareCommon_BiowareLipVisemeId::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowareLtrAlphabetLength {
    NeverwinterNights,
    Kotor,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowareLtrAlphabetLength {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowareLtrAlphabetLength> {
        match flag {
            26 => Ok(BiowareCommon_BiowareLtrAlphabetLength::NeverwinterNights),
            28 => Ok(BiowareCommon_BiowareLtrAlphabetLength::Kotor),
            _ => Ok(BiowareCommon_BiowareLtrAlphabetLength::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowareLtrAlphabetLength> for i64 {
    fn from(v: &BiowareCommon_BiowareLtrAlphabetLength) -> Self {
        match *v {
            BiowareCommon_BiowareLtrAlphabetLength::NeverwinterNights => 26,
            BiowareCommon_BiowareLtrAlphabetLength::Kotor => 28,
            BiowareCommon_BiowareLtrAlphabetLength::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowareLtrAlphabetLength {
    fn default() -> Self { BiowareCommon_BiowareLtrAlphabetLength::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowareObjectTypeId {
    Invalid,
    Creature,
    Door,
    Item,
    Trigger,
    Placeable,
    Waypoint,
    Encounter,
    Store,
    Area,
    Sound,
    Camera,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowareObjectTypeId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowareObjectTypeId> {
        match flag {
            0 => Ok(BiowareCommon_BiowareObjectTypeId::Invalid),
            1 => Ok(BiowareCommon_BiowareObjectTypeId::Creature),
            2 => Ok(BiowareCommon_BiowareObjectTypeId::Door),
            3 => Ok(BiowareCommon_BiowareObjectTypeId::Item),
            4 => Ok(BiowareCommon_BiowareObjectTypeId::Trigger),
            5 => Ok(BiowareCommon_BiowareObjectTypeId::Placeable),
            6 => Ok(BiowareCommon_BiowareObjectTypeId::Waypoint),
            7 => Ok(BiowareCommon_BiowareObjectTypeId::Encounter),
            8 => Ok(BiowareCommon_BiowareObjectTypeId::Store),
            9 => Ok(BiowareCommon_BiowareObjectTypeId::Area),
            10 => Ok(BiowareCommon_BiowareObjectTypeId::Sound),
            11 => Ok(BiowareCommon_BiowareObjectTypeId::Camera),
            _ => Ok(BiowareCommon_BiowareObjectTypeId::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowareObjectTypeId> for i64 {
    fn from(v: &BiowareCommon_BiowareObjectTypeId) -> Self {
        match *v {
            BiowareCommon_BiowareObjectTypeId::Invalid => 0,
            BiowareCommon_BiowareObjectTypeId::Creature => 1,
            BiowareCommon_BiowareObjectTypeId::Door => 2,
            BiowareCommon_BiowareObjectTypeId::Item => 3,
            BiowareCommon_BiowareObjectTypeId::Trigger => 4,
            BiowareCommon_BiowareObjectTypeId::Placeable => 5,
            BiowareCommon_BiowareObjectTypeId::Waypoint => 6,
            BiowareCommon_BiowareObjectTypeId::Encounter => 7,
            BiowareCommon_BiowareObjectTypeId::Store => 8,
            BiowareCommon_BiowareObjectTypeId::Area => 9,
            BiowareCommon_BiowareObjectTypeId::Sound => 10,
            BiowareCommon_BiowareObjectTypeId::Camera => 11,
            BiowareCommon_BiowareObjectTypeId::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowareObjectTypeId {
    fn default() -> Self { BiowareCommon_BiowareObjectTypeId::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowarePccCompressionCodec {
    None,
    Zlib,
    Lzo,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowarePccCompressionCodec {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowarePccCompressionCodec> {
        match flag {
            0 => Ok(BiowareCommon_BiowarePccCompressionCodec::None),
            1 => Ok(BiowareCommon_BiowarePccCompressionCodec::Zlib),
            2 => Ok(BiowareCommon_BiowarePccCompressionCodec::Lzo),
            _ => Ok(BiowareCommon_BiowarePccCompressionCodec::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowarePccCompressionCodec> for i64 {
    fn from(v: &BiowareCommon_BiowarePccCompressionCodec) -> Self {
        match *v {
            BiowareCommon_BiowarePccCompressionCodec::None => 0,
            BiowareCommon_BiowarePccCompressionCodec::Zlib => 1,
            BiowareCommon_BiowarePccCompressionCodec::Lzo => 2,
            BiowareCommon_BiowarePccCompressionCodec::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowarePccCompressionCodec {
    fn default() -> Self { BiowareCommon_BiowarePccCompressionCodec::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowarePccPackageKind {
    NormalPackage,
    PatchPackage,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowarePccPackageKind {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowarePccPackageKind> {
        match flag {
            0 => Ok(BiowareCommon_BiowarePccPackageKind::NormalPackage),
            1 => Ok(BiowareCommon_BiowarePccPackageKind::PatchPackage),
            _ => Ok(BiowareCommon_BiowarePccPackageKind::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowarePccPackageKind> for i64 {
    fn from(v: &BiowareCommon_BiowarePccPackageKind) -> Self {
        match *v {
            BiowareCommon_BiowarePccPackageKind::NormalPackage => 0,
            BiowareCommon_BiowarePccPackageKind::PatchPackage => 1,
            BiowareCommon_BiowarePccPackageKind::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowarePccPackageKind {
    fn default() -> Self { BiowareCommon_BiowarePccPackageKind::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_BiowareTpcPixelFormatId {
    Greyscale,
    RgbOrDxt1,
    RgbaOrDxt5,
    BgraXboxSwizzle,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_BiowareTpcPixelFormatId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_BiowareTpcPixelFormatId> {
        match flag {
            1 => Ok(BiowareCommon_BiowareTpcPixelFormatId::Greyscale),
            2 => Ok(BiowareCommon_BiowareTpcPixelFormatId::RgbOrDxt1),
            4 => Ok(BiowareCommon_BiowareTpcPixelFormatId::RgbaOrDxt5),
            12 => Ok(BiowareCommon_BiowareTpcPixelFormatId::BgraXboxSwizzle),
            _ => Ok(BiowareCommon_BiowareTpcPixelFormatId::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_BiowareTpcPixelFormatId> for i64 {
    fn from(v: &BiowareCommon_BiowareTpcPixelFormatId) -> Self {
        match *v {
            BiowareCommon_BiowareTpcPixelFormatId::Greyscale => 1,
            BiowareCommon_BiowareTpcPixelFormatId::RgbOrDxt1 => 2,
            BiowareCommon_BiowareTpcPixelFormatId::RgbaOrDxt5 => 4,
            BiowareCommon_BiowareTpcPixelFormatId::BgraXboxSwizzle => 12,
            BiowareCommon_BiowareTpcPixelFormatId::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_BiowareTpcPixelFormatId {
    fn default() -> Self { BiowareCommon_BiowareTpcPixelFormatId::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareCommon_RiffWaveFormatTag {
    Pcm,
    AdpcmMs,
    IeeeFloat,
    Alaw,
    Mulaw,
    DviImaAdpcm,
    MpegLayer3,
    WaveFormatExtensible,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareCommon_RiffWaveFormatTag {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareCommon_RiffWaveFormatTag> {
        match flag {
            1 => Ok(BiowareCommon_RiffWaveFormatTag::Pcm),
            2 => Ok(BiowareCommon_RiffWaveFormatTag::AdpcmMs),
            3 => Ok(BiowareCommon_RiffWaveFormatTag::IeeeFloat),
            6 => Ok(BiowareCommon_RiffWaveFormatTag::Alaw),
            7 => Ok(BiowareCommon_RiffWaveFormatTag::Mulaw),
            17 => Ok(BiowareCommon_RiffWaveFormatTag::DviImaAdpcm),
            85 => Ok(BiowareCommon_RiffWaveFormatTag::MpegLayer3),
            65534 => Ok(BiowareCommon_RiffWaveFormatTag::WaveFormatExtensible),
            _ => Ok(BiowareCommon_RiffWaveFormatTag::Unknown(flag)),
        }
    }
}

impl From<&BiowareCommon_RiffWaveFormatTag> for i64 {
    fn from(v: &BiowareCommon_RiffWaveFormatTag) -> Self {
        match *v {
            BiowareCommon_RiffWaveFormatTag::Pcm => 1,
            BiowareCommon_RiffWaveFormatTag::AdpcmMs => 2,
            BiowareCommon_RiffWaveFormatTag::IeeeFloat => 3,
            BiowareCommon_RiffWaveFormatTag::Alaw => 6,
            BiowareCommon_RiffWaveFormatTag::Mulaw => 7,
            BiowareCommon_RiffWaveFormatTag::DviImaAdpcm => 17,
            BiowareCommon_RiffWaveFormatTag::MpegLayer3 => 85,
            BiowareCommon_RiffWaveFormatTag::WaveFormatExtensible => 65534,
            BiowareCommon_RiffWaveFormatTag::Unknown(v) => v
        }
    }
}

impl Default for BiowareCommon_RiffWaveFormatTag {
    fn default() -> Self { BiowareCommon_RiffWaveFormatTag::Unknown(0) }
}


/**
 * Variable-length binary data with 4-byte length prefix.
 * Used for Void/Binary fields in GFF files.
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareCommon_BiowareBinaryData {
    pub _root: SharedType<BiowareCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    len_value: RefCell<u32>,
    value: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareCommon_BiowareBinaryData {
    type Root = BiowareCommon;
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
        *self_rc.len_value.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.value.borrow_mut() = _io.read_bytes(*self_rc.len_value() as usize)?.into();
        Ok(())
    }
}
impl BiowareCommon_BiowareBinaryData {
}

/**
 * Length of binary data in bytes
 */
impl BiowareCommon_BiowareBinaryData {
    pub fn len_value(&self) -> Ref<'_, u32> {
        self.len_value.borrow()
    }
}

/**
 * Binary data
 */
impl BiowareCommon_BiowareBinaryData {
    pub fn value(&self) -> Ref<'_, Vec<u8>> {
        self.value.borrow()
    }
}
impl BiowareCommon_BiowareBinaryData {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * BioWare CExoString - variable-length string with 4-byte length prefix.
 * Used for string fields in GFF files.
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareCommon_BiowareCexoString {
    pub _root: SharedType<BiowareCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    len_string: RefCell<u32>,
    value: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareCommon_BiowareCexoString {
    type Root = BiowareCommon;
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
        *self_rc.len_string.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.value.borrow_mut() = bytes_to_str(&_io.read_bytes(*self_rc.len_string() as usize)?.into(), "UTF-8")?;
        Ok(())
    }
}
impl BiowareCommon_BiowareCexoString {
}

/**
 * Length of string in bytes
 */
impl BiowareCommon_BiowareCexoString {
    pub fn len_string(&self) -> Ref<'_, u32> {
        self.len_string.borrow()
    }
}

/**
 * String data (UTF-8)
 */
impl BiowareCommon_BiowareCexoString {
    pub fn value(&self) -> Ref<'_, String> {
        self.value.borrow()
    }
}
impl BiowareCommon_BiowareCexoString {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
 * section for field type "LocalizedString".
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareCommon_BiowareLocstring {
    pub _root: SharedType<BiowareCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    total_size: RefCell<u32>,
    string_ref: RefCell<u32>,
    num_substrings: RefCell<u32>,
    substrings: RefCell<Vec<OptRc<BiowareCommon_Substring>>>,
    _io: RefCell<BytesReader>,
    f_has_strref: Cell<bool>,
    has_strref: RefCell<bool>,
}
impl KStruct for BiowareCommon_BiowareLocstring {
    type Root = BiowareCommon;
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
        *self_rc.total_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.string_ref.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.num_substrings.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.substrings.borrow_mut() = Vec::new();
        let l_substrings = *self_rc.num_substrings();
        for _i in 0..l_substrings {
            let t = Self::read_into::<_, BiowareCommon_Substring>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.substrings.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl BiowareCommon_BiowareLocstring {

    /**
     * True if this locstring references dialog.tlk
     */
    pub fn has_strref(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_strref.get() {
            return Ok(self.has_strref.borrow());
        }
        self.f_has_strref.set(true);
        *self.has_strref.borrow_mut() = (((*self.string_ref() as i32) != (4294967295 as i32))) as bool;
        Ok(self.has_strref.borrow())
    }
}

/**
 * Total size of the structure in bytes (excluding this field).
 */
impl BiowareCommon_BiowareLocstring {
    pub fn total_size(&self) -> Ref<'_, u32> {
        self.total_size.borrow()
    }
}

/**
 * StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).
 */
impl BiowareCommon_BiowareLocstring {
    pub fn string_ref(&self) -> Ref<'_, u32> {
        self.string_ref.borrow()
    }
}

/**
 * Number of substring entries that follow.
 */
impl BiowareCommon_BiowareLocstring {
    pub fn num_substrings(&self) -> Ref<'_, u32> {
        self.num_substrings.borrow()
    }
}

/**
 * Language/gender-specific substring entries.
 */
impl BiowareCommon_BiowareLocstring {
    pub fn substrings(&self) -> Ref<'_, Vec<OptRc<BiowareCommon_Substring>>> {
        self.substrings.borrow()
    }
}
impl BiowareCommon_BiowareLocstring {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
 * Used throughout GFF files to reference game resources by name.
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareCommon_BiowareResref {
    pub _root: SharedType<BiowareCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    len_resref: RefCell<u8>,
    value: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareCommon_BiowareResref {
    type Root = BiowareCommon;
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
        *self_rc.len_resref.borrow_mut() = _io.read_u1()?.into();
        if !(((*self_rc.len_resref() as u8) <= (16 as u8))) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::GreaterThan, src_path: "/types/bioware_resref/seq/0".to_string() }));
        }
        *self_rc.value.borrow_mut() = bytes_to_str(&_io.read_bytes(*self_rc.len_resref() as usize)?.into(), "ASCII")?;
        Ok(())
    }
}
impl BiowareCommon_BiowareResref {
}

/**
 * Length of ResRef string (0-16 characters)
 */
impl BiowareCommon_BiowareResref {
    pub fn len_resref(&self) -> Ref<'_, u8> {
        self.len_resref.borrow()
    }
}

/**
 * ResRef string data (ASCII, lowercase recommended)
 */
impl BiowareCommon_BiowareResref {
    pub fn value(&self) -> Ref<'_, String> {
        self.value.borrow()
    }
}
impl BiowareCommon_BiowareResref {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * 3D vector (X, Y, Z coordinates).
 * Used for positions, directions, etc. in game files.
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareCommon_BiowareVector3 {
    pub _root: SharedType<BiowareCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    x: RefCell<f32>,
    y: RefCell<f32>,
    z: RefCell<f32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareCommon_BiowareVector3 {
    type Root = BiowareCommon;
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
        *self_rc.x.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.y.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.z.borrow_mut() = _io.read_f4le()?.into();
        Ok(())
    }
}
impl BiowareCommon_BiowareVector3 {
}

/**
 * X coordinate
 */
impl BiowareCommon_BiowareVector3 {
    pub fn x(&self) -> Ref<'_, f32> {
        self.x.borrow()
    }
}

/**
 * Y coordinate
 */
impl BiowareCommon_BiowareVector3 {
    pub fn y(&self) -> Ref<'_, f32> {
        self.y.borrow()
    }
}

/**
 * Z coordinate
 */
impl BiowareCommon_BiowareVector3 {
    pub fn z(&self) -> Ref<'_, f32> {
        self.z.borrow()
    }
}
impl BiowareCommon_BiowareVector3 {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * 4D vector / Quaternion (X, Y, Z, W components).
 * Used for orientations/rotations in game files.
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareCommon_BiowareVector4 {
    pub _root: SharedType<BiowareCommon>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    x: RefCell<f32>,
    y: RefCell<f32>,
    z: RefCell<f32>,
    w: RefCell<f32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareCommon_BiowareVector4 {
    type Root = BiowareCommon;
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
        *self_rc.x.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.y.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.z.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.w.borrow_mut() = _io.read_f4le()?.into();
        Ok(())
    }
}
impl BiowareCommon_BiowareVector4 {
}

/**
 * X component
 */
impl BiowareCommon_BiowareVector4 {
    pub fn x(&self) -> Ref<'_, f32> {
        self.x.borrow()
    }
}

/**
 * Y component
 */
impl BiowareCommon_BiowareVector4 {
    pub fn y(&self) -> Ref<'_, f32> {
        self.y.borrow()
    }
}

/**
 * Z component
 */
impl BiowareCommon_BiowareVector4 {
    pub fn z(&self) -> Ref<'_, f32> {
        self.z.borrow()
    }
}

/**
 * W component
 */
impl BiowareCommon_BiowareVector4 {
    pub fn w(&self) -> Ref<'_, f32> {
        self.w.borrow()
    }
}
impl BiowareCommon_BiowareVector4 {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct BiowareCommon_Substring {
    pub _root: SharedType<BiowareCommon>,
    pub _parent: SharedType<BiowareCommon_BiowareLocstring>,
    pub _self: SharedType<Self>,
    substring_id: RefCell<u32>,
    len_text: RefCell<u32>,
    text: RefCell<String>,
    _io: RefCell<BytesReader>,
    f_gender: Cell<bool>,
    gender: RefCell<BiowareCommon_BiowareGenderId>,
    f_gender_raw: Cell<bool>,
    gender_raw: RefCell<i32>,
    f_language: Cell<bool>,
    language: RefCell<BiowareCommon_BiowareLanguageId>,
    f_language_raw: Cell<bool>,
    language_raw: RefCell<i32>,
}
impl KStruct for BiowareCommon_Substring {
    type Root = BiowareCommon;
    type Parent = BiowareCommon_BiowareLocstring;

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
        *self_rc.substring_id.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.len_text.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.text.borrow_mut() = bytes_to_str(&_io.read_bytes(*self_rc.len_text() as usize)?.into(), "UTF-8")?;
        Ok(())
    }
}
impl BiowareCommon_Substring {

    /**
     * Gender as enum value
     */
    pub fn gender(
        &self
    ) -> KResult<Ref<'_, BiowareCommon_BiowareGenderId>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_gender.get() {
            return Ok(self.gender.borrow());
        }
        self.f_gender.set(true);
        *self.gender.borrow_mut() = (*self.gender_raw()? as i64).try_into()?;
        Ok(self.gender.borrow())
    }

    /**
     * Raw gender ID (0..255).
     */
    pub fn gender_raw(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_gender_raw.get() {
            return Ok(self.gender_raw.borrow());
        }
        self.f_gender_raw.set(true);
        *self.gender_raw.borrow_mut() = (((*self.substring_id() as u32) & (255 as u32))) as i32;
        Ok(self.gender_raw.borrow())
    }

    /**
     * Language as enum value
     */
    pub fn language(
        &self
    ) -> KResult<Ref<'_, BiowareCommon_BiowareLanguageId>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_language.get() {
            return Ok(self.language.borrow());
        }
        self.f_language.set(true);
        *self.language.borrow_mut() = (*self.language_raw()? as i64).try_into()?;
        Ok(self.language.borrow())
    }

    /**
     * Raw language ID (0..255).
     */
    pub fn language_raw(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_language_raw.get() {
            return Ok(self.language_raw.borrow());
        }
        self.f_language_raw.set(true);
        *self.language_raw.borrow_mut() = (((((*self.substring_id() as u32) >> (8 as u32)) as i32) & (255 as i32))) as i32;
        Ok(self.language_raw.borrow())
    }
}

/**
 * Packed language+gender identifier:
 * - bits 0..7: gender
 * - bits 8..15: language
 */
impl BiowareCommon_Substring {
    pub fn substring_id(&self) -> Ref<'_, u32> {
        self.substring_id.borrow()
    }
}

/**
 * Length of text in bytes.
 */
impl BiowareCommon_Substring {
    pub fn len_text(&self) -> Ref<'_, u32> {
        self.len_text.borrow()
    }
}

/**
 * Substring text.
 */
impl BiowareCommon_Substring {
    pub fn text(&self) -> Ref<'_, String> {
        self.text.borrow()
    }
}
impl BiowareCommon_Substring {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
