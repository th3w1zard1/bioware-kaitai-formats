from construct import *
from construct.lib import *

gff_gui = Struct(
	'contents' / LazyBound(lambda: gff__gff_union_file),
)

_schema = gff_gui
