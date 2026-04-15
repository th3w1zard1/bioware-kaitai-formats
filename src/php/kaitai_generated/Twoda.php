<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * TwoDA (2D Array) files store tabular data in a binary format used by BioWare games
 * including Knights of the Old Republic (KotOR) and The Sith Lords (TSL).
 * 
 * TwoDA files are essentially two-dimensional arrays (tables) with:
 * - Column headers (first row defines column names)
 * - Row labels (first column defines row identifiers)
 * - Cell values (data at row/column intersections)
 * 
 * Binary Format Structure:
 * - File Header (9 bytes): Magic "2DA " (space-padded), version "V2.b", and newline
 * - Column Headers Section: Tab-separated column names, terminated by null byte
 * - Row Count (4 bytes): uint32 indicating number of data rows
 * - Row Labels Section: Tab-separated row labels (one per row)
 * - Cell Offsets Array: Array of uint16 offsets (rowCount * columnCount entries)
 * - Data Size (2 bytes): uint16 indicating total size of cell data section
 * - Cell Values Section: Null-terminated strings at offsets specified in offsets array
 * 
 * The format uses an offset-based string table for cell values, allowing efficient
 * storage of duplicate values (shared strings are stored once and referenced by offset).
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py
 */

namespace {
    class Twoda extends \Kaitai\Struct\Struct {
        public function __construct(int $columnCount, \Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Twoda $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_m_columnCount = $columnCount;
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Twoda\TwodaHeader($this->_io, $this, $this->_root);
            $this->_m_columnHeadersRaw = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(0, false, true, true), "ASCII");
            $this->_m_rowCount = $this->_io->readU4le();
            $this->_m_rowLabelsSection = new \Twoda\RowLabelsSection($this->_io, $this, $this->_root);
            $this->_m_cellOffsets = [];
            $n = $this->rowCount() * $this->columnCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_cellOffsets[] = $this->_io->readU2le();
            }
            $this->_m_lenCellValuesSection = $this->_io->readU2le();
            $this->_m__raw_cellValuesSection = $this->_io->readBytes($this->lenCellValuesSection());
            $_io__raw_cellValuesSection = new \Kaitai\Struct\Stream($this->_m__raw_cellValuesSection);
            $this->_m_cellValuesSection = new \Twoda\CellValuesSection($_io__raw_cellValuesSection, $this, $this->_root);
        }
        protected $_m_header;
        protected $_m_columnHeadersRaw;
        protected $_m_rowCount;
        protected $_m_rowLabelsSection;
        protected $_m_cellOffsets;
        protected $_m_lenCellValuesSection;
        protected $_m_cellValuesSection;
        protected $_m_columnCount;
        protected $_m__raw_cellValuesSection;

        /**
         * TwoDA file header (9 bytes) - magic "2DA ", version "V2.b", and newline character
         */
        public function header() { return $this->_m_header; }

        /**
         * Column headers section as a single null-terminated string.
         * Contains tab-separated column names. The null terminator marks the end.
         * Column names can be extracted by splitting on tab characters (0x09).
         * Example: "col1\tcol2\tcol3\0" represents three columns: "col1", "col2", "col3"
         */
        public function columnHeadersRaw() { return $this->_m_columnHeadersRaw; }

        /**
         * Number of data rows in the TwoDA table.
         * This count determines how many row labels and how many cell entries per column.
         */
        public function rowCount() { return $this->_m_rowCount; }

        /**
         * Row labels section - tab-separated row labels (one per row)
         */
        public function rowLabelsSection() { return $this->_m_rowLabelsSection; }

        /**
         * Array of cell value offsets (uint16 per cell). There are exactly row_count * column_count
         * entries, in row-major order. Each offset is relative to the start of the cell values blob
         * and points to a null-terminated string.
         */
        public function cellOffsets() { return $this->_m_cellOffsets; }

        /**
         * Total size in bytes of the cell values data section.
         * This is the size of all unique cell value strings combined (including null terminators).
         * Not used during reading but stored for format consistency.
         */
        public function lenCellValuesSection() { return $this->_m_lenCellValuesSection; }

        /**
         * Cell values data section containing all unique cell value strings.
         * Each string is null-terminated. Offsets from cell_offsets point into this section.
         * The section starts immediately after len_cell_values_section field and has size = len_cell_values_section bytes.
         */
        public function cellValuesSection() { return $this->_m_cellValuesSection; }

        /**
         * Number of tab-separated column headers in the file (excluding the trailing null terminator).
         * Kaitai expressions cannot derive this from the header blob, so callers must pre-scan the
         * column header section (same rule as PyKotor: count tab characters between the newline after
         * V2.b and the first 0x00) and pass it into the parser.
         */
        public function columnCount() { return $this->_m_columnCount; }
        public function _raw_cellValuesSection() { return $this->_m__raw_cellValuesSection; }
    }
}

namespace Twoda {
    class CellValuesSection extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Twoda $_parent = null, ?\Twoda $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_rawData = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes($this->_root()->lenCellValuesSection()), "ASCII");
        }
        protected $_m_rawData;

        /**
         * Raw cell values data as a single string.
         * Contains all null-terminated cell value strings concatenated together.
         * Individual strings can be extracted using offsets from cell_offsets.
         * Note: To read a specific cell value, seek to (cell_values_section start + offset) and read a null-terminated string.
         */
        public function rawData() { return $this->_m_rawData; }
    }
}

namespace Twoda {
    class RowLabelEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Twoda\RowLabelsSection $_parent = null, ?\Twoda $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_labelValue = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(9, false, true, false), "ASCII");
        }
        protected $_m_labelValue;

        /**
         * Row label value (ASCII string terminated by tab character 0x09).
         * Tab terminator is consumed but not included in the string value.
         * Row labels uniquely identify each row in the table.
         * Often numeric (e.g., "0", "1", "2") but can be any string identifier.
         */
        public function labelValue() { return $this->_m_labelValue; }
    }
}

namespace Twoda {
    class RowLabelsSection extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Twoda $_parent = null, ?\Twoda $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_labels = [];
            $n = $this->_root()->rowCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_labels[] = new \Twoda\RowLabelEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_labels;

        /**
         * Array of row label entries, one per row.
         * Each label is terminated by tab character (0x09).
         * Total count equals row_count from the header.
         * Row labels typically identify each data row (e.g., numeric IDs, names, etc.).
         */
        public function labels() { return $this->_m_labels; }
    }
}

namespace Twoda {
    class TwodaHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Twoda $_parent = null, ?\Twoda $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_magic = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_version = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_newline = $this->_io->readU1();
        }
        protected $_m_isValidTwoda;

        /**
         * Validation check that the file is a valid TwoDA file.
         * All header fields must match expected values.
         */
        public function isValidTwoda() {
            if ($this->_m_isValidTwoda !== null)
                return $this->_m_isValidTwoda;
            $this->_m_isValidTwoda =  (($this->magic() == "2DA ") && ($this->version() == "V2.b") && ($this->newline() == 10)) ;
            return $this->_m_isValidTwoda;
        }
        protected $_m_magic;
        protected $_m_version;
        protected $_m_newline;

        /**
         * File type signature. Must be "2DA " (space-padded).
         * Bytes: 0x32 0x44 0x41 0x20
         * The space after "2DA" is significant and must be present.
         */
        public function magic() { return $this->_m_magic; }

        /**
         * File format version. Always "V2.b" for KotOR/TSL TwoDA files.
         * Bytes: 0x56 0x32 0x2E 0x62
         * This is the binary version identifier (V2.b = Version 2 binary).
         */
        public function version() { return $this->_m_version; }

        /**
         * Newline character (0x0A = '\n').
         * Separates header from column headers section.
         */
        public function newline() { return $this->_m_newline; }
    }
}
