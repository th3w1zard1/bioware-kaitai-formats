import kaitai_struct_nim_runtime
import options

type
  BiowareTslpatcherCommon* = ref object of KaitaiStruct
    `parent`*: KaitaiStruct
  BiowareTslpatcherCommon_BiowareTslpatcherLogTypeId* = enum
    verbose = 0
    note = 1
    warning = 2
    error = 3
  BiowareTslpatcherCommon_BiowareTslpatcherTargetTypeId* = enum
    row_index = 0
    row_label = 1
    label_column = 2
  BiowareTslpatcherCommon_BiowareDiffFormatStr* = ref object of KaitaiStruct
    `value`*: string
    `parent`*: KaitaiStruct
  BiowareTslpatcherCommon_BiowareDiffResourceTypeStr* = ref object of KaitaiStruct
    `value`*: string
    `parent`*: KaitaiStruct
  BiowareTslpatcherCommon_BiowareDiffTypeStr* = ref object of KaitaiStruct
    `value`*: string
    `parent`*: KaitaiStruct
  BiowareTslpatcherCommon_BiowareNcsTokenTypeStr* = ref object of KaitaiStruct
    `value`*: string
    `parent`*: KaitaiStruct

proc read*(_: typedesc[BiowareTslpatcherCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon
proc read*(_: typedesc[BiowareTslpatcherCommon_BiowareDiffFormatStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon_BiowareDiffFormatStr
proc read*(_: typedesc[BiowareTslpatcherCommon_BiowareDiffResourceTypeStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon_BiowareDiffResourceTypeStr
proc read*(_: typedesc[BiowareTslpatcherCommon_BiowareDiffTypeStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon_BiowareDiffTypeStr
proc read*(_: typedesc[BiowareTslpatcherCommon_BiowareNcsTokenTypeStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon_BiowareNcsTokenTypeStr



##[
Shared enums and small helper types used by TSLPatcher-style tooling.

Notes:
- Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
  so string-valued enums are modeled here as small string wrapper types with `valid` constraints.

References:
- https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
- https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
- https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
- https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60">xoreos — `FileType` enum start (engine archive IDs; TSLPatcher enums here are community patch metadata, not read from `swkotor.exe`)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/patcher.py#L43-L120">PyKotor — `ModInstaller` (apply / backup entry band)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/memory.py#L1-L80">PyKotor — `memory` (patch address space / token helpers)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/tslpatcher/">PyKotor — `tslpatcher/` package</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py">PyKotor — TwoDA patch helpers</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py">PyKotor — NCS patch helpers</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py">PyKotor — TSLPatcher logging</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py">PyKotor — diff resource objects</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (TSLPatcher metadata; no dedicated PDF)</a>
]##
proc read*(_: typedesc[BiowareTslpatcherCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon =
  template this: untyped = result
  this = new(BiowareTslpatcherCommon)
  let root = if root == nil: cast[BiowareTslpatcherCommon](this) else: cast[BiowareTslpatcherCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


proc fromFile*(_: typedesc[BiowareTslpatcherCommon], filename: string): BiowareTslpatcherCommon =
  BiowareTslpatcherCommon.read(newKaitaiFileStream(filename), nil, nil)


##[
String-valued enum equivalent for DiffFormat (null-terminated ASCII).
]##
proc read*(_: typedesc[BiowareTslpatcherCommon_BiowareDiffFormatStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon_BiowareDiffFormatStr =
  template this: untyped = result
  this = new(BiowareTslpatcherCommon_BiowareDiffFormatStr)
  let root = if root == nil: cast[BiowareTslpatcherCommon](this) else: cast[BiowareTslpatcherCommon](root)
  this.io = io
  this.root = root
  this.parent = parent

  let valueExpr = encode(this.io.readBytesTerm(0, false, true, true), "ASCII")
  this.value = valueExpr

proc fromFile*(_: typedesc[BiowareTslpatcherCommon_BiowareDiffFormatStr], filename: string): BiowareTslpatcherCommon_BiowareDiffFormatStr =
  BiowareTslpatcherCommon_BiowareDiffFormatStr.read(newKaitaiFileStream(filename), nil, nil)


##[
String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
]##
proc read*(_: typedesc[BiowareTslpatcherCommon_BiowareDiffResourceTypeStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon_BiowareDiffResourceTypeStr =
  template this: untyped = result
  this = new(BiowareTslpatcherCommon_BiowareDiffResourceTypeStr)
  let root = if root == nil: cast[BiowareTslpatcherCommon](this) else: cast[BiowareTslpatcherCommon](root)
  this.io = io
  this.root = root
  this.parent = parent

  let valueExpr = encode(this.io.readBytesTerm(0, false, true, true), "ASCII")
  this.value = valueExpr

proc fromFile*(_: typedesc[BiowareTslpatcherCommon_BiowareDiffResourceTypeStr], filename: string): BiowareTslpatcherCommon_BiowareDiffResourceTypeStr =
  BiowareTslpatcherCommon_BiowareDiffResourceTypeStr.read(newKaitaiFileStream(filename), nil, nil)


##[
String-valued enum equivalent for DiffType (null-terminated ASCII).
]##
proc read*(_: typedesc[BiowareTslpatcherCommon_BiowareDiffTypeStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon_BiowareDiffTypeStr =
  template this: untyped = result
  this = new(BiowareTslpatcherCommon_BiowareDiffTypeStr)
  let root = if root == nil: cast[BiowareTslpatcherCommon](this) else: cast[BiowareTslpatcherCommon](root)
  this.io = io
  this.root = root
  this.parent = parent

  let valueExpr = encode(this.io.readBytesTerm(0, false, true, true), "ASCII")
  this.value = valueExpr

proc fromFile*(_: typedesc[BiowareTslpatcherCommon_BiowareDiffTypeStr], filename: string): BiowareTslpatcherCommon_BiowareDiffTypeStr =
  BiowareTslpatcherCommon_BiowareDiffTypeStr.read(newKaitaiFileStream(filename), nil, nil)


##[
String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
]##
proc read*(_: typedesc[BiowareTslpatcherCommon_BiowareNcsTokenTypeStr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareTslpatcherCommon_BiowareNcsTokenTypeStr =
  template this: untyped = result
  this = new(BiowareTslpatcherCommon_BiowareNcsTokenTypeStr)
  let root = if root == nil: cast[BiowareTslpatcherCommon](this) else: cast[BiowareTslpatcherCommon](root)
  this.io = io
  this.root = root
  this.parent = parent

  let valueExpr = encode(this.io.readBytesTerm(0, false, true, true), "ASCII")
  this.value = valueExpr

proc fromFile*(_: typedesc[BiowareTslpatcherCommon_BiowareNcsTokenTypeStr], filename: string): BiowareTslpatcherCommon_BiowareNcsTokenTypeStr =
  BiowareTslpatcherCommon_BiowareNcsTokenTypeStr.read(newKaitaiFileStream(filename), nil, nil)

