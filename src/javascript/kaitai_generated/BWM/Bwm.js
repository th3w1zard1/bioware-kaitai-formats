// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Bwm || (root.Bwm = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Bwm_, KaitaiStream) {
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
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43|xoreos-tools — shipped CLI inventory (no BWM-specific tool)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm|PyKotor wiki — BWM}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L56-L110|PyKotor — Kaitai-backed BWM struct load}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L187-L253|PyKotor — BWMBinaryReader.load}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L42-L113|xoreos — WalkmeshLoader::load}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L119-L216|xoreos — WalkmeshLoader (append tables / WOK-only paths)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L218-L249|xoreos — WalkmeshLoader::getAABB}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L27-L92|reone — BwmReader::load}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L94-L171|reone — BwmReader (AABB / adjacency tables)}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L301-L395|KotOR.js — readBinary}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L490-L516|KotOR.js — header / version constants}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs tree (no dedicated BWM / walkmesh Torlack page; use engine + PyKotor xrefs above)}
 */

var Bwm = (function() {
  function Bwm(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Bwm.prototype._read = function() {
    this.header = new BwmHeader(this._io, this, this._root);
    this.walkmeshProperties = new WalkmeshProperties(this._io, this, this._root);
    this.dataTableOffsets = new DataTableOffsets(this._io, this, this._root);
  }

  var AabbNode = Bwm.AabbNode = (function() {
    function AabbNode(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AabbNode.prototype._read = function() {
      this.boundsMin = new Vec3f(this._io, this, this._root);
      this.boundsMax = new Vec3f(this._io, this, this._root);
      this.faceIndex = this._io.readS4le();
      this.unknown = this._io.readU4le();
      this.mostSignificantPlane = this._io.readU4le();
      this.leftChildIndex = this._io.readU4le();
      this.rightChildIndex = this._io.readU4le();
    }

    /**
     * True if this node has a left child
     */
    Object.defineProperty(AabbNode.prototype, 'hasLeftChild', {
      get: function() {
        if (this._m_hasLeftChild !== undefined)
          return this._m_hasLeftChild;
        this._m_hasLeftChild = this.leftChildIndex != 4294967295;
        return this._m_hasLeftChild;
      }
    });

    /**
     * True if this node has a right child
     */
    Object.defineProperty(AabbNode.prototype, 'hasRightChild', {
      get: function() {
        if (this._m_hasRightChild !== undefined)
          return this._m_hasRightChild;
        this._m_hasRightChild = this.rightChildIndex != 4294967295;
        return this._m_hasRightChild;
      }
    });

    /**
     * True if this is an internal node (has children), false if leaf node
     */
    Object.defineProperty(AabbNode.prototype, 'isInternalNode', {
      get: function() {
        if (this._m_isInternalNode !== undefined)
          return this._m_isInternalNode;
        this._m_isInternalNode = this.faceIndex == -1;
        return this._m_isInternalNode;
      }
    });

    /**
     * True if this is a leaf node (contains a face), false if internal node
     */
    Object.defineProperty(AabbNode.prototype, 'isLeafNode', {
      get: function() {
        if (this._m_isLeafNode !== undefined)
          return this._m_isLeafNode;
        this._m_isLeafNode = this.faceIndex != -1;
        return this._m_isLeafNode;
      }
    });

    /**
     * Minimum bounding box coordinates (x, y, z).
     * Defines the lower corner of the axis-aligned bounding box.
     */

    /**
     * Maximum bounding box coordinates (x, y, z).
     * Defines the upper corner of the axis-aligned bounding box.
     */

    /**
     * Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
     * Leaf nodes contain a single face, internal nodes contain child nodes.
     */

    /**
     * Unknown field (typically 4).
     * Purpose is undocumented but appears in all AABB nodes.
     */

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

    /**
     * Index to left child node (0-based array index).
     * 0xFFFFFFFF indicates no left child.
     * Child indices are 0-based indices into the AABB nodes array.
     */

    /**
     * Index to right child node (0-based array index).
     * 0xFFFFFFFF indicates no right child.
     * Child indices are 0-based indices into the AABB nodes array.
     */

    return AabbNode;
  })();

  var AabbNodesArray = Bwm.AabbNodesArray = (function() {
    function AabbNodesArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AabbNodesArray.prototype._read = function() {
      this.nodes = [];
      for (var i = 0; i < this._root.dataTableOffsets.aabbCount; i++) {
        this.nodes.push(new AabbNode(this._io, this, this._root));
      }
    }

    /**
     * Array of AABB tree nodes for spatial acceleration (WOK only).
     * AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).
     */

    return AabbNodesArray;
  })();

  var AdjacenciesArray = Bwm.AdjacenciesArray = (function() {
    function AdjacenciesArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AdjacenciesArray.prototype._read = function() {
      this.adjacencies = [];
      for (var i = 0; i < this._root.dataTableOffsets.adjacencyCount; i++) {
        this.adjacencies.push(new AdjacencyTriplet(this._io, this, this._root));
      }
    }

    /**
     * Array of adjacency triplets, one per walkable face (WOK only).
     * Each walkable face has exactly three adjacency entries, one for each edge.
     * Adjacency count equals the number of walkable faces, not the total face count.
     */

    return AdjacenciesArray;
  })();

  var AdjacencyTriplet = Bwm.AdjacencyTriplet = (function() {
    function AdjacencyTriplet(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AdjacencyTriplet.prototype._read = function() {
      this.edge0Adjacency = this._io.readS4le();
      this.edge1Adjacency = this._io.readS4le();
      this.edge2Adjacency = this._io.readS4le();
    }

    /**
     * Face index of adjacent face for edge 0 (decoded from adjacency index)
     */
    Object.defineProperty(AdjacencyTriplet.prototype, 'edge0FaceIndex', {
      get: function() {
        if (this._m_edge0FaceIndex !== undefined)
          return this._m_edge0FaceIndex;
        this._m_edge0FaceIndex = (this.edge0Adjacency != -1 ? Math.floor(this.edge0Adjacency / 3) : -1);
        return this._m_edge0FaceIndex;
      }
    });

    /**
     * True if edge 0 has an adjacent walkable face
     */
    Object.defineProperty(AdjacencyTriplet.prototype, 'edge0HasNeighbor', {
      get: function() {
        if (this._m_edge0HasNeighbor !== undefined)
          return this._m_edge0HasNeighbor;
        this._m_edge0HasNeighbor = this.edge0Adjacency != -1;
        return this._m_edge0HasNeighbor;
      }
    });

    /**
     * Local edge index (0, 1, or 2) of adjacent face for edge 0
     */
    Object.defineProperty(AdjacencyTriplet.prototype, 'edge0LocalEdge', {
      get: function() {
        if (this._m_edge0LocalEdge !== undefined)
          return this._m_edge0LocalEdge;
        this._m_edge0LocalEdge = (this.edge0Adjacency != -1 ? KaitaiStream.mod(this.edge0Adjacency, 3) : -1);
        return this._m_edge0LocalEdge;
      }
    });

    /**
     * Face index of adjacent face for edge 1 (decoded from adjacency index)
     */
    Object.defineProperty(AdjacencyTriplet.prototype, 'edge1FaceIndex', {
      get: function() {
        if (this._m_edge1FaceIndex !== undefined)
          return this._m_edge1FaceIndex;
        this._m_edge1FaceIndex = (this.edge1Adjacency != -1 ? Math.floor(this.edge1Adjacency / 3) : -1);
        return this._m_edge1FaceIndex;
      }
    });

    /**
     * True if edge 1 has an adjacent walkable face
     */
    Object.defineProperty(AdjacencyTriplet.prototype, 'edge1HasNeighbor', {
      get: function() {
        if (this._m_edge1HasNeighbor !== undefined)
          return this._m_edge1HasNeighbor;
        this._m_edge1HasNeighbor = this.edge1Adjacency != -1;
        return this._m_edge1HasNeighbor;
      }
    });

    /**
     * Local edge index (0, 1, or 2) of adjacent face for edge 1
     */
    Object.defineProperty(AdjacencyTriplet.prototype, 'edge1LocalEdge', {
      get: function() {
        if (this._m_edge1LocalEdge !== undefined)
          return this._m_edge1LocalEdge;
        this._m_edge1LocalEdge = (this.edge1Adjacency != -1 ? KaitaiStream.mod(this.edge1Adjacency, 3) : -1);
        return this._m_edge1LocalEdge;
      }
    });

    /**
     * Face index of adjacent face for edge 2 (decoded from adjacency index)
     */
    Object.defineProperty(AdjacencyTriplet.prototype, 'edge2FaceIndex', {
      get: function() {
        if (this._m_edge2FaceIndex !== undefined)
          return this._m_edge2FaceIndex;
        this._m_edge2FaceIndex = (this.edge2Adjacency != -1 ? Math.floor(this.edge2Adjacency / 3) : -1);
        return this._m_edge2FaceIndex;
      }
    });

    /**
     * True if edge 2 has an adjacent walkable face
     */
    Object.defineProperty(AdjacencyTriplet.prototype, 'edge2HasNeighbor', {
      get: function() {
        if (this._m_edge2HasNeighbor !== undefined)
          return this._m_edge2HasNeighbor;
        this._m_edge2HasNeighbor = this.edge2Adjacency != -1;
        return this._m_edge2HasNeighbor;
      }
    });

    /**
     * Local edge index (0, 1, or 2) of adjacent face for edge 2
     */
    Object.defineProperty(AdjacencyTriplet.prototype, 'edge2LocalEdge', {
      get: function() {
        if (this._m_edge2LocalEdge !== undefined)
          return this._m_edge2LocalEdge;
        this._m_edge2LocalEdge = (this.edge2Adjacency != -1 ? KaitaiStream.mod(this.edge2Adjacency, 3) : -1);
        return this._m_edge2LocalEdge;
      }
    });

    /**
     * Adjacency index for edge 0 (between v1 and v2).
     * Encoding: face_index * 3 + edge_index
     * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
     */

    /**
     * Adjacency index for edge 1 (between v2 and v3).
     * Encoding: face_index * 3 + edge_index
     * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
     */

    /**
     * Adjacency index for edge 2 (between v3 and v1).
     * Encoding: face_index * 3 + edge_index
     * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
     */

    return AdjacencyTriplet;
  })();

  var BwmHeader = Bwm.BwmHeader = (function() {
    function BwmHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BwmHeader.prototype._read = function() {
      this.magic = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      this.version = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    }

    /**
     * Validation check that the file is a valid BWM file.
     * Both magic and version must match expected values.
     */
    Object.defineProperty(BwmHeader.prototype, 'isValidBwm', {
      get: function() {
        if (this._m_isValidBwm !== undefined)
          return this._m_isValidBwm;
        this._m_isValidBwm =  ((this.magic == "BWM ") && (this.version == "V1.0")) ;
        return this._m_isValidBwm;
      }
    });

    /**
     * File type signature. Must be "BWM " (space-padded).
     * The space after "BWM" is significant and must be present.
     */

    /**
     * File format version. Always "V1.0" for KotOR BWM files.
     * This is the first and only version of the BWM format used in KotOR games.
     */

    return BwmHeader;
  })();

  var DataTableOffsets = Bwm.DataTableOffsets = (function() {
    function DataTableOffsets(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    DataTableOffsets.prototype._read = function() {
      this.vertexCount = this._io.readU4le();
      this.vertexOffset = this._io.readU4le();
      this.faceCount = this._io.readU4le();
      this.faceIndicesOffset = this._io.readU4le();
      this.materialsOffset = this._io.readU4le();
      this.normalsOffset = this._io.readU4le();
      this.distancesOffset = this._io.readU4le();
      this.aabbCount = this._io.readU4le();
      this.aabbOffset = this._io.readU4le();
      this.unknown = this._io.readU4le();
      this.adjacencyCount = this._io.readU4le();
      this.adjacencyOffset = this._io.readU4le();
      this.edgeCount = this._io.readU4le();
      this.edgeOffset = this._io.readU4le();
      this.perimeterCount = this._io.readU4le();
      this.perimeterOffset = this._io.readU4le();
    }

    /**
     * Number of vertices in the walkmesh
     */

    /**
     * Byte offset to vertex array from the beginning of the file
     */

    /**
     * Number of faces (triangles) in the walkmesh
     */

    /**
     * Byte offset to face indices array from the beginning of the file
     */

    /**
     * Byte offset to materials array from the beginning of the file
     */

    /**
     * Byte offset to face normals array from the beginning of the file.
     * Only used for WOK files (area walkmeshes).
     */

    /**
     * Byte offset to planar distances array from the beginning of the file.
     * Only used for WOK files (area walkmeshes).
     */

    /**
     * Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
     * AABB trees provide spatial acceleration for raycasting and point queries.
     */

    /**
     * Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
     * Only present if aabb_count > 0.
     */

    /**
     * Unknown field (typically 0 or 4).
     * Purpose is undocumented but appears in all BWM files.
     */

    /**
     * Number of walkable faces for adjacency data (WOK only).
     * This equals the number of walkable faces, not the total face count.
     * Adjacencies are stored only for walkable faces.
     */

    /**
     * Byte offset to adjacency array from the beginning of the file (WOK only).
     * Only present if adjacency_count > 0.
     */

    /**
     * Number of perimeter edges (WOK only).
     * Perimeter edges are boundary edges with no walkable neighbor.
     */

    /**
     * Byte offset to edges array from the beginning of the file (WOK only).
     * Only present if edge_count > 0.
     */

    /**
     * Number of perimeter markers (WOK only).
     * Perimeter markers indicate the end of closed loops of perimeter edges.
     */

    /**
     * Byte offset to perimeters array from the beginning of the file (WOK only).
     * Only present if perimeter_count > 0.
     */

    return DataTableOffsets;
  })();

  var EdgeEntry = Bwm.EdgeEntry = (function() {
    function EdgeEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    EdgeEntry.prototype._read = function() {
      this.edgeIndex = this._io.readU4le();
      this.transition = this._io.readS4le();
    }

    /**
     * Face index that this edge belongs to (decoded from edge_index)
     */
    Object.defineProperty(EdgeEntry.prototype, 'faceIndex', {
      get: function() {
        if (this._m_faceIndex !== undefined)
          return this._m_faceIndex;
        this._m_faceIndex = Math.floor(this.edgeIndex / 3);
        return this._m_faceIndex;
      }
    });

    /**
     * True if this edge has a transition ID (links to door/area connection)
     */
    Object.defineProperty(EdgeEntry.prototype, 'hasTransition', {
      get: function() {
        if (this._m_hasTransition !== undefined)
          return this._m_hasTransition;
        this._m_hasTransition = this.transition != -1;
        return this._m_hasTransition;
      }
    });

    /**
     * Local edge index (0, 1, or 2) within the face (decoded from edge_index)
     */
    Object.defineProperty(EdgeEntry.prototype, 'localEdgeIndex', {
      get: function() {
        if (this._m_localEdgeIndex !== undefined)
          return this._m_localEdgeIndex;
        this._m_localEdgeIndex = KaitaiStream.mod(this.edgeIndex, 3);
        return this._m_localEdgeIndex;
      }
    });

    /**
     * Encoded edge index: face_index * 3 + local_edge_index
     * Identifies which face and which edge (0, 1, or 2) of that face.
     * Edge 0: between v1 and v2
     * Edge 1: between v2 and v3
     * Edge 2: between v3 and v1
     */

    /**
     * Transition ID for room/area connections, -1 if no transition.
     * Non-negative values reference door connections or area boundaries.
     * -1 indicates this is just a boundary edge with no transition.
     */

    return EdgeEntry;
  })();

  var EdgesArray = Bwm.EdgesArray = (function() {
    function EdgesArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    EdgesArray.prototype._read = function() {
      this.edges = [];
      for (var i = 0; i < this._root.dataTableOffsets.edgeCount; i++) {
        this.edges.push(new EdgeEntry(this._io, this, this._root));
      }
    }

    /**
     * Array of perimeter edges (WOK only).
     * Perimeter edges are boundary edges with no walkable neighbor.
     * Each edge entry contains an edge index and optional transition ID.
     */

    return EdgesArray;
  })();

  var FaceIndices = Bwm.FaceIndices = (function() {
    function FaceIndices(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FaceIndices.prototype._read = function() {
      this.v1Index = this._io.readU4le();
      this.v2Index = this._io.readU4le();
      this.v3Index = this._io.readU4le();
    }

    /**
     * Vertex index for first vertex of triangle (0-based index into vertices array).
     * Vertex indices define the triangle's vertices in counter-clockwise order
     * when viewed from the front (the side the normal points toward).
     */

    /**
     * Vertex index for second vertex of triangle (0-based index into vertices array).
     */

    /**
     * Vertex index for third vertex of triangle (0-based index into vertices array).
     */

    return FaceIndices;
  })();

  var FaceIndicesArray = Bwm.FaceIndicesArray = (function() {
    function FaceIndicesArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FaceIndicesArray.prototype._read = function() {
      this.faces = [];
      for (var i = 0; i < this._root.dataTableOffsets.faceCount; i++) {
        this.faces.push(new FaceIndices(this._io, this, this._root));
      }
    }

    /**
     * Array of face vertex index triplets
     */

    return FaceIndicesArray;
  })();

  var MaterialsArray = Bwm.MaterialsArray = (function() {
    function MaterialsArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    MaterialsArray.prototype._read = function() {
      this.materials = [];
      for (var i = 0; i < this._root.dataTableOffsets.faceCount; i++) {
        this.materials.push(this._io.readU4le());
      }
    }

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

    return MaterialsArray;
  })();

  var NormalsArray = Bwm.NormalsArray = (function() {
    function NormalsArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    NormalsArray.prototype._read = function() {
      this.normals = [];
      for (var i = 0; i < this._root.dataTableOffsets.faceCount; i++) {
        this.normals.push(new Vec3f(this._io, this, this._root));
      }
    }

    /**
     * Array of face normal vectors, one per face (WOK only).
     * Normals are precomputed unit vectors perpendicular to each face.
     * Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
     * Normal direction follows right-hand rule based on vertex winding order.
     */

    return NormalsArray;
  })();

  var PerimetersArray = Bwm.PerimetersArray = (function() {
    function PerimetersArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    PerimetersArray.prototype._read = function() {
      this.perimeters = [];
      for (var i = 0; i < this._root.dataTableOffsets.perimeterCount; i++) {
        this.perimeters.push(this._io.readU4le());
      }
    }

    /**
     * Array of perimeter markers (WOK only).
     * Each value is an index into the edges array, marking the end of a perimeter loop.
     * Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
     * Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.
     */

    return PerimetersArray;
  })();

  var PlanarDistancesArray = Bwm.PlanarDistancesArray = (function() {
    function PlanarDistancesArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    PlanarDistancesArray.prototype._read = function() {
      this.distances = [];
      for (var i = 0; i < this._root.dataTableOffsets.faceCount; i++) {
        this.distances.push(this._io.readF4le());
      }
    }

    /**
     * Array of planar distances, one per face (WOK only).
     * The D component of the plane equation ax + by + cz + d = 0.
     * Calculated as d = -normal · vertex1 for each face.
     * Precomputed to allow quick point-plane relationship tests.
     */

    return PlanarDistancesArray;
  })();

  var Vec3f = Bwm.Vec3f = (function() {
    function Vec3f(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Vec3f.prototype._read = function() {
      this.x = this._io.readF4le();
      this.y = this._io.readF4le();
      this.z = this._io.readF4le();
    }

    /**
     * X coordinate (float32)
     */

    /**
     * Y coordinate (float32)
     */

    /**
     * Z coordinate (float32)
     */

    return Vec3f;
  })();

  var VerticesArray = Bwm.VerticesArray = (function() {
    function VerticesArray(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    VerticesArray.prototype._read = function() {
      this.vertices = [];
      for (var i = 0; i < this._root.dataTableOffsets.vertexCount; i++) {
        this.vertices.push(new Vec3f(this._io, this, this._root));
      }
    }

    /**
     * Array of vertex positions, each vertex is a float3 (x, y, z)
     */

    return VerticesArray;
  })();

  var WalkmeshProperties = Bwm.WalkmeshProperties = (function() {
    function WalkmeshProperties(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    WalkmeshProperties.prototype._read = function() {
      this.walkmeshType = this._io.readU4le();
      this.relativeUsePosition1 = new Vec3f(this._io, this, this._root);
      this.relativeUsePosition2 = new Vec3f(this._io, this, this._root);
      this.absoluteUsePosition1 = new Vec3f(this._io, this, this._root);
      this.absoluteUsePosition2 = new Vec3f(this._io, this, this._root);
      this.position = new Vec3f(this._io, this, this._root);
    }

    /**
     * True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)
     */
    Object.defineProperty(WalkmeshProperties.prototype, 'isAreaWalkmesh', {
      get: function() {
        if (this._m_isAreaWalkmesh !== undefined)
          return this._m_isAreaWalkmesh;
        this._m_isAreaWalkmesh = this.walkmeshType == 1;
        return this._m_isAreaWalkmesh;
      }
    });

    /**
     * True if this is a placeable or door walkmesh (PWK/DWK)
     */
    Object.defineProperty(WalkmeshProperties.prototype, 'isPlaceableOrDoor', {
      get: function() {
        if (this._m_isPlaceableOrDoor !== undefined)
          return this._m_isPlaceableOrDoor;
        this._m_isPlaceableOrDoor = this.walkmeshType == 0;
        return this._m_isPlaceableOrDoor;
      }
    });

    /**
     * Walkmesh type identifier:
     * - 0 = PWK/DWK (Placeable/Door walkmesh)
     * - 1 = WOK (Area walkmesh)
     */

    /**
     * Relative use hook position 1 (x, y, z).
     * Position relative to the walkmesh origin, used when the walkmesh may be transformed.
     * For doors: Defines where the player must stand to interact (relative to door model).
     * For placeables: Defines interaction points relative to the object's local coordinate system.
     */

    /**
     * Relative use hook position 2 (x, y, z).
     * Second interaction point relative to the walkmesh origin.
     */

    /**
     * Absolute use hook position 1 (x, y, z).
     * Position in world space, used when the walkmesh position is known.
     * For doors: Precomputed world-space interaction points (position + relative hook).
     * For placeables: World-space interaction points accounting for object placement.
     */

    /**
     * Absolute use hook position 2 (x, y, z).
     * Second absolute interaction point in world space.
     */

    /**
     * Walkmesh position offset (x, y, z) in world space.
     * For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
     * For placeable/door walkmeshes: The position where the object is placed in the area.
     * Used to transform vertices from local to world coordinates.
     */

    return WalkmeshProperties;
  })();

  /**
   * Array of AABB tree nodes for spatial acceleration - WOK only
   */
  Object.defineProperty(Bwm.prototype, 'aabbNodes', {
    get: function() {
      if (this._m_aabbNodes !== undefined)
        return this._m_aabbNodes;
      if ( ((this._root.walkmeshProperties.walkmeshType == 1) && (this._root.dataTableOffsets.aabbCount > 0)) ) {
        var _pos = this._io.pos;
        this._io.seek(this._root.dataTableOffsets.aabbOffset);
        this._m_aabbNodes = new AabbNodesArray(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_aabbNodes;
    }
  });

  /**
   * Array of adjacency indices (int32 triplets per walkable face) - WOK only
   */
  Object.defineProperty(Bwm.prototype, 'adjacencies', {
    get: function() {
      if (this._m_adjacencies !== undefined)
        return this._m_adjacencies;
      if ( ((this._root.walkmeshProperties.walkmeshType == 1) && (this._root.dataTableOffsets.adjacencyCount > 0)) ) {
        var _pos = this._io.pos;
        this._io.seek(this._root.dataTableOffsets.adjacencyOffset);
        this._m_adjacencies = new AdjacenciesArray(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_adjacencies;
    }
  });

  /**
   * Array of perimeter edges (edge_index, transition pairs) - WOK only
   */
  Object.defineProperty(Bwm.prototype, 'edges', {
    get: function() {
      if (this._m_edges !== undefined)
        return this._m_edges;
      if ( ((this._root.walkmeshProperties.walkmeshType == 1) && (this._root.dataTableOffsets.edgeCount > 0)) ) {
        var _pos = this._io.pos;
        this._io.seek(this._root.dataTableOffsets.edgeOffset);
        this._m_edges = new EdgesArray(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_edges;
    }
  });

  /**
   * Array of face vertex indices (uint32 triplets)
   */
  Object.defineProperty(Bwm.prototype, 'faceIndices', {
    get: function() {
      if (this._m_faceIndices !== undefined)
        return this._m_faceIndices;
      if (this._root.dataTableOffsets.faceCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this._root.dataTableOffsets.faceIndicesOffset);
        this._m_faceIndices = new FaceIndicesArray(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_faceIndices;
    }
  });

  /**
   * Array of surface material IDs per face
   */
  Object.defineProperty(Bwm.prototype, 'materials', {
    get: function() {
      if (this._m_materials !== undefined)
        return this._m_materials;
      if (this._root.dataTableOffsets.faceCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this._root.dataTableOffsets.materialsOffset);
        this._m_materials = new MaterialsArray(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_materials;
    }
  });

  /**
   * Array of face normal vectors (float3 triplets) - WOK only
   */
  Object.defineProperty(Bwm.prototype, 'normals', {
    get: function() {
      if (this._m_normals !== undefined)
        return this._m_normals;
      if ( ((this._root.walkmeshProperties.walkmeshType == 1) && (this._root.dataTableOffsets.faceCount > 0)) ) {
        var _pos = this._io.pos;
        this._io.seek(this._root.dataTableOffsets.normalsOffset);
        this._m_normals = new NormalsArray(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_normals;
    }
  });

  /**
   * Array of perimeter markers (edge indices marking end of loops) - WOK only
   */
  Object.defineProperty(Bwm.prototype, 'perimeters', {
    get: function() {
      if (this._m_perimeters !== undefined)
        return this._m_perimeters;
      if ( ((this._root.walkmeshProperties.walkmeshType == 1) && (this._root.dataTableOffsets.perimeterCount > 0)) ) {
        var _pos = this._io.pos;
        this._io.seek(this._root.dataTableOffsets.perimeterOffset);
        this._m_perimeters = new PerimetersArray(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_perimeters;
    }
  });

  /**
   * Array of planar distances (float32 per face) - WOK only
   */
  Object.defineProperty(Bwm.prototype, 'planarDistances', {
    get: function() {
      if (this._m_planarDistances !== undefined)
        return this._m_planarDistances;
      if ( ((this._root.walkmeshProperties.walkmeshType == 1) && (this._root.dataTableOffsets.faceCount > 0)) ) {
        var _pos = this._io.pos;
        this._io.seek(this._root.dataTableOffsets.distancesOffset);
        this._m_planarDistances = new PlanarDistancesArray(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_planarDistances;
    }
  });

  /**
   * Array of vertex positions (float3 triplets)
   */
  Object.defineProperty(Bwm.prototype, 'vertices', {
    get: function() {
      if (this._m_vertices !== undefined)
        return this._m_vertices;
      if (this._root.dataTableOffsets.vertexCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this._root.dataTableOffsets.vertexOffset);
        this._m_vertices = new VerticesArray(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_vertices;
    }
  });

  /**
   * BWM file header (8 bytes) - magic and version signature
   */

  /**
   * Walkmesh properties section (52 bytes) - type, hooks, position
   */

  /**
   * Data table offsets section (84 bytes) - counts and offsets for all data tables
   */

  return Bwm;
})();
Bwm_.Bwm = Bwm;
});
