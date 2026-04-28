#ifndef TLK_H_
#define TLK_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class tlk_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

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
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk PyKotor wiki — TLK
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk.py#L23-L196 PyKotor — `io_tlk` (sizes, Kaitai + legacy + write)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp#L35-L69 xoreos — `TalkTable::load` (factory dispatch)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L40-L114 xoreos — TLK id/version + `TalkTable_TLK::load` + V3/V4 entry tables
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L87 xoreos — `kFileTypeTLK`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73 xoreos — `Language` / `LanguageGender` (TLK `language_id` / substring packing)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/tlk2xml.cpp#L56-L80 xoreos-tools — `tlk2xml` CLI (`main`)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/xml2tlk.cpp#L58-L85 xoreos-tools — `xml2tlk` CLI (`main`)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/tlkreader.cpp#L27-L67 reone — `TlkReader`
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TLKObject.ts#L16-L77 KotOR.js — `TLKObject`
 * \sa https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorTLK/TLKBinaryReader.cs NickHugi/Kotor.NET — `TLKBinaryReader`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/TalkTable_Format.pdf xoreos-docs — TalkTable_Format.pdf
 */

class tlk_t : public kaitai::kstruct {

public:
    class string_data_entry_t;
    class string_data_table_t;
    class tlk_header_t;

    tlk_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, tlk_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~tlk_t();

    class string_data_entry_t : public kaitai::kstruct {

    public:

        string_data_entry_t(kaitai::kstream* p__io, tlk_t::string_data_table_t* p__parent = 0, tlk_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~string_data_entry_t();

    private:
        bool f_entry_size;
        int8_t m_entry_size;

    public:

        /**
         * Size of each string_data_entry in bytes.
         * Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
         * text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.
         */
        int8_t entry_size();

    private:
        bool f_sound_length_present;
        bool m_sound_length_present;

    public:

        /**
         * Whether sound length is valid (bit 2 of flags)
         */
        bool sound_length_present();

    private:
        bool f_sound_present;
        bool m_sound_present;

    public:

        /**
         * Whether voice-over audio exists (bit 1 of flags)
         */
        bool sound_present();

    private:
        bool f_text_data;
        std::string m_text_data;

    public:

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
        std::string text_data();

    private:
        bool f_text_file_offset;
        int32_t m_text_file_offset;

    public:

        /**
         * Absolute file offset to the text string.
         * Calculated as entries_offset (from header) + text_offset (from entry).
         */
        int32_t text_file_offset();

    private:
        bool f_text_present;
        bool m_text_present;

    public:

        /**
         * Whether text content exists (bit 0 of flags)
         */
        bool text_present();

    private:
        uint32_t m_flags;
        std::string m_sound_resref;
        uint32_t m_volume_variance;
        uint32_t m_pitch_variance;
        uint32_t m_text_offset;
        uint32_t m_text_length;
        float m_sound_length;
        tlk_t* m__root;
        tlk_t::string_data_table_t* m__parent;

    public:

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
        uint32_t flags() const { return m_flags; }

        /**
         * Voice-over audio filename (ResRef), null-terminated ASCII, max 16 chars.
         * If the string is shorter than 16 bytes, it is null-padded.
         * Empty string (all nulls) indicates no voice-over audio.
         */
        std::string sound_resref() const { return m_sound_resref; }

        /**
         * Volume variance (unused in KotOR, always 0).
         * Legacy field from Neverwinter Nights, not used by KotOR engine.
         */
        uint32_t volume_variance() const { return m_volume_variance; }

        /**
         * Pitch variance (unused in KotOR, always 0).
         * Legacy field from Neverwinter Nights, not used by KotOR engine.
         */
        uint32_t pitch_variance() const { return m_pitch_variance; }

        /**
         * Offset to string text relative to entries_offset.
         * The actual file offset is: header.entries_offset + text_offset.
         * First string starts at offset 0, subsequent strings follow sequentially.
         */
        uint32_t text_offset() const { return m_text_offset; }

        /**
         * Length of string text in bytes (not characters).
         * For single-byte encodings (Windows-1252, etc.), byte length equals character count.
         * For multi-byte encodings (UTF-8, etc.), byte length may be greater than character count.
         */
        uint32_t text_length() const { return m_text_length; }

        /**
         * Duration of voice-over audio in seconds (float).
         * Only valid if sound_length_present flag (bit 2) is set.
         * Used by the engine to determine how long to wait before auto-advancing dialog.
         */
        float sound_length() const { return m_sound_length; }
        tlk_t* _root() const { return m__root; }
        tlk_t::string_data_table_t* _parent() const { return m__parent; }
    };

    class string_data_table_t : public kaitai::kstruct {

    public:

        string_data_table_t(kaitai::kstream* p__io, tlk_t* p__parent = 0, tlk_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~string_data_table_t();

    private:
        std::vector<string_data_entry_t*>* m_entries;
        tlk_t* m__root;
        tlk_t* m__parent;

    public:

        /**
         * Array of string data entries, one per string in the file
         */
        std::vector<string_data_entry_t*>* entries() const { return m_entries; }
        tlk_t* _root() const { return m__root; }
        tlk_t* _parent() const { return m__parent; }
    };

    class tlk_header_t : public kaitai::kstruct {

    public:

        tlk_header_t(kaitai::kstream* p__io, tlk_t* p__parent = 0, tlk_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~tlk_header_t();

    private:
        bool f_expected_entries_offset;
        int32_t m_expected_entries_offset;

    public:

        /**
         * Expected offset to string entries (header + string data table).
         * Used for validation.
         */
        int32_t expected_entries_offset();

    private:
        bool f_header_size;
        int8_t m_header_size;

    public:

        /**
         * Size of the TLK header in bytes
         */
        int8_t header_size();

    private:
        std::string m_file_type;
        std::string m_file_version;
        uint32_t m_language_id;
        uint32_t m_string_count;
        uint32_t m_entries_offset;
        tlk_t* m__root;
        tlk_t* m__parent;

    public:

        /**
         * File type signature. Must be "TLK " (space-padded).
         * Validates that this is a TLK file.
         * Note: Validation removed temporarily due to Kaitai Struct parser issues.
         */
        std::string file_type() const { return m_file_type; }

        /**
         * File format version. "V3.0" for KotOR, "V4.0" for Jade Empire.
         * KotOR games use V3.0. Jade Empire uses V4.0.
         * Note: Validation removed due to Kaitai Struct parser limitations with period in string.
         */
        std::string file_version() const { return m_file_version; }

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
        uint32_t language_id() const { return m_language_id; }

        /**
         * Number of string entries in the file.
         * Determines the number of entries in string_data_table.
         */
        uint32_t string_count() const { return m_string_count; }

        /**
         * Byte offset to string entries array from the beginning of the file.
         * Typically 20 + (string_count * 40) = header size + string data table size.
         * Points to where the actual text strings begin.
         */
        uint32_t entries_offset() const { return m_entries_offset; }
        tlk_t* _root() const { return m__root; }
        tlk_t* _parent() const { return m__parent; }
    };

private:
    tlk_header_t* m_header;
    string_data_table_t* m_string_data_table;
    tlk_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * TLK file header (20 bytes) - contains file signature, version, language, and counts
     */
    tlk_header_t* header() const { return m_header; }

    /**
     * Array of string data entries (metadata for each string) - 40 bytes per entry
     */
    string_data_table_t* string_data_table() const { return m_string_data_table; }
    tlk_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // TLK_H_
