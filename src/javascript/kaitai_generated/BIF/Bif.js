// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareTypeIds'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareTypeIds'));
  } else {
    factory(root.Bif || (root.Bif = {}), root.KaitaiStream, root.BiowareTypeIds || (root.BiowareTypeIds = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Bif_, KaitaiStream, BiowareTypeIds_) {
/**
 * **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
 * the paired **KEY** (`KEY.ksy`), not in the BIF.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif|PyKotor wiki — BIF}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L57-L215|PyKotor — `io_bif` (Kaitai + legacy + reader)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py#L59-L71|PyKotor — `BIFType`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L97|xoreos — `BIFFile::load` + `readVarResTable`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L208|xoreos — `kFileTypeBIF`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L209|xoreos-tools — `unkeybif` (non-`.bzf` → `BIFFile`)}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/resource/format/bifreader.cpp#L26-L63|reone — `BifReader`}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/BIFObject.ts|KotOR.js — `BIFObject`}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/bif.html|xoreos-docs — Torlack bif.html}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf|xoreos-docs — KeyBIF_Format.pdf}
 */

var Bif = (function() {
  function Bif(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Bif.prototype._read = function() {
    this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.fileType == "BIFF")) {
      throw new KaitaiStream.ValidationNotEqualError("BIFF", this.fileType, this._io, "/seq/0");
    }
    this.version = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!( ((this.version == "V1  ") || (this.version == "V1.1")) )) {
      throw new KaitaiStream.ValidationNotAnyOfError(this.version, this._io, "/seq/1");
    }
    this.varResCount = this._io.readU4le();
    this.fixedResCount = this._io.readU4le();
    if (!(this.fixedResCount == 0)) {
      throw new KaitaiStream.ValidationNotEqualError(0, this.fixedResCount, this._io, "/seq/3");
    }
    this.varTableOffset = this._io.readU4le();
  }

  var VarResourceEntry = Bif.VarResourceEntry = (function() {
    function VarResourceEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    VarResourceEntry.prototype._read = function() {
      this.resourceId = this._io.readU4le();
      this.offset = this._io.readU4le();
      this.fileSize = this._io.readU4le();
      this.resourceType = this._io.readU4le();
    }

    /**
     * Resource ID (matches KEY file entry).
     * Encodes BIF index (bits 31-20) and resource index (bits 19-0).
     * Formula: resource_id = (bif_index << 20) | resource_index
     */

    /**
     * Byte offset to resource data in file (absolute file offset).
     */

    /**
     * Uncompressed size of resource data in bytes.
     */

    /**
     * Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
     * read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
     * `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.
     */

    return VarResourceEntry;
  })();

  var VarResourceTable = Bif.VarResourceTable = (function() {
    function VarResourceTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    VarResourceTable.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.varResCount; i++) {
        this.entries.push(new VarResourceEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of variable resource entries.
     */

    return VarResourceTable;
  })();

  /**
   * Variable resource table containing entries for each resource.
   */
  Object.defineProperty(Bif.prototype, 'varResourceTable', {
    get: function() {
      if (this._m_varResourceTable !== undefined)
        return this._m_varResourceTable;
      if (this.varResCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.varTableOffset);
        this._m_varResourceTable = new VarResourceTable(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_varResourceTable;
    }
  });

  /**
   * File type signature. Must be "BIFF" for BIF files.
   */

  /**
   * File format version. Typically "V1  " or "V1.1".
   */

  /**
   * Number of variable-size resources in this file.
   */

  /**
   * Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
   */

  /**
   * Byte offset to the variable resource table from the beginning of the file.
   */

  return Bif;
})();
Bif_.Bif = Bif;
});
