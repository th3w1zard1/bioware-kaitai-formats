from construct import *
from construct.lib import *

tlk__string_data_entry = Struct(
	'flags' / Int32ul,
	'sound_resref' / FixedSized(16, GreedyString(encoding='ASCII')),
	'volume_variance' / Int32ul,
	'pitch_variance' / Int32ul,
	'text_offset' / Int32ul,
	'text_length' / Int32ul,
	'sound_length' / Float32l,
	'entry_size' / Computed(lambda this: 40),
	'sound_length_present' / Computed(lambda this: this.flags & 4 != 0),
	'sound_present' / Computed(lambda this: this.flags & 2 != 0),
	'text_data' / Pointer(this.text_file_offset, FixedSized(this.text_length, GreedyString(encoding='ASCII'))),
	'text_file_offset' / Computed(lambda this: this._root.header.entries_offset + this.text_offset),
	'text_present' / Computed(lambda this: this.flags & 1 != 0),
)

tlk__string_data_table = Struct(
	'entries' / Array(this._root.header.string_count, LazyBound(lambda: tlk__string_data_entry)),
)

tlk__tlk_header = Struct(
	'file_type' / FixedSized(4, GreedyString(encoding='ASCII')),
	'file_version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'language_id' / Int32ul,
	'string_count' / Int32ul,
	'entries_offset' / Int32ul,
	'expected_entries_offset' / Computed(lambda this: 20 + this.string_count * 40),
	'header_size' / Computed(lambda this: 20),
)

tlk = Struct(
	'header' / LazyBound(lambda: tlk__tlk_header),
	'string_data_table' / LazyBound(lambda: tlk__string_data_table),
)

_schema = tlk
