from construct import *
from construct.lib import *

nss__nss_source = Struct(
	'content' / GreedyString(encoding='UTF-8'),
)

nss = Struct(
	'bom' / If(stream_tell(_io) == 0, Int16ul),
	'source_code' / GreedyString(encoding='UTF-8'),
)

_schema = nss
