// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Tlk || (root.Tlk = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Tlk_, KaitaiStream) {
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
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk|PyKotor wiki — TLK}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk.py#L23-L196|PyKotor — `io_tlk` (sizes, Kaitai + legacy + write)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp#L35-L69|xoreos — `TalkTable::load` (factory dispatch)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L40-L114|xoreos — TLK id/version + `TalkTable_TLK::load` + V3/V4 entry tables}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L87|xoreos — `kFileTypeTLK`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73|xoreos — `Language` / `LanguageGender` (TLK `language_id` / substring packing)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/tlk2xml.cpp#L56-L80|xoreos-tools — `tlk2xml` CLI (`main`)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/xml2tlk.cpp#L58-L85|xoreos-tools — `xml2tlk` CLI (`main`)}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/resource/format/tlkreader.cpp#L27-L67|reone — `TlkReader`}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TLKObject.ts#L16-L77|KotOR.js — `TLKObject`}
 * @see {@link https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorTLK/TLKBinaryReader.cs|NickHugi/Kotor.NET — `TLKBinaryReader`}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/TalkTable_Format.pdf|xoreos-docs — TalkTable_Format.pdf}
 */

var Tlk = (function() {
  function Tlk(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Tlk.prototype._read = function() {
    this.header = new TlkHeader(this._io, this, this._root);
    this.stringDataTable = new StringDataTable(this._io, this, this._root);
  }

  var StringDataEntry = Tlk.StringDataEntry = (function() {
    function StringDataEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    StringDataEntry.prototype._read = function() {
      this.flags = this._io.readU4le();
      this.soundResref = KaitaiStream.bytesToStr(this._io.readBytes(16), "ASCII");
      this.volumeVariance = this._io.readU4le();
      this.pitchVariance = this._io.readU4le();
      this.textOffset = this._io.readU4le();
      this.textLength = this._io.readU4le();
      this.soundLength = this._io.readF4le();
    }

    /**
     * Size of each string_data_entry in bytes.
     * Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
     * text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.
     */
    Object.defineProperty(StringDataEntry.prototype, 'entrySize', {
      get: function() {
        if (this._m_entrySize !== undefined)
          return this._m_entrySize;
        this._m_entrySize = 40;
        return this._m_entrySize;
      }
    });

    /**
     * Whether sound length is valid (bit 2 of flags)
     */
    Object.defineProperty(StringDataEntry.prototype, 'soundLengthPresent', {
      get: function() {
        if (this._m_soundLengthPresent !== undefined)
          return this._m_soundLengthPresent;
        this._m_soundLengthPresent = (this.flags & 4) != 0;
        return this._m_soundLengthPresent;
      }
    });

    /**
     * Whether voice-over audio exists (bit 1 of flags)
     */
    Object.defineProperty(StringDataEntry.prototype, 'soundPresent', {
      get: function() {
        if (this._m_soundPresent !== undefined)
          return this._m_soundPresent;
        this._m_soundPresent = (this.flags & 2) != 0;
        return this._m_soundPresent;
      }
    });

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
    Object.defineProperty(StringDataEntry.prototype, 'textData', {
      get: function() {
        if (this._m_textData !== undefined)
          return this._m_textData;
        var _pos = this._io.pos;
        this._io.seek(this.textFileOffset);
        this._m_textData = KaitaiStream.bytesToStr(this._io.readBytes(this.textLength), "ASCII");
        this._io.seek(_pos);
        return this._m_textData;
      }
    });

    /**
     * Absolute file offset to the text string.
     * Calculated as entries_offset (from header) + text_offset (from entry).
     */
    Object.defineProperty(StringDataEntry.prototype, 'textFileOffset', {
      get: function() {
        if (this._m_textFileOffset !== undefined)
          return this._m_textFileOffset;
        this._m_textFileOffset = this._root.header.entriesOffset + this.textOffset;
        return this._m_textFileOffset;
      }
    });

    /**
     * Whether text content exists (bit 0 of flags)
     */
    Object.defineProperty(StringDataEntry.prototype, 'textPresent', {
      get: function() {
        if (this._m_textPresent !== undefined)
          return this._m_textPresent;
        this._m_textPresent = (this.flags & 1) != 0;
        return this._m_textPresent;
      }
    });

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

    /**
     * Voice-over audio filename (ResRef), null-terminated ASCII, max 16 chars.
     * If the string is shorter than 16 bytes, it is null-padded.
     * Empty string (all nulls) indicates no voice-over audio.
     */

    /**
     * Volume variance (unused in KotOR, always 0).
     * Legacy field from Neverwinter Nights, not used by KotOR engine.
     */

    /**
     * Pitch variance (unused in KotOR, always 0).
     * Legacy field from Neverwinter Nights, not used by KotOR engine.
     */

    /**
     * Offset to string text relative to entries_offset.
     * The actual file offset is: header.entries_offset + text_offset.
     * First string starts at offset 0, subsequent strings follow sequentially.
     */

    /**
     * Length of string text in bytes (not characters).
     * For single-byte encodings (Windows-1252, etc.), byte length equals character count.
     * For multi-byte encodings (UTF-8, etc.), byte length may be greater than character count.
     */

    /**
     * Duration of voice-over audio in seconds (float).
     * Only valid if sound_length_present flag (bit 2) is set.
     * Used by the engine to determine how long to wait before auto-advancing dialog.
     */

    return StringDataEntry;
  })();

  var StringDataTable = Tlk.StringDataTable = (function() {
    function StringDataTable(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    StringDataTable.prototype._read = function() {
      this.entries = [];
      for (var i = 0; i < this._root.header.stringCount; i++) {
        this.entries.push(new StringDataEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of string data entries, one per string in the file
     */

    return StringDataTable;
  })();

  var TlkHeader = Tlk.TlkHeader = (function() {
    function TlkHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    TlkHeader.prototype._read = function() {
      this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      this.languageId = this._io.readU4le();
      this.stringCount = this._io.readU4le();
      this.entriesOffset = this._io.readU4le();
    }

    /**
     * Expected offset to string entries (header + string data table).
     * Used for validation.
     */
    Object.defineProperty(TlkHeader.prototype, 'expectedEntriesOffset', {
      get: function() {
        if (this._m_expectedEntriesOffset !== undefined)
          return this._m_expectedEntriesOffset;
        this._m_expectedEntriesOffset = 20 + this.stringCount * 40;
        return this._m_expectedEntriesOffset;
      }
    });

    /**
     * Size of the TLK header in bytes
     */
    Object.defineProperty(TlkHeader.prototype, 'headerSize', {
      get: function() {
        if (this._m_headerSize !== undefined)
          return this._m_headerSize;
        this._m_headerSize = 20;
        return this._m_headerSize;
      }
    });

    /**
     * File type signature. Must be "TLK " (space-padded).
     * Validates that this is a TLK file.
     * Note: Validation removed temporarily due to Kaitai Struct parser issues.
     */

    /**
     * File format version. "V3.0" for KotOR, "V4.0" for Jade Empire.
     * KotOR games use V3.0. Jade Empire uses V4.0.
     * Note: Validation removed due to Kaitai Struct parser limitations with period in string.
     */

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

    /**
     * Number of string entries in the file.
     * Determines the number of entries in string_data_table.
     */

    /**
     * Byte offset to string entries array from the beginning of the file.
     * Typically 20 + (string_count * 40) = header size + string data table size.
     * Points to where the actual text strings begin.
     */

    return TlkHeader;
  })();

  /**
   * TLK file header (20 bytes) - contains file signature, version, language, and counts
   */

  /**
   * Array of string data entries (metadata for each string) - 40 bytes per entry
   */

  return Tlk;
})();
Tlk_.Tlk = Tlk;
});
