// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.BiowareExtractCommon || (root.BiowareExtractCommon = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (BiowareExtractCommon_, KaitaiStream) {
/**
 * Enums and small helper types used by installation/extraction tooling.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/installation.py
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60|xoreos — `FileType` enum start (Aurora resource type IDs; no dedicated extraction-layout parser — this `.ksy` is tooling-side)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py#L67-L122|PyKotor — `SearchLocation` / `TexturePackNames` (maps to enums in this `.ksy`)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py|PyKotor — installation / search helpers (full module)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/|PyKotor — `extract/` package}
 * @see {@link https://github.com/OldRepublicDevs/Andastra/blob/master/src/andastra/parsing/extract/installation.cs|Andastra — Eclipse extraction/installation model}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs tree (tooling enums; no extraction-specific PDF)}
 */

var BiowareExtractCommon = (function() {
  BiowareExtractCommon.BiowareSearchLocationId = Object.freeze({
    OVERRIDE: 0,
    MODULES: 1,
    CHITIN: 2,
    TEXTURES_TPA: 3,
    TEXTURES_TPB: 4,
    TEXTURES_TPC: 5,
    TEXTURES_GUI: 6,
    MUSIC: 7,
    SOUND: 8,
    VOICE: 9,
    LIPS: 10,
    RIMS: 11,
    CUSTOM_MODULES: 12,
    CUSTOM_FOLDERS: 13,

    0: "OVERRIDE",
    1: "MODULES",
    2: "CHITIN",
    3: "TEXTURES_TPA",
    4: "TEXTURES_TPB",
    5: "TEXTURES_TPC",
    6: "TEXTURES_GUI",
    7: "MUSIC",
    8: "SOUND",
    9: "VOICE",
    10: "LIPS",
    11: "RIMS",
    12: "CUSTOM_MODULES",
    13: "CUSTOM_FOLDERS",
  });

  function BiowareExtractCommon(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  BiowareExtractCommon.prototype._read = function() {
  }

  /**
   * String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
   */

  var BiowareTexturePackNameStr = BiowareExtractCommon.BiowareTexturePackNameStr = (function() {
    function BiowareTexturePackNameStr(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareTexturePackNameStr.prototype._read = function() {
      this.value = KaitaiStream.bytesToStr(this._io.readBytesTerm(0, false, true, true), "ASCII");
      if (!( ((this.value == "swpc_tex_tpa.erf") || (this.value == "swpc_tex_tpb.erf") || (this.value == "swpc_tex_tpc.erf") || (this.value == "swpc_tex_gui.erf")) )) {
        throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_texture_pack_name_str/seq/0");
      }
    }

    return BiowareTexturePackNameStr;
  })();

  return BiowareExtractCommon;
})();
BiowareExtractCommon_.BiowareExtractCommon = BiowareExtractCommon;
});
