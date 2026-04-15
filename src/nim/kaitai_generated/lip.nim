import kaitai_struct_nim_runtime
import options
import bioware_common

type
  Lip* = ref object of KaitaiStruct
    `fileType`*: string
    `fileVersion`*: string
    `length`*: float32
    `numKeyframes`*: uint32
    `keyframes`*: seq[Lip_KeyframeEntry]
    `parent`*: KaitaiStruct
  Lip_KeyframeEntry* = ref object of KaitaiStruct
    `timestamp`*: float32
    `shape`*: BiowareCommon_BiowareLipVisemeId
    `parent`*: Lip

proc read*(_: typedesc[Lip], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Lip
proc read*(_: typedesc[Lip_KeyframeEntry], io: KaitaiStream, root: KaitaiStruct, parent: Lip): Lip_KeyframeEntry



##[
**LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
`bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.

xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip">PyKotor wiki — LIP</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L42">reone — LIPReader</a>
]##
proc read*(_: typedesc[Lip], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Lip =
  template this: untyped = result
  this = new(Lip)
  let root = if root == nil: cast[Lip](this) else: cast[Lip](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "LIP " (space-padded) for LIP files.
  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Must be "V1.0" for LIP files.
  ]##
  let fileVersionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileVersion = fileVersionExpr

  ##[
  Duration in seconds. Must equal the paired WAV file playback time for
glitch-free animation. This is the total length of the lip sync animation.

  ]##
  let lengthExpr = this.io.readF4le()
  this.length = lengthExpr

  ##[
  Number of keyframes immediately following. Each keyframe contains a timestamp
and a viseme shape index. Keyframes should be sorted ascending by timestamp.

  ]##
  let numKeyframesExpr = this.io.readU4le()
  this.numKeyframes = numKeyframesExpr

  ##[
  Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
Entries must be stored in chronological order (ascending by timestamp).

  ]##
  for i in 0 ..< int(this.numKeyframes):
    let it = Lip_KeyframeEntry.read(this.io, this.root, this)
    this.keyframes.add(it)

proc fromFile*(_: typedesc[Lip], filename: string): Lip =
  Lip.read(newKaitaiFileStream(filename), nil, nil)


##[
A single keyframe entry mapping a timestamp to a viseme (mouth shape).
Keyframes are used by the engine to interpolate between mouth shapes during
audio playback to create lip sync animation.

]##
proc read*(_: typedesc[Lip_KeyframeEntry], io: KaitaiStream, root: KaitaiStruct, parent: Lip): Lip_KeyframeEntry =
  template this: untyped = result
  this = new(Lip_KeyframeEntry)
  let root = if root == nil: cast[Lip](this) else: cast[Lip](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Seconds from animation start. Must be >= 0 and <= length.
Keyframes should be sorted ascending by timestamp.

  ]##
  let timestampExpr = this.io.readF4le()
  this.timestamp = timestampExpr

  ##[
  Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
`bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).

  ]##
  let shapeExpr = BiowareCommon_BiowareLipVisemeId(this.io.readU1())
  this.shape = shapeExpr

proc fromFile*(_: typedesc[Lip_KeyframeEntry], filename: string): Lip_KeyframeEntry =
  Lip_KeyframeEntry.read(newKaitaiFileStream(filename), nil, nil)

