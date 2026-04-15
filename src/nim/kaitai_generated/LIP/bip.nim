import kaitai_struct_nim_runtime
import options

type
  Bip* = ref object of KaitaiStruct
    `payload`*: seq[byte]
    `parent`*: KaitaiStruct

proc read*(_: typedesc[Bip], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bip



##[
**BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
framed wire lives in `LIP.ksy`.

**TODO: VERIFY** full BIP layout against Odyssey Ghidra (`user-agdec-http`) and PyKotor; until then this spec
exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198">xoreos — `kFileTypeBIP`</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip">PyKotor wiki — LIP family</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; placeholder wire — verify in Ghidra)</a>
]##
proc read*(_: typedesc[Bip], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bip =
  template this: untyped = result
  this = new(Bip)
  let root = if root == nil: cast[Bip](this) else: cast[Bip](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Opaque binary LIP payload — replace with structured fields after verification.
  ]##
  let payloadExpr = this.io.readBytesFull()
  this.payload = payloadExpr

proc fromFile*(_: typedesc[Bip], filename: string): Bip =
  Bip.read(newKaitaiFileStream(filename), nil, nil)

