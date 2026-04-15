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
 * (Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).
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
