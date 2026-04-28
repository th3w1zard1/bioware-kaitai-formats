<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

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
 */

namespace {
    class Rim extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Rim $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Rim\RimHeader($this->_io, $this, $this->_root);
            if ($this->header()->offsetToResourceTable() == 0) {
                $this->_m_gapBeforeKeyTableImplicit = $this->_io->readBytes(96);
            }
            if ($this->header()->offsetToResourceTable() != 0) {
                $this->_m_gapBeforeKeyTableExplicit = $this->_io->readBytes($this->header()->offsetToResourceTable() - 24);
            }
            if ($this->header()->resourceCount() > 0) {
                $this->_m_resourceEntryTable = new \Rim\ResourceEntryTable($this->_io, $this, $this->_root);
            }
        }
        protected $_m_header;
        protected $_m_gapBeforeKeyTableImplicit;
        protected $_m_gapBeforeKeyTableExplicit;
        protected $_m_resourceEntryTable;

        /**
         * RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
         */
        public function header() { return $this->_m_header; }

        /**
         * When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
         * After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
         */
        public function gapBeforeKeyTableImplicit() { return $this->_m_gapBeforeKeyTableImplicit; }

        /**
         * When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
         * Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
         */
        public function gapBeforeKeyTableExplicit() { return $this->_m_gapBeforeKeyTableExplicit; }

        /**
         * Array of resource entries mapping ResRefs to resource data
         */
        public function resourceEntryTable() { return $this->_m_resourceEntryTable; }
    }
}

namespace Rim {
    class ResourceEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Rim\ResourceEntryTable $_parent = null, ?\Rim $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_resref = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(16), "ASCII");
            $this->_m_resourceType = $this->_io->readU4le();
            $this->_m_resourceId = $this->_io->readU4le();
            $this->_m_offsetToData = $this->_io->readU4le();
            $this->_m_numData = $this->_io->readU4le();
        }
        protected $_m_data;

        /**
         * Raw binary data for this resource (read at specified offset)
         */
        public function data() {
            if ($this->_m_data !== null)
                return $this->_m_data;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->offsetToData());
            $this->_m_data = [];
            $n = $this->numData();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_data[] = $this->_io->readU1();
            }
            $this->_io->seek($_pos);
            return $this->_m_data;
        }
        protected $_m_resref;
        protected $_m_resourceType;
        protected $_m_resourceId;
        protected $_m_offsetToData;
        protected $_m_numData;

        /**
         * Resource filename (ResRef), null-padded to 16 bytes.
         * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
         * Resource names can be mixed case, though most are lowercase in practice.
         * The game engine typically lowercases ResRefs when loading.
         */
        public function resref() { return $this->_m_resref; }

        /**
         * Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
         * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
         */
        public function resourceType() { return $this->_m_resourceType; }

        /**
         * Resource ID (index, usually sequential).
         * Typically matches the index of this entry in the resource_entry_table.
         * Used for internal reference, but not critical for parsing.
         */
        public function resourceId() { return $this->_m_resourceId; }

        /**
         * Byte offset to resource data from the beginning of the file.
         * Points to the actual binary data for this resource in resource_data_section.
         */
        public function offsetToData() { return $this->_m_offsetToData; }

        /**
         * Size of resource data in bytes (repeat count for raw `data` bytes).
         * Uncompressed size of the resource.
         */
        public function numData() { return $this->_m_numData; }
    }
}

namespace Rim {
    class ResourceEntryTable extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Rim $_parent = null, ?\Rim $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->resourceCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Rim\ResourceEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of resource entries, one per resource in the archive
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Rim {
    class RimHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Rim $_parent = null, ?\Rim $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_fileType == "RIM ")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("RIM ", $this->_m_fileType, $this->_io, "/types/rim_header/seq/0");
            }
            $this->_m_fileVersion = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_fileVersion == "V1.0")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("V1.0", $this->_m_fileVersion, $this->_io, "/types/rim_header/seq/1");
            }
            $this->_m_reserved = $this->_io->readU4le();
            $this->_m_resourceCount = $this->_io->readU4le();
            $this->_m_offsetToResourceTable = $this->_io->readU4le();
            $this->_m_offsetToResources = $this->_io->readU4le();
        }
        protected $_m_hasResources;

        /**
         * Whether the RIM file contains any resources
         */
        public function hasResources() {
            if ($this->_m_hasResources !== null)
                return $this->_m_hasResources;
            $this->_m_hasResources = $this->resourceCount() > 0;
            return $this->_m_hasResources;
        }
        protected $_m_fileType;
        protected $_m_fileVersion;
        protected $_m_reserved;
        protected $_m_resourceCount;
        protected $_m_offsetToResourceTable;
        protected $_m_offsetToResources;

        /**
         * File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
         * This identifies the file as a RIM archive.
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. Always "V1.0" for KotOR RIM files.
         * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
         */
        public function fileVersion() { return $this->_m_fileVersion; }

        /**
         * Reserved field (typically 0x00000000).
         * Unknown purpose, but always set to 0 in practice.
         */
        public function reserved() { return $this->_m_reserved; }

        /**
         * Number of resources in the archive. This determines:
         * - Number of entries in resource_entry_table
         * - Number of resources in resource_data_section
         */
        public function resourceCount() { return $this->_m_resourceCount; }

        /**
         * Byte offset to the key / resource entry table from the beginning of the file.
         * 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
         * When non-zero, this offset is used directly (commonly 120).
         */
        public function offsetToResourceTable() { return $this->_m_offsetToResourceTable; }

        /**
         * Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
         * taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
         */
        public function offsetToResources() { return $this->_m_offsetToResources; }
    }
}
