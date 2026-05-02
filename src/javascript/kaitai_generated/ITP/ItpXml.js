// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.ItpXml || (root.ItpXml = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (ItpXml_, KaitaiStream) {
/**
 * ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
 * ITP files use GFF format (FileType "ITP " in GFF header).
 * Uses GFF XML structure with root element <gff3> containing <struct> elements.
 * Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).
 * 
 * Canonical links: `meta.doc-ref` and `meta.xref`.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format|PyKotor wiki — GFF (ITP is GFF-shaped)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63|xoreos — `GFF3File::readHeader`}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225|reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf|xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49|xoreos-docs — Torlack ITP / MultiMap (GFF-family context)}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs PDF tree}
 */

var ItpXml = (function() {
  function ItpXml(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  ItpXml.prototype._read = function() {
    this.xmlContent = KaitaiStream.bytesToStr(this._io.readBytesFull(), "UTF-8");
  }

  /**
   * XML document content as UTF-8 text
   */

  return ItpXml;
})();
ItpXml_.ItpXml = ItpXml;
});
