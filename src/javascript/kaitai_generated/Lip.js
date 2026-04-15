// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareCommon'));
  } else {
    factory(root.Lip || (root.Lip = {}), root.KaitaiStream, root.BiowareCommon || (root.BiowareCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Lip_, KaitaiStream, BiowareCommon_) {
/**
 * **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
 * `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
 * 
 * xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip|PyKotor wiki — LIP}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L42|reone — LIPReader}
 */

var Lip = (function() {
  function Lip(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Lip.prototype._read = function() {
    this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    this.length = this._io.readF4le();
    this.numKeyframes = this._io.readU4le();
    this.keyframes = [];
    for (var i = 0; i < this.numKeyframes; i++) {
      this.keyframes.push(new KeyframeEntry(this._io, this, this._root));
    }
  }

  /**
   * A single keyframe entry mapping a timestamp to a viseme (mouth shape).
   * Keyframes are used by the engine to interpolate between mouth shapes during
   * audio playback to create lip sync animation.
   */

  var KeyframeEntry = Lip.KeyframeEntry = (function() {
    function KeyframeEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    KeyframeEntry.prototype._read = function() {
      this.timestamp = this._io.readF4le();
      this.shape = this._io.readU1();
    }

    /**
     * Seconds from animation start. Must be >= 0 and <= length.
     * Keyframes should be sorted ascending by timestamp.
     */

    /**
     * Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
     * `bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).
     */

    return KeyframeEntry;
  })();

  /**
   * File type signature. Must be "LIP " (space-padded) for LIP files.
   */

  /**
   * File format version. Must be "V1.0" for LIP files.
   */

  /**
   * Duration in seconds. Must equal the paired WAV file playback time for
   * glitch-free animation. This is the total length of the lip sync animation.
   */

  /**
   * Number of keyframes immediately following. Each keyframe contains a timestamp
   * and a viseme shape index. Keyframes should be sorted ascending by timestamp.
   */

  /**
   * Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
   * Entries must be stored in chronological order (ascending by timestamp).
   */

  return Lip;
})();
Lip_.Lip = Lip;
});
