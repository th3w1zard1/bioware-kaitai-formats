from construct import *
from construct.lib import *
import enum

class bioware_gff_common__gff_field_type(enum.IntEnum):
	uint8 = 0
	int8 = 1
	uint16 = 2
	int16 = 3
	uint32 = 4
	int32 = 5
	uint64 = 6
	int64 = 7
	single = 8
	double = 9
	string = 10
	resref = 11
	localized_string = 12
	binary = 13
	struct = 14
	list = 15
	vector4 = 16
	vector3 = 17
	str_ref = 18

bioware_gff_common = Struct(
)

_schema = bioware_gff_common
