#ifndef SSF_H_
#define SSF_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class ssf_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * SSF (Sound Set File) files store sound string references (StrRefs) for character voice sets.
 * Each SSF file contains exactly 28 sound slots, mapping to different game events and actions.
 * 
 * Binary Format:
 * - Header (12 bytes): File type signature, version, and offset to sounds array (usually 12)
 * - Sounds Array (112 bytes at sounds_offset): 28 uint32 values representing StrRefs (0xFFFFFFFF = -1 = no sound)
 * 
 * Vanilla KotOR SSFs are typically 136 bytes total: after the 28 StrRefs, many files append 12 bytes
 * of 0xFFFFFFFF padding; that trailer is not part of the header and is not modeled here.
 * 
 * Sound Slots (in order):
 * 0-5: Battle Cry 1-6
 * 6-8: Select 1-3
 * 9-11: Attack Grunt 1-3
 * 12-13: Pain Grunt 1-2
 * 14: Low Health
 * 15: Dead
 * 16: Critical Hit
 * 17: Target Immune
 * 18: Lay Mine
 * 19: Disarm Mine
 * 20: Begin Stealth
 * 21: Begin Search
 * 22: Begin Unlock
 * 23: Unlock Failed
 * 24: Unlock Success
 * 25: Separated From Party
 * 26: Rejoined Party
 * 27: Poisoned
 * 
 * Authoritative implementations: `meta.xref` and `doc-ref` (PyKotor `io_ssf`, xoreos `ssffile.cpp`, xoreos-tools `ssf2xml` / `xml2ssf`, xoreos-docs `SSF_Format.pdf`, reone `SsfReader`).
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf PyKotor wiki — SSF
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf.py#L102-L166 PyKotor — `io_ssf` (Kaitai bridge + binary read/write)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L126 xoreos — `kFileTypeSSF`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L72-L141 xoreos — `SSFFile::load` + `readSSFHeader` + `readEntries`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L165-L170 xoreos — `readEntriesKotOR`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/ssf2xml.cpp#L51-L70 xoreos-tools — `ssf2xml` CLI
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/xml2ssf.cpp#L54-L75 xoreos-tools — `xml2ssf` CLI (`main`)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/xml/ssfdumper.cpp#L133-L167 xoreos-tools — `SSFDumper::dump` (XML mapping for `ssf2xml`)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/xml/ssfcreator.cpp#L38-L74 xoreos-tools — `SSFCreator::create` (XML mapping for `xml2ssf`)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/SSF_Format.pdf xoreos-docs — SSF_Format.pdf
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/ssfreader.cpp#L26-L32 reone — `SsfReader::load`
 */

class ssf_t : public kaitai::kstruct {

public:
    class sound_array_t;
    class sound_entry_t;

    ssf_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, ssf_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~ssf_t();

    class sound_array_t : public kaitai::kstruct {

    public:

        sound_array_t(kaitai::kstream* p__io, ssf_t* p__parent = 0, ssf_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~sound_array_t();

    private:
        std::vector<sound_entry_t*>* m_entries;
        ssf_t* m__root;
        ssf_t* m__parent;

    public:

        /**
         * Array of exactly 28 sound entries, one for each SSFSound enum value.
         * Each entry is a uint32 representing a StrRef (string reference).
         * Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
         * 
         * Entry indices map to SSFSound enum:
         * - 0-5: Battle Cry 1-6
         * - 6-8: Select 1-3
         * - 9-11: Attack Grunt 1-3
         * - 12-13: Pain Grunt 1-2
         * - 14: Low Health
         * - 15: Dead
         * - 16: Critical Hit
         * - 17: Target Immune
         * - 18: Lay Mine
         * - 19: Disarm Mine
         * - 20: Begin Stealth
         * - 21: Begin Search
         * - 22: Begin Unlock
         * - 23: Unlock Failed
         * - 24: Unlock Success
         * - 25: Separated From Party
         * - 26: Rejoined Party
         * - 27: Poisoned
         */
        std::vector<sound_entry_t*>* entries() const { return m_entries; }
        ssf_t* _root() const { return m__root; }
        ssf_t* _parent() const { return m__parent; }
    };

    class sound_entry_t : public kaitai::kstruct {

    public:

        sound_entry_t(kaitai::kstream* p__io, ssf_t::sound_array_t* p__parent = 0, ssf_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~sound_entry_t();

    private:
        bool f_is_no_sound;
        bool m_is_no_sound;

    public:

        /**
         * True if this entry represents "no sound" (0xFFFFFFFF).
         * False if this entry contains a valid StrRef value.
         */
        bool is_no_sound();

    private:
        uint32_t m_strref_raw;
        ssf_t* m__root;
        ssf_t::sound_array_t* m__parent;

    public:

        /**
         * Raw uint32 value representing the StrRef.
         * Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
         * All other values are valid StrRefs (typically 0-999999).
         * The conversion from 0xFFFFFFFF to -1 is handled by SSFBinaryReader.ReadInt32MaxNeg1().
         */
        uint32_t strref_raw() const { return m_strref_raw; }
        ssf_t* _root() const { return m__root; }
        ssf_t::sound_array_t* _parent() const { return m__parent; }
    };

private:
    bool f_sounds;
    sound_array_t* m_sounds;

public:

    /**
     * Array of 28 sound string references (StrRefs)
     */
    sound_array_t* sounds();

private:
    std::string m_file_type;
    std::string m_file_version;
    uint32_t m_sounds_offset;
    ssf_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * File type signature. Must be "SSF " (space-padded).
     * Bytes: 0x53 0x53 0x46 0x20
     */
    std::string file_type() const { return m_file_type; }

    /**
     * File format version. Always "V1.1" for KotOR SSF files.
     * Bytes: 0x56 0x31 0x2E 0x31
     */
    std::string file_version() const { return m_file_version; }

    /**
     * Byte offset to the sounds array from the beginning of the file.
     * KotOR files almost always use 12 (0x0C) so the table follows the header immediately, but the
     * field is a real offset; readers must seek here instead of assuming 12.
     */
    uint32_t sounds_offset() const { return m_sounds_offset; }
    ssf_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // SSF_H_
