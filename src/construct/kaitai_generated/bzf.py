from construct import *
from construct.lib import *

bzf = Struct(
	'file_type' / FixedSized(4, GreedyString(encoding='ASCII')),
	'version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'compressed_data' / GreedyBytes,
)

_schema = bzf
