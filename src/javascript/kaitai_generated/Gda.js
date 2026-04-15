// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './Gff'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./Gff'));
  } else {
    factory(root.Gda || (root.Gda = {}), root.KaitaiStream, root.Gff || (root.Gff = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Gda_, KaitaiStream, Gff_) {
/**
 * **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
 * (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
 * 
 * G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305|xoreos — GDAFile::load}
 */

var Gda = (function() {
  function Gda(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Gda.prototype._read = function() {
    this.asGff4 = new Gff_.Gff.Gff4File(this._io, null, null);
  }

  /**
   * On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
   * (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).
   */

  return Gda;
})();
Gda_.Gda = Gda;
});
