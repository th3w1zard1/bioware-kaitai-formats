meta:
  id: erf
  title: BioWare ERF (Encapsulated Resource File) Format
  license: MIT
  endian: le
  file-extension:
    - erf
    - hak
    - mod
    - sav
  xref:
    ghidra_odyssey_k1:
      note: |
        Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: CERFHeader is 160 bytes with the same field order as erf_header
        (file_type, version, language_count, localized_string_size, entry_count, three offsets, build_year, build_day, description_str_ref, 116-byte reserved tail).
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/
    reone: https://github.com/seedhartha/reone/tree/master/src/libs/resource/format/erfreader.cpp
    xoreos: https://github.com/xoreos/xoreos/tree/master/src/aurora/erffile.cpp
    kotor_net: https://github.com/NickHugi/Kotor.NET/tree/master/Formats/KotorERF/
    pykotor_wiki: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf
    bioware_aurora: https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf
doc: |
  ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
  texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
  ERF files store both resource names (ResRefs) and data in the same file. They also support
  localized strings for descriptions in multiple languages.

  Format Variants:
  - ERF: Generic encapsulated resource file (texture packs, etc.)
  - HAK: Hak pak file (contains override resources). Used for mod content distribution
  - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
  - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`

  All variants use the same binary format structure, differing only in the file type signature.

  Binary Format Structure:
  - Header (160 bytes): File type, version, entry counts, offsets, build date, description
  - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
    include localized module names for the load screen. Each entry contains language_id (u4),
    string_size (u4), and string_data (UTF-8 encoded text)
  - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
    - resref (16 bytes, ASCII, null-padded): Resource filename
    - resource_id (u4): Index into resource_list
    - resource_type (u2): Resource type identifier (see ResourceType enum)
    - unused (u2): Padding/unused field (typically 0)
  - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
    - offset_to_data (u4): Byte offset to resource data from beginning of file
    - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
  - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
    in resource_list

  File Access Pattern:
  1. Read header to get entry_count and offsets
  2. Read key_list to map ResRefs to resource_ids
  3. Use resource_id to index into resource_list
  4. Read resource data from offset_to_data with byte length len_data

  References:
  - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf - Complete ERF format documentation
  - https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf - Official BioWare Aurora ERF specification
  - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/erfreader.cpp:24-106 - Complete C++ ERF reader implementation
  - https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp:44-229 - Generic Aurora ERF implementation (shared format)
  - https://github.com/NickHugi/Kotor.NET/blob/master/Formats/KotorERF/ERFBinaryStructure.cs:11-170 - .NET ERF reader/writer
  - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py - PyKotor binary reader/writer
  - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py - ERF data model

seq:
  - id: header
    type: erf_header
    doc: ERF file header (160 bytes)

instances:
  localized_string_list:
    type: localized_string_list
    if: header.language_count > 0
    pos: header.offset_to_localized_string_list
    doc: Optional localized string entries for multi-language descriptions

  key_list:
    type: key_list
    pos: header.offset_to_key_list
    doc: Array of key entries mapping ResRefs to resource indices

  resource_list:
    type: resource_list
    pos: header.offset_to_resource_list
    doc: Array of resource entries containing offset and size information

types:
  erf_header:
    seq:
      - id: file_type
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File type signature. Must be one of:
          - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
          - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
          - "SAV " (0x53 0x41 0x56 0x20) - Save game file
          - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
        valid:
          any-of:
            - "'ERF '"
            - "'MOD '"
            - "'SAV '"
            - "'HAK '"

      - id: file_version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File format version. Always "V1.0" for KotOR ERF files.
          Other versions may exist in Neverwinter Nights but are not supported in KotOR.
        valid: "'V1.0'"

      - id: language_count
        type: u4
        doc: |
          Number of localized string entries. Typically 0 for most ERF files.
          MOD files may include localized module names for the load screen.

      - id: localized_string_size
        type: u4
        doc: |
          Total size of localized string data in bytes.
          Includes all language entries (language_id + string_size + string_data for each).

      - id: entry_count
        type: u4
        doc: |
          Number of resources in the archive. This determines:
          - Number of entries in key_list
          - Number of entries in resource_list
          - Number of resource data blocks stored at various offsets

      - id: offset_to_localized_string_list
        type: u4
        doc: |
          Byte offset to the localized string list from the beginning of the file.
          Typically 160 (right after header) if present, or 0 if not present.

      - id: offset_to_key_list
        type: u4
        doc: |
          Byte offset to the key list from the beginning of the file.
          Typically 160 (right after header) if no localized strings, or after localized strings.

      - id: offset_to_resource_list
        type: u4
        doc: |
          Byte offset to the resource list from the beginning of the file.
          Located after the key list.

      - id: build_year
        type: u4
        doc: |
          Build year (years since 1900).
          Example: 103 = year 2003
          Primarily informational, used by development tools to track module versions.

      - id: build_day
        type: u4
        doc: |
          Build day (days since January 1, with January 1 = day 1).
          Example: 247 = September 4th (the 247th day of the year)
          Primarily informational, used by development tools to track module versions.

      - id: description_strref
        type: s4
        doc: |
          Description StrRef (TLK string reference) for the archive description.
          Values vary by file type:
          - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
          - SAV files: 0 (typically no description)
          - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)

      - id: reserved
        size: 116
        doc: |
          Reserved padding (usually zeros).
          Total header size is 160 bytes:
          file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
          entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
          offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
          reserved (116) = 160 bytes

    instances:
      is_save_file:
        value: file_type == "MOD " and description_strref == 0
        doc: |
          Heuristic to detect save game files.
          Save games use MOD signature but typically have description_strref = 0.

  localized_string_list:
    seq:
      - id: entries
        type: localized_string_entry
        repeat: expr
        repeat-expr: _root.header.language_count
        doc: Array of localized string entries, one per language

  localized_string_entry:
    seq:
      - id: language_id
        type: u4
        doc: |
          Language identifier:
          - 0 = English
          - 1 = French
          - 2 = German
          - 3 = Italian
          - 4 = Spanish
          - 5 = Polish
          - Additional languages for Asian releases

      - id: string_size
        type: u4
        doc: Length of string data in bytes

      - id: string_data
        type: str
        size: string_size
        encoding: UTF-8
        doc: UTF-8 encoded text string

  key_list:
    seq:
      - id: entries
        type: key_entry
        repeat: expr
        repeat-expr: _root.header.entry_count
        doc: Array of key entries mapping ResRefs to resource indices

  key_entry:
    seq:
      - id: resref
        type: str
        encoding: ASCII
        size: 16
        doc: |
          Resource filename (ResRef), null-padded to 16 bytes.
          Maximum 16 characters. If exactly 16 characters, no null terminator exists.
          Resource names can be mixed case, though most are lowercase in practice.

      - id: resource_id
        type: u4
        doc: |
          Resource ID (index into resource_list).
          Maps this key entry to the corresponding resource entry.

      - id: resource_type
        type: u2
        enum: xoreos_file_type_id
        doc: |
          Resource type identifier (see ResourceType enum).
          Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)

      - id: unused
        type: u2
        doc: Padding/unused field (typically 0)

    # NOTE: Avoid string trimming helpers here — Kaitai 0.11 does not support Python-style
    # `.rstrip()` on parsed strings in all backends. Consumers can trim `\0` externally if needed.

  resource_list:
    seq:
      - id: entries
        type: resource_entry
        repeat: expr
        repeat-expr: _root.header.entry_count
        doc: Array of resource entries containing offset and size information

  resource_entry:
    seq:
      - id: offset_to_data
        type: u4
        doc: |
          Byte offset to resource data from the beginning of the file.
          Points to the actual binary data for this resource.

      - id: len_data
        type: u4
        doc: |
          Size of resource data in bytes.
          Uncompressed size of the resource.

    instances:
      data:
        pos: offset_to_data
        size: len_data
        doc: Raw binary data for this resource

enums:
  # NOTE: Mirrors `https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h` (`enum FileType`).
  # TODO: VERIFY - Aliases exist upstream (e.g. 2045 also known as DTF) but Kaitai enums cannot
  # represent multiple names for the same numeric key.
  xoreos_file_type_id:
    -1: none
    0: res
    1: bmp
    2: mve
    3: tga
    4: wav
    6: plt
    7: ini
    8: bmu
    9: mpg
    10: txt
    11: wma
    12: wmv
    13: xmv
    2000: plh
    2001: tex
    2002: mdl
    2003: thg
    2005: fnt
    2007: lua
    2008: slt
    2009: nss
    2010: ncs
    2011: mod
    2012: are
    2013: set
    2014: ifo
    2015: bic
    2016: wok
    2017: two_da
    2018: tlk
    2022: txi
    2023: git
    2024: bti
    2025: uti
    2026: btc
    2027: utc
    2029: dlg
    2030: itp
    2031: btt
    2032: utt
    2033: dds
    2034: bts
    2035: uts
    2036: ltr
    2037: gff
    2038: fac
    2039: bte
    2040: ute
    2041: btd
    2042: utd
    2043: btp
    2044: utp
    2045: dft
    2046: gic
    2047: gui
    2048: css
    2049: ccs
    2050: btm
    2051: utm
    2052: dwk
    2053: pwk
    2054: btg
    2055: utg
    2056: jrl
    2057: sav
    2058: utw
    2059: four_pc
    2060: ssf
    2061: hak
    2062: nwm
    2063: bik
    2064: ndb
    2065: ptm
    2066: ptt
    2067: ncm
    2068: mfx
    2069: mat
    2070: mdb
    2071: say
    2072: ttf
    2073: ttc
    2074: cut
    2075: ka
    2076: jpg
    2077: ico
    2078: ogg
    2079: spt
    2080: spw
    2081: wfx
    2082: ugm
    2083: qdb
    2084: qst
    2085: npc
    2086: spn
    2087: utx
    2088: mmd
    2089: smm
    2090: uta
    2091: mde
    2092: mdv
    2093: mda
    2094: mba
    2095: oct
    2096: bfx
    2097: pdb
    2098: the_witcher_save
    2099: pvs
    2100: cfx
    2101: luc
    2103: prb
    2104: cam
    2105: vds
    2106: bin
    2107: wob
    2108: api
    2109: properties
    2110: png
    3000: lyt
    3001: vis
    3002: rim
    3003: pth
    3004: lip
    3005: bwm
    3006: txb
    3007: tpc
    3008: mdx
    3009: rsv
    3010: sig
    3011: mab
    3012: qst2
    3013: sto
    3015: hex
    3016: mdx2
    3017: txb2
    3022: fsm
    3023: art
    3024: amp
    3025: cwa
    3028: bip
    4000: mdb2
    4001: mda2
    4002: spt2
    4003: gr2
    4004: fxa
    4005: fxe
    4007: jpg2
    4008: pwc
    9996: one_da
    9997: erf
    9998: bif
    9999: key
    19000: exe
    19001: dbf
    19002: cdx
    19003: fpt
    20000: zip
    20001: fxm
    20002: fxs
    20003: xml
    20004: wlk
    20005: utr
    20006: sef
    20007: pfx
    20008: tfx
    20009: ifx
    20010: lfx
    20011: bbx
    20012: pfb
    20013: upe
    20014: usc
    20015: ult
    20016: fx
    20017: max
    20018: doc
    20019: scc
    20020: wmp
    20021: osc
    20022: trn
    20023: uen
    20024: ros
    20025: rst
    20026: ptx
    20027: ltx
    20028: trx
    21000: nds
    21001: herf
    21002: dict
    21003: small
    21004: cbgt
    21005: cdpth
    21006: emit
    21007: itm
    21008: nanr
    21009: nbfp
    21010: nbfs
    21011: ncer
    21012: ncgr
    21013: nclr
    21014: nftr
    21015: nsbca
    21016: nsbmd
    21017: nsbta
    21018: nsbtp
    21019: nsbtx
    21020: pal
    21021: raw
    21022: sadl
    21023: sdat
    21024: smp
    21025: spl
    21026: vx
    22000: anb
    22001: ani
    22002: cns
    22003: cur
    22004: evt
    22005: fdl
    22006: fxo
    22007: gad
    22008: gda
    22009: gfx
    22010: ldf
    22011: lst
    22012: mal
    22013: mao
    22014: mmh
    22015: mop
    22016: mor
    22017: msh
    22018: mtx
    22019: ncc
    22020: phy
    22021: plo
    22022: stg
    22023: tbi
    22024: tnt
    22025: arl
    22026: fev
    22027: fsb
    22028: opf
    22029: crf
    22030: rimp
    22031: met
    22032: meta
    22033: fxr
    22034: cif
    22035: cub
    22036: dlb
    22037: nsc
    23000: mov
    23001: curs
    23002: pict
    23003: rsrc
    23004: plist
    24000: cre
    24001: pso
    24002: vso
    24003: abc
    24004: sbm
    24005: pvd
    24006: pla
    24007: trg
    24008: pk
    25000: als
    25001: apl
    25002: assembly
    25003: bak
    25004: bnk
    25005: cl
    25006: cnv
    25007: con
    25008: dat
    25009: dx11
    25010: ids
    25011: log
    25012: map
    25013: mml
    25014: mp3
    25015: pck
    25016: rml
    25017: s
    25018: sta
    25019: svr
    25020: vlm
    25021: wbd
    25022: xbx
    25023: xls
    26000: bzf
    27000: adv
    28000: json
    28001: tlk_expert
    28002: tlk_mobile
    28003: tlk_touch
    28004: otf
    28005: par
    29000: xwb
    29001: xsb
    30000: xds
    30001: wnd
    40000: xeositex


