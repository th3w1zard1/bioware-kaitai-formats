from construct import *
from construct.lib import *

bwm__aabb_node = Struct(
	'bounds_min' / LazyBound(lambda: bwm__vec3f),
	'bounds_max' / LazyBound(lambda: bwm__vec3f),
	'face_index' / Int32sl,
	'unknown' / Int32ul,
	'most_significant_plane' / Int32ul,
	'left_child_index' / Int32ul,
	'right_child_index' / Int32ul,
	'has_left_child' / Computed(lambda this: this.left_child_index != 4294967295),
	'has_right_child' / Computed(lambda this: this.right_child_index != 4294967295),
	'is_internal_node' / Computed(lambda this: this.face_index == -1),
	'is_leaf_node' / Computed(lambda this: this.face_index != -1),
)

bwm__aabb_nodes_array = Struct(
	'nodes' / Array(this._root.data_table_offsets.aabb_count, LazyBound(lambda: bwm__aabb_node)),
)

bwm__adjacencies_array = Struct(
	'adjacencies' / Array(this._root.data_table_offsets.adjacency_count, LazyBound(lambda: bwm__adjacency_triplet)),
)

bwm__adjacency_triplet = Struct(
	'edge_0_adjacency' / Int32sl,
	'edge_1_adjacency' / Int32sl,
	'edge_2_adjacency' / Int32sl,
	'edge_0_face_index' / Computed(lambda this: (this.edge_0_adjacency // 3 if this.edge_0_adjacency != -1 else -1)),
	'edge_0_has_neighbor' / Computed(lambda this: this.edge_0_adjacency != -1),
	'edge_0_local_edge' / Computed(lambda this: (this.edge_0_adjacency % 3 if this.edge_0_adjacency != -1 else -1)),
	'edge_1_face_index' / Computed(lambda this: (this.edge_1_adjacency // 3 if this.edge_1_adjacency != -1 else -1)),
	'edge_1_has_neighbor' / Computed(lambda this: this.edge_1_adjacency != -1),
	'edge_1_local_edge' / Computed(lambda this: (this.edge_1_adjacency % 3 if this.edge_1_adjacency != -1 else -1)),
	'edge_2_face_index' / Computed(lambda this: (this.edge_2_adjacency // 3 if this.edge_2_adjacency != -1 else -1)),
	'edge_2_has_neighbor' / Computed(lambda this: this.edge_2_adjacency != -1),
	'edge_2_local_edge' / Computed(lambda this: (this.edge_2_adjacency % 3 if this.edge_2_adjacency != -1 else -1)),
)

bwm__bwm_header = Struct(
	'magic' / FixedSized(4, GreedyString(encoding='ASCII')),
	'version' / FixedSized(4, GreedyString(encoding='ASCII')),
	'is_valid_bwm' / Computed(lambda this:  ((this.magic == u"BWM ") and (this.version == u"V1.0")) ),
)

bwm__data_table_offsets = Struct(
	'vertex_count' / Int32ul,
	'vertex_offset' / Int32ul,
	'face_count' / Int32ul,
	'face_indices_offset' / Int32ul,
	'materials_offset' / Int32ul,
	'normals_offset' / Int32ul,
	'distances_offset' / Int32ul,
	'aabb_count' / Int32ul,
	'aabb_offset' / Int32ul,
	'unknown' / Int32ul,
	'adjacency_count' / Int32ul,
	'adjacency_offset' / Int32ul,
	'edge_count' / Int32ul,
	'edge_offset' / Int32ul,
	'perimeter_count' / Int32ul,
	'perimeter_offset' / Int32ul,
)

bwm__edge_entry = Struct(
	'edge_index' / Int32ul,
	'transition' / Int32sl,
	'face_index' / Computed(lambda this: this.edge_index // 3),
	'has_transition' / Computed(lambda this: this.transition != -1),
	'local_edge_index' / Computed(lambda this: this.edge_index % 3),
)

bwm__edges_array = Struct(
	'edges' / Array(this._root.data_table_offsets.edge_count, LazyBound(lambda: bwm__edge_entry)),
)

bwm__face_indices = Struct(
	'v1_index' / Int32ul,
	'v2_index' / Int32ul,
	'v3_index' / Int32ul,
)

bwm__face_indices_array = Struct(
	'faces' / Array(this._root.data_table_offsets.face_count, LazyBound(lambda: bwm__face_indices)),
)

bwm__materials_array = Struct(
	'materials' / Array(this._root.data_table_offsets.face_count, Int32ul),
)

bwm__normals_array = Struct(
	'normals' / Array(this._root.data_table_offsets.face_count, LazyBound(lambda: bwm__vec3f)),
)

bwm__perimeters_array = Struct(
	'perimeters' / Array(this._root.data_table_offsets.perimeter_count, Int32ul),
)

bwm__planar_distances_array = Struct(
	'distances' / Array(this._root.data_table_offsets.face_count, Float32l),
)

bwm__vec3f = Struct(
	'x' / Float32l,
	'y' / Float32l,
	'z' / Float32l,
)

bwm__vertices_array = Struct(
	'vertices' / Array(this._root.data_table_offsets.vertex_count, LazyBound(lambda: bwm__vec3f)),
)

bwm__walkmesh_properties = Struct(
	'walkmesh_type' / Int32ul,
	'relative_use_position_1' / LazyBound(lambda: bwm__vec3f),
	'relative_use_position_2' / LazyBound(lambda: bwm__vec3f),
	'absolute_use_position_1' / LazyBound(lambda: bwm__vec3f),
	'absolute_use_position_2' / LazyBound(lambda: bwm__vec3f),
	'position' / LazyBound(lambda: bwm__vec3f),
	'is_area_walkmesh' / Computed(lambda this: this.walkmesh_type == 1),
	'is_placeable_or_door' / Computed(lambda this: this.walkmesh_type == 0),
)

bwm = Struct(
	'header' / LazyBound(lambda: bwm__bwm_header),
	'walkmesh_properties' / LazyBound(lambda: bwm__walkmesh_properties),
	'data_table_offsets' / LazyBound(lambda: bwm__data_table_offsets),
	'aabb_nodes' / Pointer(this._root.data_table_offsets.aabb_offset, If( ((this._root.walkmesh_properties.walkmesh_type == 1) and (this._root.data_table_offsets.aabb_count > 0)) , LazyBound(lambda: bwm__aabb_nodes_array))),
	'adjacencies' / Pointer(this._root.data_table_offsets.adjacency_offset, If( ((this._root.walkmesh_properties.walkmesh_type == 1) and (this._root.data_table_offsets.adjacency_count > 0)) , LazyBound(lambda: bwm__adjacencies_array))),
	'edges' / Pointer(this._root.data_table_offsets.edge_offset, If( ((this._root.walkmesh_properties.walkmesh_type == 1) and (this._root.data_table_offsets.edge_count > 0)) , LazyBound(lambda: bwm__edges_array))),
	'face_indices' / Pointer(this._root.data_table_offsets.face_indices_offset, If(this._root.data_table_offsets.face_count > 0, LazyBound(lambda: bwm__face_indices_array))),
	'materials' / Pointer(this._root.data_table_offsets.materials_offset, If(this._root.data_table_offsets.face_count > 0, LazyBound(lambda: bwm__materials_array))),
	'normals' / Pointer(this._root.data_table_offsets.normals_offset, If( ((this._root.walkmesh_properties.walkmesh_type == 1) and (this._root.data_table_offsets.face_count > 0)) , LazyBound(lambda: bwm__normals_array))),
	'perimeters' / Pointer(this._root.data_table_offsets.perimeter_offset, If( ((this._root.walkmesh_properties.walkmesh_type == 1) and (this._root.data_table_offsets.perimeter_count > 0)) , LazyBound(lambda: bwm__perimeters_array))),
	'planar_distances' / Pointer(this._root.data_table_offsets.distances_offset, If( ((this._root.walkmesh_properties.walkmesh_type == 1) and (this._root.data_table_offsets.face_count > 0)) , LazyBound(lambda: bwm__planar_distances_array))),
	'vertices' / Pointer(this._root.data_table_offsets.vertex_offset, If(this._root.data_table_offsets.vertex_count > 0, LazyBound(lambda: bwm__vertices_array))),
)

_schema = bwm
