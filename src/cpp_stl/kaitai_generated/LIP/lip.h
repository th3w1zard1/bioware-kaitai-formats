#ifndef LIP_H_
#define LIP_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class lip_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_common.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
 * `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
 * 
 * xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no LIP-specific tool)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116 PyKotor — `io_lip` (Kaitai + legacy read/write)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/lip_data.py#L47-L127 PyKotor — `LIPShape` enum
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L41 reone — `LipReader::load`
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LIPObject.ts#L99-L118 KotOR.js — `LIPObject.readBinary`
 * \sa https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorLIP/LIP.cs NickHugi/Kotor.NET — `LIP`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L180 xoreos — `kFileTypeLIP` (numeric id; no standalone `lipfile.cpp`)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (no dedicated LIP Torlack/PDF; wire from PyKotor/reone)
 */

class lip_t : public kaitai::kstruct {

public:
    class keyframe_entry_t;

    lip_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, lip_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~lip_t();

    /**
     * A single keyframe entry mapping a timestamp to a viseme (mouth shape).
     * Keyframes are used by the engine to interpolate between mouth shapes during
     * audio playback to create lip sync animation.
     */

    class keyframe_entry_t : public kaitai::kstruct {

    public:

        keyframe_entry_t(kaitai::kstream* p__io, lip_t* p__parent = 0, lip_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~keyframe_entry_t();

    private:
        float m_timestamp;
        bioware_common_t::bioware_lip_viseme_id_t m_shape;
        lip_t* m__root;
        lip_t* m__parent;

    public:

        /**
         * Seconds from animation start. Must be >= 0 and <= length.
         * Keyframes should be sorted ascending by timestamp.
         */
        float timestamp() const { return m_timestamp; }

        /**
         * Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
         * `bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).
         */
        bioware_common_t::bioware_lip_viseme_id_t shape() const { return m_shape; }
        lip_t* _root() const { return m__root; }
        lip_t* _parent() const { return m__parent; }
    };

private:
    std::string m_file_type;
    std::string m_file_version;
    float m_length;
    uint32_t m_num_keyframes;
    std::vector<keyframe_entry_t*>* m_keyframes;
    lip_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * File type signature. Must be "LIP " (space-padded) for LIP files.
     */
    std::string file_type() const { return m_file_type; }

    /**
     * File format version. Must be "V1.0" for LIP files.
     */
    std::string file_version() const { return m_file_version; }

    /**
     * Duration in seconds. Must equal the paired WAV file playback time for
     * glitch-free animation. This is the total length of the lip sync animation.
     */
    float length() const { return m_length; }

    /**
     * Number of keyframes immediately following. Each keyframe contains a timestamp
     * and a viseme shape index. Keyframes should be sorted ascending by timestamp.
     */
    uint32_t num_keyframes() const { return m_num_keyframes; }

    /**
     * Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
     * Entries must be stored in chronological order (ascending by timestamp).
     */
    std::vector<keyframe_entry_t*>* keyframes() const { return m_keyframes; }
    lip_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // LIP_H_
