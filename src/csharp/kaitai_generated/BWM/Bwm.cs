// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// BWM (Binary WalkMesh) files define walkable surfaces for pathfinding and collision detection
    /// in Knights of the Old Republic (KotOR) games. BWM files are stored on disk with different
    /// extensions depending on their type:
    /// 
    /// - WOK: Area walkmesh files (walkmesh_type = 1) - defines walkable regions in game areas
    /// - PWK: Placeable walkmesh files (walkmesh_type = 0) - collision geometry for containers, furniture
    /// - DWK: Door walkmesh files (walkmesh_type = 0) - collision geometry for doors in various states
    /// 
    /// The format uses a header-based structure where offsets point to various data tables, allowing
    /// efficient random access to vertices, faces, materials, and acceleration structures.
    /// 
    /// Binary Format Structure:
    /// - File Header (8 bytes): Magic &quot;BWM &quot; and version &quot;V1.0&quot;
    /// - Walkmesh Properties (52 bytes): Type, hook vectors, position
    /// - Data Table Offsets (84 bytes): Counts and offsets for all data tables
    /// - Vertices Array: Array of float3 (x, y, z) per vertex
    /// - Face Indices Array: Array of uint32 triplets (vertex indices per face)
    /// - Materials Array: Array of uint32 (SurfaceMaterial ID per face)
    /// - Normals Array: Array of float3 (face normal per face) - WOK only
    /// - Planar Distances Array: Array of float32 (per face) - WOK only
    /// - AABB Nodes Array: Array of AABB structures (WOK only)
    /// - Adjacencies Array: Array of int32 triplets (WOK only, -1 for no neighbor)
    /// - Edges Array: Array of (edge_index, transition) pairs (WOK only)
    /// - Perimeters Array: Array of edge indices (WOK only)
    /// 
    /// Authoritative cross-implementations (pinned paths and line bands): see `meta.xref` and `doc-ref`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no BWM-specific tool)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm">PyKotor wiki — BWM</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L56-L110">PyKotor — Kaitai-backed BWM struct load</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L187-L253">PyKotor — BWMBinaryReader.load</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L42-L113">xoreos — WalkmeshLoader::load</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L119-L216">xoreos — WalkmeshLoader (append tables / WOK-only paths)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L218-L249">xoreos — WalkmeshLoader::getAABB</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L27-L92">reone — BwmReader::load</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L94-L171">reone — BwmReader (AABB / adjacency tables)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L301-L395">KotOR.js — readBinary</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L490-L516">KotOR.js — header / version constants</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no dedicated BWM / walkmesh Torlack page; use engine + PyKotor xrefs above)</a>
    /// </remarks>
    public partial class Bwm : KaitaiStruct
    {
        public static Bwm FromFile(string fileName)
        {
            return new Bwm(new KaitaiStream(fileName));
        }

        public Bwm(KaitaiStream p__io, KaitaiStruct p__parent = null, Bwm p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            f_aabbNodes = false;
            f_adjacencies = false;
            f_edges = false;
            f_faceIndices = false;
            f_materials = false;
            f_normals = false;
            f_perimeters = false;
            f_planarDistances = false;
            f_vertices = false;
            _read();
        }
        private void _read()
        {
            _header = new BwmHeader(m_io, this, m_root);
            _walkmeshProperties = new WalkmeshProperties(m_io, this, m_root);
            _dataTableOffsets = new DataTableOffsets(m_io, this, m_root);
        }
        public partial class AabbNode : KaitaiStruct
        {
            public static AabbNode FromFile(string fileName)
            {
                return new AabbNode(new KaitaiStream(fileName));
            }

            public AabbNode(KaitaiStream p__io, Bwm.AabbNodesArray p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_hasLeftChild = false;
                f_hasRightChild = false;
                f_isInternalNode = false;
                f_isLeafNode = false;
                _read();
            }
            private void _read()
            {
                _boundsMin = new Vec3f(m_io, this, m_root);
                _boundsMax = new Vec3f(m_io, this, m_root);
                _faceIndex = m_io.ReadS4le();
                _unknown = m_io.ReadU4le();
                _mostSignificantPlane = m_io.ReadU4le();
                _leftChildIndex = m_io.ReadU4le();
                _rightChildIndex = m_io.ReadU4le();
            }
            private bool f_hasLeftChild;
            private bool _hasLeftChild;

            /// <summary>
            /// True if this node has a left child
            /// </summary>
            public bool HasLeftChild
            {
                get
                {
                    if (f_hasLeftChild)
                        return _hasLeftChild;
                    f_hasLeftChild = true;
                    _hasLeftChild = (bool) (LeftChildIndex != 4294967295);
                    return _hasLeftChild;
                }
            }
            private bool f_hasRightChild;
            private bool _hasRightChild;

            /// <summary>
            /// True if this node has a right child
            /// </summary>
            public bool HasRightChild
            {
                get
                {
                    if (f_hasRightChild)
                        return _hasRightChild;
                    f_hasRightChild = true;
                    _hasRightChild = (bool) (RightChildIndex != 4294967295);
                    return _hasRightChild;
                }
            }
            private bool f_isInternalNode;
            private bool _isInternalNode;

            /// <summary>
            /// True if this is an internal node (has children), false if leaf node
            /// </summary>
            public bool IsInternalNode
            {
                get
                {
                    if (f_isInternalNode)
                        return _isInternalNode;
                    f_isInternalNode = true;
                    _isInternalNode = (bool) (FaceIndex == -1);
                    return _isInternalNode;
                }
            }
            private bool f_isLeafNode;
            private bool _isLeafNode;

            /// <summary>
            /// True if this is a leaf node (contains a face), false if internal node
            /// </summary>
            public bool IsLeafNode
            {
                get
                {
                    if (f_isLeafNode)
                        return _isLeafNode;
                    f_isLeafNode = true;
                    _isLeafNode = (bool) (FaceIndex != -1);
                    return _isLeafNode;
                }
            }
            private Vec3f _boundsMin;
            private Vec3f _boundsMax;
            private int _faceIndex;
            private uint _unknown;
            private uint _mostSignificantPlane;
            private uint _leftChildIndex;
            private uint _rightChildIndex;
            private Bwm m_root;
            private Bwm.AabbNodesArray m_parent;

            /// <summary>
            /// Minimum bounding box coordinates (x, y, z).
            /// Defines the lower corner of the axis-aligned bounding box.
            /// </summary>
            public Vec3f BoundsMin { get { return _boundsMin; } }

            /// <summary>
            /// Maximum bounding box coordinates (x, y, z).
            /// Defines the upper corner of the axis-aligned bounding box.
            /// </summary>
            public Vec3f BoundsMax { get { return _boundsMax; } }

            /// <summary>
            /// Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
            /// Leaf nodes contain a single face, internal nodes contain child nodes.
            /// </summary>
            public int FaceIndex { get { return _faceIndex; } }

            /// <summary>
            /// Unknown field (typically 4).
            /// Purpose is undocumented but appears in all AABB nodes.
            /// </summary>
            public uint Unknown { get { return _unknown; } }

            /// <summary>
            /// Split axis/plane identifier:
            /// - 0x00 = No children (leaf node)
            /// - 0x01 = Positive X axis split
            /// - 0x02 = Positive Y axis split
            /// - 0x03 = Positive Z axis split
            /// - 0xFFFFFFFE (-2) = Negative X axis split
            /// - 0xFFFFFFFD (-3) = Negative Y axis split
            /// - 0xFFFFFFFC (-4) = Negative Z axis split
            /// </summary>
            public uint MostSignificantPlane { get { return _mostSignificantPlane; } }

            /// <summary>
            /// Index to left child node (0-based array index).
            /// 0xFFFFFFFF indicates no left child.
            /// Child indices are 0-based indices into the AABB nodes array.
            /// </summary>
            public uint LeftChildIndex { get { return _leftChildIndex; } }

            /// <summary>
            /// Index to right child node (0-based array index).
            /// 0xFFFFFFFF indicates no right child.
            /// Child indices are 0-based indices into the AABB nodes array.
            /// </summary>
            public uint RightChildIndex { get { return _rightChildIndex; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm.AabbNodesArray M_Parent { get { return m_parent; } }
        }
        public partial class AabbNodesArray : KaitaiStruct
        {
            public static AabbNodesArray FromFile(string fileName)
            {
                return new AabbNodesArray(new KaitaiStream(fileName));
            }

            public AabbNodesArray(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _nodes = new List<AabbNode>();
                for (var i = 0; i < M_Root.DataTableOffsets.AabbCount; i++)
                {
                    _nodes.Add(new AabbNode(m_io, this, m_root));
                }
            }
            private List<AabbNode> _nodes;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Array of AABB tree nodes for spatial acceleration (WOK only).
            /// AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).
            /// </summary>
            public List<AabbNode> Nodes { get { return _nodes; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class AdjacenciesArray : KaitaiStruct
        {
            public static AdjacenciesArray FromFile(string fileName)
            {
                return new AdjacenciesArray(new KaitaiStream(fileName));
            }

            public AdjacenciesArray(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _adjacencies = new List<AdjacencyTriplet>();
                for (var i = 0; i < M_Root.DataTableOffsets.AdjacencyCount; i++)
                {
                    _adjacencies.Add(new AdjacencyTriplet(m_io, this, m_root));
                }
            }
            private List<AdjacencyTriplet> _adjacencies;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Array of adjacency triplets, one per walkable face (WOK only).
            /// Each walkable face has exactly three adjacency entries, one for each edge.
            /// Adjacency count equals the number of walkable faces, not the total face count.
            /// </summary>
            public List<AdjacencyTriplet> Adjacencies { get { return _adjacencies; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class AdjacencyTriplet : KaitaiStruct
        {
            public static AdjacencyTriplet FromFile(string fileName)
            {
                return new AdjacencyTriplet(new KaitaiStream(fileName));
            }

            public AdjacencyTriplet(KaitaiStream p__io, Bwm.AdjacenciesArray p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_edge0FaceIndex = false;
                f_edge0HasNeighbor = false;
                f_edge0LocalEdge = false;
                f_edge1FaceIndex = false;
                f_edge1HasNeighbor = false;
                f_edge1LocalEdge = false;
                f_edge2FaceIndex = false;
                f_edge2HasNeighbor = false;
                f_edge2LocalEdge = false;
                _read();
            }
            private void _read()
            {
                _edge0Adjacency = m_io.ReadS4le();
                _edge1Adjacency = m_io.ReadS4le();
                _edge2Adjacency = m_io.ReadS4le();
            }
            private bool f_edge0FaceIndex;
            private int _edge0FaceIndex;

            /// <summary>
            /// Face index of adjacent face for edge 0 (decoded from adjacency index)
            /// </summary>
            public int Edge0FaceIndex
            {
                get
                {
                    if (f_edge0FaceIndex)
                        return _edge0FaceIndex;
                    f_edge0FaceIndex = true;
                    _edge0FaceIndex = (int) ((Edge0Adjacency != -1 ? Edge0Adjacency / 3 : -1));
                    return _edge0FaceIndex;
                }
            }
            private bool f_edge0HasNeighbor;
            private bool _edge0HasNeighbor;

            /// <summary>
            /// True if edge 0 has an adjacent walkable face
            /// </summary>
            public bool Edge0HasNeighbor
            {
                get
                {
                    if (f_edge0HasNeighbor)
                        return _edge0HasNeighbor;
                    f_edge0HasNeighbor = true;
                    _edge0HasNeighbor = (bool) (Edge0Adjacency != -1);
                    return _edge0HasNeighbor;
                }
            }
            private bool f_edge0LocalEdge;
            private int _edge0LocalEdge;

            /// <summary>
            /// Local edge index (0, 1, or 2) of adjacent face for edge 0
            /// </summary>
            public int Edge0LocalEdge
            {
                get
                {
                    if (f_edge0LocalEdge)
                        return _edge0LocalEdge;
                    f_edge0LocalEdge = true;
                    _edge0LocalEdge = (int) ((Edge0Adjacency != -1 ? KaitaiStream.Mod(Edge0Adjacency, 3) : -1));
                    return _edge0LocalEdge;
                }
            }
            private bool f_edge1FaceIndex;
            private int _edge1FaceIndex;

            /// <summary>
            /// Face index of adjacent face for edge 1 (decoded from adjacency index)
            /// </summary>
            public int Edge1FaceIndex
            {
                get
                {
                    if (f_edge1FaceIndex)
                        return _edge1FaceIndex;
                    f_edge1FaceIndex = true;
                    _edge1FaceIndex = (int) ((Edge1Adjacency != -1 ? Edge1Adjacency / 3 : -1));
                    return _edge1FaceIndex;
                }
            }
            private bool f_edge1HasNeighbor;
            private bool _edge1HasNeighbor;

            /// <summary>
            /// True if edge 1 has an adjacent walkable face
            /// </summary>
            public bool Edge1HasNeighbor
            {
                get
                {
                    if (f_edge1HasNeighbor)
                        return _edge1HasNeighbor;
                    f_edge1HasNeighbor = true;
                    _edge1HasNeighbor = (bool) (Edge1Adjacency != -1);
                    return _edge1HasNeighbor;
                }
            }
            private bool f_edge1LocalEdge;
            private int _edge1LocalEdge;

            /// <summary>
            /// Local edge index (0, 1, or 2) of adjacent face for edge 1
            /// </summary>
            public int Edge1LocalEdge
            {
                get
                {
                    if (f_edge1LocalEdge)
                        return _edge1LocalEdge;
                    f_edge1LocalEdge = true;
                    _edge1LocalEdge = (int) ((Edge1Adjacency != -1 ? KaitaiStream.Mod(Edge1Adjacency, 3) : -1));
                    return _edge1LocalEdge;
                }
            }
            private bool f_edge2FaceIndex;
            private int _edge2FaceIndex;

            /// <summary>
            /// Face index of adjacent face for edge 2 (decoded from adjacency index)
            /// </summary>
            public int Edge2FaceIndex
            {
                get
                {
                    if (f_edge2FaceIndex)
                        return _edge2FaceIndex;
                    f_edge2FaceIndex = true;
                    _edge2FaceIndex = (int) ((Edge2Adjacency != -1 ? Edge2Adjacency / 3 : -1));
                    return _edge2FaceIndex;
                }
            }
            private bool f_edge2HasNeighbor;
            private bool _edge2HasNeighbor;

            /// <summary>
            /// True if edge 2 has an adjacent walkable face
            /// </summary>
            public bool Edge2HasNeighbor
            {
                get
                {
                    if (f_edge2HasNeighbor)
                        return _edge2HasNeighbor;
                    f_edge2HasNeighbor = true;
                    _edge2HasNeighbor = (bool) (Edge2Adjacency != -1);
                    return _edge2HasNeighbor;
                }
            }
            private bool f_edge2LocalEdge;
            private int _edge2LocalEdge;

            /// <summary>
            /// Local edge index (0, 1, or 2) of adjacent face for edge 2
            /// </summary>
            public int Edge2LocalEdge
            {
                get
                {
                    if (f_edge2LocalEdge)
                        return _edge2LocalEdge;
                    f_edge2LocalEdge = true;
                    _edge2LocalEdge = (int) ((Edge2Adjacency != -1 ? KaitaiStream.Mod(Edge2Adjacency, 3) : -1));
                    return _edge2LocalEdge;
                }
            }
            private int _edge0Adjacency;
            private int _edge1Adjacency;
            private int _edge2Adjacency;
            private Bwm m_root;
            private Bwm.AdjacenciesArray m_parent;

            /// <summary>
            /// Adjacency index for edge 0 (between v1 and v2).
            /// Encoding: face_index * 3 + edge_index
            /// -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
            /// </summary>
            public int Edge0Adjacency { get { return _edge0Adjacency; } }

            /// <summary>
            /// Adjacency index for edge 1 (between v2 and v3).
            /// Encoding: face_index * 3 + edge_index
            /// -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
            /// </summary>
            public int Edge1Adjacency { get { return _edge1Adjacency; } }

            /// <summary>
            /// Adjacency index for edge 2 (between v3 and v1).
            /// Encoding: face_index * 3 + edge_index
            /// -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
            /// </summary>
            public int Edge2Adjacency { get { return _edge2Adjacency; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm.AdjacenciesArray M_Parent { get { return m_parent; } }
        }
        public partial class BwmHeader : KaitaiStruct
        {
            public static BwmHeader FromFile(string fileName)
            {
                return new BwmHeader(new KaitaiStream(fileName));
            }

            public BwmHeader(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_isValidBwm = false;
                _read();
            }
            private void _read()
            {
                _magic = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                _version = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            }
            private bool f_isValidBwm;
            private bool _isValidBwm;

            /// <summary>
            /// Validation check that the file is a valid BWM file.
            /// Both magic and version must match expected values.
            /// </summary>
            public bool IsValidBwm
            {
                get
                {
                    if (f_isValidBwm)
                        return _isValidBwm;
                    f_isValidBwm = true;
                    _isValidBwm = (bool) ( ((Magic == "BWM ") && (Version == "V1.0")) );
                    return _isValidBwm;
                }
            }
            private string _magic;
            private string _version;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// File type signature. Must be &quot;BWM &quot; (space-padded).
            /// The space after &quot;BWM&quot; is significant and must be present.
            /// </summary>
            public string Magic { get { return _magic; } }

            /// <summary>
            /// File format version. Always &quot;V1.0&quot; for KotOR BWM files.
            /// This is the first and only version of the BWM format used in KotOR games.
            /// </summary>
            public string Version { get { return _version; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class DataTableOffsets : KaitaiStruct
        {
            public static DataTableOffsets FromFile(string fileName)
            {
                return new DataTableOffsets(new KaitaiStream(fileName));
            }

            public DataTableOffsets(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _vertexCount = m_io.ReadU4le();
                _vertexOffset = m_io.ReadU4le();
                _faceCount = m_io.ReadU4le();
                _faceIndicesOffset = m_io.ReadU4le();
                _materialsOffset = m_io.ReadU4le();
                _normalsOffset = m_io.ReadU4le();
                _distancesOffset = m_io.ReadU4le();
                _aabbCount = m_io.ReadU4le();
                _aabbOffset = m_io.ReadU4le();
                _unknown = m_io.ReadU4le();
                _adjacencyCount = m_io.ReadU4le();
                _adjacencyOffset = m_io.ReadU4le();
                _edgeCount = m_io.ReadU4le();
                _edgeOffset = m_io.ReadU4le();
                _perimeterCount = m_io.ReadU4le();
                _perimeterOffset = m_io.ReadU4le();
            }
            private uint _vertexCount;
            private uint _vertexOffset;
            private uint _faceCount;
            private uint _faceIndicesOffset;
            private uint _materialsOffset;
            private uint _normalsOffset;
            private uint _distancesOffset;
            private uint _aabbCount;
            private uint _aabbOffset;
            private uint _unknown;
            private uint _adjacencyCount;
            private uint _adjacencyOffset;
            private uint _edgeCount;
            private uint _edgeOffset;
            private uint _perimeterCount;
            private uint _perimeterOffset;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Number of vertices in the walkmesh
            /// </summary>
            public uint VertexCount { get { return _vertexCount; } }

            /// <summary>
            /// Byte offset to vertex array from the beginning of the file
            /// </summary>
            public uint VertexOffset { get { return _vertexOffset; } }

            /// <summary>
            /// Number of faces (triangles) in the walkmesh
            /// </summary>
            public uint FaceCount { get { return _faceCount; } }

            /// <summary>
            /// Byte offset to face indices array from the beginning of the file
            /// </summary>
            public uint FaceIndicesOffset { get { return _faceIndicesOffset; } }

            /// <summary>
            /// Byte offset to materials array from the beginning of the file
            /// </summary>
            public uint MaterialsOffset { get { return _materialsOffset; } }

            /// <summary>
            /// Byte offset to face normals array from the beginning of the file.
            /// Only used for WOK files (area walkmeshes).
            /// </summary>
            public uint NormalsOffset { get { return _normalsOffset; } }

            /// <summary>
            /// Byte offset to planar distances array from the beginning of the file.
            /// Only used for WOK files (area walkmeshes).
            /// </summary>
            public uint DistancesOffset { get { return _distancesOffset; } }

            /// <summary>
            /// Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
            /// AABB trees provide spatial acceleration for raycasting and point queries.
            /// </summary>
            public uint AabbCount { get { return _aabbCount; } }

            /// <summary>
            /// Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
            /// Only present if aabb_count &gt; 0.
            /// </summary>
            public uint AabbOffset { get { return _aabbOffset; } }

            /// <summary>
            /// Unknown field (typically 0 or 4).
            /// Purpose is undocumented but appears in all BWM files.
            /// </summary>
            public uint Unknown { get { return _unknown; } }

            /// <summary>
            /// Number of walkable faces for adjacency data (WOK only).
            /// This equals the number of walkable faces, not the total face count.
            /// Adjacencies are stored only for walkable faces.
            /// </summary>
            public uint AdjacencyCount { get { return _adjacencyCount; } }

            /// <summary>
            /// Byte offset to adjacency array from the beginning of the file (WOK only).
            /// Only present if adjacency_count &gt; 0.
            /// </summary>
            public uint AdjacencyOffset { get { return _adjacencyOffset; } }

            /// <summary>
            /// Number of perimeter edges (WOK only).
            /// Perimeter edges are boundary edges with no walkable neighbor.
            /// </summary>
            public uint EdgeCount { get { return _edgeCount; } }

            /// <summary>
            /// Byte offset to edges array from the beginning of the file (WOK only).
            /// Only present if edge_count &gt; 0.
            /// </summary>
            public uint EdgeOffset { get { return _edgeOffset; } }

            /// <summary>
            /// Number of perimeter markers (WOK only).
            /// Perimeter markers indicate the end of closed loops of perimeter edges.
            /// </summary>
            public uint PerimeterCount { get { return _perimeterCount; } }

            /// <summary>
            /// Byte offset to perimeters array from the beginning of the file (WOK only).
            /// Only present if perimeter_count &gt; 0.
            /// </summary>
            public uint PerimeterOffset { get { return _perimeterOffset; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class EdgeEntry : KaitaiStruct
        {
            public static EdgeEntry FromFile(string fileName)
            {
                return new EdgeEntry(new KaitaiStream(fileName));
            }

            public EdgeEntry(KaitaiStream p__io, Bwm.EdgesArray p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_faceIndex = false;
                f_hasTransition = false;
                f_localEdgeIndex = false;
                _read();
            }
            private void _read()
            {
                _edgeIndex = m_io.ReadU4le();
                _transition = m_io.ReadS4le();
            }
            private bool f_faceIndex;
            private int _faceIndex;

            /// <summary>
            /// Face index that this edge belongs to (decoded from edge_index)
            /// </summary>
            public int FaceIndex
            {
                get
                {
                    if (f_faceIndex)
                        return _faceIndex;
                    f_faceIndex = true;
                    _faceIndex = (int) (EdgeIndex / 3);
                    return _faceIndex;
                }
            }
            private bool f_hasTransition;
            private bool _hasTransition;

            /// <summary>
            /// True if this edge has a transition ID (links to door/area connection)
            /// </summary>
            public bool HasTransition
            {
                get
                {
                    if (f_hasTransition)
                        return _hasTransition;
                    f_hasTransition = true;
                    _hasTransition = (bool) (Transition != -1);
                    return _hasTransition;
                }
            }
            private bool f_localEdgeIndex;
            private int _localEdgeIndex;

            /// <summary>
            /// Local edge index (0, 1, or 2) within the face (decoded from edge_index)
            /// </summary>
            public int LocalEdgeIndex
            {
                get
                {
                    if (f_localEdgeIndex)
                        return _localEdgeIndex;
                    f_localEdgeIndex = true;
                    _localEdgeIndex = (int) (KaitaiStream.Mod(EdgeIndex, 3));
                    return _localEdgeIndex;
                }
            }
            private uint _edgeIndex;
            private int _transition;
            private Bwm m_root;
            private Bwm.EdgesArray m_parent;

            /// <summary>
            /// Encoded edge index: face_index * 3 + local_edge_index
            /// Identifies which face and which edge (0, 1, or 2) of that face.
            /// Edge 0: between v1 and v2
            /// Edge 1: between v2 and v3
            /// Edge 2: between v3 and v1
            /// </summary>
            public uint EdgeIndex { get { return _edgeIndex; } }

            /// <summary>
            /// Transition ID for room/area connections, -1 if no transition.
            /// Non-negative values reference door connections or area boundaries.
            /// -1 indicates this is just a boundary edge with no transition.
            /// </summary>
            public int Transition { get { return _transition; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm.EdgesArray M_Parent { get { return m_parent; } }
        }
        public partial class EdgesArray : KaitaiStruct
        {
            public static EdgesArray FromFile(string fileName)
            {
                return new EdgesArray(new KaitaiStream(fileName));
            }

            public EdgesArray(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _edges = new List<EdgeEntry>();
                for (var i = 0; i < M_Root.DataTableOffsets.EdgeCount; i++)
                {
                    _edges.Add(new EdgeEntry(m_io, this, m_root));
                }
            }
            private List<EdgeEntry> _edges;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Array of perimeter edges (WOK only).
            /// Perimeter edges are boundary edges with no walkable neighbor.
            /// Each edge entry contains an edge index and optional transition ID.
            /// </summary>
            public List<EdgeEntry> Edges { get { return _edges; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class FaceIndices : KaitaiStruct
        {
            public static FaceIndices FromFile(string fileName)
            {
                return new FaceIndices(new KaitaiStream(fileName));
            }

            public FaceIndices(KaitaiStream p__io, Bwm.FaceIndicesArray p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _v1Index = m_io.ReadU4le();
                _v2Index = m_io.ReadU4le();
                _v3Index = m_io.ReadU4le();
            }
            private uint _v1Index;
            private uint _v2Index;
            private uint _v3Index;
            private Bwm m_root;
            private Bwm.FaceIndicesArray m_parent;

            /// <summary>
            /// Vertex index for first vertex of triangle (0-based index into vertices array).
            /// Vertex indices define the triangle's vertices in counter-clockwise order
            /// when viewed from the front (the side the normal points toward).
            /// </summary>
            public uint V1Index { get { return _v1Index; } }

            /// <summary>
            /// Vertex index for second vertex of triangle (0-based index into vertices array).
            /// </summary>
            public uint V2Index { get { return _v2Index; } }

            /// <summary>
            /// Vertex index for third vertex of triangle (0-based index into vertices array).
            /// </summary>
            public uint V3Index { get { return _v3Index; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm.FaceIndicesArray M_Parent { get { return m_parent; } }
        }
        public partial class FaceIndicesArray : KaitaiStruct
        {
            public static FaceIndicesArray FromFile(string fileName)
            {
                return new FaceIndicesArray(new KaitaiStream(fileName));
            }

            public FaceIndicesArray(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _faces = new List<FaceIndices>();
                for (var i = 0; i < M_Root.DataTableOffsets.FaceCount; i++)
                {
                    _faces.Add(new FaceIndices(m_io, this, m_root));
                }
            }
            private List<FaceIndices> _faces;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Array of face vertex index triplets
            /// </summary>
            public List<FaceIndices> Faces { get { return _faces; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class MaterialsArray : KaitaiStruct
        {
            public static MaterialsArray FromFile(string fileName)
            {
                return new MaterialsArray(new KaitaiStream(fileName));
            }

            public MaterialsArray(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _materials = new List<uint>();
                for (var i = 0; i < M_Root.DataTableOffsets.FaceCount; i++)
                {
                    _materials.Add(m_io.ReadU4le());
                }
            }
            private List<uint> _materials;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Array of surface material IDs, one per face.
            /// Material IDs determine walkability and physical properties:
            /// - 0 = NotDefined/UNDEFINED (non-walkable)
            /// - 1 = Dirt (walkable)
            /// - 2 = Obscuring (non-walkable, blocks line of sight)
            /// - 3 = Grass (walkable)
            /// - 4 = Stone (walkable)
            /// - 5 = Wood (walkable)
            /// - 6 = Water (walkable)
            /// - 7 = Nonwalk/NON_WALK (non-walkable)
            /// - 8 = Transparent (non-walkable)
            /// - 9 = Carpet (walkable)
            /// - 10 = Metal (walkable)
            /// - 11 = Puddles (walkable)
            /// - 12 = Swamp (walkable)
            /// - 13 = Mud (walkable)
            /// - 14 = Leaves (walkable)
            /// - 15 = Lava (non-walkable, damage-dealing)
            /// - 16 = BottomlessPit (walkable but dangerous)
            /// - 17 = DeepWater (non-walkable)
            /// - 18 = Door (walkable, special handling)
            /// - 19 = Snow/NON_WALK_GRASS (non-walkable)
            /// - 20+ = Additional materials (Sand, BareBones, StoneBridge, etc.)
            /// </summary>
            public List<uint> Materials { get { return _materials; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class NormalsArray : KaitaiStruct
        {
            public static NormalsArray FromFile(string fileName)
            {
                return new NormalsArray(new KaitaiStream(fileName));
            }

            public NormalsArray(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _normals = new List<Vec3f>();
                for (var i = 0; i < M_Root.DataTableOffsets.FaceCount; i++)
                {
                    _normals.Add(new Vec3f(m_io, this, m_root));
                }
            }
            private List<Vec3f> _normals;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Array of face normal vectors, one per face (WOK only).
            /// Normals are precomputed unit vectors perpendicular to each face.
            /// Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
            /// Normal direction follows right-hand rule based on vertex winding order.
            /// </summary>
            public List<Vec3f> Normals { get { return _normals; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class PerimetersArray : KaitaiStruct
        {
            public static PerimetersArray FromFile(string fileName)
            {
                return new PerimetersArray(new KaitaiStream(fileName));
            }

            public PerimetersArray(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _perimeters = new List<uint>();
                for (var i = 0; i < M_Root.DataTableOffsets.PerimeterCount; i++)
                {
                    _perimeters.Add(m_io.ReadU4le());
                }
            }
            private List<uint> _perimeters;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Array of perimeter markers (WOK only).
            /// Each value is an index into the edges array, marking the end of a perimeter loop.
            /// Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
            /// Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.
            /// </summary>
            public List<uint> Perimeters { get { return _perimeters; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class PlanarDistancesArray : KaitaiStruct
        {
            public static PlanarDistancesArray FromFile(string fileName)
            {
                return new PlanarDistancesArray(new KaitaiStream(fileName));
            }

            public PlanarDistancesArray(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _distances = new List<float>();
                for (var i = 0; i < M_Root.DataTableOffsets.FaceCount; i++)
                {
                    _distances.Add(m_io.ReadF4le());
                }
            }
            private List<float> _distances;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Array of planar distances, one per face (WOK only).
            /// The D component of the plane equation ax + by + cz + d = 0.
            /// Calculated as d = -normal · vertex1 for each face.
            /// Precomputed to allow quick point-plane relationship tests.
            /// </summary>
            public List<float> Distances { get { return _distances; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class Vec3f : KaitaiStruct
        {
            public static Vec3f FromFile(string fileName)
            {
                return new Vec3f(new KaitaiStream(fileName));
            }

            public Vec3f(KaitaiStream p__io, KaitaiStruct p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _x = m_io.ReadF4le();
                _y = m_io.ReadF4le();
                _z = m_io.ReadF4le();
            }
            private float _x;
            private float _y;
            private float _z;
            private Bwm m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// X coordinate (float32)
            /// </summary>
            public float X { get { return _x; } }

            /// <summary>
            /// Y coordinate (float32)
            /// </summary>
            public float Y { get { return _y; } }

            /// <summary>
            /// Z coordinate (float32)
            /// </summary>
            public float Z { get { return _z; } }
            public Bwm M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        public partial class VerticesArray : KaitaiStruct
        {
            public static VerticesArray FromFile(string fileName)
            {
                return new VerticesArray(new KaitaiStream(fileName));
            }

            public VerticesArray(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _vertices = new List<Vec3f>();
                for (var i = 0; i < M_Root.DataTableOffsets.VertexCount; i++)
                {
                    _vertices.Add(new Vec3f(m_io, this, m_root));
                }
            }
            private List<Vec3f> _vertices;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Array of vertex positions, each vertex is a float3 (x, y, z)
            /// </summary>
            public List<Vec3f> Vertices { get { return _vertices; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        public partial class WalkmeshProperties : KaitaiStruct
        {
            public static WalkmeshProperties FromFile(string fileName)
            {
                return new WalkmeshProperties(new KaitaiStream(fileName));
            }

            public WalkmeshProperties(KaitaiStream p__io, Bwm p__parent = null, Bwm p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_isAreaWalkmesh = false;
                f_isPlaceableOrDoor = false;
                _read();
            }
            private void _read()
            {
                _walkmeshType = m_io.ReadU4le();
                _relativeUsePosition1 = new Vec3f(m_io, this, m_root);
                _relativeUsePosition2 = new Vec3f(m_io, this, m_root);
                _absoluteUsePosition1 = new Vec3f(m_io, this, m_root);
                _absoluteUsePosition2 = new Vec3f(m_io, this, m_root);
                _position = new Vec3f(m_io, this, m_root);
            }
            private bool f_isAreaWalkmesh;
            private bool _isAreaWalkmesh;

            /// <summary>
            /// True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)
            /// </summary>
            public bool IsAreaWalkmesh
            {
                get
                {
                    if (f_isAreaWalkmesh)
                        return _isAreaWalkmesh;
                    f_isAreaWalkmesh = true;
                    _isAreaWalkmesh = (bool) (WalkmeshType == 1);
                    return _isAreaWalkmesh;
                }
            }
            private bool f_isPlaceableOrDoor;
            private bool _isPlaceableOrDoor;

            /// <summary>
            /// True if this is a placeable or door walkmesh (PWK/DWK)
            /// </summary>
            public bool IsPlaceableOrDoor
            {
                get
                {
                    if (f_isPlaceableOrDoor)
                        return _isPlaceableOrDoor;
                    f_isPlaceableOrDoor = true;
                    _isPlaceableOrDoor = (bool) (WalkmeshType == 0);
                    return _isPlaceableOrDoor;
                }
            }
            private uint _walkmeshType;
            private Vec3f _relativeUsePosition1;
            private Vec3f _relativeUsePosition2;
            private Vec3f _absoluteUsePosition1;
            private Vec3f _absoluteUsePosition2;
            private Vec3f _position;
            private Bwm m_root;
            private Bwm m_parent;

            /// <summary>
            /// Walkmesh type identifier:
            /// - 0 = PWK/DWK (Placeable/Door walkmesh)
            /// - 1 = WOK (Area walkmesh)
            /// </summary>
            public uint WalkmeshType { get { return _walkmeshType; } }

            /// <summary>
            /// Relative use hook position 1 (x, y, z).
            /// Position relative to the walkmesh origin, used when the walkmesh may be transformed.
            /// For doors: Defines where the player must stand to interact (relative to door model).
            /// For placeables: Defines interaction points relative to the object's local coordinate system.
            /// </summary>
            public Vec3f RelativeUsePosition1 { get { return _relativeUsePosition1; } }

            /// <summary>
            /// Relative use hook position 2 (x, y, z).
            /// Second interaction point relative to the walkmesh origin.
            /// </summary>
            public Vec3f RelativeUsePosition2 { get { return _relativeUsePosition2; } }

            /// <summary>
            /// Absolute use hook position 1 (x, y, z).
            /// Position in world space, used when the walkmesh position is known.
            /// For doors: Precomputed world-space interaction points (position + relative hook).
            /// For placeables: World-space interaction points accounting for object placement.
            /// </summary>
            public Vec3f AbsoluteUsePosition1 { get { return _absoluteUsePosition1; } }

            /// <summary>
            /// Absolute use hook position 2 (x, y, z).
            /// Second absolute interaction point in world space.
            /// </summary>
            public Vec3f AbsoluteUsePosition2 { get { return _absoluteUsePosition2; } }

            /// <summary>
            /// Walkmesh position offset (x, y, z) in world space.
            /// For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
            /// For placeable/door walkmeshes: The position where the object is placed in the area.
            /// Used to transform vertices from local to world coordinates.
            /// </summary>
            public Vec3f Position { get { return _position; } }
            public Bwm M_Root { get { return m_root; } }
            public Bwm M_Parent { get { return m_parent; } }
        }
        private bool f_aabbNodes;
        private AabbNodesArray _aabbNodes;

        /// <summary>
        /// Array of AABB tree nodes for spatial acceleration - WOK only
        /// </summary>
        public AabbNodesArray AabbNodes
        {
            get
            {
                if (f_aabbNodes)
                    return _aabbNodes;
                f_aabbNodes = true;
                if ( ((M_Root.WalkmeshProperties.WalkmeshType == 1) && (M_Root.DataTableOffsets.AabbCount > 0)) ) {
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataTableOffsets.AabbOffset);
                    _aabbNodes = new AabbNodesArray(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _aabbNodes;
            }
        }
        private bool f_adjacencies;
        private AdjacenciesArray _adjacencies;

        /// <summary>
        /// Array of adjacency indices (int32 triplets per walkable face) - WOK only
        /// </summary>
        public AdjacenciesArray Adjacencies
        {
            get
            {
                if (f_adjacencies)
                    return _adjacencies;
                f_adjacencies = true;
                if ( ((M_Root.WalkmeshProperties.WalkmeshType == 1) && (M_Root.DataTableOffsets.AdjacencyCount > 0)) ) {
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataTableOffsets.AdjacencyOffset);
                    _adjacencies = new AdjacenciesArray(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _adjacencies;
            }
        }
        private bool f_edges;
        private EdgesArray _edges;

        /// <summary>
        /// Array of perimeter edges (edge_index, transition pairs) - WOK only
        /// </summary>
        public EdgesArray Edges
        {
            get
            {
                if (f_edges)
                    return _edges;
                f_edges = true;
                if ( ((M_Root.WalkmeshProperties.WalkmeshType == 1) && (M_Root.DataTableOffsets.EdgeCount > 0)) ) {
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataTableOffsets.EdgeOffset);
                    _edges = new EdgesArray(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _edges;
            }
        }
        private bool f_faceIndices;
        private FaceIndicesArray _faceIndices;

        /// <summary>
        /// Array of face vertex indices (uint32 triplets)
        /// </summary>
        public FaceIndicesArray FaceIndices
        {
            get
            {
                if (f_faceIndices)
                    return _faceIndices;
                f_faceIndices = true;
                if (M_Root.DataTableOffsets.FaceCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataTableOffsets.FaceIndicesOffset);
                    _faceIndices = new FaceIndicesArray(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _faceIndices;
            }
        }
        private bool f_materials;
        private MaterialsArray _materials;

        /// <summary>
        /// Array of surface material IDs per face
        /// </summary>
        public MaterialsArray Materials
        {
            get
            {
                if (f_materials)
                    return _materials;
                f_materials = true;
                if (M_Root.DataTableOffsets.FaceCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataTableOffsets.MaterialsOffset);
                    _materials = new MaterialsArray(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _materials;
            }
        }
        private bool f_normals;
        private NormalsArray _normals;

        /// <summary>
        /// Array of face normal vectors (float3 triplets) - WOK only
        /// </summary>
        public NormalsArray Normals
        {
            get
            {
                if (f_normals)
                    return _normals;
                f_normals = true;
                if ( ((M_Root.WalkmeshProperties.WalkmeshType == 1) && (M_Root.DataTableOffsets.FaceCount > 0)) ) {
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataTableOffsets.NormalsOffset);
                    _normals = new NormalsArray(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _normals;
            }
        }
        private bool f_perimeters;
        private PerimetersArray _perimeters;

        /// <summary>
        /// Array of perimeter markers (edge indices marking end of loops) - WOK only
        /// </summary>
        public PerimetersArray Perimeters
        {
            get
            {
                if (f_perimeters)
                    return _perimeters;
                f_perimeters = true;
                if ( ((M_Root.WalkmeshProperties.WalkmeshType == 1) && (M_Root.DataTableOffsets.PerimeterCount > 0)) ) {
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataTableOffsets.PerimeterOffset);
                    _perimeters = new PerimetersArray(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _perimeters;
            }
        }
        private bool f_planarDistances;
        private PlanarDistancesArray _planarDistances;

        /// <summary>
        /// Array of planar distances (float32 per face) - WOK only
        /// </summary>
        public PlanarDistancesArray PlanarDistances
        {
            get
            {
                if (f_planarDistances)
                    return _planarDistances;
                f_planarDistances = true;
                if ( ((M_Root.WalkmeshProperties.WalkmeshType == 1) && (M_Root.DataTableOffsets.FaceCount > 0)) ) {
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataTableOffsets.DistancesOffset);
                    _planarDistances = new PlanarDistancesArray(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _planarDistances;
            }
        }
        private bool f_vertices;
        private VerticesArray _vertices;

        /// <summary>
        /// Array of vertex positions (float3 triplets)
        /// </summary>
        public VerticesArray Vertices
        {
            get
            {
                if (f_vertices)
                    return _vertices;
                f_vertices = true;
                if (M_Root.DataTableOffsets.VertexCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataTableOffsets.VertexOffset);
                    _vertices = new VerticesArray(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _vertices;
            }
        }
        private BwmHeader _header;
        private WalkmeshProperties _walkmeshProperties;
        private DataTableOffsets _dataTableOffsets;
        private Bwm m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// BWM file header (8 bytes) - magic and version signature
        /// </summary>
        public BwmHeader Header { get { return _header; } }

        /// <summary>
        /// Walkmesh properties section (52 bytes) - type, hooks, position
        /// </summary>
        public WalkmeshProperties WalkmeshProperties { get { return _walkmeshProperties; } }

        /// <summary>
        /// Data table offsets section (84 bytes) - counts and offsets for all data tables
        /// </summary>
        public DataTableOffsets DataTableOffsets { get { return _dataTableOffsets; } }
        public Bwm M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}
