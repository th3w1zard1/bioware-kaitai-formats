from construct import *
from construct.lib import *

txb = Struct(
	'header' / LazyBound(lambda: tpc__tpc_header),
	'body' / GreedyBytes,
)

_schema = txb
