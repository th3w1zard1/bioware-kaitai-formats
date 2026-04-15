<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

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
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm
 * - https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/bwmreader.cpp:27-171
 * - https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp:73-248
 * - https://github.com/KotOR-Community-Patches/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts:452-473
 */

namespace {
    class Bwm extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Bwm\BwmHeader($this->_io, $this, $this->_root);
            $this->_m_walkmeshProperties = new \Bwm\WalkmeshProperties($this->_io, $this, $this->_root);
            $this->_m_dataTableOffsets = new \Bwm\DataTableOffsets($this->_io, $this, $this->_root);
        }
        protected $_m_aabbNodes;

        /**
         * Array of AABB tree nodes for spatial acceleration - WOK only
         */
        public function aabbNodes() {
            if ($this->_m_aabbNodes !== null)
                return $this->_m_aabbNodes;
            if ( (($this->_root()->walkmeshProperties()->walkmeshType() == 1) && ($this->_root()->dataTableOffsets()->aabbCount() > 0)) ) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->dataTableOffsets()->aabbOffset());
                $this->_m_aabbNodes = new \Bwm\AabbNodesArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_aabbNodes;
        }
        protected $_m_adjacencies;

        /**
         * Array of adjacency indices (int32 triplets per walkable face) - WOK only
         */
        public function adjacencies() {
            if ($this->_m_adjacencies !== null)
                return $this->_m_adjacencies;
            if ( (($this->_root()->walkmeshProperties()->walkmeshType() == 1) && ($this->_root()->dataTableOffsets()->adjacencyCount() > 0)) ) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->dataTableOffsets()->adjacencyOffset());
                $this->_m_adjacencies = new \Bwm\AdjacenciesArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_adjacencies;
        }
        protected $_m_edges;

        /**
         * Array of perimeter edges (edge_index, transition pairs) - WOK only
         */
        public function edges() {
            if ($this->_m_edges !== null)
                return $this->_m_edges;
            if ( (($this->_root()->walkmeshProperties()->walkmeshType() == 1) && ($this->_root()->dataTableOffsets()->edgeCount() > 0)) ) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->dataTableOffsets()->edgeOffset());
                $this->_m_edges = new \Bwm\EdgesArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_edges;
        }
        protected $_m_faceIndices;

        /**
         * Array of face vertex indices (uint32 triplets)
         */
        public function faceIndices() {
            if ($this->_m_faceIndices !== null)
                return $this->_m_faceIndices;
            if ($this->_root()->dataTableOffsets()->faceCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->dataTableOffsets()->faceIndicesOffset());
                $this->_m_faceIndices = new \Bwm\FaceIndicesArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_faceIndices;
        }
        protected $_m_materials;

        /**
         * Array of surface material IDs per face
         */
        public function materials() {
            if ($this->_m_materials !== null)
                return $this->_m_materials;
            if ($this->_root()->dataTableOffsets()->faceCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->dataTableOffsets()->materialsOffset());
                $this->_m_materials = new \Bwm\MaterialsArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_materials;
        }
        protected $_m_normals;

        /**
         * Array of face normal vectors (float3 triplets) - WOK only
         */
        public function normals() {
            if ($this->_m_normals !== null)
                return $this->_m_normals;
            if ( (($this->_root()->walkmeshProperties()->walkmeshType() == 1) && ($this->_root()->dataTableOffsets()->faceCount() > 0)) ) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->dataTableOffsets()->normalsOffset());
                $this->_m_normals = new \Bwm\NormalsArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_normals;
        }
        protected $_m_perimeters;

        /**
         * Array of perimeter markers (edge indices marking end of loops) - WOK only
         */
        public function perimeters() {
            if ($this->_m_perimeters !== null)
                return $this->_m_perimeters;
            if ( (($this->_root()->walkmeshProperties()->walkmeshType() == 1) && ($this->_root()->dataTableOffsets()->perimeterCount() > 0)) ) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->dataTableOffsets()->perimeterOffset());
                $this->_m_perimeters = new \Bwm\PerimetersArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_perimeters;
        }
        protected $_m_planarDistances;

        /**
         * Array of planar distances (float32 per face) - WOK only
         */
        public function planarDistances() {
            if ($this->_m_planarDistances !== null)
                return $this->_m_planarDistances;
            if ( (($this->_root()->walkmeshProperties()->walkmeshType() == 1) && ($this->_root()->dataTableOffsets()->faceCount() > 0)) ) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->dataTableOffsets()->distancesOffset());
                $this->_m_planarDistances = new \Bwm\PlanarDistancesArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_planarDistances;
        }
        protected $_m_vertices;

        /**
         * Array of vertex positions (float3 triplets)
         */
        public function vertices() {
            if ($this->_m_vertices !== null)
                return $this->_m_vertices;
            if ($this->_root()->dataTableOffsets()->vertexCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->_root()->dataTableOffsets()->vertexOffset());
                $this->_m_vertices = new \Bwm\VerticesArray($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_vertices;
        }
        protected $_m_header;
        protected $_m_walkmeshProperties;
        protected $_m_dataTableOffsets;

        /**
         * BWM file header (8 bytes) - magic and version signature
         */
        public function header() { return $this->_m_header; }

        /**
         * Walkmesh properties section (52 bytes) - type, hooks, position
         */
        public function walkmeshProperties() { return $this->_m_walkmeshProperties; }

        /**
         * Data table offsets section (84 bytes) - counts and offsets for all data tables
         */
        public function dataTableOffsets() { return $this->_m_dataTableOffsets; }
    }
}

namespace Bwm {
    class AabbNode extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm\AabbNodesArray $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_boundsMin = new \Bwm\Vec3f($this->_io, $this, $this->_root);
            $this->_m_boundsMax = new \Bwm\Vec3f($this->_io, $this, $this->_root);
            $this->_m_faceIndex = $this->_io->readS4le();
            $this->_m_unknown = $this->_io->readU4le();
            $this->_m_mostSignificantPlane = $this->_io->readU4le();
            $this->_m_leftChildIndex = $this->_io->readU4le();
            $this->_m_rightChildIndex = $this->_io->readU4le();
        }
        protected $_m_hasLeftChild;

        /**
         * True if this node has a left child
         */
        public function hasLeftChild() {
            if ($this->_m_hasLeftChild !== null)
                return $this->_m_hasLeftChild;
            $this->_m_hasLeftChild = $this->leftChildIndex() != 4294967295;
            return $this->_m_hasLeftChild;
        }
        protected $_m_hasRightChild;

        /**
         * True if this node has a right child
         */
        public function hasRightChild() {
            if ($this->_m_hasRightChild !== null)
                return $this->_m_hasRightChild;
            $this->_m_hasRightChild = $this->rightChildIndex() != 4294967295;
            return $this->_m_hasRightChild;
        }
        protected $_m_isInternalNode;

        /**
         * True if this is an internal node (has children), false if leaf node
         */
        public function isInternalNode() {
            if ($this->_m_isInternalNode !== null)
                return $this->_m_isInternalNode;
            $this->_m_isInternalNode = $this->faceIndex() == -1;
            return $this->_m_isInternalNode;
        }
        protected $_m_isLeafNode;

        /**
         * True if this is a leaf node (contains a face), false if internal node
         */
        public function isLeafNode() {
            if ($this->_m_isLeafNode !== null)
                return $this->_m_isLeafNode;
            $this->_m_isLeafNode = $this->faceIndex() != -1;
            return $this->_m_isLeafNode;
        }
        protected $_m_boundsMin;
        protected $_m_boundsMax;
        protected $_m_faceIndex;
        protected $_m_unknown;
        protected $_m_mostSignificantPlane;
        protected $_m_leftChildIndex;
        protected $_m_rightChildIndex;

        /**
         * Minimum bounding box coordinates (x, y, z).
         * Defines the lower corner of the axis-aligned bounding box.
         */
        public function boundsMin() { return $this->_m_boundsMin; }

        /**
         * Maximum bounding box coordinates (x, y, z).
         * Defines the upper corner of the axis-aligned bounding box.
         */
        public function boundsMax() { return $this->_m_boundsMax; }

        /**
         * Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
         * Leaf nodes contain a single face, internal nodes contain child nodes.
         */
        public function faceIndex() { return $this->_m_faceIndex; }

        /**
         * Unknown field (typically 4).
         * Purpose is undocumented but appears in all AABB nodes.
         */
        public function unknown() { return $this->_m_unknown; }

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
        public function mostSignificantPlane() { return $this->_m_mostSignificantPlane; }

        /**
         * Index to left child node (0-based array index).
         * 0xFFFFFFFF indicates no left child.
         * Child indices are 0-based indices into the AABB nodes array.
         */
        public function leftChildIndex() { return $this->_m_leftChildIndex; }

        /**
         * Index to right child node (0-based array index).
         * 0xFFFFFFFF indicates no right child.
         * Child indices are 0-based indices into the AABB nodes array.
         */
        public function rightChildIndex() { return $this->_m_rightChildIndex; }
    }
}

namespace Bwm {
    class AabbNodesArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_nodes = [];
            $n = $this->_root()->dataTableOffsets()->aabbCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_nodes[] = new \Bwm\AabbNode($this->_io, $this, $this->_root);
            }
        }
        protected $_m_nodes;

        /**
         * Array of AABB tree nodes for spatial acceleration (WOK only).
         * AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).
         */
        public function nodes() { return $this->_m_nodes; }
    }
}

namespace Bwm {
    class AdjacenciesArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_adjacencies = [];
            $n = $this->_root()->dataTableOffsets()->adjacencyCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_adjacencies[] = new \Bwm\AdjacencyTriplet($this->_io, $this, $this->_root);
            }
        }
        protected $_m_adjacencies;

        /**
         * Array of adjacency triplets, one per walkable face (WOK only).
         * Each walkable face has exactly three adjacency entries, one for each edge.
         * Adjacency count equals the number of walkable faces, not the total face count.
         */
        public function adjacencies() { return $this->_m_adjacencies; }
    }
}

namespace Bwm {
    class AdjacencyTriplet extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm\AdjacenciesArray $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_edge0Adjacency = $this->_io->readS4le();
            $this->_m_edge1Adjacency = $this->_io->readS4le();
            $this->_m_edge2Adjacency = $this->_io->readS4le();
        }
        protected $_m_edge0FaceIndex;

        /**
         * Face index of adjacent face for edge 0 (decoded from adjacency index)
         */
        public function edge0FaceIndex() {
            if ($this->_m_edge0FaceIndex !== null)
                return $this->_m_edge0FaceIndex;
            $this->_m_edge0FaceIndex = ($this->edge0Adjacency() != -1 ? intval($this->edge0Adjacency() / 3) : -1);
            return $this->_m_edge0FaceIndex;
        }
        protected $_m_edge0HasNeighbor;

        /**
         * True if edge 0 has an adjacent walkable face
         */
        public function edge0HasNeighbor() {
            if ($this->_m_edge0HasNeighbor !== null)
                return $this->_m_edge0HasNeighbor;
            $this->_m_edge0HasNeighbor = $this->edge0Adjacency() != -1;
            return $this->_m_edge0HasNeighbor;
        }
        protected $_m_edge0LocalEdge;

        /**
         * Local edge index (0, 1, or 2) of adjacent face for edge 0
         */
        public function edge0LocalEdge() {
            if ($this->_m_edge0LocalEdge !== null)
                return $this->_m_edge0LocalEdge;
            $this->_m_edge0LocalEdge = ($this->edge0Adjacency() != -1 ? \Kaitai\Struct\Stream::mod($this->edge0Adjacency(), 3) : -1);
            return $this->_m_edge0LocalEdge;
        }
        protected $_m_edge1FaceIndex;

        /**
         * Face index of adjacent face for edge 1 (decoded from adjacency index)
         */
        public function edge1FaceIndex() {
            if ($this->_m_edge1FaceIndex !== null)
                return $this->_m_edge1FaceIndex;
            $this->_m_edge1FaceIndex = ($this->edge1Adjacency() != -1 ? intval($this->edge1Adjacency() / 3) : -1);
            return $this->_m_edge1FaceIndex;
        }
        protected $_m_edge1HasNeighbor;

        /**
         * True if edge 1 has an adjacent walkable face
         */
        public function edge1HasNeighbor() {
            if ($this->_m_edge1HasNeighbor !== null)
                return $this->_m_edge1HasNeighbor;
            $this->_m_edge1HasNeighbor = $this->edge1Adjacency() != -1;
            return $this->_m_edge1HasNeighbor;
        }
        protected $_m_edge1LocalEdge;

        /**
         * Local edge index (0, 1, or 2) of adjacent face for edge 1
         */
        public function edge1LocalEdge() {
            if ($this->_m_edge1LocalEdge !== null)
                return $this->_m_edge1LocalEdge;
            $this->_m_edge1LocalEdge = ($this->edge1Adjacency() != -1 ? \Kaitai\Struct\Stream::mod($this->edge1Adjacency(), 3) : -1);
            return $this->_m_edge1LocalEdge;
        }
        protected $_m_edge2FaceIndex;

        /**
         * Face index of adjacent face for edge 2 (decoded from adjacency index)
         */
        public function edge2FaceIndex() {
            if ($this->_m_edge2FaceIndex !== null)
                return $this->_m_edge2FaceIndex;
            $this->_m_edge2FaceIndex = ($this->edge2Adjacency() != -1 ? intval($this->edge2Adjacency() / 3) : -1);
            return $this->_m_edge2FaceIndex;
        }
        protected $_m_edge2HasNeighbor;

        /**
         * True if edge 2 has an adjacent walkable face
         */
        public function edge2HasNeighbor() {
            if ($this->_m_edge2HasNeighbor !== null)
                return $this->_m_edge2HasNeighbor;
            $this->_m_edge2HasNeighbor = $this->edge2Adjacency() != -1;
            return $this->_m_edge2HasNeighbor;
        }
        protected $_m_edge2LocalEdge;

        /**
         * Local edge index (0, 1, or 2) of adjacent face for edge 2
         */
        public function edge2LocalEdge() {
            if ($this->_m_edge2LocalEdge !== null)
                return $this->_m_edge2LocalEdge;
            $this->_m_edge2LocalEdge = ($this->edge2Adjacency() != -1 ? \Kaitai\Struct\Stream::mod($this->edge2Adjacency(), 3) : -1);
            return $this->_m_edge2LocalEdge;
        }
        protected $_m_edge0Adjacency;
        protected $_m_edge1Adjacency;
        protected $_m_edge2Adjacency;

        /**
         * Adjacency index for edge 0 (between v1 and v2).
         * Encoding: face_index * 3 + edge_index
         * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
         */
        public function edge0Adjacency() { return $this->_m_edge0Adjacency; }

        /**
         * Adjacency index for edge 1 (between v2 and v3).
         * Encoding: face_index * 3 + edge_index
         * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
         */
        public function edge1Adjacency() { return $this->_m_edge1Adjacency; }

        /**
         * Adjacency index for edge 2 (between v3 and v1).
         * Encoding: face_index * 3 + edge_index
         * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
         */
        public function edge2Adjacency() { return $this->_m_edge2Adjacency; }
    }
}

namespace Bwm {
    class BwmHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_magic = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_version = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
        }
        protected $_m_isValidBwm;

        /**
         * Validation check that the file is a valid BWM file.
         * Both magic and version must match expected values.
         */
        public function isValidBwm() {
            if ($this->_m_isValidBwm !== null)
                return $this->_m_isValidBwm;
            $this->_m_isValidBwm =  (($this->magic() == "BWM ") && ($this->version() == "V1.0")) ;
            return $this->_m_isValidBwm;
        }
        protected $_m_magic;
        protected $_m_version;

        /**
         * File type signature. Must be "BWM " (space-padded).
         * The space after "BWM" is significant and must be present.
         */
        public function magic() { return $this->_m_magic; }

        /**
         * File format version. Always "V1.0" for KotOR BWM files.
         * This is the first and only version of the BWM format used in KotOR games.
         */
        public function version() { return $this->_m_version; }
    }
}

namespace Bwm {
    class DataTableOffsets extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_vertexCount = $this->_io->readU4le();
            $this->_m_vertexOffset = $this->_io->readU4le();
            $this->_m_faceCount = $this->_io->readU4le();
            $this->_m_faceIndicesOffset = $this->_io->readU4le();
            $this->_m_materialsOffset = $this->_io->readU4le();
            $this->_m_normalsOffset = $this->_io->readU4le();
            $this->_m_distancesOffset = $this->_io->readU4le();
            $this->_m_aabbCount = $this->_io->readU4le();
            $this->_m_aabbOffset = $this->_io->readU4le();
            $this->_m_unknown = $this->_io->readU4le();
            $this->_m_adjacencyCount = $this->_io->readU4le();
            $this->_m_adjacencyOffset = $this->_io->readU4le();
            $this->_m_edgeCount = $this->_io->readU4le();
            $this->_m_edgeOffset = $this->_io->readU4le();
            $this->_m_perimeterCount = $this->_io->readU4le();
            $this->_m_perimeterOffset = $this->_io->readU4le();
        }
        protected $_m_vertexCount;
        protected $_m_vertexOffset;
        protected $_m_faceCount;
        protected $_m_faceIndicesOffset;
        protected $_m_materialsOffset;
        protected $_m_normalsOffset;
        protected $_m_distancesOffset;
        protected $_m_aabbCount;
        protected $_m_aabbOffset;
        protected $_m_unknown;
        protected $_m_adjacencyCount;
        protected $_m_adjacencyOffset;
        protected $_m_edgeCount;
        protected $_m_edgeOffset;
        protected $_m_perimeterCount;
        protected $_m_perimeterOffset;

        /**
         * Number of vertices in the walkmesh
         */
        public function vertexCount() { return $this->_m_vertexCount; }

        /**
         * Byte offset to vertex array from the beginning of the file
         */
        public function vertexOffset() { return $this->_m_vertexOffset; }

        /**
         * Number of faces (triangles) in the walkmesh
         */
        public function faceCount() { return $this->_m_faceCount; }

        /**
         * Byte offset to face indices array from the beginning of the file
         */
        public function faceIndicesOffset() { return $this->_m_faceIndicesOffset; }

        /**
         * Byte offset to materials array from the beginning of the file
         */
        public function materialsOffset() { return $this->_m_materialsOffset; }

        /**
         * Byte offset to face normals array from the beginning of the file.
         * Only used for WOK files (area walkmeshes).
         */
        public function normalsOffset() { return $this->_m_normalsOffset; }

        /**
         * Byte offset to planar distances array from the beginning of the file.
         * Only used for WOK files (area walkmeshes).
         */
        public function distancesOffset() { return $this->_m_distancesOffset; }

        /**
         * Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
         * AABB trees provide spatial acceleration for raycasting and point queries.
         */
        public function aabbCount() { return $this->_m_aabbCount; }

        /**
         * Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
         * Only present if aabb_count > 0.
         */
        public function aabbOffset() { return $this->_m_aabbOffset; }

        /**
         * Unknown field (typically 0 or 4).
         * Purpose is undocumented but appears in all BWM files.
         */
        public function unknown() { return $this->_m_unknown; }

        /**
         * Number of walkable faces for adjacency data (WOK only).
         * This equals the number of walkable faces, not the total face count.
         * Adjacencies are stored only for walkable faces.
         */
        public function adjacencyCount() { return $this->_m_adjacencyCount; }

        /**
         * Byte offset to adjacency array from the beginning of the file (WOK only).
         * Only present if adjacency_count > 0.
         */
        public function adjacencyOffset() { return $this->_m_adjacencyOffset; }

        /**
         * Number of perimeter edges (WOK only).
         * Perimeter edges are boundary edges with no walkable neighbor.
         */
        public function edgeCount() { return $this->_m_edgeCount; }

        /**
         * Byte offset to edges array from the beginning of the file (WOK only).
         * Only present if edge_count > 0.
         */
        public function edgeOffset() { return $this->_m_edgeOffset; }

        /**
         * Number of perimeter markers (WOK only).
         * Perimeter markers indicate the end of closed loops of perimeter edges.
         */
        public function perimeterCount() { return $this->_m_perimeterCount; }

        /**
         * Byte offset to perimeters array from the beginning of the file (WOK only).
         * Only present if perimeter_count > 0.
         */
        public function perimeterOffset() { return $this->_m_perimeterOffset; }
    }
}

namespace Bwm {
    class EdgeEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm\EdgesArray $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_edgeIndex = $this->_io->readU4le();
            $this->_m_transition = $this->_io->readS4le();
        }
        protected $_m_faceIndex;

        /**
         * Face index that this edge belongs to (decoded from edge_index)
         */
        public function faceIndex() {
            if ($this->_m_faceIndex !== null)
                return $this->_m_faceIndex;
            $this->_m_faceIndex = intval($this->edgeIndex() / 3);
            return $this->_m_faceIndex;
        }
        protected $_m_hasTransition;

        /**
         * True if this edge has a transition ID (links to door/area connection)
         */
        public function hasTransition() {
            if ($this->_m_hasTransition !== null)
                return $this->_m_hasTransition;
            $this->_m_hasTransition = $this->transition() != -1;
            return $this->_m_hasTransition;
        }
        protected $_m_localEdgeIndex;

        /**
         * Local edge index (0, 1, or 2) within the face (decoded from edge_index)
         */
        public function localEdgeIndex() {
            if ($this->_m_localEdgeIndex !== null)
                return $this->_m_localEdgeIndex;
            $this->_m_localEdgeIndex = \Kaitai\Struct\Stream::mod($this->edgeIndex(), 3);
            return $this->_m_localEdgeIndex;
        }
        protected $_m_edgeIndex;
        protected $_m_transition;

        /**
         * Encoded edge index: face_index * 3 + local_edge_index
         * Identifies which face and which edge (0, 1, or 2) of that face.
         * Edge 0: between v1 and v2
         * Edge 1: between v2 and v3
         * Edge 2: between v3 and v1
         */
        public function edgeIndex() { return $this->_m_edgeIndex; }

        /**
         * Transition ID for room/area connections, -1 if no transition.
         * Non-negative values reference door connections or area boundaries.
         * -1 indicates this is just a boundary edge with no transition.
         */
        public function transition() { return $this->_m_transition; }
    }
}

namespace Bwm {
    class EdgesArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_edges = [];
            $n = $this->_root()->dataTableOffsets()->edgeCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_edges[] = new \Bwm\EdgeEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_edges;

        /**
         * Array of perimeter edges (WOK only).
         * Perimeter edges are boundary edges with no walkable neighbor.
         * Each edge entry contains an edge index and optional transition ID.
         */
        public function edges() { return $this->_m_edges; }
    }
}

namespace Bwm {
    class FaceIndices extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm\FaceIndicesArray $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_v1Index = $this->_io->readU4le();
            $this->_m_v2Index = $this->_io->readU4le();
            $this->_m_v3Index = $this->_io->readU4le();
        }
        protected $_m_v1Index;
        protected $_m_v2Index;
        protected $_m_v3Index;

        /**
         * Vertex index for first vertex of triangle (0-based index into vertices array).
         * Vertex indices define the triangle's vertices in counter-clockwise order
         * when viewed from the front (the side the normal points toward).
         */
        public function v1Index() { return $this->_m_v1Index; }

        /**
         * Vertex index for second vertex of triangle (0-based index into vertices array).
         */
        public function v2Index() { return $this->_m_v2Index; }

        /**
         * Vertex index for third vertex of triangle (0-based index into vertices array).
         */
        public function v3Index() { return $this->_m_v3Index; }
    }
}

namespace Bwm {
    class FaceIndicesArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_faces = [];
            $n = $this->_root()->dataTableOffsets()->faceCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_faces[] = new \Bwm\FaceIndices($this->_io, $this, $this->_root);
            }
        }
        protected $_m_faces;

        /**
         * Array of face vertex index triplets
         */
        public function faces() { return $this->_m_faces; }
    }
}

namespace Bwm {
    class MaterialsArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_materials = [];
            $n = $this->_root()->dataTableOffsets()->faceCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_materials[] = $this->_io->readU4le();
            }
        }
        protected $_m_materials;

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
        public function materials() { return $this->_m_materials; }
    }
}

namespace Bwm {
    class NormalsArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_normals = [];
            $n = $this->_root()->dataTableOffsets()->faceCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_normals[] = new \Bwm\Vec3f($this->_io, $this, $this->_root);
            }
        }
        protected $_m_normals;

        /**
         * Array of face normal vectors, one per face (WOK only).
         * Normals are precomputed unit vectors perpendicular to each face.
         * Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
         * Normal direction follows right-hand rule based on vertex winding order.
         */
        public function normals() { return $this->_m_normals; }
    }
}

namespace Bwm {
    class PerimetersArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_perimeters = [];
            $n = $this->_root()->dataTableOffsets()->perimeterCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_perimeters[] = $this->_io->readU4le();
            }
        }
        protected $_m_perimeters;

        /**
         * Array of perimeter markers (WOK only).
         * Each value is an index into the edges array, marking the end of a perimeter loop.
         * Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
         * Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.
         */
        public function perimeters() { return $this->_m_perimeters; }
    }
}

namespace Bwm {
    class PlanarDistancesArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_distances = [];
            $n = $this->_root()->dataTableOffsets()->faceCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_distances[] = $this->_io->readF4le();
            }
        }
        protected $_m_distances;

        /**
         * Array of planar distances, one per face (WOK only).
         * The D component of the plane equation ax + by + cz + d = 0.
         * Calculated as d = -normal · vertex1 for each face.
         * Precomputed to allow quick point-plane relationship tests.
         */
        public function distances() { return $this->_m_distances; }
    }
}

namespace Bwm {
    class Vec3f extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_x = $this->_io->readF4le();
            $this->_m_y = $this->_io->readF4le();
            $this->_m_z = $this->_io->readF4le();
        }
        protected $_m_x;
        protected $_m_y;
        protected $_m_z;

        /**
         * X coordinate (float32)
         */
        public function x() { return $this->_m_x; }

        /**
         * Y coordinate (float32)
         */
        public function y() { return $this->_m_y; }

        /**
         * Z coordinate (float32)
         */
        public function z() { return $this->_m_z; }
    }
}

namespace Bwm {
    class VerticesArray extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_vertices = [];
            $n = $this->_root()->dataTableOffsets()->vertexCount();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_vertices[] = new \Bwm\Vec3f($this->_io, $this, $this->_root);
            }
        }
        protected $_m_vertices;

        /**
         * Array of vertex positions, each vertex is a float3 (x, y, z)
         */
        public function vertices() { return $this->_m_vertices; }
    }
}

namespace Bwm {
    class WalkmeshProperties extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Bwm $_parent = null, ?\Bwm $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_walkmeshType = $this->_io->readU4le();
            $this->_m_relativeUsePosition1 = new \Bwm\Vec3f($this->_io, $this, $this->_root);
            $this->_m_relativeUsePosition2 = new \Bwm\Vec3f($this->_io, $this, $this->_root);
            $this->_m_absoluteUsePosition1 = new \Bwm\Vec3f($this->_io, $this, $this->_root);
            $this->_m_absoluteUsePosition2 = new \Bwm\Vec3f($this->_io, $this, $this->_root);
            $this->_m_position = new \Bwm\Vec3f($this->_io, $this, $this->_root);
        }
        protected $_m_isAreaWalkmesh;

        /**
         * True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)
         */
        public function isAreaWalkmesh() {
            if ($this->_m_isAreaWalkmesh !== null)
                return $this->_m_isAreaWalkmesh;
            $this->_m_isAreaWalkmesh = $this->walkmeshType() == 1;
            return $this->_m_isAreaWalkmesh;
        }
        protected $_m_isPlaceableOrDoor;

        /**
         * True if this is a placeable or door walkmesh (PWK/DWK)
         */
        public function isPlaceableOrDoor() {
            if ($this->_m_isPlaceableOrDoor !== null)
                return $this->_m_isPlaceableOrDoor;
            $this->_m_isPlaceableOrDoor = $this->walkmeshType() == 0;
            return $this->_m_isPlaceableOrDoor;
        }
        protected $_m_walkmeshType;
        protected $_m_relativeUsePosition1;
        protected $_m_relativeUsePosition2;
        protected $_m_absoluteUsePosition1;
        protected $_m_absoluteUsePosition2;
        protected $_m_position;

        /**
         * Walkmesh type identifier:
         * - 0 = PWK/DWK (Placeable/Door walkmesh)
         * - 1 = WOK (Area walkmesh)
         */
        public function walkmeshType() { return $this->_m_walkmeshType; }

        /**
         * Relative use hook position 1 (x, y, z).
         * Position relative to the walkmesh origin, used when the walkmesh may be transformed.
         * For doors: Defines where the player must stand to interact (relative to door model).
         * For placeables: Defines interaction points relative to the object's local coordinate system.
         */
        public function relativeUsePosition1() { return $this->_m_relativeUsePosition1; }

        /**
         * Relative use hook position 2 (x, y, z).
         * Second interaction point relative to the walkmesh origin.
         */
        public function relativeUsePosition2() { return $this->_m_relativeUsePosition2; }

        /**
         * Absolute use hook position 1 (x, y, z).
         * Position in world space, used when the walkmesh position is known.
         * For doors: Precomputed world-space interaction points (position + relative hook).
         * For placeables: World-space interaction points accounting for object placement.
         */
        public function absoluteUsePosition1() { return $this->_m_absoluteUsePosition1; }

        /**
         * Absolute use hook position 2 (x, y, z).
         * Second absolute interaction point in world space.
         */
        public function absoluteUsePosition2() { return $this->_m_absoluteUsePosition2; }

        /**
         * Walkmesh position offset (x, y, z) in world space.
         * For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
         * For placeable/door walkmeshes: The position where the object is placed in the area.
         * Used to transform vertices from local to world coordinates.
         */
        public function position() { return $this->_m_position; }
    }
}
