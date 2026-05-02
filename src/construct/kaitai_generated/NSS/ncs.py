from construct import *
from construct.lib import *

ncs__instruction = Struct(
	'opcode' / Enum(Int8ub, bioware_ncs_common__ncs_bytecode),
	'qualifier' / Enum(Int8ub, bioware_ncs_common__ncs_instruction_qualifier),
	'arguments' / RepeatUntil(lambda obj_, list_, this: stream_tell(_io) >= stream_size(_io), Int8ub),
)

ncs = Struct(
	'file_type' / FixedSized(4, GreedyString(encoding='ASCII')),
	'file_version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'size_marker' / Int8ub,
	'file_size' / Int32ub,
	'instructions' / RepeatUntil(lambda obj_, list_, this: stream_tell(_io) >= this.file_size, LazyBound(lambda: ncs__instruction)),
)

_schema = ncs
