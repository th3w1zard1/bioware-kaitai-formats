meta:
  id: bioware_mdl_common
  title: BioWare MDL / MDX shared enumerations
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1:
      note: "Shared MDL/MDX wire enums — mesh Ghidra notes on `formats/MDL/MDL.ksy` / `MDX.ksy`; `user-agdec-http` per AGENTS.md."
    pykotor_wiki_mdl: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format
    pykotor_mdl_formats_tree: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/
    pykotor_vendor_mdopsm: https://github.com/th3w1zard1/mdlops/blob/master/MDLOpsM.pm#L342-L407
    xoreos_model_kotor: https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267
    xoreos_types_kfiletype_mdl: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L73
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html
    xoreos_docs_binmdl: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html
doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX"
  - "https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/ PyKotor — MDL package"
  - "https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267 xoreos — `Model_KotOR::load`"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L73 xoreos — `kFileTypeMDL`"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (controller IDs)"
  - "https://github.com/th3w1zard1/mdlops/blob/master/MDLOpsM.pm#L342-L407 Community MDLOps — `MDLOpsM.pm` controller name table (legacy PyKotor `vendor/MDLOps` path 404 on current default branch)"
doc: |
  Wire enums shared by `formats/MDL/MDL.ksy` (imported there as `bioware_mdl_common`; field-bound on `model_type` and
  `controller.type`; `node_header.node_type` is a bitmask so MDL.ksy keeps it as raw `u2` and references this enum for docs).
  Tooling alignment: PyKotor / MDLOps / xoreos.

  - `model_classification` — `model_header.model_type` (`u1`).
  - `node_type_value` — primary node discriminator in `node_header.node_type` (`u2`); bitmask flags on the same field are documented in MDL.ksy.
  - `controller_type` — **partial** list of `controller.type` (`u4`) values (common KotOR / Aurora); many emitter-specific IDs exist — see PyKotor wiki + torlack `binmdl` for the full set. `formats/MDL/MDL.ksy` attaches this enum to `controller.type`; unknown numeric IDs may still appear in data and should be treated as vendor-defined extensions.

enums:
  model_classification:
    0x00: other
    0x01: effect
    0x02: tile
    0x04: character
    0x08: door
    0x10: lightsaber
    0x20: placeable
    0x40: flyer

  node_type_value:
    0x001: dummy
    0x003: light
    0x005: emitter
    0x011: reference
    0x021: trimesh
    0x061: skinmesh
    0x0a1: animmesh
    0x121: danglymesh
    0x221: aabb
    0x821: lightsaber

  controller_type:
    8: position
    20: orientation
    36: scale
    76: color
    88: radius
    96: shadow_radius
    100: vertical_displacement_or_drag_or_selfillumcolor
    132: alpha
    140: multiplier_or_randvel
    # Emitter / particle controllers (same numeric space as lights; disambiguation is node-type–specific) — MDL.ksy `controller` doc / torlack `binmdl`.
    80: emitter_alpha_end
    84: emitter_alpha_start
    92: emitter_bounce_coefficient
    104: emitter_fps
    108: emitter_frame_end
    112: emitter_frame_start
    116: emitter_gravity
    120: emitter_life_expectancy
    124: emitter_mass
    136: emitter_particle_rotation
    144: emitter_size_start
    148: emitter_size_end
    152: emitter_size_start_y
    156: emitter_size_end_y
    160: emitter_spread
    164: emitter_threshold
    168: emitter_velocity
    172: emitter_x_size
    176: emitter_y_size
    180: emitter_blur_length
    184: emitter_lightning_delay
    188: emitter_lightning_radius
    192: emitter_lightning_scale
    196: emitter_lightning_subdivide
    200: emitter_lightning_zig_zag
    216: emitter_alpha_mid
    220: emitter_percent_start
    224: emitter_percent_mid
    228: emitter_percent_end
    232: emitter_size_mid
    236: emitter_size_mid_y
    240: emitter_random_birth_rate
    252: emitter_target_size
    256: emitter_num_control_points
    260: emitter_control_point_radius
    264: emitter_control_point_delay
    268: emitter_tangent_spread
    272: emitter_tangent_length
    284: emitter_color_mid
    380: emitter_color_end
    392: emitter_color_start
    502: emitter_detonate
