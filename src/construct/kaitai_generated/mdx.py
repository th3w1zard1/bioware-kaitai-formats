from construct import *
from construct.lib import *

mdx = Struct(
	'vertex_data' / GreedyBytes,
)

_schema = mdx
