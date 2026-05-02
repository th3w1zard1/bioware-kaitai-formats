from construct import *
from construct.lib import *

rim__resource_entry = Struct(
	'resref' / FixedSized(16, GreedyString(encoding='ASCII')),
	'resource_type' / Enum(Int32ul, bioware_type_ids__xoreos_file_type_id),
	'resource_id' / Int32ul,
	'offset_to_data' / Int32ul,
	'num_data' / Int32ul,
	'data' / Pointer(this.offset_to_data, Array(this.num_data, Int8ub)),
)

rim__resource_entry_table = Struct(
	'entries' / Array(this._root.header.resource_count, LazyBound(lambda: rim__resource_entry)),
)

rim__rim_header = Struct(
	'file_type' / FixedSized(4, GreedyString(encoding='ASCII')),
	'file_version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'reserved' / Int32ul,
	'resource_count' / Int32ul,
	'offset_to_resource_table' / Int32ul,
	'offset_to_resources' / Int32ul,
	'has_resources' / Computed(lambda this: this.resource_count > 0),
)

rim = Struct(
	'header' / LazyBound(lambda: rim__rim_header),
	'gap_before_key_table_implicit' / If(this.header.offset_to_resource_table == 0, FixedSized(96, GreedyBytes)),
	'gap_before_key_table_explicit' / If(this.header.offset_to_resource_table != 0, FixedSized(this.header.offset_to_resource_table - 24, GreedyBytes)),
	'resource_entry_table' / If(this.header.resource_count > 0, LazyBound(lambda: rim__resource_entry_table)),
)

_schema = rim
