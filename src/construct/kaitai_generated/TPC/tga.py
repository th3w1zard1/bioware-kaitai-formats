from construct import *
from construct.lib import *

tga__color_map_specification = Struct(
	'first_entry_index' / Int16ul,
	'length' / Int16ul,
	'entry_size' / Int8ub,
)

tga__image_specification = Struct(
	'x_origin' / Int16ul,
	'y_origin' / Int16ul,
	'width' / Int16ul,
	'height' / Int16ul,
	'pixel_depth' / Int8ub,
	'image_descriptor' / Int8ub,
)

tga = Struct(
	'id_length' / Int8ub,
	'color_map_type' / Enum(Int8ub, tga_common__tga_color_map_type),
	'image_type' / Enum(Int8ub, tga_common__tga_image_type),
	'color_map_spec' / If(this.color_map_type == 'present', LazyBound(lambda: tga__color_map_specification)),
	'image_spec' / LazyBound(lambda: tga__image_specification),
	'image_id' / If(this.id_length > 0, FixedSized(this.id_length, GreedyString(encoding='ASCII'))),
	'color_map_data' / If(this.color_map_type == 'present', Array(this.color_map_spec.length, Int8ub)),
	'image_data' / GreedyRange(Int8ub),
)

_schema = tga
