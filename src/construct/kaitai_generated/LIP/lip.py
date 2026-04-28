from construct import *
from construct.lib import *

lip__keyframe_entry = Struct(
	'timestamp' / Float32l,
	'shape' / Enum(Int8ub, bioware_common__bioware_lip_viseme_id),
)

lip = Struct(
	'file_type' / FixedSized(4, GreedyString(encoding='ASCII')),
	'file_version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'length' / Float32l,
	'num_keyframes' / Int32ul,
	'keyframes' / Array(this.num_keyframes, LazyBound(lambda: lip__keyframe_entry)),
)

_schema = lip
