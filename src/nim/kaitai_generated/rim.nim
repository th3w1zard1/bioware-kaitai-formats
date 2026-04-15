import kaitai_struct_nim_runtime
import options

type
  Rim* = ref object of KaitaiStruct
    `header`*: Rim_RimHeader
    `gapBeforeKeyTableImplicit`*: seq[byte]
    `gapBeforeKeyTableExplicit`*: seq[byte]
    `resourceEntryTable`*: Rim_ResourceEntryTable
    `parent`*: KaitaiStruct
  Rim_XoreosFileTypeId* = enum
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
  Rim_ResourceEntry* = ref object of KaitaiStruct
    `resref`*: string
    `resourceType`*: Rim_XoreosFileTypeId
    `resourceId`*: uint32
    `offsetToData`*: uint32
    `numData`*: uint32
    `parent`*: Rim_ResourceEntryTable
    `dataInst`: seq[uint8]
    `dataInstFlag`: bool
  Rim_ResourceEntryTable* = ref object of KaitaiStruct
    `entries`*: seq[Rim_ResourceEntry]
    `parent`*: Rim
  Rim_RimHeader* = ref object of KaitaiStruct
    `fileType`*: string
    `fileVersion`*: string
    `reserved`*: uint32
    `resourceCount`*: uint32
    `offsetToResourceTable`*: uint32
    `offsetToResources`*: uint32
    `parent`*: Rim
    `hasResourcesInst`: bool
    `hasResourcesInstFlag`: bool

proc read*(_: typedesc[Rim], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Rim
proc read*(_: typedesc[Rim_ResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Rim_ResourceEntryTable): Rim_ResourceEntry
proc read*(_: typedesc[Rim_ResourceEntryTable], io: KaitaiStream, root: KaitaiStruct, parent: Rim): Rim_ResourceEntryTable
proc read*(_: typedesc[Rim_RimHeader], io: KaitaiStream, root: KaitaiStruct, parent: Rim): Rim_RimHeader

proc data*(this: Rim_ResourceEntry): seq[uint8]
proc hasResources*(this: Rim_RimHeader): bool


##[
RIM (Resource Information Manager) files are self-contained archives used for module templates.
RIM files are similar to ERF files but are read-only from the game's perspective. The game
loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
RIM files store all resources inline with metadata, making them self-contained archives.

Format Variants:
- Standard RIM: Basic module template files
- Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs

Binary Format (KotOR / PyKotor):
- Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
- Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
- Key / resource entry table (32 bytes per entry): ResRef, type, ID, offset, size
- Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)

References:
- https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim
- https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/rimreader.cpp:24-100
- https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp:40-160
- https://github.com/KotOR-Community-Patches/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs:11-121
- https://github.com/KotOR-Community-Patches/KotOR_IO/blob/master/KotOR_IO/File%20Formats/RIM.cs:20-260

]##
proc read*(_: typedesc[Rim], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Rim =
  template this: untyped = result
  this = new(Rim)
  let root = if root == nil: cast[Rim](this) else: cast[Rim](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
  ]##
  let headerExpr = Rim_RimHeader.read(this.io, this.root, this)
  this.header = headerExpr

  ##[
  When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).

  ]##
  if this.header.offsetToResourceTable == 0:
    let gapBeforeKeyTableImplicitExpr = this.io.readBytes(int(96))
    this.gapBeforeKeyTableImplicit = gapBeforeKeyTableImplicitExpr

  ##[
  When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.

  ]##
  if this.header.offsetToResourceTable != 0:
    let gapBeforeKeyTableExplicitExpr = this.io.readBytes(int(this.header.offsetToResourceTable - 24))
    this.gapBeforeKeyTableExplicit = gapBeforeKeyTableExplicitExpr

  ##[
  Array of resource entries mapping ResRefs to resource data
  ]##
  if this.header.resourceCount > 0:
    let resourceEntryTableExpr = Rim_ResourceEntryTable.read(this.io, this.root, this)
    this.resourceEntryTable = resourceEntryTableExpr

proc fromFile*(_: typedesc[Rim], filename: string): Rim =
  Rim.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Rim_ResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Rim_ResourceEntryTable): Rim_ResourceEntry =
  template this: untyped = result
  this = new(Rim_ResourceEntry)
  let root = if root == nil: cast[Rim](this) else: cast[Rim](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Resource filename (ResRef), null-padded to 16 bytes.
Maximum 16 characters. If exactly 16 characters, no null terminator exists.
Resource names can be mixed case, though most are lowercase in practice.
The game engine typically lowercases ResRefs when loading.

  ]##
  let resrefExpr = encode(this.io.readBytes(int(16)), "ASCII")
  this.resref = resrefExpr

  ##[
  Resource type identifier (see ResourceType enum).
Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)

  ]##
  let resourceTypeExpr = Rim_XoreosFileTypeId(this.io.readU4le())
  this.resourceType = resourceTypeExpr

  ##[
  Resource ID (index, usually sequential).
Typically matches the index of this entry in the resource_entry_table.
Used for internal reference, but not critical for parsing.

  ]##
  let resourceIdExpr = this.io.readU4le()
  this.resourceId = resourceIdExpr

  ##[
  Byte offset to resource data from the beginning of the file.
Points to the actual binary data for this resource in resource_data_section.

  ]##
  let offsetToDataExpr = this.io.readU4le()
  this.offsetToData = offsetToDataExpr

  ##[
  Size of resource data in bytes (repeat count for raw `data` bytes).
Uncompressed size of the resource.

  ]##
  let numDataExpr = this.io.readU4le()
  this.numData = numDataExpr

proc data(this: Rim_ResourceEntry): seq[uint8] = 

  ##[
  Raw binary data for this resource (read at specified offset)
  ]##
  if this.dataInstFlag:
    return this.dataInst
  let pos = this.io.pos()
  this.io.seek(int(this.offsetToData))
  for i in 0 ..< int(this.numData):
    let it = this.io.readU1()
    this.dataInst.add(it)
  this.io.seek(pos)
  this.dataInstFlag = true
  return this.dataInst

proc fromFile*(_: typedesc[Rim_ResourceEntry], filename: string): Rim_ResourceEntry =
  Rim_ResourceEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Rim_ResourceEntryTable], io: KaitaiStream, root: KaitaiStruct, parent: Rim): Rim_ResourceEntryTable =
  template this: untyped = result
  this = new(Rim_ResourceEntryTable)
  let root = if root == nil: cast[Rim](this) else: cast[Rim](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of resource entries, one per resource in the archive
  ]##
  for i in 0 ..< int(Rim(this.root).header.resourceCount):
    let it = Rim_ResourceEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Rim_ResourceEntryTable], filename: string): Rim_ResourceEntryTable =
  Rim_ResourceEntryTable.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Rim_RimHeader], io: KaitaiStream, root: KaitaiStruct, parent: Rim): Rim_RimHeader =
  template this: untyped = result
  this = new(Rim_RimHeader)
  let root = if root == nil: cast[Rim](this) else: cast[Rim](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
This identifies the file as a RIM archive.

  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Always "V1.0" for KotOR RIM files.
Other versions may exist in Neverwinter Nights but are not supported in KotOR.

  ]##
  let fileVersionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileVersion = fileVersionExpr

  ##[
  Reserved field (typically 0x00000000).
Unknown purpose, but always set to 0 in practice.

  ]##
  let reservedExpr = this.io.readU4le()
  this.reserved = reservedExpr

  ##[
  Number of resources in the archive. This determines:
- Number of entries in resource_entry_table
- Number of resources in resource_data_section

  ]##
  let resourceCountExpr = this.io.readU4le()
  this.resourceCount = resourceCountExpr

  ##[
  Byte offset to the key / resource entry table from the beginning of the file.
0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
When non-zero, this offset is used directly (commonly 120).

  ]##
  let offsetToResourceTableExpr = this.io.readU4le()
  this.offsetToResourceTable = offsetToResourceTableExpr

  ##[
  Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.

  ]##
  let offsetToResourcesExpr = this.io.readU4le()
  this.offsetToResources = offsetToResourcesExpr

proc hasResources(this: Rim_RimHeader): bool = 

  ##[
  Whether the RIM file contains any resources
  ]##
  if this.hasResourcesInstFlag:
    return this.hasResourcesInst
  let hasResourcesInstExpr = bool(this.resourceCount > 0)
  this.hasResourcesInst = hasResourcesInstExpr
  this.hasResourcesInstFlag = true
  return this.hasResourcesInst

proc fromFile*(_: typedesc[Rim_RimHeader], filename: string): Rim_RimHeader =
  Rim_RimHeader.read(newKaitaiFileStream(filename), nil, nil)

