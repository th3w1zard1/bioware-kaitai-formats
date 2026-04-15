import kaitai_struct_nim_runtime
import options
import tpc

type
  Txb2* = ref object of KaitaiStruct
    `header`*: Tpc_TpcHeader
    `body`*: seq[byte]
    `parent`*: KaitaiStruct

proc read*(_: typedesc[Txb2], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Txb2



##[
**TXB2** (`kFileTypeTXB2` **3017**): second-generation TXB id in `types.h`; treated like **TXB** / **TPC** by engine
texture stacks. This capsule mirrors `TXB.ksy` (TPC header + opaque tail) until a divergent wire is proven.

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192">xoreos — `kFileTypeTXB2`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66">xoreos — `TPC::load` (texture family)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68">xoreos-tools — `TPC::load`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224">xoreos-tools — `TPC::readHeader`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture pipeline context)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — texture family</a>
]##
proc read*(_: typedesc[Txb2], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Txb2 =
  template this: untyped = result
  this = new(Txb2)
  let root = if root == nil: cast[Txb2](this) else: cast[Txb2](root)
  this.io = io
  this.root = root
  this.parent = parent

  let headerExpr = Tpc_TpcHeader.read(this.io, nil, nil)
  this.header = headerExpr
  let bodyExpr = this.io.readBytesFull()
  this.body = bodyExpr

proc fromFile*(_: typedesc[Txb2], filename: string): Txb2 =
  Txb2.read(newKaitaiFileStream(filename), nil, nil)

