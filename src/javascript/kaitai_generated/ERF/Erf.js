// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareTypeIds'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareTypeIds'));
  } else {
    factory(root.Erf || (root.Erf = {}), root.KaitaiStream, root.BiowareTypeIds || (root.BiowareTypeIds = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Erf_, KaitaiStream, BiowareTypeIds_) {
/**
 * ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
 * texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
 * ERF files store both resource names (ResRefs) and data in the same file. They also support
 * localized strings for descriptions in multiple languages.
 * 
 * Format Variants:
 * - ERF: Generic encapsulated resource file (texture packs, etc.)
 * - HAK: Hak pak file (contains override resources). Used for mod content distribution
 * - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
 * - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`
 * 
 * All variants use the same binary format structure, differing only in the file type signature.
 * 
 * Archive `resource_type` values use the shared **`bioware_type_ids::xoreos_file_type_id`** enum (xoreos `FileType`); see `formats/Common/bioware_type_ids.ksy`.
 * 
 * Binary Format Structure:
 * - Header (160 bytes): File type, version, entry counts, offsets, build date, description
 * - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
 *   include localized module names for the load screen. Each entry contains language_id (u4),
 *   string_size (u4), and string_data (UTF-8 encoded text)
 * - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
 *   - resref (16 bytes, ASCII, null-padded): Resource filename
 *   - resource_id (u4): Index into resource_list
 *   - resource_type (u2): Resource type identifier (`bioware_type_ids::xoreos_file_type_id`, xoreos `FileType`)
 *   - unused (u2): Padding/unused field (typically 0)
 * - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
 *   - offset_to_data (u4): Byte offset to resource data from beginning of file
 *   - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
 * - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
 *   in resource_list
 * 
 * File Access Pattern:
 * 1. Read header to get entry_count and offsets
 * 2. Read key_list to map ResRefs to resource_ids
 * 3. Use resource_id to index into resource_list
 * 4. Read resource data from offset_to_data with byte length len_data
 * 
 * Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_erf` / `erf_data`, xoreos `ERFFile`, xoreos-tools `unerf` / `erf`, reone `ErfReader`, KotOR.js `ERFObject`, NickHugi `Kotor.NET/Formats/KotorERF`).
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf|PyKotor wiki — ERF}
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf|PyKotor wiki — Aurora ERF notes}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py#L22-L316|PyKotor — `io_erf` (Kaitai + legacy + `ERFBinaryWriter.write`)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L130|PyKotor — `ERFType` + `ERF` model (opening)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L50-L335|xoreos — ERF type tags + `ERFFile::load` + `readV10Header` start}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/unerf.cpp#L69-L106|xoreos-tools — `unerf` CLI (`main`)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/erf.cpp#L49-L96|xoreos-tools — `erf` packer CLI (`main`)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html|xoreos-docs — Torlack mod.html}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/resource/format/erfreader.cpp#L26-L92|reone — `ErfReader`}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/ERFObject.ts#L70-L115|KotOR.js — `ERFObject`}
 * @see {@link https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorERF/ERFBinaryStructure.cs|NickHugi/Kotor.NET — `ERFBinaryStructure`}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/ERF_Format.pdf|xoreos-docs — ERF_Format.pdf}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394|xoreos — `enum FileType` (numeric IDs in KEY/ERF/RIM tables)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py|PyKotor — `ResourceType` (tooling superset; overlaps FileType for KotOR rows)}
 */

var Erf = (function() {
  function Erf(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Erf.prototype._read = function() {
    this.header = new ErfHeader(this._io, this, this._root);
  }

  var ErfHeader = Erf.ErfHeader = (function() {
    function ErfHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ErfHeader.prototype._read = function() {
      this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!( ((this.fileType == "ERF ") || (this.fileType == "MOD ") || (this.fileType == "SAV ") || (this.fileType == "HAK ")) )) {
        throw new KaitaiStream.ValidationNotAnyOfError(this.fileType, this._io, "/types/erf_header/seq/0");
      }
      this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.fileVersion == "V1.0")) {
        throw new KaitaiStream.ValidationNotEqualError("V1.0", this.fileVersion, this._io, "/types/erf_header/seq/1");
      }
      this.languageCount = this._io.readU4le();
      this.localizedStringSize = this._io.readU4le();
      this.entryCount = this._io.readU4le();
      this.offsetToLocalizedStringList = this._io.readU4le();
      this.offsetToKeyList = this._io.readU4le();
      this.offsetToResourceList = this._io.readU4le();
      this.buildYear = this._io.readU4le();
      this.buildDay = this._io.readU4le();
      this.descriptionStrref = this._io.readS4le();
      this.reserved = this._io.readBytes(116);
    }

    /**
     * Heuristic to detect save game files.
     * Save games use MOD signature but typically have description_strref = 0.
     */
    Object.defineProperty(ErfHeader.prototype, 'isSaveFile', {
      get: function() {
        if (this._m_isSaveFile !== undefined)
          return this._m_isSaveFile;
        this._m_isSaveFile =  ((this.fileType == "MOD ") && (this.descriptionStrref == 0)) ;
        return this._m_isSaveFile;
      }
    });

    /**
     * File type signature. Must be one of:
     * - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
     * - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
     * - "SAV " (0x53 0x41 0x56 0x20) - Save game file
     * - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
     */

    /**
     * File format version. Always "V1.0" for KotOR ERF files.
     * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
     */

    /**
     * Number of localized string entries. Typically 0 for most ERF files.
     * MOD files may include localized module names for the load screen.
     */

    /**
     * Total size of localized string data in bytes.
     * Includes all language entries (language_id + string_size + string_data for each).
     */

    /**
     * Number of resources in the archive. This determines:
     * - Number of entries in key_list
     * - Number of entries in resource_list
     * - Number of resource data blocks stored at various offsets
     */

    /**
     * Byte offset to the localized string list from the beginning of the file.
     * Typically 160 (right after header) if present, or 0 if not present.
     */

    /**
     * Byte offset to the key list from the beginning of the file.
     * Typically 160 (right after header) if no localized strings, or after localized strings.
     */

    /**
     * Byte offset to the resource list from the beginning of the file.
     * Located after the key list.
     */

    /**
     * Build year (years since 1900).
     * Example: 103 = year 2003
     * Primarily informational, used by development tools to track module versions.
     */

    /**
     * Build day (days since January 1, with January 1 = day 1).
     * Example: 247 = September 4th (the 247th day of the year)
     * Primarily informational, used by development tools to track module versions.
     */

    /**
     * Description StrRef (TLK string reference) for the archive description.
     * Values vary by file type:
     * - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
     * - SAV files: 0 (typically no description)
     * - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
     */

    /**
     * Reserved padding (usually zeros).
     * Total header size is 160 bytes:
     * file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
     * entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
     * offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
     * reserved (116) = 160 bytes
     */

    return ErfHeader;
  })();

  var KeyEntry = Erf.KeyEntry = (function() {
    function KeyEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    KeyEntry.prototype._read = function() {
      this.resref = KaitaiStream.bytesToStr(this._io.readBytes(16), "ASCII");
      this.resourceId = this._io.readU4le();
      this.resourceType = this._io.readU2le();
      this.unused = this._io.readU2le();
    }

    /**
     * Resource filename (ResRef), null-padded to 16 bytes.
     * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
     * Resource names can be mixed case, though most are lowercase in practice.
     */

    /**
     * Resource ID (index into resource_list).
     * Maps this key entry to the corresponding resource entry.
     */

    /**
     * Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
     * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
     */

    /**
     * Padding/unused field (typically 0)
     */

    return KeyEntry;
  })();

  var KeyList = Erf.KeyList = (function() {
    function KeyList(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    KeyList.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.entryCount; i++) {
        this.entries.push(new KeyEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of key entries mapping ResRefs to resource indices
     */

    return KeyList;
  })();

  var LocalizedStringEntry = Erf.LocalizedStringEntry = (function() {
    function LocalizedStringEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LocalizedStringEntry.prototype._read = function() {
      this.languageId = this._io.readU4le();
      this.stringSize = this._io.readU4le();
      this.stringData = KaitaiStream.bytesToStr(this._io.readBytes(this.stringSize), "UTF-8");
    }

    /**
     * Language identifier:
     * - 0 = English
     * - 1 = French
     * - 2 = German
     * - 3 = Italian
     * - 4 = Spanish
     * - 5 = Polish
     * - Additional languages for Asian releases
     */

    /**
     * Length of string data in bytes
     */

    /**
     * UTF-8 encoded text string
     */

    return LocalizedStringEntry;
  })();

  var LocalizedStringList = Erf.LocalizedStringList = (function() {
    function LocalizedStringList(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LocalizedStringList.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.languageCount; i++) {
        this.entries.push(new LocalizedStringEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of localized string entries, one per language
     */

    return LocalizedStringList;
  })();

  var ResourceEntry = Erf.ResourceEntry = (function() {
    function ResourceEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ResourceEntry.prototype._read = function() {
      this.offsetToData = this._io.readU4le();
      this.lenData = this._io.readU4le();
    }

    /**
     * Raw binary data for this resource
     */
    Object.defineProperty(ResourceEntry.prototype, 'data', {
      get: function() {
        if (this._m_data !== undefined)
          return this._m_data;
        var _pos = this._io.pos;
        this._io.seek(this.offsetToData);
        this._m_data = this._io.readBytes(this.lenData);
        this._io.seek(_pos);
        return this._m_data;
      }
    });

    /**
     * Byte offset to resource data from the beginning of the file.
     * Points to the actual binary data for this resource.
     */

    /**
     * Size of resource data in bytes.
     * Uncompressed size of the resource.
     */

    return ResourceEntry;
  })();

  var ResourceList = Erf.ResourceList = (function() {
    function ResourceList(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ResourceList.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.entryCount; i++) {
        this.entries.push(new ResourceEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of resource entries containing offset and size information
     */

    return ResourceList;
  })();

  /**
   * Array of key entries mapping ResRefs to resource indices
   */
  Object.defineProperty(Erf.prototype, 'keyList', {
    get: function() {
      if (this._m_keyList !== undefined)
        return this._m_keyList;
      var _pos = this._io.pos;
      this._io.seek(this.header.offsetToKeyList);
      this._m_keyList = new KeyList(this._io, this, this._root);
      this._io.seek(_pos);
      return this._m_keyList;
    }
  });

  /**
   * Optional localized string entries for multi-language descriptions
   */
  Object.defineProperty(Erf.prototype, 'localizedStringList', {
    get: function() {
      if (this._m_localizedStringList !== undefined)
        return this._m_localizedStringList;
      if (this.header.languageCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.header.offsetToLocalizedStringList);
        this._m_localizedStringList = new LocalizedStringList(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_localizedStringList;
    }
  });

  /**
   * Array of resource entries containing offset and size information
   */
  Object.defineProperty(Erf.prototype, 'resourceList', {
    get: function() {
      if (this._m_resourceList !== undefined)
        return this._m_resourceList;
      var _pos = this._io.pos;
      this._io.seek(this.header.offsetToResourceList);
      this._m_resourceList = new ResourceList(this._io, this, this._root);
      this._io.seek(_pos);
      return this._m_resourceList;
    }
  });

  /**
   * ERF file header (160 bytes)
   */

  return Erf;
})();
Erf_.Erf = Erf;
});
