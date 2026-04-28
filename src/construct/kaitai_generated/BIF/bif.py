from construct import *
from construct.lib import *

bif__var_resource_entry = Struct(
	'resource_id' / Int32ul,
	'offset' / Int32ul,
	'file_size' / Int32ul,
	'resource_type' / Enum(Int32ul, bioware_type_ids__xoreos_file_type_id),
)

bif__var_resource_table = Struct(
	'entries' / Array(this._root.var_res_count, LazyBound(lambda: bif__var_resource_entry)),
)

bif = Struct(
	'file_type' / FixedSized(4, GreedyString(encoding='ASCII')),
	'version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'var_res_count' / Int32ul,
	'fixed_res_count' / Int32ul,
	'var_table_offset' / Int32ul,
	'var_resource_table' / Pointer(this.var_table_offset, If(this.var_res_count > 0, LazyBound(lambda: bif__var_resource_table))),
)

_schema = bif
