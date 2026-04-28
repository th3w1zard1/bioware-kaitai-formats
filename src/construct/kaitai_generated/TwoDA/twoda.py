from construct import *
from construct.lib import *

twoda__cell_values_section = Struct(
	'raw_data' / FixedSized(this._root.len_cell_values_section, GreedyString(encoding='ASCII')),
)

twoda__row_label_entry = Struct(
	'label_value' / NullTerminated(GreedyString(encoding='ASCII'), term=b"\x09", include=False, consume=True),
)

twoda__row_labels_section = Struct(
	'labels' / Array(this._root.row_count, LazyBound(lambda: twoda__row_label_entry)),
)

twoda__twoda_header = Struct(
	'magic' / FixedSized(4, GreedyString(encoding='ASCII')),
	'version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'newline' / Int8ub,
	'is_valid_twoda' / Computed(lambda this:  ((this.magic == u"2DA ") and (this.version == u"V2.b") and (this.newline == 10)) ),
)

twoda = Struct(
	'header' / LazyBound(lambda: twoda__twoda_header),
	'column_headers_raw' / NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False, consume=True),
	'row_count' / Int32ul,
	'row_labels_section' / LazyBound(lambda: twoda__row_labels_section),
	'cell_offsets' / Array(this.row_count * this.column_count, Int16ul),
	'len_cell_values_section' / Int16ul,
	'cell_values_section' / FixedSized(this.len_cell_values_section, LazyBound(lambda: twoda__cell_values_section)),
)

_schema = twoda
