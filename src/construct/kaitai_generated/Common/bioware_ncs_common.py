from construct import *
from construct.lib import *
import enum

class bioware_ncs_common__ncs_bytecode(enum.IntEnum):
	reserved_bc = 0
	cpdownsp = 1
	rsaddx = 2
	cptopsp = 3
	constx = 4
	action = 5
	logandxx = 6
	logorxx = 7
	incorxx = 8
	excorxx = 9
	boolandxx = 10
	equalxx = 11
	nequalxx = 12
	geqxx = 13
	gtxx = 14
	ltxx = 15
	leqxx = 16
	shleftxx = 17
	shrightxx = 18
	ushrightxx = 19
	addxx = 20
	subxx = 21
	mulxx = 22
	divxx = 23
	modxx = 24
	negx = 25
	compx = 26
	movsp = 27
	unused_gap = 28
	jmp = 29
	jsr = 30
	jz = 31
	retn = 32
	destruct = 33
	notx = 34
	decxsp = 35
	incxsp = 36
	jnz = 37
	cpdownbp = 38
	cptopbp = 39
	decxbp = 40
	incxbp = 41
	savebp = 42
	restorebp = 43
	store_state = 44
	nop = 45

class bioware_ncs_common__ncs_instruction_qualifier(enum.IntEnum):
	none = 0
	unary_operand_layout = 1
	int_type = 3
	float_type = 4
	string_type = 5
	object_type = 6
	effect_type = 16
	event_type = 17
	location_type = 18
	talent_type = 19
	int_int = 32
	float_float = 33
	object_object = 34
	string_string = 35
	struct_struct = 36
	int_float = 37
	float_int = 38
	effect_effect = 48
	event_event = 49
	location_location = 50
	talent_talent = 51
	vector_vector = 58
	vector_float = 59
	float_vector = 60

class bioware_ncs_common__ncs_program_size_marker(enum.IntEnum):
	program_size_prefix = 66

bioware_ncs_common = Struct(
)

_schema = bioware_ncs_common
