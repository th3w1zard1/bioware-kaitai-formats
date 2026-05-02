from construct import *
from construct.lib import *

pcc__export_entry = Struct(
	'class_index' / Int32sl,
	'super_class_index' / Int32sl,
	'link' / Int32sl,
	'object_name_index' / Int32sl,
	'object_name_number' / Int32sl,
	'archetype_index' / Int32sl,
	'object_flags' / Int64ul,
	'data_size' / Int32ul,
	'data_offset' / Int32ul,
	'unknown1' / Int32ul,
	'num_components' / Int32sl,
	'unknown2' / Int32ul,
	'guid' / LazyBound(lambda: pcc__guid),
	'components' / If(this.num_components > 0, Array(this.num_components, Int32sl)),
)

pcc__export_table = Struct(
	'entries' / Array(this._root.header.export_count, LazyBound(lambda: pcc__export_entry)),
)

pcc__file_header = Struct(
	'magic' / Int32ul,
	'version' / Int32ul,
	'licensee_version' / Int32ul,
	'header_size' / Int32sl,
	'package_name' / FixedSized(10, GreedyString(encoding='UTF-16LE')),
	'package_flags' / Int32ul,
	'package_type' / Enum(Int32ul, bioware_common__bioware_pcc_package_kind),
	'name_count' / Int32ul,
	'name_table_offset' / Int32ul,
	'export_count' / Int32ul,
	'export_table_offset' / Int32ul,
	'import_count' / Int32ul,
	'import_table_offset' / Int32ul,
	'depend_offset' / Int32ul,
	'depend_count' / Int32ul,
	'guid_part1' / Int32ul,
	'guid_part2' / Int32ul,
	'guid_part3' / Int32ul,
	'guid_part4' / Int32ul,
	'generations' / Int32ul,
	'export_count_dup' / Int32ul,
	'name_count_dup' / Int32ul,
	'unknown1' / Int32ul,
	'engine_version' / Int32ul,
	'cooker_version' / Int32ul,
	'compression_flags' / Int32ul,
	'package_source' / Int32ul,
	'compression_type' / Enum(Int32ul, bioware_common__bioware_pcc_compression_codec),
	'chunk_count' / Int32ul,
)

pcc__guid = Struct(
	'part1' / Int32ul,
	'part2' / Int32ul,
	'part3' / Int32ul,
	'part4' / Int32ul,
)

pcc__import_entry = Struct(
	'package_name_index' / Int64sl,
	'class_name_index' / Int32sl,
	'link' / Int64sl,
	'import_name_index' / Int64sl,
)

pcc__import_table = Struct(
	'entries' / Array(this._root.header.import_count, LazyBound(lambda: pcc__import_entry)),
)

pcc__name_entry = Struct(
	'length' / Int32sl,
	'name' / FixedSized((-(this.length) if this.length < 0 else this.length) * 2, GreedyString(encoding='UTF-16LE')),
	'abs_length' / Computed(lambda this: (-(this.length) if this.length < 0 else this.length)),
	'name_size' / Computed(lambda this: this.abs_length * 2),
)

pcc__name_table = Struct(
	'entries' / Array(this._root.header.name_count, LazyBound(lambda: pcc__name_entry)),
)

pcc = Struct(
	'header' / LazyBound(lambda: pcc__file_header),
	'compression_type' / Computed(lambda this: this.header.compression_type),
	'export_table' / Pointer(this.header.export_table_offset, If(this.header.export_count > 0, LazyBound(lambda: pcc__export_table))),
	'import_table' / Pointer(this.header.import_table_offset, If(this.header.import_count > 0, LazyBound(lambda: pcc__import_table))),
	'is_compressed' / Computed(lambda this: this.header.package_flags & 33554432 != 0),
	'name_table' / Pointer(this.header.name_table_offset, If(this.header.name_count > 0, LazyBound(lambda: pcc__name_table))),
)

_schema = pcc
