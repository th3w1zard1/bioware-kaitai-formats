// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.BiowareGffCommon || (root.BiowareGffCommon = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (BiowareGffCommon_, KaitaiStream) {
/**
 * Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).
 * 
 * Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
 * (PyKotor / reone / wiki line anchors; `GFF.ksy` for per-field **observed behavior**.)
 * 
 * **GFF4** uses a different container/struct layout on disk (`GFF4File::Header::read` in `meta.xref.xoreos_gff4file_header_read`);
 * this enum remains the **GFF3** field-type table unless a future split spec proves wire-identical IDs across both.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types|PyKotor wiki — GFF data types}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367|PyKotor — `GFFFieldType` enum}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L197-L273|PyKotor — field read dispatch}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63|xoreos — `GFF3File::readHeader`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L59-L82|xoreos — `GFF4File::Header::read` (GFF4 container; distinct from GFF3 field tags above)}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225|reone — `GffReader`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176|xoreos-tools — `gffdumper` (identify / dump)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60|xoreos-tools — `gffcreator` (create)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf|xoreos-docs — GFF_Format.pdf}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf|xoreos-docs — CommonGFFStructs.pdf}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs PDF tree}
 */

var BiowareGffCommon = (function() {
  BiowareGffCommon.GffFieldType = Object.freeze({
    UINT8: 0,
    INT8: 1,
    UINT16: 2,
    INT16: 3,
    UINT32: 4,
    INT32: 5,
    UINT64: 6,
    INT64: 7,
    SINGLE: 8,
    DOUBLE: 9,
    STRING: 10,
    RESREF: 11,
    LOCALIZED_STRING: 12,
    BINARY: 13,
    STRUCT: 14,
    LIST: 15,
    VECTOR4: 16,
    VECTOR3: 17,
    STR_REF: 18,

    0: "UINT8",
    1: "INT8",
    2: "UINT16",
    3: "INT16",
    4: "UINT32",
    5: "INT32",
    6: "UINT64",
    7: "INT64",
    8: "SINGLE",
    9: "DOUBLE",
    10: "STRING",
    11: "RESREF",
    12: "LOCALIZED_STRING",
    13: "BINARY",
    14: "STRUCT",
    15: "LIST",
    16: "VECTOR4",
    17: "VECTOR3",
    18: "STR_REF",
  });

  function BiowareGffCommon(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  BiowareGffCommon.prototype._read = function() {
  }

  return BiowareGffCommon;
})();
BiowareGffCommon_.BiowareGffCommon = BiowareGffCommon;
});
