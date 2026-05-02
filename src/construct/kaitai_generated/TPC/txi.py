from construct import *
from construct.lib import *

txi = Struct(
	'content' / GreedyString(encoding='ASCII'),
)

_schema = txi
