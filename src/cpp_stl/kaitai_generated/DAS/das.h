#ifndef DAS_H_
#define DAS_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class das_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **DAS** (Dragon Age: Origins save): Eclipse binary save — `DAS ` signature, `version==1`, length-prefixed strings +
 * tagged blocks. **Not KotOR** — reference serializers live under **Andastra** `Game/Games/Eclipse/...` on GitHub (`meta.xref`), not `Runtime/...`.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408 xoreos — `GameID` (`kGameIDDragonAge` = 7)
 * \sa https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAgeOrigins/Save/DragonAgeOriginsSaveSerializer.cs#L23-L180 Andastra — `DragonAgeOriginsSaveSerializer` (signature + nfo + archive entrypoints)
 * \sa https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126 Andastra — `EclipseSaveSerializer` string + metadata helpers
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (DAO saves via Andastra; no DAS-specific PDF here)
 */

class das_t : public kaitai::kstruct {

public:
    class length_prefixed_string_t;

    das_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, das_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~das_t();

    class length_prefixed_string_t : public kaitai::kstruct {

    public:

        length_prefixed_string_t(kaitai::kstream* p__io, das_t* p__parent = 0, das_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~length_prefixed_string_t();

    private:
        bool f_value_trimmed;
        std::string m_value_trimmed;

    public:

        /**
         * String value.
         * Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
         */
        std::string value_trimmed();

    private:
        int32_t m_length;
        std::string m_value;
        das_t* m__root;
        das_t* m__parent;

    public:

        /**
         * String length in bytes (UTF-8 encoding).
         * Must be >= 0 and <= 65536 (sanity check).
         */
        int32_t length() const { return m_length; }

        /**
         * String value (UTF-8 encoded)
         */
        std::string value() const { return m_value; }
        das_t* _root() const { return m__root; }
        das_t* _parent() const { return m__parent; }
    };

private:
    std::string m_signature;
    int32_t m_version;
    length_prefixed_string_t* m_save_name;
    length_prefixed_string_t* m_module_name;
    length_prefixed_string_t* m_area_name;
    int32_t m_time_played_seconds;
    int64_t m_timestamp_filetime;
    int32_t m_num_screenshot_data;
    std::vector<uint8_t>* m_screenshot_data;
    bool n_screenshot_data;

public:
    bool _is_null_screenshot_data() { screenshot_data(); return n_screenshot_data; };

private:
    int32_t m_num_portrait_data;
    std::vector<uint8_t>* m_portrait_data;
    bool n_portrait_data;

public:
    bool _is_null_portrait_data() { portrait_data(); return n_portrait_data; };

private:
    length_prefixed_string_t* m_player_name;
    int32_t m_party_member_count;
    int32_t m_player_level;
    das_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * File signature. Must be "DAS " for Dragon Age: Origins save files.
     */
    std::string signature() const { return m_signature; }

    /**
     * Save format version. Must be 1 for Dragon Age: Origins.
     */
    int32_t version() const { return m_version; }

    /**
     * User-entered save name displayed in UI
     */
    length_prefixed_string_t* save_name() const { return m_save_name; }

    /**
     * Current module resource name
     */
    length_prefixed_string_t* module_name() const { return m_module_name; }

    /**
     * Current area name for display
     */
    length_prefixed_string_t* area_name() const { return m_area_name; }

    /**
     * Total play time in seconds
     */
    int32_t time_played_seconds() const { return m_time_played_seconds; }

    /**
     * Save creation timestamp as Windows FILETIME (int64).
     * Convert using DateTime.FromFileTime().
     */
    int64_t timestamp_filetime() const { return m_timestamp_filetime; }

    /**
     * Length of screenshot data in bytes (0 if no screenshot)
     */
    int32_t num_screenshot_data() const { return m_num_screenshot_data; }

    /**
     * Screenshot image data (typically TGA or DDS format)
     */
    std::vector<uint8_t>* screenshot_data() const { return m_screenshot_data; }

    /**
     * Length of portrait data in bytes (0 if no portrait)
     */
    int32_t num_portrait_data() const { return m_num_portrait_data; }

    /**
     * Portrait image data (typically TGA or DDS format)
     */
    std::vector<uint8_t>* portrait_data() const { return m_portrait_data; }

    /**
     * Player character name
     */
    length_prefixed_string_t* player_name() const { return m_player_name; }

    /**
     * Number of party members (from PartyState)
     */
    int32_t party_member_count() const { return m_party_member_count; }

    /**
     * Player character level (from PartyState.PlayerCharacter)
     */
    int32_t player_level() const { return m_player_level; }
    das_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // DAS_H_
