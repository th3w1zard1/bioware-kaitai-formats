from construct import *
from construct.lib import *

mdl_ascii__animation_section = Struct(
	'newanim' / LazyBound(lambda: mdl_ascii__line_text),
	'doneanim' / LazyBound(lambda: mdl_ascii__line_text),
	'length' / LazyBound(lambda: mdl_ascii__line_text),
	'transtime' / LazyBound(lambda: mdl_ascii__line_text),
	'animroot' / LazyBound(lambda: mdl_ascii__line_text),
	'event' / LazyBound(lambda: mdl_ascii__line_text),
	'eventlist' / LazyBound(lambda: mdl_ascii__line_text),
	'endlist' / LazyBound(lambda: mdl_ascii__line_text),
)

mdl_ascii__ascii_line = Struct(
	'content' / NullTerminated(GreedyString(encoding='UTF-8'), term=b"\x0A", include=False, consume=True),
)

mdl_ascii__controller_bezier = Struct(
	'controller_name' / LazyBound(lambda: mdl_ascii__line_text),
	'keyframes' / GreedyRange(LazyBound(lambda: mdl_ascii__controller_bezier_keyframe)),
)

mdl_ascii__controller_bezier_keyframe = Struct(
	'time' / GreedyString(encoding='UTF-8'),
	'value_data' / GreedyString(encoding='UTF-8'),
)

mdl_ascii__controller_keyed = Struct(
	'controller_name' / LazyBound(lambda: mdl_ascii__line_text),
	'keyframes' / GreedyRange(LazyBound(lambda: mdl_ascii__controller_keyframe)),
)

mdl_ascii__controller_keyframe = Struct(
	'time' / GreedyString(encoding='UTF-8'),
	'values' / GreedyString(encoding='UTF-8'),
)

mdl_ascii__controller_single = Struct(
	'controller_name' / LazyBound(lambda: mdl_ascii__line_text),
	'values' / LazyBound(lambda: mdl_ascii__line_text),
)

mdl_ascii__danglymesh_properties = Struct(
	'displacement' / LazyBound(lambda: mdl_ascii__line_text),
	'tightness' / LazyBound(lambda: mdl_ascii__line_text),
	'period' / LazyBound(lambda: mdl_ascii__line_text),
)

mdl_ascii__data_arrays = Struct(
	'verts' / LazyBound(lambda: mdl_ascii__line_text),
	'faces' / LazyBound(lambda: mdl_ascii__line_text),
	'tverts' / LazyBound(lambda: mdl_ascii__line_text),
	'tverts1' / LazyBound(lambda: mdl_ascii__line_text),
	'lightmaptverts' / LazyBound(lambda: mdl_ascii__line_text),
	'tverts2' / LazyBound(lambda: mdl_ascii__line_text),
	'tverts3' / LazyBound(lambda: mdl_ascii__line_text),
	'texindices1' / LazyBound(lambda: mdl_ascii__line_text),
	'texindices2' / LazyBound(lambda: mdl_ascii__line_text),
	'texindices3' / LazyBound(lambda: mdl_ascii__line_text),
	'colors' / LazyBound(lambda: mdl_ascii__line_text),
	'colorindices' / LazyBound(lambda: mdl_ascii__line_text),
	'weights' / LazyBound(lambda: mdl_ascii__line_text),
	'constraints' / LazyBound(lambda: mdl_ascii__line_text),
	'aabb' / LazyBound(lambda: mdl_ascii__line_text),
	'saber_verts' / LazyBound(lambda: mdl_ascii__line_text),
	'saber_norms' / LazyBound(lambda: mdl_ascii__line_text),
	'name' / LazyBound(lambda: mdl_ascii__line_text),
)

mdl_ascii__emitter_flags = Struct(
	'p2p' / LazyBound(lambda: mdl_ascii__line_text),
	'p2p_sel' / LazyBound(lambda: mdl_ascii__line_text),
	'affected_by_wind' / LazyBound(lambda: mdl_ascii__line_text),
	'm_is_tinted' / LazyBound(lambda: mdl_ascii__line_text),
	'bounce' / LazyBound(lambda: mdl_ascii__line_text),
	'random' / LazyBound(lambda: mdl_ascii__line_text),
	'inherit' / LazyBound(lambda: mdl_ascii__line_text),
	'inheritvel' / LazyBound(lambda: mdl_ascii__line_text),
	'inherit_local' / LazyBound(lambda: mdl_ascii__line_text),
	'splat' / LazyBound(lambda: mdl_ascii__line_text),
	'inherit_part' / LazyBound(lambda: mdl_ascii__line_text),
	'depth_texture' / LazyBound(lambda: mdl_ascii__line_text),
	'emitterflag13' / LazyBound(lambda: mdl_ascii__line_text),
)

mdl_ascii__emitter_properties = Struct(
	'deadspace' / LazyBound(lambda: mdl_ascii__line_text),
	'blast_radius' / LazyBound(lambda: mdl_ascii__line_text),
	'blast_length' / LazyBound(lambda: mdl_ascii__line_text),
	'num_branches' / LazyBound(lambda: mdl_ascii__line_text),
	'controlptsmoothing' / LazyBound(lambda: mdl_ascii__line_text),
	'xgrid' / LazyBound(lambda: mdl_ascii__line_text),
	'ygrid' / LazyBound(lambda: mdl_ascii__line_text),
	'spawntype' / LazyBound(lambda: mdl_ascii__line_text),
	'update' / LazyBound(lambda: mdl_ascii__line_text),
	'render' / LazyBound(lambda: mdl_ascii__line_text),
	'blend' / LazyBound(lambda: mdl_ascii__line_text),
	'texture' / LazyBound(lambda: mdl_ascii__line_text),
	'chunkname' / LazyBound(lambda: mdl_ascii__line_text),
	'twosidedtex' / LazyBound(lambda: mdl_ascii__line_text),
	'loop' / LazyBound(lambda: mdl_ascii__line_text),
	'renderorder' / LazyBound(lambda: mdl_ascii__line_text),
	'm_b_frame_blending' / LazyBound(lambda: mdl_ascii__line_text),
	'm_s_depth_texture_name' / LazyBound(lambda: mdl_ascii__line_text),
)

mdl_ascii__light_properties = Struct(
	'flareradius' / LazyBound(lambda: mdl_ascii__line_text),
	'flarepositions' / LazyBound(lambda: mdl_ascii__line_text),
	'flaresizes' / LazyBound(lambda: mdl_ascii__line_text),
	'flarecolorshifts' / LazyBound(lambda: mdl_ascii__line_text),
	'texturenames' / LazyBound(lambda: mdl_ascii__line_text),
	'ambientonly' / LazyBound(lambda: mdl_ascii__line_text),
	'ndynamictype' / LazyBound(lambda: mdl_ascii__line_text),
	'affectdynamic' / LazyBound(lambda: mdl_ascii__line_text),
	'flare' / LazyBound(lambda: mdl_ascii__line_text),
	'lightpriority' / LazyBound(lambda: mdl_ascii__line_text),
	'fadinglight' / LazyBound(lambda: mdl_ascii__line_text),
)

mdl_ascii__line_text = Struct(
	'value' / NullTerminated(GreedyString(encoding='UTF-8'), term=b"\x0A", include=False, consume=True),
)

mdl_ascii__reference_properties = Struct(
	'refmodel' / LazyBound(lambda: mdl_ascii__line_text),
	'reattachable' / LazyBound(lambda: mdl_ascii__line_text),
)

mdl_ascii = Struct(
	'lines' / GreedyRange(LazyBound(lambda: mdl_ascii__ascii_line)),
)

_schema = mdl_ascii
