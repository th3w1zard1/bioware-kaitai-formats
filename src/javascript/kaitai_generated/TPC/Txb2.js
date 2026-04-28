// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './Tpc'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./Tpc'));
  } else {
    factory(root.Txb2 || (root.Txb2 = {}), root.KaitaiStream, root.Tpc || (root.Tpc = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Txb2_, KaitaiStream, Tpc_) {
/**
 * **TXB2** (`kFileTypeTXB2` **3017**): second-generation TXB id in `types.h`; treated like **TXB** / **TPC** by engine
 * texture stacks. This capsule mirrors `TXB.ksy` (TPC header + opaque tail) until a divergent wire is proven.
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192|xoreos — `kFileTypeTXB2`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66|xoreos — `TPC::load` (texture family)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68|xoreos-tools — `TPC::load`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224|xoreos-tools — `TPC::readHeader`}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs PDF tree}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html|xoreos-docs — KotOR MDL overview (texture pipeline context)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc|PyKotor wiki — texture family}
 */

var Txb2 = (function() {
  function Txb2(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Txb2.prototype._read = function() {
    this.header = new Tpc_.Tpc.TpcHeader(this._io, null, null);
    this.body = this._io.readBytesFull();
  }

  return Txb2;
})();
Txb2_.Txb2 = Txb2;
});
