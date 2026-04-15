#ifndef BIOWARE_COMMON_H_
#define BIOWARE_COMMON_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bioware_common_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <set>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * Shared enums and "common objects" used across the BioWare ecosystem that also appear
 * in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).
 * 
 * This file is intended to be imported by other `.ksy` files to avoid repeating:
 * - Language IDs (used in TLK headers and GFF LocalizedString substrings)
 * - Gender IDs (used in GFF LocalizedString substrings)
 * - The CExoLocString / LocalizedString binary layout
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py
 * - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h
 * - https://github.com/seedhartha/reone/blob/master/include/reone/resource/types.h
 */

class bioware_common_t : public kaitai::kstruct {

public:
    class bioware_binary_data_t;
    class bioware_cexo_string_t;
    class bioware_locstring_t;
    class bioware_resref_t;
    class bioware_vector3_t;
    class bioware_vector4_t;
    class substring_t;

    enum bioware_dds_variant_bytes_per_pixel_t {
        BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL_DXT1 = 3,
        BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL_DXT5 = 4
    };
    static bool _is_defined_bioware_dds_variant_bytes_per_pixel_t(bioware_dds_variant_bytes_per_pixel_t v);

private:
    static const std::set<bioware_dds_variant_bytes_per_pixel_t> _values_bioware_dds_variant_bytes_per_pixel_t;
    static std::set<bioware_dds_variant_bytes_per_pixel_t> _build_values_bioware_dds_variant_bytes_per_pixel_t();

public:

    enum bioware_equipment_slot_flag_t {
        BIOWARE_EQUIPMENT_SLOT_FLAG_INVALID = 0,
        BIOWARE_EQUIPMENT_SLOT_FLAG_HEAD = 1,
        BIOWARE_EQUIPMENT_SLOT_FLAG_ARMOR = 2,
        BIOWARE_EQUIPMENT_SLOT_FLAG_GAUNTLET = 8,
        BIOWARE_EQUIPMENT_SLOT_FLAG_RIGHT_HAND = 16,
        BIOWARE_EQUIPMENT_SLOT_FLAG_LEFT_HAND = 32,
        BIOWARE_EQUIPMENT_SLOT_FLAG_RIGHT_ARM = 128,
        BIOWARE_EQUIPMENT_SLOT_FLAG_LEFT_ARM = 256,
        BIOWARE_EQUIPMENT_SLOT_FLAG_IMPLANT = 512,
        BIOWARE_EQUIPMENT_SLOT_FLAG_BELT = 1024,
        BIOWARE_EQUIPMENT_SLOT_FLAG_CLAW1 = 16384,
        BIOWARE_EQUIPMENT_SLOT_FLAG_CLAW2 = 32768,
        BIOWARE_EQUIPMENT_SLOT_FLAG_CLAW3 = 65536,
        BIOWARE_EQUIPMENT_SLOT_FLAG_HIDE = 131072,
        BIOWARE_EQUIPMENT_SLOT_FLAG_RIGHT_HAND_2 = 262144,
        BIOWARE_EQUIPMENT_SLOT_FLAG_LEFT_HAND_2 = 524288
    };
    static bool _is_defined_bioware_equipment_slot_flag_t(bioware_equipment_slot_flag_t v);

private:
    static const std::set<bioware_equipment_slot_flag_t> _values_bioware_equipment_slot_flag_t;
    static std::set<bioware_equipment_slot_flag_t> _build_values_bioware_equipment_slot_flag_t();

public:

    enum bioware_game_id_t {
        BIOWARE_GAME_ID_K1 = 1,
        BIOWARE_GAME_ID_K2 = 2,
        BIOWARE_GAME_ID_K1_XBOX = 3,
        BIOWARE_GAME_ID_K2_XBOX = 4,
        BIOWARE_GAME_ID_K1_IOS = 5,
        BIOWARE_GAME_ID_K2_IOS = 6,
        BIOWARE_GAME_ID_K1_ANDROID = 7,
        BIOWARE_GAME_ID_K2_ANDROID = 8
    };
    static bool _is_defined_bioware_game_id_t(bioware_game_id_t v);

private:
    static const std::set<bioware_game_id_t> _values_bioware_game_id_t;
    static std::set<bioware_game_id_t> _build_values_bioware_game_id_t();

public:

    enum bioware_gender_id_t {
        BIOWARE_GENDER_ID_MALE = 0,
        BIOWARE_GENDER_ID_FEMALE = 1
    };
    static bool _is_defined_bioware_gender_id_t(bioware_gender_id_t v);

private:
    static const std::set<bioware_gender_id_t> _values_bioware_gender_id_t;
    static std::set<bioware_gender_id_t> _build_values_bioware_gender_id_t();

public:

    enum bioware_language_id_t {
        BIOWARE_LANGUAGE_ID_ENGLISH = 0,
        BIOWARE_LANGUAGE_ID_FRENCH = 1,
        BIOWARE_LANGUAGE_ID_GERMAN = 2,
        BIOWARE_LANGUAGE_ID_ITALIAN = 3,
        BIOWARE_LANGUAGE_ID_SPANISH = 4,
        BIOWARE_LANGUAGE_ID_POLISH = 5,
        BIOWARE_LANGUAGE_ID_AFRIKAANS = 6,
        BIOWARE_LANGUAGE_ID_BASQUE = 7,
        BIOWARE_LANGUAGE_ID_BRETON = 9,
        BIOWARE_LANGUAGE_ID_CATALAN = 10,
        BIOWARE_LANGUAGE_ID_CHAMORRO = 11,
        BIOWARE_LANGUAGE_ID_CHICHEWA = 12,
        BIOWARE_LANGUAGE_ID_CORSICAN = 13,
        BIOWARE_LANGUAGE_ID_DANISH = 14,
        BIOWARE_LANGUAGE_ID_DUTCH = 15,
        BIOWARE_LANGUAGE_ID_FAROESE = 16,
        BIOWARE_LANGUAGE_ID_FILIPINO = 18,
        BIOWARE_LANGUAGE_ID_FINNISH = 19,
        BIOWARE_LANGUAGE_ID_FLEMISH = 20,
        BIOWARE_LANGUAGE_ID_FRISIAN = 21,
        BIOWARE_LANGUAGE_ID_GALICIAN = 22,
        BIOWARE_LANGUAGE_ID_GANDA = 23,
        BIOWARE_LANGUAGE_ID_HAITIAN_CREOLE = 24,
        BIOWARE_LANGUAGE_ID_HAUSA_LATIN = 25,
        BIOWARE_LANGUAGE_ID_HAWAIIAN = 26,
        BIOWARE_LANGUAGE_ID_ICELANDIC = 27,
        BIOWARE_LANGUAGE_ID_IDO = 28,
        BIOWARE_LANGUAGE_ID_INDONESIAN = 29,
        BIOWARE_LANGUAGE_ID_IGBO = 30,
        BIOWARE_LANGUAGE_ID_IRISH = 31,
        BIOWARE_LANGUAGE_ID_INTERLINGUA = 32,
        BIOWARE_LANGUAGE_ID_JAVANESE_LATIN = 33,
        BIOWARE_LANGUAGE_ID_LATIN = 34,
        BIOWARE_LANGUAGE_ID_LUXEMBOURGISH = 35,
        BIOWARE_LANGUAGE_ID_MALTESE = 36,
        BIOWARE_LANGUAGE_ID_NORWEGIAN = 37,
        BIOWARE_LANGUAGE_ID_OCCITAN = 38,
        BIOWARE_LANGUAGE_ID_PORTUGUESE = 39,
        BIOWARE_LANGUAGE_ID_SCOTS = 40,
        BIOWARE_LANGUAGE_ID_SCOTTISH_GAELIC = 41,
        BIOWARE_LANGUAGE_ID_SHONA = 42,
        BIOWARE_LANGUAGE_ID_SOTO = 43,
        BIOWARE_LANGUAGE_ID_SUNDANESE_LATIN = 44,
        BIOWARE_LANGUAGE_ID_SWAHILI = 45,
        BIOWARE_LANGUAGE_ID_SWEDISH = 46,
        BIOWARE_LANGUAGE_ID_TAGALOG = 47,
        BIOWARE_LANGUAGE_ID_TAHITIAN = 48,
        BIOWARE_LANGUAGE_ID_TONGAN = 49,
        BIOWARE_LANGUAGE_ID_UZBEK_LATIN = 50,
        BIOWARE_LANGUAGE_ID_WALLOON = 51,
        BIOWARE_LANGUAGE_ID_XHOSA = 52,
        BIOWARE_LANGUAGE_ID_YORUBA = 53,
        BIOWARE_LANGUAGE_ID_WELSH = 54,
        BIOWARE_LANGUAGE_ID_ZULU = 55,
        BIOWARE_LANGUAGE_ID_BULGARIAN = 58,
        BIOWARE_LANGUAGE_ID_BELARISIAN = 59,
        BIOWARE_LANGUAGE_ID_MACEDONIAN = 60,
        BIOWARE_LANGUAGE_ID_RUSSIAN = 61,
        BIOWARE_LANGUAGE_ID_SERBIAN_CYRILLIC = 62,
        BIOWARE_LANGUAGE_ID_TAJIK = 63,
        BIOWARE_LANGUAGE_ID_TATAR_CYRILLIC = 64,
        BIOWARE_LANGUAGE_ID_UKRAINIAN = 66,
        BIOWARE_LANGUAGE_ID_UZBEK = 67,
        BIOWARE_LANGUAGE_ID_ALBANIAN = 68,
        BIOWARE_LANGUAGE_ID_BOSNIAN_LATIN = 69,
        BIOWARE_LANGUAGE_ID_CZECH = 70,
        BIOWARE_LANGUAGE_ID_SLOVAK = 71,
        BIOWARE_LANGUAGE_ID_SLOVENE = 72,
        BIOWARE_LANGUAGE_ID_CROATIAN = 73,
        BIOWARE_LANGUAGE_ID_HUNGARIAN = 75,
        BIOWARE_LANGUAGE_ID_ROMANIAN = 76,
        BIOWARE_LANGUAGE_ID_GREEK = 77,
        BIOWARE_LANGUAGE_ID_ESPERANTO = 78,
        BIOWARE_LANGUAGE_ID_AZERBAIJANI_LATIN = 79,
        BIOWARE_LANGUAGE_ID_TURKISH = 81,
        BIOWARE_LANGUAGE_ID_TURKMEN_LATIN = 82,
        BIOWARE_LANGUAGE_ID_HEBREW = 83,
        BIOWARE_LANGUAGE_ID_ARABIC = 84,
        BIOWARE_LANGUAGE_ID_ESTONIAN = 85,
        BIOWARE_LANGUAGE_ID_LATVIAN = 86,
        BIOWARE_LANGUAGE_ID_LITHUANIAN = 87,
        BIOWARE_LANGUAGE_ID_VIETNAMESE = 88,
        BIOWARE_LANGUAGE_ID_THAI = 89,
        BIOWARE_LANGUAGE_ID_AYMARA = 90,
        BIOWARE_LANGUAGE_ID_KINYARWANDA = 91,
        BIOWARE_LANGUAGE_ID_KURDISH_LATIN = 92,
        BIOWARE_LANGUAGE_ID_MALAGASY = 93,
        BIOWARE_LANGUAGE_ID_MALAY_LATIN = 94,
        BIOWARE_LANGUAGE_ID_MAORI = 95,
        BIOWARE_LANGUAGE_ID_MOLDOVAN_LATIN = 96,
        BIOWARE_LANGUAGE_ID_SAMOAN = 97,
        BIOWARE_LANGUAGE_ID_SOMALI = 98,
        BIOWARE_LANGUAGE_ID_KOREAN = 128,
        BIOWARE_LANGUAGE_ID_CHINESE_TRADITIONAL = 129,
        BIOWARE_LANGUAGE_ID_CHINESE_SIMPLIFIED = 130,
        BIOWARE_LANGUAGE_ID_JAPANESE = 131,
        BIOWARE_LANGUAGE_ID_UNKNOWN = 2147483646
    };
    static bool _is_defined_bioware_language_id_t(bioware_language_id_t v);

private:
    static const std::set<bioware_language_id_t> _values_bioware_language_id_t;
    static std::set<bioware_language_id_t> _build_values_bioware_language_id_t();

public:

    enum bioware_lip_viseme_id_t {
        BIOWARE_LIP_VISEME_ID_NEUTRAL = 0,
        BIOWARE_LIP_VISEME_ID_EE = 1,
        BIOWARE_LIP_VISEME_ID_EH = 2,
        BIOWARE_LIP_VISEME_ID_AH = 3,
        BIOWARE_LIP_VISEME_ID_OH = 4,
        BIOWARE_LIP_VISEME_ID_OOH = 5,
        BIOWARE_LIP_VISEME_ID_Y = 6,
        BIOWARE_LIP_VISEME_ID_STS = 7,
        BIOWARE_LIP_VISEME_ID_FV = 8,
        BIOWARE_LIP_VISEME_ID_NG = 9,
        BIOWARE_LIP_VISEME_ID_TH = 10,
        BIOWARE_LIP_VISEME_ID_MPB = 11,
        BIOWARE_LIP_VISEME_ID_TD = 12,
        BIOWARE_LIP_VISEME_ID_SH = 13,
        BIOWARE_LIP_VISEME_ID_L = 14,
        BIOWARE_LIP_VISEME_ID_KG = 15
    };
    static bool _is_defined_bioware_lip_viseme_id_t(bioware_lip_viseme_id_t v);

private:
    static const std::set<bioware_lip_viseme_id_t> _values_bioware_lip_viseme_id_t;
    static std::set<bioware_lip_viseme_id_t> _build_values_bioware_lip_viseme_id_t();

public:

    enum bioware_ltr_alphabet_length_t {
        BIOWARE_LTR_ALPHABET_LENGTH_NEVERWINTER_NIGHTS = 26,
        BIOWARE_LTR_ALPHABET_LENGTH_KOTOR = 28
    };
    static bool _is_defined_bioware_ltr_alphabet_length_t(bioware_ltr_alphabet_length_t v);

private:
    static const std::set<bioware_ltr_alphabet_length_t> _values_bioware_ltr_alphabet_length_t;
    static std::set<bioware_ltr_alphabet_length_t> _build_values_bioware_ltr_alphabet_length_t();

public:

    enum bioware_object_type_id_t {
        BIOWARE_OBJECT_TYPE_ID_INVALID = 0,
        BIOWARE_OBJECT_TYPE_ID_CREATURE = 1,
        BIOWARE_OBJECT_TYPE_ID_DOOR = 2,
        BIOWARE_OBJECT_TYPE_ID_ITEM = 3,
        BIOWARE_OBJECT_TYPE_ID_TRIGGER = 4,
        BIOWARE_OBJECT_TYPE_ID_PLACEABLE = 5,
        BIOWARE_OBJECT_TYPE_ID_WAYPOINT = 6,
        BIOWARE_OBJECT_TYPE_ID_ENCOUNTER = 7,
        BIOWARE_OBJECT_TYPE_ID_STORE = 8,
        BIOWARE_OBJECT_TYPE_ID_AREA = 9,
        BIOWARE_OBJECT_TYPE_ID_SOUND = 10,
        BIOWARE_OBJECT_TYPE_ID_CAMERA = 11
    };
    static bool _is_defined_bioware_object_type_id_t(bioware_object_type_id_t v);

private:
    static const std::set<bioware_object_type_id_t> _values_bioware_object_type_id_t;
    static std::set<bioware_object_type_id_t> _build_values_bioware_object_type_id_t();

public:

    enum bioware_pcc_compression_codec_t {
        BIOWARE_PCC_COMPRESSION_CODEC_NONE = 0,
        BIOWARE_PCC_COMPRESSION_CODEC_ZLIB = 1,
        BIOWARE_PCC_COMPRESSION_CODEC_LZO = 2
    };
    static bool _is_defined_bioware_pcc_compression_codec_t(bioware_pcc_compression_codec_t v);

private:
    static const std::set<bioware_pcc_compression_codec_t> _values_bioware_pcc_compression_codec_t;
    static std::set<bioware_pcc_compression_codec_t> _build_values_bioware_pcc_compression_codec_t();

public:

    enum bioware_pcc_package_kind_t {
        BIOWARE_PCC_PACKAGE_KIND_NORMAL_PACKAGE = 0,
        BIOWARE_PCC_PACKAGE_KIND_PATCH_PACKAGE = 1
    };
    static bool _is_defined_bioware_pcc_package_kind_t(bioware_pcc_package_kind_t v);

private:
    static const std::set<bioware_pcc_package_kind_t> _values_bioware_pcc_package_kind_t;
    static std::set<bioware_pcc_package_kind_t> _build_values_bioware_pcc_package_kind_t();

public:

    enum bioware_tpc_pixel_format_id_t {
        BIOWARE_TPC_PIXEL_FORMAT_ID_GREYSCALE = 1,
        BIOWARE_TPC_PIXEL_FORMAT_ID_RGB_OR_DXT1 = 2,
        BIOWARE_TPC_PIXEL_FORMAT_ID_RGBA_OR_DXT5 = 4,
        BIOWARE_TPC_PIXEL_FORMAT_ID_BGRA_XBOX_SWIZZLE = 12
    };
    static bool _is_defined_bioware_tpc_pixel_format_id_t(bioware_tpc_pixel_format_id_t v);

private:
    static const std::set<bioware_tpc_pixel_format_id_t> _values_bioware_tpc_pixel_format_id_t;
    static std::set<bioware_tpc_pixel_format_id_t> _build_values_bioware_tpc_pixel_format_id_t();

public:

    enum riff_wave_format_tag_t {
        RIFF_WAVE_FORMAT_TAG_PCM = 1,
        RIFF_WAVE_FORMAT_TAG_ADPCM_MS = 2,
        RIFF_WAVE_FORMAT_TAG_IEEE_FLOAT = 3,
        RIFF_WAVE_FORMAT_TAG_ALAW = 6,
        RIFF_WAVE_FORMAT_TAG_MULAW = 7,
        RIFF_WAVE_FORMAT_TAG_DVI_IMA_ADPCM = 17,
        RIFF_WAVE_FORMAT_TAG_MPEG_LAYER3 = 85,
        RIFF_WAVE_FORMAT_TAG_WAVE_FORMAT_EXTENSIBLE = 65534
    };
    static bool _is_defined_riff_wave_format_tag_t(riff_wave_format_tag_t v);

private:
    static const std::set<riff_wave_format_tag_t> _values_riff_wave_format_tag_t;
    static std::set<riff_wave_format_tag_t> _build_values_riff_wave_format_tag_t();

public:

    bioware_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_common_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bioware_common_t();

    /**
     * Variable-length binary data with 4-byte length prefix.
     * Used for Void/Binary fields in GFF files.
     */

    class bioware_binary_data_t : public kaitai::kstruct {

    public:

        bioware_binary_data_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_binary_data_t();

    private:
        uint32_t m_len_value;
        std::string m_value;
        bioware_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Length of binary data in bytes
         */
        uint32_t len_value() const { return m_len_value; }

        /**
         * Binary data
         */
        std::string value() const { return m_value; }
        bioware_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * BioWare CExoString - variable-length string with 4-byte length prefix.
     * Used for string fields in GFF files.
     */

    class bioware_cexo_string_t : public kaitai::kstruct {

    public:

        bioware_cexo_string_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_cexo_string_t();

    private:
        uint32_t m_len_string;
        std::string m_value;
        bioware_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Length of string in bytes
         */
        uint32_t len_string() const { return m_len_string; }

        /**
         * String data (UTF-8)
         */
        std::string value() const { return m_value; }
        bioware_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
     * section for field type "LocalizedString".
     */

    class bioware_locstring_t : public kaitai::kstruct {

    public:

        bioware_locstring_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_locstring_t();

    private:
        bool f_has_strref;
        bool m_has_strref;

    public:

        /**
         * True if this locstring references dialog.tlk
         */
        bool has_strref();

    private:
        uint32_t m_total_size;
        uint32_t m_string_ref;
        uint32_t m_num_substrings;
        std::vector<substring_t*>* m_substrings;
        bioware_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Total size of the structure in bytes (excluding this field).
         */
        uint32_t total_size() const { return m_total_size; }

        /**
         * StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).
         */
        uint32_t string_ref() const { return m_string_ref; }

        /**
         * Number of substring entries that follow.
         */
        uint32_t num_substrings() const { return m_num_substrings; }

        /**
         * Language/gender-specific substring entries.
         */
        std::vector<substring_t*>* substrings() const { return m_substrings; }
        bioware_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
     * Used throughout GFF files to reference game resources by name.
     */

    class bioware_resref_t : public kaitai::kstruct {

    public:

        bioware_resref_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_resref_t();

    private:
        uint8_t m_len_resref;
        std::string m_value;
        bioware_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Length of ResRef string (0-16 characters)
         */
        uint8_t len_resref() const { return m_len_resref; }

        /**
         * ResRef string data (ASCII, lowercase recommended)
         */
        std::string value() const { return m_value; }
        bioware_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * 3D vector (X, Y, Z coordinates).
     * Used for positions, directions, etc. in game files.
     */

    class bioware_vector3_t : public kaitai::kstruct {

    public:

        bioware_vector3_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_vector3_t();

    private:
        float m_x;
        float m_y;
        float m_z;
        bioware_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * X coordinate
         */
        float x() const { return m_x; }

        /**
         * Y coordinate
         */
        float y() const { return m_y; }

        /**
         * Z coordinate
         */
        float z() const { return m_z; }
        bioware_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * 4D vector / Quaternion (X, Y, Z, W components).
     * Used for orientations/rotations in game files.
     */

    class bioware_vector4_t : public kaitai::kstruct {

    public:

        bioware_vector4_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_vector4_t();

    private:
        float m_x;
        float m_y;
        float m_z;
        float m_w;
        bioware_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * X component
         */
        float x() const { return m_x; }

        /**
         * Y component
         */
        float y() const { return m_y; }

        /**
         * Z component
         */
        float z() const { return m_z; }

        /**
         * W component
         */
        float w() const { return m_w; }
        bioware_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    class substring_t : public kaitai::kstruct {

    public:

        substring_t(kaitai::kstream* p__io, bioware_common_t::bioware_locstring_t* p__parent = 0, bioware_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~substring_t();

    private:
        bool f_gender;
        bioware_gender_id_t m_gender;

    public:

        /**
         * Gender as enum value
         */
        bioware_gender_id_t gender();

    private:
        bool f_gender_raw;
        int32_t m_gender_raw;

    public:

        /**
         * Raw gender ID (0..255).
         */
        int32_t gender_raw();

    private:
        bool f_language;
        bioware_language_id_t m_language;

    public:

        /**
         * Language as enum value
         */
        bioware_language_id_t language();

    private:
        bool f_language_raw;
        int32_t m_language_raw;

    public:

        /**
         * Raw language ID (0..255).
         */
        int32_t language_raw();

    private:
        uint32_t m_substring_id;
        uint32_t m_len_text;
        std::string m_text;
        bioware_common_t* m__root;
        bioware_common_t::bioware_locstring_t* m__parent;

    public:

        /**
         * Packed language+gender identifier:
         * - bits 0..7: gender
         * - bits 8..15: language
         */
        uint32_t substring_id() const { return m_substring_id; }

        /**
         * Length of text in bytes.
         */
        uint32_t len_text() const { return m_len_text; }

        /**
         * Substring text.
         */
        std::string text() const { return m_text; }
        bioware_common_t* _root() const { return m__root; }
        bioware_common_t::bioware_locstring_t* _parent() const { return m__parent; }
    };

private:
    bioware_common_t* m__root;
    kaitai::kstruct* m__parent;

public:
    bioware_common_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BIOWARE_COMMON_H_
