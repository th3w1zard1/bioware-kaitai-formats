from construct import *
from construct.lib import *

ssf__sound_array = Struct(
	'entries' / Array(28, LazyBound(lambda: ssf__sound_entry)),
)

ssf__sound_entry = Struct(
	'strref_raw' / Int32ul,
	'is_no_sound' / Computed(lambda this: this.strref_raw == 4294967295),
)

ssf = Struct(
	'file_type' / FixedSized(4, GreedyString(encoding='ASCII')),
	'file_version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'sounds_offset' / Int32ul,
	'sounds' / Pointer(this.sounds_offset, LazyBound(lambda: ssf__sound_array)),
)

_schema = ssf
