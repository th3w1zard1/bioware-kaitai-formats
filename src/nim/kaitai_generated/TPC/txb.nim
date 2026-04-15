import kaitai_struct_nim_runtime
import options
import tpc

type
  Txb* = ref object of KaitaiStruct
    `header`*: Tpc_TpcHeader
    `body`*: seq[byte]
    `parent`*: KaitaiStruct

proc read*(_: typedesc[Txb], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Txb



##[
**TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
(PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.

This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
variant diverges, split a dedicated header type and cite Ghidra / binary evidence (`TODO: VERIFY`).

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182">xoreos — `kFileTypeTXB`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66">xoreos — `TPC::load` (texture family)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68">xoreos-tools — `TPC::load`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224">xoreos-tools — `TPC::readHeader`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture pipeline context)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — texture family (cross-check TXB)</a>
]##
proc read*(_: typedesc[Txb], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Txb =
  template this: untyped = result
  this = new(Txb)
  let root = if root == nil: cast[Txb](this) else: cast[Txb](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
  ]##
  let headerExpr = Tpc_TpcHeader.read(this.io, nil, nil)
  this.header = headerExpr

  ##[
  Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.
  ]##
  let bodyExpr = this.io.readBytesFull()
  this.body = bodyExpr

proc fromFile*(_: typedesc[Txb], filename: string): Txb =
  Txb.read(newKaitaiFileStream(filename), nil, nil)

