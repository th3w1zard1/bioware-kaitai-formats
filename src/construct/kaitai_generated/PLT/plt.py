from construct import *
from construct.lib import *

plt__pixel_data_section = Struct(
	'pixels' / Array(this._root.header.width * this._root.header.height, LazyBound(lambda: plt__plt_pixel)),
)

plt__plt_header = Struct(
	'signature' / FixedSized(4, GreedyString(encoding='ASCII')),
	'version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'unknown1' / Int32ul,
	'unknown2' / Int32ul,
	'width' / Int32ul,
	'height' / Int32ul,
)

plt__plt_pixel = Struct(
	'color_index' / Int8ub,
	'palette_group_index' / Int8ub,
)

plt = Struct(
	'header' / LazyBound(lambda: plt__plt_header),
	'pixel_data' / LazyBound(lambda: plt__pixel_data_section),
)

_schema = plt
