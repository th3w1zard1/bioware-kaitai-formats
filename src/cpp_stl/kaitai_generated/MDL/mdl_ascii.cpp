// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "mdl_ascii.h"

mdl_ascii_t::mdl_ascii_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_lines = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::_read() {
    m_lines = new std::vector<ascii_line_t*>();
    {
        int i = 0;
        while (!m__io->is_eof()) {
            m_lines->push_back(new ascii_line_t(m__io, this, m__root));
            i++;
        }
    }
}

mdl_ascii_t::~mdl_ascii_t() {
    _clean_up();
}

void mdl_ascii_t::_clean_up() {
    if (m_lines) {
        for (std::vector<ascii_line_t*>::iterator it = m_lines->begin(); it != m_lines->end(); ++it) {
            delete *it;
        }
        delete m_lines; m_lines = 0;
    }
}

mdl_ascii_t::animation_section_t::animation_section_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_newanim = 0;
    m_doneanim = 0;
    m_length = 0;
    m_transtime = 0;
    m_animroot = 0;
    m_event = 0;
    m_eventlist = 0;
    m_endlist = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::animation_section_t::_read() {
    m_newanim = new line_text_t(m__io, this, m__root);
    m_doneanim = new line_text_t(m__io, this, m__root);
    m_length = new line_text_t(m__io, this, m__root);
    m_transtime = new line_text_t(m__io, this, m__root);
    m_animroot = new line_text_t(m__io, this, m__root);
    m_event = new line_text_t(m__io, this, m__root);
    m_eventlist = new line_text_t(m__io, this, m__root);
    m_endlist = new line_text_t(m__io, this, m__root);
}

mdl_ascii_t::animation_section_t::~animation_section_t() {
    _clean_up();
}

void mdl_ascii_t::animation_section_t::_clean_up() {
    if (m_newanim) {
        delete m_newanim; m_newanim = 0;
    }
    if (m_doneanim) {
        delete m_doneanim; m_doneanim = 0;
    }
    if (m_length) {
        delete m_length; m_length = 0;
    }
    if (m_transtime) {
        delete m_transtime; m_transtime = 0;
    }
    if (m_animroot) {
        delete m_animroot; m_animroot = 0;
    }
    if (m_event) {
        delete m_event; m_event = 0;
    }
    if (m_eventlist) {
        delete m_eventlist; m_eventlist = 0;
    }
    if (m_endlist) {
        delete m_endlist; m_endlist = 0;
    }
}

mdl_ascii_t::ascii_line_t::ascii_line_t(kaitai::kstream* p__io, mdl_ascii_t* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::ascii_line_t::_read() {
    m_content = kaitai::kstream::bytes_to_str(m__io->read_bytes_term(10, false, true, false), "UTF-8");
}

mdl_ascii_t::ascii_line_t::~ascii_line_t() {
    _clean_up();
}

void mdl_ascii_t::ascii_line_t::_clean_up() {
}

mdl_ascii_t::controller_bezier_t::controller_bezier_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_controller_name = 0;
    m_keyframes = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::controller_bezier_t::_read() {
    m_controller_name = new line_text_t(m__io, this, m__root);
    m_keyframes = new std::vector<controller_bezier_keyframe_t*>();
    {
        int i = 0;
        while (!m__io->is_eof()) {
            m_keyframes->push_back(new controller_bezier_keyframe_t(m__io, this, m__root));
            i++;
        }
    }
}

mdl_ascii_t::controller_bezier_t::~controller_bezier_t() {
    _clean_up();
}

void mdl_ascii_t::controller_bezier_t::_clean_up() {
    if (m_controller_name) {
        delete m_controller_name; m_controller_name = 0;
    }
    if (m_keyframes) {
        for (std::vector<controller_bezier_keyframe_t*>::iterator it = m_keyframes->begin(); it != m_keyframes->end(); ++it) {
            delete *it;
        }
        delete m_keyframes; m_keyframes = 0;
    }
}

mdl_ascii_t::controller_bezier_keyframe_t::controller_bezier_keyframe_t(kaitai::kstream* p__io, mdl_ascii_t::controller_bezier_t* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::controller_bezier_keyframe_t::_read() {
    m_time = kaitai::kstream::bytes_to_str(m__io->read_bytes_full(), "UTF-8");
    m_value_data = kaitai::kstream::bytes_to_str(m__io->read_bytes_full(), "UTF-8");
}

mdl_ascii_t::controller_bezier_keyframe_t::~controller_bezier_keyframe_t() {
    _clean_up();
}

void mdl_ascii_t::controller_bezier_keyframe_t::_clean_up() {
}

mdl_ascii_t::controller_keyed_t::controller_keyed_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_controller_name = 0;
    m_keyframes = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::controller_keyed_t::_read() {
    m_controller_name = new line_text_t(m__io, this, m__root);
    m_keyframes = new std::vector<controller_keyframe_t*>();
    {
        int i = 0;
        while (!m__io->is_eof()) {
            m_keyframes->push_back(new controller_keyframe_t(m__io, this, m__root));
            i++;
        }
    }
}

mdl_ascii_t::controller_keyed_t::~controller_keyed_t() {
    _clean_up();
}

void mdl_ascii_t::controller_keyed_t::_clean_up() {
    if (m_controller_name) {
        delete m_controller_name; m_controller_name = 0;
    }
    if (m_keyframes) {
        for (std::vector<controller_keyframe_t*>::iterator it = m_keyframes->begin(); it != m_keyframes->end(); ++it) {
            delete *it;
        }
        delete m_keyframes; m_keyframes = 0;
    }
}

mdl_ascii_t::controller_keyframe_t::controller_keyframe_t(kaitai::kstream* p__io, mdl_ascii_t::controller_keyed_t* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::controller_keyframe_t::_read() {
    m_time = kaitai::kstream::bytes_to_str(m__io->read_bytes_full(), "UTF-8");
    m_values = kaitai::kstream::bytes_to_str(m__io->read_bytes_full(), "UTF-8");
}

mdl_ascii_t::controller_keyframe_t::~controller_keyframe_t() {
    _clean_up();
}

void mdl_ascii_t::controller_keyframe_t::_clean_up() {
}

mdl_ascii_t::controller_single_t::controller_single_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_controller_name = 0;
    m_values = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::controller_single_t::_read() {
    m_controller_name = new line_text_t(m__io, this, m__root);
    m_values = new line_text_t(m__io, this, m__root);
}

mdl_ascii_t::controller_single_t::~controller_single_t() {
    _clean_up();
}

void mdl_ascii_t::controller_single_t::_clean_up() {
    if (m_controller_name) {
        delete m_controller_name; m_controller_name = 0;
    }
    if (m_values) {
        delete m_values; m_values = 0;
    }
}

mdl_ascii_t::danglymesh_properties_t::danglymesh_properties_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_displacement = 0;
    m_tightness = 0;
    m_period = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::danglymesh_properties_t::_read() {
    m_displacement = new line_text_t(m__io, this, m__root);
    m_tightness = new line_text_t(m__io, this, m__root);
    m_period = new line_text_t(m__io, this, m__root);
}

mdl_ascii_t::danglymesh_properties_t::~danglymesh_properties_t() {
    _clean_up();
}

void mdl_ascii_t::danglymesh_properties_t::_clean_up() {
    if (m_displacement) {
        delete m_displacement; m_displacement = 0;
    }
    if (m_tightness) {
        delete m_tightness; m_tightness = 0;
    }
    if (m_period) {
        delete m_period; m_period = 0;
    }
}

mdl_ascii_t::data_arrays_t::data_arrays_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_verts = 0;
    m_faces = 0;
    m_tverts = 0;
    m_tverts1 = 0;
    m_lightmaptverts = 0;
    m_tverts2 = 0;
    m_tverts3 = 0;
    m_texindices1 = 0;
    m_texindices2 = 0;
    m_texindices3 = 0;
    m_colors = 0;
    m_colorindices = 0;
    m_weights = 0;
    m_constraints = 0;
    m_aabb = 0;
    m_saber_verts = 0;
    m_saber_norms = 0;
    m_name = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::data_arrays_t::_read() {
    m_verts = new line_text_t(m__io, this, m__root);
    m_faces = new line_text_t(m__io, this, m__root);
    m_tverts = new line_text_t(m__io, this, m__root);
    m_tverts1 = new line_text_t(m__io, this, m__root);
    m_lightmaptverts = new line_text_t(m__io, this, m__root);
    m_tverts2 = new line_text_t(m__io, this, m__root);
    m_tverts3 = new line_text_t(m__io, this, m__root);
    m_texindices1 = new line_text_t(m__io, this, m__root);
    m_texindices2 = new line_text_t(m__io, this, m__root);
    m_texindices3 = new line_text_t(m__io, this, m__root);
    m_colors = new line_text_t(m__io, this, m__root);
    m_colorindices = new line_text_t(m__io, this, m__root);
    m_weights = new line_text_t(m__io, this, m__root);
    m_constraints = new line_text_t(m__io, this, m__root);
    m_aabb = new line_text_t(m__io, this, m__root);
    m_saber_verts = new line_text_t(m__io, this, m__root);
    m_saber_norms = new line_text_t(m__io, this, m__root);
    m_name = new line_text_t(m__io, this, m__root);
}

mdl_ascii_t::data_arrays_t::~data_arrays_t() {
    _clean_up();
}

void mdl_ascii_t::data_arrays_t::_clean_up() {
    if (m_verts) {
        delete m_verts; m_verts = 0;
    }
    if (m_faces) {
        delete m_faces; m_faces = 0;
    }
    if (m_tverts) {
        delete m_tverts; m_tverts = 0;
    }
    if (m_tverts1) {
        delete m_tverts1; m_tverts1 = 0;
    }
    if (m_lightmaptverts) {
        delete m_lightmaptverts; m_lightmaptverts = 0;
    }
    if (m_tverts2) {
        delete m_tverts2; m_tverts2 = 0;
    }
    if (m_tverts3) {
        delete m_tverts3; m_tverts3 = 0;
    }
    if (m_texindices1) {
        delete m_texindices1; m_texindices1 = 0;
    }
    if (m_texindices2) {
        delete m_texindices2; m_texindices2 = 0;
    }
    if (m_texindices3) {
        delete m_texindices3; m_texindices3 = 0;
    }
    if (m_colors) {
        delete m_colors; m_colors = 0;
    }
    if (m_colorindices) {
        delete m_colorindices; m_colorindices = 0;
    }
    if (m_weights) {
        delete m_weights; m_weights = 0;
    }
    if (m_constraints) {
        delete m_constraints; m_constraints = 0;
    }
    if (m_aabb) {
        delete m_aabb; m_aabb = 0;
    }
    if (m_saber_verts) {
        delete m_saber_verts; m_saber_verts = 0;
    }
    if (m_saber_norms) {
        delete m_saber_norms; m_saber_norms = 0;
    }
    if (m_name) {
        delete m_name; m_name = 0;
    }
}

mdl_ascii_t::emitter_flags_t::emitter_flags_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_p2p = 0;
    m_p2p_sel = 0;
    m_affected_by_wind = 0;
    m_m_is_tinted = 0;
    m_bounce = 0;
    m_random = 0;
    m_inherit = 0;
    m_inheritvel = 0;
    m_inherit_local = 0;
    m_splat = 0;
    m_inherit_part = 0;
    m_depth_texture = 0;
    m_emitterflag13 = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::emitter_flags_t::_read() {
    m_p2p = new line_text_t(m__io, this, m__root);
    m_p2p_sel = new line_text_t(m__io, this, m__root);
    m_affected_by_wind = new line_text_t(m__io, this, m__root);
    m_m_is_tinted = new line_text_t(m__io, this, m__root);
    m_bounce = new line_text_t(m__io, this, m__root);
    m_random = new line_text_t(m__io, this, m__root);
    m_inherit = new line_text_t(m__io, this, m__root);
    m_inheritvel = new line_text_t(m__io, this, m__root);
    m_inherit_local = new line_text_t(m__io, this, m__root);
    m_splat = new line_text_t(m__io, this, m__root);
    m_inherit_part = new line_text_t(m__io, this, m__root);
    m_depth_texture = new line_text_t(m__io, this, m__root);
    m_emitterflag13 = new line_text_t(m__io, this, m__root);
}

mdl_ascii_t::emitter_flags_t::~emitter_flags_t() {
    _clean_up();
}

void mdl_ascii_t::emitter_flags_t::_clean_up() {
    if (m_p2p) {
        delete m_p2p; m_p2p = 0;
    }
    if (m_p2p_sel) {
        delete m_p2p_sel; m_p2p_sel = 0;
    }
    if (m_affected_by_wind) {
        delete m_affected_by_wind; m_affected_by_wind = 0;
    }
    if (m_m_is_tinted) {
        delete m_m_is_tinted; m_m_is_tinted = 0;
    }
    if (m_bounce) {
        delete m_bounce; m_bounce = 0;
    }
    if (m_random) {
        delete m_random; m_random = 0;
    }
    if (m_inherit) {
        delete m_inherit; m_inherit = 0;
    }
    if (m_inheritvel) {
        delete m_inheritvel; m_inheritvel = 0;
    }
    if (m_inherit_local) {
        delete m_inherit_local; m_inherit_local = 0;
    }
    if (m_splat) {
        delete m_splat; m_splat = 0;
    }
    if (m_inherit_part) {
        delete m_inherit_part; m_inherit_part = 0;
    }
    if (m_depth_texture) {
        delete m_depth_texture; m_depth_texture = 0;
    }
    if (m_emitterflag13) {
        delete m_emitterflag13; m_emitterflag13 = 0;
    }
}

mdl_ascii_t::emitter_properties_t::emitter_properties_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_deadspace = 0;
    m_blast_radius = 0;
    m_blast_length = 0;
    m_num_branches = 0;
    m_controlptsmoothing = 0;
    m_xgrid = 0;
    m_ygrid = 0;
    m_spawntype = 0;
    m_update = 0;
    m_render = 0;
    m_blend = 0;
    m_texture = 0;
    m_chunkname = 0;
    m_twosidedtex = 0;
    m_loop = 0;
    m_renderorder = 0;
    m_m_b_frame_blending = 0;
    m_m_s_depth_texture_name = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::emitter_properties_t::_read() {
    m_deadspace = new line_text_t(m__io, this, m__root);
    m_blast_radius = new line_text_t(m__io, this, m__root);
    m_blast_length = new line_text_t(m__io, this, m__root);
    m_num_branches = new line_text_t(m__io, this, m__root);
    m_controlptsmoothing = new line_text_t(m__io, this, m__root);
    m_xgrid = new line_text_t(m__io, this, m__root);
    m_ygrid = new line_text_t(m__io, this, m__root);
    m_spawntype = new line_text_t(m__io, this, m__root);
    m_update = new line_text_t(m__io, this, m__root);
    m_render = new line_text_t(m__io, this, m__root);
    m_blend = new line_text_t(m__io, this, m__root);
    m_texture = new line_text_t(m__io, this, m__root);
    m_chunkname = new line_text_t(m__io, this, m__root);
    m_twosidedtex = new line_text_t(m__io, this, m__root);
    m_loop = new line_text_t(m__io, this, m__root);
    m_renderorder = new line_text_t(m__io, this, m__root);
    m_m_b_frame_blending = new line_text_t(m__io, this, m__root);
    m_m_s_depth_texture_name = new line_text_t(m__io, this, m__root);
}

mdl_ascii_t::emitter_properties_t::~emitter_properties_t() {
    _clean_up();
}

void mdl_ascii_t::emitter_properties_t::_clean_up() {
    if (m_deadspace) {
        delete m_deadspace; m_deadspace = 0;
    }
    if (m_blast_radius) {
        delete m_blast_radius; m_blast_radius = 0;
    }
    if (m_blast_length) {
        delete m_blast_length; m_blast_length = 0;
    }
    if (m_num_branches) {
        delete m_num_branches; m_num_branches = 0;
    }
    if (m_controlptsmoothing) {
        delete m_controlptsmoothing; m_controlptsmoothing = 0;
    }
    if (m_xgrid) {
        delete m_xgrid; m_xgrid = 0;
    }
    if (m_ygrid) {
        delete m_ygrid; m_ygrid = 0;
    }
    if (m_spawntype) {
        delete m_spawntype; m_spawntype = 0;
    }
    if (m_update) {
        delete m_update; m_update = 0;
    }
    if (m_render) {
        delete m_render; m_render = 0;
    }
    if (m_blend) {
        delete m_blend; m_blend = 0;
    }
    if (m_texture) {
        delete m_texture; m_texture = 0;
    }
    if (m_chunkname) {
        delete m_chunkname; m_chunkname = 0;
    }
    if (m_twosidedtex) {
        delete m_twosidedtex; m_twosidedtex = 0;
    }
    if (m_loop) {
        delete m_loop; m_loop = 0;
    }
    if (m_renderorder) {
        delete m_renderorder; m_renderorder = 0;
    }
    if (m_m_b_frame_blending) {
        delete m_m_b_frame_blending; m_m_b_frame_blending = 0;
    }
    if (m_m_s_depth_texture_name) {
        delete m_m_s_depth_texture_name; m_m_s_depth_texture_name = 0;
    }
}

mdl_ascii_t::light_properties_t::light_properties_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_flareradius = 0;
    m_flarepositions = 0;
    m_flaresizes = 0;
    m_flarecolorshifts = 0;
    m_texturenames = 0;
    m_ambientonly = 0;
    m_ndynamictype = 0;
    m_affectdynamic = 0;
    m_flare = 0;
    m_lightpriority = 0;
    m_fadinglight = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::light_properties_t::_read() {
    m_flareradius = new line_text_t(m__io, this, m__root);
    m_flarepositions = new line_text_t(m__io, this, m__root);
    m_flaresizes = new line_text_t(m__io, this, m__root);
    m_flarecolorshifts = new line_text_t(m__io, this, m__root);
    m_texturenames = new line_text_t(m__io, this, m__root);
    m_ambientonly = new line_text_t(m__io, this, m__root);
    m_ndynamictype = new line_text_t(m__io, this, m__root);
    m_affectdynamic = new line_text_t(m__io, this, m__root);
    m_flare = new line_text_t(m__io, this, m__root);
    m_lightpriority = new line_text_t(m__io, this, m__root);
    m_fadinglight = new line_text_t(m__io, this, m__root);
}

mdl_ascii_t::light_properties_t::~light_properties_t() {
    _clean_up();
}

void mdl_ascii_t::light_properties_t::_clean_up() {
    if (m_flareradius) {
        delete m_flareradius; m_flareradius = 0;
    }
    if (m_flarepositions) {
        delete m_flarepositions; m_flarepositions = 0;
    }
    if (m_flaresizes) {
        delete m_flaresizes; m_flaresizes = 0;
    }
    if (m_flarecolorshifts) {
        delete m_flarecolorshifts; m_flarecolorshifts = 0;
    }
    if (m_texturenames) {
        delete m_texturenames; m_texturenames = 0;
    }
    if (m_ambientonly) {
        delete m_ambientonly; m_ambientonly = 0;
    }
    if (m_ndynamictype) {
        delete m_ndynamictype; m_ndynamictype = 0;
    }
    if (m_affectdynamic) {
        delete m_affectdynamic; m_affectdynamic = 0;
    }
    if (m_flare) {
        delete m_flare; m_flare = 0;
    }
    if (m_lightpriority) {
        delete m_lightpriority; m_lightpriority = 0;
    }
    if (m_fadinglight) {
        delete m_fadinglight; m_fadinglight = 0;
    }
}

mdl_ascii_t::line_text_t::line_text_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::line_text_t::_read() {
    m_value = kaitai::kstream::bytes_to_str(m__io->read_bytes_term(10, false, true, false), "UTF-8");
}

mdl_ascii_t::line_text_t::~line_text_t() {
    _clean_up();
}

void mdl_ascii_t::line_text_t::_clean_up() {
}

mdl_ascii_t::reference_properties_t::reference_properties_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mdl_ascii_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_refmodel = 0;
    m_reattachable = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mdl_ascii_t::reference_properties_t::_read() {
    m_refmodel = new line_text_t(m__io, this, m__root);
    m_reattachable = new line_text_t(m__io, this, m__root);
}

mdl_ascii_t::reference_properties_t::~reference_properties_t() {
    _clean_up();
}

void mdl_ascii_t::reference_properties_t::_clean_up() {
    if (m_refmodel) {
        delete m_refmodel; m_refmodel = 0;
    }
    if (m_reattachable) {
        delete m_reattachable; m_reattachable = 0;
    }
}
