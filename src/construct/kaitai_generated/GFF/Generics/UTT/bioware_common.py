from construct import *
from construct.lib import *
import enum

class bioware_common__bioware_dds_variant_bytes_per_pixel(enum.IntEnum):
	dxt1 = 3
	dxt5 = 4

class bioware_common__bioware_equipment_slot_flag(enum.IntEnum):
	invalid = 0
	head = 1
	armor = 2
	gauntlet = 8
	right_hand = 16
	left_hand = 32
	right_arm = 128
	left_arm = 256
	implant = 512
	belt = 1024
	claw1 = 16384
	claw2 = 32768
	claw3 = 65536
	hide = 131072
	right_hand_2 = 262144
	left_hand_2 = 524288

class bioware_common__bioware_game_id(enum.IntEnum):
	k1 = 1
	k2 = 2
	k1_xbox = 3
	k2_xbox = 4
	k1_ios = 5
	k2_ios = 6
	k1_android = 7
	k2_android = 8

class bioware_common__bioware_gender_id(enum.IntEnum):
	male = 0
	female = 1

class bioware_common__bioware_language_id(enum.IntEnum):
	english = 0
	french = 1
	german = 2
	italian = 3
	spanish = 4
	polish = 5
	afrikaans = 6
	basque = 7
	breton = 9
	catalan = 10
	chamorro = 11
	chichewa = 12
	corsican = 13
	danish = 14
	dutch = 15
	faroese = 16
	filipino = 18
	finnish = 19
	flemish = 20
	frisian = 21
	galician = 22
	ganda = 23
	haitian_creole = 24
	hausa_latin = 25
	hawaiian = 26
	icelandic = 27
	ido = 28
	indonesian = 29
	igbo = 30
	irish = 31
	interlingua = 32
	javanese_latin = 33
	latin = 34
	luxembourgish = 35
	maltese = 36
	norwegian = 37
	occitan = 38
	portuguese = 39
	scots = 40
	scottish_gaelic = 41
	shona = 42
	soto = 43
	sundanese_latin = 44
	swahili = 45
	swedish = 46
	tagalog = 47
	tahitian = 48
	tongan = 49
	uzbek_latin = 50
	walloon = 51
	xhosa = 52
	yoruba = 53
	welsh = 54
	zulu = 55
	bulgarian = 58
	belarisian = 59
	macedonian = 60
	russian = 61
	serbian_cyrillic = 62
	tajik = 63
	tatar_cyrillic = 64
	ukrainian = 66
	uzbek = 67
	albanian = 68
	bosnian_latin = 69
	czech = 70
	slovak = 71
	slovene = 72
	croatian = 73
	hungarian = 75
	romanian = 76
	greek = 77
	esperanto = 78
	azerbaijani_latin = 79
	turkish = 81
	turkmen_latin = 82
	hebrew = 83
	arabic = 84
	estonian = 85
	latvian = 86
	lithuanian = 87
	vietnamese = 88
	thai = 89
	aymara = 90
	kinyarwanda = 91
	kurdish_latin = 92
	malagasy = 93
	malay_latin = 94
	maori = 95
	moldovan_latin = 96
	samoan = 97
	somali = 98
	korean = 128
	chinese_traditional = 129
	chinese_simplified = 130
	japanese = 131
	unknown = 2147483646

class bioware_common__bioware_lip_viseme_id(enum.IntEnum):
	neutral = 0
	ee = 1
	eh = 2
	ah = 3
	oh = 4
	ooh = 5
	y = 6
	sts = 7
	fv = 8
	ng = 9
	th = 10
	mpb = 11
	td = 12
	sh = 13
	l = 14
	kg = 15

class bioware_common__bioware_ltr_alphabet_length(enum.IntEnum):
	neverwinter_nights = 26
	kotor = 28

class bioware_common__bioware_object_type_id(enum.IntEnum):
	invalid = 0
	creature = 1
	door = 2
	item = 3
	trigger = 4
	placeable = 5
	waypoint = 6
	encounter = 7
	store = 8
	area = 9
	sound = 10
	camera = 11

class bioware_common__bioware_pcc_compression_codec(enum.IntEnum):
	none = 0
	zlib = 1
	lzo = 2

class bioware_common__bioware_pcc_package_kind(enum.IntEnum):
	normal_package = 0
	patch_package = 1

class bioware_common__bioware_tpc_pixel_format_id(enum.IntEnum):
	greyscale = 1
	rgb_or_dxt1 = 2
	rgba_or_dxt5 = 4
	bgra_xbox_swizzle = 12

class bioware_common__riff_wave_format_tag(enum.IntEnum):
	pcm = 1
	adpcm_ms = 2
	ieee_float = 3
	alaw = 6
	mulaw = 7
	dvi_ima_adpcm = 17
	mpeg_layer3 = 85
	wave_format_extensible = 65534

bioware_common__bioware_binary_data = Struct(
	'len_value' / Int32ul,
	'value' / FixedSized(this.len_value, GreedyBytes),
)

bioware_common__bioware_cexo_string = Struct(
	'len_string' / Int32ul,
	'value' / FixedSized(this.len_string, GreedyString(encoding='UTF-8')),
)

bioware_common__bioware_locstring = Struct(
	'total_size' / Int32ul,
	'string_ref' / Int32ul,
	'num_substrings' / Int32ul,
	'substrings' / Array(this.num_substrings, LazyBound(lambda: bioware_common__substring)),
	'has_strref' / Computed(lambda this: this.string_ref != 4294967295),
)

bioware_common__bioware_resref = Struct(
	'len_resref' / Int8ub,
	'value' / FixedSized(this.len_resref, GreedyString(encoding='ASCII')),
)

bioware_common__bioware_vector3 = Struct(
	'x' / Float32l,
	'y' / Float32l,
	'z' / Float32l,
)

bioware_common__bioware_vector4 = Struct(
	'x' / Float32l,
	'y' / Float32l,
	'z' / Float32l,
	'w' / Float32l,
)

bioware_common__substring = Struct(
	'substring_id' / Int32ul,
	'len_text' / Int32ul,
	'text' / FixedSized(this.len_text, GreedyString(encoding='UTF-8')),
	'gender' / Computed(lambda this: KaitaiStream.resolve_enum(BiowareCommon.BiowareGenderId, this.gender_raw)),
	'gender_raw' / Computed(lambda this: this.substring_id & 255),
	'language' / Computed(lambda this: KaitaiStream.resolve_enum(BiowareCommon.BiowareLanguageId, this.language_raw)),
	'language_raw' / Computed(lambda this: this.substring_id >> 8 & 255),
)

bioware_common = Struct(
)

_schema = bioware_common
