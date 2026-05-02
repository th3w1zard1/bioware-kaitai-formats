// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bwm.h"

bwm_t::bwm_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_header = 0;
    m_walkmesh_properties = 0;
    m_data_table_offsets = 0;
    m_aabb_nodes = 0;
    m_adjacencies = 0;
    m_edges = 0;
    m_face_indices = 0;
    m_materials = 0;
    m_normals = 0;
    m_perimeters = 0;
    m_planar_distances = 0;
    m_vertices = 0;
    f_aabb_nodes = false;
    f_adjacencies = false;
    f_edges = false;
    f_face_indices = false;
    f_materials = false;
    f_normals = false;
    f_perimeters = false;
    f_planar_distances = false;
    f_vertices = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::_read() {
    m_header = new bwm_header_t(m__io, this, m__root);
    m_walkmesh_properties = new walkmesh_properties_t(m__io, this, m__root);
    m_data_table_offsets = new data_table_offsets_t(m__io, this, m__root);
}

bwm_t::~bwm_t() {
    _clean_up();
}

void bwm_t::_clean_up() {
    if (m_header) {
        delete m_header; m_header = 0;
    }
    if (m_walkmesh_properties) {
        delete m_walkmesh_properties; m_walkmesh_properties = 0;
    }
    if (m_data_table_offsets) {
        delete m_data_table_offsets; m_data_table_offsets = 0;
    }
    if (f_aabb_nodes && !n_aabb_nodes) {
        if (m_aabb_nodes) {
            delete m_aabb_nodes; m_aabb_nodes = 0;
        }
    }
    if (f_adjacencies && !n_adjacencies) {
        if (m_adjacencies) {
            delete m_adjacencies; m_adjacencies = 0;
        }
    }
    if (f_edges && !n_edges) {
        if (m_edges) {
            delete m_edges; m_edges = 0;
        }
    }
    if (f_face_indices && !n_face_indices) {
        if (m_face_indices) {
            delete m_face_indices; m_face_indices = 0;
        }
    }
    if (f_materials && !n_materials) {
        if (m_materials) {
            delete m_materials; m_materials = 0;
        }
    }
    if (f_normals && !n_normals) {
        if (m_normals) {
            delete m_normals; m_normals = 0;
        }
    }
    if (f_perimeters && !n_perimeters) {
        if (m_perimeters) {
            delete m_perimeters; m_perimeters = 0;
        }
    }
    if (f_planar_distances && !n_planar_distances) {
        if (m_planar_distances) {
            delete m_planar_distances; m_planar_distances = 0;
        }
    }
    if (f_vertices && !n_vertices) {
        if (m_vertices) {
            delete m_vertices; m_vertices = 0;
        }
    }
}

bwm_t::aabb_node_t::aabb_node_t(kaitai::kstream* p__io, bwm_t::aabb_nodes_array_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_bounds_min = 0;
    m_bounds_max = 0;
    f_has_left_child = false;
    f_has_right_child = false;
    f_is_internal_node = false;
    f_is_leaf_node = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::aabb_node_t::_read() {
    m_bounds_min = new vec3f_t(m__io, this, m__root);
    m_bounds_max = new vec3f_t(m__io, this, m__root);
    m_face_index = m__io->read_s4le();
    m_unknown = m__io->read_u4le();
    m_most_significant_plane = m__io->read_u4le();
    m_left_child_index = m__io->read_u4le();
    m_right_child_index = m__io->read_u4le();
}

bwm_t::aabb_node_t::~aabb_node_t() {
    _clean_up();
}

void bwm_t::aabb_node_t::_clean_up() {
    if (m_bounds_min) {
        delete m_bounds_min; m_bounds_min = 0;
    }
    if (m_bounds_max) {
        delete m_bounds_max; m_bounds_max = 0;
    }
}

bool bwm_t::aabb_node_t::has_left_child() {
    if (f_has_left_child)
        return m_has_left_child;
    f_has_left_child = true;
    m_has_left_child = left_child_index() != 4294967295UL;
    return m_has_left_child;
}

bool bwm_t::aabb_node_t::has_right_child() {
    if (f_has_right_child)
        return m_has_right_child;
    f_has_right_child = true;
    m_has_right_child = right_child_index() != 4294967295UL;
    return m_has_right_child;
}

bool bwm_t::aabb_node_t::is_internal_node() {
    if (f_is_internal_node)
        return m_is_internal_node;
    f_is_internal_node = true;
    m_is_internal_node = face_index() == -1;
    return m_is_internal_node;
}

bool bwm_t::aabb_node_t::is_leaf_node() {
    if (f_is_leaf_node)
        return m_is_leaf_node;
    f_is_leaf_node = true;
    m_is_leaf_node = face_index() != -1;
    return m_is_leaf_node;
}

bwm_t::aabb_nodes_array_t::aabb_nodes_array_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_nodes = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::aabb_nodes_array_t::_read() {
    m_nodes = new std::vector<aabb_node_t*>();
    const int l_nodes = _root()->data_table_offsets()->aabb_count();
    for (int i = 0; i < l_nodes; i++) {
        m_nodes->push_back(new aabb_node_t(m__io, this, m__root));
    }
}

bwm_t::aabb_nodes_array_t::~aabb_nodes_array_t() {
    _clean_up();
}

void bwm_t::aabb_nodes_array_t::_clean_up() {
    if (m_nodes) {
        for (std::vector<aabb_node_t*>::iterator it = m_nodes->begin(); it != m_nodes->end(); ++it) {
            delete *it;
        }
        delete m_nodes; m_nodes = 0;
    }
}

bwm_t::adjacencies_array_t::adjacencies_array_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_adjacencies = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::adjacencies_array_t::_read() {
    m_adjacencies = new std::vector<adjacency_triplet_t*>();
    const int l_adjacencies = _root()->data_table_offsets()->adjacency_count();
    for (int i = 0; i < l_adjacencies; i++) {
        m_adjacencies->push_back(new adjacency_triplet_t(m__io, this, m__root));
    }
}

bwm_t::adjacencies_array_t::~adjacencies_array_t() {
    _clean_up();
}

void bwm_t::adjacencies_array_t::_clean_up() {
    if (m_adjacencies) {
        for (std::vector<adjacency_triplet_t*>::iterator it = m_adjacencies->begin(); it != m_adjacencies->end(); ++it) {
            delete *it;
        }
        delete m_adjacencies; m_adjacencies = 0;
    }
}

bwm_t::adjacency_triplet_t::adjacency_triplet_t(kaitai::kstream* p__io, bwm_t::adjacencies_array_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_edge_0_face_index = false;
    f_edge_0_has_neighbor = false;
    f_edge_0_local_edge = false;
    f_edge_1_face_index = false;
    f_edge_1_has_neighbor = false;
    f_edge_1_local_edge = false;
    f_edge_2_face_index = false;
    f_edge_2_has_neighbor = false;
    f_edge_2_local_edge = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::adjacency_triplet_t::_read() {
    m_edge_0_adjacency = m__io->read_s4le();
    m_edge_1_adjacency = m__io->read_s4le();
    m_edge_2_adjacency = m__io->read_s4le();
}

bwm_t::adjacency_triplet_t::~adjacency_triplet_t() {
    _clean_up();
}

void bwm_t::adjacency_triplet_t::_clean_up() {
}

int32_t bwm_t::adjacency_triplet_t::edge_0_face_index() {
    if (f_edge_0_face_index)
        return m_edge_0_face_index;
    f_edge_0_face_index = true;
    m_edge_0_face_index = ((edge_0_adjacency() != -1) ? (edge_0_adjacency() / 3) : (-1));
    return m_edge_0_face_index;
}

bool bwm_t::adjacency_triplet_t::edge_0_has_neighbor() {
    if (f_edge_0_has_neighbor)
        return m_edge_0_has_neighbor;
    f_edge_0_has_neighbor = true;
    m_edge_0_has_neighbor = edge_0_adjacency() != -1;
    return m_edge_0_has_neighbor;
}

int32_t bwm_t::adjacency_triplet_t::edge_0_local_edge() {
    if (f_edge_0_local_edge)
        return m_edge_0_local_edge;
    f_edge_0_local_edge = true;
    m_edge_0_local_edge = ((edge_0_adjacency() != -1) ? (kaitai::kstream::mod(edge_0_adjacency(), 3)) : (-1));
    return m_edge_0_local_edge;
}

int32_t bwm_t::adjacency_triplet_t::edge_1_face_index() {
    if (f_edge_1_face_index)
        return m_edge_1_face_index;
    f_edge_1_face_index = true;
    m_edge_1_face_index = ((edge_1_adjacency() != -1) ? (edge_1_adjacency() / 3) : (-1));
    return m_edge_1_face_index;
}

bool bwm_t::adjacency_triplet_t::edge_1_has_neighbor() {
    if (f_edge_1_has_neighbor)
        return m_edge_1_has_neighbor;
    f_edge_1_has_neighbor = true;
    m_edge_1_has_neighbor = edge_1_adjacency() != -1;
    return m_edge_1_has_neighbor;
}

int32_t bwm_t::adjacency_triplet_t::edge_1_local_edge() {
    if (f_edge_1_local_edge)
        return m_edge_1_local_edge;
    f_edge_1_local_edge = true;
    m_edge_1_local_edge = ((edge_1_adjacency() != -1) ? (kaitai::kstream::mod(edge_1_adjacency(), 3)) : (-1));
    return m_edge_1_local_edge;
}

int32_t bwm_t::adjacency_triplet_t::edge_2_face_index() {
    if (f_edge_2_face_index)
        return m_edge_2_face_index;
    f_edge_2_face_index = true;
    m_edge_2_face_index = ((edge_2_adjacency() != -1) ? (edge_2_adjacency() / 3) : (-1));
    return m_edge_2_face_index;
}

bool bwm_t::adjacency_triplet_t::edge_2_has_neighbor() {
    if (f_edge_2_has_neighbor)
        return m_edge_2_has_neighbor;
    f_edge_2_has_neighbor = true;
    m_edge_2_has_neighbor = edge_2_adjacency() != -1;
    return m_edge_2_has_neighbor;
}

int32_t bwm_t::adjacency_triplet_t::edge_2_local_edge() {
    if (f_edge_2_local_edge)
        return m_edge_2_local_edge;
    f_edge_2_local_edge = true;
    m_edge_2_local_edge = ((edge_2_adjacency() != -1) ? (kaitai::kstream::mod(edge_2_adjacency(), 3)) : (-1));
    return m_edge_2_local_edge;
}

bwm_t::bwm_header_t::bwm_header_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_is_valid_bwm = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::bwm_header_t::_read() {
    m_magic = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_version = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
}

bwm_t::bwm_header_t::~bwm_header_t() {
    _clean_up();
}

void bwm_t::bwm_header_t::_clean_up() {
}

bool bwm_t::bwm_header_t::is_valid_bwm() {
    if (f_is_valid_bwm)
        return m_is_valid_bwm;
    f_is_valid_bwm = true;
    m_is_valid_bwm =  ((magic() == std::string("BWM ")) && (version() == std::string("V1.0"))) ;
    return m_is_valid_bwm;
}

bwm_t::data_table_offsets_t::data_table_offsets_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::data_table_offsets_t::_read() {
    m_vertex_count = m__io->read_u4le();
    m_vertex_offset = m__io->read_u4le();
    m_face_count = m__io->read_u4le();
    m_face_indices_offset = m__io->read_u4le();
    m_materials_offset = m__io->read_u4le();
    m_normals_offset = m__io->read_u4le();
    m_distances_offset = m__io->read_u4le();
    m_aabb_count = m__io->read_u4le();
    m_aabb_offset = m__io->read_u4le();
    m_unknown = m__io->read_u4le();
    m_adjacency_count = m__io->read_u4le();
    m_adjacency_offset = m__io->read_u4le();
    m_edge_count = m__io->read_u4le();
    m_edge_offset = m__io->read_u4le();
    m_perimeter_count = m__io->read_u4le();
    m_perimeter_offset = m__io->read_u4le();
}

bwm_t::data_table_offsets_t::~data_table_offsets_t() {
    _clean_up();
}

void bwm_t::data_table_offsets_t::_clean_up() {
}

bwm_t::edge_entry_t::edge_entry_t(kaitai::kstream* p__io, bwm_t::edges_array_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_face_index = false;
    f_has_transition = false;
    f_local_edge_index = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::edge_entry_t::_read() {
    m_edge_index = m__io->read_u4le();
    m_transition = m__io->read_s4le();
}

bwm_t::edge_entry_t::~edge_entry_t() {
    _clean_up();
}

void bwm_t::edge_entry_t::_clean_up() {
}

int32_t bwm_t::edge_entry_t::face_index() {
    if (f_face_index)
        return m_face_index;
    f_face_index = true;
    m_face_index = edge_index() / 3;
    return m_face_index;
}

bool bwm_t::edge_entry_t::has_transition() {
    if (f_has_transition)
        return m_has_transition;
    f_has_transition = true;
    m_has_transition = transition() != -1;
    return m_has_transition;
}

int32_t bwm_t::edge_entry_t::local_edge_index() {
    if (f_local_edge_index)
        return m_local_edge_index;
    f_local_edge_index = true;
    m_local_edge_index = kaitai::kstream::mod(edge_index(), 3);
    return m_local_edge_index;
}

bwm_t::edges_array_t::edges_array_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_edges = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::edges_array_t::_read() {
    m_edges = new std::vector<edge_entry_t*>();
    const int l_edges = _root()->data_table_offsets()->edge_count();
    for (int i = 0; i < l_edges; i++) {
        m_edges->push_back(new edge_entry_t(m__io, this, m__root));
    }
}

bwm_t::edges_array_t::~edges_array_t() {
    _clean_up();
}

void bwm_t::edges_array_t::_clean_up() {
    if (m_edges) {
        for (std::vector<edge_entry_t*>::iterator it = m_edges->begin(); it != m_edges->end(); ++it) {
            delete *it;
        }
        delete m_edges; m_edges = 0;
    }
}

bwm_t::face_indices_t::face_indices_t(kaitai::kstream* p__io, bwm_t::face_indices_array_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::face_indices_t::_read() {
    m_v1_index = m__io->read_u4le();
    m_v2_index = m__io->read_u4le();
    m_v3_index = m__io->read_u4le();
}

bwm_t::face_indices_t::~face_indices_t() {
    _clean_up();
}

void bwm_t::face_indices_t::_clean_up() {
}

bwm_t::face_indices_array_t::face_indices_array_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_faces = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::face_indices_array_t::_read() {
    m_faces = new std::vector<face_indices_t*>();
    const int l_faces = _root()->data_table_offsets()->face_count();
    for (int i = 0; i < l_faces; i++) {
        m_faces->push_back(new face_indices_t(m__io, this, m__root));
    }
}

bwm_t::face_indices_array_t::~face_indices_array_t() {
    _clean_up();
}

void bwm_t::face_indices_array_t::_clean_up() {
    if (m_faces) {
        for (std::vector<face_indices_t*>::iterator it = m_faces->begin(); it != m_faces->end(); ++it) {
            delete *it;
        }
        delete m_faces; m_faces = 0;
    }
}

bwm_t::materials_array_t::materials_array_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_materials = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::materials_array_t::_read() {
    m_materials = new std::vector<uint32_t>();
    const int l_materials = _root()->data_table_offsets()->face_count();
    for (int i = 0; i < l_materials; i++) {
        m_materials->push_back(m__io->read_u4le());
    }
}

bwm_t::materials_array_t::~materials_array_t() {
    _clean_up();
}

void bwm_t::materials_array_t::_clean_up() {
    if (m_materials) {
        delete m_materials; m_materials = 0;
    }
}

bwm_t::normals_array_t::normals_array_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_normals = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::normals_array_t::_read() {
    m_normals = new std::vector<vec3f_t*>();
    const int l_normals = _root()->data_table_offsets()->face_count();
    for (int i = 0; i < l_normals; i++) {
        m_normals->push_back(new vec3f_t(m__io, this, m__root));
    }
}

bwm_t::normals_array_t::~normals_array_t() {
    _clean_up();
}

void bwm_t::normals_array_t::_clean_up() {
    if (m_normals) {
        for (std::vector<vec3f_t*>::iterator it = m_normals->begin(); it != m_normals->end(); ++it) {
            delete *it;
        }
        delete m_normals; m_normals = 0;
    }
}

bwm_t::perimeters_array_t::perimeters_array_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_perimeters = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::perimeters_array_t::_read() {
    m_perimeters = new std::vector<uint32_t>();
    const int l_perimeters = _root()->data_table_offsets()->perimeter_count();
    for (int i = 0; i < l_perimeters; i++) {
        m_perimeters->push_back(m__io->read_u4le());
    }
}

bwm_t::perimeters_array_t::~perimeters_array_t() {
    _clean_up();
}

void bwm_t::perimeters_array_t::_clean_up() {
    if (m_perimeters) {
        delete m_perimeters; m_perimeters = 0;
    }
}

bwm_t::planar_distances_array_t::planar_distances_array_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_distances = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::planar_distances_array_t::_read() {
    m_distances = new std::vector<float>();
    const int l_distances = _root()->data_table_offsets()->face_count();
    for (int i = 0; i < l_distances; i++) {
        m_distances->push_back(m__io->read_f4le());
    }
}

bwm_t::planar_distances_array_t::~planar_distances_array_t() {
    _clean_up();
}

void bwm_t::planar_distances_array_t::_clean_up() {
    if (m_distances) {
        delete m_distances; m_distances = 0;
    }
}

bwm_t::vec3f_t::vec3f_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::vec3f_t::_read() {
    m_x = m__io->read_f4le();
    m_y = m__io->read_f4le();
    m_z = m__io->read_f4le();
}

bwm_t::vec3f_t::~vec3f_t() {
    _clean_up();
}

void bwm_t::vec3f_t::_clean_up() {
}

bwm_t::vertices_array_t::vertices_array_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_vertices = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::vertices_array_t::_read() {
    m_vertices = new std::vector<vec3f_t*>();
    const int l_vertices = _root()->data_table_offsets()->vertex_count();
    for (int i = 0; i < l_vertices; i++) {
        m_vertices->push_back(new vec3f_t(m__io, this, m__root));
    }
}

bwm_t::vertices_array_t::~vertices_array_t() {
    _clean_up();
}

void bwm_t::vertices_array_t::_clean_up() {
    if (m_vertices) {
        for (std::vector<vec3f_t*>::iterator it = m_vertices->begin(); it != m_vertices->end(); ++it) {
            delete *it;
        }
        delete m_vertices; m_vertices = 0;
    }
}

bwm_t::walkmesh_properties_t::walkmesh_properties_t(kaitai::kstream* p__io, bwm_t* p__parent, bwm_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_relative_use_position_1 = 0;
    m_relative_use_position_2 = 0;
    m_absolute_use_position_1 = 0;
    m_absolute_use_position_2 = 0;
    m_position = 0;
    f_is_area_walkmesh = false;
    f_is_placeable_or_door = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bwm_t::walkmesh_properties_t::_read() {
    m_walkmesh_type = m__io->read_u4le();
    m_relative_use_position_1 = new vec3f_t(m__io, this, m__root);
    m_relative_use_position_2 = new vec3f_t(m__io, this, m__root);
    m_absolute_use_position_1 = new vec3f_t(m__io, this, m__root);
    m_absolute_use_position_2 = new vec3f_t(m__io, this, m__root);
    m_position = new vec3f_t(m__io, this, m__root);
}

bwm_t::walkmesh_properties_t::~walkmesh_properties_t() {
    _clean_up();
}

void bwm_t::walkmesh_properties_t::_clean_up() {
    if (m_relative_use_position_1) {
        delete m_relative_use_position_1; m_relative_use_position_1 = 0;
    }
    if (m_relative_use_position_2) {
        delete m_relative_use_position_2; m_relative_use_position_2 = 0;
    }
    if (m_absolute_use_position_1) {
        delete m_absolute_use_position_1; m_absolute_use_position_1 = 0;
    }
    if (m_absolute_use_position_2) {
        delete m_absolute_use_position_2; m_absolute_use_position_2 = 0;
    }
    if (m_position) {
        delete m_position; m_position = 0;
    }
}

bool bwm_t::walkmesh_properties_t::is_area_walkmesh() {
    if (f_is_area_walkmesh)
        return m_is_area_walkmesh;
    f_is_area_walkmesh = true;
    m_is_area_walkmesh = walkmesh_type() == 1;
    return m_is_area_walkmesh;
}

bool bwm_t::walkmesh_properties_t::is_placeable_or_door() {
    if (f_is_placeable_or_door)
        return m_is_placeable_or_door;
    f_is_placeable_or_door = true;
    m_is_placeable_or_door = walkmesh_type() == 0;
    return m_is_placeable_or_door;
}

bwm_t::aabb_nodes_array_t* bwm_t::aabb_nodes() {
    if (f_aabb_nodes)
        return m_aabb_nodes;
    f_aabb_nodes = true;
    n_aabb_nodes = true;
    if ( ((_root()->walkmesh_properties()->walkmesh_type() == 1) && (_root()->data_table_offsets()->aabb_count() > 0)) ) {
        n_aabb_nodes = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->data_table_offsets()->aabb_offset());
        m_aabb_nodes = new aabb_nodes_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_aabb_nodes;
}

bwm_t::adjacencies_array_t* bwm_t::adjacencies() {
    if (f_adjacencies)
        return m_adjacencies;
    f_adjacencies = true;
    n_adjacencies = true;
    if ( ((_root()->walkmesh_properties()->walkmesh_type() == 1) && (_root()->data_table_offsets()->adjacency_count() > 0)) ) {
        n_adjacencies = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->data_table_offsets()->adjacency_offset());
        m_adjacencies = new adjacencies_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_adjacencies;
}

bwm_t::edges_array_t* bwm_t::edges() {
    if (f_edges)
        return m_edges;
    f_edges = true;
    n_edges = true;
    if ( ((_root()->walkmesh_properties()->walkmesh_type() == 1) && (_root()->data_table_offsets()->edge_count() > 0)) ) {
        n_edges = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->data_table_offsets()->edge_offset());
        m_edges = new edges_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_edges;
}

bwm_t::face_indices_array_t* bwm_t::face_indices() {
    if (f_face_indices)
        return m_face_indices;
    f_face_indices = true;
    n_face_indices = true;
    if (_root()->data_table_offsets()->face_count() > 0) {
        n_face_indices = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->data_table_offsets()->face_indices_offset());
        m_face_indices = new face_indices_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_face_indices;
}

bwm_t::materials_array_t* bwm_t::materials() {
    if (f_materials)
        return m_materials;
    f_materials = true;
    n_materials = true;
    if (_root()->data_table_offsets()->face_count() > 0) {
        n_materials = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->data_table_offsets()->materials_offset());
        m_materials = new materials_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_materials;
}

bwm_t::normals_array_t* bwm_t::normals() {
    if (f_normals)
        return m_normals;
    f_normals = true;
    n_normals = true;
    if ( ((_root()->walkmesh_properties()->walkmesh_type() == 1) && (_root()->data_table_offsets()->face_count() > 0)) ) {
        n_normals = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->data_table_offsets()->normals_offset());
        m_normals = new normals_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_normals;
}

bwm_t::perimeters_array_t* bwm_t::perimeters() {
    if (f_perimeters)
        return m_perimeters;
    f_perimeters = true;
    n_perimeters = true;
    if ( ((_root()->walkmesh_properties()->walkmesh_type() == 1) && (_root()->data_table_offsets()->perimeter_count() > 0)) ) {
        n_perimeters = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->data_table_offsets()->perimeter_offset());
        m_perimeters = new perimeters_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_perimeters;
}

bwm_t::planar_distances_array_t* bwm_t::planar_distances() {
    if (f_planar_distances)
        return m_planar_distances;
    f_planar_distances = true;
    n_planar_distances = true;
    if ( ((_root()->walkmesh_properties()->walkmesh_type() == 1) && (_root()->data_table_offsets()->face_count() > 0)) ) {
        n_planar_distances = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->data_table_offsets()->distances_offset());
        m_planar_distances = new planar_distances_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_planar_distances;
}

bwm_t::vertices_array_t* bwm_t::vertices() {
    if (f_vertices)
        return m_vertices;
    f_vertices = true;
    n_vertices = true;
    if (_root()->data_table_offsets()->vertex_count() > 0) {
        n_vertices = false;
        std::streampos _pos = m__io->pos();
        m__io->seek(_root()->data_table_offsets()->vertex_offset());
        m_vertices = new vertices_array_t(m__io, this, m__root);
        m__io->seek(_pos);
    }
    return m_vertices;
}
