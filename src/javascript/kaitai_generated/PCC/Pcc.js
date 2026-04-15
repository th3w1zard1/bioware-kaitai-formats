// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareCommon'));
  } else {
    factory(root.Pcc || (root.Pcc = {}), root.KaitaiStream, root.BiowareCommon || (root.BiowareCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Pcc_, KaitaiStream, BiowareCommon_) {
/**
 * **PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
 * tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).
 * 
 * **Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60|xoreos — `FileType` enum start (Aurora/BioWare family IDs; **PCC/Unreal packages are not in this table** — included only as canonical upstream anchor for “what this repo’s xoreos stack is”)}
 * @see {@link https://github.com/ME3Tweaks/LegendaryExplorer/wiki/PCC-File-Format|ME3Tweaks — PCC file format}
 * @see {@link https://github.com/ME3Tweaks/LegendaryExplorer/wiki/Package-Handling|ME3Tweaks — Package handling (export/import tables, UE3-era BioWare packages)}
 * @see {@link https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/docs/XOREOS_FORMAT_COVERAGE.md|In-tree — coverage matrix (PCC is out-of-xoreos Aurora scope; see table)}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs tree (KotOR-era PDFs; PCC is Mass Effect / UE3 — use LegendaryExplorer wiki as wire authority)}
 */

var Pcc = (function() {
  function Pcc(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Pcc.prototype._read = function() {
    this.header = new FileHeader(this._io, this, this._root);
  }

  var ExportEntry = Pcc.ExportEntry = (function() {
    function ExportEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ExportEntry.prototype._read = function() {
      this.classIndex = this._io.readS4le();
      this.superClassIndex = this._io.readS4le();
      this.link = this._io.readS4le();
      this.objectNameIndex = this._io.readS4le();
      this.objectNameNumber = this._io.readS4le();
      this.archetypeIndex = this._io.readS4le();
      this.objectFlags = this._io.readU8le();
      this.dataSize = this._io.readU4le();
      this.dataOffset = this._io.readU4le();
      this.unknown1 = this._io.readU4le();
      this.numComponents = this._io.readS4le();
      this.unknown2 = this._io.readU4le();
      this.guid = new Guid(this._io, this, this._root);
      if (this.numComponents > 0) {
        this.components = [];
        for (var i = 0; i < this.numComponents; i++) {
          this.components.push(this._io.readS4le());
        }
      }
    }

    /**
     * Object index for the class.
     * Negative = import table index
     * Positive = export table index
     * Zero = no class
     */

    /**
     * Object index for the super class.
     * Negative = import table index
     * Positive = export table index
     * Zero = no super class
     */

    /**
     * Link to other objects (internal reference).
     */

    /**
     * Index into name table for the object name.
     */

    /**
     * Object name number (for duplicate names).
     */

    /**
     * Object index for the archetype.
     * Negative = import table index
     * Positive = export table index
     * Zero = no archetype
     */

    /**
     * Object flags bitfield (64-bit).
     */

    /**
     * Size of the export data in bytes.
     */

    /**
     * Byte offset to the export data from the beginning of the file.
     */

    /**
     * Unknown field.
     */

    /**
     * Number of component entries (can be negative).
     */

    /**
     * Unknown field.
     */

    /**
     * GUID for this export object.
     */

    /**
     * Array of component indices.
     * Only present if num_components > 0.
     */

    return ExportEntry;
  })();

  var ExportTable = Pcc.ExportTable = (function() {
    function ExportTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ExportTable.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.exportCount; i++) {
        this.entries.push(new ExportEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of export entries.
     */

    return ExportTable;
  })();

  var FileHeader = Pcc.FileHeader = (function() {
    function FileHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FileHeader.prototype._read = function() {
      this.magic = this._io.readU4le();
      if (!(this.magic == 2653586369)) {
        throw new KaitaiStream.ValidationNotEqualError(2653586369, this.magic, this._io, "/types/file_header/seq/0");
      }
      this.version = this._io.readU4le();
      this.licenseeVersion = this._io.readU4le();
      this.headerSize = this._io.readS4le();
      this.packageName = KaitaiStream.bytesToStr(this._io.readBytes(10), "UTF-16LE");
      this.packageFlags = this._io.readU4le();
      this.packageType = this._io.readU4le();
      this.nameCount = this._io.readU4le();
      this.nameTableOffset = this._io.readU4le();
      this.exportCount = this._io.readU4le();
      this.exportTableOffset = this._io.readU4le();
      this.importCount = this._io.readU4le();
      this.importTableOffset = this._io.readU4le();
      this.dependOffset = this._io.readU4le();
      this.dependCount = this._io.readU4le();
      this.guidPart1 = this._io.readU4le();
      this.guidPart2 = this._io.readU4le();
      this.guidPart3 = this._io.readU4le();
      this.guidPart4 = this._io.readU4le();
      this.generations = this._io.readU4le();
      this.exportCountDup = this._io.readU4le();
      this.nameCountDup = this._io.readU4le();
      this.unknown1 = this._io.readU4le();
      this.engineVersion = this._io.readU4le();
      this.cookerVersion = this._io.readU4le();
      this.compressionFlags = this._io.readU4le();
      this.packageSource = this._io.readU4le();
      this.compressionType = this._io.readU4le();
      this.chunkCount = this._io.readU4le();
    }

    /**
     * Magic number identifying PCC format. Must be 0x9E2A83C1.
     */

    /**
     * File format version.
     * Encoded as: (major << 16) | (minor << 8) | patch
     * Example: 0xC202AC = 194/684 (major=194, minor=684)
     */

    /**
     * Licensee-specific version field (typically 0x67C).
     */

    /**
     * Header size field (typically -5 = 0xFFFFFFFB).
     */

    /**
     * Package name (typically "None" = 0x4E006F006E006500).
     */

    /**
     * Package flags bitfield.
     * Bit 25 (0x2000000): Compressed package
     * Bit 20 (0x100000): ME3Explorer edited format flag
     * Other bits: Various package attributes
     */

    /**
     * Package type indicator (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_package_kind`
     * (LegendaryExplorer PCC wiki).
     */

    /**
     * Number of entries in the name table.
     */

    /**
     * Byte offset to the name table from the beginning of the file.
     */

    /**
     * Number of entries in the export table.
     */

    /**
     * Byte offset to the export table from the beginning of the file.
     */

    /**
     * Number of entries in the import table.
     */

    /**
     * Byte offset to the import table from the beginning of the file.
     */

    /**
     * Offset to dependency table (typically 0x664).
     */

    /**
     * Number of dependencies (typically 0x67C).
     */

    /**
     * First 32 bits of package GUID.
     */

    /**
     * Second 32 bits of package GUID.
     */

    /**
     * Third 32 bits of package GUID.
     */

    /**
     * Fourth 32 bits of package GUID.
     */

    /**
     * Number of generation entries.
     */

    /**
     * Duplicate export count (should match export_count).
     */

    /**
     * Duplicate name count (should match name_count).
     */

    /**
     * Unknown field (typically 0x0).
     */

    /**
     * Engine version (typically 0x18EF = 6383).
     */

    /**
     * Cooker version (typically 0x3006B = 196715).
     */

    /**
     * Compression flags (typically 0x15330000).
     */

    /**
     * Package source identifier (typically 0x8AA0000).
     */

    /**
     * Compression codec when package is compressed (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_compression_codec`
     * (LegendaryExplorer PCC wiki). Unused / undefined when uncompressed.
     */

    /**
     * Number of compressed chunks (0 for uncompressed, 1 for compressed).
     * If > 0, file uses compressed structure with chunks.
     */

    return FileHeader;
  })();

  var Guid = Pcc.Guid = (function() {
    function Guid(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Guid.prototype._read = function() {
      this.part1 = this._io.readU4le();
      this.part2 = this._io.readU4le();
      this.part3 = this._io.readU4le();
      this.part4 = this._io.readU4le();
    }

    /**
     * First 32 bits of GUID.
     */

    /**
     * Second 32 bits of GUID.
     */

    /**
     * Third 32 bits of GUID.
     */

    /**
     * Fourth 32 bits of GUID.
     */

    return Guid;
  })();

  var ImportEntry = Pcc.ImportEntry = (function() {
    function ImportEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ImportEntry.prototype._read = function() {
      this.packageNameIndex = this._io.readS8le();
      this.classNameIndex = this._io.readS4le();
      this.link = this._io.readS8le();
      this.importNameIndex = this._io.readS8le();
    }

    /**
     * Index into name table for package name.
     * Negative value indicates import from external package.
     * Positive value indicates import from this package.
     */

    /**
     * Index into name table for class name.
     */

    /**
     * Link to import/export table entry.
     * Used to resolve the actual object reference.
     */

    /**
     * Index into name table for the imported object name.
     */

    return ImportEntry;
  })();

  var ImportTable = Pcc.ImportTable = (function() {
    function ImportTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ImportTable.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.importCount; i++) {
        this.entries.push(new ImportEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of import entries.
     */

    return ImportTable;
  })();

  var NameEntry = Pcc.NameEntry = (function() {
    function NameEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    NameEntry.prototype._read = function() {
      this.length = this._io.readS4le();
      this.name = KaitaiStream.bytesToStr(this._io.readBytes((this.length < 0 ? -(this.length) : this.length) * 2), "UTF-16LE");
    }

    /**
     * Absolute value of length for size calculation
     */
    Object.defineProperty(NameEntry.prototype, 'absLength', {
      get: function() {
        if (this._m_absLength !== undefined)
          return this._m_absLength;
        this._m_absLength = (this.length < 0 ? -(this.length) : this.length);
        return this._m_absLength;
      }
    });

    /**
     * Size of name string in bytes (absolute length * 2 bytes per WCHAR)
     */
    Object.defineProperty(NameEntry.prototype, 'nameSize', {
      get: function() {
        if (this._m_nameSize !== undefined)
          return this._m_nameSize;
        this._m_nameSize = this.absLength * 2;
        return this._m_nameSize;
      }
    });

    /**
     * Length of the name string in characters (signed).
     * Negative value indicates the number of WCHAR characters.
     * Positive value is also valid but less common.
     */

    /**
     * Name string encoded as UTF-16LE (WCHAR).
     * Size is absolute value of length * 2 bytes per character.
     * Negative length indicates WCHAR count (use absolute value).
     */

    return NameEntry;
  })();

  var NameTable = Pcc.NameTable = (function() {
    function NameTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    NameTable.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.nameCount; i++) {
        this.entries.push(new NameEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of name entries.
     */

    return NameTable;
  })();

  /**
   * Compression algorithm used (0=None, 1=Zlib, 2=LZO).
   */
  Object.defineProperty(Pcc.prototype, 'compressionType', {
    get: function() {
      if (this._m_compressionType !== undefined)
        return this._m_compressionType;
      this._m_compressionType = this.header.compressionType;
      return this._m_compressionType;
    }
  });

  /**
   * Table containing all objects exported from this package.
   */
  Object.defineProperty(Pcc.prototype, 'exportTable', {
    get: function() {
      if (this._m_exportTable !== undefined)
        return this._m_exportTable;
      if (this.header.exportCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.header.exportTableOffset);
        this._m_exportTable = new ExportTable(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_exportTable;
    }
  });

  /**
   * Table containing references to external packages and classes.
   */
  Object.defineProperty(Pcc.prototype, 'importTable', {
    get: function() {
      if (this._m_importTable !== undefined)
        return this._m_importTable;
      if (this.header.importCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.header.importTableOffset);
        this._m_importTable = new ImportTable(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_importTable;
    }
  });

  /**
   * True if package uses compressed chunks (bit 25 of package_flags).
   */
  Object.defineProperty(Pcc.prototype, 'isCompressed', {
    get: function() {
      if (this._m_isCompressed !== undefined)
        return this._m_isCompressed;
      this._m_isCompressed = (this.header.packageFlags & 33554432) != 0;
      return this._m_isCompressed;
    }
  });

  /**
   * Table containing all string names used in the package.
   */
  Object.defineProperty(Pcc.prototype, 'nameTable', {
    get: function() {
      if (this._m_nameTable !== undefined)
        return this._m_nameTable;
      if (this.header.nameCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.header.nameTableOffset);
        this._m_nameTable = new NameTable(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_nameTable;
    }
  });

  /**
   * File header containing format metadata and table offsets.
   */

  return Pcc;
})();
Pcc_.Pcc = Pcc;
});
