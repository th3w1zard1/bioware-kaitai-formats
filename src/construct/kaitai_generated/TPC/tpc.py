from construct import *
from construct.lib import *

tpc__tpc_header = Struct(
	'data_size' / Int32ul,
	'alpha_test' / Float32l,
	'width' / Int16ul,
	'height' / Int16ul,
	'pixel_encoding' / Enum(Int8ub, bioware_common__bioware_tpc_pixel_format_id),
	'mipmap_count' / Int8ub,
	'reserved' / Array(114, Int8ub),
	'is_compressed' / Computed(lambda this: this.data_size != 0),
	'is_uncompressed' / Computed(lambda this: this.data_size == 0),
)

tpc = Struct(
	'header' / LazyBound(lambda: tpc__tpc_header),
	'body' / GreedyBytes,
)

_schema = tpc
