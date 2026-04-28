import kaitai_struct_nim_runtime
import options

type
  BiowareExtractCommon* = ref object of KaitaiStruct
    `parent`*: KaitaiStruct
  BiowareExtractCommon_BiowareSearchLocationId* = enum
    override = 0
    modules = 1
    chitin = 2
    textures_tpa = 3
    textures_tpb = 4
    textures_tpc = 5
    textures_gui = 6
    music = 7
    sound = 8
    voice = 9
    lips = 10
    rims = 11
    custom_modules = 12
    custom_folders = 13
  BiowareExtractCommon_BiowareTexturePackNameStr* = ref object of KaitaiStruct
    `value`*: string
    `parent`*: KaitaiStruct

proc read*(_: typedesc[BiowareExtractCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareExtractCommon
proc read*(_: typedesc[BiowareExtractCommon_BiowareTexturePackNameStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareExtractCommon_BiowareTexturePackNameStr



##[
Enums and small helper types used by installation/extraction tooling.

References:
- https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/installation.py

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60">xoreos — `FileType` enum start (Aurora resource type IDs; no dedicated extraction-layout parser — this `.ksy` is tooling-side)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py#L67-L122">PyKotor — `SearchLocation` / `TexturePackNames` (maps to enums in this `.ksy`)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py">PyKotor — installation / search helpers (full module)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/">PyKotor — `extract/` package</a>
@see <a href="https://github.com/OldRepublicDevs/Andastra/blob/master/src/andastra/parsing/extract/installation.cs">Andastra — Eclipse extraction/installation model</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (tooling enums; no extraction-specific PDF)</a>
]##
proc read*(_: typedesc[BiowareExtractCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareExtractCommon =
  template this: untyped = result
  this = new(BiowareExtractCommon)
  let root = if root == nil: cast[BiowareExtractCommon](this) else: cast[BiowareExtractCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


proc fromFile*(_: typedesc[BiowareExtractCommon], filename: string): BiowareExtractCommon =
  BiowareExtractCommon.read(newKaitaiFileStream(filename), nil, nil)


##[
String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
]##
proc read*(_: typedesc[BiowareExtractCommon_BiowareTexturePackNameStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareExtractCommon_BiowareTexturePackNameStr =
  template this: untyped = result
  this = new(BiowareExtractCommon_BiowareTexturePackNameStr)
  let root = if root == nil: cast[BiowareExtractCommon](this) else: cast[BiowareExtractCommon](root)
  this.io = io
  this.root = root
  this.parent = parent

  let valueExpr = encode(this.io.readBytesTerm(0, false, true, true), "ASCII")
  this.value = valueExpr

proc fromFile*(_: typedesc[BiowareExtractCommon_BiowareTexturePackNameStr], filename: string): BiowareExtractCommon_BiowareTexturePackNameStr =
  BiowareExtractCommon_BiowareTexturePackNameStr.read(newKaitaiFileStream(filename), nil, nil)

