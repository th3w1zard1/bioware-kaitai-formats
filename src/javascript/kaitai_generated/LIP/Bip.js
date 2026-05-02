// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Bip || (root.Bip = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Bip_, KaitaiStream) {
/**
 * **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
 * framed wire lives in `LIP.ksy`.
 * 
 * **TODO: VERIFY** full BIP layout against a KotOR PC build and PyKotor; until then this spec
 * exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198|xoreos — `kFileTypeBIP`}
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip|PyKotor wiki — LIP family}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; verify wire with PyKotor / **observed behavior** on shipped builds when possible)}
 */

var Bip = (function() {
  function Bip(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Bip.prototype._read = function() {
    this.payload = this._io.readBytesFull();
  }

  /**
   * Opaque binary LIP payload — replace with structured fields after verification.
   */

  return Bip;
})();
Bip_.Bip = Bip;
});
