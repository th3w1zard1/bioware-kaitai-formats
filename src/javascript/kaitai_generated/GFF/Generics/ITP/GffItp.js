// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './Gff'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./Gff'));
  } else {
    factory(root.GffItp || (root.GffItp = {}), root.KaitaiStream, root.Gff || (root.Gff = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (GffItp_, KaitaiStream, Gff_) {
/**
 * **ITP** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
 * `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
 * `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.
 * 
 * FileType / restype id **2030** — see `bioware_type_ids::xoreos_file_type_id` enum member `itp`.
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63|xoreos — GFF3 header read}
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format|PyKotor wiki — GFF binary}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf|xoreos-docs — GFF_Format.pdf (GFF3 wire)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf|xoreos-docs — CommonGFFStructs.pdf}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs PDF tree}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49|xoreos-docs — Torlack ITP / MultiMap (GFF-family context)}
 */

var GffItp = (function() {
  function GffItp(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  GffItp.prototype._read = function() {
    this.contents = new Gff_.Gff.GffUnionFile(this._io, null, null);
  }

  /**
   * Full GFF3/GFF4 union (see `GFF.ksy`); interpret struct labels per ITP template docs / PyKotor `gff_auto`.
   */

  return GffItp;
})();
GffItp_.GffItp = GffItp;
});
