from construct import *
from construct.lib import *
import enum

class bioware_extract_common__bioware_search_location_id(enum.IntEnum):
	override = 0
	modules = 1
	chitin = 2
	textures_tpa = 3
	textures_tpb = 4
	textures_tpc = 5
	textures_gui = 6
	music = 7
	sound = 8
	voice = 9
	lips = 10
	rims = 11
	custom_modules = 12
	custom_folders = 13

bioware_extract_common__bioware_texture_pack_name_str = Struct(
	'value' / NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False, consume=True),
)

bioware_extract_common = Struct(
)

_schema = bioware_extract_common
