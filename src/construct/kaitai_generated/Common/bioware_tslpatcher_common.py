from construct import *
from construct.lib import *
import enum

class bioware_tslpatcher_common__bioware_tslpatcher_log_type_id(enum.IntEnum):
	verbose = 0
	note = 1
	warning = 2
	error = 3

class bioware_tslpatcher_common__bioware_tslpatcher_target_type_id(enum.IntEnum):
	row_index = 0
	row_label = 1
	label_column = 2

bioware_tslpatcher_common__bioware_diff_format_str = Struct(
	'value' / NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False, consume=True),
)

bioware_tslpatcher_common__bioware_diff_resource_type_str = Struct(
	'value' / NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False, consume=True),
)

bioware_tslpatcher_common__bioware_diff_type_str = Struct(
	'value' / NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False, consume=True),
)

bioware_tslpatcher_common__bioware_ncs_token_type_str = Struct(
	'value' / NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False, consume=True),
)

bioware_tslpatcher_common = Struct(
)

_schema = bioware_tslpatcher_common
