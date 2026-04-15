from construct import *
from construct.lib import *

dds__bioware_dds_header = Struct(
	'width' / Int32ul,
	'height' / Int32ul,
	'bytes_per_pixel' / Enum(Int32ul, bioware_common__bioware_dds_variant_bytes_per_pixel),
	'data_size' / Int32ul,
	'unused_float' / Float32l,
)

dds__ddpixelformat = Struct(
	'size' / Int32ul,
	'flags' / Int32ul,
	'fourcc' / FixedSized(4, GreedyString(encoding='ASCII')),
	'rgb_bit_count' / Int32ul,
	'r_bit_mask' / Int32ul,
	'g_bit_mask' / Int32ul,
	'b_bit_mask' / Int32ul,
	'a_bit_mask' / Int32ul,
)

dds__dds_header = Struct(
	'size' / Int32ul,
	'flags' / Int32ul,
	'height' / Int32ul,
	'width' / Int32ul,
	'pitch_or_linear_size' / Int32ul,
	'depth' / Int32ul,
	'mipmap_count' / Int32ul,
	'reserved1' / Array(11, Int32ul),
	'pixel_format' / LazyBound(lambda: dds__ddpixelformat),
	'caps' / Int32ul,
	'caps2' / Int32ul,
	'caps3' / Int32ul,
	'caps4' / Int32ul,
	'reserved2' / Int32ul,
)

dds = Struct(
	'magic' / FixedSized(4, GreedyString(encoding='ASCII')),
	'header' / If(this.magic == u"DDS ", LazyBound(lambda: dds__dds_header)),
	'bioware_header' / If(this.magic != u"DDS ", LazyBound(lambda: dds__bioware_dds_header)),
	'pixel_data' / GreedyBytes,
)

_schema = dds
