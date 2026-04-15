// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Das || (root.Das = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Das_, KaitaiStream) {
/**
 * **DAS** (Dragon Age: Origins save): Eclipse binary save — `DAS ` signature, `version==1`, length-prefixed strings +
 * tagged blocks. **Not KotOR** — reference serializers live under **Andastra** `Game/Games/Eclipse/...` on GitHub (`meta.xref`), not `Runtime/...`.
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408|xoreos — `GameID` (`kGameIDDragonAge` = 7)}
 * @see {@link https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAgeOrigins/Save/DragonAgeOriginsSaveSerializer.cs#L23-L180|Andastra — `DragonAgeOriginsSaveSerializer` (signature + nfo + archive entrypoints)}
 * @see {@link https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126|Andastra — `EclipseSaveSerializer` string + metadata helpers}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs tree (DAO saves via Andastra; no DAS-specific PDF here)}
 */

var Das = (function() {
  function Das(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Das.prototype._read = function() {
    this.signature = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.signature == "DAS ")) {
      throw new KaitaiStream.ValidationNotEqualError("DAS ", this.signature, this._io, "/seq/0");
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

  var LengthPrefixedString = Das.LengthPrefixedString = (function() {
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
   * File signature. Must be "DAS " for Dragon Age: Origins save files.
   */

  /**
   * Save format version. Must be 1 for Dragon Age: Origins.
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

  return Das;
})();
Das_.Das = Das;
});
