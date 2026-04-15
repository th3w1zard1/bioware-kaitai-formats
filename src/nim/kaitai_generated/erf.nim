import kaitai_struct_nim_runtime
import options

type
  Erf* = ref object of KaitaiStruct
    `header`*: Erf_ErfHeader
    `parent`*: KaitaiStruct
    `keyListInst`: Erf_KeyList
    `keyListInstFlag`: bool
    `localizedStringListInst`: Erf_LocalizedStringList
    `localizedStringListInstFlag`: bool
    `resourceListInst`: Erf_ResourceList
    `resourceListInstFlag`: bool
  Erf_XoreosFileTypeId* = enum
    none = -1
    res = 0
    bmp = 1
    mve = 2
    tga = 3
    wav = 4
    plt = 6
    ini = 7
    bmu = 8
    mpg = 9
    txt = 10
    wma = 11
    wmv = 12
    xmv = 13
    plh = 2000
    tex = 2001
    mdl = 2002
    thg = 2003
    fnt = 2005
    lua = 2007
    slt = 2008
    nss = 2009
    ncs = 2010
    mod = 2011
    are = 2012
    set = 2013
    ifo = 2014
    bic = 2015
    wok = 2016
    two_da = 2017
    tlk = 2018
    txi = 2022
    git = 2023
    bti = 2024
    uti = 2025
    btc = 2026
    utc = 2027
    dlg = 2029
    itp = 2030
    btt = 2031
    utt = 2032
    dds = 2033
    bts = 2034
    uts = 2035
    ltr = 2036
    gff = 2037
    fac = 2038
    bte = 2039
    ute = 2040
    btd = 2041
    utd = 2042
    btp = 2043
    utp = 2044
    dft = 2045
    gic = 2046
    gui = 2047
    css = 2048
    ccs = 2049
    btm = 2050
    utm = 2051
    dwk = 2052
    pwk = 2053
    btg = 2054
    utg = 2055
    jrl = 2056
    sav = 2057
    utw = 2058
    four_pc = 2059
    ssf = 2060
    hak = 2061
    nwm = 2062
    bik = 2063
    ndb = 2064
    ptm = 2065
    ptt = 2066
    ncm = 2067
    mfx = 2068
    mat = 2069
    mdb = 2070
    say = 2071
    ttf = 2072
    ttc = 2073
    cut = 2074
    ka = 2075
    jpg = 2076
    ico = 2077
    ogg = 2078
    spt = 2079
    spw = 2080
    wfx = 2081
    ugm = 2082
    qdb = 2083
    qst = 2084
    npc = 2085
    spn = 2086
    utx = 2087
    mmd = 2088
    smm = 2089
    uta = 2090
    mde = 2091
    mdv = 2092
    mda = 2093
    mba = 2094
    oct = 2095
    bfx = 2096
    pdb = 2097
    the_witcher_save = 2098
    pvs = 2099
    cfx = 2100
    luc = 2101
    prb = 2103
    cam = 2104
    vds = 2105
    bin = 2106
    wob = 2107
    api = 2108
    properties = 2109
    png = 2110
    lyt = 3000
    vis = 3001
    rim = 3002
    pth = 3003
    lip = 3004
    bwm = 3005
    txb = 3006
    tpc = 3007
    mdx = 3008
    rsv = 3009
    sig = 3010
    mab = 3011
    qst2 = 3012
    sto = 3013
    hex = 3015
    mdx2 = 3016
    txb2 = 3017
    fsm = 3022
    art = 3023
    amp = 3024
    cwa = 3025
    bip = 3028
    mdb2 = 4000
    mda2 = 4001
    spt2 = 4002
    gr2 = 4003
    fxa = 4004
    fxe = 4005
    jpg2 = 4007
    pwc = 4008
    one_da = 9996
    erf = 9997
    bif = 9998
    key = 9999
    exe = 19000
    dbf = 19001
    cdx = 19002
    fpt = 19003
    zip = 20000
    fxm = 20001
    fxs = 20002
    xml = 20003
    wlk = 20004
    utr = 20005
    sef = 20006
    pfx = 20007
    tfx = 20008
    ifx = 20009
    lfx = 20010
    bbx = 20011
    pfb = 20012
    upe = 20013
    usc = 20014
    ult = 20015
    fx = 20016
    max = 20017
    doc = 20018
    scc = 20019
    wmp = 20020
    osc = 20021
    trn = 20022
    uen = 20023
    ros = 20024
    rst = 20025
    ptx = 20026
    ltx = 20027
    trx = 20028
    nds = 21000
    herf = 21001
    dict = 21002
    small = 21003
    cbgt = 21004
    cdpth = 21005
    emit = 21006
    itm = 21007
    nanr = 21008
    nbfp = 21009
    nbfs = 21010
    ncer = 21011
    ncgr = 21012
    nclr = 21013
    nftr = 21014
    nsbca = 21015
    nsbmd = 21016
    nsbta = 21017
    nsbtp = 21018
    nsbtx = 21019
    pal = 21020
    raw = 21021
    sadl = 21022
    sdat = 21023
    smp = 21024
    spl = 21025
    vx = 21026
    anb = 22000
    ani = 22001
    cns = 22002
    cur = 22003
    evt = 22004
    fdl = 22005
    fxo = 22006
    gad = 22007
    gda = 22008
    gfx = 22009
    ldf = 22010
    lst = 22011
    mal = 22012
    mao = 22013
    mmh = 22014
    mop = 22015
    mor = 22016
    msh = 22017
    mtx = 22018
    ncc = 22019
    phy = 22020
    plo = 22021
    stg = 22022
    tbi = 22023
    tnt = 22024
    arl = 22025
    fev = 22026
    fsb = 22027
    opf = 22028
    crf = 22029
    rimp = 22030
    met = 22031
    meta = 22032
    fxr = 22033
    cif = 22034
    cub = 22035
    dlb = 22036
    nsc = 22037
    mov = 23000
    curs = 23001
    pict = 23002
    rsrc = 23003
    plist = 23004
    cre = 24000
    pso = 24001
    vso = 24002
    abc = 24003
    sbm = 24004
    pvd = 24005
    pla = 24006
    trg = 24007
    pk = 24008
    als = 25000
    apl = 25001
    assembly = 25002
    bak = 25003
    bnk = 25004
    cl = 25005
    cnv = 25006
    con = 25007
    dat = 25008
    dx11 = 25009
    ids = 25010
    log = 25011
    map = 25012
    mml = 25013
    mp3 = 25014
    pck = 25015
    rml = 25016
    s = 25017
    sta = 25018
    svr = 25019
    vlm = 25020
    wbd = 25021
    xbx = 25022
    xls = 25023
    bzf = 26000
    adv = 27000
    json = 28000
    tlk_expert = 28001
    tlk_mobile = 28002
    tlk_touch = 28003
    otf = 28004
    par = 28005
    xwb = 29000
    xsb = 29001
    xds = 30000
    wnd = 30001
    xeositex = 40000
  Erf_ErfHeader* = ref object of KaitaiStruct
    `fileType`*: string
    `fileVersion`*: string
    `languageCount`*: uint32
    `localizedStringSize`*: uint32
    `entryCount`*: uint32
    `offsetToLocalizedStringList`*: uint32
    `offsetToKeyList`*: uint32
    `offsetToResourceList`*: uint32
    `buildYear`*: uint32
    `buildDay`*: uint32
    `descriptionStrref`*: int32
    `reserved`*: seq[byte]
    `parent`*: Erf
    `isSaveFileInst`: bool
    `isSaveFileInstFlag`: bool
  Erf_KeyEntry* = ref object of KaitaiStruct
    `resref`*: string
    `resourceId`*: uint32
    `resourceType`*: Erf_XoreosFileTypeId
    `unused`*: uint16
    `parent`*: Erf_KeyList
  Erf_KeyList* = ref object of KaitaiStruct
    `entries`*: seq[Erf_KeyEntry]
    `parent`*: Erf
  Erf_LocalizedStringEntry* = ref object of KaitaiStruct
    `languageId`*: uint32
    `stringSize`*: uint32
    `stringData`*: string
    `parent`*: Erf_LocalizedStringList
  Erf_LocalizedStringList* = ref object of KaitaiStruct
    `entries`*: seq[Erf_LocalizedStringEntry]
    `parent`*: Erf
  Erf_ResourceEntry* = ref object of KaitaiStruct
    `offsetToData`*: uint32
    `lenData`*: uint32
    `parent`*: Erf_ResourceList
    `dataInst`: seq[byte]
    `dataInstFlag`: bool
  Erf_ResourceList* = ref object of KaitaiStruct
    `entries`*: seq[Erf_ResourceEntry]
    `parent`*: Erf

proc read*(_: typedesc[Erf], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Erf
proc read*(_: typedesc[Erf_ErfHeader], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_ErfHeader
proc read*(_: typedesc[Erf_KeyEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_KeyList): Erf_KeyEntry
proc read*(_: typedesc[Erf_KeyList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_KeyList
proc read*(_: typedesc[Erf_LocalizedStringEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_LocalizedStringList): Erf_LocalizedStringEntry
proc read*(_: typedesc[Erf_LocalizedStringList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_LocalizedStringList
proc read*(_: typedesc[Erf_ResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_ResourceList): Erf_ResourceEntry
proc read*(_: typedesc[Erf_ResourceList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_ResourceList

proc keyList*(this: Erf): Erf_KeyList
proc localizedStringList*(this: Erf): Erf_LocalizedStringList
proc resourceList*(this: Erf): Erf_ResourceList
proc isSaveFile*(this: Erf_ErfHeader): bool
proc data*(this: Erf_ResourceEntry): seq[byte]


##[
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

]##
proc read*(_: typedesc[Erf], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Erf =
  template this: untyped = result
  this = new(Erf)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  ERF file header (160 bytes)
  ]##
  let headerExpr = Erf_ErfHeader.read(this.io, this.root, this)
  this.header = headerExpr

proc keyList(this: Erf): Erf_KeyList = 

  ##[
  Array of key entries mapping ResRefs to resource indices
  ]##
  if this.keyListInstFlag:
    return this.keyListInst
  let pos = this.io.pos()
  this.io.seek(int(this.header.offsetToKeyList))
  let keyListInstExpr = Erf_KeyList.read(this.io, this.root, this)
  this.keyListInst = keyListInstExpr
  this.io.seek(pos)
  this.keyListInstFlag = true
  return this.keyListInst

proc localizedStringList(this: Erf): Erf_LocalizedStringList = 

  ##[
  Optional localized string entries for multi-language descriptions
  ]##
  if this.localizedStringListInstFlag:
    return this.localizedStringListInst
  if this.header.languageCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.offsetToLocalizedStringList))
    let localizedStringListInstExpr = Erf_LocalizedStringList.read(this.io, this.root, this)
    this.localizedStringListInst = localizedStringListInstExpr
    this.io.seek(pos)
  this.localizedStringListInstFlag = true
  return this.localizedStringListInst

proc resourceList(this: Erf): Erf_ResourceList = 

  ##[
  Array of resource entries containing offset and size information
  ]##
  if this.resourceListInstFlag:
    return this.resourceListInst
  let pos = this.io.pos()
  this.io.seek(int(this.header.offsetToResourceList))
  let resourceListInstExpr = Erf_ResourceList.read(this.io, this.root, this)
  this.resourceListInst = resourceListInstExpr
  this.io.seek(pos)
  this.resourceListInstFlag = true
  return this.resourceListInst

proc fromFile*(_: typedesc[Erf], filename: string): Erf =
  Erf.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_ErfHeader], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_ErfHeader =
  template this: untyped = result
  this = new(Erf_ErfHeader)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be one of:
- "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
- "MOD " (0x4D 0x4F 0x44 0x20) - Module file
- "SAV " (0x53 0x41 0x56 0x20) - Save game file
- "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file

  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Always "V1.0" for KotOR ERF files.
Other versions may exist in Neverwinter Nights but are not supported in KotOR.

  ]##
  let fileVersionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileVersion = fileVersionExpr

  ##[
  Number of localized string entries. Typically 0 for most ERF files.
MOD files may include localized module names for the load screen.

  ]##
  let languageCountExpr = this.io.readU4le()
  this.languageCount = languageCountExpr

  ##[
  Total size of localized string data in bytes.
Includes all language entries (language_id + string_size + string_data for each).

  ]##
  let localizedStringSizeExpr = this.io.readU4le()
  this.localizedStringSize = localizedStringSizeExpr

  ##[
  Number of resources in the archive. This determines:
- Number of entries in key_list
- Number of entries in resource_list
- Number of resource data blocks stored at various offsets

  ]##
  let entryCountExpr = this.io.readU4le()
  this.entryCount = entryCountExpr

  ##[
  Byte offset to the localized string list from the beginning of the file.
Typically 160 (right after header) if present, or 0 if not present.

  ]##
  let offsetToLocalizedStringListExpr = this.io.readU4le()
  this.offsetToLocalizedStringList = offsetToLocalizedStringListExpr

  ##[
  Byte offset to the key list from the beginning of the file.
Typically 160 (right after header) if no localized strings, or after localized strings.

  ]##
  let offsetToKeyListExpr = this.io.readU4le()
  this.offsetToKeyList = offsetToKeyListExpr

  ##[
  Byte offset to the resource list from the beginning of the file.
Located after the key list.

  ]##
  let offsetToResourceListExpr = this.io.readU4le()
  this.offsetToResourceList = offsetToResourceListExpr

  ##[
  Build year (years since 1900).
Example: 103 = year 2003
Primarily informational, used by development tools to track module versions.

  ]##
  let buildYearExpr = this.io.readU4le()
  this.buildYear = buildYearExpr

  ##[
  Build day (days since January 1, with January 1 = day 1).
Example: 247 = September 4th (the 247th day of the year)
Primarily informational, used by development tools to track module versions.

  ]##
  let buildDayExpr = this.io.readU4le()
  this.buildDay = buildDayExpr

  ##[
  Description StrRef (TLK string reference) for the archive description.
Values vary by file type:
- MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
- SAV files: 0 (typically no description)
- ERF/HAK files: Unpredictable (may contain valid StrRef or -1)

  ]##
  let descriptionStrrefExpr = this.io.readS4le()
  this.descriptionStrref = descriptionStrrefExpr

  ##[
  Reserved padding (usually zeros).
Total header size is 160 bytes:
file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
reserved (116) = 160 bytes

  ]##
  let reservedExpr = this.io.readBytes(int(116))
  this.reserved = reservedExpr

proc isSaveFile(this: Erf_ErfHeader): bool = 

  ##[
  Heuristic to detect save game files.
Save games use MOD signature but typically have description_strref = 0.

  ]##
  if this.isSaveFileInstFlag:
    return this.isSaveFileInst
  let isSaveFileInstExpr = bool( ((this.fileType == "MOD ") and (this.descriptionStrref == 0)) )
  this.isSaveFileInst = isSaveFileInstExpr
  this.isSaveFileInstFlag = true
  return this.isSaveFileInst

proc fromFile*(_: typedesc[Erf_ErfHeader], filename: string): Erf_ErfHeader =
  Erf_ErfHeader.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_KeyEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_KeyList): Erf_KeyEntry =
  template this: untyped = result
  this = new(Erf_KeyEntry)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Resource filename (ResRef), null-padded to 16 bytes.
Maximum 16 characters. If exactly 16 characters, no null terminator exists.
Resource names can be mixed case, though most are lowercase in practice.

  ]##
  let resrefExpr = encode(this.io.readBytes(int(16)), "ASCII")
  this.resref = resrefExpr

  ##[
  Resource ID (index into resource_list).
Maps this key entry to the corresponding resource entry.

  ]##
  let resourceIdExpr = this.io.readU4le()
  this.resourceId = resourceIdExpr

  ##[
  Resource type identifier (see ResourceType enum).
Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)

  ]##
  let resourceTypeExpr = Erf_XoreosFileTypeId(this.io.readU2le())
  this.resourceType = resourceTypeExpr

  ##[
  Padding/unused field (typically 0)
  ]##
  let unusedExpr = this.io.readU2le()
  this.unused = unusedExpr

proc fromFile*(_: typedesc[Erf_KeyEntry], filename: string): Erf_KeyEntry =
  Erf_KeyEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_KeyList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_KeyList =
  template this: untyped = result
  this = new(Erf_KeyList)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of key entries mapping ResRefs to resource indices
  ]##
  for i in 0 ..< int(Erf(this.root).header.entryCount):
    let it = Erf_KeyEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Erf_KeyList], filename: string): Erf_KeyList =
  Erf_KeyList.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_LocalizedStringEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_LocalizedStringList): Erf_LocalizedStringEntry =
  template this: untyped = result
  this = new(Erf_LocalizedStringEntry)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Language identifier:
- 0 = English
- 1 = French
- 2 = German
- 3 = Italian
- 4 = Spanish
- 5 = Polish
- Additional languages for Asian releases

  ]##
  let languageIdExpr = this.io.readU4le()
  this.languageId = languageIdExpr

  ##[
  Length of string data in bytes
  ]##
  let stringSizeExpr = this.io.readU4le()
  this.stringSize = stringSizeExpr

  ##[
  UTF-8 encoded text string
  ]##
  let stringDataExpr = encode(this.io.readBytes(int(this.stringSize)), "UTF-8")
  this.stringData = stringDataExpr

proc fromFile*(_: typedesc[Erf_LocalizedStringEntry], filename: string): Erf_LocalizedStringEntry =
  Erf_LocalizedStringEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_LocalizedStringList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_LocalizedStringList =
  template this: untyped = result
  this = new(Erf_LocalizedStringList)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of localized string entries, one per language
  ]##
  for i in 0 ..< int(Erf(this.root).header.languageCount):
    let it = Erf_LocalizedStringEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Erf_LocalizedStringList], filename: string): Erf_LocalizedStringList =
  Erf_LocalizedStringList.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_ResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_ResourceList): Erf_ResourceEntry =
  template this: untyped = result
  this = new(Erf_ResourceEntry)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Byte offset to resource data from the beginning of the file.
Points to the actual binary data for this resource.

  ]##
  let offsetToDataExpr = this.io.readU4le()
  this.offsetToData = offsetToDataExpr

  ##[
  Size of resource data in bytes.
Uncompressed size of the resource.

  ]##
  let lenDataExpr = this.io.readU4le()
  this.lenData = lenDataExpr

proc data(this: Erf_ResourceEntry): seq[byte] = 

  ##[
  Raw binary data for this resource
  ]##
  if this.dataInstFlag:
    return this.dataInst
  let pos = this.io.pos()
  this.io.seek(int(this.offsetToData))
  let dataInstExpr = this.io.readBytes(int(this.lenData))
  this.dataInst = dataInstExpr
  this.io.seek(pos)
  this.dataInstFlag = true
  return this.dataInst

proc fromFile*(_: typedesc[Erf_ResourceEntry], filename: string): Erf_ResourceEntry =
  Erf_ResourceEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_ResourceList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_ResourceList =
  template this: untyped = result
  this = new(Erf_ResourceList)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of resource entries containing offset and size information
  ]##
  for i in 0 ..< int(Erf(this.root).header.entryCount):
    let it = Erf_ResourceEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Erf_ResourceList], filename: string): Erf_ResourceList =
  Erf_ResourceList.read(newKaitaiFileStream(filename), nil, nil)

