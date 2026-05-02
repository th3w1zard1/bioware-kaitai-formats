// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareTypeIds'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareTypeIds'));
  } else {
    factory(root.Key || (root.Key = {}), root.KaitaiStream, root.BiowareTypeIds || (root.BiowareTypeIds = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Key_, KaitaiStream, BiowareTypeIds_) {
/**
 * **KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
 * Resource types use `bioware_type_ids`.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key|PyKotor wiki — KEY}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/key/io_key.py#L26-L183|PyKotor — `io_key` (Kaitai + legacy + header write)}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/resource/format/keyreader.cpp#L26-L80|reone — `KeyReader`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp#L50-L88|xoreos — `KEYFile::load`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L192-L210|xoreos-tools — `openKEYs` / `openKEYDataFiles`}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf|xoreos-docs — KeyBIF_Format.pdf}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/key.html|xoreos-docs — Torlack key.html}
 */

var Key = (function() {
  function Key(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Key.prototype._read = function() {
    this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.fileType == "KEY ")) {
      throw new KaitaiStream.ValidationNotEqualError("KEY ", this.fileType, this._io, "/seq/0");
    }
    this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!( ((this.fileVersion == "V1  ") || (this.fileVersion == "V1.1")) )) {
      throw new KaitaiStream.ValidationNotAnyOfError(this.fileVersion, this._io, "/seq/1");
    }
    this.bifCount = this._io.readU4le();
    this.keyCount = this._io.readU4le();
    this.fileTableOffset = this._io.readU4le();
    this.keyTableOffset = this._io.readU4le();
    this.buildYear = this._io.readU4le();
    this.buildDay = this._io.readU4le();
    this.reserved = this._io.readBytes(32);
  }

  var FileEntry = Key.FileEntry = (function() {
    function FileEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FileEntry.prototype._read = function() {
      this.fileSize = this._io.readU4le();
      this.filenameOffset = this._io.readU4le();
      this.filenameSize = this._io.readU2le();
      this.drives = this._io.readU2le();
    }

    /**
     * BIF filename string at the absolute filename_offset in the KEY file.
     */
    Object.defineProperty(FileEntry.prototype, 'filename', {
      get: function() {
        if (this._m_filename !== undefined)
          return this._m_filename;
        var _pos = this._io.pos;
        this._io.seek(this.filenameOffset);
        this._m_filename = KaitaiStream.bytesToStr(this._io.readBytes(this.filenameSize), "ASCII");
        this._io.seek(_pos);
        return this._m_filename;
      }
    });

    /**
     * Size of the BIF file on disk in bytes.
     */

    /**
     * Absolute byte offset from the start of the KEY file where this BIF's filename is stored
     * (seek(filename_offset), then read filename_size bytes).
     * This is not relative to the file table or to the end of the BIF entry array.
     */

    /**
     * Length of the filename in bytes (including null terminator).
     */

    /**
     * Drive flags indicating which media contains the BIF file.
     * Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
     * Modern distributions typically use 0x0001 (HD) for all files.
     */

    return FileEntry;
  })();

  var FileTable = Key.FileTable = (function() {
    function FileTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FileTable.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.bifCount; i++) {
        this.entries.push(new FileEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of BIF file entries.
     */

    return FileTable;
  })();

  var FilenameTable = Key.FilenameTable = (function() {
    function FilenameTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FilenameTable.prototype._read = function() {
      this.filenames = KaitaiStream.bytesToStr(this._io.readBytesFull(), "ASCII");
    }

    /**
     * Null-terminated BIF filenames concatenated together.
     * Each filename is read using the filename_offset and filename_size
     * from the corresponding file_entry.
     */

    return FilenameTable;
  })();

  var KeyEntry = Key.KeyEntry = (function() {
    function KeyEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    KeyEntry.prototype._read = function() {
      this.resref = KaitaiStream.bytesToStr(this._io.readBytes(16), "ASCII");
      this.resourceType = this._io.readU2le();
      this.resourceId = this._io.readU4le();
    }

    /**
     * Resource filename (ResRef) without extension.
     * Null-padded, maximum 16 characters.
     * The game uses this name to access the resource.
     */

    /**
     * Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
     * `formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).
     */

    /**
     * Encoded resource location.
     * Bits 31-20: BIF index (top 12 bits) - index into file table
     * Bits 19-0: Resource index (bottom 20 bits) - index within the BIF file
     * 
     * Formula: resource_id = (bif_index << 20) | resource_index
     * 
     * Decoding:
     * - bif_index = (resource_id >> 20) & 0xFFF
     * - resource_index = resource_id & 0xFFFFF
     */

    return KeyEntry;
  })();

  var KeyTable = Key.KeyTable = (function() {
    function KeyTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    KeyTable.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.keyCount; i++) {
        this.entries.push(new KeyEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of resource entries.
     */

    return KeyTable;
  })();

  /**
   * File table containing BIF file entries.
   */
  Object.defineProperty(Key.prototype, 'fileTable', {
    get: function() {
      if (this._m_fileTable !== undefined)
        return this._m_fileTable;
      if (this.bifCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.fileTableOffset);
        this._m_fileTable = new FileTable(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_fileTable;
    }
  });

  /**
   * KEY table containing resource entries.
   */
  Object.defineProperty(Key.prototype, 'keyTable', {
    get: function() {
      if (this._m_keyTable !== undefined)
        return this._m_keyTable;
      if (this.keyCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.keyTableOffset);
        this._m_keyTable = new KeyTable(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_keyTable;
    }
  });

  /**
   * File type signature. Must be "KEY " (space-padded).
   */

  /**
   * File format version. Typically "V1  " or "V1.1".
   */

  /**
   * Number of BIF files referenced by this KEY file.
   */

  /**
   * Number of resource entries in the KEY table.
   */

  /**
   * Byte offset to the file table from the beginning of the file.
   */

  /**
   * Byte offset to the KEY table from the beginning of the file.
   */

  /**
   * Build year (years since 1900).
   */

  /**
   * Build day (days since January 1).
   */

  /**
   * Reserved padding (usually zeros).
   */

  return Key;
})();
Key_.Key = Key;
});
