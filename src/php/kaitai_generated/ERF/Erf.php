<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

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
 */

namespace {
    class Erf extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Erf\ErfHeader($this->_io, $this, $this->_root);
        }
        protected $_m_keyList;

        /**
         * Array of key entries mapping ResRefs to resource indices
         */
        public function keyList() {
            if ($this->_m_keyList !== null)
                return $this->_m_keyList;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->header()->offsetToKeyList());
            $this->_m_keyList = new \Erf\KeyList($this->_io, $this, $this->_root);
            $this->_io->seek($_pos);
            return $this->_m_keyList;
        }
        protected $_m_localizedStringList;

        /**
         * Optional localized string entries for multi-language descriptions
         */
        public function localizedStringList() {
            if ($this->_m_localizedStringList !== null)
                return $this->_m_localizedStringList;
            if ($this->header()->languageCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->offsetToLocalizedStringList());
                $this->_m_localizedStringList = new \Erf\LocalizedStringList($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_localizedStringList;
        }
        protected $_m_resourceList;

        /**
         * Array of resource entries containing offset and size information
         */
        public function resourceList() {
            if ($this->_m_resourceList !== null)
                return $this->_m_resourceList;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->header()->offsetToResourceList());
            $this->_m_resourceList = new \Erf\ResourceList($this->_io, $this, $this->_root);
            $this->_io->seek($_pos);
            return $this->_m_resourceList;
        }
        protected $_m_header;

        /**
         * ERF file header (160 bytes)
         */
        public function header() { return $this->_m_header; }
    }
}

namespace Erf {
    class ErfHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!( (($this->_m_fileType == "ERF ") || ($this->_m_fileType == "MOD ") || ($this->_m_fileType == "SAV ") || ($this->_m_fileType == "HAK ")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_fileType, $this->_io, "/types/erf_header/seq/0");
            }
            $this->_m_fileVersion = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_fileVersion == "V1.0")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("V1.0", $this->_m_fileVersion, $this->_io, "/types/erf_header/seq/1");
            }
            $this->_m_languageCount = $this->_io->readU4le();
            $this->_m_localizedStringSize = $this->_io->readU4le();
            $this->_m_entryCount = $this->_io->readU4le();
            $this->_m_offsetToLocalizedStringList = $this->_io->readU4le();
            $this->_m_offsetToKeyList = $this->_io->readU4le();
            $this->_m_offsetToResourceList = $this->_io->readU4le();
            $this->_m_buildYear = $this->_io->readU4le();
            $this->_m_buildDay = $this->_io->readU4le();
            $this->_m_descriptionStrref = $this->_io->readS4le();
            $this->_m_reserved = $this->_io->readBytes(116);
        }
        protected $_m_isSaveFile;

        /**
         * Heuristic to detect save game files.
         * Save games use MOD signature but typically have description_strref = 0.
         */
        public function isSaveFile() {
            if ($this->_m_isSaveFile !== null)
                return $this->_m_isSaveFile;
            $this->_m_isSaveFile =  (($this->fileType() == "MOD ") && ($this->descriptionStrref() == 0)) ;
            return $this->_m_isSaveFile;
        }
        protected $_m_fileType;
        protected $_m_fileVersion;
        protected $_m_languageCount;
        protected $_m_localizedStringSize;
        protected $_m_entryCount;
        protected $_m_offsetToLocalizedStringList;
        protected $_m_offsetToKeyList;
        protected $_m_offsetToResourceList;
        protected $_m_buildYear;
        protected $_m_buildDay;
        protected $_m_descriptionStrref;
        protected $_m_reserved;

        /**
         * File type signature. Must be one of:
         * - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
         * - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
         * - "SAV " (0x53 0x41 0x56 0x20) - Save game file
         * - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. Always "V1.0" for KotOR ERF files.
         * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
         */
        public function fileVersion() { return $this->_m_fileVersion; }

        /**
         * Number of localized string entries. Typically 0 for most ERF files.
         * MOD files may include localized module names for the load screen.
         */
        public function languageCount() { return $this->_m_languageCount; }

        /**
         * Total size of localized string data in bytes.
         * Includes all language entries (language_id + string_size + string_data for each).
         */
        public function localizedStringSize() { return $this->_m_localizedStringSize; }

        /**
         * Number of resources in the archive. This determines:
         * - Number of entries in key_list
         * - Number of entries in resource_list
         * - Number of resource data blocks stored at various offsets
         */
        public function entryCount() { return $this->_m_entryCount; }

        /**
         * Byte offset to the localized string list from the beginning of the file.
         * Typically 160 (right after header) if present, or 0 if not present.
         */
        public function offsetToLocalizedStringList() { return $this->_m_offsetToLocalizedStringList; }

        /**
         * Byte offset to the key list from the beginning of the file.
         * Typically 160 (right after header) if no localized strings, or after localized strings.
         */
        public function offsetToKeyList() { return $this->_m_offsetToKeyList; }

        /**
         * Byte offset to the resource list from the beginning of the file.
         * Located after the key list.
         */
        public function offsetToResourceList() { return $this->_m_offsetToResourceList; }

        /**
         * Build year (years since 1900).
         * Example: 103 = year 2003
         * Primarily informational, used by development tools to track module versions.
         */
        public function buildYear() { return $this->_m_buildYear; }

        /**
         * Build day (days since January 1, with January 1 = day 1).
         * Example: 247 = September 4th (the 247th day of the year)
         * Primarily informational, used by development tools to track module versions.
         */
        public function buildDay() { return $this->_m_buildDay; }

        /**
         * Description StrRef (TLK string reference) for the archive description.
         * Values vary by file type:
         * - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
         * - SAV files: 0 (typically no description)
         * - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
         */
        public function descriptionStrref() { return $this->_m_descriptionStrref; }

        /**
         * Reserved padding (usually zeros).
         * Total header size is 160 bytes:
         * file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
         * entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
         * offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
         * reserved (116) = 160 bytes
         */
        public function reserved() { return $this->_m_reserved; }
    }
}

namespace Erf {
    class KeyEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf\KeyList $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_resref = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(16), "ASCII");
            $this->_m_resourceId = $this->_io->readU4le();
            $this->_m_resourceType = $this->_io->readU2le();
            $this->_m_unused = $this->_io->readU2le();
        }
        protected $_m_resref;
        protected $_m_resourceId;
        protected $_m_resourceType;
        protected $_m_unused;

        /**
         * Resource filename (ResRef), null-padded to 16 bytes.
         * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
         * Resource names can be mixed case, though most are lowercase in practice.
         */
        public function resref() { return $this->_m_resref; }

        /**
         * Resource ID (index into resource_list).
         * Maps this key entry to the corresponding resource entry.
         */
        public function resourceId() { return $this->_m_resourceId; }

        /**
         * Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
         * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
         */
        public function resourceType() { return $this->_m_resourceType; }

        /**
         * Padding/unused field (typically 0)
         */
        public function unused() { return $this->_m_unused; }
    }
}

namespace Erf {
    class KeyList extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->entryCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Erf\KeyEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of key entries mapping ResRefs to resource indices
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Erf {
    class LocalizedStringEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf\LocalizedStringList $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_languageId = $this->_io->readU4le();
            $this->_m_stringSize = $this->_io->readU4le();
            $this->_m_stringData = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes($this->stringSize()), "UTF-8");
        }
        protected $_m_languageId;
        protected $_m_stringSize;
        protected $_m_stringData;

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
        public function languageId() { return $this->_m_languageId; }

        /**
         * Length of string data in bytes
         */
        public function stringSize() { return $this->_m_stringSize; }

        /**
         * UTF-8 encoded text string
         */
        public function stringData() { return $this->_m_stringData; }
    }
}

namespace Erf {
    class LocalizedStringList extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->languageCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Erf\LocalizedStringEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of localized string entries, one per language
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Erf {
    class ResourceEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf\ResourceList $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_offsetToData = $this->_io->readU4le();
            $this->_m_lenData = $this->_io->readU4le();
        }
        protected $_m_data;

        /**
         * Raw binary data for this resource
         */
        public function data() {
            if ($this->_m_data !== null)
                return $this->_m_data;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->offsetToData());
            $this->_m_data = $this->_io->readBytes($this->lenData());
            $this->_io->seek($_pos);
            return $this->_m_data;
        }
        protected $_m_offsetToData;
        protected $_m_lenData;

        /**
         * Byte offset to resource data from the beginning of the file.
         * Points to the actual binary data for this resource.
         */
        public function offsetToData() { return $this->_m_offsetToData; }

        /**
         * Size of resource data in bytes.
         * Uncompressed size of the resource.
         */
        public function lenData() { return $this->_m_lenData; }
    }
}

namespace Erf {
    class ResourceList extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Erf $_parent = null, ?\Erf $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->entryCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Erf\ResourceEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of resource entries containing offset and size information
         */
        public function entries() { return $this->_m_entries; }
    }
}
