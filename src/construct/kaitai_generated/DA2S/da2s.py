from construct import *
from construct.lib import *

da2s__length_prefixed_string = Struct(
	'length' / Int32sl,
	'value' / FixedSized(this.length, NullTerminated(GreedyString(encoding='UTF-8'), term=b"\x00", include=False)),
	'value_trimmed' / Computed(lambda this: this.value),
)

da2s = Struct(
	'signature' / FixedSized(4, GreedyString(encoding='ASCII')),
	'version' / Int32sl,
	'save_name' / LazyBound(lambda: da2s__length_prefixed_string),
	'module_name' / LazyBound(lambda: da2s__length_prefixed_string),
	'area_name' / LazyBound(lambda: da2s__length_prefixed_string),
	'time_played_seconds' / Int32sl,
	'timestamp_filetime' / Int64sl,
	'num_screenshot_data' / Int32sl,
	'screenshot_data' / If(this.num_screenshot_data > 0, Array(this.num_screenshot_data, Int8ub)),
	'num_portrait_data' / Int32sl,
	'portrait_data' / If(this.num_portrait_data > 0, Array(this.num_portrait_data, Int8ub)),
	'player_name' / LazyBound(lambda: da2s__length_prefixed_string),
	'party_member_count' / Int32sl,
	'player_level' / Int32sl,
)

_schema = da2s
