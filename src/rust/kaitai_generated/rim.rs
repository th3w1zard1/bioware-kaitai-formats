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
 * - Key / resource entry table (32 bytes per entry): ResRef, type, ID, offset, size
 * - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim
 * - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/rimreader.cpp:24-100
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp:40-160
 * - https://github.com/KotOR-Community-Patches/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs:11-121
 * - https://github.com/KotOR-Community-Patches/KotOR_IO/blob/master/KotOR_IO/File%20Formats/RIM.cs:20-260
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
#[derive(Debug, PartialEq, Clone)]
pub enum Rim_XoreosFileTypeId {
    None,
    Res,
    Bmp,
    Mve,
    Tga,
    Wav,
    Plt,
    Ini,
    Bmu,
    Mpg,
    Txt,
    Wma,
    Wmv,
    Xmv,
    Plh,
    Tex,
    Mdl,
    Thg,
    Fnt,
    Lua,
    Slt,
    Nss,
    Ncs,
    Mod,
    Are,
    Set,
    Ifo,
    Bic,
    Wok,
    TwoDa,
    Tlk,
    Txi,
    Git,
    Bti,
    Uti,
    Btc,
    Utc,
    Dlg,
    Itp,
    Btt,
    Utt,
    Dds,
    Bts,
    Uts,
    Ltr,
    Gff,
    Fac,
    Bte,
    Ute,
    Btd,
    Utd,
    Btp,
    Utp,
    Dft,
    Gic,
    Gui,
    Css,
    Ccs,
    Btm,
    Utm,
    Dwk,
    Pwk,
    Btg,
    Utg,
    Jrl,
    Sav,
    Utw,
    FourPc,
    Ssf,
    Hak,
    Nwm,
    Bik,
    Ndb,
    Ptm,
    Ptt,
    Ncm,
    Mfx,
    Mat,
    Mdb,
    Say,
    Ttf,
    Ttc,
    Cut,
    Ka,
    Jpg,
    Ico,
    Ogg,
    Spt,
    Spw,
    Wfx,
    Ugm,
    Qdb,
    Qst,
    Npc,
    Spn,
    Utx,
    Mmd,
    Smm,
    Uta,
    Mde,
    Mdv,
    Mda,
    Mba,
    Oct,
    Bfx,
    Pdb,
    TheWitcherSave,
    Pvs,
    Cfx,
    Luc,
    Prb,
    Cam,
    Vds,
    Bin,
    Wob,
    Api,
    Properties,
    Png,
    Lyt,
    Vis,
    Rim,
    Pth,
    Lip,
    Bwm,
    Txb,
    Tpc,
    Mdx,
    Rsv,
    Sig,
    Mab,
    Qst2,
    Sto,
    Hex,
    Mdx2,
    Txb2,
    Fsm,
    Art,
    Amp,
    Cwa,
    Bip,
    Mdb2,
    Mda2,
    Spt2,
    Gr2,
    Fxa,
    Fxe,
    Jpg2,
    Pwc,
    OneDa,
    Erf,
    Bif,
    Key,
    Exe,
    Dbf,
    Cdx,
    Fpt,
    Zip,
    Fxm,
    Fxs,
    Xml,
    Wlk,
    Utr,
    Sef,
    Pfx,
    Tfx,
    Ifx,
    Lfx,
    Bbx,
    Pfb,
    Upe,
    Usc,
    Ult,
    Fx,
    Max,
    Doc,
    Scc,
    Wmp,
    Osc,
    Trn,
    Uen,
    Ros,
    Rst,
    Ptx,
    Ltx,
    Trx,
    Nds,
    Herf,
    Dict,
    Small,
    Cbgt,
    Cdpth,
    Emit,
    Itm,
    Nanr,
    Nbfp,
    Nbfs,
    Ncer,
    Ncgr,
    Nclr,
    Nftr,
    Nsbca,
    Nsbmd,
    Nsbta,
    Nsbtp,
    Nsbtx,
    Pal,
    Raw,
    Sadl,
    Sdat,
    Smp,
    Spl,
    Vx,
    Anb,
    Ani,
    Cns,
    Cur,
    Evt,
    Fdl,
    Fxo,
    Gad,
    Gda,
    Gfx,
    Ldf,
    Lst,
    Mal,
    Mao,
    Mmh,
    Mop,
    Mor,
    Msh,
    Mtx,
    Ncc,
    Phy,
    Plo,
    Stg,
    Tbi,
    Tnt,
    Arl,
    Fev,
    Fsb,
    Opf,
    Crf,
    Rimp,
    Met,
    Meta,
    Fxr,
    Cif,
    Cub,
    Dlb,
    Nsc,
    Mov,
    Curs,
    Pict,
    Rsrc,
    Plist,
    Cre,
    Pso,
    Vso,
    Abc,
    Sbm,
    Pvd,
    Pla,
    Trg,
    Pk,
    Als,
    Apl,
    Assembly,
    Bak,
    Bnk,
    Cl,
    Cnv,
    Con,
    Dat,
    Dx11,
    Ids,
    Log,
    Map,
    Mml,
    Mp3,
    Pck,
    Rml,
    S,
    Sta,
    Svr,
    Vlm,
    Wbd,
    Xbx,
    Xls,
    Bzf,
    Adv,
    Json,
    TlkExpert,
    TlkMobile,
    TlkTouch,
    Otf,
    Par,
    Xwb,
    Xsb,
    Xds,
    Wnd,
    Xeositex,
    Unknown(i64),
}

impl TryFrom<i64> for Rim_XoreosFileTypeId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<Rim_XoreosFileTypeId> {
        match flag {
            -1 => Ok(Rim_XoreosFileTypeId::None),
            0 => Ok(Rim_XoreosFileTypeId::Res),
            1 => Ok(Rim_XoreosFileTypeId::Bmp),
            2 => Ok(Rim_XoreosFileTypeId::Mve),
            3 => Ok(Rim_XoreosFileTypeId::Tga),
            4 => Ok(Rim_XoreosFileTypeId::Wav),
            6 => Ok(Rim_XoreosFileTypeId::Plt),
            7 => Ok(Rim_XoreosFileTypeId::Ini),
            8 => Ok(Rim_XoreosFileTypeId::Bmu),
            9 => Ok(Rim_XoreosFileTypeId::Mpg),
            10 => Ok(Rim_XoreosFileTypeId::Txt),
            11 => Ok(Rim_XoreosFileTypeId::Wma),
            12 => Ok(Rim_XoreosFileTypeId::Wmv),
            13 => Ok(Rim_XoreosFileTypeId::Xmv),
            2000 => Ok(Rim_XoreosFileTypeId::Plh),
            2001 => Ok(Rim_XoreosFileTypeId::Tex),
            2002 => Ok(Rim_XoreosFileTypeId::Mdl),
            2003 => Ok(Rim_XoreosFileTypeId::Thg),
            2005 => Ok(Rim_XoreosFileTypeId::Fnt),
            2007 => Ok(Rim_XoreosFileTypeId::Lua),
            2008 => Ok(Rim_XoreosFileTypeId::Slt),
            2009 => Ok(Rim_XoreosFileTypeId::Nss),
            2010 => Ok(Rim_XoreosFileTypeId::Ncs),
            2011 => Ok(Rim_XoreosFileTypeId::Mod),
            2012 => Ok(Rim_XoreosFileTypeId::Are),
            2013 => Ok(Rim_XoreosFileTypeId::Set),
            2014 => Ok(Rim_XoreosFileTypeId::Ifo),
            2015 => Ok(Rim_XoreosFileTypeId::Bic),
            2016 => Ok(Rim_XoreosFileTypeId::Wok),
            2017 => Ok(Rim_XoreosFileTypeId::TwoDa),
            2018 => Ok(Rim_XoreosFileTypeId::Tlk),
            2022 => Ok(Rim_XoreosFileTypeId::Txi),
            2023 => Ok(Rim_XoreosFileTypeId::Git),
            2024 => Ok(Rim_XoreosFileTypeId::Bti),
            2025 => Ok(Rim_XoreosFileTypeId::Uti),
            2026 => Ok(Rim_XoreosFileTypeId::Btc),
            2027 => Ok(Rim_XoreosFileTypeId::Utc),
            2029 => Ok(Rim_XoreosFileTypeId::Dlg),
            2030 => Ok(Rim_XoreosFileTypeId::Itp),
            2031 => Ok(Rim_XoreosFileTypeId::Btt),
            2032 => Ok(Rim_XoreosFileTypeId::Utt),
            2033 => Ok(Rim_XoreosFileTypeId::Dds),
            2034 => Ok(Rim_XoreosFileTypeId::Bts),
            2035 => Ok(Rim_XoreosFileTypeId::Uts),
            2036 => Ok(Rim_XoreosFileTypeId::Ltr),
            2037 => Ok(Rim_XoreosFileTypeId::Gff),
            2038 => Ok(Rim_XoreosFileTypeId::Fac),
            2039 => Ok(Rim_XoreosFileTypeId::Bte),
            2040 => Ok(Rim_XoreosFileTypeId::Ute),
            2041 => Ok(Rim_XoreosFileTypeId::Btd),
            2042 => Ok(Rim_XoreosFileTypeId::Utd),
            2043 => Ok(Rim_XoreosFileTypeId::Btp),
            2044 => Ok(Rim_XoreosFileTypeId::Utp),
            2045 => Ok(Rim_XoreosFileTypeId::Dft),
            2046 => Ok(Rim_XoreosFileTypeId::Gic),
            2047 => Ok(Rim_XoreosFileTypeId::Gui),
            2048 => Ok(Rim_XoreosFileTypeId::Css),
            2049 => Ok(Rim_XoreosFileTypeId::Ccs),
            2050 => Ok(Rim_XoreosFileTypeId::Btm),
            2051 => Ok(Rim_XoreosFileTypeId::Utm),
            2052 => Ok(Rim_XoreosFileTypeId::Dwk),
            2053 => Ok(Rim_XoreosFileTypeId::Pwk),
            2054 => Ok(Rim_XoreosFileTypeId::Btg),
            2055 => Ok(Rim_XoreosFileTypeId::Utg),
            2056 => Ok(Rim_XoreosFileTypeId::Jrl),
            2057 => Ok(Rim_XoreosFileTypeId::Sav),
            2058 => Ok(Rim_XoreosFileTypeId::Utw),
            2059 => Ok(Rim_XoreosFileTypeId::FourPc),
            2060 => Ok(Rim_XoreosFileTypeId::Ssf),
            2061 => Ok(Rim_XoreosFileTypeId::Hak),
            2062 => Ok(Rim_XoreosFileTypeId::Nwm),
            2063 => Ok(Rim_XoreosFileTypeId::Bik),
            2064 => Ok(Rim_XoreosFileTypeId::Ndb),
            2065 => Ok(Rim_XoreosFileTypeId::Ptm),
            2066 => Ok(Rim_XoreosFileTypeId::Ptt),
            2067 => Ok(Rim_XoreosFileTypeId::Ncm),
            2068 => Ok(Rim_XoreosFileTypeId::Mfx),
            2069 => Ok(Rim_XoreosFileTypeId::Mat),
            2070 => Ok(Rim_XoreosFileTypeId::Mdb),
            2071 => Ok(Rim_XoreosFileTypeId::Say),
            2072 => Ok(Rim_XoreosFileTypeId::Ttf),
            2073 => Ok(Rim_XoreosFileTypeId::Ttc),
            2074 => Ok(Rim_XoreosFileTypeId::Cut),
            2075 => Ok(Rim_XoreosFileTypeId::Ka),
            2076 => Ok(Rim_XoreosFileTypeId::Jpg),
            2077 => Ok(Rim_XoreosFileTypeId::Ico),
            2078 => Ok(Rim_XoreosFileTypeId::Ogg),
            2079 => Ok(Rim_XoreosFileTypeId::Spt),
            2080 => Ok(Rim_XoreosFileTypeId::Spw),
            2081 => Ok(Rim_XoreosFileTypeId::Wfx),
            2082 => Ok(Rim_XoreosFileTypeId::Ugm),
            2083 => Ok(Rim_XoreosFileTypeId::Qdb),
            2084 => Ok(Rim_XoreosFileTypeId::Qst),
            2085 => Ok(Rim_XoreosFileTypeId::Npc),
            2086 => Ok(Rim_XoreosFileTypeId::Spn),
            2087 => Ok(Rim_XoreosFileTypeId::Utx),
            2088 => Ok(Rim_XoreosFileTypeId::Mmd),
            2089 => Ok(Rim_XoreosFileTypeId::Smm),
            2090 => Ok(Rim_XoreosFileTypeId::Uta),
            2091 => Ok(Rim_XoreosFileTypeId::Mde),
            2092 => Ok(Rim_XoreosFileTypeId::Mdv),
            2093 => Ok(Rim_XoreosFileTypeId::Mda),
            2094 => Ok(Rim_XoreosFileTypeId::Mba),
            2095 => Ok(Rim_XoreosFileTypeId::Oct),
            2096 => Ok(Rim_XoreosFileTypeId::Bfx),
            2097 => Ok(Rim_XoreosFileTypeId::Pdb),
            2098 => Ok(Rim_XoreosFileTypeId::TheWitcherSave),
            2099 => Ok(Rim_XoreosFileTypeId::Pvs),
            2100 => Ok(Rim_XoreosFileTypeId::Cfx),
            2101 => Ok(Rim_XoreosFileTypeId::Luc),
            2103 => Ok(Rim_XoreosFileTypeId::Prb),
            2104 => Ok(Rim_XoreosFileTypeId::Cam),
            2105 => Ok(Rim_XoreosFileTypeId::Vds),
            2106 => Ok(Rim_XoreosFileTypeId::Bin),
            2107 => Ok(Rim_XoreosFileTypeId::Wob),
            2108 => Ok(Rim_XoreosFileTypeId::Api),
            2109 => Ok(Rim_XoreosFileTypeId::Properties),
            2110 => Ok(Rim_XoreosFileTypeId::Png),
            3000 => Ok(Rim_XoreosFileTypeId::Lyt),
            3001 => Ok(Rim_XoreosFileTypeId::Vis),
            3002 => Ok(Rim_XoreosFileTypeId::Rim),
            3003 => Ok(Rim_XoreosFileTypeId::Pth),
            3004 => Ok(Rim_XoreosFileTypeId::Lip),
            3005 => Ok(Rim_XoreosFileTypeId::Bwm),
            3006 => Ok(Rim_XoreosFileTypeId::Txb),
            3007 => Ok(Rim_XoreosFileTypeId::Tpc),
            3008 => Ok(Rim_XoreosFileTypeId::Mdx),
            3009 => Ok(Rim_XoreosFileTypeId::Rsv),
            3010 => Ok(Rim_XoreosFileTypeId::Sig),
            3011 => Ok(Rim_XoreosFileTypeId::Mab),
            3012 => Ok(Rim_XoreosFileTypeId::Qst2),
            3013 => Ok(Rim_XoreosFileTypeId::Sto),
            3015 => Ok(Rim_XoreosFileTypeId::Hex),
            3016 => Ok(Rim_XoreosFileTypeId::Mdx2),
            3017 => Ok(Rim_XoreosFileTypeId::Txb2),
            3022 => Ok(Rim_XoreosFileTypeId::Fsm),
            3023 => Ok(Rim_XoreosFileTypeId::Art),
            3024 => Ok(Rim_XoreosFileTypeId::Amp),
            3025 => Ok(Rim_XoreosFileTypeId::Cwa),
            3028 => Ok(Rim_XoreosFileTypeId::Bip),
            4000 => Ok(Rim_XoreosFileTypeId::Mdb2),
            4001 => Ok(Rim_XoreosFileTypeId::Mda2),
            4002 => Ok(Rim_XoreosFileTypeId::Spt2),
            4003 => Ok(Rim_XoreosFileTypeId::Gr2),
            4004 => Ok(Rim_XoreosFileTypeId::Fxa),
            4005 => Ok(Rim_XoreosFileTypeId::Fxe),
            4007 => Ok(Rim_XoreosFileTypeId::Jpg2),
            4008 => Ok(Rim_XoreosFileTypeId::Pwc),
            9996 => Ok(Rim_XoreosFileTypeId::OneDa),
            9997 => Ok(Rim_XoreosFileTypeId::Erf),
            9998 => Ok(Rim_XoreosFileTypeId::Bif),
            9999 => Ok(Rim_XoreosFileTypeId::Key),
            19000 => Ok(Rim_XoreosFileTypeId::Exe),
            19001 => Ok(Rim_XoreosFileTypeId::Dbf),
            19002 => Ok(Rim_XoreosFileTypeId::Cdx),
            19003 => Ok(Rim_XoreosFileTypeId::Fpt),
            20000 => Ok(Rim_XoreosFileTypeId::Zip),
            20001 => Ok(Rim_XoreosFileTypeId::Fxm),
            20002 => Ok(Rim_XoreosFileTypeId::Fxs),
            20003 => Ok(Rim_XoreosFileTypeId::Xml),
            20004 => Ok(Rim_XoreosFileTypeId::Wlk),
            20005 => Ok(Rim_XoreosFileTypeId::Utr),
            20006 => Ok(Rim_XoreosFileTypeId::Sef),
            20007 => Ok(Rim_XoreosFileTypeId::Pfx),
            20008 => Ok(Rim_XoreosFileTypeId::Tfx),
            20009 => Ok(Rim_XoreosFileTypeId::Ifx),
            20010 => Ok(Rim_XoreosFileTypeId::Lfx),
            20011 => Ok(Rim_XoreosFileTypeId::Bbx),
            20012 => Ok(Rim_XoreosFileTypeId::Pfb),
            20013 => Ok(Rim_XoreosFileTypeId::Upe),
            20014 => Ok(Rim_XoreosFileTypeId::Usc),
            20015 => Ok(Rim_XoreosFileTypeId::Ult),
            20016 => Ok(Rim_XoreosFileTypeId::Fx),
            20017 => Ok(Rim_XoreosFileTypeId::Max),
            20018 => Ok(Rim_XoreosFileTypeId::Doc),
            20019 => Ok(Rim_XoreosFileTypeId::Scc),
            20020 => Ok(Rim_XoreosFileTypeId::Wmp),
            20021 => Ok(Rim_XoreosFileTypeId::Osc),
            20022 => Ok(Rim_XoreosFileTypeId::Trn),
            20023 => Ok(Rim_XoreosFileTypeId::Uen),
            20024 => Ok(Rim_XoreosFileTypeId::Ros),
            20025 => Ok(Rim_XoreosFileTypeId::Rst),
            20026 => Ok(Rim_XoreosFileTypeId::Ptx),
            20027 => Ok(Rim_XoreosFileTypeId::Ltx),
            20028 => Ok(Rim_XoreosFileTypeId::Trx),
            21000 => Ok(Rim_XoreosFileTypeId::Nds),
            21001 => Ok(Rim_XoreosFileTypeId::Herf),
            21002 => Ok(Rim_XoreosFileTypeId::Dict),
            21003 => Ok(Rim_XoreosFileTypeId::Small),
            21004 => Ok(Rim_XoreosFileTypeId::Cbgt),
            21005 => Ok(Rim_XoreosFileTypeId::Cdpth),
            21006 => Ok(Rim_XoreosFileTypeId::Emit),
            21007 => Ok(Rim_XoreosFileTypeId::Itm),
            21008 => Ok(Rim_XoreosFileTypeId::Nanr),
            21009 => Ok(Rim_XoreosFileTypeId::Nbfp),
            21010 => Ok(Rim_XoreosFileTypeId::Nbfs),
            21011 => Ok(Rim_XoreosFileTypeId::Ncer),
            21012 => Ok(Rim_XoreosFileTypeId::Ncgr),
            21013 => Ok(Rim_XoreosFileTypeId::Nclr),
            21014 => Ok(Rim_XoreosFileTypeId::Nftr),
            21015 => Ok(Rim_XoreosFileTypeId::Nsbca),
            21016 => Ok(Rim_XoreosFileTypeId::Nsbmd),
            21017 => Ok(Rim_XoreosFileTypeId::Nsbta),
            21018 => Ok(Rim_XoreosFileTypeId::Nsbtp),
            21019 => Ok(Rim_XoreosFileTypeId::Nsbtx),
            21020 => Ok(Rim_XoreosFileTypeId::Pal),
            21021 => Ok(Rim_XoreosFileTypeId::Raw),
            21022 => Ok(Rim_XoreosFileTypeId::Sadl),
            21023 => Ok(Rim_XoreosFileTypeId::Sdat),
            21024 => Ok(Rim_XoreosFileTypeId::Smp),
            21025 => Ok(Rim_XoreosFileTypeId::Spl),
            21026 => Ok(Rim_XoreosFileTypeId::Vx),
            22000 => Ok(Rim_XoreosFileTypeId::Anb),
            22001 => Ok(Rim_XoreosFileTypeId::Ani),
            22002 => Ok(Rim_XoreosFileTypeId::Cns),
            22003 => Ok(Rim_XoreosFileTypeId::Cur),
            22004 => Ok(Rim_XoreosFileTypeId::Evt),
            22005 => Ok(Rim_XoreosFileTypeId::Fdl),
            22006 => Ok(Rim_XoreosFileTypeId::Fxo),
            22007 => Ok(Rim_XoreosFileTypeId::Gad),
            22008 => Ok(Rim_XoreosFileTypeId::Gda),
            22009 => Ok(Rim_XoreosFileTypeId::Gfx),
            22010 => Ok(Rim_XoreosFileTypeId::Ldf),
            22011 => Ok(Rim_XoreosFileTypeId::Lst),
            22012 => Ok(Rim_XoreosFileTypeId::Mal),
            22013 => Ok(Rim_XoreosFileTypeId::Mao),
            22014 => Ok(Rim_XoreosFileTypeId::Mmh),
            22015 => Ok(Rim_XoreosFileTypeId::Mop),
            22016 => Ok(Rim_XoreosFileTypeId::Mor),
            22017 => Ok(Rim_XoreosFileTypeId::Msh),
            22018 => Ok(Rim_XoreosFileTypeId::Mtx),
            22019 => Ok(Rim_XoreosFileTypeId::Ncc),
            22020 => Ok(Rim_XoreosFileTypeId::Phy),
            22021 => Ok(Rim_XoreosFileTypeId::Plo),
            22022 => Ok(Rim_XoreosFileTypeId::Stg),
            22023 => Ok(Rim_XoreosFileTypeId::Tbi),
            22024 => Ok(Rim_XoreosFileTypeId::Tnt),
            22025 => Ok(Rim_XoreosFileTypeId::Arl),
            22026 => Ok(Rim_XoreosFileTypeId::Fev),
            22027 => Ok(Rim_XoreosFileTypeId::Fsb),
            22028 => Ok(Rim_XoreosFileTypeId::Opf),
            22029 => Ok(Rim_XoreosFileTypeId::Crf),
            22030 => Ok(Rim_XoreosFileTypeId::Rimp),
            22031 => Ok(Rim_XoreosFileTypeId::Met),
            22032 => Ok(Rim_XoreosFileTypeId::Meta),
            22033 => Ok(Rim_XoreosFileTypeId::Fxr),
            22034 => Ok(Rim_XoreosFileTypeId::Cif),
            22035 => Ok(Rim_XoreosFileTypeId::Cub),
            22036 => Ok(Rim_XoreosFileTypeId::Dlb),
            22037 => Ok(Rim_XoreosFileTypeId::Nsc),
            23000 => Ok(Rim_XoreosFileTypeId::Mov),
            23001 => Ok(Rim_XoreosFileTypeId::Curs),
            23002 => Ok(Rim_XoreosFileTypeId::Pict),
            23003 => Ok(Rim_XoreosFileTypeId::Rsrc),
            23004 => Ok(Rim_XoreosFileTypeId::Plist),
            24000 => Ok(Rim_XoreosFileTypeId::Cre),
            24001 => Ok(Rim_XoreosFileTypeId::Pso),
            24002 => Ok(Rim_XoreosFileTypeId::Vso),
            24003 => Ok(Rim_XoreosFileTypeId::Abc),
            24004 => Ok(Rim_XoreosFileTypeId::Sbm),
            24005 => Ok(Rim_XoreosFileTypeId::Pvd),
            24006 => Ok(Rim_XoreosFileTypeId::Pla),
            24007 => Ok(Rim_XoreosFileTypeId::Trg),
            24008 => Ok(Rim_XoreosFileTypeId::Pk),
            25000 => Ok(Rim_XoreosFileTypeId::Als),
            25001 => Ok(Rim_XoreosFileTypeId::Apl),
            25002 => Ok(Rim_XoreosFileTypeId::Assembly),
            25003 => Ok(Rim_XoreosFileTypeId::Bak),
            25004 => Ok(Rim_XoreosFileTypeId::Bnk),
            25005 => Ok(Rim_XoreosFileTypeId::Cl),
            25006 => Ok(Rim_XoreosFileTypeId::Cnv),
            25007 => Ok(Rim_XoreosFileTypeId::Con),
            25008 => Ok(Rim_XoreosFileTypeId::Dat),
            25009 => Ok(Rim_XoreosFileTypeId::Dx11),
            25010 => Ok(Rim_XoreosFileTypeId::Ids),
            25011 => Ok(Rim_XoreosFileTypeId::Log),
            25012 => Ok(Rim_XoreosFileTypeId::Map),
            25013 => Ok(Rim_XoreosFileTypeId::Mml),
            25014 => Ok(Rim_XoreosFileTypeId::Mp3),
            25015 => Ok(Rim_XoreosFileTypeId::Pck),
            25016 => Ok(Rim_XoreosFileTypeId::Rml),
            25017 => Ok(Rim_XoreosFileTypeId::S),
            25018 => Ok(Rim_XoreosFileTypeId::Sta),
            25019 => Ok(Rim_XoreosFileTypeId::Svr),
            25020 => Ok(Rim_XoreosFileTypeId::Vlm),
            25021 => Ok(Rim_XoreosFileTypeId::Wbd),
            25022 => Ok(Rim_XoreosFileTypeId::Xbx),
            25023 => Ok(Rim_XoreosFileTypeId::Xls),
            26000 => Ok(Rim_XoreosFileTypeId::Bzf),
            27000 => Ok(Rim_XoreosFileTypeId::Adv),
            28000 => Ok(Rim_XoreosFileTypeId::Json),
            28001 => Ok(Rim_XoreosFileTypeId::TlkExpert),
            28002 => Ok(Rim_XoreosFileTypeId::TlkMobile),
            28003 => Ok(Rim_XoreosFileTypeId::TlkTouch),
            28004 => Ok(Rim_XoreosFileTypeId::Otf),
            28005 => Ok(Rim_XoreosFileTypeId::Par),
            29000 => Ok(Rim_XoreosFileTypeId::Xwb),
            29001 => Ok(Rim_XoreosFileTypeId::Xsb),
            30000 => Ok(Rim_XoreosFileTypeId::Xds),
            30001 => Ok(Rim_XoreosFileTypeId::Wnd),
            40000 => Ok(Rim_XoreosFileTypeId::Xeositex),
            _ => Ok(Rim_XoreosFileTypeId::Unknown(flag)),
        }
    }
}

impl From<&Rim_XoreosFileTypeId> for i64 {
    fn from(v: &Rim_XoreosFileTypeId) -> Self {
        match *v {
            Rim_XoreosFileTypeId::None => -1,
            Rim_XoreosFileTypeId::Res => 0,
            Rim_XoreosFileTypeId::Bmp => 1,
            Rim_XoreosFileTypeId::Mve => 2,
            Rim_XoreosFileTypeId::Tga => 3,
            Rim_XoreosFileTypeId::Wav => 4,
            Rim_XoreosFileTypeId::Plt => 6,
            Rim_XoreosFileTypeId::Ini => 7,
            Rim_XoreosFileTypeId::Bmu => 8,
            Rim_XoreosFileTypeId::Mpg => 9,
            Rim_XoreosFileTypeId::Txt => 10,
            Rim_XoreosFileTypeId::Wma => 11,
            Rim_XoreosFileTypeId::Wmv => 12,
            Rim_XoreosFileTypeId::Xmv => 13,
            Rim_XoreosFileTypeId::Plh => 2000,
            Rim_XoreosFileTypeId::Tex => 2001,
            Rim_XoreosFileTypeId::Mdl => 2002,
            Rim_XoreosFileTypeId::Thg => 2003,
            Rim_XoreosFileTypeId::Fnt => 2005,
            Rim_XoreosFileTypeId::Lua => 2007,
            Rim_XoreosFileTypeId::Slt => 2008,
            Rim_XoreosFileTypeId::Nss => 2009,
            Rim_XoreosFileTypeId::Ncs => 2010,
            Rim_XoreosFileTypeId::Mod => 2011,
            Rim_XoreosFileTypeId::Are => 2012,
            Rim_XoreosFileTypeId::Set => 2013,
            Rim_XoreosFileTypeId::Ifo => 2014,
            Rim_XoreosFileTypeId::Bic => 2015,
            Rim_XoreosFileTypeId::Wok => 2016,
            Rim_XoreosFileTypeId::TwoDa => 2017,
            Rim_XoreosFileTypeId::Tlk => 2018,
            Rim_XoreosFileTypeId::Txi => 2022,
            Rim_XoreosFileTypeId::Git => 2023,
            Rim_XoreosFileTypeId::Bti => 2024,
            Rim_XoreosFileTypeId::Uti => 2025,
            Rim_XoreosFileTypeId::Btc => 2026,
            Rim_XoreosFileTypeId::Utc => 2027,
            Rim_XoreosFileTypeId::Dlg => 2029,
            Rim_XoreosFileTypeId::Itp => 2030,
            Rim_XoreosFileTypeId::Btt => 2031,
            Rim_XoreosFileTypeId::Utt => 2032,
            Rim_XoreosFileTypeId::Dds => 2033,
            Rim_XoreosFileTypeId::Bts => 2034,
            Rim_XoreosFileTypeId::Uts => 2035,
            Rim_XoreosFileTypeId::Ltr => 2036,
            Rim_XoreosFileTypeId::Gff => 2037,
            Rim_XoreosFileTypeId::Fac => 2038,
            Rim_XoreosFileTypeId::Bte => 2039,
            Rim_XoreosFileTypeId::Ute => 2040,
            Rim_XoreosFileTypeId::Btd => 2041,
            Rim_XoreosFileTypeId::Utd => 2042,
            Rim_XoreosFileTypeId::Btp => 2043,
            Rim_XoreosFileTypeId::Utp => 2044,
            Rim_XoreosFileTypeId::Dft => 2045,
            Rim_XoreosFileTypeId::Gic => 2046,
            Rim_XoreosFileTypeId::Gui => 2047,
            Rim_XoreosFileTypeId::Css => 2048,
            Rim_XoreosFileTypeId::Ccs => 2049,
            Rim_XoreosFileTypeId::Btm => 2050,
            Rim_XoreosFileTypeId::Utm => 2051,
            Rim_XoreosFileTypeId::Dwk => 2052,
            Rim_XoreosFileTypeId::Pwk => 2053,
            Rim_XoreosFileTypeId::Btg => 2054,
            Rim_XoreosFileTypeId::Utg => 2055,
            Rim_XoreosFileTypeId::Jrl => 2056,
            Rim_XoreosFileTypeId::Sav => 2057,
            Rim_XoreosFileTypeId::Utw => 2058,
            Rim_XoreosFileTypeId::FourPc => 2059,
            Rim_XoreosFileTypeId::Ssf => 2060,
            Rim_XoreosFileTypeId::Hak => 2061,
            Rim_XoreosFileTypeId::Nwm => 2062,
            Rim_XoreosFileTypeId::Bik => 2063,
            Rim_XoreosFileTypeId::Ndb => 2064,
            Rim_XoreosFileTypeId::Ptm => 2065,
            Rim_XoreosFileTypeId::Ptt => 2066,
            Rim_XoreosFileTypeId::Ncm => 2067,
            Rim_XoreosFileTypeId::Mfx => 2068,
            Rim_XoreosFileTypeId::Mat => 2069,
            Rim_XoreosFileTypeId::Mdb => 2070,
            Rim_XoreosFileTypeId::Say => 2071,
            Rim_XoreosFileTypeId::Ttf => 2072,
            Rim_XoreosFileTypeId::Ttc => 2073,
            Rim_XoreosFileTypeId::Cut => 2074,
            Rim_XoreosFileTypeId::Ka => 2075,
            Rim_XoreosFileTypeId::Jpg => 2076,
            Rim_XoreosFileTypeId::Ico => 2077,
            Rim_XoreosFileTypeId::Ogg => 2078,
            Rim_XoreosFileTypeId::Spt => 2079,
            Rim_XoreosFileTypeId::Spw => 2080,
            Rim_XoreosFileTypeId::Wfx => 2081,
            Rim_XoreosFileTypeId::Ugm => 2082,
            Rim_XoreosFileTypeId::Qdb => 2083,
            Rim_XoreosFileTypeId::Qst => 2084,
            Rim_XoreosFileTypeId::Npc => 2085,
            Rim_XoreosFileTypeId::Spn => 2086,
            Rim_XoreosFileTypeId::Utx => 2087,
            Rim_XoreosFileTypeId::Mmd => 2088,
            Rim_XoreosFileTypeId::Smm => 2089,
            Rim_XoreosFileTypeId::Uta => 2090,
            Rim_XoreosFileTypeId::Mde => 2091,
            Rim_XoreosFileTypeId::Mdv => 2092,
            Rim_XoreosFileTypeId::Mda => 2093,
            Rim_XoreosFileTypeId::Mba => 2094,
            Rim_XoreosFileTypeId::Oct => 2095,
            Rim_XoreosFileTypeId::Bfx => 2096,
            Rim_XoreosFileTypeId::Pdb => 2097,
            Rim_XoreosFileTypeId::TheWitcherSave => 2098,
            Rim_XoreosFileTypeId::Pvs => 2099,
            Rim_XoreosFileTypeId::Cfx => 2100,
            Rim_XoreosFileTypeId::Luc => 2101,
            Rim_XoreosFileTypeId::Prb => 2103,
            Rim_XoreosFileTypeId::Cam => 2104,
            Rim_XoreosFileTypeId::Vds => 2105,
            Rim_XoreosFileTypeId::Bin => 2106,
            Rim_XoreosFileTypeId::Wob => 2107,
            Rim_XoreosFileTypeId::Api => 2108,
            Rim_XoreosFileTypeId::Properties => 2109,
            Rim_XoreosFileTypeId::Png => 2110,
            Rim_XoreosFileTypeId::Lyt => 3000,
            Rim_XoreosFileTypeId::Vis => 3001,
            Rim_XoreosFileTypeId::Rim => 3002,
            Rim_XoreosFileTypeId::Pth => 3003,
            Rim_XoreosFileTypeId::Lip => 3004,
            Rim_XoreosFileTypeId::Bwm => 3005,
            Rim_XoreosFileTypeId::Txb => 3006,
            Rim_XoreosFileTypeId::Tpc => 3007,
            Rim_XoreosFileTypeId::Mdx => 3008,
            Rim_XoreosFileTypeId::Rsv => 3009,
            Rim_XoreosFileTypeId::Sig => 3010,
            Rim_XoreosFileTypeId::Mab => 3011,
            Rim_XoreosFileTypeId::Qst2 => 3012,
            Rim_XoreosFileTypeId::Sto => 3013,
            Rim_XoreosFileTypeId::Hex => 3015,
            Rim_XoreosFileTypeId::Mdx2 => 3016,
            Rim_XoreosFileTypeId::Txb2 => 3017,
            Rim_XoreosFileTypeId::Fsm => 3022,
            Rim_XoreosFileTypeId::Art => 3023,
            Rim_XoreosFileTypeId::Amp => 3024,
            Rim_XoreosFileTypeId::Cwa => 3025,
            Rim_XoreosFileTypeId::Bip => 3028,
            Rim_XoreosFileTypeId::Mdb2 => 4000,
            Rim_XoreosFileTypeId::Mda2 => 4001,
            Rim_XoreosFileTypeId::Spt2 => 4002,
            Rim_XoreosFileTypeId::Gr2 => 4003,
            Rim_XoreosFileTypeId::Fxa => 4004,
            Rim_XoreosFileTypeId::Fxe => 4005,
            Rim_XoreosFileTypeId::Jpg2 => 4007,
            Rim_XoreosFileTypeId::Pwc => 4008,
            Rim_XoreosFileTypeId::OneDa => 9996,
            Rim_XoreosFileTypeId::Erf => 9997,
            Rim_XoreosFileTypeId::Bif => 9998,
            Rim_XoreosFileTypeId::Key => 9999,
            Rim_XoreosFileTypeId::Exe => 19000,
            Rim_XoreosFileTypeId::Dbf => 19001,
            Rim_XoreosFileTypeId::Cdx => 19002,
            Rim_XoreosFileTypeId::Fpt => 19003,
            Rim_XoreosFileTypeId::Zip => 20000,
            Rim_XoreosFileTypeId::Fxm => 20001,
            Rim_XoreosFileTypeId::Fxs => 20002,
            Rim_XoreosFileTypeId::Xml => 20003,
            Rim_XoreosFileTypeId::Wlk => 20004,
            Rim_XoreosFileTypeId::Utr => 20005,
            Rim_XoreosFileTypeId::Sef => 20006,
            Rim_XoreosFileTypeId::Pfx => 20007,
            Rim_XoreosFileTypeId::Tfx => 20008,
            Rim_XoreosFileTypeId::Ifx => 20009,
            Rim_XoreosFileTypeId::Lfx => 20010,
            Rim_XoreosFileTypeId::Bbx => 20011,
            Rim_XoreosFileTypeId::Pfb => 20012,
            Rim_XoreosFileTypeId::Upe => 20013,
            Rim_XoreosFileTypeId::Usc => 20014,
            Rim_XoreosFileTypeId::Ult => 20015,
            Rim_XoreosFileTypeId::Fx => 20016,
            Rim_XoreosFileTypeId::Max => 20017,
            Rim_XoreosFileTypeId::Doc => 20018,
            Rim_XoreosFileTypeId::Scc => 20019,
            Rim_XoreosFileTypeId::Wmp => 20020,
            Rim_XoreosFileTypeId::Osc => 20021,
            Rim_XoreosFileTypeId::Trn => 20022,
            Rim_XoreosFileTypeId::Uen => 20023,
            Rim_XoreosFileTypeId::Ros => 20024,
            Rim_XoreosFileTypeId::Rst => 20025,
            Rim_XoreosFileTypeId::Ptx => 20026,
            Rim_XoreosFileTypeId::Ltx => 20027,
            Rim_XoreosFileTypeId::Trx => 20028,
            Rim_XoreosFileTypeId::Nds => 21000,
            Rim_XoreosFileTypeId::Herf => 21001,
            Rim_XoreosFileTypeId::Dict => 21002,
            Rim_XoreosFileTypeId::Small => 21003,
            Rim_XoreosFileTypeId::Cbgt => 21004,
            Rim_XoreosFileTypeId::Cdpth => 21005,
            Rim_XoreosFileTypeId::Emit => 21006,
            Rim_XoreosFileTypeId::Itm => 21007,
            Rim_XoreosFileTypeId::Nanr => 21008,
            Rim_XoreosFileTypeId::Nbfp => 21009,
            Rim_XoreosFileTypeId::Nbfs => 21010,
            Rim_XoreosFileTypeId::Ncer => 21011,
            Rim_XoreosFileTypeId::Ncgr => 21012,
            Rim_XoreosFileTypeId::Nclr => 21013,
            Rim_XoreosFileTypeId::Nftr => 21014,
            Rim_XoreosFileTypeId::Nsbca => 21015,
            Rim_XoreosFileTypeId::Nsbmd => 21016,
            Rim_XoreosFileTypeId::Nsbta => 21017,
            Rim_XoreosFileTypeId::Nsbtp => 21018,
            Rim_XoreosFileTypeId::Nsbtx => 21019,
            Rim_XoreosFileTypeId::Pal => 21020,
            Rim_XoreosFileTypeId::Raw => 21021,
            Rim_XoreosFileTypeId::Sadl => 21022,
            Rim_XoreosFileTypeId::Sdat => 21023,
            Rim_XoreosFileTypeId::Smp => 21024,
            Rim_XoreosFileTypeId::Spl => 21025,
            Rim_XoreosFileTypeId::Vx => 21026,
            Rim_XoreosFileTypeId::Anb => 22000,
            Rim_XoreosFileTypeId::Ani => 22001,
            Rim_XoreosFileTypeId::Cns => 22002,
            Rim_XoreosFileTypeId::Cur => 22003,
            Rim_XoreosFileTypeId::Evt => 22004,
            Rim_XoreosFileTypeId::Fdl => 22005,
            Rim_XoreosFileTypeId::Fxo => 22006,
            Rim_XoreosFileTypeId::Gad => 22007,
            Rim_XoreosFileTypeId::Gda => 22008,
            Rim_XoreosFileTypeId::Gfx => 22009,
            Rim_XoreosFileTypeId::Ldf => 22010,
            Rim_XoreosFileTypeId::Lst => 22011,
            Rim_XoreosFileTypeId::Mal => 22012,
            Rim_XoreosFileTypeId::Mao => 22013,
            Rim_XoreosFileTypeId::Mmh => 22014,
            Rim_XoreosFileTypeId::Mop => 22015,
            Rim_XoreosFileTypeId::Mor => 22016,
            Rim_XoreosFileTypeId::Msh => 22017,
            Rim_XoreosFileTypeId::Mtx => 22018,
            Rim_XoreosFileTypeId::Ncc => 22019,
            Rim_XoreosFileTypeId::Phy => 22020,
            Rim_XoreosFileTypeId::Plo => 22021,
            Rim_XoreosFileTypeId::Stg => 22022,
            Rim_XoreosFileTypeId::Tbi => 22023,
            Rim_XoreosFileTypeId::Tnt => 22024,
            Rim_XoreosFileTypeId::Arl => 22025,
            Rim_XoreosFileTypeId::Fev => 22026,
            Rim_XoreosFileTypeId::Fsb => 22027,
            Rim_XoreosFileTypeId::Opf => 22028,
            Rim_XoreosFileTypeId::Crf => 22029,
            Rim_XoreosFileTypeId::Rimp => 22030,
            Rim_XoreosFileTypeId::Met => 22031,
            Rim_XoreosFileTypeId::Meta => 22032,
            Rim_XoreosFileTypeId::Fxr => 22033,
            Rim_XoreosFileTypeId::Cif => 22034,
            Rim_XoreosFileTypeId::Cub => 22035,
            Rim_XoreosFileTypeId::Dlb => 22036,
            Rim_XoreosFileTypeId::Nsc => 22037,
            Rim_XoreosFileTypeId::Mov => 23000,
            Rim_XoreosFileTypeId::Curs => 23001,
            Rim_XoreosFileTypeId::Pict => 23002,
            Rim_XoreosFileTypeId::Rsrc => 23003,
            Rim_XoreosFileTypeId::Plist => 23004,
            Rim_XoreosFileTypeId::Cre => 24000,
            Rim_XoreosFileTypeId::Pso => 24001,
            Rim_XoreosFileTypeId::Vso => 24002,
            Rim_XoreosFileTypeId::Abc => 24003,
            Rim_XoreosFileTypeId::Sbm => 24004,
            Rim_XoreosFileTypeId::Pvd => 24005,
            Rim_XoreosFileTypeId::Pla => 24006,
            Rim_XoreosFileTypeId::Trg => 24007,
            Rim_XoreosFileTypeId::Pk => 24008,
            Rim_XoreosFileTypeId::Als => 25000,
            Rim_XoreosFileTypeId::Apl => 25001,
            Rim_XoreosFileTypeId::Assembly => 25002,
            Rim_XoreosFileTypeId::Bak => 25003,
            Rim_XoreosFileTypeId::Bnk => 25004,
            Rim_XoreosFileTypeId::Cl => 25005,
            Rim_XoreosFileTypeId::Cnv => 25006,
            Rim_XoreosFileTypeId::Con => 25007,
            Rim_XoreosFileTypeId::Dat => 25008,
            Rim_XoreosFileTypeId::Dx11 => 25009,
            Rim_XoreosFileTypeId::Ids => 25010,
            Rim_XoreosFileTypeId::Log => 25011,
            Rim_XoreosFileTypeId::Map => 25012,
            Rim_XoreosFileTypeId::Mml => 25013,
            Rim_XoreosFileTypeId::Mp3 => 25014,
            Rim_XoreosFileTypeId::Pck => 25015,
            Rim_XoreosFileTypeId::Rml => 25016,
            Rim_XoreosFileTypeId::S => 25017,
            Rim_XoreosFileTypeId::Sta => 25018,
            Rim_XoreosFileTypeId::Svr => 25019,
            Rim_XoreosFileTypeId::Vlm => 25020,
            Rim_XoreosFileTypeId::Wbd => 25021,
            Rim_XoreosFileTypeId::Xbx => 25022,
            Rim_XoreosFileTypeId::Xls => 25023,
            Rim_XoreosFileTypeId::Bzf => 26000,
            Rim_XoreosFileTypeId::Adv => 27000,
            Rim_XoreosFileTypeId::Json => 28000,
            Rim_XoreosFileTypeId::TlkExpert => 28001,
            Rim_XoreosFileTypeId::TlkMobile => 28002,
            Rim_XoreosFileTypeId::TlkTouch => 28003,
            Rim_XoreosFileTypeId::Otf => 28004,
            Rim_XoreosFileTypeId::Par => 28005,
            Rim_XoreosFileTypeId::Xwb => 29000,
            Rim_XoreosFileTypeId::Xsb => 29001,
            Rim_XoreosFileTypeId::Xds => 30000,
            Rim_XoreosFileTypeId::Wnd => 30001,
            Rim_XoreosFileTypeId::Xeositex => 40000,
            Rim_XoreosFileTypeId::Unknown(v) => v
        }
    }
}

impl Default for Rim_XoreosFileTypeId {
    fn default() -> Self { Rim_XoreosFileTypeId::Unknown(0) }
}


#[derive(Default, Debug, Clone)]
pub struct Rim_ResourceEntry {
    pub _root: SharedType<Rim>,
    pub _parent: SharedType<Rim_ResourceEntryTable>,
    pub _self: SharedType<Self>,
    resref: RefCell<String>,
    resource_type: RefCell<Rim_XoreosFileTypeId>,
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
 * Resource type identifier (see ResourceType enum).
 * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
 */
impl Rim_ResourceEntry {
    pub fn resource_type(&self) -> Ref<'_, Rim_XoreosFileTypeId> {
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
