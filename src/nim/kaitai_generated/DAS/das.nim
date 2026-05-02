import kaitai_struct_nim_runtime
import options

type
  Das* = ref object of KaitaiStruct
    `signature`*: string
    `version`*: int32
    `saveName`*: Das_LengthPrefixedString
    `moduleName`*: Das_LengthPrefixedString
    `areaName`*: Das_LengthPrefixedString
    `timePlayedSeconds`*: int32
    `timestampFiletime`*: int64
    `numScreenshotData`*: int32
    `screenshotData`*: seq[uint8]
    `numPortraitData`*: int32
    `portraitData`*: seq[uint8]
    `playerName`*: Das_LengthPrefixedString
    `partyMemberCount`*: int32
    `playerLevel`*: int32
    `parent`*: KaitaiStruct
  Das_LengthPrefixedString* = ref object of KaitaiStruct
    `length`*: int32
    `value`*: string
    `parent`*: Das
    `valueTrimmedInst`: string
    `valueTrimmedInstFlag`: bool

proc read*(_: typedesc[Das], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Das
proc read*(_: typedesc[Das_LengthPrefixedString], io: KaitaiStream, root: KaitaiStruct, parent: Das): Das_LengthPrefixedString

proc valueTrimmed*(this: Das_LengthPrefixedString): string


##[
**DAS** (Dragon Age: Origins save): Eclipse binary save — `DAS ` signature, `version==1`, length-prefixed strings +
tagged blocks. **Not KotOR** — reference serializers live under **Andastra** `Game/Games/Eclipse/...` on GitHub (`meta.xref`), not `Runtime/...`.

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408">xoreos — `GameID` (`kGameIDDragonAge` = 7)</a>
@see <a href="https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAgeOrigins/Save/DragonAgeOriginsSaveSerializer.cs#L23-L180">Andastra — `DragonAgeOriginsSaveSerializer` (signature + nfo + archive entrypoints)</a>
@see <a href="https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126">Andastra — `EclipseSaveSerializer` string + metadata helpers</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (DAO saves via Andastra; no DAS-specific PDF here)</a>
]##
proc read*(_: typedesc[Das], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Das =
  template this: untyped = result
  this = new(Das)
  let root = if root == nil: cast[Das](this) else: cast[Das](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File signature. Must be "DAS " for Dragon Age: Origins save files.

  ]##
  let signatureExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.signature = signatureExpr

  ##[
  Save format version. Must be 1 for Dragon Age: Origins.

  ]##
  let versionExpr = this.io.readS4le()
  this.version = versionExpr

  ##[
  User-entered save name displayed in UI
  ]##
  let saveNameExpr = Das_LengthPrefixedString.read(this.io, this.root, this)
  this.saveName = saveNameExpr

  ##[
  Current module resource name
  ]##
  let moduleNameExpr = Das_LengthPrefixedString.read(this.io, this.root, this)
  this.moduleName = moduleNameExpr

  ##[
  Current area name for display
  ]##
  let areaNameExpr = Das_LengthPrefixedString.read(this.io, this.root, this)
  this.areaName = areaNameExpr

  ##[
  Total play time in seconds
  ]##
  let timePlayedSecondsExpr = this.io.readS4le()
  this.timePlayedSeconds = timePlayedSecondsExpr

  ##[
  Save creation timestamp as Windows FILETIME (int64).
Convert using DateTime.FromFileTime().

  ]##
  let timestampFiletimeExpr = this.io.readS8le()
  this.timestampFiletime = timestampFiletimeExpr

  ##[
  Length of screenshot data in bytes (0 if no screenshot)
  ]##
  let numScreenshotDataExpr = this.io.readS4le()
  this.numScreenshotData = numScreenshotDataExpr

  ##[
  Screenshot image data (typically TGA or DDS format)
  ]##
  if this.numScreenshotData > 0:
    for i in 0 ..< int(this.numScreenshotData):
      let it = this.io.readU1()
      this.screenshotData.add(it)

  ##[
  Length of portrait data in bytes (0 if no portrait)
  ]##
  let numPortraitDataExpr = this.io.readS4le()
  this.numPortraitData = numPortraitDataExpr

  ##[
  Portrait image data (typically TGA or DDS format)
  ]##
  if this.numPortraitData > 0:
    for i in 0 ..< int(this.numPortraitData):
      let it = this.io.readU1()
      this.portraitData.add(it)

  ##[
  Player character name
  ]##
  let playerNameExpr = Das_LengthPrefixedString.read(this.io, this.root, this)
  this.playerName = playerNameExpr

  ##[
  Number of party members (from PartyState)
  ]##
  let partyMemberCountExpr = this.io.readS4le()
  this.partyMemberCount = partyMemberCountExpr

  ##[
  Player character level (from PartyState.PlayerCharacter)
  ]##
  let playerLevelExpr = this.io.readS4le()
  this.playerLevel = playerLevelExpr

proc fromFile*(_: typedesc[Das], filename: string): Das =
  Das.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Das_LengthPrefixedString], io: KaitaiStream, root: KaitaiStruct, parent: Das): Das_LengthPrefixedString =
  template this: untyped = result
  this = new(Das_LengthPrefixedString)
  let root = if root == nil: cast[Das](this) else: cast[Das](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  String length in bytes (UTF-8 encoding).
Must be >= 0 and <= 65536 (sanity check).

  ]##
  let lengthExpr = this.io.readS4le()
  this.length = lengthExpr

  ##[
  String value (UTF-8 encoded)
  ]##
  let valueExpr = encode(this.io.readBytes(int(this.length)).bytesTerminate(0, false), "UTF-8")
  this.value = valueExpr

proc valueTrimmed(this: Das_LengthPrefixedString): string = 

  ##[
  String value.
Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.

  ]##
  if this.valueTrimmedInstFlag:
    return this.valueTrimmedInst
  let valueTrimmedInstExpr = string(this.value)
  this.valueTrimmedInst = valueTrimmedInstExpr
  this.valueTrimmedInstFlag = true
  return this.valueTrimmedInst

proc fromFile*(_: typedesc[Das_LengthPrefixedString], filename: string): Das_LengthPrefixedString =
  Das_LengthPrefixedString.read(newKaitaiFileStream(filename), nil, nil)

