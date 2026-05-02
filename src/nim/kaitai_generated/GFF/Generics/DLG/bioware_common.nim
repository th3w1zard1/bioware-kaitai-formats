import kaitai_struct_nim_runtime
import options

type
  BiowareCommon* = ref object of KaitaiStruct
    `parent`*: KaitaiStruct
  BiowareCommon_BiowareDdsVariantBytesPerPixel* = enum
    dxt1 = 3
    dxt5 = 4
  BiowareCommon_BiowareEquipmentSlotFlag* = enum
    invalid = 0
    head = 1
    armor = 2
    gauntlet = 8
    right_hand = 16
    left_hand = 32
    right_arm = 128
    left_arm = 256
    implant = 512
    belt = 1024
    claw1 = 16384
    claw2 = 32768
    claw3 = 65536
    hide = 131072
    right_hand_2 = 262144
    left_hand_2 = 524288
  BiowareCommon_BiowareGameId* = enum
    k1 = 1
    k2 = 2
    k1_xbox = 3
    k2_xbox = 4
    k1_ios = 5
    k2_ios = 6
    k1_android = 7
    k2_android = 8
  BiowareCommon_BiowareGenderId* = enum
    male = 0
    female = 1
  BiowareCommon_BiowareLanguageId* = enum
    english = 0
    french = 1
    german = 2
    italian = 3
    spanish = 4
    polish = 5
    afrikaans = 6
    basque = 7
    breton = 9
    catalan = 10
    chamorro = 11
    chichewa = 12
    corsican = 13
    danish = 14
    dutch = 15
    faroese = 16
    filipino = 18
    finnish = 19
    flemish = 20
    frisian = 21
    galician = 22
    ganda = 23
    haitian_creole = 24
    hausa_latin = 25
    hawaiian = 26
    icelandic = 27
    ido = 28
    indonesian = 29
    igbo = 30
    irish = 31
    interlingua = 32
    javanese_latin = 33
    latin = 34
    luxembourgish = 35
    maltese = 36
    norwegian = 37
    occitan = 38
    portuguese = 39
    scots = 40
    scottish_gaelic = 41
    shona = 42
    soto = 43
    sundanese_latin = 44
    swahili = 45
    swedish = 46
    tagalog = 47
    tahitian = 48
    tongan = 49
    uzbek_latin = 50
    walloon = 51
    xhosa = 52
    yoruba = 53
    welsh = 54
    zulu = 55
    bulgarian = 58
    belarisian = 59
    macedonian = 60
    russian = 61
    serbian_cyrillic = 62
    tajik = 63
    tatar_cyrillic = 64
    ukrainian = 66
    uzbek = 67
    albanian = 68
    bosnian_latin = 69
    czech = 70
    slovak = 71
    slovene = 72
    croatian = 73
    hungarian = 75
    romanian = 76
    greek = 77
    esperanto = 78
    azerbaijani_latin = 79
    turkish = 81
    turkmen_latin = 82
    hebrew = 83
    arabic = 84
    estonian = 85
    latvian = 86
    lithuanian = 87
    vietnamese = 88
    thai = 89
    aymara = 90
    kinyarwanda = 91
    kurdish_latin = 92
    malagasy = 93
    malay_latin = 94
    maori = 95
    moldovan_latin = 96
    samoan = 97
    somali = 98
    korean = 128
    chinese_traditional = 129
    chinese_simplified = 130
    japanese = 131
    unknown = 2147483646
  BiowareCommon_BiowareLipVisemeId* = enum
    neutral = 0
    ee = 1
    eh = 2
    ah = 3
    oh = 4
    ooh = 5
    y = 6
    sts = 7
    fv = 8
    ng = 9
    th = 10
    mpb = 11
    td = 12
    sh = 13
    l = 14
    kg = 15
  BiowareCommon_BiowareLtrAlphabetLength* = enum
    neverwinter_nights = 26
    kotor = 28
  BiowareCommon_BiowareObjectTypeId* = enum
    invalid = 0
    creature = 1
    door = 2
    item = 3
    trigger = 4
    placeable = 5
    waypoint = 6
    encounter = 7
    store = 8
    area = 9
    sound = 10
    camera = 11
  BiowareCommon_BiowarePccCompressionCodec* = enum
    none = 0
    zlib = 1
    lzo = 2
  BiowareCommon_BiowarePccPackageKind* = enum
    normal_package = 0
    patch_package = 1
  BiowareCommon_BiowareTpcPixelFormatId* = enum
    greyscale = 1
    rgb_or_dxt1 = 2
    rgba_or_dxt5 = 4
    bgra_xbox_swizzle = 12
  BiowareCommon_RiffWaveFormatTag* = enum
    pcm = 1
    adpcm_ms = 2
    ieee_float = 3
    alaw = 6
    mulaw = 7
    dvi_ima_adpcm = 17
    mpeg_layer3 = 85
    wave_format_extensible = 65534
  BiowareCommon_BiowareBinaryData* = ref object of KaitaiStruct
    `lenValue`*: uint32
    `value`*: seq[byte]
    `parent`*: KaitaiStruct
  BiowareCommon_BiowareCexoString* = ref object of KaitaiStruct
    `lenString`*: uint32
    `value`*: string
    `parent`*: KaitaiStruct
  BiowareCommon_BiowareLocstring* = ref object of KaitaiStruct
    `totalSize`*: uint32
    `stringRef`*: uint32
    `numSubstrings`*: uint32
    `substrings`*: seq[BiowareCommon_Substring]
    `parent`*: KaitaiStruct
    `hasStrrefInst`: bool
    `hasStrrefInstFlag`: bool
  BiowareCommon_BiowareResref* = ref object of KaitaiStruct
    `lenResref`*: uint8
    `value`*: string
    `parent`*: KaitaiStruct
  BiowareCommon_BiowareVector3* = ref object of KaitaiStruct
    `x`*: float32
    `y`*: float32
    `z`*: float32
    `parent`*: KaitaiStruct
  BiowareCommon_BiowareVector4* = ref object of KaitaiStruct
    `x`*: float32
    `y`*: float32
    `z`*: float32
    `w`*: float32
    `parent`*: KaitaiStruct
  BiowareCommon_Substring* = ref object of KaitaiStruct
    `substringId`*: uint32
    `lenText`*: uint32
    `text`*: string
    `parent`*: BiowareCommon_BiowareLocstring
    `genderInst`: BiowareCommon_BiowareGenderId
    `genderInstFlag`: bool
    `genderRawInst`: int
    `genderRawInstFlag`: bool
    `languageInst`: BiowareCommon_BiowareLanguageId
    `languageInstFlag`: bool
    `languageRawInst`: int
    `languageRawInstFlag`: bool

proc read*(_: typedesc[BiowareCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon
proc read*(_: typedesc[BiowareCommon_BiowareBinaryData], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareBinaryData
proc read*(_: typedesc[BiowareCommon_BiowareCexoString], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareCexoString
proc read*(_: typedesc[BiowareCommon_BiowareLocstring], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareLocstring
proc read*(_: typedesc[BiowareCommon_BiowareResref], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareResref
proc read*(_: typedesc[BiowareCommon_BiowareVector3], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareVector3
proc read*(_: typedesc[BiowareCommon_BiowareVector4], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareVector4
proc read*(_: typedesc[BiowareCommon_Substring], io: KaitaiStream, root: KaitaiStruct, parent: BiowareCommon_BiowareLocstring): BiowareCommon_Substring

proc hasStrref*(this: BiowareCommon_BiowareLocstring): bool
proc gender*(this: BiowareCommon_Substring): BiowareCommon_BiowareGenderId
proc genderRaw*(this: BiowareCommon_Substring): int
proc language*(this: BiowareCommon_Substring): BiowareCommon_BiowareLanguageId
proc languageRaw*(this: BiowareCommon_Substring): int


##[
Shared enums and "common objects" used across the BioWare ecosystem that also appear
in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).

This file is intended to be imported by other `.ksy` files to avoid repeating:
- Language IDs (used in TLK headers and GFF LocalizedString substrings)
- Gender IDs (used in GFF LocalizedString substrings)
- The CExoLocString / LocalizedString binary layout

References:
- https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py
- https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py
- https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py
- https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33
- https://github.com/modawan/reone/blob/master/include/reone/resource/types.h

@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py">PyKotor — Language (substring language IDs)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py">PyKotor — Gender / Game / EquipmentSlot</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py">PyKotor — ObjectType</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L235">PyKotor — GFF field read path (LocalizedString via reader)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73">xoreos — `Language` / `LanguageGender` (Aurora runtime; compare TLK / substring packing)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L57-L92">xoreos — `TalkTable_TLK::load` (TLK header + language id field)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33">xoreos-tools — `byte` / `uint` typedefs</a>
@see <a href="https://github.com/modawan/reone/blob/master/include/reone/resource/types.h">reone — resource type / engine constants</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree (discoverability)</a>
]##
proc read*(_: typedesc[BiowareCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon =
  template this: untyped = result
  this = new(BiowareCommon)
  let root = if root == nil: cast[BiowareCommon](this) else: cast[BiowareCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


proc fromFile*(_: typedesc[BiowareCommon], filename: string): BiowareCommon =
  BiowareCommon.read(newKaitaiFileStream(filename), nil, nil)


##[
Variable-length binary data with 4-byte length prefix.
Used for Void/Binary fields in GFF files.

]##
proc read*(_: typedesc[BiowareCommon_BiowareBinaryData], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareBinaryData =
  template this: untyped = result
  this = new(BiowareCommon_BiowareBinaryData)
  let root = if root == nil: cast[BiowareCommon](this) else: cast[BiowareCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Length of binary data in bytes
  ]##
  let lenValueExpr = this.io.readU4le()
  this.lenValue = lenValueExpr

  ##[
  Binary data
  ]##
  let valueExpr = this.io.readBytes(int(this.lenValue))
  this.value = valueExpr

proc fromFile*(_: typedesc[BiowareCommon_BiowareBinaryData], filename: string): BiowareCommon_BiowareBinaryData =
  BiowareCommon_BiowareBinaryData.read(newKaitaiFileStream(filename), nil, nil)


##[
BioWare CExoString - variable-length string with 4-byte length prefix.
Used for string fields in GFF files.

]##
proc read*(_: typedesc[BiowareCommon_BiowareCexoString], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareCexoString =
  template this: untyped = result
  this = new(BiowareCommon_BiowareCexoString)
  let root = if root == nil: cast[BiowareCommon](this) else: cast[BiowareCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Length of string in bytes
  ]##
  let lenStringExpr = this.io.readU4le()
  this.lenString = lenStringExpr

  ##[
  String data (UTF-8)
  ]##
  let valueExpr = encode(this.io.readBytes(int(this.lenString)), "UTF-8")
  this.value = valueExpr

proc fromFile*(_: typedesc[BiowareCommon_BiowareCexoString], filename: string): BiowareCommon_BiowareCexoString =
  BiowareCommon_BiowareCexoString.read(newKaitaiFileStream(filename), nil, nil)


##[
BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
section for field type "LocalizedString".

]##
proc read*(_: typedesc[BiowareCommon_BiowareLocstring], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareLocstring =
  template this: untyped = result
  this = new(BiowareCommon_BiowareLocstring)
  let root = if root == nil: cast[BiowareCommon](this) else: cast[BiowareCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Total size of the structure in bytes (excluding this field).
  ]##
  let totalSizeExpr = this.io.readU4le()
  this.totalSize = totalSizeExpr

  ##[
  StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).

  ]##
  let stringRefExpr = this.io.readU4le()
  this.stringRef = stringRefExpr

  ##[
  Number of substring entries that follow.
  ]##
  let numSubstringsExpr = this.io.readU4le()
  this.numSubstrings = numSubstringsExpr

  ##[
  Language/gender-specific substring entries.
  ]##
  for i in 0 ..< int(this.numSubstrings):
    let it = BiowareCommon_Substring.read(this.io, this.root, this)
    this.substrings.add(it)

proc hasStrref(this: BiowareCommon_BiowareLocstring): bool = 

  ##[
  True if this locstring references dialog.tlk
  ]##
  if this.hasStrrefInstFlag:
    return this.hasStrrefInst
  let hasStrrefInstExpr = bool(this.stringRef != 4294967295'i64)
  this.hasStrrefInst = hasStrrefInstExpr
  this.hasStrrefInstFlag = true
  return this.hasStrrefInst

proc fromFile*(_: typedesc[BiowareCommon_BiowareLocstring], filename: string): BiowareCommon_BiowareLocstring =
  BiowareCommon_BiowareLocstring.read(newKaitaiFileStream(filename), nil, nil)


##[
BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
Used throughout GFF files to reference game resources by name.

]##
proc read*(_: typedesc[BiowareCommon_BiowareResref], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareResref =
  template this: untyped = result
  this = new(BiowareCommon_BiowareResref)
  let root = if root == nil: cast[BiowareCommon](this) else: cast[BiowareCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Length of ResRef string (0-16 characters)
  ]##
  let lenResrefExpr = this.io.readU1()
  this.lenResref = lenResrefExpr

  ##[
  ResRef string data (ASCII, lowercase recommended)
  ]##
  let valueExpr = encode(this.io.readBytes(int(this.lenResref)), "ASCII")
  this.value = valueExpr

proc fromFile*(_: typedesc[BiowareCommon_BiowareResref], filename: string): BiowareCommon_BiowareResref =
  BiowareCommon_BiowareResref.read(newKaitaiFileStream(filename), nil, nil)


##[
3D vector (X, Y, Z coordinates).
Used for positions, directions, etc. in game files.

]##
proc read*(_: typedesc[BiowareCommon_BiowareVector3], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareVector3 =
  template this: untyped = result
  this = new(BiowareCommon_BiowareVector3)
  let root = if root == nil: cast[BiowareCommon](this) else: cast[BiowareCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  X coordinate
  ]##
  let xExpr = this.io.readF4le()
  this.x = xExpr

  ##[
  Y coordinate
  ]##
  let yExpr = this.io.readF4le()
  this.y = yExpr

  ##[
  Z coordinate
  ]##
  let zExpr = this.io.readF4le()
  this.z = zExpr

proc fromFile*(_: typedesc[BiowareCommon_BiowareVector3], filename: string): BiowareCommon_BiowareVector3 =
  BiowareCommon_BiowareVector3.read(newKaitaiFileStream(filename), nil, nil)


##[
4D vector / Quaternion (X, Y, Z, W components).
Used for orientations/rotations in game files.

]##
proc read*(_: typedesc[BiowareCommon_BiowareVector4], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareCommon_BiowareVector4 =
  template this: untyped = result
  this = new(BiowareCommon_BiowareVector4)
  let root = if root == nil: cast[BiowareCommon](this) else: cast[BiowareCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  X component
  ]##
  let xExpr = this.io.readF4le()
  this.x = xExpr

  ##[
  Y component
  ]##
  let yExpr = this.io.readF4le()
  this.y = yExpr

  ##[
  Z component
  ]##
  let zExpr = this.io.readF4le()
  this.z = zExpr

  ##[
  W component
  ]##
  let wExpr = this.io.readF4le()
  this.w = wExpr

proc fromFile*(_: typedesc[BiowareCommon_BiowareVector4], filename: string): BiowareCommon_BiowareVector4 =
  BiowareCommon_BiowareVector4.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[BiowareCommon_Substring], io: KaitaiStream, root: KaitaiStruct, parent: BiowareCommon_BiowareLocstring): BiowareCommon_Substring =
  template this: untyped = result
  this = new(BiowareCommon_Substring)
  let root = if root == nil: cast[BiowareCommon](this) else: cast[BiowareCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Packed language+gender identifier:
- bits 0..7: gender
- bits 8..15: language

  ]##
  let substringIdExpr = this.io.readU4le()
  this.substringId = substringIdExpr

  ##[
  Length of text in bytes.
  ]##
  let lenTextExpr = this.io.readU4le()
  this.lenText = lenTextExpr

  ##[
  Substring text.
  ]##
  let textExpr = encode(this.io.readBytes(int(this.lenText)), "UTF-8")
  this.text = textExpr

proc gender(this: BiowareCommon_Substring): BiowareCommon_BiowareGenderId = 

  ##[
  Gender as enum value
  ]##
  if this.genderInstFlag:
    return this.genderInst
  let genderInstExpr = BiowareCommon_BiowareGenderId(BiowareCommon_BiowareGenderId(this.genderRaw))
  this.genderInst = genderInstExpr
  this.genderInstFlag = true
  return this.genderInst

proc genderRaw(this: BiowareCommon_Substring): int = 

  ##[
  Raw gender ID (0..255).
  ]##
  if this.genderRawInstFlag:
    return this.genderRawInst
  let genderRawInstExpr = int(this.substringId and 255)
  this.genderRawInst = genderRawInstExpr
  this.genderRawInstFlag = true
  return this.genderRawInst

proc language(this: BiowareCommon_Substring): BiowareCommon_BiowareLanguageId = 

  ##[
  Language as enum value
  ]##
  if this.languageInstFlag:
    return this.languageInst
  let languageInstExpr = BiowareCommon_BiowareLanguageId(BiowareCommon_BiowareLanguageId(this.languageRaw))
  this.languageInst = languageInstExpr
  this.languageInstFlag = true
  return this.languageInst

proc languageRaw(this: BiowareCommon_Substring): int = 

  ##[
  Raw language ID (0..255).
  ]##
  if this.languageRawInstFlag:
    return this.languageRawInst
  let languageRawInstExpr = int(this.substringId shr 8 and 255)
  this.languageRawInst = languageRawInstExpr
  this.languageRawInstFlag = true
  return this.languageRawInst

proc fromFile*(_: typedesc[BiowareCommon_Substring], filename: string): BiowareCommon_Substring =
  BiowareCommon_Substring.read(newKaitaiFileStream(filename), nil, nil)

