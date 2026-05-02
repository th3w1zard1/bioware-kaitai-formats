from construct import *
from construct.lib import *

gda = Struct(
	'as_gff4' / LazyBound(lambda: gff__gff4_file),
)

_schema = gda
