from construct import *
from construct.lib import *

txb2 = Struct(
	'header' / LazyBound(lambda: tpc__tpc_header),
	'body' / GreedyBytes,
)

_schema = txb2
