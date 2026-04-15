<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
 * tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).
 * 
 * **Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.
 */

namespace {
    class Pcc extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Pcc $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Pcc\FileHeader($this->_io, $this, $this->_root);
        }
        protected $_m_compressionType;

        /**
         * Compression algorithm used (0=None, 1=Zlib, 2=LZO).
         */
        public function compressionType() {
            if ($this->_m_compressionType !== null)
                return $this->_m_compressionType;
            $this->_m_compressionType = $this->header()->compressionType();
            return $this->_m_compressionType;
        }
        protected $_m_exportTable;

        /**
         * Table containing all objects exported from this package.
         */
        public function exportTable() {
            if ($this->_m_exportTable !== null)
                return $this->_m_exportTable;
            if ($this->header()->exportCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->exportTableOffset());
                $this->_m_exportTable = new \Pcc\ExportTable($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_exportTable;
        }
        protected $_m_importTable;

        /**
         * Table containing references to external packages and classes.
         */
        public function importTable() {
            if ($this->_m_importTable !== null)
                return $this->_m_importTable;
            if ($this->header()->importCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->importTableOffset());
                $this->_m_importTable = new \Pcc\ImportTable($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_importTable;
        }
        protected $_m_isCompressed;

        /**
         * True if package uses compressed chunks (bit 25 of package_flags).
         */
        public function isCompressed() {
            if ($this->_m_isCompressed !== null)
                return $this->_m_isCompressed;
            $this->_m_isCompressed = ($this->header()->packageFlags() & 33554432) != 0;
            return $this->_m_isCompressed;
        }
        protected $_m_nameTable;

        /**
         * Table containing all string names used in the package.
         */
        public function nameTable() {
            if ($this->_m_nameTable !== null)
                return $this->_m_nameTable;
            if ($this->header()->nameCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->header()->nameTableOffset());
                $this->_m_nameTable = new \Pcc\NameTable($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_nameTable;
        }
        protected $_m_header;

        /**
         * File header containing format metadata and table offsets.
         */
        public function header() { return $this->_m_header; }
    }
}

namespace Pcc {
    class ExportEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Pcc\ExportTable $_parent = null, ?\Pcc $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_classIndex = $this->_io->readS4le();
            $this->_m_superClassIndex = $this->_io->readS4le();
            $this->_m_link = $this->_io->readS4le();
            $this->_m_objectNameIndex = $this->_io->readS4le();
            $this->_m_objectNameNumber = $this->_io->readS4le();
            $this->_m_archetypeIndex = $this->_io->readS4le();
            $this->_m_objectFlags = $this->_io->readU8le();
            $this->_m_dataSize = $this->_io->readU4le();
            $this->_m_dataOffset = $this->_io->readU4le();
            $this->_m_unknown1 = $this->_io->readU4le();
            $this->_m_numComponents = $this->_io->readS4le();
            $this->_m_unknown2 = $this->_io->readU4le();
            $this->_m_guid = new \Pcc\Guid($this->_io, $this, $this->_root);
            if ($this->numComponents() > 0) {
                $this->_m_components = [];
                $n = $this->numComponents();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_components[] = $this->_io->readS4le();
                }
            }
        }
        protected $_m_classIndex;
        protected $_m_superClassIndex;
        protected $_m_link;
        protected $_m_objectNameIndex;
        protected $_m_objectNameNumber;
        protected $_m_archetypeIndex;
        protected $_m_objectFlags;
        protected $_m_dataSize;
        protected $_m_dataOffset;
        protected $_m_unknown1;
        protected $_m_numComponents;
        protected $_m_unknown2;
        protected $_m_guid;
        protected $_m_components;

        /**
         * Object index for the class.
         * Negative = import table index
         * Positive = export table index
         * Zero = no class
         */
        public function classIndex() { return $this->_m_classIndex; }

        /**
         * Object index for the super class.
         * Negative = import table index
         * Positive = export table index
         * Zero = no super class
         */
        public function superClassIndex() { return $this->_m_superClassIndex; }

        /**
         * Link to other objects (internal reference).
         */
        public function link() { return $this->_m_link; }

        /**
         * Index into name table for the object name.
         */
        public function objectNameIndex() { return $this->_m_objectNameIndex; }

        /**
         * Object name number (for duplicate names).
         */
        public function objectNameNumber() { return $this->_m_objectNameNumber; }

        /**
         * Object index for the archetype.
         * Negative = import table index
         * Positive = export table index
         * Zero = no archetype
         */
        public function archetypeIndex() { return $this->_m_archetypeIndex; }

        /**
         * Object flags bitfield (64-bit).
         */
        public function objectFlags() { return $this->_m_objectFlags; }

        /**
         * Size of the export data in bytes.
         */
        public function dataSize() { return $this->_m_dataSize; }

        /**
         * Byte offset to the export data from the beginning of the file.
         */
        public function dataOffset() { return $this->_m_dataOffset; }

        /**
         * Unknown field.
         */
        public function unknown1() { return $this->_m_unknown1; }

        /**
         * Number of component entries (can be negative).
         */
        public function numComponents() { return $this->_m_numComponents; }

        /**
         * Unknown field.
         */
        public function unknown2() { return $this->_m_unknown2; }

        /**
         * GUID for this export object.
         */
        public function guid() { return $this->_m_guid; }

        /**
         * Array of component indices.
         * Only present if num_components > 0.
         */
        public function components() { return $this->_m_components; }
    }
}

namespace Pcc {
    class ExportTable extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Pcc $_parent = null, ?\Pcc $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->exportCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Pcc\ExportEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of export entries.
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Pcc {
    class FileHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Pcc $_parent = null, ?\Pcc $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_magic = $this->_io->readU4le();
            if (!($this->_m_magic == 2653586369)) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError(2653586369, $this->_m_magic, $this->_io, "/types/file_header/seq/0");
            }
            $this->_m_version = $this->_io->readU4le();
            $this->_m_licenseeVersion = $this->_io->readU4le();
            $this->_m_headerSize = $this->_io->readS4le();
            $this->_m_packageName = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(10), "UTF-16LE");
            $this->_m_packageFlags = $this->_io->readU4le();
            $this->_m_packageType = $this->_io->readU4le();
            $this->_m_nameCount = $this->_io->readU4le();
            $this->_m_nameTableOffset = $this->_io->readU4le();
            $this->_m_exportCount = $this->_io->readU4le();
            $this->_m_exportTableOffset = $this->_io->readU4le();
            $this->_m_importCount = $this->_io->readU4le();
            $this->_m_importTableOffset = $this->_io->readU4le();
            $this->_m_dependOffset = $this->_io->readU4le();
            $this->_m_dependCount = $this->_io->readU4le();
            $this->_m_guidPart1 = $this->_io->readU4le();
            $this->_m_guidPart2 = $this->_io->readU4le();
            $this->_m_guidPart3 = $this->_io->readU4le();
            $this->_m_guidPart4 = $this->_io->readU4le();
            $this->_m_generations = $this->_io->readU4le();
            $this->_m_exportCountDup = $this->_io->readU4le();
            $this->_m_nameCountDup = $this->_io->readU4le();
            $this->_m_unknown1 = $this->_io->readU4le();
            $this->_m_engineVersion = $this->_io->readU4le();
            $this->_m_cookerVersion = $this->_io->readU4le();
            $this->_m_compressionFlags = $this->_io->readU4le();
            $this->_m_packageSource = $this->_io->readU4le();
            $this->_m_compressionType = $this->_io->readU4le();
            $this->_m_chunkCount = $this->_io->readU4le();
        }
        protected $_m_magic;
        protected $_m_version;
        protected $_m_licenseeVersion;
        protected $_m_headerSize;
        protected $_m_packageName;
        protected $_m_packageFlags;
        protected $_m_packageType;
        protected $_m_nameCount;
        protected $_m_nameTableOffset;
        protected $_m_exportCount;
        protected $_m_exportTableOffset;
        protected $_m_importCount;
        protected $_m_importTableOffset;
        protected $_m_dependOffset;
        protected $_m_dependCount;
        protected $_m_guidPart1;
        protected $_m_guidPart2;
        protected $_m_guidPart3;
        protected $_m_guidPart4;
        protected $_m_generations;
        protected $_m_exportCountDup;
        protected $_m_nameCountDup;
        protected $_m_unknown1;
        protected $_m_engineVersion;
        protected $_m_cookerVersion;
        protected $_m_compressionFlags;
        protected $_m_packageSource;
        protected $_m_compressionType;
        protected $_m_chunkCount;

        /**
         * Magic number identifying PCC format. Must be 0x9E2A83C1.
         */
        public function magic() { return $this->_m_magic; }

        /**
         * File format version.
         * Encoded as: (major << 16) | (minor << 8) | patch
         * Example: 0xC202AC = 194/684 (major=194, minor=684)
         */
        public function version() { return $this->_m_version; }

        /**
         * Licensee-specific version field (typically 0x67C).
         */
        public function licenseeVersion() { return $this->_m_licenseeVersion; }

        /**
         * Header size field (typically -5 = 0xFFFFFFFB).
         */
        public function headerSize() { return $this->_m_headerSize; }

        /**
         * Package name (typically "None" = 0x4E006F006E006500).
         */
        public function packageName() { return $this->_m_packageName; }

        /**
         * Package flags bitfield.
         * Bit 25 (0x2000000): Compressed package
         * Bit 20 (0x100000): ME3Explorer edited format flag
         * Other bits: Various package attributes
         */
        public function packageFlags() { return $this->_m_packageFlags; }

        /**
         * Package type indicator (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_package_kind`
         * (LegendaryExplorer PCC wiki).
         */
        public function packageType() { return $this->_m_packageType; }

        /**
         * Number of entries in the name table.
         */
        public function nameCount() { return $this->_m_nameCount; }

        /**
         * Byte offset to the name table from the beginning of the file.
         */
        public function nameTableOffset() { return $this->_m_nameTableOffset; }

        /**
         * Number of entries in the export table.
         */
        public function exportCount() { return $this->_m_exportCount; }

        /**
         * Byte offset to the export table from the beginning of the file.
         */
        public function exportTableOffset() { return $this->_m_exportTableOffset; }

        /**
         * Number of entries in the import table.
         */
        public function importCount() { return $this->_m_importCount; }

        /**
         * Byte offset to the import table from the beginning of the file.
         */
        public function importTableOffset() { return $this->_m_importTableOffset; }

        /**
         * Offset to dependency table (typically 0x664).
         */
        public function dependOffset() { return $this->_m_dependOffset; }

        /**
         * Number of dependencies (typically 0x67C).
         */
        public function dependCount() { return $this->_m_dependCount; }

        /**
         * First 32 bits of package GUID.
         */
        public function guidPart1() { return $this->_m_guidPart1; }

        /**
         * Second 32 bits of package GUID.
         */
        public function guidPart2() { return $this->_m_guidPart2; }

        /**
         * Third 32 bits of package GUID.
         */
        public function guidPart3() { return $this->_m_guidPart3; }

        /**
         * Fourth 32 bits of package GUID.
         */
        public function guidPart4() { return $this->_m_guidPart4; }

        /**
         * Number of generation entries.
         */
        public function generations() { return $this->_m_generations; }

        /**
         * Duplicate export count (should match export_count).
         */
        public function exportCountDup() { return $this->_m_exportCountDup; }

        /**
         * Duplicate name count (should match name_count).
         */
        public function nameCountDup() { return $this->_m_nameCountDup; }

        /**
         * Unknown field (typically 0x0).
         */
        public function unknown1() { return $this->_m_unknown1; }

        /**
         * Engine version (typically 0x18EF = 6383).
         */
        public function engineVersion() { return $this->_m_engineVersion; }

        /**
         * Cooker version (typically 0x3006B = 196715).
         */
        public function cookerVersion() { return $this->_m_cookerVersion; }

        /**
         * Compression flags (typically 0x15330000).
         */
        public function compressionFlags() { return $this->_m_compressionFlags; }

        /**
         * Package source identifier (typically 0x8AA0000).
         */
        public function packageSource() { return $this->_m_packageSource; }

        /**
         * Compression codec when package is compressed (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_compression_codec`
         * (LegendaryExplorer PCC wiki). Unused / undefined when uncompressed.
         */
        public function compressionType() { return $this->_m_compressionType; }

        /**
         * Number of compressed chunks (0 for uncompressed, 1 for compressed).
         * If > 0, file uses compressed structure with chunks.
         */
        public function chunkCount() { return $this->_m_chunkCount; }
    }
}

namespace Pcc {
    class Guid extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Pcc\ExportEntry $_parent = null, ?\Pcc $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_part1 = $this->_io->readU4le();
            $this->_m_part2 = $this->_io->readU4le();
            $this->_m_part3 = $this->_io->readU4le();
            $this->_m_part4 = $this->_io->readU4le();
        }
        protected $_m_part1;
        protected $_m_part2;
        protected $_m_part3;
        protected $_m_part4;

        /**
         * First 32 bits of GUID.
         */
        public function part1() { return $this->_m_part1; }

        /**
         * Second 32 bits of GUID.
         */
        public function part2() { return $this->_m_part2; }

        /**
         * Third 32 bits of GUID.
         */
        public function part3() { return $this->_m_part3; }

        /**
         * Fourth 32 bits of GUID.
         */
        public function part4() { return $this->_m_part4; }
    }
}

namespace Pcc {
    class ImportEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Pcc\ImportTable $_parent = null, ?\Pcc $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_packageNameIndex = $this->_io->readS8le();
            $this->_m_classNameIndex = $this->_io->readS4le();
            $this->_m_link = $this->_io->readS8le();
            $this->_m_importNameIndex = $this->_io->readS8le();
        }
        protected $_m_packageNameIndex;
        protected $_m_classNameIndex;
        protected $_m_link;
        protected $_m_importNameIndex;

        /**
         * Index into name table for package name.
         * Negative value indicates import from external package.
         * Positive value indicates import from this package.
         */
        public function packageNameIndex() { return $this->_m_packageNameIndex; }

        /**
         * Index into name table for class name.
         */
        public function classNameIndex() { return $this->_m_classNameIndex; }

        /**
         * Link to import/export table entry.
         * Used to resolve the actual object reference.
         */
        public function link() { return $this->_m_link; }

        /**
         * Index into name table for the imported object name.
         */
        public function importNameIndex() { return $this->_m_importNameIndex; }
    }
}

namespace Pcc {
    class ImportTable extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Pcc $_parent = null, ?\Pcc $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->importCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Pcc\ImportEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of import entries.
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Pcc {
    class NameEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Pcc\NameTable $_parent = null, ?\Pcc $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_length = $this->_io->readS4le();
            $this->_m_name = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(($this->length() < 0 ? -($this->length()) : $this->length()) * 2), "UTF-16LE");
        }
        protected $_m_absLength;

        /**
         * Absolute value of length for size calculation
         */
        public function absLength() {
            if ($this->_m_absLength !== null)
                return $this->_m_absLength;
            $this->_m_absLength = ($this->length() < 0 ? -($this->length()) : $this->length());
            return $this->_m_absLength;
        }
        protected $_m_nameSize;

        /**
         * Size of name string in bytes (absolute length * 2 bytes per WCHAR)
         */
        public function nameSize() {
            if ($this->_m_nameSize !== null)
                return $this->_m_nameSize;
            $this->_m_nameSize = $this->absLength() * 2;
            return $this->_m_nameSize;
        }
        protected $_m_length;
        protected $_m_name;

        /**
         * Length of the name string in characters (signed).
         * Negative value indicates the number of WCHAR characters.
         * Positive value is also valid but less common.
         */
        public function length() { return $this->_m_length; }

        /**
         * Name string encoded as UTF-16LE (WCHAR).
         * Size is absolute value of length * 2 bytes per character.
         * Negative length indicates WCHAR count (use absolute value).
         */
        public function name() { return $this->_m_name; }
    }
}

namespace Pcc {
    class NameTable extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Pcc $_parent = null, ?\Pcc $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->nameCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Pcc\NameEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of name entries.
         */
        public function entries() { return $this->_m_entries; }
    }
}
