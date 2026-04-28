<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * TLK (Talk Table) files contain all text strings used in the game, both written and spoken.
 * They enable easy localization by providing a lookup table from string reference numbers (StrRef)
 * to localized text and associated voice-over audio files.
 * 
 * Binary Format Structure:
 * - File Header (20 bytes): File type signature, version, language ID, string count, entries offset
 * - String Data Table (40 bytes per entry): Metadata for each string entry (flags, sound ResRef, offsets, lengths)
 * - String Entries (variable size): Sequential null-terminated text strings starting at entries_offset
 * 
 * The format uses a two-level structure:
 * 1. String Data Table: Contains metadata (flags, sound filename, text offset/length) for each entry
 * 2. String Entries: Actual text data stored sequentially, referenced by offsets in the data table
 * 
 * String references (StrRef) are 0-based indices into the string_data_table array. StrRef 0 refers to
 * the first entry, StrRef 1 to the second, etc. StrRef -1 indicates no string reference.
 * 
 * Authoritative index: `meta.xref` and `doc-ref` (PyKotor, xoreos `talktable*` + `talktable_tlk`, xoreos-tools CLIs, reone, KotOR.js, NickHugi/Kotor.NET). Legacy Perl / archived community URLs are omitted when they no longer resolve on GitHub.
 */

namespace {
    class Tlk extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Tlk $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Tlk\TlkHeader($this->_io, $this, $this->_root);
            $this->_m_stringDataTable = new \Tlk\StringDataTable($this->_io, $this, $this->_root);
        }
        protected $_m_header;
        protected $_m_stringDataTable;

        /**
         * TLK file header (20 bytes) - contains file signature, version, language, and counts
         */
        public function header() { return $this->_m_header; }

        /**
         * Array of string data entries (metadata for each string) - 40 bytes per entry
         */
        public function stringDataTable() { return $this->_m_stringDataTable; }
    }
}

namespace Tlk {
    class StringDataEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Tlk\StringDataTable $_parent = null, ?\Tlk $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_flags = $this->_io->readU4le();
            $this->_m_soundResref = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(16), "ASCII");
            $this->_m_volumeVariance = $this->_io->readU4le();
            $this->_m_pitchVariance = $this->_io->readU4le();
            $this->_m_textOffset = $this->_io->readU4le();
            $this->_m_textLength = $this->_io->readU4le();
            $this->_m_soundLength = $this->_io->readF4le();
        }
        protected $_m_entrySize;

        /**
         * Size of each string_data_entry in bytes.
         * Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
         * text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.
         */
        public function entrySize() {
            if ($this->_m_entrySize !== null)
                return $this->_m_entrySize;
            $this->_m_entrySize = 40;
            return $this->_m_entrySize;
        }
        protected $_m_soundLengthPresent;

        /**
         * Whether sound length is valid (bit 2 of flags)
         */
        public function soundLengthPresent() {
            if ($this->_m_soundLengthPresent !== null)
                return $this->_m_soundLengthPresent;
            $this->_m_soundLengthPresent = ($this->flags() & 4) != 0;
            return $this->_m_soundLengthPresent;
        }
        protected $_m_soundPresent;

        /**
         * Whether voice-over audio exists (bit 1 of flags)
         */
        public function soundPresent() {
            if ($this->_m_soundPresent !== null)
                return $this->_m_soundPresent;
            $this->_m_soundPresent = ($this->flags() & 2) != 0;
            return $this->_m_soundPresent;
        }
        protected $_m_textData;

        /**
         * Text string data as raw bytes (read as ASCII for byte-level access).
         * The actual encoding depends on the language_id in the header.
         * Common encodings:
         * - English/French/German/Italian/Spanish: Windows-1252 (cp1252)
         * - Polish: Windows-1250 (cp1250)
         * - Korean: EUC-KR (cp949)
         * - Chinese Traditional: Big5 (cp950)
         * - Chinese Simplified: GB2312 (cp936)
         * - Japanese: Shift-JIS (cp932)
         * 
         * Note: This field reads the raw bytes as ASCII string for byte-level access.
         * The application layer should decode based on the language_id field in the header.
         * To get raw bytes, access the underlying byte representation of this string.
         * 
         * In practice, strings are stored sequentially starting at entries_offset,
         * so text_offset values are relative to entries_offset (0, len1, len1+len2, etc.).
         * 
         * Strings may be null-terminated, but text_length includes the null terminator.
         * Application code should trim null bytes when decoding.
         * 
         * If text_present flag (bit 0) is not set, this field may contain garbage data
         * or be empty. Always check text_present before using this data.
         */
        public function textData() {
            if ($this->_m_textData !== null)
                return $this->_m_textData;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->textFileOffset());
            $this->_m_textData = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes($this->textLength()), "ASCII");
            $this->_io->seek($_pos);
            return $this->_m_textData;
        }
        protected $_m_textFileOffset;

        /**
         * Absolute file offset to the text string.
         * Calculated as entries_offset (from header) + text_offset (from entry).
         */
        public function textFileOffset() {
            if ($this->_m_textFileOffset !== null)
                return $this->_m_textFileOffset;
            $this->_m_textFileOffset = $this->_root()->header()->entriesOffset() + $this->textOffset();
            return $this->_m_textFileOffset;
        }
        protected $_m_textPresent;

        /**
         * Whether text content exists (bit 0 of flags)
         */
        public function textPresent() {
            if ($this->_m_textPresent !== null)
                return $this->_m_textPresent;
            $this->_m_textPresent = ($this->flags() & 1) != 0;
            return $this->_m_textPresent;
        }
        protected $_m_flags;
        protected $_m_soundResref;
        protected $_m_volumeVariance;
        protected $_m_pitchVariance;
        protected $_m_textOffset;
        protected $_m_textLength;
        protected $_m_soundLength;

        /**
         * Bit flags indicating what data is present:
         * - bit 0 (0x0001): Text present - string has text content
         * - bit 1 (0x0002): Sound present - string has associated voice-over audio
         * - bit 2 (0x0004): Sound length present - sound length field is valid
         * 
         * Common flag combinations:
         * - 0x0001: Text only (menu options, item descriptions)
         * - 0x0003: Text + Sound (voiced dialog lines)
         * - 0x0007: Text + Sound + Length (fully voiced with duration)
         * - 0x0000: Empty entry (unused StrRef slots)
         */
        public function flags() { return $this->_m_flags; }

        /**
         * Voice-over audio filename (ResRef), null-terminated ASCII, max 16 chars.
         * If the string is shorter than 16 bytes, it is null-padded.
         * Empty string (all nulls) indicates no voice-over audio.
         */
        public function soundResref() { return $this->_m_soundResref; }

        /**
         * Volume variance (unused in KotOR, always 0).
         * Legacy field from Neverwinter Nights, not used by KotOR engine.
         */
        public function volumeVariance() { return $this->_m_volumeVariance; }

        /**
         * Pitch variance (unused in KotOR, always 0).
         * Legacy field from Neverwinter Nights, not used by KotOR engine.
         */
        public function pitchVariance() { return $this->_m_pitchVariance; }

        /**
         * Offset to string text relative to entries_offset.
         * The actual file offset is: header.entries_offset + text_offset.
         * First string starts at offset 0, subsequent strings follow sequentially.
         */
        public function textOffset() { return $this->_m_textOffset; }

        /**
         * Length of string text in bytes (not characters).
         * For single-byte encodings (Windows-1252, etc.), byte length equals character count.
         * For multi-byte encodings (UTF-8, etc.), byte length may be greater than character count.
         */
        public function textLength() { return $this->_m_textLength; }

        /**
         * Duration of voice-over audio in seconds (float).
         * Only valid if sound_length_present flag (bit 2) is set.
         * Used by the engine to determine how long to wait before auto-advancing dialog.
         */
        public function soundLength() { return $this->_m_soundLength; }
    }
}

namespace Tlk {
    class StringDataTable extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Tlk $_parent = null, ?\Tlk $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_entries = [];
            $n = $this->_root()->header()->stringCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_entries[] = new \Tlk\StringDataEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_entries;

        /**
         * Array of string data entries, one per string in the file
         */
        public function entries() { return $this->_m_entries; }
    }
}

namespace Tlk {
    class TlkHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Tlk $_parent = null, ?\Tlk $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_fileVersion = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_languageId = $this->_io->readU4le();
            $this->_m_stringCount = $this->_io->readU4le();
            $this->_m_entriesOffset = $this->_io->readU4le();
        }
        protected $_m_expectedEntriesOffset;

        /**
         * Expected offset to string entries (header + string data table).
         * Used for validation.
         */
        public function expectedEntriesOffset() {
            if ($this->_m_expectedEntriesOffset !== null)
                return $this->_m_expectedEntriesOffset;
            $this->_m_expectedEntriesOffset = 20 + $this->stringCount() * 40;
            return $this->_m_expectedEntriesOffset;
        }
        protected $_m_headerSize;

        /**
         * Size of the TLK header in bytes
         */
        public function headerSize() {
            if ($this->_m_headerSize !== null)
                return $this->_m_headerSize;
            $this->_m_headerSize = 20;
            return $this->_m_headerSize;
        }
        protected $_m_fileType;
        protected $_m_fileVersion;
        protected $_m_languageId;
        protected $_m_stringCount;
        protected $_m_entriesOffset;

        /**
         * File type signature. Must be "TLK " (space-padded).
         * Validates that this is a TLK file.
         * Note: Validation removed temporarily due to Kaitai Struct parser issues.
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. "V3.0" for KotOR, "V4.0" for Jade Empire.
         * KotOR games use V3.0. Jade Empire uses V4.0.
         * Note: Validation removed due to Kaitai Struct parser limitations with period in string.
         */
        public function fileVersion() { return $this->_m_fileVersion; }

        /**
         * Language identifier:
         * - 0 = English
         * - 1 = French
         * - 2 = German
         * - 3 = Italian
         * - 4 = Spanish
         * - 5 = Polish
         * - 128 = Korean
         * - 129 = Chinese Traditional
         * - 130 = Chinese Simplified
         * - 131 = Japanese
         * See Language enum for complete list.
         */
        public function languageId() { return $this->_m_languageId; }

        /**
         * Number of string entries in the file.
         * Determines the number of entries in string_data_table.
         */
        public function stringCount() { return $this->_m_stringCount; }

        /**
         * Byte offset to string entries array from the beginning of the file.
         * Typically 20 + (string_count * 40) = header size + string data table size.
         * Points to where the actual text strings begin.
         */
        public function entriesOffset() { return $this->_m_entriesOffset; }
    }
}
