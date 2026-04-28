// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './Tpc'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./Tpc'));
  } else {
    factory(root.Txb || (root.Txb = {}), root.KaitaiStream, root.Tpc || (root.Tpc = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Txb_, KaitaiStream, Tpc_) {
/**
 * **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
 * (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.
 * 
 * This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
 * variant diverges, split a dedicated header type and cite **observed behavior** / tooling evidence (`TODO: VERIFY`).
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182|xoreos — `kFileTypeTXB`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66|xoreos — `TPC::load` (texture family)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68|xoreos-tools — `TPC::load`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224|xoreos-tools — `TPC::readHeader`}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs PDF tree}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html|xoreos-docs — KotOR MDL overview (texture pipeline context)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc|PyKotor wiki — texture family (cross-check TXB)}
 */

var Txb = (function() {
  function Txb(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Txb.prototype._read = function() {
    this.header = new Tpc_.Tpc.TpcHeader(this._io, null, null);
    this.body = this._io.readBytesFull();
  }

  /**
   * Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
   */

  /**
   * Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.
   */

  return Txb;
})();
Txb_.Txb = Txb;
});
