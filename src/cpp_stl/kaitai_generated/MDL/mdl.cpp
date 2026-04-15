// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "mdl.h"

mdl_t::mdl_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_file_header = 0;
    m_model_header = 0;
    m_animation_offsets = 0;
    m_animations = 0;
    m_name_offsets = 0;
    m_names_data = 0;
    m__io__raw_names_data = 0;
    m_root_node = 0;
    f_animation_offsets = false;
    f_animations = false;
    f_data_start = false;
    f_name_offsets = false;
    f_names_data = false;
    f_root_node = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::_read() {
    m_file_header = new file_header_t(m__io, this, m__root);
    m_model_header = new model_header_t(m__io, this, m__root);
}

mdl_t::~mdl_t() {
    _clean_up();
}

void mdl_t::_clean_up() {
    if (m_file_header) {
        delete m_file_header; m_file_header = 0;
    }
    if (m_model_header) {
        delete m_model_header; m_model_header = 0;
    }
    if (f_animation_offsets && !n_animation_offsets) {
        if (m_animation_offsets) {
            delete m_animation_offsets; m_animation_offsets = 0;
        }
    }
    if (f_animations && !n_animations) {
        if (m_animations) {
            for (std::vector<mdl_animation_entry_t*>::iterator it = m_animations->begin(); it != m_animations->end(); ++it) {
                delete *it;
            }
            delete m_animations; m_animations = 0;
        }
    }
    if (f_name_offsets && !n_name_offsets) {
        if (m_name_offsets) {
            delete m_name_offsets; m_name_offsets = 0;
        }
    }
    if (f_names_data && !n_names_data) {
        if (m__io__raw_names_data) {
            delete m__io__raw_names_data; m__io__raw_names_data = 0;
        }
        if (m_names_data) {
            delete m_names_data; m_names_data = 0;
        }
    }
    if (f_root_node && !n_root_node) {
        if (m_root_node) {
            delete m_root_node; m_root_node = 0;
        }
    }
}

mdl_t::aabb_header_t::aabb_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_trimesh_base = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::aabb_header_t::_read() {
    m_trimesh_base = new trimesh_header_t(m__io, this, m__root);
    m_unknown = m__io->read_u4le();
}

mdl_t::aabb_header_t::~aabb_header_t() {
    _clean_up();
}

void mdl_t::aabb_header_t::_clean_up() {
    if (m_trimesh_base) {
        delete m_trimesh_base; m_trimesh_base = 0;
    }
}

mdl_t::animation_event_t::animation_event_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::animation_event_t::_read() {
    m_activation_time = m__io->read_f4le();
    m_event_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
}

mdl_t::animation_event_t::~animation_event_t() {
    _clean_up();
}

void mdl_t::animation_event_t::_clean_up() {
}

mdl_t::animation_header_t::animation_header_t(kaitai::kstream* p__io, mdl_t::mdl_animation_entry_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_geo_header = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::animation_header_t::_read() {
    m_geo_header = new geometry_header_t(m__io, this, m__root);
    m_animation_length = m__io->read_f4le();
    m_transition_time = m__io->read_f4le();
    m_animation_root = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_event_array_offset = m__io->read_u4le();
    m_event_count = m__io->read_u4le();
    m_event_count_duplicate = m__io->read_u4le();
    m_unknown = m__io->read_u4le();
}

mdl_t::animation_header_t::~animation_header_t() {
    _clean_up();
}

void mdl_t::animation_header_t::_clean_up() {
    if (m_geo_header) {
        delete m_geo_header; m_geo_header = 0;
    }
}

mdl_t::animmesh_header_t::animmesh_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_trimesh_base = 0;
    m_unknown_array = 0;
    m_unknown_floats = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::animmesh_header_t::_read() {
    m_trimesh_base = new trimesh_header_t(m__io, this, m__root);
    m_unknown = m__io->read_f4le();
    m_unknown_array = new array_definition_t(m__io, this, m__root);
    m_unknown_floats = new std::vector<float>();
    const int l_unknown_floats = 9;
    for (int i = 0; i < l_unknown_floats; i++) {
        m_unknown_floats->push_back(m__io->read_f4le());
    }
}

mdl_t::animmesh_header_t::~animmesh_header_t() {
    _clean_up();
}

void mdl_t::animmesh_header_t::_clean_up() {
    if (m_trimesh_base) {
        delete m_trimesh_base; m_trimesh_base = 0;
    }
    if (m_unknown_array) {
        delete m_unknown_array; m_unknown_array = 0;
    }
    if (m_unknown_floats) {
        delete m_unknown_floats; m_unknown_floats = 0;
    }
}

mdl_t::array_definition_t::array_definition_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::array_definition_t::_read() {
    m_offset = m__io->read_s4le();
    m_count = m__io->read_u4le();
    m_count_duplicate = m__io->read_u4le();
}

mdl_t::array_definition_t::~array_definition_t() {
    _clean_up();
}

void mdl_t::array_definition_t::_clean_up() {
}

mdl_t::controller_t::controller_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_padding = 0;
    f_uses_bezier = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::controller_t::_read() {
    m_type = static_cast<bioware_mdl_common_t::controller_type_t>(m__io->read_u4le());
    m_unknown = m__io->read_u2le();
    m_row_count = m__io->read_u2le();
    m_time_index = m__io->read_u2le();
    m_data_index = m__io->read_u2le();
    m_column_count = m__io->read_u1();
    m_padding = new std::vector<uint8_t>();
    const int l_padding = 3;
    for (int i = 0; i < l_padding; i++) {
        m_padding->push_back(m__io->read_u1());
    }
}

mdl_t::controller_t::~controller_t() {
    _clean_up();
}

void mdl_t::controller_t::_clean_up() {
    if (m_padding) {
        delete m_padding; m_padding = 0;
    }
}

bool mdl_t::controller_t::uses_bezier() {
    if (f_uses_bezier)
        return m_uses_bezier;
    f_uses_bezier = true;
    m_uses_bezier = (column_count() & 16) != 0;
    return m_uses_bezier;
}

mdl_t::danglymesh_header_t::danglymesh_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_trimesh_base = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::danglymesh_header_t::_read() {
    m_trimesh_base = new trimesh_header_t(m__io, this, m__root);
    m_constraints_offset = m__io->read_u4le();
    m_constraints_count = m__io->read_u4le();
    m_constraints_count_duplicate = m__io->read_u4le();
    m_displacement = m__io->read_f4le();
    m_tightness = m__io->read_f4le();
    m_period = m__io->read_f4le();
    m_unknown = m__io->read_u4le();
}

mdl_t::danglymesh_header_t::~danglymesh_header_t() {
    _clean_up();
}

void mdl_t::danglymesh_header_t::_clean_up() {
    if (m_trimesh_base) {
        delete m_trimesh_base; m_trimesh_base = 0;
    }
}

mdl_t::emitter_header_t::emitter_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::emitter_header_t::_read() {
    m_dead_space = m__io->read_f4le();
    m_blast_radius = m__io->read_f4le();
    m_blast_length = m__io->read_f4le();
    m_branch_count = m__io->read_u4le();
    m_control_point_smoothing = m__io->read_f4le();
    m_x_grid = m__io->read_u4le();
    m_y_grid = m__io->read_u4le();
    m_padding_unknown = m__io->read_u4le();
    m_update_script = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_render_script = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_blend_script = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_texture_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_chunk_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_two_sided_texture = m__io->read_u4le();
    m_loop = m__io->read_u4le();
    m_render_order = m__io->read_u2le();
    m_frame_blending = m__io->read_u1();
    m_depth_texture_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_padding = m__io->read_u1();
    m_flags = m__io->read_u4le();
}

mdl_t::emitter_header_t::~emitter_header_t() {
    _clean_up();
}

void mdl_t::emitter_header_t::_clean_up() {
}

mdl_t::file_header_t::file_header_t(kaitai::kstream* p__io, mdl_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::file_header_t::_read() {
    m_unused = m__io->read_u4le();
    m_mdl_size = m__io->read_u4le();
    m_mdx_size = m__io->read_u4le();
}

mdl_t::file_header_t::~file_header_t() {
    _clean_up();
}

void mdl_t::file_header_t::_clean_up() {
}

mdl_t::geometry_header_t::geometry_header_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_unknown_array_1 = 0;
    m_unknown_array_2 = 0;
    m_padding = 0;
    f_is_kotor2 = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::geometry_header_t::_read() {
    m_function_pointer_0 = m__io->read_u4le();
    m_function_pointer_1 = m__io->read_u4le();
    m_model_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_root_node_offset = m__io->read_u4le();
    m_node_count = m__io->read_u4le();
    m_unknown_array_1 = new array_definition_t(m__io, this, m__root);
    m_unknown_array_2 = new array_definition_t(m__io, this, m__root);
    m_reference_count = m__io->read_u4le();
    m_geometry_type = m__io->read_u1();
    m_padding = new std::vector<uint8_t>();
    const int l_padding = 3;
    for (int i = 0; i < l_padding; i++) {
        m_padding->push_back(m__io->read_u1());
    }
}

mdl_t::geometry_header_t::~geometry_header_t() {
    _clean_up();
}

void mdl_t::geometry_header_t::_clean_up() {
    if (m_unknown_array_1) {
        delete m_unknown_array_1; m_unknown_array_1 = 0;
    }
    if (m_unknown_array_2) {
        delete m_unknown_array_2; m_unknown_array_2 = 0;
    }
    if (m_padding) {
        delete m_padding; m_padding = 0;
    }
}

bool mdl_t::geometry_header_t::is_kotor2() {
    if (f_is_kotor2)
        return m_is_kotor2;
    f_is_kotor2 = true;
    m_is_kotor2 =  ((function_pointer_0() == 4285200) || (function_pointer_0() == 4285872)) ;
    return m_is_kotor2;
}

mdl_t::light_header_t::light_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_unknown = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::light_header_t::_read() {
    m_unknown = new std::vector<float>();
    const int l_unknown = 4;
    for (int i = 0; i < l_unknown; i++) {
        m_unknown->push_back(m__io->read_f4le());
    }
    m_flare_sizes_offset = m__io->read_u4le();
    m_flare_sizes_count = m__io->read_u4le();
    m_flare_sizes_count_duplicate = m__io->read_u4le();
    m_flare_positions_offset = m__io->read_u4le();
    m_flare_positions_count = m__io->read_u4le();
    m_flare_positions_count_duplicate = m__io->read_u4le();
    m_flare_color_shifts_offset = m__io->read_u4le();
    m_flare_color_shifts_count = m__io->read_u4le();
    m_flare_color_shifts_count_duplicate = m__io->read_u4le();
    m_flare_texture_names_offset = m__io->read_u4le();
    m_flare_texture_names_count = m__io->read_u4le();
    m_flare_texture_names_count_duplicate = m__io->read_u4le();
    m_flare_radius = m__io->read_f4le();
    m_light_priority = m__io->read_u4le();
    m_ambient_only = m__io->read_u4le();
    m_dynamic_type = m__io->read_u4le();
    m_affect_dynamic = m__io->read_u4le();
    m_shadow = m__io->read_u4le();
    m_flare = m__io->read_u4le();
    m_fading_light = m__io->read_u4le();
}

mdl_t::light_header_t::~light_header_t() {
    _clean_up();
}

void mdl_t::light_header_t::_clean_up() {
    if (m_unknown) {
        delete m_unknown; m_unknown = 0;
    }
}

mdl_t::lightsaber_header_t::lightsaber_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_trimesh_base = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::lightsaber_header_t::_read() {
    m_trimesh_base = new trimesh_header_t(m__io, this, m__root);
    m_vertices_offset = m__io->read_u4le();
    m_texcoords_offset = m__io->read_u4le();
    m_normals_offset = m__io->read_u4le();
    m_unknown1 = m__io->read_u4le();
    m_unknown2 = m__io->read_u4le();
}

mdl_t::lightsaber_header_t::~lightsaber_header_t() {
    _clean_up();
}

void mdl_t::lightsaber_header_t::_clean_up() {
    if (m_trimesh_base) {
        delete m_trimesh_base; m_trimesh_base = 0;
    }
}

mdl_t::mdl_animation_entry_t::mdl_animation_entry_t(uint32_t p_anim_index, kaitai::kstream* p__io, mdl_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_anim_index = p_anim_index;
    m_header = 0;
    f_header = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::mdl_animation_entry_t::_read() {
}

mdl_t::mdl_animation_entry_t::~mdl_animation_entry_t() {
    _clean_up();
}

void mdl_t::mdl_animation_entry_t::_clean_up() {
    if (f_header) {
        if (m_header) {
            delete m_header; m_header = 0;
        }
    }
}

mdl_t::animation_header_t* mdl_t::mdl_animation_entry_t::header() {
    if (f_header)
        return m_header;
    f_header = true;
    std::streampos _pos = m__io->pos();
    m__io->seek(_root()->data_start() + _root()->animation_offsets()->at(anim_index()));
    m_header = new animation_header_t(m__io, this, m__root);
    m__io->seek(_pos);
    return m_header;
}

mdl_t::model_header_t::model_header_t(kaitai::kstream* p__io, mdl_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_geometry = 0;
    m_bounding_box_min = 0;
    m_bounding_box_max = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::model_header_t::_read() {
    m_geometry = new geometry_header_t(m__io, this, m__root);
    m_model_type = static_cast<bioware_mdl_common_t::model_classification_t>(m__io->read_u1());
    m_unknown0 = m__io->read_u1();
    m_padding0 = m__io->read_u1();
    m_fog = m__io->read_u1();
    m_unknown1 = m__io->read_u4le();
    m_offset_to_animations = m__io->read_u4le();
    m_animation_count = m__io->read_u4le();
    m_animation_count2 = m__io->read_u4le();
    m_unknown2 = m__io->read_u4le();
    m_bounding_box_min = new vec3f_t(m__io, this, m__root);
    m_bounding_box_max = new vec3f_t(m__io, this, m__root);
    m_radius = m__io->read_f4le();
    m_animation_scale = m__io->read_f4le();
    m_supermodel_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_offset_to_super_root = m__io->read_u4le();
    m_unknown3 = m__io->read_u4le();
    m_mdx_data_size = m__io->read_u4le();
    m_mdx_data_offset = m__io->read_u4le();
    m_offset_to_name_offsets = m__io->read_u4le();
    m_name_offsets_count = m__io->read_u4le();
    m_name_offsets_count2 = m__io->read_u4le();
}

mdl_t::model_header_t::~model_header_t() {
    _clean_up();
}

void mdl_t::model_header_t::_clean_up() {
    if (m_geometry) {
        delete m_geometry; m_geometry = 0;
    }
    if (m_bounding_box_min) {
        delete m_bounding_box_min; m_bounding_box_min = 0;
    }
    if (m_bounding_box_max) {
        delete m_bounding_box_max; m_bounding_box_max = 0;
    }
}

mdl_t::name_strings_t::name_strings_t(kaitai::kstream* p__io, mdl_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_strings = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::name_strings_t::_read() {
    m_strings = new std::vector<std::string>();
    {
        int i = 0;
        while (!m__io->is_eof()) {
            m_strings->push_back(kaitai::kstream::bytes_to_str(m__io->read_bytes_term(0, false, true, true), "ASCII"));
            i++;
        }
    }
}

mdl_t::name_strings_t::~name_strings_t() {
    _clean_up();
}

void mdl_t::name_strings_t::_clean_up() {
    if (m_strings) {
        delete m_strings; m_strings = 0;
    }
}

mdl_t::node_t::node_t(kaitai::kstream* p__io, mdl_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_header = 0;
    m_light_sub_header = 0;
    m_emitter_sub_header = 0;
    m_reference_sub_header = 0;
    m_trimesh_sub_header = 0;
    m_skinmesh_sub_header = 0;
    m_animmesh_sub_header = 0;
    m_danglymesh_sub_header = 0;
    m_aabb_sub_header = 0;
    m_lightsaber_sub_header = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::node_t::_read() {
    m_header = new node_header_t(m__io, this, m__root);
    n_light_sub_header = true;
    if (header()->node_type() == 3) {
        n_light_sub_header = false;
        m_light_sub_header = new light_header_t(m__io, this, m__root);
    }
    n_emitter_sub_header = true;
    if (header()->node_type() == 5) {
        n_emitter_sub_header = false;
        m_emitter_sub_header = new emitter_header_t(m__io, this, m__root);
    }
    n_reference_sub_header = true;
    if (header()->node_type() == 17) {
        n_reference_sub_header = false;
        m_reference_sub_header = new reference_header_t(m__io, this, m__root);
    }
    n_trimesh_sub_header = true;
    if (header()->node_type() == 33) {
        n_trimesh_sub_header = false;
        m_trimesh_sub_header = new trimesh_header_t(m__io, this, m__root);
    }
    n_skinmesh_sub_header = true;
    if (header()->node_type() == 97) {
        n_skinmesh_sub_header = false;
        m_skinmesh_sub_header = new skinmesh_header_t(m__io, this, m__root);
    }
    n_animmesh_sub_header = true;
    if (header()->node_type() == 161) {
        n_animmesh_sub_header = false;
        m_animmesh_sub_header = new animmesh_header_t(m__io, this, m__root);
    }
    n_danglymesh_sub_header = true;
    if (header()->node_type() == 289) {
        n_danglymesh_sub_header = false;
        m_danglymesh_sub_header = new danglymesh_header_t(m__io, this, m__root);
    }
    n_aabb_sub_header = true;
    if (header()->node_type() == 545) {
        n_aabb_sub_header = false;
        m_aabb_sub_header = new aabb_header_t(m__io, this, m__root);
    }
    n_lightsaber_sub_header = true;
    if (header()->node_type() == 2081) {
        n_lightsaber_sub_header = false;
        m_lightsaber_sub_header = new lightsaber_header_t(m__io, this, m__root);
    }
}

mdl_t::node_t::~node_t() {
    _clean_up();
}

void mdl_t::node_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
    if (!n_light_sub_header) {
        if (m_light_sub_header) {
            delete m_light_sub_header; m_light_sub_header = 0;
        }
    }
    if (!n_emitter_sub_header) {
        if (m_emitter_sub_header) {
            delete m_emitter_sub_header; m_emitter_sub_header = 0;
        }
    }
    if (!n_reference_sub_header) {
        if (m_reference_sub_header) {
            delete m_reference_sub_header; m_reference_sub_header = 0;
        }
    }
    if (!n_trimesh_sub_header) {
        if (m_trimesh_sub_header) {
            delete m_trimesh_sub_header; m_trimesh_sub_header = 0;
        }
    }
    if (!n_skinmesh_sub_header) {
        if (m_skinmesh_sub_header) {
            delete m_skinmesh_sub_header; m_skinmesh_sub_header = 0;
        }
    }
    if (!n_animmesh_sub_header) {
        if (m_animmesh_sub_header) {
            delete m_animmesh_sub_header; m_animmesh_sub_header = 0;
        }
    }
    if (!n_danglymesh_sub_header) {
        if (m_danglymesh_sub_header) {
            delete m_danglymesh_sub_header; m_danglymesh_sub_header = 0;
        }
    }
    if (!n_aabb_sub_header) {
        if (m_aabb_sub_header) {
            delete m_aabb_sub_header; m_aabb_sub_header = 0;
        }
    }
    if (!n_lightsaber_sub_header) {
        if (m_lightsaber_sub_header) {
            delete m_lightsaber_sub_header; m_lightsaber_sub_header = 0;
        }
    }
}

mdl_t::node_header_t::node_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_position = 0;
    m_orientation = 0;
    f_has_aabb = false;
    f_has_anim = false;
    f_has_dangly = false;
    f_has_emitter = false;
    f_has_light = false;
    f_has_mesh = false;
    f_has_reference = false;
    f_has_saber = false;
    f_has_skin = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::node_header_t::_read() {
    m_node_type = m__io->read_u2le();
    m_node_index = m__io->read_u2le();
    m_node_name_index = m__io->read_u2le();
    m_padding = m__io->read_u2le();
    m_root_node_offset = m__io->read_u4le();
    m_parent_node_offset = m__io->read_u4le();
    m_position = new vec3f_t(m__io, this, m__root);
    m_orientation = new quaternion_t(m__io, this, m__root);
    m_child_array_offset = m__io->read_u4le();
    m_child_count = m__io->read_u4le();
    m_child_count_duplicate = m__io->read_u4le();
    m_controller_array_offset = m__io->read_u4le();
    m_controller_count = m__io->read_u4le();
    m_controller_count_duplicate = m__io->read_u4le();
    m_controller_data_offset = m__io->read_u4le();
    m_controller_data_count = m__io->read_u4le();
    m_controller_data_count_duplicate = m__io->read_u4le();
}

mdl_t::node_header_t::~node_header_t() {
    _clean_up();
}

void mdl_t::node_header_t::_clean_up() {
    if (m_position) {
        delete m_position; m_position = 0;
    }
    if (m_orientation) {
        delete m_orientation; m_orientation = 0;
    }
}

bool mdl_t::node_header_t::has_aabb() {
    if (f_has_aabb)
        return m_has_aabb;
    f_has_aabb = true;
    m_has_aabb = (node_type() & 512) != 0;
    return m_has_aabb;
}

bool mdl_t::node_header_t::has_anim() {
    if (f_has_anim)
        return m_has_anim;
    f_has_anim = true;
    m_has_anim = (node_type() & 128) != 0;
    return m_has_anim;
}

bool mdl_t::node_header_t::has_dangly() {
    if (f_has_dangly)
        return m_has_dangly;
    f_has_dangly = true;
    m_has_dangly = (node_type() & 256) != 0;
    return m_has_dangly;
}

bool mdl_t::node_header_t::has_emitter() {
    if (f_has_emitter)
        return m_has_emitter;
    f_has_emitter = true;
    m_has_emitter = (node_type() & 4) != 0;
    return m_has_emitter;
}

bool mdl_t::node_header_t::has_light() {
    if (f_has_light)
        return m_has_light;
    f_has_light = true;
    m_has_light = (node_type() & 2) != 0;
    return m_has_light;
}

bool mdl_t::node_header_t::has_mesh() {
    if (f_has_mesh)
        return m_has_mesh;
    f_has_mesh = true;
    m_has_mesh = (node_type() & 32) != 0;
    return m_has_mesh;
}

bool mdl_t::node_header_t::has_reference() {
    if (f_has_reference)
        return m_has_reference;
    f_has_reference = true;
    m_has_reference = (node_type() & 16) != 0;
    return m_has_reference;
}

bool mdl_t::node_header_t::has_saber() {
    if (f_has_saber)
        return m_has_saber;
    f_has_saber = true;
    m_has_saber = (node_type() & 2048) != 0;
    return m_has_saber;
}

bool mdl_t::node_header_t::has_skin() {
    if (f_has_skin)
        return m_has_skin;
    f_has_skin = true;
    m_has_skin = (node_type() & 64) != 0;
    return m_has_skin;
}

mdl_t::quaternion_t::quaternion_t(kaitai::kstream* p__io, mdl_t::node_header_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::quaternion_t::_read() {
    m_w = m__io->read_f4le();
    m_x = m__io->read_f4le();
    m_y = m__io->read_f4le();
    m_z = m__io->read_f4le();
}

mdl_t::quaternion_t::~quaternion_t() {
    _clean_up();
}

void mdl_t::quaternion_t::_clean_up() {
}

mdl_t::reference_header_t::reference_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::reference_header_t::_read() {
    m_model_resref = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_reattachable = m__io->read_u4le();
}

mdl_t::reference_header_t::~reference_header_t() {
    _clean_up();
}

void mdl_t::reference_header_t::_clean_up() {
}

mdl_t::skinmesh_header_t::skinmesh_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_trimesh_base = 0;
    m_padding1 = 0;
    m_bone_node_serial_numbers = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::skinmesh_header_t::_read() {
    m_trimesh_base = new trimesh_header_t(m__io, this, m__root);
    m_unknown_weights = m__io->read_s4le();
    m_padding1 = new std::vector<uint8_t>();
    const int l_padding1 = 8;
    for (int i = 0; i < l_padding1; i++) {
        m_padding1->push_back(m__io->read_u1());
    }
    m_mdx_bone_weights_offset = m__io->read_u4le();
    m_mdx_bone_indices_offset = m__io->read_u4le();
    m_bone_map_offset = m__io->read_u4le();
    m_bone_map_count = m__io->read_u4le();
    m_qbones_offset = m__io->read_u4le();
    m_qbones_count = m__io->read_u4le();
    m_qbones_count_duplicate = m__io->read_u4le();
    m_tbones_offset = m__io->read_u4le();
    m_tbones_count = m__io->read_u4le();
    m_tbones_count_duplicate = m__io->read_u4le();
    m_unknown_array = m__io->read_u4le();
    m_bone_node_serial_numbers = new std::vector<uint16_t>();
    const int l_bone_node_serial_numbers = 16;
    for (int i = 0; i < l_bone_node_serial_numbers; i++) {
        m_bone_node_serial_numbers->push_back(m__io->read_u2le());
    }
    m_padding2 = m__io->read_u2le();
}

mdl_t::skinmesh_header_t::~skinmesh_header_t() {
    _clean_up();
}

void mdl_t::skinmesh_header_t::_clean_up() {
    if (m_trimesh_base) {
        delete m_trimesh_base; m_trimesh_base = 0;
    }
    if (m_padding1) {
        delete m_padding1; m_padding1 = 0;
    }
    if (m_bone_node_serial_numbers) {
        delete m_bone_node_serial_numbers; m_bone_node_serial_numbers = 0;
    }
}

mdl_t::trimesh_header_t::trimesh_header_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_bounding_box_min = 0;
    m_bounding_box_max = 0;
    m_average_point = 0;
    m_diffuse_color = 0;
    m_ambient_color = 0;
    m_unknown_values = 0;
    m_saber_unknown_data = 0;
    m_uv_direction = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::trimesh_header_t::_read() {
    m_function_pointer_0 = m__io->read_u4le();
    m_function_pointer_1 = m__io->read_u4le();
    m_faces_array_offset = m__io->read_u4le();
    m_faces_count = m__io->read_u4le();
    m_faces_count_duplicate = m__io->read_u4le();
    m_bounding_box_min = new vec3f_t(m__io, this, m__root);
    m_bounding_box_max = new vec3f_t(m__io, this, m__root);
    m_radius = m__io->read_f4le();
    m_average_point = new vec3f_t(m__io, this, m__root);
    m_diffuse_color = new vec3f_t(m__io, this, m__root);
    m_ambient_color = new vec3f_t(m__io, this, m__root);
    m_transparency_hint = m__io->read_u4le();
    m_texture_0_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_texture_1_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(32), 0, false), "ASCII");
    m_texture_2_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(12), 0, false), "ASCII");
    m_texture_3_name = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(12), 0, false), "ASCII");
    m_indices_count_array_offset = m__io->read_u4le();
    m_indices_count_array_count = m__io->read_u4le();
    m_indices_count_array_count_duplicate = m__io->read_u4le();
    m_indices_offset_array_offset = m__io->read_u4le();
    m_indices_offset_array_count = m__io->read_u4le();
    m_indices_offset_array_count_duplicate = m__io->read_u4le();
    m_inverted_counter_array_offset = m__io->read_u4le();
    m_inverted_counter_array_count = m__io->read_u4le();
    m_inverted_counter_array_count_duplicate = m__io->read_u4le();
    m_unknown_values = new std::vector<int32_t>();
    const int l_unknown_values = 3;
    for (int i = 0; i < l_unknown_values; i++) {
        m_unknown_values->push_back(m__io->read_s4le());
    }
    m_saber_unknown_data = new std::vector<uint8_t>();
    const int l_saber_unknown_data = 8;
    for (int i = 0; i < l_saber_unknown_data; i++) {
        m_saber_unknown_data->push_back(m__io->read_u1());
    }
    m_unknown = m__io->read_u4le();
    m_uv_direction = new vec3f_t(m__io, this, m__root);
    m_uv_jitter = m__io->read_f4le();
    m_uv_jitter_speed = m__io->read_f4le();
    m_mdx_vertex_size = m__io->read_u4le();
    m_mdx_data_flags = m__io->read_u4le();
    m_mdx_vertices_offset = m__io->read_s4le();
    m_mdx_normals_offset = m__io->read_s4le();
    m_mdx_vertex_colors_offset = m__io->read_s4le();
    m_mdx_tex0_uvs_offset = m__io->read_s4le();
    m_mdx_tex1_uvs_offset = m__io->read_s4le();
    m_mdx_tex2_uvs_offset = m__io->read_s4le();
    m_mdx_tex3_uvs_offset = m__io->read_s4le();
    m_mdx_tangent_space_offset = m__io->read_s4le();
    m_mdx_unknown_offset_1 = m__io->read_s4le();
    m_mdx_unknown_offset_2 = m__io->read_s4le();
    m_mdx_unknown_offset_3 = m__io->read_s4le();
    m_vertex_count = m__io->read_u2le();
    m_texture_count = m__io->read_u2le();
    m_lightmapped = m__io->read_u1();
    m_rotate_texture = m__io->read_u1();
    m_background_geometry = m__io->read_u1();
    m_shadow = m__io->read_u1();
    m_beaming = m__io->read_u1();
    m_render = m__io->read_u1();
    m_unknown_flag = m__io->read_u1();
    m_padding = m__io->read_u1();
    m_total_area = m__io->read_f4le();
    m_unknown2 = m__io->read_u4le();
    n_k2_unknown_1 = true;
    if (_root()->model_header()->geometry()->is_kotor2()) {
        n_k2_unknown_1 = false;
        m_k2_unknown_1 = m__io->read_u4le();
    }
    n_k2_unknown_2 = true;
    if (_root()->model_header()->geometry()->is_kotor2()) {
        n_k2_unknown_2 = false;
        m_k2_unknown_2 = m__io->read_u4le();
    }
    m_mdx_data_offset = m__io->read_u4le();
    m_mdl_vertices_offset = m__io->read_u4le();
}

mdl_t::trimesh_header_t::~trimesh_header_t() {
    _clean_up();
}

void mdl_t::trimesh_header_t::_clean_up() {
    if (m_bounding_box_min) {
        delete m_bounding_box_min; m_bounding_box_min = 0;
    }
    if (m_bounding_box_max) {
        delete m_bounding_box_max; m_bounding_box_max = 0;
    }
    if (m_average_point) {
        delete m_average_point; m_average_point = 0;
    }
    if (m_diffuse_color) {
        delete m_diffuse_color; m_diffuse_color = 0;
    }
    if (m_ambient_color) {
        delete m_ambient_color; m_ambient_color = 0;
    }
    if (m_unknown_values) {
        delete m_unknown_values; m_unknown_values = 0;
    }
    if (m_saber_unknown_data) {
        delete m_saber_unknown_data; m_saber_unknown_data = 0;
    }
    if (m_uv_direction) {
        delete m_uv_direction; m_uv_direction = 0;
    }
    if (!n_k2_unknown_1) {
    }
    if (!n_k2_unknown_2) {
    }
}

mdl_t::vec3f_t::vec3f_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_t::vec3f_t::_read() {
    m_x = m__io->read_f4le();
    m_y = m__io->read_f4le();
    m_z = m__io->read_f4le();
}

mdl_t::vec3f_t::~vec3f_t() {
    _clean_up();
}

void mdl_t::vec3f_t::_clean_up() {
}

std::vector<uint32_t>* mdl_t::animation_offsets() {
    if (f_animation_offsets)
        return m_animation_offsets;
    f_animation_offsets = true;
    n_animation_offsets = true;
    if (model_header()->animation_count() > 0) {
        n_animation_offsets = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(data_start() + model_header()->offset_to_animations());
        m_animation_offsets = new std::vector<uint32_t>();
        const int l_animation_offsets = model_header()->animation_count();
        for (int i = 0; i < l_animation_offsets; i++) {
            m_animation_offsets->push_back(m__io->read_u4le());
        }
        m__io->seek(_pos);
    }
    return m_animation_offsets;
}

std::vector<mdl_t::mdl_animation_entry_t*>* mdl_t::animations() {
    if (f_animations)
        return m_animations;
    f_animations = true;
    n_animations = true;
    if (model_header()->animation_count() > 0) {
        n_animations = false;
        m_animations = new std::vector<mdl_animation_entry_t*>();
        const int l_animations = model_header()->animation_count();
        for (int i = 0; i < l_animations; i++) {
            m_animations->push_back(new mdl_animation_entry_t(i, m__io, this, m__root));
        }
    }
    return m_animations;
}

int8_t mdl_t::data_start() {
    if (f_data_start)
        return m_data_start;
    f_data_start = true;
    m_data_start = 12;
    return m_data_start;
}

std::vector<uint32_t>* mdl_t::name_offsets() {
    if (f_name_offsets)
        return m_name_offsets;
    f_name_offsets = true;
    n_name_offsets = true;
    if (model_header()->name_offsets_count() > 0) {
        n_name_offsets = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(data_start() + model_header()->offset_to_name_offsets());
        m_name_offsets = new std::vector<uint32_t>();
        const int l_name_offsets = model_header()->name_offsets_count();
        for (int i = 0; i < l_name_offsets; i++) {
            m_name_offsets->push_back(m__io->read_u4le());
        }
        m__io->seek(_pos);
    }
    return m_name_offsets;
}

mdl_t::name_strings_t* mdl_t::names_data() {
    if (f_names_data)
        return m_names_data;
    f_names_data = true;
    n_names_data = true;
    if (model_header()->name_offsets_count() > 0) {
        n_names_data = false;
        std::streampos _pos = m__io->pos();
        m__io->seek((data_start() + model_header()->offset_to_name_offsets()) + 4 * model_header()->name_offsets_count());
        m__raw_names_data = m__io->read_bytes((data_start() + model_header()->offset_to_animations()) - ((data_start() + model_header()->offset_to_name_offsets()) + 4 * model_header()->name_offsets_count()));
        m__io__raw_names_data = new kaitai::kstream(m__raw_names_data);
        m_names_data = new name_strings_t(m__io__raw_names_data, this, m__root);
        m__io->seek(_pos);
    }
    return m_names_data;
}

mdl_t::node_t* mdl_t::root_node() {
    if (f_root_node)
        return m_root_node;
    f_root_node = true;
    n_root_node = true;
    if (model_header()->geometry()->root_node_offset() > 0) {
        n_root_node = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(data_start() + model_header()->geometry()->root_node_offset());
        m_root_node = new node_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_root_node;
}
