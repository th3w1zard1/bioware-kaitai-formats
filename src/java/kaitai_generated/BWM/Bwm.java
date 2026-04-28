// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.nio.charset.StandardCharsets;


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
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no BWM-specific tool)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm">PyKotor wiki — BWM</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L56-L110">PyKotor — Kaitai-backed BWM struct load</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L187-L253">PyKotor — BWMBinaryReader.load</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L42-L113">xoreos — WalkmeshLoader::load</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L119-L216">xoreos — WalkmeshLoader (append tables / WOK-only paths)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L218-L249">xoreos — WalkmeshLoader::getAABB</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L27-L92">reone — BwmReader::load</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L94-L171">reone — BwmReader (AABB / adjacency tables)</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L301-L395">KotOR.js — readBinary</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L490-L516">KotOR.js — header / version constants</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no dedicated BWM / walkmesh Torlack page; use engine + PyKotor xrefs above)</a>
 */
public class Bwm extends KaitaiStruct {
    public static Bwm fromFile(String fileName) throws IOException {
        return new Bwm(new ByteBufferKaitaiStream(fileName));
    }

    public Bwm(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Bwm(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Bwm(KaitaiStream _io, KaitaiStruct _parent, Bwm _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new BwmHeader(this._io, this, _root);
        this.walkmeshProperties = new WalkmeshProperties(this._io, this, _root);
        this.dataTableOffsets = new DataTableOffsets(this._io, this, _root);
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
        this.walkmeshProperties._fetchInstances();
        this.dataTableOffsets._fetchInstances();
        aabbNodes();
        if (this.aabbNodes != null) {
            this.aabbNodes._fetchInstances();
        }
        adjacencies();
        if (this.adjacencies != null) {
            this.adjacencies._fetchInstances();
        }
        edges();
        if (this.edges != null) {
            this.edges._fetchInstances();
        }
        faceIndices();
        if (this.faceIndices != null) {
            this.faceIndices._fetchInstances();
        }
        materials();
        if (this.materials != null) {
            this.materials._fetchInstances();
        }
        normals();
        if (this.normals != null) {
            this.normals._fetchInstances();
        }
        perimeters();
        if (this.perimeters != null) {
            this.perimeters._fetchInstances();
        }
        planarDistances();
        if (this.planarDistances != null) {
            this.planarDistances._fetchInstances();
        }
        vertices();
        if (this.vertices != null) {
            this.vertices._fetchInstances();
        }
    }
    public static class AabbNode extends KaitaiStruct {
        public static AabbNode fromFile(String fileName) throws IOException {
            return new AabbNode(new ByteBufferKaitaiStream(fileName));
        }

        public AabbNode(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AabbNode(KaitaiStream _io, Bwm.AabbNodesArray _parent) {
            this(_io, _parent, null);
        }

        public AabbNode(KaitaiStream _io, Bwm.AabbNodesArray _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.boundsMin = new Vec3f(this._io, this, _root);
            this.boundsMax = new Vec3f(this._io, this, _root);
            this.faceIndex = this._io.readS4le();
            this.unknown = this._io.readU4le();
            this.mostSignificantPlane = this._io.readU4le();
            this.leftChildIndex = this._io.readU4le();
            this.rightChildIndex = this._io.readU4le();
        }

        public void _fetchInstances() {
            this.boundsMin._fetchInstances();
            this.boundsMax._fetchInstances();
        }
        private Boolean hasLeftChild;

        /**
         * True if this node has a left child
         */
        public Boolean hasLeftChild() {
            if (this.hasLeftChild != null)
                return this.hasLeftChild;
            this.hasLeftChild = leftChildIndex() != 4294967295L;
            return this.hasLeftChild;
        }
        private Boolean hasRightChild;

        /**
         * True if this node has a right child
         */
        public Boolean hasRightChild() {
            if (this.hasRightChild != null)
                return this.hasRightChild;
            this.hasRightChild = rightChildIndex() != 4294967295L;
            return this.hasRightChild;
        }
        private Boolean isInternalNode;

        /**
         * True if this is an internal node (has children), false if leaf node
         */
        public Boolean isInternalNode() {
            if (this.isInternalNode != null)
                return this.isInternalNode;
            this.isInternalNode = faceIndex() == -1;
            return this.isInternalNode;
        }
        private Boolean isLeafNode;

        /**
         * True if this is a leaf node (contains a face), false if internal node
         */
        public Boolean isLeafNode() {
            if (this.isLeafNode != null)
                return this.isLeafNode;
            this.isLeafNode = faceIndex() != -1;
            return this.isLeafNode;
        }
        private Vec3f boundsMin;
        private Vec3f boundsMax;
        private int faceIndex;
        private long unknown;
        private long mostSignificantPlane;
        private long leftChildIndex;
        private long rightChildIndex;
        private Bwm _root;
        private Bwm.AabbNodesArray _parent;

        /**
         * Minimum bounding box coordinates (x, y, z).
         * Defines the lower corner of the axis-aligned bounding box.
         */
        public Vec3f boundsMin() { return boundsMin; }

        /**
         * Maximum bounding box coordinates (x, y, z).
         * Defines the upper corner of the axis-aligned bounding box.
         */
        public Vec3f boundsMax() { return boundsMax; }

        /**
         * Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
         * Leaf nodes contain a single face, internal nodes contain child nodes.
         */
        public int faceIndex() { return faceIndex; }

        /**
         * Unknown field (typically 4).
         * Purpose is undocumented but appears in all AABB nodes.
         */
        public long unknown() { return unknown; }

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
        public long mostSignificantPlane() { return mostSignificantPlane; }

        /**
         * Index to left child node (0-based array index).
         * 0xFFFFFFFF indicates no left child.
         * Child indices are 0-based indices into the AABB nodes array.
         */
        public long leftChildIndex() { return leftChildIndex; }

        /**
         * Index to right child node (0-based array index).
         * 0xFFFFFFFF indicates no right child.
         * Child indices are 0-based indices into the AABB nodes array.
         */
        public long rightChildIndex() { return rightChildIndex; }
        public Bwm _root() { return _root; }
        public Bwm.AabbNodesArray _parent() { return _parent; }
    }
    public static class AabbNodesArray extends KaitaiStruct {
        public static AabbNodesArray fromFile(String fileName) throws IOException {
            return new AabbNodesArray(new ByteBufferKaitaiStream(fileName));
        }

        public AabbNodesArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AabbNodesArray(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public AabbNodesArray(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.nodes = new ArrayList<AabbNode>();
            for (int i = 0; i < _root().dataTableOffsets().aabbCount(); i++) {
                this.nodes.add(new AabbNode(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.nodes.size(); i++) {
                this.nodes.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<AabbNode> nodes;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Array of AABB tree nodes for spatial acceleration (WOK only).
         * AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).
         */
        public List<AabbNode> nodes() { return nodes; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class AdjacenciesArray extends KaitaiStruct {
        public static AdjacenciesArray fromFile(String fileName) throws IOException {
            return new AdjacenciesArray(new ByteBufferKaitaiStream(fileName));
        }

        public AdjacenciesArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AdjacenciesArray(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public AdjacenciesArray(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.adjacencies = new ArrayList<AdjacencyTriplet>();
            for (int i = 0; i < _root().dataTableOffsets().adjacencyCount(); i++) {
                this.adjacencies.add(new AdjacencyTriplet(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.adjacencies.size(); i++) {
                this.adjacencies.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<AdjacencyTriplet> adjacencies;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Array of adjacency triplets, one per walkable face (WOK only).
         * Each walkable face has exactly three adjacency entries, one for each edge.
         * Adjacency count equals the number of walkable faces, not the total face count.
         */
        public List<AdjacencyTriplet> adjacencies() { return adjacencies; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class AdjacencyTriplet extends KaitaiStruct {
        public static AdjacencyTriplet fromFile(String fileName) throws IOException {
            return new AdjacencyTriplet(new ByteBufferKaitaiStream(fileName));
        }

        public AdjacencyTriplet(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AdjacencyTriplet(KaitaiStream _io, Bwm.AdjacenciesArray _parent) {
            this(_io, _parent, null);
        }

        public AdjacencyTriplet(KaitaiStream _io, Bwm.AdjacenciesArray _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.edge0Adjacency = this._io.readS4le();
            this.edge1Adjacency = this._io.readS4le();
            this.edge2Adjacency = this._io.readS4le();
        }

        public void _fetchInstances() {
        }
        private Integer edge0FaceIndex;

        /**
         * Face index of adjacent face for edge 0 (decoded from adjacency index)
         */
        public Integer edge0FaceIndex() {
            if (this.edge0FaceIndex != null)
                return this.edge0FaceIndex;
            this.edge0FaceIndex = ((Number) ((edge0Adjacency() != -1 ? edge0Adjacency() / 3 : -1))).intValue();
            return this.edge0FaceIndex;
        }
        private Boolean edge0HasNeighbor;

        /**
         * True if edge 0 has an adjacent walkable face
         */
        public Boolean edge0HasNeighbor() {
            if (this.edge0HasNeighbor != null)
                return this.edge0HasNeighbor;
            this.edge0HasNeighbor = edge0Adjacency() != -1;
            return this.edge0HasNeighbor;
        }
        private Integer edge0LocalEdge;

        /**
         * Local edge index (0, 1, or 2) of adjacent face for edge 0
         */
        public Integer edge0LocalEdge() {
            if (this.edge0LocalEdge != null)
                return this.edge0LocalEdge;
            this.edge0LocalEdge = ((Number) ((edge0Adjacency() != -1 ? KaitaiStream.mod(edge0Adjacency(), 3) : -1))).intValue();
            return this.edge0LocalEdge;
        }
        private Integer edge1FaceIndex;

        /**
         * Face index of adjacent face for edge 1 (decoded from adjacency index)
         */
        public Integer edge1FaceIndex() {
            if (this.edge1FaceIndex != null)
                return this.edge1FaceIndex;
            this.edge1FaceIndex = ((Number) ((edge1Adjacency() != -1 ? edge1Adjacency() / 3 : -1))).intValue();
            return this.edge1FaceIndex;
        }
        private Boolean edge1HasNeighbor;

        /**
         * True if edge 1 has an adjacent walkable face
         */
        public Boolean edge1HasNeighbor() {
            if (this.edge1HasNeighbor != null)
                return this.edge1HasNeighbor;
            this.edge1HasNeighbor = edge1Adjacency() != -1;
            return this.edge1HasNeighbor;
        }
        private Integer edge1LocalEdge;

        /**
         * Local edge index (0, 1, or 2) of adjacent face for edge 1
         */
        public Integer edge1LocalEdge() {
            if (this.edge1LocalEdge != null)
                return this.edge1LocalEdge;
            this.edge1LocalEdge = ((Number) ((edge1Adjacency() != -1 ? KaitaiStream.mod(edge1Adjacency(), 3) : -1))).intValue();
            return this.edge1LocalEdge;
        }
        private Integer edge2FaceIndex;

        /**
         * Face index of adjacent face for edge 2 (decoded from adjacency index)
         */
        public Integer edge2FaceIndex() {
            if (this.edge2FaceIndex != null)
                return this.edge2FaceIndex;
            this.edge2FaceIndex = ((Number) ((edge2Adjacency() != -1 ? edge2Adjacency() / 3 : -1))).intValue();
            return this.edge2FaceIndex;
        }
        private Boolean edge2HasNeighbor;

        /**
         * True if edge 2 has an adjacent walkable face
         */
        public Boolean edge2HasNeighbor() {
            if (this.edge2HasNeighbor != null)
                return this.edge2HasNeighbor;
            this.edge2HasNeighbor = edge2Adjacency() != -1;
            return this.edge2HasNeighbor;
        }
        private Integer edge2LocalEdge;

        /**
         * Local edge index (0, 1, or 2) of adjacent face for edge 2
         */
        public Integer edge2LocalEdge() {
            if (this.edge2LocalEdge != null)
                return this.edge2LocalEdge;
            this.edge2LocalEdge = ((Number) ((edge2Adjacency() != -1 ? KaitaiStream.mod(edge2Adjacency(), 3) : -1))).intValue();
            return this.edge2LocalEdge;
        }
        private int edge0Adjacency;
        private int edge1Adjacency;
        private int edge2Adjacency;
        private Bwm _root;
        private Bwm.AdjacenciesArray _parent;

        /**
         * Adjacency index for edge 0 (between v1 and v2).
         * Encoding: face_index * 3 + edge_index
         * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
         */
        public int edge0Adjacency() { return edge0Adjacency; }

        /**
         * Adjacency index for edge 1 (between v2 and v3).
         * Encoding: face_index * 3 + edge_index
         * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
         */
        public int edge1Adjacency() { return edge1Adjacency; }

        /**
         * Adjacency index for edge 2 (between v3 and v1).
         * Encoding: face_index * 3 + edge_index
         * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
         */
        public int edge2Adjacency() { return edge2Adjacency; }
        public Bwm _root() { return _root; }
        public Bwm.AdjacenciesArray _parent() { return _parent; }
    }
    public static class BwmHeader extends KaitaiStruct {
        public static BwmHeader fromFile(String fileName) throws IOException {
            return new BwmHeader(new ByteBufferKaitaiStream(fileName));
        }

        public BwmHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BwmHeader(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public BwmHeader(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.magic = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            this.version = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        }

        public void _fetchInstances() {
        }
        private Boolean isValidBwm;

        /**
         * Validation check that the file is a valid BWM file.
         * Both magic and version must match expected values.
         */
        public Boolean isValidBwm() {
            if (this.isValidBwm != null)
                return this.isValidBwm;
            this.isValidBwm =  ((magic().equals("BWM ")) && (version().equals("V1.0"))) ;
            return this.isValidBwm;
        }
        private String magic;
        private String version;
        private Bwm _root;
        private Bwm _parent;

        /**
         * File type signature. Must be "BWM " (space-padded).
         * The space after "BWM" is significant and must be present.
         */
        public String magic() { return magic; }

        /**
         * File format version. Always "V1.0" for KotOR BWM files.
         * This is the first and only version of the BWM format used in KotOR games.
         */
        public String version() { return version; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class DataTableOffsets extends KaitaiStruct {
        public static DataTableOffsets fromFile(String fileName) throws IOException {
            return new DataTableOffsets(new ByteBufferKaitaiStream(fileName));
        }

        public DataTableOffsets(KaitaiStream _io) {
            this(_io, null, null);
        }

        public DataTableOffsets(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public DataTableOffsets(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
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

        public void _fetchInstances() {
        }
        private long vertexCount;
        private long vertexOffset;
        private long faceCount;
        private long faceIndicesOffset;
        private long materialsOffset;
        private long normalsOffset;
        private long distancesOffset;
        private long aabbCount;
        private long aabbOffset;
        private long unknown;
        private long adjacencyCount;
        private long adjacencyOffset;
        private long edgeCount;
        private long edgeOffset;
        private long perimeterCount;
        private long perimeterOffset;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Number of vertices in the walkmesh
         */
        public long vertexCount() { return vertexCount; }

        /**
         * Byte offset to vertex array from the beginning of the file
         */
        public long vertexOffset() { return vertexOffset; }

        /**
         * Number of faces (triangles) in the walkmesh
         */
        public long faceCount() { return faceCount; }

        /**
         * Byte offset to face indices array from the beginning of the file
         */
        public long faceIndicesOffset() { return faceIndicesOffset; }

        /**
         * Byte offset to materials array from the beginning of the file
         */
        public long materialsOffset() { return materialsOffset; }

        /**
         * Byte offset to face normals array from the beginning of the file.
         * Only used for WOK files (area walkmeshes).
         */
        public long normalsOffset() { return normalsOffset; }

        /**
         * Byte offset to planar distances array from the beginning of the file.
         * Only used for WOK files (area walkmeshes).
         */
        public long distancesOffset() { return distancesOffset; }

        /**
         * Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
         * AABB trees provide spatial acceleration for raycasting and point queries.
         */
        public long aabbCount() { return aabbCount; }

        /**
         * Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
         * Only present if aabb_count > 0.
         */
        public long aabbOffset() { return aabbOffset; }

        /**
         * Unknown field (typically 0 or 4).
         * Purpose is undocumented but appears in all BWM files.
         */
        public long unknown() { return unknown; }

        /**
         * Number of walkable faces for adjacency data (WOK only).
         * This equals the number of walkable faces, not the total face count.
         * Adjacencies are stored only for walkable faces.
         */
        public long adjacencyCount() { return adjacencyCount; }

        /**
         * Byte offset to adjacency array from the beginning of the file (WOK only).
         * Only present if adjacency_count > 0.
         */
        public long adjacencyOffset() { return adjacencyOffset; }

        /**
         * Number of perimeter edges (WOK only).
         * Perimeter edges are boundary edges with no walkable neighbor.
         */
        public long edgeCount() { return edgeCount; }

        /**
         * Byte offset to edges array from the beginning of the file (WOK only).
         * Only present if edge_count > 0.
         */
        public long edgeOffset() { return edgeOffset; }

        /**
         * Number of perimeter markers (WOK only).
         * Perimeter markers indicate the end of closed loops of perimeter edges.
         */
        public long perimeterCount() { return perimeterCount; }

        /**
         * Byte offset to perimeters array from the beginning of the file (WOK only).
         * Only present if perimeter_count > 0.
         */
        public long perimeterOffset() { return perimeterOffset; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class EdgeEntry extends KaitaiStruct {
        public static EdgeEntry fromFile(String fileName) throws IOException {
            return new EdgeEntry(new ByteBufferKaitaiStream(fileName));
        }

        public EdgeEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public EdgeEntry(KaitaiStream _io, Bwm.EdgesArray _parent) {
            this(_io, _parent, null);
        }

        public EdgeEntry(KaitaiStream _io, Bwm.EdgesArray _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.edgeIndex = this._io.readU4le();
            this.transition = this._io.readS4le();
        }

        public void _fetchInstances() {
        }
        private Integer faceIndex;

        /**
         * Face index that this edge belongs to (decoded from edge_index)
         */
        public Integer faceIndex() {
            if (this.faceIndex != null)
                return this.faceIndex;
            this.faceIndex = ((Number) (edgeIndex() / 3)).intValue();
            return this.faceIndex;
        }
        private Boolean hasTransition;

        /**
         * True if this edge has a transition ID (links to door/area connection)
         */
        public Boolean hasTransition() {
            if (this.hasTransition != null)
                return this.hasTransition;
            this.hasTransition = transition() != -1;
            return this.hasTransition;
        }
        private Integer localEdgeIndex;

        /**
         * Local edge index (0, 1, or 2) within the face (decoded from edge_index)
         */
        public Integer localEdgeIndex() {
            if (this.localEdgeIndex != null)
                return this.localEdgeIndex;
            this.localEdgeIndex = ((Number) (KaitaiStream.mod(edgeIndex(), 3))).intValue();
            return this.localEdgeIndex;
        }
        private long edgeIndex;
        private int transition;
        private Bwm _root;
        private Bwm.EdgesArray _parent;

        /**
         * Encoded edge index: face_index * 3 + local_edge_index
         * Identifies which face and which edge (0, 1, or 2) of that face.
         * Edge 0: between v1 and v2
         * Edge 1: between v2 and v3
         * Edge 2: between v3 and v1
         */
        public long edgeIndex() { return edgeIndex; }

        /**
         * Transition ID for room/area connections, -1 if no transition.
         * Non-negative values reference door connections or area boundaries.
         * -1 indicates this is just a boundary edge with no transition.
         */
        public int transition() { return transition; }
        public Bwm _root() { return _root; }
        public Bwm.EdgesArray _parent() { return _parent; }
    }
    public static class EdgesArray extends KaitaiStruct {
        public static EdgesArray fromFile(String fileName) throws IOException {
            return new EdgesArray(new ByteBufferKaitaiStream(fileName));
        }

        public EdgesArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public EdgesArray(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public EdgesArray(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.edges = new ArrayList<EdgeEntry>();
            for (int i = 0; i < _root().dataTableOffsets().edgeCount(); i++) {
                this.edges.add(new EdgeEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.edges.size(); i++) {
                this.edges.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<EdgeEntry> edges;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Array of perimeter edges (WOK only).
         * Perimeter edges are boundary edges with no walkable neighbor.
         * Each edge entry contains an edge index and optional transition ID.
         */
        public List<EdgeEntry> edges() { return edges; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class FaceIndices extends KaitaiStruct {
        public static FaceIndices fromFile(String fileName) throws IOException {
            return new FaceIndices(new ByteBufferKaitaiStream(fileName));
        }

        public FaceIndices(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FaceIndices(KaitaiStream _io, Bwm.FaceIndicesArray _parent) {
            this(_io, _parent, null);
        }

        public FaceIndices(KaitaiStream _io, Bwm.FaceIndicesArray _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.v1Index = this._io.readU4le();
            this.v2Index = this._io.readU4le();
            this.v3Index = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private long v1Index;
        private long v2Index;
        private long v3Index;
        private Bwm _root;
        private Bwm.FaceIndicesArray _parent;

        /**
         * Vertex index for first vertex of triangle (0-based index into vertices array).
         * Vertex indices define the triangle's vertices in counter-clockwise order
         * when viewed from the front (the side the normal points toward).
         */
        public long v1Index() { return v1Index; }

        /**
         * Vertex index for second vertex of triangle (0-based index into vertices array).
         */
        public long v2Index() { return v2Index; }

        /**
         * Vertex index for third vertex of triangle (0-based index into vertices array).
         */
        public long v3Index() { return v3Index; }
        public Bwm _root() { return _root; }
        public Bwm.FaceIndicesArray _parent() { return _parent; }
    }
    public static class FaceIndicesArray extends KaitaiStruct {
        public static FaceIndicesArray fromFile(String fileName) throws IOException {
            return new FaceIndicesArray(new ByteBufferKaitaiStream(fileName));
        }

        public FaceIndicesArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FaceIndicesArray(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public FaceIndicesArray(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.faces = new ArrayList<FaceIndices>();
            for (int i = 0; i < _root().dataTableOffsets().faceCount(); i++) {
                this.faces.add(new FaceIndices(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.faces.size(); i++) {
                this.faces.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<FaceIndices> faces;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Array of face vertex index triplets
         */
        public List<FaceIndices> faces() { return faces; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class MaterialsArray extends KaitaiStruct {
        public static MaterialsArray fromFile(String fileName) throws IOException {
            return new MaterialsArray(new ByteBufferKaitaiStream(fileName));
        }

        public MaterialsArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public MaterialsArray(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public MaterialsArray(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.materials = new ArrayList<Long>();
            for (int i = 0; i < _root().dataTableOffsets().faceCount(); i++) {
                this.materials.add(this._io.readU4le());
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.materials.size(); i++) {
            }
        }
        private List<Long> materials;
        private Bwm _root;
        private Bwm _parent;

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
        public List<Long> materials() { return materials; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class NormalsArray extends KaitaiStruct {
        public static NormalsArray fromFile(String fileName) throws IOException {
            return new NormalsArray(new ByteBufferKaitaiStream(fileName));
        }

        public NormalsArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public NormalsArray(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public NormalsArray(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.normals = new ArrayList<Vec3f>();
            for (int i = 0; i < _root().dataTableOffsets().faceCount(); i++) {
                this.normals.add(new Vec3f(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.normals.size(); i++) {
                this.normals.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<Vec3f> normals;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Array of face normal vectors, one per face (WOK only).
         * Normals are precomputed unit vectors perpendicular to each face.
         * Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
         * Normal direction follows right-hand rule based on vertex winding order.
         */
        public List<Vec3f> normals() { return normals; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class PerimetersArray extends KaitaiStruct {
        public static PerimetersArray fromFile(String fileName) throws IOException {
            return new PerimetersArray(new ByteBufferKaitaiStream(fileName));
        }

        public PerimetersArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public PerimetersArray(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public PerimetersArray(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.perimeters = new ArrayList<Long>();
            for (int i = 0; i < _root().dataTableOffsets().perimeterCount(); i++) {
                this.perimeters.add(this._io.readU4le());
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.perimeters.size(); i++) {
            }
        }
        private List<Long> perimeters;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Array of perimeter markers (WOK only).
         * Each value is an index into the edges array, marking the end of a perimeter loop.
         * Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
         * Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.
         */
        public List<Long> perimeters() { return perimeters; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class PlanarDistancesArray extends KaitaiStruct {
        public static PlanarDistancesArray fromFile(String fileName) throws IOException {
            return new PlanarDistancesArray(new ByteBufferKaitaiStream(fileName));
        }

        public PlanarDistancesArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public PlanarDistancesArray(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public PlanarDistancesArray(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.distances = new ArrayList<Float>();
            for (int i = 0; i < _root().dataTableOffsets().faceCount(); i++) {
                this.distances.add(this._io.readF4le());
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.distances.size(); i++) {
            }
        }
        private List<Float> distances;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Array of planar distances, one per face (WOK only).
         * The D component of the plane equation ax + by + cz + d = 0.
         * Calculated as d = -normal · vertex1 for each face.
         * Precomputed to allow quick point-plane relationship tests.
         */
        public List<Float> distances() { return distances; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class Vec3f extends KaitaiStruct {
        public static Vec3f fromFile(String fileName) throws IOException {
            return new Vec3f(new ByteBufferKaitaiStream(fileName));
        }

        public Vec3f(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Vec3f(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public Vec3f(KaitaiStream _io, KaitaiStruct _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.x = this._io.readF4le();
            this.y = this._io.readF4le();
            this.z = this._io.readF4le();
        }

        public void _fetchInstances() {
        }
        private float x;
        private float y;
        private float z;
        private Bwm _root;
        private KaitaiStruct _parent;

        /**
         * X coordinate (float32)
         */
        public float x() { return x; }

        /**
         * Y coordinate (float32)
         */
        public float y() { return y; }

        /**
         * Z coordinate (float32)
         */
        public float z() { return z; }
        public Bwm _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }
    public static class VerticesArray extends KaitaiStruct {
        public static VerticesArray fromFile(String fileName) throws IOException {
            return new VerticesArray(new ByteBufferKaitaiStream(fileName));
        }

        public VerticesArray(KaitaiStream _io) {
            this(_io, null, null);
        }

        public VerticesArray(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public VerticesArray(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.vertices = new ArrayList<Vec3f>();
            for (int i = 0; i < _root().dataTableOffsets().vertexCount(); i++) {
                this.vertices.add(new Vec3f(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.vertices.size(); i++) {
                this.vertices.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<Vec3f> vertices;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Array of vertex positions, each vertex is a float3 (x, y, z)
         */
        public List<Vec3f> vertices() { return vertices; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    public static class WalkmeshProperties extends KaitaiStruct {
        public static WalkmeshProperties fromFile(String fileName) throws IOException {
            return new WalkmeshProperties(new ByteBufferKaitaiStream(fileName));
        }

        public WalkmeshProperties(KaitaiStream _io) {
            this(_io, null, null);
        }

        public WalkmeshProperties(KaitaiStream _io, Bwm _parent) {
            this(_io, _parent, null);
        }

        public WalkmeshProperties(KaitaiStream _io, Bwm _parent, Bwm _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.walkmeshType = this._io.readU4le();
            this.relativeUsePosition1 = new Vec3f(this._io, this, _root);
            this.relativeUsePosition2 = new Vec3f(this._io, this, _root);
            this.absoluteUsePosition1 = new Vec3f(this._io, this, _root);
            this.absoluteUsePosition2 = new Vec3f(this._io, this, _root);
            this.position = new Vec3f(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.relativeUsePosition1._fetchInstances();
            this.relativeUsePosition2._fetchInstances();
            this.absoluteUsePosition1._fetchInstances();
            this.absoluteUsePosition2._fetchInstances();
            this.position._fetchInstances();
        }
        private Boolean isAreaWalkmesh;

        /**
         * True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)
         */
        public Boolean isAreaWalkmesh() {
            if (this.isAreaWalkmesh != null)
                return this.isAreaWalkmesh;
            this.isAreaWalkmesh = walkmeshType() == 1;
            return this.isAreaWalkmesh;
        }
        private Boolean isPlaceableOrDoor;

        /**
         * True if this is a placeable or door walkmesh (PWK/DWK)
         */
        public Boolean isPlaceableOrDoor() {
            if (this.isPlaceableOrDoor != null)
                return this.isPlaceableOrDoor;
            this.isPlaceableOrDoor = walkmeshType() == 0;
            return this.isPlaceableOrDoor;
        }
        private long walkmeshType;
        private Vec3f relativeUsePosition1;
        private Vec3f relativeUsePosition2;
        private Vec3f absoluteUsePosition1;
        private Vec3f absoluteUsePosition2;
        private Vec3f position;
        private Bwm _root;
        private Bwm _parent;

        /**
         * Walkmesh type identifier:
         * - 0 = PWK/DWK (Placeable/Door walkmesh)
         * - 1 = WOK (Area walkmesh)
         */
        public long walkmeshType() { return walkmeshType; }

        /**
         * Relative use hook position 1 (x, y, z).
         * Position relative to the walkmesh origin, used when the walkmesh may be transformed.
         * For doors: Defines where the player must stand to interact (relative to door model).
         * For placeables: Defines interaction points relative to the object's local coordinate system.
         */
        public Vec3f relativeUsePosition1() { return relativeUsePosition1; }

        /**
         * Relative use hook position 2 (x, y, z).
         * Second interaction point relative to the walkmesh origin.
         */
        public Vec3f relativeUsePosition2() { return relativeUsePosition2; }

        /**
         * Absolute use hook position 1 (x, y, z).
         * Position in world space, used when the walkmesh position is known.
         * For doors: Precomputed world-space interaction points (position + relative hook).
         * For placeables: World-space interaction points accounting for object placement.
         */
        public Vec3f absoluteUsePosition1() { return absoluteUsePosition1; }

        /**
         * Absolute use hook position 2 (x, y, z).
         * Second absolute interaction point in world space.
         */
        public Vec3f absoluteUsePosition2() { return absoluteUsePosition2; }

        /**
         * Walkmesh position offset (x, y, z) in world space.
         * For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
         * For placeable/door walkmeshes: The position where the object is placed in the area.
         * Used to transform vertices from local to world coordinates.
         */
        public Vec3f position() { return position; }
        public Bwm _root() { return _root; }
        public Bwm _parent() { return _parent; }
    }
    private AabbNodesArray aabbNodes;

    /**
     * Array of AABB tree nodes for spatial acceleration - WOK only
     */
    public AabbNodesArray aabbNodes() {
        if (this.aabbNodes != null)
            return this.aabbNodes;
        if ( ((_root().walkmeshProperties().walkmeshType() == 1) && (_root().dataTableOffsets().aabbCount() > 0)) ) {
            long _pos = this._io.pos();
            this._io.seek(_root().dataTableOffsets().aabbOffset());
            this.aabbNodes = new AabbNodesArray(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.aabbNodes;
    }
    private AdjacenciesArray adjacencies;

    /**
     * Array of adjacency indices (int32 triplets per walkable face) - WOK only
     */
    public AdjacenciesArray adjacencies() {
        if (this.adjacencies != null)
            return this.adjacencies;
        if ( ((_root().walkmeshProperties().walkmeshType() == 1) && (_root().dataTableOffsets().adjacencyCount() > 0)) ) {
            long _pos = this._io.pos();
            this._io.seek(_root().dataTableOffsets().adjacencyOffset());
            this.adjacencies = new AdjacenciesArray(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.adjacencies;
    }
    private EdgesArray edges;

    /**
     * Array of perimeter edges (edge_index, transition pairs) - WOK only
     */
    public EdgesArray edges() {
        if (this.edges != null)
            return this.edges;
        if ( ((_root().walkmeshProperties().walkmeshType() == 1) && (_root().dataTableOffsets().edgeCount() > 0)) ) {
            long _pos = this._io.pos();
            this._io.seek(_root().dataTableOffsets().edgeOffset());
            this.edges = new EdgesArray(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.edges;
    }
    private FaceIndicesArray faceIndices;

    /**
     * Array of face vertex indices (uint32 triplets)
     */
    public FaceIndicesArray faceIndices() {
        if (this.faceIndices != null)
            return this.faceIndices;
        if (_root().dataTableOffsets().faceCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(_root().dataTableOffsets().faceIndicesOffset());
            this.faceIndices = new FaceIndicesArray(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.faceIndices;
    }
    private MaterialsArray materials;

    /**
     * Array of surface material IDs per face
     */
    public MaterialsArray materials() {
        if (this.materials != null)
            return this.materials;
        if (_root().dataTableOffsets().faceCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(_root().dataTableOffsets().materialsOffset());
            this.materials = new MaterialsArray(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.materials;
    }
    private NormalsArray normals;

    /**
     * Array of face normal vectors (float3 triplets) - WOK only
     */
    public NormalsArray normals() {
        if (this.normals != null)
            return this.normals;
        if ( ((_root().walkmeshProperties().walkmeshType() == 1) && (_root().dataTableOffsets().faceCount() > 0)) ) {
            long _pos = this._io.pos();
            this._io.seek(_root().dataTableOffsets().normalsOffset());
            this.normals = new NormalsArray(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.normals;
    }
    private PerimetersArray perimeters;

    /**
     * Array of perimeter markers (edge indices marking end of loops) - WOK only
     */
    public PerimetersArray perimeters() {
        if (this.perimeters != null)
            return this.perimeters;
        if ( ((_root().walkmeshProperties().walkmeshType() == 1) && (_root().dataTableOffsets().perimeterCount() > 0)) ) {
            long _pos = this._io.pos();
            this._io.seek(_root().dataTableOffsets().perimeterOffset());
            this.perimeters = new PerimetersArray(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.perimeters;
    }
    private PlanarDistancesArray planarDistances;

    /**
     * Array of planar distances (float32 per face) - WOK only
     */
    public PlanarDistancesArray planarDistances() {
        if (this.planarDistances != null)
            return this.planarDistances;
        if ( ((_root().walkmeshProperties().walkmeshType() == 1) && (_root().dataTableOffsets().faceCount() > 0)) ) {
            long _pos = this._io.pos();
            this._io.seek(_root().dataTableOffsets().distancesOffset());
            this.planarDistances = new PlanarDistancesArray(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.planarDistances;
    }
    private VerticesArray vertices;

    /**
     * Array of vertex positions (float3 triplets)
     */
    public VerticesArray vertices() {
        if (this.vertices != null)
            return this.vertices;
        if (_root().dataTableOffsets().vertexCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(_root().dataTableOffsets().vertexOffset());
            this.vertices = new VerticesArray(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.vertices;
    }
    private BwmHeader header;
    private WalkmeshProperties walkmeshProperties;
    private DataTableOffsets dataTableOffsets;
    private Bwm _root;
    private KaitaiStruct _parent;

    /**
     * BWM file header (8 bytes) - magic and version signature
     */
    public BwmHeader header() { return header; }

    /**
     * Walkmesh properties section (52 bytes) - type, hooks, position
     */
    public WalkmeshProperties walkmeshProperties() { return walkmeshProperties; }

    /**
     * Data table offsets section (84 bytes) - counts and offsets for all data tables
     */
    public DataTableOffsets dataTableOffsets() { return dataTableOffsets; }
    public Bwm _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
