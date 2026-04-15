// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Bzf || (root.Bzf = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Bzf_, KaitaiStream) {
/**
 * **BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
 * mobile KotOR ports.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression|PyKotor wiki — BZF (LZMA BIF)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L26-L54|PyKotor — `_decompress_bzf_payload`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/bzffile.cpp#L41-L83|xoreos — `kBZFID` quirk + `BZFFile::load`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L207|xoreos-tools — `.bzf` → `BZFFile`}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf|xoreos-docs — KeyBIF_Format.pdf}
 */

var Bzf = (function() {
  function Bzf(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Bzf.prototype._read = function() {
    this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.fileType == "BZF ")) {
      throw new KaitaiStream.ValidationNotEqualError("BZF ", this.fileType, this._io, "/seq/0");
    }
    this.version = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.version == "V1.0")) {
      throw new KaitaiStream.ValidationNotEqualError("V1.0", this.version, this._io, "/seq/1");
    }
    this.compressedData = this._io.readBytesFull();
  }

  /**
   * File type signature. Must be "BZF " for compressed BIF files.
   */

  /**
   * File format version. Always "V1.0" for BZF files.
   */

  /**
   * LZMA-compressed BIF file data (single blob to EOF).
   * Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).
   */

  return Bzf;
})();
Bzf_.Bzf = Bzf;
});
