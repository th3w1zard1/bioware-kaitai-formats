// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.BiowareTslpatcherCommon || (root.BiowareTslpatcherCommon = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (BiowareTslpatcherCommon_, KaitaiStream) {
/**
 * Shared enums and small helper types used by TSLPatcher-style tooling.
 * 
 * Notes:
 * - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
 *   so string-valued enums are modeled here as small string wrapper types with `valid` constraints.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60|xoreos — `FileType` enum start (engine archive IDs; TSLPatcher enums here are community patch metadata, not read from `swkotor.exe`)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/patcher.py#L43-L120|PyKotor — `ModInstaller` (apply / backup entry band)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/memory.py#L1-L80|PyKotor — `memory` (patch address space / token helpers)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/tslpatcher/|PyKotor — `tslpatcher/` package}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py|PyKotor — TwoDA patch helpers}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py|PyKotor — NCS patch helpers}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py|PyKotor — TSLPatcher logging}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py|PyKotor — diff resource objects}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs tree (TSLPatcher metadata; no dedicated PDF)}
 */

var BiowareTslpatcherCommon = (function() {
  BiowareTslpatcherCommon.BiowareTslpatcherLogTypeId = Object.freeze({
    VERBOSE: 0,
    NOTE: 1,
    WARNING: 2,
    ERROR: 3,

    0: "VERBOSE",
    1: "NOTE",
    2: "WARNING",
    3: "ERROR",
  });

  BiowareTslpatcherCommon.BiowareTslpatcherTargetTypeId = Object.freeze({
    ROW_INDEX: 0,
    ROW_LABEL: 1,
    LABEL_COLUMN: 2,

    0: "ROW_INDEX",
    1: "ROW_LABEL",
    2: "LABEL_COLUMN",
  });

  function BiowareTslpatcherCommon(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  BiowareTslpatcherCommon.prototype._read = function() {
  }

  /**
   * String-valued enum equivalent for DiffFormat (null-terminated ASCII).
   */

  var BiowareDiffFormatStr = BiowareTslpatcherCommon.BiowareDiffFormatStr = (function() {
    function BiowareDiffFormatStr(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareDiffFormatStr.prototype._read = function() {
      this.value = KaitaiStream.bytesToStr(this._io.readBytesTerm(0, false, true, true), "ASCII");
      if (!( ((this.value == "default") || (this.value == "unified") || (this.value == "context") || (this.value == "side_by_side")) )) {
        throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_diff_format_str/seq/0");
      }
    }

    return BiowareDiffFormatStr;
  })();

  /**
   * String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
   */

  var BiowareDiffResourceTypeStr = BiowareTslpatcherCommon.BiowareDiffResourceTypeStr = (function() {
    function BiowareDiffResourceTypeStr(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareDiffResourceTypeStr.prototype._read = function() {
      this.value = KaitaiStream.bytesToStr(this._io.readBytesTerm(0, false, true, true), "ASCII");
      if (!( ((this.value == "gff") || (this.value == "2da") || (this.value == "tlk") || (this.value == "lip") || (this.value == "bytes")) )) {
        throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_diff_resource_type_str/seq/0");
      }
    }

    return BiowareDiffResourceTypeStr;
  })();

  /**
   * String-valued enum equivalent for DiffType (null-terminated ASCII).
   */

  var BiowareDiffTypeStr = BiowareTslpatcherCommon.BiowareDiffTypeStr = (function() {
    function BiowareDiffTypeStr(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareDiffTypeStr.prototype._read = function() {
      this.value = KaitaiStream.bytesToStr(this._io.readBytesTerm(0, false, true, true), "ASCII");
      if (!( ((this.value == "identical") || (this.value == "modified") || (this.value == "added") || (this.value == "removed") || (this.value == "error")) )) {
        throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_diff_type_str/seq/0");
      }
    }

    return BiowareDiffTypeStr;
  })();

  /**
   * String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
   */

  var BiowareNcsTokenTypeStr = BiowareTslpatcherCommon.BiowareNcsTokenTypeStr = (function() {
    function BiowareNcsTokenTypeStr(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareNcsTokenTypeStr.prototype._read = function() {
      this.value = KaitaiStream.bytesToStr(this._io.readBytesTerm(0, false, true, true), "ASCII");
      if (!( ((this.value == "strref") || (this.value == "strref32") || (this.value == "2damemory") || (this.value == "2damemory32") || (this.value == "uint32") || (this.value == "uint16") || (this.value == "uint8")) )) {
        throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_ncs_token_type_str/seq/0");
      }
    }

    return BiowareNcsTokenTypeStr;
  })();

  return BiowareTslpatcherCommon;
})();
BiowareTslpatcherCommon_.BiowareTslpatcherCommon = BiowareTslpatcherCommon;
});
