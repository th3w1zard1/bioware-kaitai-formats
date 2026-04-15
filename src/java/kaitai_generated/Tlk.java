// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


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
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk
 * - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/tlkreader.cpp:31-84
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp:42-176
 * - https://github.com/TSLPatcher/TSLPatcher/blob/master/lib/site/Bioware/TLK.pm:1-533
 * - https://github.com/KotOR-Community-Patches/Kotor.NET/blob/master/Kotor.NET/Formats/KotorTLK/TLKBinaryStructure.cs:11-132
 */
public class Tlk extends KaitaiStruct {
    public static Tlk fromFile(String fileName) throws IOException {
        return new Tlk(new ByteBufferKaitaiStream(fileName));
    }

    public Tlk(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Tlk(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Tlk(KaitaiStream _io, KaitaiStruct _parent, Tlk _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new TlkHeader(this._io, this, _root);
        this.stringDataTable = new StringDataTable(this._io, this, _root);
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
        this.stringDataTable._fetchInstances();
    }
    public static class StringDataEntry extends KaitaiStruct {
        public static StringDataEntry fromFile(String fileName) throws IOException {
            return new StringDataEntry(new ByteBufferKaitaiStream(fileName));
        }

        public StringDataEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public StringDataEntry(KaitaiStream _io, Tlk.StringDataTable _parent) {
            this(_io, _parent, null);
        }

        public StringDataEntry(KaitaiStream _io, Tlk.StringDataTable _parent, Tlk _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.flags = this._io.readU4le();
            this.soundResref = new String(this._io.readBytes(16), StandardCharsets.US_ASCII);
            this.volumeVariance = this._io.readU4le();
            this.pitchVariance = this._io.readU4le();
            this.textOffset = this._io.readU4le();
            this.textLength = this._io.readU4le();
            this.soundLength = this._io.readF4le();
        }

        public void _fetchInstances() {
            textData();
            if (this.textData != null) {
            }
        }
        private Byte entrySize;

        /**
         * Size of each string_data_entry in bytes.
         * Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
         * text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.
         */
        public Byte entrySize() {
            if (this.entrySize != null)
                return this.entrySize;
            this.entrySize = ((byte) 40);
            return this.entrySize;
        }
        private Boolean soundLengthPresent;

        /**
         * Whether sound length is valid (bit 2 of flags)
         */
        public Boolean soundLengthPresent() {
            if (this.soundLengthPresent != null)
                return this.soundLengthPresent;
            this.soundLengthPresent = (flags() & 4) != 0;
            return this.soundLengthPresent;
        }
        private Boolean soundPresent;

        /**
         * Whether voice-over audio exists (bit 1 of flags)
         */
        public Boolean soundPresent() {
            if (this.soundPresent != null)
                return this.soundPresent;
            this.soundPresent = (flags() & 2) != 0;
            return this.soundPresent;
        }
        private String textData;

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
        public String textData() {
            if (this.textData != null)
                return this.textData;
            long _pos = this._io.pos();
            this._io.seek(textFileOffset());
            this.textData = new String(this._io.readBytes(textLength()), StandardCharsets.US_ASCII);
            this._io.seek(_pos);
            return this.textData;
        }
        private Integer textFileOffset;

        /**
         * Absolute file offset to the text string.
         * Calculated as entries_offset (from header) + text_offset (from entry).
         */
        public Integer textFileOffset() {
            if (this.textFileOffset != null)
                return this.textFileOffset;
            this.textFileOffset = ((Number) (_root().header().entriesOffset() + textOffset())).intValue();
            return this.textFileOffset;
        }
        private Boolean textPresent;

        /**
         * Whether text content exists (bit 0 of flags)
         */
        public Boolean textPresent() {
            if (this.textPresent != null)
                return this.textPresent;
            this.textPresent = (flags() & 1) != 0;
            return this.textPresent;
        }
        private long flags;
        private String soundResref;
        private long volumeVariance;
        private long pitchVariance;
        private long textOffset;
        private long textLength;
        private float soundLength;
        private Tlk _root;
        private Tlk.StringDataTable _parent;

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
        public long flags() { return flags; }

        /**
         * Voice-over audio filename (ResRef), null-terminated ASCII, max 16 chars.
         * If the string is shorter than 16 bytes, it is null-padded.
         * Empty string (all nulls) indicates no voice-over audio.
         */
        public String soundResref() { return soundResref; }

        /**
         * Volume variance (unused in KotOR, always 0).
         * Legacy field from Neverwinter Nights, not used by KotOR engine.
         */
        public long volumeVariance() { return volumeVariance; }

        /**
         * Pitch variance (unused in KotOR, always 0).
         * Legacy field from Neverwinter Nights, not used by KotOR engine.
         */
        public long pitchVariance() { return pitchVariance; }

        /**
         * Offset to string text relative to entries_offset.
         * The actual file offset is: header.entries_offset + text_offset.
         * First string starts at offset 0, subsequent strings follow sequentially.
         */
        public long textOffset() { return textOffset; }

        /**
         * Length of string text in bytes (not characters).
         * For single-byte encodings (Windows-1252, etc.), byte length equals character count.
         * For multi-byte encodings (UTF-8, etc.), byte length may be greater than character count.
         */
        public long textLength() { return textLength; }

        /**
         * Duration of voice-over audio in seconds (float).
         * Only valid if sound_length_present flag (bit 2) is set.
         * Used by the engine to determine how long to wait before auto-advancing dialog.
         */
        public float soundLength() { return soundLength; }
        public Tlk _root() { return _root; }
        public Tlk.StringDataTable _parent() { return _parent; }
    }
    public static class StringDataTable extends KaitaiStruct {
        public static StringDataTable fromFile(String fileName) throws IOException {
            return new StringDataTable(new ByteBufferKaitaiStream(fileName));
        }

        public StringDataTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public StringDataTable(KaitaiStream _io, Tlk _parent) {
            this(_io, _parent, null);
        }

        public StringDataTable(KaitaiStream _io, Tlk _parent, Tlk _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<StringDataEntry>();
            for (int i = 0; i < _root().header().stringCount(); i++) {
                this.entries.add(new StringDataEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<StringDataEntry> entries;
        private Tlk _root;
        private Tlk _parent;

        /**
         * Array of string data entries, one per string in the file
         */
        public List<StringDataEntry> entries() { return entries; }
        public Tlk _root() { return _root; }
        public Tlk _parent() { return _parent; }
    }
    public static class TlkHeader extends KaitaiStruct {
        public static TlkHeader fromFile(String fileName) throws IOException {
            return new TlkHeader(new ByteBufferKaitaiStream(fileName));
        }

        public TlkHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public TlkHeader(KaitaiStream _io, Tlk _parent) {
            this(_io, _parent, null);
        }

        public TlkHeader(KaitaiStream _io, Tlk _parent, Tlk _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            this.fileVersion = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            this.languageId = this._io.readU4le();
            this.stringCount = this._io.readU4le();
            this.entriesOffset = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private Integer expectedEntriesOffset;

        /**
         * Expected offset to string entries (header + string data table).
         * Used for validation.
         */
        public Integer expectedEntriesOffset() {
            if (this.expectedEntriesOffset != null)
                return this.expectedEntriesOffset;
            this.expectedEntriesOffset = ((Number) (20 + stringCount() * 40)).intValue();
            return this.expectedEntriesOffset;
        }
        private Byte headerSize;

        /**
         * Size of the TLK header in bytes
         */
        public Byte headerSize() {
            if (this.headerSize != null)
                return this.headerSize;
            this.headerSize = ((byte) 20);
            return this.headerSize;
        }
        private String fileType;
        private String fileVersion;
        private long languageId;
        private long stringCount;
        private long entriesOffset;
        private Tlk _root;
        private Tlk _parent;

        /**
         * File type signature. Must be "TLK " (space-padded).
         * Validates that this is a TLK file.
         * Note: Validation removed temporarily due to Kaitai Struct parser issues.
         */
        public String fileType() { return fileType; }

        /**
         * File format version. "V3.0" for KotOR, "V4.0" for Jade Empire.
         * KotOR games use V3.0. Jade Empire uses V4.0.
         * Note: Validation removed due to Kaitai Struct parser limitations with period in string.
         */
        public String fileVersion() { return fileVersion; }

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
        public long languageId() { return languageId; }

        /**
         * Number of string entries in the file.
         * Determines the number of entries in string_data_table.
         */
        public long stringCount() { return stringCount; }

        /**
         * Byte offset to string entries array from the beginning of the file.
         * Typically 20 + (string_count * 40) = header size + string data table size.
         * Points to where the actual text strings begin.
         */
        public long entriesOffset() { return entriesOffset; }
        public Tlk _root() { return _root; }
        public Tlk _parent() { return _parent; }
    }
    private TlkHeader header;
    private StringDataTable stringDataTable;
    private Tlk _root;
    private KaitaiStruct _parent;

    /**
     * TLK file header (20 bytes) - contains file signature, version, language, and counts
     */
    public TlkHeader header() { return header; }

    /**
     * Array of string data entries (metadata for each string) - 40 bytes per entry
     */
    public StringDataTable stringDataTable() { return stringDataTable; }
    public Tlk _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
