from construct import *
from construct.lib import *

bip = Struct(
	'payload' / GreedyBytes,
)

_schema = bip
