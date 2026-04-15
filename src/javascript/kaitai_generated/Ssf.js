// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Ssf || (root.Ssf = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Ssf_, KaitaiStream) {
/**
 * SSF (Sound Set File) files store sound string references (StrRefs) for character voice sets.
 * Each SSF file contains exactly 28 sound slots, mapping to different game events and actions.
 * 
 * Binary Format:
 * - Header (12 bytes): File type signature, version, and offset to sounds array (usually 12)
 * - Sounds Array (112 bytes at sounds_offset): 28 uint32 values representing StrRefs (0xFFFFFFFF = -1 = no sound)
 * 
 * Vanilla KotOR SSFs are typically 136 bytes total: after the 28 StrRefs, many files append 12 bytes
 * of 0xFFFFFFFF padding; that trailer is not part of the header and is not modeled here.
 * 
 * Sound Slots (in order):
 * 0-5: Battle Cry 1-6
 * 6-8: Select 1-3
 * 9-11: Attack Grunt 1-3
 * 12-13: Pain Grunt 1-2
 * 14: Low Health
 * 15: Dead
 * 16: Critical Hit
 * 17: Target Immune
 * 18: Lay Mine
 * 19: Disarm Mine
 * 20: Begin Stealth
 * 21: Begin Search
 * 22: Begin Unlock
 * 23: Unlock Failed
 * 24: Unlock Success
 * 25: Separated From Party
 * 26: Rejoined Party
 * 27: Poisoned
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/ssf_binary_reader.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/ssf_binary_writer.py
 */

var Ssf = (function() {
  function Ssf(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Ssf.prototype._read = function() {
    this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.fileType == "SSF ")) {
      throw new KaitaiStream.ValidationNotEqualError("SSF ", this.fileType, this._io, "/seq/0");
    }
    this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.fileVersion == "V1.1")) {
      throw new KaitaiStream.ValidationNotEqualError("V1.1", this.fileVersion, this._io, "/seq/1");
    }
    this.soundsOffset = this._io.readU4le();
  }

  var SoundArray = Ssf.SoundArray = (function() {
    function SoundArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    SoundArray.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < 28; i++) {
        this.entries.push(new SoundEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of exactly 28 sound entries, one for each SSFSound enum value.
     * Each entry is a uint32 representing a StrRef (string reference).
     * Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
     * 
     * Entry indices map to SSFSound enum:
     * - 0-5: Battle Cry 1-6
     * - 6-8: Select 1-3
     * - 9-11: Attack Grunt 1-3
     * - 12-13: Pain Grunt 1-2
     * - 14: Low Health
     * - 15: Dead
     * - 16: Critical Hit
     * - 17: Target Immune
     * - 18: Lay Mine
     * - 19: Disarm Mine
     * - 20: Begin Stealth
     * - 21: Begin Search
     * - 22: Begin Unlock
     * - 23: Unlock Failed
     * - 24: Unlock Success
     * - 25: Separated From Party
     * - 26: Rejoined Party
     * - 27: Poisoned
     */

    return SoundArray;
  })();

  var SoundEntry = Ssf.SoundEntry = (function() {
    function SoundEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    SoundEntry.prototype._read = function() {
      this.strrefRaw = this._io.readU4le();
    }

    /**
     * True if this entry represents "no sound" (0xFFFFFFFF).
     * False if this entry contains a valid StrRef value.
     */
    Object.defineProperty(SoundEntry.prototype, 'isNoSound', {
      get: function() {
        if (this._m_isNoSound !== undefined)
          return this._m_isNoSound;
        this._m_isNoSound = this.strrefRaw == 4294967295;
        return this._m_isNoSound;
      }
    });

    /**
     * Raw uint32 value representing the StrRef.
     * Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
     * All other values are valid StrRefs (typically 0-999999).
     * The conversion from 0xFFFFFFFF to -1 is handled by SSFBinaryReader.ReadInt32MaxNeg1().
     */

    return SoundEntry;
  })();

  /**
   * Array of 28 sound string references (StrRefs)
   */
  Object.defineProperty(Ssf.prototype, 'sounds', {
    get: function() {
      if (this._m_sounds !== undefined)
        return this._m_sounds;
      var _pos = this._io.pos;
      this._io.seek(this.soundsOffset);
      this._m_sounds = new SoundArray(this._io, this, this._root);
      this._io.seek(_pos);
      return this._m_sounds;
    }
  });

  /**
   * File type signature. Must be "SSF " (space-padded).
   * Bytes: 0x53 0x53 0x46 0x20
   */

  /**
   * File format version. Always "V1.1" for KotOR SSF files.
   * Bytes: 0x56 0x31 0x2E 0x31
   */

  /**
   * Byte offset to the sounds array from the beginning of the file.
   * KotOR files almost always use 12 (0x0C) so the table follows the header immediately, but the
   * field is a real offset; readers must seek here instead of assuming 12.
   */

  return Ssf;
})();
Ssf_.Ssf = Ssf;
});
