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
 * 
 * **reone:** not applicable for GDA wire ingestion on the KotOR fork (`meta.xref.reone_gda_consumer_note`).
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305|xoreos — `GDAFile::load`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L87-L93|xoreos — `GFF4File` stream ctor (type dispatch)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4fields.h#L1230-L1260|xoreos — G2DA column field ids (excerpt)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L136-L140|xoreos — `TwoDAFile(const GDAFile &)`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L343-L400|xoreos — `TwoDAFile::load(const GDAFile &)`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86|xoreos-tools — `main`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159|xoreos-tools — `get2DAGDA`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L167-L181|xoreos-tools — multi-file `GDAFile` merge}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L1466-L1472|PyKotor — `ResourceType.GDA`}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf|xoreos-docs — GFF_Format.pdf (GFF4 family; G2DA container)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf|xoreos-docs — CommonGFFStructs.pdf}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf|xoreos-docs — 2DA_Format.pdf (classic `.2da`; contrast with GDA)}
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
