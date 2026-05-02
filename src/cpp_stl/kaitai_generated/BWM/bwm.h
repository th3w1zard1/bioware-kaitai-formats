#ifndef BWM_H_
#define BWM_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bwm_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * BWM (Binary WalkMesh) files define walkable surfaces for pathfinding and collision detection
 * in Knights of the Old Republic (KotOR) games. BWM files are stored on disk with different
 * extensions depending on their type:
 * 
 * - WOK: Area walkmesh files (walkmesh_type = 1) - defines walkable regions in game areas
 * - PWK: Placeable walkmesh files (walkmesh_type = 0) - collision geometry for containers, furniture
 * - DWK: Door walkmesh files (walkmesh_type = 0) - collision geometry for doors in various states
 * 
 * The format uses a header-based structure where offsets point to various data tables, allowing
 * efficient random access to vertices, faces, materials, and acceleration structures.
 * 
 * Binary Format Structure:
 * - File Header (8 bytes): Magic "BWM " and version "V1.0"
 * - Walkmesh Properties (52 bytes): Type, hook vectors, position
 * - Data Table Offsets (84 bytes): Counts and offsets for all data tables
 * - Vertices Array: Array of float3 (x, y, z) per vertex
 * - Face Indices Array: Array of uint32 triplets (vertex indices per face)
 * - Materials Array: Array of uint32 (SurfaceMaterial ID per face)
 * - Normals Array: Array of float3 (face normal per face) - WOK only
 * - Planar Distances Array: Array of float32 (per face) - WOK only
 * - AABB Nodes Array: Array of AABB structures (WOK only)
 * - Adjacencies Array: Array of int32 triplets (WOK only, -1 for no neighbor)
 * - Edges Array: Array of (edge_index, transition) pairs (WOK only)
 * - Perimeters Array: Array of edge indices (WOK only)
 * 
 * Authoritative cross-implementations (pinned paths and line bands): see `meta.xref` and `doc-ref`.
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no BWM-specific tool)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm PyKotor wiki — BWM
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L56-L110 PyKotor — Kaitai-backed BWM struct load
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L187-L253 PyKotor — BWMBinaryReader.load
 * \sa https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L42-L113 xoreos — WalkmeshLoader::load
 * \sa https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L119-L216 xoreos — WalkmeshLoader (append tables / WOK-only paths)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L218-L249 xoreos — WalkmeshLoader::getAABB
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L27-L92 reone — BwmReader::load
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L94-L171 reone — BwmReader (AABB / adjacency tables)
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L301-L395 KotOR.js — readBinary
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L490-L516 KotOR.js — header / version constants
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (no dedicated BWM / walkmesh Torlack page; use engine + PyKotor xrefs above)
 */

class bwm_t : public kaitai::kstruct {

public:
    class aabb_node_t;
    class aabb_nodes_array_t;
    class adjacencies_array_t;
    class adjacency_triplet_t;
    class bwm_header_t;
    class data_table_offsets_t;
    class edge_entry_t;
    class edges_array_t;
    class face_indices_t;
    class face_indices_array_t;
    class materials_array_t;
    class normals_array_t;
    class perimeters_array_t;
    class planar_distances_array_t;
    class vec3f_t;
    class vertices_array_t;
    class walkmesh_properties_t;

    bwm_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bwm_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bwm_t();

    class aabb_node_t : public kaitai::kstruct {

    public:

        aabb_node_t(kaitai::kstream* p__io, bwm_t::aabb_nodes_array_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~aabb_node_t();

    private:
        bool f_has_left_child;
        bool m_has_left_child;

    public:

        /**
         * True if this node has a left child
         */
        bool has_left_child();

    private:
        bool f_has_right_child;
        bool m_has_right_child;

    public:

        /**
         * True if this node has a right child
         */
        bool has_right_child();

    private:
        bool f_is_internal_node;
        bool m_is_internal_node;

    public:

        /**
         * True if this is an internal node (has children), false if leaf node
         */
        bool is_internal_node();

    private:
        bool f_is_leaf_node;
        bool m_is_leaf_node;

    public:

        /**
         * True if this is a leaf node (contains a face), false if internal node
         */
        bool is_leaf_node();

    private:
        vec3f_t* m_bounds_min;
        vec3f_t* m_bounds_max;
        int32_t m_face_index;
        uint32_t m_unknown;
        uint32_t m_most_significant_plane;
        uint32_t m_left_child_index;
        uint32_t m_right_child_index;
        bwm_t* m__root;
        bwm_t::aabb_nodes_array_t* m__parent;

    public:

        /**
         * Minimum bounding box coordinates (x, y, z).
         * Defines the lower corner of the axis-aligned bounding box.
         */
        vec3f_t* bounds_min() const { return m_bounds_min; }

        /**
         * Maximum bounding box coordinates (x, y, z).
         * Defines the upper corner of the axis-aligned bounding box.
         */
        vec3f_t* bounds_max() const { return m_bounds_max; }

        /**
         * Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
         * Leaf nodes contain a single face, internal nodes contain child nodes.
         */
        int32_t face_index() const { return m_face_index; }

        /**
         * Unknown field (typically 4).
         * Purpose is undocumented but appears in all AABB nodes.
         */
        uint32_t unknown() const { return m_unknown; }

        /**
         * Split axis/plane identifier:
         * - 0x00 = No children (leaf node)
         * - 0x01 = Positive X axis split
         * - 0x02 = Positive Y axis split
         * - 0x03 = Positive Z axis split
         * - 0xFFFFFFFE (-2) = Negative X axis split
         * - 0xFFFFFFFD (-3) = Negative Y axis split
         * - 0xFFFFFFFC (-4) = Negative Z axis split
         */
        uint32_t most_significant_plane() const { return m_most_significant_plane; }

        /**
         * Index to left child node (0-based array index).
         * 0xFFFFFFFF indicates no left child.
         * Child indices are 0-based indices into the AABB nodes array.
         */
        uint32_t left_child_index() const { return m_left_child_index; }

        /**
         * Index to right child node (0-based array index).
         * 0xFFFFFFFF indicates no right child.
         * Child indices are 0-based indices into the AABB nodes array.
         */
        uint32_t right_child_index() const { return m_right_child_index; }
        bwm_t* _root() const { return m__root; }
        bwm_t::aabb_nodes_array_t* _parent() const { return m__parent; }
    };

    class aabb_nodes_array_t : public kaitai::kstruct {

    public:

        aabb_nodes_array_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~aabb_nodes_array_t();

    private:
        std::vector<aabb_node_t*>* m_nodes;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Array of AABB tree nodes for spatial acceleration (WOK only).
         * AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).
         */
        std::vector<aabb_node_t*>* nodes() const { return m_nodes; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class adjacencies_array_t : public kaitai::kstruct {

    public:

        adjacencies_array_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~adjacencies_array_t();

    private:
        std::vector<adjacency_triplet_t*>* m_adjacencies;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Array of adjacency triplets, one per walkable face (WOK only).
         * Each walkable face has exactly three adjacency entries, one for each edge.
         * Adjacency count equals the number of walkable faces, not the total face count.
         */
        std::vector<adjacency_triplet_t*>* adjacencies() const { return m_adjacencies; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class adjacency_triplet_t : public kaitai::kstruct {

    public:

        adjacency_triplet_t(kaitai::kstream* p__io, bwm_t::adjacencies_array_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~adjacency_triplet_t();

    private:
        bool f_edge_0_face_index;
        int32_t m_edge_0_face_index;

    public:

        /**
         * Face index of adjacent face for edge 0 (decoded from adjacency index)
         */
        int32_t edge_0_face_index();

    private:
        bool f_edge_0_has_neighbor;
        bool m_edge_0_has_neighbor;

    public:

        /**
         * True if edge 0 has an adjacent walkable face
         */
        bool edge_0_has_neighbor();

    private:
        bool f_edge_0_local_edge;
        int32_t m_edge_0_local_edge;

    public:

        /**
         * Local edge index (0, 1, or 2) of adjacent face for edge 0
         */
        int32_t edge_0_local_edge();

    private:
        bool f_edge_1_face_index;
        int32_t m_edge_1_face_index;

    public:

        /**
         * Face index of adjacent face for edge 1 (decoded from adjacency index)
         */
        int32_t edge_1_face_index();

    private:
        bool f_edge_1_has_neighbor;
        bool m_edge_1_has_neighbor;

    public:

        /**
         * True if edge 1 has an adjacent walkable face
         */
        bool edge_1_has_neighbor();

    private:
        bool f_edge_1_local_edge;
        int32_t m_edge_1_local_edge;

    public:

        /**
         * Local edge index (0, 1, or 2) of adjacent face for edge 1
         */
        int32_t edge_1_local_edge();

    private:
        bool f_edge_2_face_index;
        int32_t m_edge_2_face_index;

    public:

        /**
         * Face index of adjacent face for edge 2 (decoded from adjacency index)
         */
        int32_t edge_2_face_index();

    private:
        bool f_edge_2_has_neighbor;
        bool m_edge_2_has_neighbor;

    public:

        /**
         * True if edge 2 has an adjacent walkable face
         */
        bool edge_2_has_neighbor();

    private:
        bool f_edge_2_local_edge;
        int32_t m_edge_2_local_edge;

    public:

        /**
         * Local edge index (0, 1, or 2) of adjacent face for edge 2
         */
        int32_t edge_2_local_edge();

    private:
        int32_t m_edge_0_adjacency;
        int32_t m_edge_1_adjacency;
        int32_t m_edge_2_adjacency;
        bwm_t* m__root;
        bwm_t::adjacencies_array_t* m__parent;

    public:

        /**
         * Adjacency index for edge 0 (between v1 and v2).
         * Encoding: face_index * 3 + edge_index
         * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
         */
        int32_t edge_0_adjacency() const { return m_edge_0_adjacency; }

        /**
         * Adjacency index for edge 1 (between v2 and v3).
         * Encoding: face_index * 3 + edge_index
         * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
         */
        int32_t edge_1_adjacency() const { return m_edge_1_adjacency; }

        /**
         * Adjacency index for edge 2 (between v3 and v1).
         * Encoding: face_index * 3 + edge_index
         * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
         */
        int32_t edge_2_adjacency() const { return m_edge_2_adjacency; }
        bwm_t* _root() const { return m__root; }
        bwm_t::adjacencies_array_t* _parent() const { return m__parent; }
    };

    class bwm_header_t : public kaitai::kstruct {

    public:

        bwm_header_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bwm_header_t();

    private:
        bool f_is_valid_bwm;
        bool m_is_valid_bwm;

    public:

        /**
         * Validation check that the file is a valid BWM file.
         * Both magic and version must match expected values.
         */
        bool is_valid_bwm();

    private:
        std::string m_magic;
        std::string m_version;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * File type signature. Must be "BWM " (space-padded).
         * The space after "BWM" is significant and must be present.
         */
        std::string magic() const { return m_magic; }

        /**
         * File format version. Always "V1.0" for KotOR BWM files.
         * This is the first and only version of the BWM format used in KotOR games.
         */
        std::string version() const { return m_version; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class data_table_offsets_t : public kaitai::kstruct {

    public:

        data_table_offsets_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~data_table_offsets_t();

    private:
        uint32_t m_vertex_count;
        uint32_t m_vertex_offset;
        uint32_t m_face_count;
        uint32_t m_face_indices_offset;
        uint32_t m_materials_offset;
        uint32_t m_normals_offset;
        uint32_t m_distances_offset;
        uint32_t m_aabb_count;
        uint32_t m_aabb_offset;
        uint32_t m_unknown;
        uint32_t m_adjacency_count;
        uint32_t m_adjacency_offset;
        uint32_t m_edge_count;
        uint32_t m_edge_offset;
        uint32_t m_perimeter_count;
        uint32_t m_perimeter_offset;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Number of vertices in the walkmesh
         */
        uint32_t vertex_count() const { return m_vertex_count; }

        /**
         * Byte offset to vertex array from the beginning of the file
         */
        uint32_t vertex_offset() const { return m_vertex_offset; }

        /**
         * Number of faces (triangles) in the walkmesh
         */
        uint32_t face_count() const { return m_face_count; }

        /**
         * Byte offset to face indices array from the beginning of the file
         */
        uint32_t face_indices_offset() const { return m_face_indices_offset; }

        /**
         * Byte offset to materials array from the beginning of the file
         */
        uint32_t materials_offset() const { return m_materials_offset; }

        /**
         * Byte offset to face normals array from the beginning of the file.
         * Only used for WOK files (area walkmeshes).
         */
        uint32_t normals_offset() const { return m_normals_offset; }

        /**
         * Byte offset to planar distances array from the beginning of the file.
         * Only used for WOK files (area walkmeshes).
         */
        uint32_t distances_offset() const { return m_distances_offset; }

        /**
         * Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
         * AABB trees provide spatial acceleration for raycasting and point queries.
         */
        uint32_t aabb_count() const { return m_aabb_count; }

        /**
         * Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
         * Only present if aabb_count > 0.
         */
        uint32_t aabb_offset() const { return m_aabb_offset; }

        /**
         * Unknown field (typically 0 or 4).
         * Purpose is undocumented but appears in all BWM files.
         */
        uint32_t unknown() const { return m_unknown; }

        /**
         * Number of walkable faces for adjacency data (WOK only).
         * This equals the number of walkable faces, not the total face count.
         * Adjacencies are stored only for walkable faces.
         */
        uint32_t adjacency_count() const { return m_adjacency_count; }

        /**
         * Byte offset to adjacency array from the beginning of the file (WOK only).
         * Only present if adjacency_count > 0.
         */
        uint32_t adjacency_offset() const { return m_adjacency_offset; }

        /**
         * Number of perimeter edges (WOK only).
         * Perimeter edges are boundary edges with no walkable neighbor.
         */
        uint32_t edge_count() const { return m_edge_count; }

        /**
         * Byte offset to edges array from the beginning of the file (WOK only).
         * Only present if edge_count > 0.
         */
        uint32_t edge_offset() const { return m_edge_offset; }

        /**
         * Number of perimeter markers (WOK only).
         * Perimeter markers indicate the end of closed loops of perimeter edges.
         */
        uint32_t perimeter_count() const { return m_perimeter_count; }

        /**
         * Byte offset to perimeters array from the beginning of the file (WOK only).
         * Only present if perimeter_count > 0.
         */
        uint32_t perimeter_offset() const { return m_perimeter_offset; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class edge_entry_t : public kaitai::kstruct {

    public:

        edge_entry_t(kaitai::kstream* p__io, bwm_t::edges_array_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~edge_entry_t();

    private:
        bool f_face_index;
        int32_t m_face_index;

    public:

        /**
         * Face index that this edge belongs to (decoded from edge_index)
         */
        int32_t face_index();

    private:
        bool f_has_transition;
        bool m_has_transition;

    public:

        /**
         * True if this edge has a transition ID (links to door/area connection)
         */
        bool has_transition();

    private:
        bool f_local_edge_index;
        int32_t m_local_edge_index;

    public:

        /**
         * Local edge index (0, 1, or 2) within the face (decoded from edge_index)
         */
        int32_t local_edge_index();

    private:
        uint32_t m_edge_index;
        int32_t m_transition;
        bwm_t* m__root;
        bwm_t::edges_array_t* m__parent;

    public:

        /**
         * Encoded edge index: face_index * 3 + local_edge_index
         * Identifies which face and which edge (0, 1, or 2) of that face.
         * Edge 0: between v1 and v2
         * Edge 1: between v2 and v3
         * Edge 2: between v3 and v1
         */
        uint32_t edge_index() const { return m_edge_index; }

        /**
         * Transition ID for room/area connections, -1 if no transition.
         * Non-negative values reference door connections or area boundaries.
         * -1 indicates this is just a boundary edge with no transition.
         */
        int32_t transition() const { return m_transition; }
        bwm_t* _root() const { return m__root; }
        bwm_t::edges_array_t* _parent() const { return m__parent; }
    };

    class edges_array_t : public kaitai::kstruct {

    public:

        edges_array_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~edges_array_t();

    private:
        std::vector<edge_entry_t*>* m_edges;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Array of perimeter edges (WOK only).
         * Perimeter edges are boundary edges with no walkable neighbor.
         * Each edge entry contains an edge index and optional transition ID.
         */
        std::vector<edge_entry_t*>* edges() const { return m_edges; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class face_indices_t : public kaitai::kstruct {

    public:

        face_indices_t(kaitai::kstream* p__io, bwm_t::face_indices_array_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~face_indices_t();

    private:
        uint32_t m_v1_index;
        uint32_t m_v2_index;
        uint32_t m_v3_index;
        bwm_t* m__root;
        bwm_t::face_indices_array_t* m__parent;

    public:

        /**
         * Vertex index for first vertex of triangle (0-based index into vertices array).
         * Vertex indices define the triangle's vertices in counter-clockwise order
         * when viewed from the front (the side the normal points toward).
         */
        uint32_t v1_index() const { return m_v1_index; }

        /**
         * Vertex index for second vertex of triangle (0-based index into vertices array).
         */
        uint32_t v2_index() const { return m_v2_index; }

        /**
         * Vertex index for third vertex of triangle (0-based index into vertices array).
         */
        uint32_t v3_index() const { return m_v3_index; }
        bwm_t* _root() const { return m__root; }
        bwm_t::face_indices_array_t* _parent() const { return m__parent; }
    };

    class face_indices_array_t : public kaitai::kstruct {

    public:

        face_indices_array_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~face_indices_array_t();

    private:
        std::vector<face_indices_t*>* m_faces;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Array of face vertex index triplets
         */
        std::vector<face_indices_t*>* faces() const { return m_faces; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class materials_array_t : public kaitai::kstruct {

    public:

        materials_array_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~materials_array_t();

    private:
        std::vector<uint32_t>* m_materials;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Array of surface material IDs, one per face.
         * Material IDs determine walkability and physical properties:
         * - 0 = NotDefined/UNDEFINED (non-walkable)
         * - 1 = Dirt (walkable)
         * - 2 = Obscuring (non-walkable, blocks line of sight)
         * - 3 = Grass (walkable)
         * - 4 = Stone (walkable)
         * - 5 = Wood (walkable)
         * - 6 = Water (walkable)
         * - 7 = Nonwalk/NON_WALK (non-walkable)
         * - 8 = Transparent (non-walkable)
         * - 9 = Carpet (walkable)
         * - 10 = Metal (walkable)
         * - 11 = Puddles (walkable)
         * - 12 = Swamp (walkable)
         * - 13 = Mud (walkable)
         * - 14 = Leaves (walkable)
         * - 15 = Lava (non-walkable, damage-dealing)
         * - 16 = BottomlessPit (walkable but dangerous)
         * - 17 = DeepWater (non-walkable)
         * - 18 = Door (walkable, special handling)
         * - 19 = Snow/NON_WALK_GRASS (non-walkable)
         * - 20+ = Additional materials (Sand, BareBones, StoneBridge, etc.)
         */
        std::vector<uint32_t>* materials() const { return m_materials; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class normals_array_t : public kaitai::kstruct {

    public:

        normals_array_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~normals_array_t();

    private:
        std::vector<vec3f_t*>* m_normals;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Array of face normal vectors, one per face (WOK only).
         * Normals are precomputed unit vectors perpendicular to each face.
         * Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
         * Normal direction follows right-hand rule based on vertex winding order.
         */
        std::vector<vec3f_t*>* normals() const { return m_normals; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class perimeters_array_t : public kaitai::kstruct {

    public:

        perimeters_array_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~perimeters_array_t();

    private:
        std::vector<uint32_t>* m_perimeters;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Array of perimeter markers (WOK only).
         * Each value is an index into the edges array, marking the end of a perimeter loop.
         * Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
         * Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.
         */
        std::vector<uint32_t>* perimeters() const { return m_perimeters; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class planar_distances_array_t : public kaitai::kstruct {

    public:

        planar_distances_array_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~planar_distances_array_t();

    private:
        std::vector<float>* m_distances;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Array of planar distances, one per face (WOK only).
         * The D component of the plane equation ax + by + cz + d = 0.
         * Calculated as d = -normal · vertex1 for each face.
         * Precomputed to allow quick point-plane relationship tests.
         */
        std::vector<float>* distances() const { return m_distances; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class vec3f_t : public kaitai::kstruct {

    public:

        vec3f_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~vec3f_t();

    private:
        float m_x;
        float m_y;
        float m_z;
        bwm_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * X coordinate (float32)
         */
        float x() const { return m_x; }

        /**
         * Y coordinate (float32)
         */
        float y() const { return m_y; }

        /**
         * Z coordinate (float32)
         */
        float z() const { return m_z; }
        bwm_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    class vertices_array_t : public kaitai::kstruct {

    public:

        vertices_array_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~vertices_array_t();

    private:
        std::vector<vec3f_t*>* m_vertices;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Array of vertex positions, each vertex is a float3 (x, y, z)
         */
        std::vector<vec3f_t*>* vertices() const { return m_vertices; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

    class walkmesh_properties_t : public kaitai::kstruct {

    public:

        walkmesh_properties_t(kaitai::kstream* p__io, bwm_t* p__parent = 0, bwm_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~walkmesh_properties_t();

    private:
        bool f_is_area_walkmesh;
        bool m_is_area_walkmesh;

    public:

        /**
         * True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)
         */
        bool is_area_walkmesh();

    private:
        bool f_is_placeable_or_door;
        bool m_is_placeable_or_door;

    public:

        /**
         * True if this is a placeable or door walkmesh (PWK/DWK)
         */
        bool is_placeable_or_door();

    private:
        uint32_t m_walkmesh_type;
        vec3f_t* m_relative_use_position_1;
        vec3f_t* m_relative_use_position_2;
        vec3f_t* m_absolute_use_position_1;
        vec3f_t* m_absolute_use_position_2;
        vec3f_t* m_position;
        bwm_t* m__root;
        bwm_t* m__parent;

    public:

        /**
         * Walkmesh type identifier:
         * - 0 = PWK/DWK (Placeable/Door walkmesh)
         * - 1 = WOK (Area walkmesh)
         */
        uint32_t walkmesh_type() const { return m_walkmesh_type; }

        /**
         * Relative use hook position 1 (x, y, z).
         * Position relative to the walkmesh origin, used when the walkmesh may be transformed.
         * For doors: Defines where the player must stand to interact (relative to door model).
         * For placeables: Defines interaction points relative to the object's local coordinate system.
         */
        vec3f_t* relative_use_position_1() const { return m_relative_use_position_1; }

        /**
         * Relative use hook position 2 (x, y, z).
         * Second interaction point relative to the walkmesh origin.
         */
        vec3f_t* relative_use_position_2() const { return m_relative_use_position_2; }

        /**
         * Absolute use hook position 1 (x, y, z).
         * Position in world space, used when the walkmesh position is known.
         * For doors: Precomputed world-space interaction points (position + relative hook).
         * For placeables: World-space interaction points accounting for object placement.
         */
        vec3f_t* absolute_use_position_1() const { return m_absolute_use_position_1; }

        /**
         * Absolute use hook position 2 (x, y, z).
         * Second absolute interaction point in world space.
         */
        vec3f_t* absolute_use_position_2() const { return m_absolute_use_position_2; }

        /**
         * Walkmesh position offset (x, y, z) in world space.
         * For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
         * For placeable/door walkmeshes: The position where the object is placed in the area.
         * Used to transform vertices from local to world coordinates.
         */
        vec3f_t* position() const { return m_position; }
        bwm_t* _root() const { return m__root; }
        bwm_t* _parent() const { return m__parent; }
    };

private:
    bool f_aabb_nodes;
    aabb_nodes_array_t* m_aabb_nodes;
    bool n_aabb_nodes;

public:
    bool _is_null_aabb_nodes() { aabb_nodes(); return n_aabb_nodes; };

private:

public:

    /**
     * Array of AABB tree nodes for spatial acceleration - WOK only
     */
    aabb_nodes_array_t* aabb_nodes();

private:
    bool f_adjacencies;
    adjacencies_array_t* m_adjacencies;
    bool n_adjacencies;

public:
    bool _is_null_adjacencies() { adjacencies(); return n_adjacencies; };

private:

public:

    /**
     * Array of adjacency indices (int32 triplets per walkable face) - WOK only
     */
    adjacencies_array_t* adjacencies();

private:
    bool f_edges;
    edges_array_t* m_edges;
    bool n_edges;

public:
    bool _is_null_edges() { edges(); return n_edges; };

private:

public:

    /**
     * Array of perimeter edges (edge_index, transition pairs) - WOK only
     */
    edges_array_t* edges();

private:
    bool f_face_indices;
    face_indices_array_t* m_face_indices;
    bool n_face_indices;

public:
    bool _is_null_face_indices() { face_indices(); return n_face_indices; };

private:

public:

    /**
     * Array of face vertex indices (uint32 triplets)
     */
    face_indices_array_t* face_indices();

private:
    bool f_materials;
    materials_array_t* m_materials;
    bool n_materials;

public:
    bool _is_null_materials() { materials(); return n_materials; };

private:

public:

    /**
     * Array of surface material IDs per face
     */
    materials_array_t* materials();

private:
    bool f_normals;
    normals_array_t* m_normals;
    bool n_normals;

public:
    bool _is_null_normals() { normals(); return n_normals; };

private:

public:

    /**
     * Array of face normal vectors (float3 triplets) - WOK only
     */
    normals_array_t* normals();

private:
    bool f_perimeters;
    perimeters_array_t* m_perimeters;
    bool n_perimeters;

public:
    bool _is_null_perimeters() { perimeters(); return n_perimeters; };

private:

public:

    /**
     * Array of perimeter markers (edge indices marking end of loops) - WOK only
     */
    perimeters_array_t* perimeters();

private:
    bool f_planar_distances;
    planar_distances_array_t* m_planar_distances;
    bool n_planar_distances;

public:
    bool _is_null_planar_distances() { planar_distances(); return n_planar_distances; };

private:

public:

    /**
     * Array of planar distances (float32 per face) - WOK only
     */
    planar_distances_array_t* planar_distances();

private:
    bool f_vertices;
    vertices_array_t* m_vertices;
    bool n_vertices;

public:
    bool _is_null_vertices() { vertices(); return n_vertices; };

private:

public:

    /**
     * Array of vertex positions (float3 triplets)
     */
    vertices_array_t* vertices();

private:
    bwm_header_t* m_header;
    walkmesh_properties_t* m_walkmesh_properties;
    data_table_offsets_t* m_data_table_offsets;
    bwm_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * BWM file header (8 bytes) - magic and version signature
     */
    bwm_header_t* header() const { return m_header; }

    /**
     * Walkmesh properties section (52 bytes) - type, hooks, position
     */
    walkmesh_properties_t* walkmesh_properties() const { return m_walkmesh_properties; }

    /**
     * Data table offsets section (84 bytes) - counts and offsets for all data tables
     */
    data_table_offsets_t* data_table_offsets() const { return m_data_table_offsets; }
    bwm_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BWM_H_
