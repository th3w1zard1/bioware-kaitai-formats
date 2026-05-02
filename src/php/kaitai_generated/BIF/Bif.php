<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
 * the paired **KEY** (`KEY.ksy`), not in the BIF.
 */

namespace {
    class Bif extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Bif $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_fileType == "BIFF")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("BIFF", $this->_m_fileType, $this->_io, "/seq/0");
            }
            $this->_m_version = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!( (($this->_m_version == "V1  ") || ($this->_m_version == "V1.1")) )) {
                throw new \Kaitai\Struct\Error\ValidationNotAnyOfError($this->_m_version, $this->_io, "/seq/1");
            }
            $this->_m_varResCount = $this->_io->readU4le();
            $this->_m_fixedResCount = $this->_io->readU4le();
            if (!($this->_m_fixedResCount == 0)) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError(0, $this->_m_fixedResCount, $this->_io, "/seq/3");
            }
            $this->_m_varTableOffset = $this->_io->readU4le();
        }
        protected $_m_varResourceTable;

        /**
         * Variable resource table containing entries for each resource.
         */
        public function varResourceTable() {
            if ($this->_m_varResourceTable !== null)
                return $this->_m_varResourceTable;
            if ($this->varResCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->varTableOffset());
                $this->_m_varResourceTable = new \Bif\VarResourceTable($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_varResourceTable;
        }
        protected $_m_fileType;
        protected $_m_version;
        protected $_m_varResCount;
        protected $_m_fixedResCount;
        protected $_m_varTableOffset;

        /**
         * File type signature. Must be "BIFF" for BIF files.
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. Typically "V1  " or "V1.1".
         */
        public function version() { return $this->_m_version; }

        /**
         * Number of variable-size resources in this file.
         */
        public function varResCount() { return $this->_m_varResCount; }

        /**
         * Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
         */
        public function fixedResCount() { return $this->_m_fixedResCount; }

        /**
         * Byte offset to the variable resource table from the beginning of the file.
         */
        public function varTableOffset() { return $this->_m_varTableOffset; }
    }
}

namespace Bif {
    class VarResourceEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bif\VarResourceTable $_parent = null, ?\Bif $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_resourceId = $this->_io->readU4le();
            $this->_m_offset = $this->_io->readU4le();
            $this->_m_fileSize = $this->_io->readU4le();
            $this->_m_resourceType = $this->_io->readU4le();
        }
        protected $_m_resourceId;
        protected $_m_offset;
        protected $_m_fileSize;
        protected $_m_resourceType;

        /**
         * Resource ID (matches KEY file entry).
         * Encodes BIF index (bits 31-20) and resource index (bits 19-0).
         * Formula: resource_id = (bif_index << 20) | resource_index
         */
        public function resourceId() { return $this->_m_resourceId; }

        /**
         * Byte offset to resource data in file (absolute file offset).
         */
        public function offset() { return $this->_m_offset; }

        /**
         * Uncompressed size of resource data in bytes.
         */
        public function fileSize() { return $this->_m_fileSize; }

        /**
         * Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
         * read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
         * `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.
         */
        public function resourceType() { return $this->_m_resourceType; }
    }
}

namespace Bif {
    class VarResourceTable extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bif $_parent = null, ?\Bif $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->varResCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Bif\VarResourceEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of variable resource entries.
         */
        public function entries() { return $this->_m_entries; }
    }
}
