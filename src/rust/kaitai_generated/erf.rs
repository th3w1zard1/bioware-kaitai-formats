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
 * Binary Format Structure:
 * - Header (160 bytes): File type, version, entry counts, offsets, build date, description
 * - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
 *   include localized module names for the load screen. Each entry contains language_id (u4),
 *   string_size (u4), and string_data (UTF-8 encoded text)
 * - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
 *   - resref (16 bytes, ASCII, null-padded): Resource filename
 *   - resource_id (u4): Index into resource_list
 *   - resource_type (u2): Resource type identifier (see ResourceType enum)
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
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf - Complete ERF format documentation
 * - https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf - Official BioWare Aurora ERF specification
 * - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/erfreader.cpp:24-106 - Complete C++ ERF reader implementation
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp:44-229 - Generic Aurora ERF implementation (shared format)
 * - https://github.com/NickHugi/Kotor.NET/blob/master/Formats/KotorERF/ERFBinaryStructure.cs:11-170 - .NET ERF reader/writer
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py - PyKotor binary reader/writer
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py - ERF data model
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
#[derive(Debug, PartialEq, Clone)]
pub enum Erf_XoreosFileTypeId {
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

impl TryFrom<i64> for Erf_XoreosFileTypeId {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<Erf_XoreosFileTypeId> {
        match flag {
            -1 => Ok(Erf_XoreosFileTypeId::None),
            0 => Ok(Erf_XoreosFileTypeId::Res),
            1 => Ok(Erf_XoreosFileTypeId::Bmp),
            2 => Ok(Erf_XoreosFileTypeId::Mve),
            3 => Ok(Erf_XoreosFileTypeId::Tga),
            4 => Ok(Erf_XoreosFileTypeId::Wav),
            6 => Ok(Erf_XoreosFileTypeId::Plt),
            7 => Ok(Erf_XoreosFileTypeId::Ini),
            8 => Ok(Erf_XoreosFileTypeId::Bmu),
            9 => Ok(Erf_XoreosFileTypeId::Mpg),
            10 => Ok(Erf_XoreosFileTypeId::Txt),
            11 => Ok(Erf_XoreosFileTypeId::Wma),
            12 => Ok(Erf_XoreosFileTypeId::Wmv),
            13 => Ok(Erf_XoreosFileTypeId::Xmv),
            2000 => Ok(Erf_XoreosFileTypeId::Plh),
            2001 => Ok(Erf_XoreosFileTypeId::Tex),
            2002 => Ok(Erf_XoreosFileTypeId::Mdl),
            2003 => Ok(Erf_XoreosFileTypeId::Thg),
            2005 => Ok(Erf_XoreosFileTypeId::Fnt),
            2007 => Ok(Erf_XoreosFileTypeId::Lua),
            2008 => Ok(Erf_XoreosFileTypeId::Slt),
            2009 => Ok(Erf_XoreosFileTypeId::Nss),
            2010 => Ok(Erf_XoreosFileTypeId::Ncs),
            2011 => Ok(Erf_XoreosFileTypeId::Mod),
            2012 => Ok(Erf_XoreosFileTypeId::Are),
            2013 => Ok(Erf_XoreosFileTypeId::Set),
            2014 => Ok(Erf_XoreosFileTypeId::Ifo),
            2015 => Ok(Erf_XoreosFileTypeId::Bic),
            2016 => Ok(Erf_XoreosFileTypeId::Wok),
            2017 => Ok(Erf_XoreosFileTypeId::TwoDa),
            2018 => Ok(Erf_XoreosFileTypeId::Tlk),
            2022 => Ok(Erf_XoreosFileTypeId::Txi),
            2023 => Ok(Erf_XoreosFileTypeId::Git),
            2024 => Ok(Erf_XoreosFileTypeId::Bti),
            2025 => Ok(Erf_XoreosFileTypeId::Uti),
            2026 => Ok(Erf_XoreosFileTypeId::Btc),
            2027 => Ok(Erf_XoreosFileTypeId::Utc),
            2029 => Ok(Erf_XoreosFileTypeId::Dlg),
            2030 => Ok(Erf_XoreosFileTypeId::Itp),
            2031 => Ok(Erf_XoreosFileTypeId::Btt),
            2032 => Ok(Erf_XoreosFileTypeId::Utt),
            2033 => Ok(Erf_XoreosFileTypeId::Dds),
            2034 => Ok(Erf_XoreosFileTypeId::Bts),
            2035 => Ok(Erf_XoreosFileTypeId::Uts),
            2036 => Ok(Erf_XoreosFileTypeId::Ltr),
            2037 => Ok(Erf_XoreosFileTypeId::Gff),
            2038 => Ok(Erf_XoreosFileTypeId::Fac),
            2039 => Ok(Erf_XoreosFileTypeId::Bte),
            2040 => Ok(Erf_XoreosFileTypeId::Ute),
            2041 => Ok(Erf_XoreosFileTypeId::Btd),
            2042 => Ok(Erf_XoreosFileTypeId::Utd),
            2043 => Ok(Erf_XoreosFileTypeId::Btp),
            2044 => Ok(Erf_XoreosFileTypeId::Utp),
            2045 => Ok(Erf_XoreosFileTypeId::Dft),
            2046 => Ok(Erf_XoreosFileTypeId::Gic),
            2047 => Ok(Erf_XoreosFileTypeId::Gui),
            2048 => Ok(Erf_XoreosFileTypeId::Css),
            2049 => Ok(Erf_XoreosFileTypeId::Ccs),
            2050 => Ok(Erf_XoreosFileTypeId::Btm),
            2051 => Ok(Erf_XoreosFileTypeId::Utm),
            2052 => Ok(Erf_XoreosFileTypeId::Dwk),
            2053 => Ok(Erf_XoreosFileTypeId::Pwk),
            2054 => Ok(Erf_XoreosFileTypeId::Btg),
            2055 => Ok(Erf_XoreosFileTypeId::Utg),
            2056 => Ok(Erf_XoreosFileTypeId::Jrl),
            2057 => Ok(Erf_XoreosFileTypeId::Sav),
            2058 => Ok(Erf_XoreosFileTypeId::Utw),
            2059 => Ok(Erf_XoreosFileTypeId::FourPc),
            2060 => Ok(Erf_XoreosFileTypeId::Ssf),
            2061 => Ok(Erf_XoreosFileTypeId::Hak),
            2062 => Ok(Erf_XoreosFileTypeId::Nwm),
            2063 => Ok(Erf_XoreosFileTypeId::Bik),
            2064 => Ok(Erf_XoreosFileTypeId::Ndb),
            2065 => Ok(Erf_XoreosFileTypeId::Ptm),
            2066 => Ok(Erf_XoreosFileTypeId::Ptt),
            2067 => Ok(Erf_XoreosFileTypeId::Ncm),
            2068 => Ok(Erf_XoreosFileTypeId::Mfx),
            2069 => Ok(Erf_XoreosFileTypeId::Mat),
            2070 => Ok(Erf_XoreosFileTypeId::Mdb),
            2071 => Ok(Erf_XoreosFileTypeId::Say),
            2072 => Ok(Erf_XoreosFileTypeId::Ttf),
            2073 => Ok(Erf_XoreosFileTypeId::Ttc),
            2074 => Ok(Erf_XoreosFileTypeId::Cut),
            2075 => Ok(Erf_XoreosFileTypeId::Ka),
            2076 => Ok(Erf_XoreosFileTypeId::Jpg),
            2077 => Ok(Erf_XoreosFileTypeId::Ico),
            2078 => Ok(Erf_XoreosFileTypeId::Ogg),
            2079 => Ok(Erf_XoreosFileTypeId::Spt),
            2080 => Ok(Erf_XoreosFileTypeId::Spw),
            2081 => Ok(Erf_XoreosFileTypeId::Wfx),
            2082 => Ok(Erf_XoreosFileTypeId::Ugm),
            2083 => Ok(Erf_XoreosFileTypeId::Qdb),
            2084 => Ok(Erf_XoreosFileTypeId::Qst),
            2085 => Ok(Erf_XoreosFileTypeId::Npc),
            2086 => Ok(Erf_XoreosFileTypeId::Spn),
            2087 => Ok(Erf_XoreosFileTypeId::Utx),
            2088 => Ok(Erf_XoreosFileTypeId::Mmd),
            2089 => Ok(Erf_XoreosFileTypeId::Smm),
            2090 => Ok(Erf_XoreosFileTypeId::Uta),
            2091 => Ok(Erf_XoreosFileTypeId::Mde),
            2092 => Ok(Erf_XoreosFileTypeId::Mdv),
            2093 => Ok(Erf_XoreosFileTypeId::Mda),
            2094 => Ok(Erf_XoreosFileTypeId::Mba),
            2095 => Ok(Erf_XoreosFileTypeId::Oct),
            2096 => Ok(Erf_XoreosFileTypeId::Bfx),
            2097 => Ok(Erf_XoreosFileTypeId::Pdb),
            2098 => Ok(Erf_XoreosFileTypeId::TheWitcherSave),
            2099 => Ok(Erf_XoreosFileTypeId::Pvs),
            2100 => Ok(Erf_XoreosFileTypeId::Cfx),
            2101 => Ok(Erf_XoreosFileTypeId::Luc),
            2103 => Ok(Erf_XoreosFileTypeId::Prb),
            2104 => Ok(Erf_XoreosFileTypeId::Cam),
            2105 => Ok(Erf_XoreosFileTypeId::Vds),
            2106 => Ok(Erf_XoreosFileTypeId::Bin),
            2107 => Ok(Erf_XoreosFileTypeId::Wob),
            2108 => Ok(Erf_XoreosFileTypeId::Api),
            2109 => Ok(Erf_XoreosFileTypeId::Properties),
            2110 => Ok(Erf_XoreosFileTypeId::Png),
            3000 => Ok(Erf_XoreosFileTypeId::Lyt),
            3001 => Ok(Erf_XoreosFileTypeId::Vis),
            3002 => Ok(Erf_XoreosFileTypeId::Rim),
            3003 => Ok(Erf_XoreosFileTypeId::Pth),
            3004 => Ok(Erf_XoreosFileTypeId::Lip),
            3005 => Ok(Erf_XoreosFileTypeId::Bwm),
            3006 => Ok(Erf_XoreosFileTypeId::Txb),
            3007 => Ok(Erf_XoreosFileTypeId::Tpc),
            3008 => Ok(Erf_XoreosFileTypeId::Mdx),
            3009 => Ok(Erf_XoreosFileTypeId::Rsv),
            3010 => Ok(Erf_XoreosFileTypeId::Sig),
            3011 => Ok(Erf_XoreosFileTypeId::Mab),
            3012 => Ok(Erf_XoreosFileTypeId::Qst2),
            3013 => Ok(Erf_XoreosFileTypeId::Sto),
            3015 => Ok(Erf_XoreosFileTypeId::Hex),
            3016 => Ok(Erf_XoreosFileTypeId::Mdx2),
            3017 => Ok(Erf_XoreosFileTypeId::Txb2),
            3022 => Ok(Erf_XoreosFileTypeId::Fsm),
            3023 => Ok(Erf_XoreosFileTypeId::Art),
            3024 => Ok(Erf_XoreosFileTypeId::Amp),
            3025 => Ok(Erf_XoreosFileTypeId::Cwa),
            3028 => Ok(Erf_XoreosFileTypeId::Bip),
            4000 => Ok(Erf_XoreosFileTypeId::Mdb2),
            4001 => Ok(Erf_XoreosFileTypeId::Mda2),
            4002 => Ok(Erf_XoreosFileTypeId::Spt2),
            4003 => Ok(Erf_XoreosFileTypeId::Gr2),
            4004 => Ok(Erf_XoreosFileTypeId::Fxa),
            4005 => Ok(Erf_XoreosFileTypeId::Fxe),
            4007 => Ok(Erf_XoreosFileTypeId::Jpg2),
            4008 => Ok(Erf_XoreosFileTypeId::Pwc),
            9996 => Ok(Erf_XoreosFileTypeId::OneDa),
            9997 => Ok(Erf_XoreosFileTypeId::Erf),
            9998 => Ok(Erf_XoreosFileTypeId::Bif),
            9999 => Ok(Erf_XoreosFileTypeId::Key),
            19000 => Ok(Erf_XoreosFileTypeId::Exe),
            19001 => Ok(Erf_XoreosFileTypeId::Dbf),
            19002 => Ok(Erf_XoreosFileTypeId::Cdx),
            19003 => Ok(Erf_XoreosFileTypeId::Fpt),
            20000 => Ok(Erf_XoreosFileTypeId::Zip),
            20001 => Ok(Erf_XoreosFileTypeId::Fxm),
            20002 => Ok(Erf_XoreosFileTypeId::Fxs),
            20003 => Ok(Erf_XoreosFileTypeId::Xml),
            20004 => Ok(Erf_XoreosFileTypeId::Wlk),
            20005 => Ok(Erf_XoreosFileTypeId::Utr),
            20006 => Ok(Erf_XoreosFileTypeId::Sef),
            20007 => Ok(Erf_XoreosFileTypeId::Pfx),
            20008 => Ok(Erf_XoreosFileTypeId::Tfx),
            20009 => Ok(Erf_XoreosFileTypeId::Ifx),
            20010 => Ok(Erf_XoreosFileTypeId::Lfx),
            20011 => Ok(Erf_XoreosFileTypeId::Bbx),
            20012 => Ok(Erf_XoreosFileTypeId::Pfb),
            20013 => Ok(Erf_XoreosFileTypeId::Upe),
            20014 => Ok(Erf_XoreosFileTypeId::Usc),
            20015 => Ok(Erf_XoreosFileTypeId::Ult),
            20016 => Ok(Erf_XoreosFileTypeId::Fx),
            20017 => Ok(Erf_XoreosFileTypeId::Max),
            20018 => Ok(Erf_XoreosFileTypeId::Doc),
            20019 => Ok(Erf_XoreosFileTypeId::Scc),
            20020 => Ok(Erf_XoreosFileTypeId::Wmp),
            20021 => Ok(Erf_XoreosFileTypeId::Osc),
            20022 => Ok(Erf_XoreosFileTypeId::Trn),
            20023 => Ok(Erf_XoreosFileTypeId::Uen),
            20024 => Ok(Erf_XoreosFileTypeId::Ros),
            20025 => Ok(Erf_XoreosFileTypeId::Rst),
            20026 => Ok(Erf_XoreosFileTypeId::Ptx),
            20027 => Ok(Erf_XoreosFileTypeId::Ltx),
            20028 => Ok(Erf_XoreosFileTypeId::Trx),
            21000 => Ok(Erf_XoreosFileTypeId::Nds),
            21001 => Ok(Erf_XoreosFileTypeId::Herf),
            21002 => Ok(Erf_XoreosFileTypeId::Dict),
            21003 => Ok(Erf_XoreosFileTypeId::Small),
            21004 => Ok(Erf_XoreosFileTypeId::Cbgt),
            21005 => Ok(Erf_XoreosFileTypeId::Cdpth),
            21006 => Ok(Erf_XoreosFileTypeId::Emit),
            21007 => Ok(Erf_XoreosFileTypeId::Itm),
            21008 => Ok(Erf_XoreosFileTypeId::Nanr),
            21009 => Ok(Erf_XoreosFileTypeId::Nbfp),
            21010 => Ok(Erf_XoreosFileTypeId::Nbfs),
            21011 => Ok(Erf_XoreosFileTypeId::Ncer),
            21012 => Ok(Erf_XoreosFileTypeId::Ncgr),
            21013 => Ok(Erf_XoreosFileTypeId::Nclr),
            21014 => Ok(Erf_XoreosFileTypeId::Nftr),
            21015 => Ok(Erf_XoreosFileTypeId::Nsbca),
            21016 => Ok(Erf_XoreosFileTypeId::Nsbmd),
            21017 => Ok(Erf_XoreosFileTypeId::Nsbta),
            21018 => Ok(Erf_XoreosFileTypeId::Nsbtp),
            21019 => Ok(Erf_XoreosFileTypeId::Nsbtx),
            21020 => Ok(Erf_XoreosFileTypeId::Pal),
            21021 => Ok(Erf_XoreosFileTypeId::Raw),
            21022 => Ok(Erf_XoreosFileTypeId::Sadl),
            21023 => Ok(Erf_XoreosFileTypeId::Sdat),
            21024 => Ok(Erf_XoreosFileTypeId::Smp),
            21025 => Ok(Erf_XoreosFileTypeId::Spl),
            21026 => Ok(Erf_XoreosFileTypeId::Vx),
            22000 => Ok(Erf_XoreosFileTypeId::Anb),
            22001 => Ok(Erf_XoreosFileTypeId::Ani),
            22002 => Ok(Erf_XoreosFileTypeId::Cns),
            22003 => Ok(Erf_XoreosFileTypeId::Cur),
            22004 => Ok(Erf_XoreosFileTypeId::Evt),
            22005 => Ok(Erf_XoreosFileTypeId::Fdl),
            22006 => Ok(Erf_XoreosFileTypeId::Fxo),
            22007 => Ok(Erf_XoreosFileTypeId::Gad),
            22008 => Ok(Erf_XoreosFileTypeId::Gda),
            22009 => Ok(Erf_XoreosFileTypeId::Gfx),
            22010 => Ok(Erf_XoreosFileTypeId::Ldf),
            22011 => Ok(Erf_XoreosFileTypeId::Lst),
            22012 => Ok(Erf_XoreosFileTypeId::Mal),
            22013 => Ok(Erf_XoreosFileTypeId::Mao),
            22014 => Ok(Erf_XoreosFileTypeId::Mmh),
            22015 => Ok(Erf_XoreosFileTypeId::Mop),
            22016 => Ok(Erf_XoreosFileTypeId::Mor),
            22017 => Ok(Erf_XoreosFileTypeId::Msh),
            22018 => Ok(Erf_XoreosFileTypeId::Mtx),
            22019 => Ok(Erf_XoreosFileTypeId::Ncc),
            22020 => Ok(Erf_XoreosFileTypeId::Phy),
            22021 => Ok(Erf_XoreosFileTypeId::Plo),
            22022 => Ok(Erf_XoreosFileTypeId::Stg),
            22023 => Ok(Erf_XoreosFileTypeId::Tbi),
            22024 => Ok(Erf_XoreosFileTypeId::Tnt),
            22025 => Ok(Erf_XoreosFileTypeId::Arl),
            22026 => Ok(Erf_XoreosFileTypeId::Fev),
            22027 => Ok(Erf_XoreosFileTypeId::Fsb),
            22028 => Ok(Erf_XoreosFileTypeId::Opf),
            22029 => Ok(Erf_XoreosFileTypeId::Crf),
            22030 => Ok(Erf_XoreosFileTypeId::Rimp),
            22031 => Ok(Erf_XoreosFileTypeId::Met),
            22032 => Ok(Erf_XoreosFileTypeId::Meta),
            22033 => Ok(Erf_XoreosFileTypeId::Fxr),
            22034 => Ok(Erf_XoreosFileTypeId::Cif),
            22035 => Ok(Erf_XoreosFileTypeId::Cub),
            22036 => Ok(Erf_XoreosFileTypeId::Dlb),
            22037 => Ok(Erf_XoreosFileTypeId::Nsc),
            23000 => Ok(Erf_XoreosFileTypeId::Mov),
            23001 => Ok(Erf_XoreosFileTypeId::Curs),
            23002 => Ok(Erf_XoreosFileTypeId::Pict),
            23003 => Ok(Erf_XoreosFileTypeId::Rsrc),
            23004 => Ok(Erf_XoreosFileTypeId::Plist),
            24000 => Ok(Erf_XoreosFileTypeId::Cre),
            24001 => Ok(Erf_XoreosFileTypeId::Pso),
            24002 => Ok(Erf_XoreosFileTypeId::Vso),
            24003 => Ok(Erf_XoreosFileTypeId::Abc),
            24004 => Ok(Erf_XoreosFileTypeId::Sbm),
            24005 => Ok(Erf_XoreosFileTypeId::Pvd),
            24006 => Ok(Erf_XoreosFileTypeId::Pla),
            24007 => Ok(Erf_XoreosFileTypeId::Trg),
            24008 => Ok(Erf_XoreosFileTypeId::Pk),
            25000 => Ok(Erf_XoreosFileTypeId::Als),
            25001 => Ok(Erf_XoreosFileTypeId::Apl),
            25002 => Ok(Erf_XoreosFileTypeId::Assembly),
            25003 => Ok(Erf_XoreosFileTypeId::Bak),
            25004 => Ok(Erf_XoreosFileTypeId::Bnk),
            25005 => Ok(Erf_XoreosFileTypeId::Cl),
            25006 => Ok(Erf_XoreosFileTypeId::Cnv),
            25007 => Ok(Erf_XoreosFileTypeId::Con),
            25008 => Ok(Erf_XoreosFileTypeId::Dat),
            25009 => Ok(Erf_XoreosFileTypeId::Dx11),
            25010 => Ok(Erf_XoreosFileTypeId::Ids),
            25011 => Ok(Erf_XoreosFileTypeId::Log),
            25012 => Ok(Erf_XoreosFileTypeId::Map),
            25013 => Ok(Erf_XoreosFileTypeId::Mml),
            25014 => Ok(Erf_XoreosFileTypeId::Mp3),
            25015 => Ok(Erf_XoreosFileTypeId::Pck),
            25016 => Ok(Erf_XoreosFileTypeId::Rml),
            25017 => Ok(Erf_XoreosFileTypeId::S),
            25018 => Ok(Erf_XoreosFileTypeId::Sta),
            25019 => Ok(Erf_XoreosFileTypeId::Svr),
            25020 => Ok(Erf_XoreosFileTypeId::Vlm),
            25021 => Ok(Erf_XoreosFileTypeId::Wbd),
            25022 => Ok(Erf_XoreosFileTypeId::Xbx),
            25023 => Ok(Erf_XoreosFileTypeId::Xls),
            26000 => Ok(Erf_XoreosFileTypeId::Bzf),
            27000 => Ok(Erf_XoreosFileTypeId::Adv),
            28000 => Ok(Erf_XoreosFileTypeId::Json),
            28001 => Ok(Erf_XoreosFileTypeId::TlkExpert),
            28002 => Ok(Erf_XoreosFileTypeId::TlkMobile),
            28003 => Ok(Erf_XoreosFileTypeId::TlkTouch),
            28004 => Ok(Erf_XoreosFileTypeId::Otf),
            28005 => Ok(Erf_XoreosFileTypeId::Par),
            29000 => Ok(Erf_XoreosFileTypeId::Xwb),
            29001 => Ok(Erf_XoreosFileTypeId::Xsb),
            30000 => Ok(Erf_XoreosFileTypeId::Xds),
            30001 => Ok(Erf_XoreosFileTypeId::Wnd),
            40000 => Ok(Erf_XoreosFileTypeId::Xeositex),
            _ => Ok(Erf_XoreosFileTypeId::Unknown(flag)),
        }
    }
}

impl From<&Erf_XoreosFileTypeId> for i64 {
    fn from(v: &Erf_XoreosFileTypeId) -> Self {
        match *v {
            Erf_XoreosFileTypeId::None => -1,
            Erf_XoreosFileTypeId::Res => 0,
            Erf_XoreosFileTypeId::Bmp => 1,
            Erf_XoreosFileTypeId::Mve => 2,
            Erf_XoreosFileTypeId::Tga => 3,
            Erf_XoreosFileTypeId::Wav => 4,
            Erf_XoreosFileTypeId::Plt => 6,
            Erf_XoreosFileTypeId::Ini => 7,
            Erf_XoreosFileTypeId::Bmu => 8,
            Erf_XoreosFileTypeId::Mpg => 9,
            Erf_XoreosFileTypeId::Txt => 10,
            Erf_XoreosFileTypeId::Wma => 11,
            Erf_XoreosFileTypeId::Wmv => 12,
            Erf_XoreosFileTypeId::Xmv => 13,
            Erf_XoreosFileTypeId::Plh => 2000,
            Erf_XoreosFileTypeId::Tex => 2001,
            Erf_XoreosFileTypeId::Mdl => 2002,
            Erf_XoreosFileTypeId::Thg => 2003,
            Erf_XoreosFileTypeId::Fnt => 2005,
            Erf_XoreosFileTypeId::Lua => 2007,
            Erf_XoreosFileTypeId::Slt => 2008,
            Erf_XoreosFileTypeId::Nss => 2009,
            Erf_XoreosFileTypeId::Ncs => 2010,
            Erf_XoreosFileTypeId::Mod => 2011,
            Erf_XoreosFileTypeId::Are => 2012,
            Erf_XoreosFileTypeId::Set => 2013,
            Erf_XoreosFileTypeId::Ifo => 2014,
            Erf_XoreosFileTypeId::Bic => 2015,
            Erf_XoreosFileTypeId::Wok => 2016,
            Erf_XoreosFileTypeId::TwoDa => 2017,
            Erf_XoreosFileTypeId::Tlk => 2018,
            Erf_XoreosFileTypeId::Txi => 2022,
            Erf_XoreosFileTypeId::Git => 2023,
            Erf_XoreosFileTypeId::Bti => 2024,
            Erf_XoreosFileTypeId::Uti => 2025,
            Erf_XoreosFileTypeId::Btc => 2026,
            Erf_XoreosFileTypeId::Utc => 2027,
            Erf_XoreosFileTypeId::Dlg => 2029,
            Erf_XoreosFileTypeId::Itp => 2030,
            Erf_XoreosFileTypeId::Btt => 2031,
            Erf_XoreosFileTypeId::Utt => 2032,
            Erf_XoreosFileTypeId::Dds => 2033,
            Erf_XoreosFileTypeId::Bts => 2034,
            Erf_XoreosFileTypeId::Uts => 2035,
            Erf_XoreosFileTypeId::Ltr => 2036,
            Erf_XoreosFileTypeId::Gff => 2037,
            Erf_XoreosFileTypeId::Fac => 2038,
            Erf_XoreosFileTypeId::Bte => 2039,
            Erf_XoreosFileTypeId::Ute => 2040,
            Erf_XoreosFileTypeId::Btd => 2041,
            Erf_XoreosFileTypeId::Utd => 2042,
            Erf_XoreosFileTypeId::Btp => 2043,
            Erf_XoreosFileTypeId::Utp => 2044,
            Erf_XoreosFileTypeId::Dft => 2045,
            Erf_XoreosFileTypeId::Gic => 2046,
            Erf_XoreosFileTypeId::Gui => 2047,
            Erf_XoreosFileTypeId::Css => 2048,
            Erf_XoreosFileTypeId::Ccs => 2049,
            Erf_XoreosFileTypeId::Btm => 2050,
            Erf_XoreosFileTypeId::Utm => 2051,
            Erf_XoreosFileTypeId::Dwk => 2052,
            Erf_XoreosFileTypeId::Pwk => 2053,
            Erf_XoreosFileTypeId::Btg => 2054,
            Erf_XoreosFileTypeId::Utg => 2055,
            Erf_XoreosFileTypeId::Jrl => 2056,
            Erf_XoreosFileTypeId::Sav => 2057,
            Erf_XoreosFileTypeId::Utw => 2058,
            Erf_XoreosFileTypeId::FourPc => 2059,
            Erf_XoreosFileTypeId::Ssf => 2060,
            Erf_XoreosFileTypeId::Hak => 2061,
            Erf_XoreosFileTypeId::Nwm => 2062,
            Erf_XoreosFileTypeId::Bik => 2063,
            Erf_XoreosFileTypeId::Ndb => 2064,
            Erf_XoreosFileTypeId::Ptm => 2065,
            Erf_XoreosFileTypeId::Ptt => 2066,
            Erf_XoreosFileTypeId::Ncm => 2067,
            Erf_XoreosFileTypeId::Mfx => 2068,
            Erf_XoreosFileTypeId::Mat => 2069,
            Erf_XoreosFileTypeId::Mdb => 2070,
            Erf_XoreosFileTypeId::Say => 2071,
            Erf_XoreosFileTypeId::Ttf => 2072,
            Erf_XoreosFileTypeId::Ttc => 2073,
            Erf_XoreosFileTypeId::Cut => 2074,
            Erf_XoreosFileTypeId::Ka => 2075,
            Erf_XoreosFileTypeId::Jpg => 2076,
            Erf_XoreosFileTypeId::Ico => 2077,
            Erf_XoreosFileTypeId::Ogg => 2078,
            Erf_XoreosFileTypeId::Spt => 2079,
            Erf_XoreosFileTypeId::Spw => 2080,
            Erf_XoreosFileTypeId::Wfx => 2081,
            Erf_XoreosFileTypeId::Ugm => 2082,
            Erf_XoreosFileTypeId::Qdb => 2083,
            Erf_XoreosFileTypeId::Qst => 2084,
            Erf_XoreosFileTypeId::Npc => 2085,
            Erf_XoreosFileTypeId::Spn => 2086,
            Erf_XoreosFileTypeId::Utx => 2087,
            Erf_XoreosFileTypeId::Mmd => 2088,
            Erf_XoreosFileTypeId::Smm => 2089,
            Erf_XoreosFileTypeId::Uta => 2090,
            Erf_XoreosFileTypeId::Mde => 2091,
            Erf_XoreosFileTypeId::Mdv => 2092,
            Erf_XoreosFileTypeId::Mda => 2093,
            Erf_XoreosFileTypeId::Mba => 2094,
            Erf_XoreosFileTypeId::Oct => 2095,
            Erf_XoreosFileTypeId::Bfx => 2096,
            Erf_XoreosFileTypeId::Pdb => 2097,
            Erf_XoreosFileTypeId::TheWitcherSave => 2098,
            Erf_XoreosFileTypeId::Pvs => 2099,
            Erf_XoreosFileTypeId::Cfx => 2100,
            Erf_XoreosFileTypeId::Luc => 2101,
            Erf_XoreosFileTypeId::Prb => 2103,
            Erf_XoreosFileTypeId::Cam => 2104,
            Erf_XoreosFileTypeId::Vds => 2105,
            Erf_XoreosFileTypeId::Bin => 2106,
            Erf_XoreosFileTypeId::Wob => 2107,
            Erf_XoreosFileTypeId::Api => 2108,
            Erf_XoreosFileTypeId::Properties => 2109,
            Erf_XoreosFileTypeId::Png => 2110,
            Erf_XoreosFileTypeId::Lyt => 3000,
            Erf_XoreosFileTypeId::Vis => 3001,
            Erf_XoreosFileTypeId::Rim => 3002,
            Erf_XoreosFileTypeId::Pth => 3003,
            Erf_XoreosFileTypeId::Lip => 3004,
            Erf_XoreosFileTypeId::Bwm => 3005,
            Erf_XoreosFileTypeId::Txb => 3006,
            Erf_XoreosFileTypeId::Tpc => 3007,
            Erf_XoreosFileTypeId::Mdx => 3008,
            Erf_XoreosFileTypeId::Rsv => 3009,
            Erf_XoreosFileTypeId::Sig => 3010,
            Erf_XoreosFileTypeId::Mab => 3011,
            Erf_XoreosFileTypeId::Qst2 => 3012,
            Erf_XoreosFileTypeId::Sto => 3013,
            Erf_XoreosFileTypeId::Hex => 3015,
            Erf_XoreosFileTypeId::Mdx2 => 3016,
            Erf_XoreosFileTypeId::Txb2 => 3017,
            Erf_XoreosFileTypeId::Fsm => 3022,
            Erf_XoreosFileTypeId::Art => 3023,
            Erf_XoreosFileTypeId::Amp => 3024,
            Erf_XoreosFileTypeId::Cwa => 3025,
            Erf_XoreosFileTypeId::Bip => 3028,
            Erf_XoreosFileTypeId::Mdb2 => 4000,
            Erf_XoreosFileTypeId::Mda2 => 4001,
            Erf_XoreosFileTypeId::Spt2 => 4002,
            Erf_XoreosFileTypeId::Gr2 => 4003,
            Erf_XoreosFileTypeId::Fxa => 4004,
            Erf_XoreosFileTypeId::Fxe => 4005,
            Erf_XoreosFileTypeId::Jpg2 => 4007,
            Erf_XoreosFileTypeId::Pwc => 4008,
            Erf_XoreosFileTypeId::OneDa => 9996,
            Erf_XoreosFileTypeId::Erf => 9997,
            Erf_XoreosFileTypeId::Bif => 9998,
            Erf_XoreosFileTypeId::Key => 9999,
            Erf_XoreosFileTypeId::Exe => 19000,
            Erf_XoreosFileTypeId::Dbf => 19001,
            Erf_XoreosFileTypeId::Cdx => 19002,
            Erf_XoreosFileTypeId::Fpt => 19003,
            Erf_XoreosFileTypeId::Zip => 20000,
            Erf_XoreosFileTypeId::Fxm => 20001,
            Erf_XoreosFileTypeId::Fxs => 20002,
            Erf_XoreosFileTypeId::Xml => 20003,
            Erf_XoreosFileTypeId::Wlk => 20004,
            Erf_XoreosFileTypeId::Utr => 20005,
            Erf_XoreosFileTypeId::Sef => 20006,
            Erf_XoreosFileTypeId::Pfx => 20007,
            Erf_XoreosFileTypeId::Tfx => 20008,
            Erf_XoreosFileTypeId::Ifx => 20009,
            Erf_XoreosFileTypeId::Lfx => 20010,
            Erf_XoreosFileTypeId::Bbx => 20011,
            Erf_XoreosFileTypeId::Pfb => 20012,
            Erf_XoreosFileTypeId::Upe => 20013,
            Erf_XoreosFileTypeId::Usc => 20014,
            Erf_XoreosFileTypeId::Ult => 20015,
            Erf_XoreosFileTypeId::Fx => 20016,
            Erf_XoreosFileTypeId::Max => 20017,
            Erf_XoreosFileTypeId::Doc => 20018,
            Erf_XoreosFileTypeId::Scc => 20019,
            Erf_XoreosFileTypeId::Wmp => 20020,
            Erf_XoreosFileTypeId::Osc => 20021,
            Erf_XoreosFileTypeId::Trn => 20022,
            Erf_XoreosFileTypeId::Uen => 20023,
            Erf_XoreosFileTypeId::Ros => 20024,
            Erf_XoreosFileTypeId::Rst => 20025,
            Erf_XoreosFileTypeId::Ptx => 20026,
            Erf_XoreosFileTypeId::Ltx => 20027,
            Erf_XoreosFileTypeId::Trx => 20028,
            Erf_XoreosFileTypeId::Nds => 21000,
            Erf_XoreosFileTypeId::Herf => 21001,
            Erf_XoreosFileTypeId::Dict => 21002,
            Erf_XoreosFileTypeId::Small => 21003,
            Erf_XoreosFileTypeId::Cbgt => 21004,
            Erf_XoreosFileTypeId::Cdpth => 21005,
            Erf_XoreosFileTypeId::Emit => 21006,
            Erf_XoreosFileTypeId::Itm => 21007,
            Erf_XoreosFileTypeId::Nanr => 21008,
            Erf_XoreosFileTypeId::Nbfp => 21009,
            Erf_XoreosFileTypeId::Nbfs => 21010,
            Erf_XoreosFileTypeId::Ncer => 21011,
            Erf_XoreosFileTypeId::Ncgr => 21012,
            Erf_XoreosFileTypeId::Nclr => 21013,
            Erf_XoreosFileTypeId::Nftr => 21014,
            Erf_XoreosFileTypeId::Nsbca => 21015,
            Erf_XoreosFileTypeId::Nsbmd => 21016,
            Erf_XoreosFileTypeId::Nsbta => 21017,
            Erf_XoreosFileTypeId::Nsbtp => 21018,
            Erf_XoreosFileTypeId::Nsbtx => 21019,
            Erf_XoreosFileTypeId::Pal => 21020,
            Erf_XoreosFileTypeId::Raw => 21021,
            Erf_XoreosFileTypeId::Sadl => 21022,
            Erf_XoreosFileTypeId::Sdat => 21023,
            Erf_XoreosFileTypeId::Smp => 21024,
            Erf_XoreosFileTypeId::Spl => 21025,
            Erf_XoreosFileTypeId::Vx => 21026,
            Erf_XoreosFileTypeId::Anb => 22000,
            Erf_XoreosFileTypeId::Ani => 22001,
            Erf_XoreosFileTypeId::Cns => 22002,
            Erf_XoreosFileTypeId::Cur => 22003,
            Erf_XoreosFileTypeId::Evt => 22004,
            Erf_XoreosFileTypeId::Fdl => 22005,
            Erf_XoreosFileTypeId::Fxo => 22006,
            Erf_XoreosFileTypeId::Gad => 22007,
            Erf_XoreosFileTypeId::Gda => 22008,
            Erf_XoreosFileTypeId::Gfx => 22009,
            Erf_XoreosFileTypeId::Ldf => 22010,
            Erf_XoreosFileTypeId::Lst => 22011,
            Erf_XoreosFileTypeId::Mal => 22012,
            Erf_XoreosFileTypeId::Mao => 22013,
            Erf_XoreosFileTypeId::Mmh => 22014,
            Erf_XoreosFileTypeId::Mop => 22015,
            Erf_XoreosFileTypeId::Mor => 22016,
            Erf_XoreosFileTypeId::Msh => 22017,
            Erf_XoreosFileTypeId::Mtx => 22018,
            Erf_XoreosFileTypeId::Ncc => 22019,
            Erf_XoreosFileTypeId::Phy => 22020,
            Erf_XoreosFileTypeId::Plo => 22021,
            Erf_XoreosFileTypeId::Stg => 22022,
            Erf_XoreosFileTypeId::Tbi => 22023,
            Erf_XoreosFileTypeId::Tnt => 22024,
            Erf_XoreosFileTypeId::Arl => 22025,
            Erf_XoreosFileTypeId::Fev => 22026,
            Erf_XoreosFileTypeId::Fsb => 22027,
            Erf_XoreosFileTypeId::Opf => 22028,
            Erf_XoreosFileTypeId::Crf => 22029,
            Erf_XoreosFileTypeId::Rimp => 22030,
            Erf_XoreosFileTypeId::Met => 22031,
            Erf_XoreosFileTypeId::Meta => 22032,
            Erf_XoreosFileTypeId::Fxr => 22033,
            Erf_XoreosFileTypeId::Cif => 22034,
            Erf_XoreosFileTypeId::Cub => 22035,
            Erf_XoreosFileTypeId::Dlb => 22036,
            Erf_XoreosFileTypeId::Nsc => 22037,
            Erf_XoreosFileTypeId::Mov => 23000,
            Erf_XoreosFileTypeId::Curs => 23001,
            Erf_XoreosFileTypeId::Pict => 23002,
            Erf_XoreosFileTypeId::Rsrc => 23003,
            Erf_XoreosFileTypeId::Plist => 23004,
            Erf_XoreosFileTypeId::Cre => 24000,
            Erf_XoreosFileTypeId::Pso => 24001,
            Erf_XoreosFileTypeId::Vso => 24002,
            Erf_XoreosFileTypeId::Abc => 24003,
            Erf_XoreosFileTypeId::Sbm => 24004,
            Erf_XoreosFileTypeId::Pvd => 24005,
            Erf_XoreosFileTypeId::Pla => 24006,
            Erf_XoreosFileTypeId::Trg => 24007,
            Erf_XoreosFileTypeId::Pk => 24008,
            Erf_XoreosFileTypeId::Als => 25000,
            Erf_XoreosFileTypeId::Apl => 25001,
            Erf_XoreosFileTypeId::Assembly => 25002,
            Erf_XoreosFileTypeId::Bak => 25003,
            Erf_XoreosFileTypeId::Bnk => 25004,
            Erf_XoreosFileTypeId::Cl => 25005,
            Erf_XoreosFileTypeId::Cnv => 25006,
            Erf_XoreosFileTypeId::Con => 25007,
            Erf_XoreosFileTypeId::Dat => 25008,
            Erf_XoreosFileTypeId::Dx11 => 25009,
            Erf_XoreosFileTypeId::Ids => 25010,
            Erf_XoreosFileTypeId::Log => 25011,
            Erf_XoreosFileTypeId::Map => 25012,
            Erf_XoreosFileTypeId::Mml => 25013,
            Erf_XoreosFileTypeId::Mp3 => 25014,
            Erf_XoreosFileTypeId::Pck => 25015,
            Erf_XoreosFileTypeId::Rml => 25016,
            Erf_XoreosFileTypeId::S => 25017,
            Erf_XoreosFileTypeId::Sta => 25018,
            Erf_XoreosFileTypeId::Svr => 25019,
            Erf_XoreosFileTypeId::Vlm => 25020,
            Erf_XoreosFileTypeId::Wbd => 25021,
            Erf_XoreosFileTypeId::Xbx => 25022,
            Erf_XoreosFileTypeId::Xls => 25023,
            Erf_XoreosFileTypeId::Bzf => 26000,
            Erf_XoreosFileTypeId::Adv => 27000,
            Erf_XoreosFileTypeId::Json => 28000,
            Erf_XoreosFileTypeId::TlkExpert => 28001,
            Erf_XoreosFileTypeId::TlkMobile => 28002,
            Erf_XoreosFileTypeId::TlkTouch => 28003,
            Erf_XoreosFileTypeId::Otf => 28004,
            Erf_XoreosFileTypeId::Par => 28005,
            Erf_XoreosFileTypeId::Xwb => 29000,
            Erf_XoreosFileTypeId::Xsb => 29001,
            Erf_XoreosFileTypeId::Xds => 30000,
            Erf_XoreosFileTypeId::Wnd => 30001,
            Erf_XoreosFileTypeId::Xeositex => 40000,
            Erf_XoreosFileTypeId::Unknown(v) => v
        }
    }
}

impl Default for Erf_XoreosFileTypeId {
    fn default() -> Self { Erf_XoreosFileTypeId::Unknown(0) }
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
    resource_type: RefCell<Erf_XoreosFileTypeId>,
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
 * Resource type identifier (see ResourceType enum).
 * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
 */
impl Erf_KeyEntry {
    pub fn resource_type(&self) -> Ref<'_, Erf_XoreosFileTypeId> {
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
