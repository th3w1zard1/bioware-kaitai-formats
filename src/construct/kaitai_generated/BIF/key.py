from construct import *
from construct.lib import *

key__file_entry = Struct(
	'file_size' / Int32ul,
	'filename_offset' / Int32ul,
	'filename_size' / Int16ul,
	'drives' / Int16ul,
	'filename' / Pointer(this.filename_offset, FixedSized(this.filename_size, GreedyString(encoding='ASCII'))),
)

key__file_table = Struct(
	'entries' / Array(this._root.bif_count, LazyBound(lambda: key__file_entry)),
)

key__filename_table = Struct(
	'filenames' / GreedyString(encoding='ASCII'),
)

key__key_entry = Struct(
	'resref' / FixedSized(16, GreedyString(encoding='ASCII')),
	'resource_type' / Enum(Int16ul, bioware_type_ids__xoreos_file_type_id),
	'resource_id' / Int32ul,
)

key__key_table = Struct(
	'entries' / Array(this._root.key_count, LazyBound(lambda: key__key_entry)),
)

key = Struct(
	'file_type' / FixedSized(4, GreedyString(encoding='ASCII')),
	'file_version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'bif_count' / Int32ul,
	'key_count' / Int32ul,
	'file_table_offset' / Int32ul,
	'key_table_offset' / Int32ul,
	'build_year' / Int32ul,
	'build_day' / Int32ul,
	'reserved' / FixedSized(32, GreedyBytes),
	'file_table' / Pointer(this.file_table_offset, If(this.bif_count > 0, LazyBound(lambda: key__file_table))),
	'key_table' / Pointer(this.key_table_offset, If(this.key_count > 0, LazyBound(lambda: key__key_table))),
)

_schema = key
