import kaitai_struct_nim_runtime
import options

type
  BiowareMdlCommon* = ref object of KaitaiStruct
    `parent`*: KaitaiStruct
  BiowareMdlCommon_ControllerType* = enum
    position = 8
    orientation = 20
    scale = 36
    color = 76
    emitter_alpha_end = 80
    emitter_alpha_start = 84
    radius = 88
    emitter_bounce_coefficient = 92
    shadow_radius = 96
    vertical_displacement_or_drag_or_selfillumcolor = 100
    emitter_fps = 104
    emitter_frame_end = 108
    emitter_frame_start = 112
    emitter_gravity = 116
    emitter_life_expectancy = 120
    emitter_mass = 124
    alpha = 132
    emitter_particle_rotation = 136
    multiplier_or_randvel = 140
    emitter_size_start = 144
    emitter_size_end = 148
    emitter_size_start_y = 152
    emitter_size_end_y = 156
    emitter_spread = 160
    emitter_threshold = 164
    emitter_velocity = 168
    emitter_x_size = 172
    emitter_y_size = 176
    emitter_blur_length = 180
    emitter_lightning_delay = 184
    emitter_lightning_radius = 188
    emitter_lightning_scale = 192
    emitter_lightning_subdivide = 196
    emitter_lightning_zig_zag = 200
    emitter_alpha_mid = 216
    emitter_percent_start = 220
    emitter_percent_mid = 224
    emitter_percent_end = 228
    emitter_size_mid = 232
    emitter_size_mid_y = 236
    emitter_random_birth_rate = 240
    emitter_target_size = 252
    emitter_num_control_points = 256
    emitter_control_point_radius = 260
    emitter_control_point_delay = 264
    emitter_tangent_spread = 268
    emitter_tangent_length = 272
    emitter_color_mid = 284
    emitter_color_end = 380
    emitter_color_start = 392
    emitter_detonate = 502
  BiowareMdlCommon_ModelClassification* = enum
    other = 0
    effect = 1
    tile = 2
    character = 4
    door = 8
    lightsaber = 16
    placeable = 32
    flyer = 64
  BiowareMdlCommon_NodeTypeValue* = enum
    dummy = 1
    light = 3
    emitter = 5
    reference = 17
    trimesh = 33
    skinmesh = 97
    animmesh = 161
    danglymesh = 289
    aabb = 545
    lightsaber = 2081

proc read*(_: typedesc[BiowareMdlCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareMdlCommon



##[
Wire enums shared by `formats/MDL/MDL.ksy` (and tooling aligned with PyKotor / MDLOps / xoreos).

- `model_classification` — `model_header.model_type` (`u1`).
- `node_type_value` — primary node discriminator in `node_header.node_type` (`u2`); bitmask flags on the same field are documented in MDL.ksy.
- `controller_type` — **partial** list of `controller.type` (`u4`) values (common KotOR / Aurora); many emitter-specific IDs exist — see PyKotor wiki + torlack `binmdl` for the full set. `formats/MDL/MDL.ksy` attaches this enum to `controller.type`; unknown numeric IDs may still appear in data and should be treated as vendor-defined extensions.

]##
proc read*(_: typedesc[BiowareMdlCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): BiowareMdlCommon =
  template this: untyped = result
  this = new(BiowareMdlCommon)
  let root = if root == nil: cast[BiowareMdlCommon](this) else: cast[BiowareMdlCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


proc fromFile*(_: typedesc[BiowareMdlCommon], filename: string): BiowareMdlCommon =
  BiowareMdlCommon.read(newKaitaiFileStream(filename), nil, nil)

