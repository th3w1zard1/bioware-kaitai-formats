from construct import *
from construct.lib import *
import enum

class tga_common__tga_color_map_type(enum.IntEnum):
	none = 0
	present = 1

class tga_common__tga_image_type(enum.IntEnum):
	no_image_data = 0
	uncompressed_color_mapped = 1
	uncompressed_rgb = 2
	uncompressed_greyscale = 3
	rle_color_mapped = 9
	rle_rgb = 10
	rle_greyscale = 11

tga_common = Struct(
)

_schema = tga_common
