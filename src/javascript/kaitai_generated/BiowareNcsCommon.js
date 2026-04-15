// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.BiowareNcsCommon || (root.BiowareNcsCommon = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (BiowareNcsCommon_, KaitaiStream) {
/**
 * Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).
 * 
 * - `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
 *   (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
 * - `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
 *   decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
 * - `ncs_program_size_marker` is the fixed header byte after `"V1.0"` in retail KotOR NCS blobs (`0x42`).
 * 
 * **Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
 * duplicating opcode lists.
 */

var BiowareNcsCommon = (function() {
  BiowareNcsCommon.NcsBytecode = Object.freeze({
    RESERVED_BC: 0,
    CPDOWNSP: 1,
    RSADDX: 2,
    CPTOPSP: 3,
    CONSTX: 4,
    ACTION: 5,
    LOGANDXX: 6,
    LOGORXX: 7,
    INCORXX: 8,
    EXCORXX: 9,
    BOOLANDXX: 10,
    EQUALXX: 11,
    NEQUALXX: 12,
    GEQXX: 13,
    GTXX: 14,
    LTXX: 15,
    LEQXX: 16,
    SHLEFTXX: 17,
    SHRIGHTXX: 18,
    USHRIGHTXX: 19,
    ADDXX: 20,
    SUBXX: 21,
    MULXX: 22,
    DIVXX: 23,
    MODXX: 24,
    NEGX: 25,
    COMPX: 26,
    MOVSP: 27,
    UNUSED_GAP: 28,
    JMP: 29,
    JSR: 30,
    JZ: 31,
    RETN: 32,
    DESTRUCT: 33,
    NOTX: 34,
    DECXSP: 35,
    INCXSP: 36,
    JNZ: 37,
    CPDOWNBP: 38,
    CPTOPBP: 39,
    DECXBP: 40,
    INCXBP: 41,
    SAVEBP: 42,
    RESTOREBP: 43,
    STORE_STATE: 44,
    NOP: 45,

    0: "RESERVED_BC",
    1: "CPDOWNSP",
    2: "RSADDX",
    3: "CPTOPSP",
    4: "CONSTX",
    5: "ACTION",
    6: "LOGANDXX",
    7: "LOGORXX",
    8: "INCORXX",
    9: "EXCORXX",
    10: "BOOLANDXX",
    11: "EQUALXX",
    12: "NEQUALXX",
    13: "GEQXX",
    14: "GTXX",
    15: "LTXX",
    16: "LEQXX",
    17: "SHLEFTXX",
    18: "SHRIGHTXX",
    19: "USHRIGHTXX",
    20: "ADDXX",
    21: "SUBXX",
    22: "MULXX",
    23: "DIVXX",
    24: "MODXX",
    25: "NEGX",
    26: "COMPX",
    27: "MOVSP",
    28: "UNUSED_GAP",
    29: "JMP",
    30: "JSR",
    31: "JZ",
    32: "RETN",
    33: "DESTRUCT",
    34: "NOTX",
    35: "DECXSP",
    36: "INCXSP",
    37: "JNZ",
    38: "CPDOWNBP",
    39: "CPTOPBP",
    40: "DECXBP",
    41: "INCXBP",
    42: "SAVEBP",
    43: "RESTOREBP",
    44: "STORE_STATE",
    45: "NOP",
  });

  BiowareNcsCommon.NcsInstructionQualifier = Object.freeze({
    NONE: 0,
    UNARY_OPERAND_LAYOUT: 1,
    INT_TYPE: 3,
    FLOAT_TYPE: 4,
    STRING_TYPE: 5,
    OBJECT_TYPE: 6,
    EFFECT_TYPE: 16,
    EVENT_TYPE: 17,
    LOCATION_TYPE: 18,
    TALENT_TYPE: 19,
    INT_INT: 32,
    FLOAT_FLOAT: 33,
    OBJECT_OBJECT: 34,
    STRING_STRING: 35,
    STRUCT_STRUCT: 36,
    INT_FLOAT: 37,
    FLOAT_INT: 38,
    EFFECT_EFFECT: 48,
    EVENT_EVENT: 49,
    LOCATION_LOCATION: 50,
    TALENT_TALENT: 51,
    VECTOR_VECTOR: 58,
    VECTOR_FLOAT: 59,
    FLOAT_VECTOR: 60,

    0: "NONE",
    1: "UNARY_OPERAND_LAYOUT",
    3: "INT_TYPE",
    4: "FLOAT_TYPE",
    5: "STRING_TYPE",
    6: "OBJECT_TYPE",
    16: "EFFECT_TYPE",
    17: "EVENT_TYPE",
    18: "LOCATION_TYPE",
    19: "TALENT_TYPE",
    32: "INT_INT",
    33: "FLOAT_FLOAT",
    34: "OBJECT_OBJECT",
    35: "STRING_STRING",
    36: "STRUCT_STRUCT",
    37: "INT_FLOAT",
    38: "FLOAT_INT",
    48: "EFFECT_EFFECT",
    49: "EVENT_EVENT",
    50: "LOCATION_LOCATION",
    51: "TALENT_TALENT",
    58: "VECTOR_VECTOR",
    59: "VECTOR_FLOAT",
    60: "FLOAT_VECTOR",
  });

  BiowareNcsCommon.NcsProgramSizeMarker = Object.freeze({
    PROGRAM_SIZE_PREFIX: 66,

    66: "PROGRAM_SIZE_PREFIX",
  });

  function BiowareNcsCommon(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  BiowareNcsCommon.prototype._read = function() {
  }

  return BiowareNcsCommon;
})();
BiowareNcsCommon_.BiowareNcsCommon = BiowareNcsCommon;
});
