// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bioware_common.h"
#include "kaitai/exceptions.h"
std::set<bioware_common_t::bioware_dds_variant_bytes_per_pixel_t> bioware_common_t::_build_values_bioware_dds_variant_bytes_per_pixel_t() {
    std::set<bioware_common_t::bioware_dds_variant_bytes_per_pixel_t> _t;
    _t.insert(bioware_common_t::BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL_DXT1);
    _t.insert(bioware_common_t::BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL_DXT5);
    return _t;
}
const std::set<bioware_common_t::bioware_dds_variant_bytes_per_pixel_t> bioware_common_t::_values_bioware_dds_variant_bytes_per_pixel_t = bioware_common_t::_build_values_bioware_dds_variant_bytes_per_pixel_t();
bool bioware_common_t::_is_defined_bioware_dds_variant_bytes_per_pixel_t(bioware_common_t::bioware_dds_variant_bytes_per_pixel_t v) {
    return bioware_common_t::_values_bioware_dds_variant_bytes_per_pixel_t.find(v) != bioware_common_t::_values_bioware_dds_variant_bytes_per_pixel_t.end();
}
std::set<bioware_common_t::bioware_equipment_slot_flag_t> bioware_common_t::_build_values_bioware_equipment_slot_flag_t() {
    std::set<bioware_common_t::bioware_equipment_slot_flag_t> _t;
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_INVALID);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_HEAD);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_ARMOR);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_GAUNTLET);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_RIGHT_HAND);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_LEFT_HAND);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_RIGHT_ARM);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_LEFT_ARM);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_IMPLANT);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_BELT);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_CLAW1);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_CLAW2);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_CLAW3);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_HIDE);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_RIGHT_HAND_2);
    _t.insert(bioware_common_t::BIOWARE_EQUIPMENT_SLOT_FLAG_LEFT_HAND_2);
    return _t;
}
const std::set<bioware_common_t::bioware_equipment_slot_flag_t> bioware_common_t::_values_bioware_equipment_slot_flag_t = bioware_common_t::_build_values_bioware_equipment_slot_flag_t();
bool bioware_common_t::_is_defined_bioware_equipment_slot_flag_t(bioware_common_t::bioware_equipment_slot_flag_t v) {
    return bioware_common_t::_values_bioware_equipment_slot_flag_t.find(v) != bioware_common_t::_values_bioware_equipment_slot_flag_t.end();
}
std::set<bioware_common_t::bioware_game_id_t> bioware_common_t::_build_values_bioware_game_id_t() {
    std::set<bioware_common_t::bioware_game_id_t> _t;
    _t.insert(bioware_common_t::BIOWARE_GAME_ID_K1);
    _t.insert(bioware_common_t::BIOWARE_GAME_ID_K2);
    _t.insert(bioware_common_t::BIOWARE_GAME_ID_K1_XBOX);
    _t.insert(bioware_common_t::BIOWARE_GAME_ID_K2_XBOX);
    _t.insert(bioware_common_t::BIOWARE_GAME_ID_K1_IOS);
    _t.insert(bioware_common_t::BIOWARE_GAME_ID_K2_IOS);
    _t.insert(bioware_common_t::BIOWARE_GAME_ID_K1_ANDROID);
    _t.insert(bioware_common_t::BIOWARE_GAME_ID_K2_ANDROID);
    return _t;
}
const std::set<bioware_common_t::bioware_game_id_t> bioware_common_t::_values_bioware_game_id_t = bioware_common_t::_build_values_bioware_game_id_t();
bool bioware_common_t::_is_defined_bioware_game_id_t(bioware_common_t::bioware_game_id_t v) {
    return bioware_common_t::_values_bioware_game_id_t.find(v) != bioware_common_t::_values_bioware_game_id_t.end();
}
std::set<bioware_common_t::bioware_gender_id_t> bioware_common_t::_build_values_bioware_gender_id_t() {
    std::set<bioware_common_t::bioware_gender_id_t> _t;
    _t.insert(bioware_common_t::BIOWARE_GENDER_ID_MALE);
    _t.insert(bioware_common_t::BIOWARE_GENDER_ID_FEMALE);
    return _t;
}
const std::set<bioware_common_t::bioware_gender_id_t> bioware_common_t::_values_bioware_gender_id_t = bioware_common_t::_build_values_bioware_gender_id_t();
bool bioware_common_t::_is_defined_bioware_gender_id_t(bioware_common_t::bioware_gender_id_t v) {
    return bioware_common_t::_values_bioware_gender_id_t.find(v) != bioware_common_t::_values_bioware_gender_id_t.end();
}
std::set<bioware_common_t::bioware_language_id_t> bioware_common_t::_build_values_bioware_language_id_t() {
    std::set<bioware_common_t::bioware_language_id_t> _t;
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_ENGLISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_FRENCH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_GERMAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_ITALIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SPANISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_POLISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_AFRIKAANS);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_BASQUE);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_BRETON);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_CATALAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_CHAMORRO);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_CHICHEWA);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_CORSICAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_DANISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_DUTCH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_FAROESE);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_FILIPINO);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_FINNISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_FLEMISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_FRISIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_GALICIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_GANDA);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_HAITIAN_CREOLE);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_HAUSA_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_HAWAIIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_ICELANDIC);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_IDO);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_INDONESIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_IGBO);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_IRISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_INTERLINGUA);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_JAVANESE_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_LUXEMBOURGISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_MALTESE);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_NORWEGIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_OCCITAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_PORTUGUESE);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SCOTS);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SCOTTISH_GAELIC);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SHONA);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SOTO);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SUNDANESE_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SWAHILI);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SWEDISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_TAGALOG);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_TAHITIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_TONGAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_UZBEK_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_WALLOON);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_XHOSA);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_YORUBA);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_WELSH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_ZULU);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_BULGARIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_BELARISIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_MACEDONIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_RUSSIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SERBIAN_CYRILLIC);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_TAJIK);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_TATAR_CYRILLIC);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_UKRAINIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_UZBEK);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_ALBANIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_BOSNIAN_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_CZECH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SLOVAK);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SLOVENE);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_CROATIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_HUNGARIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_ROMANIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_GREEK);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_ESPERANTO);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_AZERBAIJANI_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_TURKISH);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_TURKMEN_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_HEBREW);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_ARABIC);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_ESTONIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_LATVIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_LITHUANIAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_VIETNAMESE);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_THAI);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_AYMARA);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_KINYARWANDA);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_KURDISH_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_MALAGASY);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_MALAY_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_MAORI);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_MOLDOVAN_LATIN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SAMOAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_SOMALI);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_KOREAN);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_CHINESE_TRADITIONAL);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_CHINESE_SIMPLIFIED);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_JAPANESE);
    _t.insert(bioware_common_t::BIOWARE_LANGUAGE_ID_UNKNOWN);
    return _t;
}
const std::set<bioware_common_t::bioware_language_id_t> bioware_common_t::_values_bioware_language_id_t = bioware_common_t::_build_values_bioware_language_id_t();
bool bioware_common_t::_is_defined_bioware_language_id_t(bioware_common_t::bioware_language_id_t v) {
    return bioware_common_t::_values_bioware_language_id_t.find(v) != bioware_common_t::_values_bioware_language_id_t.end();
}
std::set<bioware_common_t::bioware_lip_viseme_id_t> bioware_common_t::_build_values_bioware_lip_viseme_id_t() {
    std::set<bioware_common_t::bioware_lip_viseme_id_t> _t;
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_NEUTRAL);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_EE);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_EH);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_AH);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_OH);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_OOH);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_Y);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_STS);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_FV);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_NG);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_TH);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_MPB);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_TD);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_SH);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_L);
    _t.insert(bioware_common_t::BIOWARE_LIP_VISEME_ID_KG);
    return _t;
}
const std::set<bioware_common_t::bioware_lip_viseme_id_t> bioware_common_t::_values_bioware_lip_viseme_id_t = bioware_common_t::_build_values_bioware_lip_viseme_id_t();
bool bioware_common_t::_is_defined_bioware_lip_viseme_id_t(bioware_common_t::bioware_lip_viseme_id_t v) {
    return bioware_common_t::_values_bioware_lip_viseme_id_t.find(v) != bioware_common_t::_values_bioware_lip_viseme_id_t.end();
}
std::set<bioware_common_t::bioware_ltr_alphabet_length_t> bioware_common_t::_build_values_bioware_ltr_alphabet_length_t() {
    std::set<bioware_common_t::bioware_ltr_alphabet_length_t> _t;
    _t.insert(bioware_common_t::BIOWARE_LTR_ALPHABET_LENGTH_NEVERWINTER_NIGHTS);
    _t.insert(bioware_common_t::BIOWARE_LTR_ALPHABET_LENGTH_KOTOR);
    return _t;
}
const std::set<bioware_common_t::bioware_ltr_alphabet_length_t> bioware_common_t::_values_bioware_ltr_alphabet_length_t = bioware_common_t::_build_values_bioware_ltr_alphabet_length_t();
bool bioware_common_t::_is_defined_bioware_ltr_alphabet_length_t(bioware_common_t::bioware_ltr_alphabet_length_t v) {
    return bioware_common_t::_values_bioware_ltr_alphabet_length_t.find(v) != bioware_common_t::_values_bioware_ltr_alphabet_length_t.end();
}
std::set<bioware_common_t::bioware_object_type_id_t> bioware_common_t::_build_values_bioware_object_type_id_t() {
    std::set<bioware_common_t::bioware_object_type_id_t> _t;
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_INVALID);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_CREATURE);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_DOOR);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_ITEM);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_TRIGGER);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_PLACEABLE);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_WAYPOINT);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_ENCOUNTER);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_STORE);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_AREA);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_SOUND);
    _t.insert(bioware_common_t::BIOWARE_OBJECT_TYPE_ID_CAMERA);
    return _t;
}
const std::set<bioware_common_t::bioware_object_type_id_t> bioware_common_t::_values_bioware_object_type_id_t = bioware_common_t::_build_values_bioware_object_type_id_t();
bool bioware_common_t::_is_defined_bioware_object_type_id_t(bioware_common_t::bioware_object_type_id_t v) {
    return bioware_common_t::_values_bioware_object_type_id_t.find(v) != bioware_common_t::_values_bioware_object_type_id_t.end();
}
std::set<bioware_common_t::bioware_pcc_compression_codec_t> bioware_common_t::_build_values_bioware_pcc_compression_codec_t() {
    std::set<bioware_common_t::bioware_pcc_compression_codec_t> _t;
    _t.insert(bioware_common_t::BIOWARE_PCC_COMPRESSION_CODEC_NONE);
    _t.insert(bioware_common_t::BIOWARE_PCC_COMPRESSION_CODEC_ZLIB);
    _t.insert(bioware_common_t::BIOWARE_PCC_COMPRESSION_CODEC_LZO);
    return _t;
}
const std::set<bioware_common_t::bioware_pcc_compression_codec_t> bioware_common_t::_values_bioware_pcc_compression_codec_t = bioware_common_t::_build_values_bioware_pcc_compression_codec_t();
bool bioware_common_t::_is_defined_bioware_pcc_compression_codec_t(bioware_common_t::bioware_pcc_compression_codec_t v) {
    return bioware_common_t::_values_bioware_pcc_compression_codec_t.find(v) != bioware_common_t::_values_bioware_pcc_compression_codec_t.end();
}
std::set<bioware_common_t::bioware_pcc_package_kind_t> bioware_common_t::_build_values_bioware_pcc_package_kind_t() {
    std::set<bioware_common_t::bioware_pcc_package_kind_t> _t;
    _t.insert(bioware_common_t::BIOWARE_PCC_PACKAGE_KIND_NORMAL_PACKAGE);
    _t.insert(bioware_common_t::BIOWARE_PCC_PACKAGE_KIND_PATCH_PACKAGE);
    return _t;
}
const std::set<bioware_common_t::bioware_pcc_package_kind_t> bioware_common_t::_values_bioware_pcc_package_kind_t = bioware_common_t::_build_values_bioware_pcc_package_kind_t();
bool bioware_common_t::_is_defined_bioware_pcc_package_kind_t(bioware_common_t::bioware_pcc_package_kind_t v) {
    return bioware_common_t::_values_bioware_pcc_package_kind_t.find(v) != bioware_common_t::_values_bioware_pcc_package_kind_t.end();
}
std::set<bioware_common_t::bioware_tpc_pixel_format_id_t> bioware_common_t::_build_values_bioware_tpc_pixel_format_id_t() {
    std::set<bioware_common_t::bioware_tpc_pixel_format_id_t> _t;
    _t.insert(bioware_common_t::BIOWARE_TPC_PIXEL_FORMAT_ID_GREYSCALE);
    _t.insert(bioware_common_t::BIOWARE_TPC_PIXEL_FORMAT_ID_RGB_OR_DXT1);
    _t.insert(bioware_common_t::BIOWARE_TPC_PIXEL_FORMAT_ID_RGBA_OR_DXT5);
    _t.insert(bioware_common_t::BIOWARE_TPC_PIXEL_FORMAT_ID_BGRA_XBOX_SWIZZLE);
    return _t;
}
const std::set<bioware_common_t::bioware_tpc_pixel_format_id_t> bioware_common_t::_values_bioware_tpc_pixel_format_id_t = bioware_common_t::_build_values_bioware_tpc_pixel_format_id_t();
bool bioware_common_t::_is_defined_bioware_tpc_pixel_format_id_t(bioware_common_t::bioware_tpc_pixel_format_id_t v) {
    return bioware_common_t::_values_bioware_tpc_pixel_format_id_t.find(v) != bioware_common_t::_values_bioware_tpc_pixel_format_id_t.end();
}
std::set<bioware_common_t::riff_wave_format_tag_t> bioware_common_t::_build_values_riff_wave_format_tag_t() {
    std::set<bioware_common_t::riff_wave_format_tag_t> _t;
    _t.insert(bioware_common_t::RIFF_WAVE_FORMAT_TAG_PCM);
    _t.insert(bioware_common_t::RIFF_WAVE_FORMAT_TAG_ADPCM_MS);
    _t.insert(bioware_common_t::RIFF_WAVE_FORMAT_TAG_IEEE_FLOAT);
    _t.insert(bioware_common_t::RIFF_WAVE_FORMAT_TAG_ALAW);
    _t.insert(bioware_common_t::RIFF_WAVE_FORMAT_TAG_MULAW);
    _t.insert(bioware_common_t::RIFF_WAVE_FORMAT_TAG_DVI_IMA_ADPCM);
    _t.insert(bioware_common_t::RIFF_WAVE_FORMAT_TAG_MPEG_LAYER3);
    _t.insert(bioware_common_t::RIFF_WAVE_FORMAT_TAG_WAVE_FORMAT_EXTENSIBLE);
    return _t;
}
const std::set<bioware_common_t::riff_wave_format_tag_t> bioware_common_t::_values_riff_wave_format_tag_t = bioware_common_t::_build_values_riff_wave_format_tag_t();
bool bioware_common_t::_is_defined_riff_wave_format_tag_t(bioware_common_t::riff_wave_format_tag_t v) {
    return bioware_common_t::_values_riff_wave_format_tag_t.find(v) != bioware_common_t::_values_riff_wave_format_tag_t.end();
}

bioware_common_t::bioware_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_common_t::_read() {
}

bioware_common_t::~bioware_common_t() {
    _clean_up();
}

void bioware_common_t::_clean_up() {
}

bioware_common_t::bioware_binary_data_t::bioware_binary_data_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_common_t::bioware_binary_data_t::_read() {
    m_len_value = m__io->read_u4le();
    m_value = m__io->read_bytes(len_value());
}

bioware_common_t::bioware_binary_data_t::~bioware_binary_data_t() {
    _clean_up();
}

void bioware_common_t::bioware_binary_data_t::_clean_up() {
}

bioware_common_t::bioware_cexo_string_t::bioware_cexo_string_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_common_t::bioware_cexo_string_t::_read() {
    m_len_string = m__io->read_u4le();
    m_value = kaitai::kstream::bytes_to_str(m__io->read_bytes(len_string()), "UTF-8");
}

bioware_common_t::bioware_cexo_string_t::~bioware_cexo_string_t() {
    _clean_up();
}

void bioware_common_t::bioware_cexo_string_t::_clean_up() {
}

bioware_common_t::bioware_locstring_t::bioware_locstring_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_substrings = 0;
    f_has_strref = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_common_t::bioware_locstring_t::_read() {
    m_total_size = m__io->read_u4le();
    m_string_ref = m__io->read_u4le();
    m_num_substrings = m__io->read_u4le();
    m_substrings = new std::vector<substring_t*>();
    const int l_substrings = num_substrings();
    for (int i = 0; i < l_substrings; i++) {
        m_substrings->push_back(new substring_t(m__io, this, m__root));
    }
}

bioware_common_t::bioware_locstring_t::~bioware_locstring_t() {
    _clean_up();
}

void bioware_common_t::bioware_locstring_t::_clean_up() {
    if (m_substrings) {
        for (std::vector<substring_t*>::iterator it = m_substrings->begin(); it != m_substrings->end(); ++it) {
            delete *it;
        }
        delete m_substrings; m_substrings = 0;
    }
}

bool bioware_common_t::bioware_locstring_t::has_strref() {
    if (f_has_strref)
        return m_has_strref;
    f_has_strref = true;
    m_has_strref = string_ref() != 4294967295UL;
    return m_has_strref;
}

bioware_common_t::bioware_resref_t::bioware_resref_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_common_t::bioware_resref_t::_read() {
    m_len_resref = m__io->read_u1();
    if (!(m_len_resref <= 16)) {
        throw kaitai::validation_greater_than_error<uint8_t>(16, m_len_resref, m__io, std::string("/types/bioware_resref/seq/0"));
    }
    m_value = kaitai::kstream::bytes_to_str(m__io->read_bytes(len_resref()), "ASCII");
}

bioware_common_t::bioware_resref_t::~bioware_resref_t() {
    _clean_up();
}

void bioware_common_t::bioware_resref_t::_clean_up() {
}

bioware_common_t::bioware_vector3_t::bioware_vector3_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_common_t::bioware_vector3_t::_read() {
    m_x = m__io->read_f4le();
    m_y = m__io->read_f4le();
    m_z = m__io->read_f4le();
}

bioware_common_t::bioware_vector3_t::~bioware_vector3_t() {
    _clean_up();
}

void bioware_common_t::bioware_vector3_t::_clean_up() {
}

bioware_common_t::bioware_vector4_t::bioware_vector4_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_common_t::bioware_vector4_t::_read() {
    m_x = m__io->read_f4le();
    m_y = m__io->read_f4le();
    m_z = m__io->read_f4le();
    m_w = m__io->read_f4le();
}

bioware_common_t::bioware_vector4_t::~bioware_vector4_t() {
    _clean_up();
}

void bioware_common_t::bioware_vector4_t::_clean_up() {
}

bioware_common_t::substring_t::substring_t(kaitai::kstream* p__io, bioware_common_t::bioware_locstring_t* p__parent, bioware_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_gender = false;
    f_gender_raw = false;
    f_language = false;
    f_language_raw = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_common_t::substring_t::_read() {
    m_substring_id = m__io->read_u4le();
    m_len_text = m__io->read_u4le();
    m_text = kaitai::kstream::bytes_to_str(m__io->read_bytes(len_text()), "UTF-8");
}

bioware_common_t::substring_t::~substring_t() {
    _clean_up();
}

void bioware_common_t::substring_t::_clean_up() {
}

bioware_common_t::bioware_gender_id_t bioware_common_t::substring_t::gender() {
    if (f_gender)
        return m_gender;
    f_gender = true;
    m_gender = static_cast<bioware_common_t::bioware_gender_id_t>(gender_raw());
    return m_gender;
}

int32_t bioware_common_t::substring_t::gender_raw() {
    if (f_gender_raw)
        return m_gender_raw;
    f_gender_raw = true;
    m_gender_raw = substring_id() & 255;
    return m_gender_raw;
}

bioware_common_t::bioware_language_id_t bioware_common_t::substring_t::language() {
    if (f_language)
        return m_language;
    f_language = true;
    m_language = static_cast<bioware_common_t::bioware_language_id_t>(language_raw());
    return m_language;
}

int32_t bioware_common_t::substring_t::language_raw() {
    if (f_language_raw)
        return m_language_raw;
    f_language_raw = true;
    m_language_raw = substring_id() >> 8 & 255;
    return m_language_raw;
}
