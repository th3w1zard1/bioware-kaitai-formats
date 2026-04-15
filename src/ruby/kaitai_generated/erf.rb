# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
# texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
# ERF files store both resource names (ResRefs) and data in the same file. They also support
# localized strings for descriptions in multiple languages.
# 
# Format Variants:
# - ERF: Generic encapsulated resource file (texture packs, etc.)
# - HAK: Hak pak file (contains override resources). Used for mod content distribution
# - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
# - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`
# 
# All variants use the same binary format structure, differing only in the file type signature.
# 
# Binary Format Structure:
# - Header (160 bytes): File type, version, entry counts, offsets, build date, description
# - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
#   include localized module names for the load screen. Each entry contains language_id (u4),
#   string_size (u4), and string_data (UTF-8 encoded text)
# - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
#   - resref (16 bytes, ASCII, null-padded): Resource filename
#   - resource_id (u4): Index into resource_list
#   - resource_type (u2): Resource type identifier (see ResourceType enum)
#   - unused (u2): Padding/unused field (typically 0)
# - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
#   - offset_to_data (u4): Byte offset to resource data from beginning of file
#   - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
# - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
#   in resource_list
# 
# File Access Pattern:
# 1. Read header to get entry_count and offsets
# 2. Read key_list to map ResRefs to resource_ids
# 3. Use resource_id to index into resource_list
# 4. Read resource data from offset_to_data with byte length len_data
# 
# References:
# - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf - Complete ERF format documentation
# - https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf - Official BioWare Aurora ERF specification
# - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/erfreader.cpp:24-106 - Complete C++ ERF reader implementation
# - https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp:44-229 - Generic Aurora ERF implementation (shared format)
# - https://github.com/NickHugi/Kotor.NET/blob/master/Formats/KotorERF/ERFBinaryStructure.cs:11-170 - .NET ERF reader/writer
# - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py - PyKotor binary reader/writer
# - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py - ERF data model
class Erf < Kaitai::Struct::Struct

  XOREOS_FILE_TYPE_ID = {
    -1 => :xoreos_file_type_id_none,
    0 => :xoreos_file_type_id_res,
    1 => :xoreos_file_type_id_bmp,
    2 => :xoreos_file_type_id_mve,
    3 => :xoreos_file_type_id_tga,
    4 => :xoreos_file_type_id_wav,
    6 => :xoreos_file_type_id_plt,
    7 => :xoreos_file_type_id_ini,
    8 => :xoreos_file_type_id_bmu,
    9 => :xoreos_file_type_id_mpg,
    10 => :xoreos_file_type_id_txt,
    11 => :xoreos_file_type_id_wma,
    12 => :xoreos_file_type_id_wmv,
    13 => :xoreos_file_type_id_xmv,
    2000 => :xoreos_file_type_id_plh,
    2001 => :xoreos_file_type_id_tex,
    2002 => :xoreos_file_type_id_mdl,
    2003 => :xoreos_file_type_id_thg,
    2005 => :xoreos_file_type_id_fnt,
    2007 => :xoreos_file_type_id_lua,
    2008 => :xoreos_file_type_id_slt,
    2009 => :xoreos_file_type_id_nss,
    2010 => :xoreos_file_type_id_ncs,
    2011 => :xoreos_file_type_id_mod,
    2012 => :xoreos_file_type_id_are,
    2013 => :xoreos_file_type_id_set,
    2014 => :xoreos_file_type_id_ifo,
    2015 => :xoreos_file_type_id_bic,
    2016 => :xoreos_file_type_id_wok,
    2017 => :xoreos_file_type_id_two_da,
    2018 => :xoreos_file_type_id_tlk,
    2022 => :xoreos_file_type_id_txi,
    2023 => :xoreos_file_type_id_git,
    2024 => :xoreos_file_type_id_bti,
    2025 => :xoreos_file_type_id_uti,
    2026 => :xoreos_file_type_id_btc,
    2027 => :xoreos_file_type_id_utc,
    2029 => :xoreos_file_type_id_dlg,
    2030 => :xoreos_file_type_id_itp,
    2031 => :xoreos_file_type_id_btt,
    2032 => :xoreos_file_type_id_utt,
    2033 => :xoreos_file_type_id_dds,
    2034 => :xoreos_file_type_id_bts,
    2035 => :xoreos_file_type_id_uts,
    2036 => :xoreos_file_type_id_ltr,
    2037 => :xoreos_file_type_id_gff,
    2038 => :xoreos_file_type_id_fac,
    2039 => :xoreos_file_type_id_bte,
    2040 => :xoreos_file_type_id_ute,
    2041 => :xoreos_file_type_id_btd,
    2042 => :xoreos_file_type_id_utd,
    2043 => :xoreos_file_type_id_btp,
    2044 => :xoreos_file_type_id_utp,
    2045 => :xoreos_file_type_id_dft,
    2046 => :xoreos_file_type_id_gic,
    2047 => :xoreos_file_type_id_gui,
    2048 => :xoreos_file_type_id_css,
    2049 => :xoreos_file_type_id_ccs,
    2050 => :xoreos_file_type_id_btm,
    2051 => :xoreos_file_type_id_utm,
    2052 => :xoreos_file_type_id_dwk,
    2053 => :xoreos_file_type_id_pwk,
    2054 => :xoreos_file_type_id_btg,
    2055 => :xoreos_file_type_id_utg,
    2056 => :xoreos_file_type_id_jrl,
    2057 => :xoreos_file_type_id_sav,
    2058 => :xoreos_file_type_id_utw,
    2059 => :xoreos_file_type_id_four_pc,
    2060 => :xoreos_file_type_id_ssf,
    2061 => :xoreos_file_type_id_hak,
    2062 => :xoreos_file_type_id_nwm,
    2063 => :xoreos_file_type_id_bik,
    2064 => :xoreos_file_type_id_ndb,
    2065 => :xoreos_file_type_id_ptm,
    2066 => :xoreos_file_type_id_ptt,
    2067 => :xoreos_file_type_id_ncm,
    2068 => :xoreos_file_type_id_mfx,
    2069 => :xoreos_file_type_id_mat,
    2070 => :xoreos_file_type_id_mdb,
    2071 => :xoreos_file_type_id_say,
    2072 => :xoreos_file_type_id_ttf,
    2073 => :xoreos_file_type_id_ttc,
    2074 => :xoreos_file_type_id_cut,
    2075 => :xoreos_file_type_id_ka,
    2076 => :xoreos_file_type_id_jpg,
    2077 => :xoreos_file_type_id_ico,
    2078 => :xoreos_file_type_id_ogg,
    2079 => :xoreos_file_type_id_spt,
    2080 => :xoreos_file_type_id_spw,
    2081 => :xoreos_file_type_id_wfx,
    2082 => :xoreos_file_type_id_ugm,
    2083 => :xoreos_file_type_id_qdb,
    2084 => :xoreos_file_type_id_qst,
    2085 => :xoreos_file_type_id_npc,
    2086 => :xoreos_file_type_id_spn,
    2087 => :xoreos_file_type_id_utx,
    2088 => :xoreos_file_type_id_mmd,
    2089 => :xoreos_file_type_id_smm,
    2090 => :xoreos_file_type_id_uta,
    2091 => :xoreos_file_type_id_mde,
    2092 => :xoreos_file_type_id_mdv,
    2093 => :xoreos_file_type_id_mda,
    2094 => :xoreos_file_type_id_mba,
    2095 => :xoreos_file_type_id_oct,
    2096 => :xoreos_file_type_id_bfx,
    2097 => :xoreos_file_type_id_pdb,
    2098 => :xoreos_file_type_id_the_witcher_save,
    2099 => :xoreos_file_type_id_pvs,
    2100 => :xoreos_file_type_id_cfx,
    2101 => :xoreos_file_type_id_luc,
    2103 => :xoreos_file_type_id_prb,
    2104 => :xoreos_file_type_id_cam,
    2105 => :xoreos_file_type_id_vds,
    2106 => :xoreos_file_type_id_bin,
    2107 => :xoreos_file_type_id_wob,
    2108 => :xoreos_file_type_id_api,
    2109 => :xoreos_file_type_id_properties,
    2110 => :xoreos_file_type_id_png,
    3000 => :xoreos_file_type_id_lyt,
    3001 => :xoreos_file_type_id_vis,
    3002 => :xoreos_file_type_id_rim,
    3003 => :xoreos_file_type_id_pth,
    3004 => :xoreos_file_type_id_lip,
    3005 => :xoreos_file_type_id_bwm,
    3006 => :xoreos_file_type_id_txb,
    3007 => :xoreos_file_type_id_tpc,
    3008 => :xoreos_file_type_id_mdx,
    3009 => :xoreos_file_type_id_rsv,
    3010 => :xoreos_file_type_id_sig,
    3011 => :xoreos_file_type_id_mab,
    3012 => :xoreos_file_type_id_qst2,
    3013 => :xoreos_file_type_id_sto,
    3015 => :xoreos_file_type_id_hex,
    3016 => :xoreos_file_type_id_mdx2,
    3017 => :xoreos_file_type_id_txb2,
    3022 => :xoreos_file_type_id_fsm,
    3023 => :xoreos_file_type_id_art,
    3024 => :xoreos_file_type_id_amp,
    3025 => :xoreos_file_type_id_cwa,
    3028 => :xoreos_file_type_id_bip,
    4000 => :xoreos_file_type_id_mdb2,
    4001 => :xoreos_file_type_id_mda2,
    4002 => :xoreos_file_type_id_spt2,
    4003 => :xoreos_file_type_id_gr2,
    4004 => :xoreos_file_type_id_fxa,
    4005 => :xoreos_file_type_id_fxe,
    4007 => :xoreos_file_type_id_jpg2,
    4008 => :xoreos_file_type_id_pwc,
    9996 => :xoreos_file_type_id_one_da,
    9997 => :xoreos_file_type_id_erf,
    9998 => :xoreos_file_type_id_bif,
    9999 => :xoreos_file_type_id_key,
    19000 => :xoreos_file_type_id_exe,
    19001 => :xoreos_file_type_id_dbf,
    19002 => :xoreos_file_type_id_cdx,
    19003 => :xoreos_file_type_id_fpt,
    20000 => :xoreos_file_type_id_zip,
    20001 => :xoreos_file_type_id_fxm,
    20002 => :xoreos_file_type_id_fxs,
    20003 => :xoreos_file_type_id_xml,
    20004 => :xoreos_file_type_id_wlk,
    20005 => :xoreos_file_type_id_utr,
    20006 => :xoreos_file_type_id_sef,
    20007 => :xoreos_file_type_id_pfx,
    20008 => :xoreos_file_type_id_tfx,
    20009 => :xoreos_file_type_id_ifx,
    20010 => :xoreos_file_type_id_lfx,
    20011 => :xoreos_file_type_id_bbx,
    20012 => :xoreos_file_type_id_pfb,
    20013 => :xoreos_file_type_id_upe,
    20014 => :xoreos_file_type_id_usc,
    20015 => :xoreos_file_type_id_ult,
    20016 => :xoreos_file_type_id_fx,
    20017 => :xoreos_file_type_id_max,
    20018 => :xoreos_file_type_id_doc,
    20019 => :xoreos_file_type_id_scc,
    20020 => :xoreos_file_type_id_wmp,
    20021 => :xoreos_file_type_id_osc,
    20022 => :xoreos_file_type_id_trn,
    20023 => :xoreos_file_type_id_uen,
    20024 => :xoreos_file_type_id_ros,
    20025 => :xoreos_file_type_id_rst,
    20026 => :xoreos_file_type_id_ptx,
    20027 => :xoreos_file_type_id_ltx,
    20028 => :xoreos_file_type_id_trx,
    21000 => :xoreos_file_type_id_nds,
    21001 => :xoreos_file_type_id_herf,
    21002 => :xoreos_file_type_id_dict,
    21003 => :xoreos_file_type_id_small,
    21004 => :xoreos_file_type_id_cbgt,
    21005 => :xoreos_file_type_id_cdpth,
    21006 => :xoreos_file_type_id_emit,
    21007 => :xoreos_file_type_id_itm,
    21008 => :xoreos_file_type_id_nanr,
    21009 => :xoreos_file_type_id_nbfp,
    21010 => :xoreos_file_type_id_nbfs,
    21011 => :xoreos_file_type_id_ncer,
    21012 => :xoreos_file_type_id_ncgr,
    21013 => :xoreos_file_type_id_nclr,
    21014 => :xoreos_file_type_id_nftr,
    21015 => :xoreos_file_type_id_nsbca,
    21016 => :xoreos_file_type_id_nsbmd,
    21017 => :xoreos_file_type_id_nsbta,
    21018 => :xoreos_file_type_id_nsbtp,
    21019 => :xoreos_file_type_id_nsbtx,
    21020 => :xoreos_file_type_id_pal,
    21021 => :xoreos_file_type_id_raw,
    21022 => :xoreos_file_type_id_sadl,
    21023 => :xoreos_file_type_id_sdat,
    21024 => :xoreos_file_type_id_smp,
    21025 => :xoreos_file_type_id_spl,
    21026 => :xoreos_file_type_id_vx,
    22000 => :xoreos_file_type_id_anb,
    22001 => :xoreos_file_type_id_ani,
    22002 => :xoreos_file_type_id_cns,
    22003 => :xoreos_file_type_id_cur,
    22004 => :xoreos_file_type_id_evt,
    22005 => :xoreos_file_type_id_fdl,
    22006 => :xoreos_file_type_id_fxo,
    22007 => :xoreos_file_type_id_gad,
    22008 => :xoreos_file_type_id_gda,
    22009 => :xoreos_file_type_id_gfx,
    22010 => :xoreos_file_type_id_ldf,
    22011 => :xoreos_file_type_id_lst,
    22012 => :xoreos_file_type_id_mal,
    22013 => :xoreos_file_type_id_mao,
    22014 => :xoreos_file_type_id_mmh,
    22015 => :xoreos_file_type_id_mop,
    22016 => :xoreos_file_type_id_mor,
    22017 => :xoreos_file_type_id_msh,
    22018 => :xoreos_file_type_id_mtx,
    22019 => :xoreos_file_type_id_ncc,
    22020 => :xoreos_file_type_id_phy,
    22021 => :xoreos_file_type_id_plo,
    22022 => :xoreos_file_type_id_stg,
    22023 => :xoreos_file_type_id_tbi,
    22024 => :xoreos_file_type_id_tnt,
    22025 => :xoreos_file_type_id_arl,
    22026 => :xoreos_file_type_id_fev,
    22027 => :xoreos_file_type_id_fsb,
    22028 => :xoreos_file_type_id_opf,
    22029 => :xoreos_file_type_id_crf,
    22030 => :xoreos_file_type_id_rimp,
    22031 => :xoreos_file_type_id_met,
    22032 => :xoreos_file_type_id_meta,
    22033 => :xoreos_file_type_id_fxr,
    22034 => :xoreos_file_type_id_cif,
    22035 => :xoreos_file_type_id_cub,
    22036 => :xoreos_file_type_id_dlb,
    22037 => :xoreos_file_type_id_nsc,
    23000 => :xoreos_file_type_id_mov,
    23001 => :xoreos_file_type_id_curs,
    23002 => :xoreos_file_type_id_pict,
    23003 => :xoreos_file_type_id_rsrc,
    23004 => :xoreos_file_type_id_plist,
    24000 => :xoreos_file_type_id_cre,
    24001 => :xoreos_file_type_id_pso,
    24002 => :xoreos_file_type_id_vso,
    24003 => :xoreos_file_type_id_abc,
    24004 => :xoreos_file_type_id_sbm,
    24005 => :xoreos_file_type_id_pvd,
    24006 => :xoreos_file_type_id_pla,
    24007 => :xoreos_file_type_id_trg,
    24008 => :xoreos_file_type_id_pk,
    25000 => :xoreos_file_type_id_als,
    25001 => :xoreos_file_type_id_apl,
    25002 => :xoreos_file_type_id_assembly,
    25003 => :xoreos_file_type_id_bak,
    25004 => :xoreos_file_type_id_bnk,
    25005 => :xoreos_file_type_id_cl,
    25006 => :xoreos_file_type_id_cnv,
    25007 => :xoreos_file_type_id_con,
    25008 => :xoreos_file_type_id_dat,
    25009 => :xoreos_file_type_id_dx11,
    25010 => :xoreos_file_type_id_ids,
    25011 => :xoreos_file_type_id_log,
    25012 => :xoreos_file_type_id_map,
    25013 => :xoreos_file_type_id_mml,
    25014 => :xoreos_file_type_id_mp3,
    25015 => :xoreos_file_type_id_pck,
    25016 => :xoreos_file_type_id_rml,
    25017 => :xoreos_file_type_id_s,
    25018 => :xoreos_file_type_id_sta,
    25019 => :xoreos_file_type_id_svr,
    25020 => :xoreos_file_type_id_vlm,
    25021 => :xoreos_file_type_id_wbd,
    25022 => :xoreos_file_type_id_xbx,
    25023 => :xoreos_file_type_id_xls,
    26000 => :xoreos_file_type_id_bzf,
    27000 => :xoreos_file_type_id_adv,
    28000 => :xoreos_file_type_id_json,
    28001 => :xoreos_file_type_id_tlk_expert,
    28002 => :xoreos_file_type_id_tlk_mobile,
    28003 => :xoreos_file_type_id_tlk_touch,
    28004 => :xoreos_file_type_id_otf,
    28005 => :xoreos_file_type_id_par,
    29000 => :xoreos_file_type_id_xwb,
    29001 => :xoreos_file_type_id_xsb,
    30000 => :xoreos_file_type_id_xds,
    30001 => :xoreos_file_type_id_wnd,
    40000 => :xoreos_file_type_id_xeositex,
  }
  I__XOREOS_FILE_TYPE_ID = XOREOS_FILE_TYPE_ID.invert
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = ErfHeader.new(@_io, self, @_root)
    self
  end
  class ErfHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotAnyOfError.new(@file_type, @_io, "/types/erf_header/seq/0") if not  ((@file_type == "ERF ") || (@file_type == "MOD ") || (@file_type == "SAV ") || (@file_type == "HAK ")) 
      @file_version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotEqualError.new("V1.0", @file_version, @_io, "/types/erf_header/seq/1") if not @file_version == "V1.0"
      @language_count = @_io.read_u4le
      @localized_string_size = @_io.read_u4le
      @entry_count = @_io.read_u4le
      @offset_to_localized_string_list = @_io.read_u4le
      @offset_to_key_list = @_io.read_u4le
      @offset_to_resource_list = @_io.read_u4le
      @build_year = @_io.read_u4le
      @build_day = @_io.read_u4le
      @description_strref = @_io.read_s4le
      @reserved = @_io.read_bytes(116)
      self
    end

    ##
    # Heuristic to detect save game files.
    # Save games use MOD signature but typically have description_strref = 0.
    def is_save_file
      return @is_save_file unless @is_save_file.nil?
      @is_save_file =  ((file_type == "MOD ") && (description_strref == 0)) 
      @is_save_file
    end

    ##
    # File type signature. Must be one of:
    # - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
    # - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
    # - "SAV " (0x53 0x41 0x56 0x20) - Save game file
    # - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
    attr_reader :file_type

    ##
    # File format version. Always "V1.0" for KotOR ERF files.
    # Other versions may exist in Neverwinter Nights but are not supported in KotOR.
    attr_reader :file_version

    ##
    # Number of localized string entries. Typically 0 for most ERF files.
    # MOD files may include localized module names for the load screen.
    attr_reader :language_count

    ##
    # Total size of localized string data in bytes.
    # Includes all language entries (language_id + string_size + string_data for each).
    attr_reader :localized_string_size

    ##
    # Number of resources in the archive. This determines:
    # - Number of entries in key_list
    # - Number of entries in resource_list
    # - Number of resource data blocks stored at various offsets
    attr_reader :entry_count

    ##
    # Byte offset to the localized string list from the beginning of the file.
    # Typically 160 (right after header) if present, or 0 if not present.
    attr_reader :offset_to_localized_string_list

    ##
    # Byte offset to the key list from the beginning of the file.
    # Typically 160 (right after header) if no localized strings, or after localized strings.
    attr_reader :offset_to_key_list

    ##
    # Byte offset to the resource list from the beginning of the file.
    # Located after the key list.
    attr_reader :offset_to_resource_list

    ##
    # Build year (years since 1900).
    # Example: 103 = year 2003
    # Primarily informational, used by development tools to track module versions.
    attr_reader :build_year

    ##
    # Build day (days since January 1, with January 1 = day 1).
    # Example: 247 = September 4th (the 247th day of the year)
    # Primarily informational, used by development tools to track module versions.
    attr_reader :build_day

    ##
    # Description StrRef (TLK string reference) for the archive description.
    # Values vary by file type:
    # - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
    # - SAV files: 0 (typically no description)
    # - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
    attr_reader :description_strref

    ##
    # Reserved padding (usually zeros).
    # Total header size is 160 bytes:
    # file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
    # entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
    # offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
    # reserved (116) = 160 bytes
    attr_reader :reserved
  end
  class KeyEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @resref = (@_io.read_bytes(16)).force_encoding("ASCII").encode('UTF-8')
      @resource_id = @_io.read_u4le
      @resource_type = Kaitai::Struct::Stream::resolve_enum(Erf::XOREOS_FILE_TYPE_ID, @_io.read_u2le)
      @unused = @_io.read_u2le
      self
    end

    ##
    # Resource filename (ResRef), null-padded to 16 bytes.
    # Maximum 16 characters. If exactly 16 characters, no null terminator exists.
    # Resource names can be mixed case, though most are lowercase in practice.
    attr_reader :resref

    ##
    # Resource ID (index into resource_list).
    # Maps this key entry to the corresponding resource entry.
    attr_reader :resource_id

    ##
    # Resource type identifier (see ResourceType enum).
    # Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
    attr_reader :resource_type

    ##
    # Padding/unused field (typically 0)
    attr_reader :unused
  end
  class KeyList < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.entry_count).times { |i|
        @entries << KeyEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of key entries mapping ResRefs to resource indices
    attr_reader :entries
  end
  class LocalizedStringEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @language_id = @_io.read_u4le
      @string_size = @_io.read_u4le
      @string_data = (@_io.read_bytes(string_size)).force_encoding("UTF-8")
      self
    end

    ##
    # Language identifier:
    # - 0 = English
    # - 1 = French
    # - 2 = German
    # - 3 = Italian
    # - 4 = Spanish
    # - 5 = Polish
    # - Additional languages for Asian releases
    attr_reader :language_id

    ##
    # Length of string data in bytes
    attr_reader :string_size

    ##
    # UTF-8 encoded text string
    attr_reader :string_data
  end
  class LocalizedStringList < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.language_count).times { |i|
        @entries << LocalizedStringEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of localized string entries, one per language
    attr_reader :entries
  end
  class ResourceEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @offset_to_data = @_io.read_u4le
      @len_data = @_io.read_u4le
      self
    end

    ##
    # Raw binary data for this resource
    def data
      return @data unless @data.nil?
      _pos = @_io.pos
      @_io.seek(offset_to_data)
      @data = @_io.read_bytes(len_data)
      @_io.seek(_pos)
      @data
    end

    ##
    # Byte offset to resource data from the beginning of the file.
    # Points to the actual binary data for this resource.
    attr_reader :offset_to_data

    ##
    # Size of resource data in bytes.
    # Uncompressed size of the resource.
    attr_reader :len_data
  end
  class ResourceList < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.entry_count).times { |i|
        @entries << ResourceEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of resource entries containing offset and size information
    attr_reader :entries
  end

  ##
  # Array of key entries mapping ResRefs to resource indices
  def key_list
    return @key_list unless @key_list.nil?
    _pos = @_io.pos
    @_io.seek(header.offset_to_key_list)
    @key_list = KeyList.new(@_io, self, @_root)
    @_io.seek(_pos)
    @key_list
  end

  ##
  # Optional localized string entries for multi-language descriptions
  def localized_string_list
    return @localized_string_list unless @localized_string_list.nil?
    if header.language_count > 0
      _pos = @_io.pos
      @_io.seek(header.offset_to_localized_string_list)
      @localized_string_list = LocalizedStringList.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @localized_string_list
  end

  ##
  # Array of resource entries containing offset and size information
  def resource_list
    return @resource_list unless @resource_list.nil?
    _pos = @_io.pos
    @_io.seek(header.offset_to_resource_list)
    @resource_list = ResourceList.new(@_io, self, @_root)
    @_io.seek(_pos)
    @resource_list
  end

  ##
  # ERF file header (160 bytes)
  attr_reader :header
end
