// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareTypeIds'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareTypeIds'));
  } else {
    factory(root.Rim || (root.Rim = {}), root.KaitaiStream, root.BiowareTypeIds || (root.BiowareTypeIds = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Rim_, KaitaiStream, BiowareTypeIds_) {
/**
 * RIM (Resource Information Manager) files are self-contained archives used for module templates.
 * RIM files are similar to ERF files but are read-only from the game's perspective. The game
 * loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
 * RIM files store all resources inline with metadata, making them self-contained archives.
 * 
 * Format Variants:
 * - Standard RIM: Basic module template files
 * - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
 * 
 * Binary Format (KotOR / PyKotor):
 * - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
 * - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
 * - Key / resource entry table (32 bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
 * - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
 * 
 * Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim|PyKotor wiki — RIM}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128|PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L35-L91|xoreos — `RIMFile::load` + `readResList`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/unrim.cpp#L55-L85|xoreos-tools — `unrim` CLI (`main`)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/rim.cpp#L43-L84|xoreos-tools — `rim` packer CLI (`main`)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html|xoreos-docs — Torlack mod.html (MOD/RIM family)}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/RIMObject.ts#L69-L93|KotOR.js — `RIMObject`}
 * @see {@link https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs|NickHugi/Kotor.NET — `RIMBinaryStructure`}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/resource/format/rimreader.cpp#L26-L58|reone — `RimReader`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394|xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py|PyKotor — `ResourceType` (tooling superset)}
 */

var Rim = (function() {
  function Rim(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Rim.prototype._read = function() {
    this.header = new RimHeader(this._io, this, this._root);
    if (this.header.offsetToResourceTable == 0) {
      this.gapBeforeKeyTableImplicit = this._io.readBytes(96);
    }
    if (this.header.offsetToResourceTable != 0) {
      this.gapBeforeKeyTableExplicit = this._io.readBytes(this.header.offsetToResourceTable - 24);
    }
    if (this.header.resourceCount > 0) {
      this.resourceEntryTable = new ResourceEntryTable(this._io, this, this._root);
    }
  }

  var ResourceEntry = Rim.ResourceEntry = (function() {
    function ResourceEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ResourceEntry.prototype._read = function() {
      this.resref = KaitaiStream.bytesToStr(this._io.readBytes(16), "ASCII");
      this.resourceType = this._io.readU4le();
      this.resourceId = this._io.readU4le();
      this.offsetToData = this._io.readU4le();
      this.numData = this._io.readU4le();
    }

    /**
     * Raw binary data for this resource (read at specified offset)
     */
    Object.defineProperty(ResourceEntry.prototype, 'data', {
      get: function() {
        if (this._m_data !== undefined)
          return this._m_data;
        var _pos = this._io.pos;
        this._io.seek(this.offsetToData);
        this._m_data = [];
        for (var i = 0; i < this.numData; i++) {
          this._m_data.push(this._io.readU1());
        }
        this._io.seek(_pos);
        return this._m_data;
      }
    });

    /**
     * Resource filename (ResRef), null-padded to 16 bytes.
     * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
     * Resource names can be mixed case, though most are lowercase in practice.
     * The game engine typically lowercases ResRefs when loading.
     */

    /**
     * Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
     * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
     */

    /**
     * Resource ID (index, usually sequential).
     * Typically matches the index of this entry in the resource_entry_table.
     * Used for internal reference, but not critical for parsing.
     */

    /**
     * Byte offset to resource data from the beginning of the file.
     * Points to the actual binary data for this resource in resource_data_section.
     */

    /**
     * Size of resource data in bytes (repeat count for raw `data` bytes).
     * Uncompressed size of the resource.
     */

    return ResourceEntry;
  })();

  var ResourceEntryTable = Rim.ResourceEntryTable = (function() {
    function ResourceEntryTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ResourceEntryTable.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.resourceCount; i++) {
        this.entries.push(new ResourceEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of resource entries, one per resource in the archive
     */

    return ResourceEntryTable;
  })();

  var RimHeader = Rim.RimHeader = (function() {
    function RimHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    RimHeader.prototype._read = function() {
      this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.fileType == "RIM ")) {
        throw new KaitaiStream.ValidationNotEqualError("RIM ", this.fileType, this._io, "/types/rim_header/seq/0");
      }
      this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.fileVersion == "V1.0")) {
        throw new KaitaiStream.ValidationNotEqualError("V1.0", this.fileVersion, this._io, "/types/rim_header/seq/1");
      }
      this.reserved = this._io.readU4le();
      this.resourceCount = this._io.readU4le();
      this.offsetToResourceTable = this._io.readU4le();
      this.offsetToResources = this._io.readU4le();
    }

    /**
     * Whether the RIM file contains any resources
     */
    Object.defineProperty(RimHeader.prototype, 'hasResources', {
      get: function() {
        if (this._m_hasResources !== undefined)
          return this._m_hasResources;
        this._m_hasResources = this.resourceCount > 0;
        return this._m_hasResources;
      }
    });

    /**
     * File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
     * This identifies the file as a RIM archive.
     */

    /**
     * File format version. Always "V1.0" for KotOR RIM files.
     * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
     */

    /**
     * Reserved field (typically 0x00000000).
     * Unknown purpose, but always set to 0 in practice.
     */

    /**
     * Number of resources in the archive. This determines:
     * - Number of entries in resource_entry_table
     * - Number of resources in resource_data_section
     */

    /**
     * Byte offset to the key / resource entry table from the beginning of the file.
     * 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
     * When non-zero, this offset is used directly (commonly 120).
     */

    /**
     * Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
     * taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
     */

    return RimHeader;
  })();

  /**
   * RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
   */

  /**
   * When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
   * After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
   */

  /**
   * When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
   * Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
   */

  /**
   * Array of resource entries mapping ResRefs to resource data
   */

  return Rim;
})();
Rim_.Rim = Rim;
});
