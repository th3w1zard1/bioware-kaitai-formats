<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
 * Resource types use `bioware_type_ids`.
 */

namespace {
    class Key extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Key $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_fileType == "KEY ")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("KEY ", $this->_m_fileType, $this->_io, "/seq/0");
            }
            $this->_m_fileVersion = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!( (($this->_m_fileVersion == "V1  ") || ($this->_m_fileVersion == "V1.1")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_fileVersion, $this->_io, "/seq/1");
            }
            $this->_m_bifCount = $this->_io->readU4le();
            $this->_m_keyCount = $this->_io->readU4le();
            $this->_m_fileTableOffset = $this->_io->readU4le();
            $this->_m_keyTableOffset = $this->_io->readU4le();
            $this->_m_buildYear = $this->_io->readU4le();
            $this->_m_buildDay = $this->_io->readU4le();
            $this->_m_reserved = $this->_io->readBytes(32);
        }
        protected $_m_fileTable;

        /**
         * File table containing BIF file entries.
         */
        public function fileTable() {
            if ($this->_m_fileTable !== null)
                return $this->_m_fileTable;
            if ($this->bifCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->fileTableOffset());
                $this->_m_fileTable = new \Key\FileTable($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_fileTable;
        }
        protected $_m_keyTable;

        /**
         * KEY table containing resource entries.
         */
        public function keyTable() {
            if ($this->_m_keyTable !== null)
                return $this->_m_keyTable;
            if ($this->keyCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->keyTableOffset());
                $this->_m_keyTable = new \Key\KeyTable($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_keyTable;
        }
        protected $_m_fileType;
        protected $_m_fileVersion;
        protected $_m_bifCount;
        protected $_m_keyCount;
        protected $_m_fileTableOffset;
        protected $_m_keyTableOffset;
        protected $_m_buildYear;
        protected $_m_buildDay;
        protected $_m_reserved;

        /**
         * File type signature. Must be "KEY " (space-padded).
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. Typically "V1  " or "V1.1".
         */
        public function fileVersion() { return $this->_m_fileVersion; }

        /**
         * Number of BIF files referenced by this KEY file.
         */
        public function bifCount() { return $this->_m_bifCount; }

        /**
         * Number of resource entries in the KEY table.
         */
        public function keyCount() { return $this->_m_keyCount; }

        /**
         * Byte offset to the file table from the beginning of the file.
         */
        public function fileTableOffset() { return $this->_m_fileTableOffset; }

        /**
         * Byte offset to the KEY table from the beginning of the file.
         */
        public function keyTableOffset() { return $this->_m_keyTableOffset; }

        /**
         * Build year (years since 1900).
         */
        public function buildYear() { return $this->_m_buildYear; }

        /**
         * Build day (days since January 1).
         */
        public function buildDay() { return $this->_m_buildDay; }

        /**
         * Reserved padding (usually zeros).
         */
        public function reserved() { return $this->_m_reserved; }
    }
}

namespace Key {
    class FileEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Key\FileTable $_parent = null, ?\Key $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileSize = $this->_io->readU4le();
            $this->_m_filenameOffset = $this->_io->readU4le();
            $this->_m_filenameSize = $this->_io->readU2le();
            $this->_m_drives = $this->_io->readU2le();
        }
        protected $_m_filename;

        /**
         * BIF filename string at the absolute filename_offset in the KEY file.
         */
        public function filename() {
            if ($this->_m_filename !== null)
                return $this->_m_filename;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->filenameOffset());
            $this->_m_filename = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes($this->filenameSize()), "ASCII");
            $this->_io->seek($_pos);
            return $this->_m_filename;
        }
        protected $_m_fileSize;
        protected $_m_filenameOffset;
        protected $_m_filenameSize;
        protected $_m_drives;

        /**
         * Size of the BIF file on disk in bytes.
         */
        public function fileSize() { return $this->_m_fileSize; }

        /**
         * Absolute byte offset from the start of the KEY file where this BIF's filename is stored
         * (seek(filename_offset), then read filename_size bytes).
         * This is not relative to the file table or to the end of the BIF entry array.
         */
        public function filenameOffset() { return $this->_m_filenameOffset; }

        /**
         * Length of the filename in bytes (including null terminator).
         */
        public function filenameSize() { return $this->_m_filenameSize; }

        /**
         * Drive flags indicating which media contains the BIF file.
         * Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
         * Modern distributions typically use 0x0001 (HD) for all files.
         */
        public function drives() { return $this->_m_drives; }
    }
}

namespace Key {
    class FileTable extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Key $_parent = null, ?\Key $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->bifCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Key\FileEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of BIF file entries.
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Key {
    class FilenameTable extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Key $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_filenames = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesFull(), "ASCII");
        }
        protected $_m_filenames;

        /**
         * Null-terminated BIF filenames concatenated together.
         * Each filename is read using the filename_offset and filename_size
         * from the corresponding file_entry.
         */
        public function filenames() { return $this->_m_filenames; }
    }
}

namespace Key {
    class KeyEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Key\KeyTable $_parent = null, ?\Key $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_resref = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(16), "ASCII");
            $this->_m_resourceType = $this->_io->readU2le();
            $this->_m_resourceId = $this->_io->readU4le();
        }
        protected $_m_resref;
        protected $_m_resourceType;
        protected $_m_resourceId;

        /**
         * Resource filename (ResRef) without extension.
         * Null-padded, maximum 16 characters.
         * The game uses this name to access the resource.
         */
        public function resref() { return $this->_m_resref; }

        /**
         * Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
         * `formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).
         */
        public function resourceType() { return $this->_m_resourceType; }

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
        public function resourceId() { return $this->_m_resourceId; }
    }
}

namespace Key {
    class KeyTable extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Key $_parent = null, ?\Key $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->keyCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Key\KeyEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of resource entries.
         */
        public function entries() { return $this->_m_entries; }
    }
}
