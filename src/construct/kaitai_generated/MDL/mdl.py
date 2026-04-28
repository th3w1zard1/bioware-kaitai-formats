from construct import *
from construct.lib import *

mdl__aabb_header = Struct(
	'trimesh_base' / LazyBound(lambda: mdl__trimesh_header),
	'unknown' / Int32ul,
)

mdl__animation_event = Struct(
	'activation_time' / Float32l,
	'event_name' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
)

mdl__animation_header = Struct(
	'geo_header' / LazyBound(lambda: mdl__geometry_header),
	'animation_length' / Float32l,
	'transition_time' / Float32l,
	'animation_root' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'event_array_offset' / Int32ul,
	'event_count' / Int32ul,
	'event_count_duplicate' / Int32ul,
	'unknown' / Int32ul,
)

mdl__animmesh_header = Struct(
	'trimesh_base' / LazyBound(lambda: mdl__trimesh_header),
	'unknown' / Float32l,
	'unknown_array' / LazyBound(lambda: mdl__array_definition),
	'unknown_floats' / Array(9, Float32l),
)

mdl__array_definition = Struct(
	'offset' / Int32sl,
	'count' / Int32ul,
	'count_duplicate' / Int32ul,
)

mdl__controller = Struct(
	'type' / Enum(Int32ul, bioware_mdl_common__controller_type),
	'unknown' / Int16ul,
	'row_count' / Int16ul,
	'time_index' / Int16ul,
	'data_index' / Int16ul,
	'column_count' / Int8ub,
	'padding' / Array(3, Int8ub),
	'uses_bezier' / Computed(lambda this: this.column_count & 16 != 0),
)

mdl__danglymesh_header = Struct(
	'trimesh_base' / LazyBound(lambda: mdl__trimesh_header),
	'constraints_offset' / Int32ul,
	'constraints_count' / Int32ul,
	'constraints_count_duplicate' / Int32ul,
	'displacement' / Float32l,
	'tightness' / Float32l,
	'period' / Float32l,
	'unknown' / Int32ul,
)

mdl__emitter_header = Struct(
	'dead_space' / Float32l,
	'blast_radius' / Float32l,
	'blast_length' / Float32l,
	'branch_count' / Int32ul,
	'control_point_smoothing' / Float32l,
	'x_grid' / Int32ul,
	'y_grid' / Int32ul,
	'padding_unknown' / Int32ul,
	'update_script' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'render_script' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'blend_script' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'texture_name' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'chunk_name' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'two_sided_texture' / Int32ul,
	'loop' / Int32ul,
	'render_order' / Int16ul,
	'frame_blending' / Int8ub,
	'depth_texture_name' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'padding' / Int8ub,
	'flags' / Int32ul,
)

mdl__file_header = Struct(
	'unused' / Int32ul,
	'mdl_size' / Int32ul,
	'mdx_size' / Int32ul,
)

mdl__geometry_header = Struct(
	'function_pointer_0' / Int32ul,
	'function_pointer_1' / Int32ul,
	'model_name' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'root_node_offset' / Int32ul,
	'node_count' / Int32ul,
	'unknown_array_1' / LazyBound(lambda: mdl__array_definition),
	'unknown_array_2' / LazyBound(lambda: mdl__array_definition),
	'reference_count' / Int32ul,
	'geometry_type' / Int8ub,
	'padding' / Array(3, Int8ub),
	'is_kotor2' / Computed(lambda this:  ((this.function_pointer_0 == 4285200) or (this.function_pointer_0 == 4285872)) ),
)

mdl__light_header = Struct(
	'unknown' / Array(4, Float32l),
	'flare_sizes_offset' / Int32ul,
	'flare_sizes_count' / Int32ul,
	'flare_sizes_count_duplicate' / Int32ul,
	'flare_positions_offset' / Int32ul,
	'flare_positions_count' / Int32ul,
	'flare_positions_count_duplicate' / Int32ul,
	'flare_color_shifts_offset' / Int32ul,
	'flare_color_shifts_count' / Int32ul,
	'flare_color_shifts_count_duplicate' / Int32ul,
	'flare_texture_names_offset' / Int32ul,
	'flare_texture_names_count' / Int32ul,
	'flare_texture_names_count_duplicate' / Int32ul,
	'flare_radius' / Float32l,
	'light_priority' / Int32ul,
	'ambient_only' / Int32ul,
	'dynamic_type' / Int32ul,
	'affect_dynamic' / Int32ul,
	'shadow' / Int32ul,
	'flare' / Int32ul,
	'fading_light' / Int32ul,
)

mdl__lightsaber_header = Struct(
	'trimesh_base' / LazyBound(lambda: mdl__trimesh_header),
	'vertices_offset' / Int32ul,
	'texcoords_offset' / Int32ul,
	'normals_offset' / Int32ul,
	'unknown1' / Int32ul,
	'unknown2' / Int32ul,
)

mdl__mdl_animation_entry = Struct(
	'header' / Pointer(this._root.data_start + this._root.animation_offsets[this.anim_index], LazyBound(lambda: mdl__animation_header)),
)

mdl__model_header = Struct(
	'geometry' / LazyBound(lambda: mdl__geometry_header),
	'model_type' / Enum(Int8ub, bioware_mdl_common__model_classification),
	'unknown0' / Int8ub,
	'padding0' / Int8ub,
	'fog' / Int8ub,
	'unknown1' / Int32ul,
	'offset_to_animations' / Int32ul,
	'animation_count' / Int32ul,
	'animation_count2' / Int32ul,
	'unknown2' / Int32ul,
	'bounding_box_min' / LazyBound(lambda: mdl__vec3f),
	'bounding_box_max' / LazyBound(lambda: mdl__vec3f),
	'radius' / Float32l,
	'animation_scale' / Float32l,
	'supermodel_name' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'offset_to_super_root' / Int32ul,
	'unknown3' / Int32ul,
	'mdx_data_size' / Int32ul,
	'mdx_data_offset' / Int32ul,
	'offset_to_name_offsets' / Int32ul,
	'name_offsets_count' / Int32ul,
	'name_offsets_count2' / Int32ul,
)

mdl__name_strings = Struct(
	'strings' / GreedyRange(NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False, consume=True)),
)

mdl__node = Struct(
	'header' / LazyBound(lambda: mdl__node_header),
	'light_sub_header' / If(this.header.node_type == 3, LazyBound(lambda: mdl__light_header)),
	'emitter_sub_header' / If(this.header.node_type == 5, LazyBound(lambda: mdl__emitter_header)),
	'reference_sub_header' / If(this.header.node_type == 17, LazyBound(lambda: mdl__reference_header)),
	'trimesh_sub_header' / If(this.header.node_type == 33, LazyBound(lambda: mdl__trimesh_header)),
	'skinmesh_sub_header' / If(this.header.node_type == 97, LazyBound(lambda: mdl__skinmesh_header)),
	'animmesh_sub_header' / If(this.header.node_type == 161, LazyBound(lambda: mdl__animmesh_header)),
	'danglymesh_sub_header' / If(this.header.node_type == 289, LazyBound(lambda: mdl__danglymesh_header)),
	'aabb_sub_header' / If(this.header.node_type == 545, LazyBound(lambda: mdl__aabb_header)),
	'lightsaber_sub_header' / If(this.header.node_type == 2081, LazyBound(lambda: mdl__lightsaber_header)),
)

mdl__node_header = Struct(
	'node_type' / Int16ul,
	'node_index' / Int16ul,
	'node_name_index' / Int16ul,
	'padding' / Int16ul,
	'root_node_offset' / Int32ul,
	'parent_node_offset' / Int32ul,
	'position' / LazyBound(lambda: mdl__vec3f),
	'orientation' / LazyBound(lambda: mdl__quaternion),
	'child_array_offset' / Int32ul,
	'child_count' / Int32ul,
	'child_count_duplicate' / Int32ul,
	'controller_array_offset' / Int32ul,
	'controller_count' / Int32ul,
	'controller_count_duplicate' / Int32ul,
	'controller_data_offset' / Int32ul,
	'controller_data_count' / Int32ul,
	'controller_data_count_duplicate' / Int32ul,
	'has_aabb' / Computed(lambda this: this.node_type & 512 != 0),
	'has_anim' / Computed(lambda this: this.node_type & 128 != 0),
	'has_dangly' / Computed(lambda this: this.node_type & 256 != 0),
	'has_emitter' / Computed(lambda this: this.node_type & 4 != 0),
	'has_light' / Computed(lambda this: this.node_type & 2 != 0),
	'has_mesh' / Computed(lambda this: this.node_type & 32 != 0),
	'has_reference' / Computed(lambda this: this.node_type & 16 != 0),
	'has_saber' / Computed(lambda this: this.node_type & 2048 != 0),
	'has_skin' / Computed(lambda this: this.node_type & 64 != 0),
)

mdl__quaternion = Struct(
	'w' / Float32l,
	'x' / Float32l,
	'y' / Float32l,
	'z' / Float32l,
)

mdl__reference_header = Struct(
	'model_resref' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'reattachable' / Int32ul,
)

mdl__skinmesh_header = Struct(
	'trimesh_base' / LazyBound(lambda: mdl__trimesh_header),
	'unknown_weights' / Int32sl,
	'padding1' / Array(8, Int8ub),
	'mdx_bone_weights_offset' / Int32ul,
	'mdx_bone_indices_offset' / Int32ul,
	'bone_map_offset' / Int32ul,
	'bone_map_count' / Int32ul,
	'qbones_offset' / Int32ul,
	'qbones_count' / Int32ul,
	'qbones_count_duplicate' / Int32ul,
	'tbones_offset' / Int32ul,
	'tbones_count' / Int32ul,
	'tbones_count_duplicate' / Int32ul,
	'unknown_array' / Int32ul,
	'bone_node_serial_numbers' / Array(16, Int16ul),
	'padding2' / Int16ul,
)

mdl__trimesh_header = Struct(
	'function_pointer_0' / Int32ul,
	'function_pointer_1' / Int32ul,
	'faces_array_offset' / Int32ul,
	'faces_count' / Int32ul,
	'faces_count_duplicate' / Int32ul,
	'bounding_box_min' / LazyBound(lambda: mdl__vec3f),
	'bounding_box_max' / LazyBound(lambda: mdl__vec3f),
	'radius' / Float32l,
	'average_point' / LazyBound(lambda: mdl__vec3f),
	'diffuse_color' / LazyBound(lambda: mdl__vec3f),
	'ambient_color' / LazyBound(lambda: mdl__vec3f),
	'transparency_hint' / Int32ul,
	'texture_0_name' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'texture_1_name' / FixedSized(32, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'texture_2_name' / FixedSized(12, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'texture_3_name' / FixedSized(12, NullTerminated(GreedyString(encoding='ASCII'), term=b"\x00", include=False)),
	'indices_count_array_offset' / Int32ul,
	'indices_count_array_count' / Int32ul,
	'indices_count_array_count_duplicate' / Int32ul,
	'indices_offset_array_offset' / Int32ul,
	'indices_offset_array_count' / Int32ul,
	'indices_offset_array_count_duplicate' / Int32ul,
	'inverted_counter_array_offset' / Int32ul,
	'inverted_counter_array_count' / Int32ul,
	'inverted_counter_array_count_duplicate' / Int32ul,
	'unknown_values' / Array(3, Int32sl),
	'saber_unknown_data' / Array(8, Int8ub),
	'unknown' / Int32ul,
	'uv_direction' / LazyBound(lambda: mdl__vec3f),
	'uv_jitter' / Float32l,
	'uv_jitter_speed' / Float32l,
	'mdx_vertex_size' / Int32ul,
	'mdx_data_flags' / Int32ul,
	'mdx_vertices_offset' / Int32sl,
	'mdx_normals_offset' / Int32sl,
	'mdx_vertex_colors_offset' / Int32sl,
	'mdx_tex0_uvs_offset' / Int32sl,
	'mdx_tex1_uvs_offset' / Int32sl,
	'mdx_tex2_uvs_offset' / Int32sl,
	'mdx_tex3_uvs_offset' / Int32sl,
	'mdx_tangent_space_offset' / Int32sl,
	'mdx_unknown_offset_1' / Int32sl,
	'mdx_unknown_offset_2' / Int32sl,
	'mdx_unknown_offset_3' / Int32sl,
	'vertex_count' / Int16ul,
	'texture_count' / Int16ul,
	'lightmapped' / Int8ub,
	'rotate_texture' / Int8ub,
	'background_geometry' / Int8ub,
	'shadow' / Int8ub,
	'beaming' / Int8ub,
	'render' / Int8ub,
	'unknown_flag' / Int8ub,
	'padding' / Int8ub,
	'total_area' / Float32l,
	'unknown2' / Int32ul,
	'k2_unknown_1' / If(this._root.model_header.geometry.is_kotor2, Int32ul),
	'k2_unknown_2' / If(this._root.model_header.geometry.is_kotor2, Int32ul),
	'mdx_data_offset' / Int32ul,
	'mdl_vertices_offset' / Int32ul,
)

mdl__vec3f = Struct(
	'x' / Float32l,
	'y' / Float32l,
	'z' / Float32l,
)

mdl = Struct(
	'file_header' / LazyBound(lambda: mdl__file_header),
	'model_header' / LazyBound(lambda: mdl__model_header),
	'animation_offsets' / Pointer(this.data_start + this.model_header.offset_to_animations, If(this.model_header.animation_count > 0, Array(this.model_header.animation_count, Int32ul))),
	'animations' / If(this.model_header.animation_count > 0, Array(this.model_header.animation_count, LazyBound(lambda: mdl__mdl_animation_entry))),
	'data_start' / Computed(lambda this: 12),
	'name_offsets' / Pointer(this.data_start + this.model_header.offset_to_name_offsets, If(this.model_header.name_offsets_count > 0, Array(this.model_header.name_offsets_count, Int32ul))),
	'names_data' / Pointer((this.data_start + this.model_header.offset_to_name_offsets) + 4 * this.model_header.name_offsets_count, If(this.model_header.name_offsets_count > 0, FixedSized((this.data_start + this.model_header.offset_to_animations) - ((this.data_start + this.model_header.offset_to_name_offsets) + 4 * this.model_header.name_offsets_count), LazyBound(lambda: mdl__name_strings)))),
	'root_node' / Pointer(this.data_start + this.model_header.geometry.root_node_offset, If(this.model_header.geometry.root_node_offset > 0, LazyBound(lambda: mdl__node))),
)

_schema = mdl
