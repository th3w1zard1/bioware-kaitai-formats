from construct import *
from construct.lib import *

erf__erf_header = Struct(
	'file_type' / FixedSized(4, GreedyString(encoding='ASCII')),
	'file_version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'language_count' / Int32ul,
	'localized_string_size' / Int32ul,
	'entry_count' / Int32ul,
	'offset_to_localized_string_list' / Int32ul,
	'offset_to_key_list' / Int32ul,
	'offset_to_resource_list' / Int32ul,
	'build_year' / Int32ul,
	'build_day' / Int32ul,
	'description_strref' / Int32sl,
	'reserved' / FixedSized(116, GreedyBytes),
	'is_save_file' / Computed(lambda this:  ((this.file_type == u"MOD ") and (this.description_strref == 0)) ),
)

erf__key_entry = Struct(
	'resref' / FixedSized(16, GreedyString(encoding='ASCII')),
	'resource_id' / Int32ul,
	'resource_type' / Enum(Int16ul, bioware_type_ids__xoreos_file_type_id),
	'unused' / Int16ul,
)

erf__key_list = Struct(
	'entries' / Array(this._root.header.entry_count, LazyBound(lambda: erf__key_entry)),
)

erf__localized_string_entry = Struct(
	'language_id' / Int32ul,
	'string_size' / Int32ul,
	'string_data' / FixedSized(this.string_size, GreedyString(encoding='UTF-8')),
)

erf__localized_string_list = Struct(
	'entries' / Array(this._root.header.language_count, LazyBound(lambda: erf__localized_string_entry)),
)

erf__resource_entry = Struct(
	'offset_to_data' / Int32ul,
	'len_data' / Int32ul,
	'data' / Pointer(this.offset_to_data, FixedSized(this.len_data, GreedyBytes)),
)

erf__resource_list = Struct(
	'entries' / Array(this._root.header.entry_count, LazyBound(lambda: erf__resource_entry)),
)

erf = Struct(
	'header' / LazyBound(lambda: erf__erf_header),
	'key_list' / Pointer(this.header.offset_to_key_list, LazyBound(lambda: erf__key_list)),
	'localized_string_list' / Pointer(this.header.offset_to_localized_string_list, If(this.header.language_count > 0, LazyBound(lambda: erf__localized_string_list))),
	'resource_list' / Pointer(this.header.offset_to_resource_list, LazyBound(lambda: erf__resource_list)),
)

_schema = erf
