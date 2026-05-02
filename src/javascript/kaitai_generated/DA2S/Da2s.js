// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Da2s || (root.Da2s = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Da2s_, KaitaiStream) {
/**
 * **DA2S** (Dragon Age 2 save): Eclipse binary save — `DA2S` signature, `version==1`, length-prefixed strings + tagged
 * blocks (party/inventory/journal/etc.). **Not KotOR** — Andastra serializers under `Game/Games/Eclipse/DragonAge2/Save/` (`meta.xref`).
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408|xoreos — `GameID` (`kGameIDDragonAge2` = 8)}
 * @see {@link https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAge2/Save/DragonAge2SaveSerializer.cs#L24-L180|Andastra — `DragonAge2SaveSerializer`}
 * @see {@link https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126|Andastra — `EclipseSaveSerializer` helpers}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs tree (Dragon Age saves documented via Andastra + `GameID`; no DA2S-specific PDF here)}
 */

var Da2s = (function() {
  function Da2s(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Da2s.prototype._read = function() {
    this.signature = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.signature == "DA2S")) {
      throw new KaitaiStream.ValidationNotEqualError("DA2S", this.signature, this._io, "/seq/0");
    }
    this.version = this._io.readS4le();
    if (!(this.version == 1)) {
      throw new KaitaiStream.ValidationNotEqualError(1, this.version, this._io, "/seq/1");
    }
    this.saveName = new LengthPrefixedString(this._io, this, this._root);
    this.moduleName = new LengthPrefixedString(this._io, this, this._root);
    this.areaName = new LengthPrefixedString(this._io, this, this._root);
    this.timePlayedSeconds = this._io.readS4le();
    this.timestampFiletime = this._io.readS8le();
    this.numScreenshotData = this._io.readS4le();
    if (this.numScreenshotData > 0) {
      this.screenshotData = [];
      for (var i = 0; i < this.numScreenshotData; i++) {
        this.screenshotData.push(this._io.readU1());
      }
    }
    this.numPortraitData = this._io.readS4le();
    if (this.numPortraitData > 0) {
      this.portraitData = [];
      for (var i = 0; i < this.numPortraitData; i++) {
        this.portraitData.push(this._io.readU1());
      }
    }
    this.playerName = new LengthPrefixedString(this._io, this, this._root);
    this.partyMemberCount = this._io.readS4le();
    this.playerLevel = this._io.readS4le();
  }

  var LengthPrefixedString = Da2s.LengthPrefixedString = (function() {
    function LengthPrefixedString(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LengthPrefixedString.prototype._read = function() {
      this.length = this._io.readS4le();
      this.value = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(this.length), 0, false), "UTF-8");
    }

    /**
     * String value.
     * Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
     */
    Object.defineProperty(LengthPrefixedString.prototype, 'valueTrimmed', {
      get: function() {
        if (this._m_valueTrimmed !== undefined)
          return this._m_valueTrimmed;
        this._m_valueTrimmed = this.value;
        return this._m_valueTrimmed;
      }
    });

    /**
     * String length in bytes (UTF-8 encoding).
     * Must be >= 0 and <= 65536 (sanity check).
     */

    /**
     * String value (UTF-8 encoded)
     */

    return LengthPrefixedString;
  })();

  /**
   * File signature. Must be "DA2S" for Dragon Age 2 save files.
   */

  /**
   * Save format version. Must be 1 for Dragon Age 2.
   */

  /**
   * User-entered save name displayed in UI
   */

  /**
   * Current module resource name
   */

  /**
   * Current area name for display
   */

  /**
   * Total play time in seconds
   */

  /**
   * Save creation timestamp as Windows FILETIME (int64).
   * Convert using DateTime.FromFileTime().
   */

  /**
   * Length of screenshot data in bytes (0 if no screenshot)
   */

  /**
   * Screenshot image data (typically TGA or DDS format)
   */

  /**
   * Length of portrait data in bytes (0 if no portrait)
   */

  /**
   * Portrait image data (typically TGA or DDS format)
   */

  /**
   * Player character name
   */

  /**
   * Number of party members (from PartyState)
   */

  /**
   * Player character level (from PartyState.PlayerCharacter)
   */

  return Da2s;
})();
Da2s_.Da2s = Da2s;
});
