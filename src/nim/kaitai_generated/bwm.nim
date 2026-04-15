import kaitai_struct_nim_runtime
import options

type
  Bwm* = ref object of KaitaiStruct
    `header`*: Bwm_BwmHeader
    `walkmeshProperties`*: Bwm_WalkmeshProperties
    `dataTableOffsets`*: Bwm_DataTableOffsets
    `parent`*: KaitaiStruct
    `aabbNodesInst`: Bwm_AabbNodesArray
    `aabbNodesInstFlag`: bool
    `adjacenciesInst`: Bwm_AdjacenciesArray
    `adjacenciesInstFlag`: bool
    `edgesInst`: Bwm_EdgesArray
    `edgesInstFlag`: bool
    `faceIndicesInst`: Bwm_FaceIndicesArray
    `faceIndicesInstFlag`: bool
    `materialsInst`: Bwm_MaterialsArray
    `materialsInstFlag`: bool
    `normalsInst`: Bwm_NormalsArray
    `normalsInstFlag`: bool
    `perimetersInst`: Bwm_PerimetersArray
    `perimetersInstFlag`: bool
    `planarDistancesInst`: Bwm_PlanarDistancesArray
    `planarDistancesInstFlag`: bool
    `verticesInst`: Bwm_VerticesArray
    `verticesInstFlag`: bool
  Bwm_AabbNode* = ref object of KaitaiStruct
    `boundsMin`*: Bwm_Vec3f
    `boundsMax`*: Bwm_Vec3f
    `faceIndex`*: int32
    `unknown`*: uint32
    `mostSignificantPlane`*: uint32
    `leftChildIndex`*: uint32
    `rightChildIndex`*: uint32
    `parent`*: Bwm_AabbNodesArray
    `hasLeftChildInst`: bool
    `hasLeftChildInstFlag`: bool
    `hasRightChildInst`: bool
    `hasRightChildInstFlag`: bool
    `isInternalNodeInst`: bool
    `isInternalNodeInstFlag`: bool
    `isLeafNodeInst`: bool
    `isLeafNodeInstFlag`: bool
  Bwm_AabbNodesArray* = ref object of KaitaiStruct
    `nodes`*: seq[Bwm_AabbNode]
    `parent`*: Bwm
  Bwm_AdjacenciesArray* = ref object of KaitaiStruct
    `adjacencies`*: seq[Bwm_AdjacencyTriplet]
    `parent`*: Bwm
  Bwm_AdjacencyTriplet* = ref object of KaitaiStruct
    `edge0Adjacency`*: int32
    `edge1Adjacency`*: int32
    `edge2Adjacency`*: int32
    `parent`*: Bwm_AdjacenciesArray
    `edge0FaceIndexInst`: int
    `edge0FaceIndexInstFlag`: bool
    `edge0HasNeighborInst`: bool
    `edge0HasNeighborInstFlag`: bool
    `edge0LocalEdgeInst`: int
    `edge0LocalEdgeInstFlag`: bool
    `edge1FaceIndexInst`: int
    `edge1FaceIndexInstFlag`: bool
    `edge1HasNeighborInst`: bool
    `edge1HasNeighborInstFlag`: bool
    `edge1LocalEdgeInst`: int
    `edge1LocalEdgeInstFlag`: bool
    `edge2FaceIndexInst`: int
    `edge2FaceIndexInstFlag`: bool
    `edge2HasNeighborInst`: bool
    `edge2HasNeighborInstFlag`: bool
    `edge2LocalEdgeInst`: int
    `edge2LocalEdgeInstFlag`: bool
  Bwm_BwmHeader* = ref object of KaitaiStruct
    `magic`*: string
    `version`*: string
    `parent`*: Bwm
    `isValidBwmInst`: bool
    `isValidBwmInstFlag`: bool
  Bwm_DataTableOffsets* = ref object of KaitaiStruct
    `vertexCount`*: uint32
    `vertexOffset`*: uint32
    `faceCount`*: uint32
    `faceIndicesOffset`*: uint32
    `materialsOffset`*: uint32
    `normalsOffset`*: uint32
    `distancesOffset`*: uint32
    `aabbCount`*: uint32
    `aabbOffset`*: uint32
    `unknown`*: uint32
    `adjacencyCount`*: uint32
    `adjacencyOffset`*: uint32
    `edgeCount`*: uint32
    `edgeOffset`*: uint32
    `perimeterCount`*: uint32
    `perimeterOffset`*: uint32
    `parent`*: Bwm
  Bwm_EdgeEntry* = ref object of KaitaiStruct
    `edgeIndex`*: uint32
    `transition`*: int32
    `parent`*: Bwm_EdgesArray
    `faceIndexInst`: int
    `faceIndexInstFlag`: bool
    `hasTransitionInst`: bool
    `hasTransitionInstFlag`: bool
    `localEdgeIndexInst`: int
    `localEdgeIndexInstFlag`: bool
  Bwm_EdgesArray* = ref object of KaitaiStruct
    `edges`*: seq[Bwm_EdgeEntry]
    `parent`*: Bwm
  Bwm_FaceIndices* = ref object of KaitaiStruct
    `v1Index`*: uint32
    `v2Index`*: uint32
    `v3Index`*: uint32
    `parent`*: Bwm_FaceIndicesArray
  Bwm_FaceIndicesArray* = ref object of KaitaiStruct
    `faces`*: seq[Bwm_FaceIndices]
    `parent`*: Bwm
  Bwm_MaterialsArray* = ref object of KaitaiStruct
    `materials`*: seq[uint32]
    `parent`*: Bwm
  Bwm_NormalsArray* = ref object of KaitaiStruct
    `normals`*: seq[Bwm_Vec3f]
    `parent`*: Bwm
  Bwm_PerimetersArray* = ref object of KaitaiStruct
    `perimeters`*: seq[uint32]
    `parent`*: Bwm
  Bwm_PlanarDistancesArray* = ref object of KaitaiStruct
    `distances`*: seq[float32]
    `parent`*: Bwm
  Bwm_Vec3f* = ref object of KaitaiStruct
    `x`*: float32
    `y`*: float32
    `z`*: float32
    `parent`*: KaitaiStruct
  Bwm_VerticesArray* = ref object of KaitaiStruct
    `vertices`*: seq[Bwm_Vec3f]
    `parent`*: Bwm
  Bwm_WalkmeshProperties* = ref object of KaitaiStruct
    `walkmeshType`*: uint32
    `relativeUsePosition1`*: Bwm_Vec3f
    `relativeUsePosition2`*: Bwm_Vec3f
    `absoluteUsePosition1`*: Bwm_Vec3f
    `absoluteUsePosition2`*: Bwm_Vec3f
    `position`*: Bwm_Vec3f
    `parent`*: Bwm
    `isAreaWalkmeshInst`: bool
    `isAreaWalkmeshInstFlag`: bool
    `isPlaceableOrDoorInst`: bool
    `isPlaceableOrDoorInstFlag`: bool

proc read*(_: typedesc[Bwm], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bwm
proc read*(_: typedesc[Bwm_AabbNode], io: KaitaiStream, root: KaitaiStruct, parent: Bwm_AabbNodesArray): Bwm_AabbNode
proc read*(_: typedesc[Bwm_AabbNodesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_AabbNodesArray
proc read*(_: typedesc[Bwm_AdjacenciesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_AdjacenciesArray
proc read*(_: typedesc[Bwm_AdjacencyTriplet], io: KaitaiStream, root: KaitaiStruct, parent: Bwm_AdjacenciesArray): Bwm_AdjacencyTriplet
proc read*(_: typedesc[Bwm_BwmHeader], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_BwmHeader
proc read*(_: typedesc[Bwm_DataTableOffsets], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_DataTableOffsets
proc read*(_: typedesc[Bwm_EdgeEntry], io: KaitaiStream, root: KaitaiStruct, parent: Bwm_EdgesArray): Bwm_EdgeEntry
proc read*(_: typedesc[Bwm_EdgesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_EdgesArray
proc read*(_: typedesc[Bwm_FaceIndices], io: KaitaiStream, root: KaitaiStruct, parent: Bwm_FaceIndicesArray): Bwm_FaceIndices
proc read*(_: typedesc[Bwm_FaceIndicesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_FaceIndicesArray
proc read*(_: typedesc[Bwm_MaterialsArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_MaterialsArray
proc read*(_: typedesc[Bwm_NormalsArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_NormalsArray
proc read*(_: typedesc[Bwm_PerimetersArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_PerimetersArray
proc read*(_: typedesc[Bwm_PlanarDistancesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_PlanarDistancesArray
proc read*(_: typedesc[Bwm_Vec3f], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bwm_Vec3f
proc read*(_: typedesc[Bwm_VerticesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_VerticesArray
proc read*(_: typedesc[Bwm_WalkmeshProperties], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_WalkmeshProperties

proc aabbNodes*(this: Bwm): Bwm_AabbNodesArray
proc adjacencies*(this: Bwm): Bwm_AdjacenciesArray
proc edges*(this: Bwm): Bwm_EdgesArray
proc faceIndices*(this: Bwm): Bwm_FaceIndicesArray
proc materials*(this: Bwm): Bwm_MaterialsArray
proc normals*(this: Bwm): Bwm_NormalsArray
proc perimeters*(this: Bwm): Bwm_PerimetersArray
proc planarDistances*(this: Bwm): Bwm_PlanarDistancesArray
proc vertices*(this: Bwm): Bwm_VerticesArray
proc hasLeftChild*(this: Bwm_AabbNode): bool
proc hasRightChild*(this: Bwm_AabbNode): bool
proc isInternalNode*(this: Bwm_AabbNode): bool
proc isLeafNode*(this: Bwm_AabbNode): bool
proc edge0FaceIndex*(this: Bwm_AdjacencyTriplet): int
proc edge0HasNeighbor*(this: Bwm_AdjacencyTriplet): bool
proc edge0LocalEdge*(this: Bwm_AdjacencyTriplet): int
proc edge1FaceIndex*(this: Bwm_AdjacencyTriplet): int
proc edge1HasNeighbor*(this: Bwm_AdjacencyTriplet): bool
proc edge1LocalEdge*(this: Bwm_AdjacencyTriplet): int
proc edge2FaceIndex*(this: Bwm_AdjacencyTriplet): int
proc edge2HasNeighbor*(this: Bwm_AdjacencyTriplet): bool
proc edge2LocalEdge*(this: Bwm_AdjacencyTriplet): int
proc isValidBwm*(this: Bwm_BwmHeader): bool
proc faceIndex*(this: Bwm_EdgeEntry): int
proc hasTransition*(this: Bwm_EdgeEntry): bool
proc localEdgeIndex*(this: Bwm_EdgeEntry): int
proc isAreaWalkmesh*(this: Bwm_WalkmeshProperties): bool
proc isPlaceableOrDoor*(this: Bwm_WalkmeshProperties): bool


##[
BWM (Binary WalkMesh) files define walkable surfaces for pathfinding and collision detection
in Knights of the Old Republic (KotOR) games. BWM files are stored on disk with different
extensions depending on their type:

- WOK: Area walkmesh files (walkmesh_type = 1) - defines walkable regions in game areas
- PWK: Placeable walkmesh files (walkmesh_type = 0) - collision geometry for containers, furniture
- DWK: Door walkmesh files (walkmesh_type = 0) - collision geometry for doors in various states

The format uses a header-based structure where offsets point to various data tables, allowing
efficient random access to vertices, faces, materials, and acceleration structures.

Binary Format Structure:
- File Header (8 bytes): Magic "BWM " and version "V1.0"
- Walkmesh Properties (52 bytes): Type, hook vectors, position
- Data Table Offsets (84 bytes): Counts and offsets for all data tables
- Vertices Array: Array of float3 (x, y, z) per vertex
- Face Indices Array: Array of uint32 triplets (vertex indices per face)
- Materials Array: Array of uint32 (SurfaceMaterial ID per face)
- Normals Array: Array of float3 (face normal per face) - WOK only
- Planar Distances Array: Array of float32 (per face) - WOK only
- AABB Nodes Array: Array of AABB structures (WOK only)
- Adjacencies Array: Array of int32 triplets (WOK only, -1 for no neighbor)
- Edges Array: Array of (edge_index, transition) pairs (WOK only)
- Perimeters Array: Array of edge indices (WOK only)

References:
- https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm
- https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/bwmreader.cpp:27-171
- https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp:73-248
- https://github.com/KotOR-Community-Patches/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts:452-473

]##
proc read*(_: typedesc[Bwm], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bwm =
  template this: untyped = result
  this = new(Bwm)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  BWM file header (8 bytes) - magic and version signature
  ]##
  let headerExpr = Bwm_BwmHeader.read(this.io, this.root, this)
  this.header = headerExpr

  ##[
  Walkmesh properties section (52 bytes) - type, hooks, position
  ]##
  let walkmeshPropertiesExpr = Bwm_WalkmeshProperties.read(this.io, this.root, this)
  this.walkmeshProperties = walkmeshPropertiesExpr

  ##[
  Data table offsets section (84 bytes) - counts and offsets for all data tables
  ]##
  let dataTableOffsetsExpr = Bwm_DataTableOffsets.read(this.io, this.root, this)
  this.dataTableOffsets = dataTableOffsetsExpr

proc aabbNodes(this: Bwm): Bwm_AabbNodesArray = 

  ##[
  Array of AABB tree nodes for spatial acceleration - WOK only
  ]##
  if this.aabbNodesInstFlag:
    return this.aabbNodesInst
  if  ((Bwm(this.root).walkmeshProperties.walkmeshType == 1) and (Bwm(this.root).dataTableOffsets.aabbCount > 0)) :
    let pos = this.io.pos()
    this.io.seek(int(Bwm(this.root).dataTableOffsets.aabbOffset))
    let aabbNodesInstExpr = Bwm_AabbNodesArray.read(this.io, this.root, this)
    this.aabbNodesInst = aabbNodesInstExpr
    this.io.seek(pos)
  this.aabbNodesInstFlag = true
  return this.aabbNodesInst

proc adjacencies(this: Bwm): Bwm_AdjacenciesArray = 

  ##[
  Array of adjacency indices (int32 triplets per walkable face) - WOK only
  ]##
  if this.adjacenciesInstFlag:
    return this.adjacenciesInst
  if  ((Bwm(this.root).walkmeshProperties.walkmeshType == 1) and (Bwm(this.root).dataTableOffsets.adjacencyCount > 0)) :
    let pos = this.io.pos()
    this.io.seek(int(Bwm(this.root).dataTableOffsets.adjacencyOffset))
    let adjacenciesInstExpr = Bwm_AdjacenciesArray.read(this.io, this.root, this)
    this.adjacenciesInst = adjacenciesInstExpr
    this.io.seek(pos)
  this.adjacenciesInstFlag = true
  return this.adjacenciesInst

proc edges(this: Bwm): Bwm_EdgesArray = 

  ##[
  Array of perimeter edges (edge_index, transition pairs) - WOK only
  ]##
  if this.edgesInstFlag:
    return this.edgesInst
  if  ((Bwm(this.root).walkmeshProperties.walkmeshType == 1) and (Bwm(this.root).dataTableOffsets.edgeCount > 0)) :
    let pos = this.io.pos()
    this.io.seek(int(Bwm(this.root).dataTableOffsets.edgeOffset))
    let edgesInstExpr = Bwm_EdgesArray.read(this.io, this.root, this)
    this.edgesInst = edgesInstExpr
    this.io.seek(pos)
  this.edgesInstFlag = true
  return this.edgesInst

proc faceIndices(this: Bwm): Bwm_FaceIndicesArray = 

  ##[
  Array of face vertex indices (uint32 triplets)
  ]##
  if this.faceIndicesInstFlag:
    return this.faceIndicesInst
  if Bwm(this.root).dataTableOffsets.faceCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(Bwm(this.root).dataTableOffsets.faceIndicesOffset))
    let faceIndicesInstExpr = Bwm_FaceIndicesArray.read(this.io, this.root, this)
    this.faceIndicesInst = faceIndicesInstExpr
    this.io.seek(pos)
  this.faceIndicesInstFlag = true
  return this.faceIndicesInst

proc materials(this: Bwm): Bwm_MaterialsArray = 

  ##[
  Array of surface material IDs per face
  ]##
  if this.materialsInstFlag:
    return this.materialsInst
  if Bwm(this.root).dataTableOffsets.faceCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(Bwm(this.root).dataTableOffsets.materialsOffset))
    let materialsInstExpr = Bwm_MaterialsArray.read(this.io, this.root, this)
    this.materialsInst = materialsInstExpr
    this.io.seek(pos)
  this.materialsInstFlag = true
  return this.materialsInst

proc normals(this: Bwm): Bwm_NormalsArray = 

  ##[
  Array of face normal vectors (float3 triplets) - WOK only
  ]##
  if this.normalsInstFlag:
    return this.normalsInst
  if  ((Bwm(this.root).walkmeshProperties.walkmeshType == 1) and (Bwm(this.root).dataTableOffsets.faceCount > 0)) :
    let pos = this.io.pos()
    this.io.seek(int(Bwm(this.root).dataTableOffsets.normalsOffset))
    let normalsInstExpr = Bwm_NormalsArray.read(this.io, this.root, this)
    this.normalsInst = normalsInstExpr
    this.io.seek(pos)
  this.normalsInstFlag = true
  return this.normalsInst

proc perimeters(this: Bwm): Bwm_PerimetersArray = 

  ##[
  Array of perimeter markers (edge indices marking end of loops) - WOK only
  ]##
  if this.perimetersInstFlag:
    return this.perimetersInst
  if  ((Bwm(this.root).walkmeshProperties.walkmeshType == 1) and (Bwm(this.root).dataTableOffsets.perimeterCount > 0)) :
    let pos = this.io.pos()
    this.io.seek(int(Bwm(this.root).dataTableOffsets.perimeterOffset))
    let perimetersInstExpr = Bwm_PerimetersArray.read(this.io, this.root, this)
    this.perimetersInst = perimetersInstExpr
    this.io.seek(pos)
  this.perimetersInstFlag = true
  return this.perimetersInst

proc planarDistances(this: Bwm): Bwm_PlanarDistancesArray = 

  ##[
  Array of planar distances (float32 per face) - WOK only
  ]##
  if this.planarDistancesInstFlag:
    return this.planarDistancesInst
  if  ((Bwm(this.root).walkmeshProperties.walkmeshType == 1) and (Bwm(this.root).dataTableOffsets.faceCount > 0)) :
    let pos = this.io.pos()
    this.io.seek(int(Bwm(this.root).dataTableOffsets.distancesOffset))
    let planarDistancesInstExpr = Bwm_PlanarDistancesArray.read(this.io, this.root, this)
    this.planarDistancesInst = planarDistancesInstExpr
    this.io.seek(pos)
  this.planarDistancesInstFlag = true
  return this.planarDistancesInst

proc vertices(this: Bwm): Bwm_VerticesArray = 

  ##[
  Array of vertex positions (float3 triplets)
  ]##
  if this.verticesInstFlag:
    return this.verticesInst
  if Bwm(this.root).dataTableOffsets.vertexCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(Bwm(this.root).dataTableOffsets.vertexOffset))
    let verticesInstExpr = Bwm_VerticesArray.read(this.io, this.root, this)
    this.verticesInst = verticesInstExpr
    this.io.seek(pos)
  this.verticesInstFlag = true
  return this.verticesInst

proc fromFile*(_: typedesc[Bwm], filename: string): Bwm =
  Bwm.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_AabbNode], io: KaitaiStream, root: KaitaiStruct, parent: Bwm_AabbNodesArray): Bwm_AabbNode =
  template this: untyped = result
  this = new(Bwm_AabbNode)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Minimum bounding box coordinates (x, y, z).
Defines the lower corner of the axis-aligned bounding box.

  ]##
  let boundsMinExpr = Bwm_Vec3f.read(this.io, this.root, this)
  this.boundsMin = boundsMinExpr

  ##[
  Maximum bounding box coordinates (x, y, z).
Defines the upper corner of the axis-aligned bounding box.

  ]##
  let boundsMaxExpr = Bwm_Vec3f.read(this.io, this.root, this)
  this.boundsMax = boundsMaxExpr

  ##[
  Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
Leaf nodes contain a single face, internal nodes contain child nodes.

  ]##
  let faceIndexExpr = this.io.readS4le()
  this.faceIndex = faceIndexExpr

  ##[
  Unknown field (typically 4).
Purpose is undocumented but appears in all AABB nodes.

  ]##
  let unknownExpr = this.io.readU4le()
  this.unknown = unknownExpr

  ##[
  Split axis/plane identifier:
- 0x00 = No children (leaf node)
- 0x01 = Positive X axis split
- 0x02 = Positive Y axis split
- 0x03 = Positive Z axis split
- 0xFFFFFFFE (-2) = Negative X axis split
- 0xFFFFFFFD (-3) = Negative Y axis split
- 0xFFFFFFFC (-4) = Negative Z axis split

  ]##
  let mostSignificantPlaneExpr = this.io.readU4le()
  this.mostSignificantPlane = mostSignificantPlaneExpr

  ##[
  Index to left child node (0-based array index).
0xFFFFFFFF indicates no left child.
Child indices are 0-based indices into the AABB nodes array.

  ]##
  let leftChildIndexExpr = this.io.readU4le()
  this.leftChildIndex = leftChildIndexExpr

  ##[
  Index to right child node (0-based array index).
0xFFFFFFFF indicates no right child.
Child indices are 0-based indices into the AABB nodes array.

  ]##
  let rightChildIndexExpr = this.io.readU4le()
  this.rightChildIndex = rightChildIndexExpr

proc hasLeftChild(this: Bwm_AabbNode): bool = 

  ##[
  True if this node has a left child
  ]##
  if this.hasLeftChildInstFlag:
    return this.hasLeftChildInst
  let hasLeftChildInstExpr = bool(this.leftChildIndex != 4294967295'i64)
  this.hasLeftChildInst = hasLeftChildInstExpr
  this.hasLeftChildInstFlag = true
  return this.hasLeftChildInst

proc hasRightChild(this: Bwm_AabbNode): bool = 

  ##[
  True if this node has a right child
  ]##
  if this.hasRightChildInstFlag:
    return this.hasRightChildInst
  let hasRightChildInstExpr = bool(this.rightChildIndex != 4294967295'i64)
  this.hasRightChildInst = hasRightChildInstExpr
  this.hasRightChildInstFlag = true
  return this.hasRightChildInst

proc isInternalNode(this: Bwm_AabbNode): bool = 

  ##[
  True if this is an internal node (has children), false if leaf node
  ]##
  if this.isInternalNodeInstFlag:
    return this.isInternalNodeInst
  let isInternalNodeInstExpr = bool(this.faceIndex == -1)
  this.isInternalNodeInst = isInternalNodeInstExpr
  this.isInternalNodeInstFlag = true
  return this.isInternalNodeInst

proc isLeafNode(this: Bwm_AabbNode): bool = 

  ##[
  True if this is a leaf node (contains a face), false if internal node
  ]##
  if this.isLeafNodeInstFlag:
    return this.isLeafNodeInst
  let isLeafNodeInstExpr = bool(this.faceIndex != -1)
  this.isLeafNodeInst = isLeafNodeInstExpr
  this.isLeafNodeInstFlag = true
  return this.isLeafNodeInst

proc fromFile*(_: typedesc[Bwm_AabbNode], filename: string): Bwm_AabbNode =
  Bwm_AabbNode.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_AabbNodesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_AabbNodesArray =
  template this: untyped = result
  this = new(Bwm_AabbNodesArray)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of AABB tree nodes for spatial acceleration (WOK only).
AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).

  ]##
  for i in 0 ..< int(Bwm(this.root).dataTableOffsets.aabbCount):
    let it = Bwm_AabbNode.read(this.io, this.root, this)
    this.nodes.add(it)

proc fromFile*(_: typedesc[Bwm_AabbNodesArray], filename: string): Bwm_AabbNodesArray =
  Bwm_AabbNodesArray.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_AdjacenciesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_AdjacenciesArray =
  template this: untyped = result
  this = new(Bwm_AdjacenciesArray)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of adjacency triplets, one per walkable face (WOK only).
Each walkable face has exactly three adjacency entries, one for each edge.
Adjacency count equals the number of walkable faces, not the total face count.

  ]##
  for i in 0 ..< int(Bwm(this.root).dataTableOffsets.adjacencyCount):
    let it = Bwm_AdjacencyTriplet.read(this.io, this.root, this)
    this.adjacencies.add(it)

proc fromFile*(_: typedesc[Bwm_AdjacenciesArray], filename: string): Bwm_AdjacenciesArray =
  Bwm_AdjacenciesArray.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_AdjacencyTriplet], io: KaitaiStream, root: KaitaiStruct, parent: Bwm_AdjacenciesArray): Bwm_AdjacencyTriplet =
  template this: untyped = result
  this = new(Bwm_AdjacencyTriplet)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Adjacency index for edge 0 (between v1 and v2).
Encoding: face_index * 3 + edge_index
-1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).

  ]##
  let edge0AdjacencyExpr = this.io.readS4le()
  this.edge0Adjacency = edge0AdjacencyExpr

  ##[
  Adjacency index for edge 1 (between v2 and v3).
Encoding: face_index * 3 + edge_index
-1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).

  ]##
  let edge1AdjacencyExpr = this.io.readS4le()
  this.edge1Adjacency = edge1AdjacencyExpr

  ##[
  Adjacency index for edge 2 (between v3 and v1).
Encoding: face_index * 3 + edge_index
-1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).

  ]##
  let edge2AdjacencyExpr = this.io.readS4le()
  this.edge2Adjacency = edge2AdjacencyExpr

proc edge0FaceIndex(this: Bwm_AdjacencyTriplet): int = 

  ##[
  Face index of adjacent face for edge 0 (decoded from adjacency index)
  ]##
  if this.edge0FaceIndexInstFlag:
    return this.edge0FaceIndexInst
  let edge0FaceIndexInstExpr = int((if this.edge0Adjacency != -1: this.edge0Adjacency div 3 else: -1))
  this.edge0FaceIndexInst = edge0FaceIndexInstExpr
  this.edge0FaceIndexInstFlag = true
  return this.edge0FaceIndexInst

proc edge0HasNeighbor(this: Bwm_AdjacencyTriplet): bool = 

  ##[
  True if edge 0 has an adjacent walkable face
  ]##
  if this.edge0HasNeighborInstFlag:
    return this.edge0HasNeighborInst
  let edge0HasNeighborInstExpr = bool(this.edge0Adjacency != -1)
  this.edge0HasNeighborInst = edge0HasNeighborInstExpr
  this.edge0HasNeighborInstFlag = true
  return this.edge0HasNeighborInst

proc edge0LocalEdge(this: Bwm_AdjacencyTriplet): int = 

  ##[
  Local edge index (0, 1, or 2) of adjacent face for edge 0
  ]##
  if this.edge0LocalEdgeInstFlag:
    return this.edge0LocalEdgeInst
  let edge0LocalEdgeInstExpr = int((if this.edge0Adjacency != -1: this.edge0Adjacency %%% 3 else: -1))
  this.edge0LocalEdgeInst = edge0LocalEdgeInstExpr
  this.edge0LocalEdgeInstFlag = true
  return this.edge0LocalEdgeInst

proc edge1FaceIndex(this: Bwm_AdjacencyTriplet): int = 

  ##[
  Face index of adjacent face for edge 1 (decoded from adjacency index)
  ]##
  if this.edge1FaceIndexInstFlag:
    return this.edge1FaceIndexInst
  let edge1FaceIndexInstExpr = int((if this.edge1Adjacency != -1: this.edge1Adjacency div 3 else: -1))
  this.edge1FaceIndexInst = edge1FaceIndexInstExpr
  this.edge1FaceIndexInstFlag = true
  return this.edge1FaceIndexInst

proc edge1HasNeighbor(this: Bwm_AdjacencyTriplet): bool = 

  ##[
  True if edge 1 has an adjacent walkable face
  ]##
  if this.edge1HasNeighborInstFlag:
    return this.edge1HasNeighborInst
  let edge1HasNeighborInstExpr = bool(this.edge1Adjacency != -1)
  this.edge1HasNeighborInst = edge1HasNeighborInstExpr
  this.edge1HasNeighborInstFlag = true
  return this.edge1HasNeighborInst

proc edge1LocalEdge(this: Bwm_AdjacencyTriplet): int = 

  ##[
  Local edge index (0, 1, or 2) of adjacent face for edge 1
  ]##
  if this.edge1LocalEdgeInstFlag:
    return this.edge1LocalEdgeInst
  let edge1LocalEdgeInstExpr = int((if this.edge1Adjacency != -1: this.edge1Adjacency %%% 3 else: -1))
  this.edge1LocalEdgeInst = edge1LocalEdgeInstExpr
  this.edge1LocalEdgeInstFlag = true
  return this.edge1LocalEdgeInst

proc edge2FaceIndex(this: Bwm_AdjacencyTriplet): int = 

  ##[
  Face index of adjacent face for edge 2 (decoded from adjacency index)
  ]##
  if this.edge2FaceIndexInstFlag:
    return this.edge2FaceIndexInst
  let edge2FaceIndexInstExpr = int((if this.edge2Adjacency != -1: this.edge2Adjacency div 3 else: -1))
  this.edge2FaceIndexInst = edge2FaceIndexInstExpr
  this.edge2FaceIndexInstFlag = true
  return this.edge2FaceIndexInst

proc edge2HasNeighbor(this: Bwm_AdjacencyTriplet): bool = 

  ##[
  True if edge 2 has an adjacent walkable face
  ]##
  if this.edge2HasNeighborInstFlag:
    return this.edge2HasNeighborInst
  let edge2HasNeighborInstExpr = bool(this.edge2Adjacency != -1)
  this.edge2HasNeighborInst = edge2HasNeighborInstExpr
  this.edge2HasNeighborInstFlag = true
  return this.edge2HasNeighborInst

proc edge2LocalEdge(this: Bwm_AdjacencyTriplet): int = 

  ##[
  Local edge index (0, 1, or 2) of adjacent face for edge 2
  ]##
  if this.edge2LocalEdgeInstFlag:
    return this.edge2LocalEdgeInst
  let edge2LocalEdgeInstExpr = int((if this.edge2Adjacency != -1: this.edge2Adjacency %%% 3 else: -1))
  this.edge2LocalEdgeInst = edge2LocalEdgeInstExpr
  this.edge2LocalEdgeInstFlag = true
  return this.edge2LocalEdgeInst

proc fromFile*(_: typedesc[Bwm_AdjacencyTriplet], filename: string): Bwm_AdjacencyTriplet =
  Bwm_AdjacencyTriplet.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_BwmHeader], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_BwmHeader =
  template this: untyped = result
  this = new(Bwm_BwmHeader)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "BWM " (space-padded).
The space after "BWM" is significant and must be present.

  ]##
  let magicExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.magic = magicExpr

  ##[
  File format version. Always "V1.0" for KotOR BWM files.
This is the first and only version of the BWM format used in KotOR games.

  ]##
  let versionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.version = versionExpr

proc isValidBwm(this: Bwm_BwmHeader): bool = 

  ##[
  Validation check that the file is a valid BWM file.
Both magic and version must match expected values.

  ]##
  if this.isValidBwmInstFlag:
    return this.isValidBwmInst
  let isValidBwmInstExpr = bool( ((this.magic == "BWM ") and (this.version == "V1.0")) )
  this.isValidBwmInst = isValidBwmInstExpr
  this.isValidBwmInstFlag = true
  return this.isValidBwmInst

proc fromFile*(_: typedesc[Bwm_BwmHeader], filename: string): Bwm_BwmHeader =
  Bwm_BwmHeader.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_DataTableOffsets], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_DataTableOffsets =
  template this: untyped = result
  this = new(Bwm_DataTableOffsets)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Number of vertices in the walkmesh
  ]##
  let vertexCountExpr = this.io.readU4le()
  this.vertexCount = vertexCountExpr

  ##[
  Byte offset to vertex array from the beginning of the file
  ]##
  let vertexOffsetExpr = this.io.readU4le()
  this.vertexOffset = vertexOffsetExpr

  ##[
  Number of faces (triangles) in the walkmesh
  ]##
  let faceCountExpr = this.io.readU4le()
  this.faceCount = faceCountExpr

  ##[
  Byte offset to face indices array from the beginning of the file
  ]##
  let faceIndicesOffsetExpr = this.io.readU4le()
  this.faceIndicesOffset = faceIndicesOffsetExpr

  ##[
  Byte offset to materials array from the beginning of the file
  ]##
  let materialsOffsetExpr = this.io.readU4le()
  this.materialsOffset = materialsOffsetExpr

  ##[
  Byte offset to face normals array from the beginning of the file.
Only used for WOK files (area walkmeshes).

  ]##
  let normalsOffsetExpr = this.io.readU4le()
  this.normalsOffset = normalsOffsetExpr

  ##[
  Byte offset to planar distances array from the beginning of the file.
Only used for WOK files (area walkmeshes).

  ]##
  let distancesOffsetExpr = this.io.readU4le()
  this.distancesOffset = distancesOffsetExpr

  ##[
  Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
AABB trees provide spatial acceleration for raycasting and point queries.

  ]##
  let aabbCountExpr = this.io.readU4le()
  this.aabbCount = aabbCountExpr

  ##[
  Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
Only present if aabb_count > 0.

  ]##
  let aabbOffsetExpr = this.io.readU4le()
  this.aabbOffset = aabbOffsetExpr

  ##[
  Unknown field (typically 0 or 4).
Purpose is undocumented but appears in all BWM files.

  ]##
  let unknownExpr = this.io.readU4le()
  this.unknown = unknownExpr

  ##[
  Number of walkable faces for adjacency data (WOK only).
This equals the number of walkable faces, not the total face count.
Adjacencies are stored only for walkable faces.

  ]##
  let adjacencyCountExpr = this.io.readU4le()
  this.adjacencyCount = adjacencyCountExpr

  ##[
  Byte offset to adjacency array from the beginning of the file (WOK only).
Only present if adjacency_count > 0.

  ]##
  let adjacencyOffsetExpr = this.io.readU4le()
  this.adjacencyOffset = adjacencyOffsetExpr

  ##[
  Number of perimeter edges (WOK only).
Perimeter edges are boundary edges with no walkable neighbor.

  ]##
  let edgeCountExpr = this.io.readU4le()
  this.edgeCount = edgeCountExpr

  ##[
  Byte offset to edges array from the beginning of the file (WOK only).
Only present if edge_count > 0.

  ]##
  let edgeOffsetExpr = this.io.readU4le()
  this.edgeOffset = edgeOffsetExpr

  ##[
  Number of perimeter markers (WOK only).
Perimeter markers indicate the end of closed loops of perimeter edges.

  ]##
  let perimeterCountExpr = this.io.readU4le()
  this.perimeterCount = perimeterCountExpr

  ##[
  Byte offset to perimeters array from the beginning of the file (WOK only).
Only present if perimeter_count > 0.

  ]##
  let perimeterOffsetExpr = this.io.readU4le()
  this.perimeterOffset = perimeterOffsetExpr

proc fromFile*(_: typedesc[Bwm_DataTableOffsets], filename: string): Bwm_DataTableOffsets =
  Bwm_DataTableOffsets.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_EdgeEntry], io: KaitaiStream, root: KaitaiStruct, parent: Bwm_EdgesArray): Bwm_EdgeEntry =
  template this: untyped = result
  this = new(Bwm_EdgeEntry)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Encoded edge index: face_index * 3 + local_edge_index
Identifies which face and which edge (0, 1, or 2) of that face.
Edge 0: between v1 and v2
Edge 1: between v2 and v3
Edge 2: between v3 and v1

  ]##
  let edgeIndexExpr = this.io.readU4le()
  this.edgeIndex = edgeIndexExpr

  ##[
  Transition ID for room/area connections, -1 if no transition.
Non-negative values reference door connections or area boundaries.
-1 indicates this is just a boundary edge with no transition.

  ]##
  let transitionExpr = this.io.readS4le()
  this.transition = transitionExpr

proc faceIndex(this: Bwm_EdgeEntry): int = 

  ##[
  Face index that this edge belongs to (decoded from edge_index)
  ]##
  if this.faceIndexInstFlag:
    return this.faceIndexInst
  let faceIndexInstExpr = int(this.edgeIndex div 3)
  this.faceIndexInst = faceIndexInstExpr
  this.faceIndexInstFlag = true
  return this.faceIndexInst

proc hasTransition(this: Bwm_EdgeEntry): bool = 

  ##[
  True if this edge has a transition ID (links to door/area connection)
  ]##
  if this.hasTransitionInstFlag:
    return this.hasTransitionInst
  let hasTransitionInstExpr = bool(this.transition != -1)
  this.hasTransitionInst = hasTransitionInstExpr
  this.hasTransitionInstFlag = true
  return this.hasTransitionInst

proc localEdgeIndex(this: Bwm_EdgeEntry): int = 

  ##[
  Local edge index (0, 1, or 2) within the face (decoded from edge_index)
  ]##
  if this.localEdgeIndexInstFlag:
    return this.localEdgeIndexInst
  let localEdgeIndexInstExpr = int(this.edgeIndex %%% 3)
  this.localEdgeIndexInst = localEdgeIndexInstExpr
  this.localEdgeIndexInstFlag = true
  return this.localEdgeIndexInst

proc fromFile*(_: typedesc[Bwm_EdgeEntry], filename: string): Bwm_EdgeEntry =
  Bwm_EdgeEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_EdgesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_EdgesArray =
  template this: untyped = result
  this = new(Bwm_EdgesArray)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of perimeter edges (WOK only).
Perimeter edges are boundary edges with no walkable neighbor.
Each edge entry contains an edge index and optional transition ID.

  ]##
  for i in 0 ..< int(Bwm(this.root).dataTableOffsets.edgeCount):
    let it = Bwm_EdgeEntry.read(this.io, this.root, this)
    this.edges.add(it)

proc fromFile*(_: typedesc[Bwm_EdgesArray], filename: string): Bwm_EdgesArray =
  Bwm_EdgesArray.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_FaceIndices], io: KaitaiStream, root: KaitaiStruct, parent: Bwm_FaceIndicesArray): Bwm_FaceIndices =
  template this: untyped = result
  this = new(Bwm_FaceIndices)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Vertex index for first vertex of triangle (0-based index into vertices array).
Vertex indices define the triangle's vertices in counter-clockwise order
when viewed from the front (the side the normal points toward).

  ]##
  let v1IndexExpr = this.io.readU4le()
  this.v1Index = v1IndexExpr

  ##[
  Vertex index for second vertex of triangle (0-based index into vertices array).

  ]##
  let v2IndexExpr = this.io.readU4le()
  this.v2Index = v2IndexExpr

  ##[
  Vertex index for third vertex of triangle (0-based index into vertices array).

  ]##
  let v3IndexExpr = this.io.readU4le()
  this.v3Index = v3IndexExpr

proc fromFile*(_: typedesc[Bwm_FaceIndices], filename: string): Bwm_FaceIndices =
  Bwm_FaceIndices.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_FaceIndicesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_FaceIndicesArray =
  template this: untyped = result
  this = new(Bwm_FaceIndicesArray)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of face vertex index triplets
  ]##
  for i in 0 ..< int(Bwm(this.root).dataTableOffsets.faceCount):
    let it = Bwm_FaceIndices.read(this.io, this.root, this)
    this.faces.add(it)

proc fromFile*(_: typedesc[Bwm_FaceIndicesArray], filename: string): Bwm_FaceIndicesArray =
  Bwm_FaceIndicesArray.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_MaterialsArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_MaterialsArray =
  template this: untyped = result
  this = new(Bwm_MaterialsArray)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of surface material IDs, one per face.
Material IDs determine walkability and physical properties:
- 0 = NotDefined/UNDEFINED (non-walkable)
- 1 = Dirt (walkable)
- 2 = Obscuring (non-walkable, blocks line of sight)
- 3 = Grass (walkable)
- 4 = Stone (walkable)
- 5 = Wood (walkable)
- 6 = Water (walkable)
- 7 = Nonwalk/NON_WALK (non-walkable)
- 8 = Transparent (non-walkable)
- 9 = Carpet (walkable)
- 10 = Metal (walkable)
- 11 = Puddles (walkable)
- 12 = Swamp (walkable)
- 13 = Mud (walkable)
- 14 = Leaves (walkable)
- 15 = Lava (non-walkable, damage-dealing)
- 16 = BottomlessPit (walkable but dangerous)
- 17 = DeepWater (non-walkable)
- 18 = Door (walkable, special handling)
- 19 = Snow/NON_WALK_GRASS (non-walkable)
- 20+ = Additional materials (Sand, BareBones, StoneBridge, etc.)

  ]##
  for i in 0 ..< int(Bwm(this.root).dataTableOffsets.faceCount):
    let it = this.io.readU4le()
    this.materials.add(it)

proc fromFile*(_: typedesc[Bwm_MaterialsArray], filename: string): Bwm_MaterialsArray =
  Bwm_MaterialsArray.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_NormalsArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_NormalsArray =
  template this: untyped = result
  this = new(Bwm_NormalsArray)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of face normal vectors, one per face (WOK only).
Normals are precomputed unit vectors perpendicular to each face.
Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
Normal direction follows right-hand rule based on vertex winding order.

  ]##
  for i in 0 ..< int(Bwm(this.root).dataTableOffsets.faceCount):
    let it = Bwm_Vec3f.read(this.io, this.root, this)
    this.normals.add(it)

proc fromFile*(_: typedesc[Bwm_NormalsArray], filename: string): Bwm_NormalsArray =
  Bwm_NormalsArray.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_PerimetersArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_PerimetersArray =
  template this: untyped = result
  this = new(Bwm_PerimetersArray)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of perimeter markers (WOK only).
Each value is an index into the edges array, marking the end of a perimeter loop.
Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.

  ]##
  for i in 0 ..< int(Bwm(this.root).dataTableOffsets.perimeterCount):
    let it = this.io.readU4le()
    this.perimeters.add(it)

proc fromFile*(_: typedesc[Bwm_PerimetersArray], filename: string): Bwm_PerimetersArray =
  Bwm_PerimetersArray.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_PlanarDistancesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_PlanarDistancesArray =
  template this: untyped = result
  this = new(Bwm_PlanarDistancesArray)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of planar distances, one per face (WOK only).
The D component of the plane equation ax + by + cz + d = 0.
Calculated as d = -normal · vertex1 for each face.
Precomputed to allow quick point-plane relationship tests.

  ]##
  for i in 0 ..< int(Bwm(this.root).dataTableOffsets.faceCount):
    let it = this.io.readF4le()
    this.distances.add(it)

proc fromFile*(_: typedesc[Bwm_PlanarDistancesArray], filename: string): Bwm_PlanarDistancesArray =
  Bwm_PlanarDistancesArray.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_Vec3f], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bwm_Vec3f =
  template this: untyped = result
  this = new(Bwm_Vec3f)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  X coordinate (float32)
  ]##
  let xExpr = this.io.readF4le()
  this.x = xExpr

  ##[
  Y coordinate (float32)
  ]##
  let yExpr = this.io.readF4le()
  this.y = yExpr

  ##[
  Z coordinate (float32)
  ]##
  let zExpr = this.io.readF4le()
  this.z = zExpr

proc fromFile*(_: typedesc[Bwm_Vec3f], filename: string): Bwm_Vec3f =
  Bwm_Vec3f.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_VerticesArray], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_VerticesArray =
  template this: untyped = result
  this = new(Bwm_VerticesArray)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of vertex positions, each vertex is a float3 (x, y, z)
  ]##
  for i in 0 ..< int(Bwm(this.root).dataTableOffsets.vertexCount):
    let it = Bwm_Vec3f.read(this.io, this.root, this)
    this.vertices.add(it)

proc fromFile*(_: typedesc[Bwm_VerticesArray], filename: string): Bwm_VerticesArray =
  Bwm_VerticesArray.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bwm_WalkmeshProperties], io: KaitaiStream, root: KaitaiStruct, parent: Bwm): Bwm_WalkmeshProperties =
  template this: untyped = result
  this = new(Bwm_WalkmeshProperties)
  let root = if root == nil: cast[Bwm](this) else: cast[Bwm](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Walkmesh type identifier:
- 0 = PWK/DWK (Placeable/Door walkmesh)
- 1 = WOK (Area walkmesh)

  ]##
  let walkmeshTypeExpr = this.io.readU4le()
  this.walkmeshType = walkmeshTypeExpr

  ##[
  Relative use hook position 1 (x, y, z).
Position relative to the walkmesh origin, used when the walkmesh may be transformed.
For doors: Defines where the player must stand to interact (relative to door model).
For placeables: Defines interaction points relative to the object's local coordinate system.

  ]##
  let relativeUsePosition1Expr = Bwm_Vec3f.read(this.io, this.root, this)
  this.relativeUsePosition1 = relativeUsePosition1Expr

  ##[
  Relative use hook position 2 (x, y, z).
Second interaction point relative to the walkmesh origin.

  ]##
  let relativeUsePosition2Expr = Bwm_Vec3f.read(this.io, this.root, this)
  this.relativeUsePosition2 = relativeUsePosition2Expr

  ##[
  Absolute use hook position 1 (x, y, z).
Position in world space, used when the walkmesh position is known.
For doors: Precomputed world-space interaction points (position + relative hook).
For placeables: World-space interaction points accounting for object placement.

  ]##
  let absoluteUsePosition1Expr = Bwm_Vec3f.read(this.io, this.root, this)
  this.absoluteUsePosition1 = absoluteUsePosition1Expr

  ##[
  Absolute use hook position 2 (x, y, z).
Second absolute interaction point in world space.

  ]##
  let absoluteUsePosition2Expr = Bwm_Vec3f.read(this.io, this.root, this)
  this.absoluteUsePosition2 = absoluteUsePosition2Expr

  ##[
  Walkmesh position offset (x, y, z) in world space.
For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
For placeable/door walkmeshes: The position where the object is placed in the area.
Used to transform vertices from local to world coordinates.

  ]##
  let positionExpr = Bwm_Vec3f.read(this.io, this.root, this)
  this.position = positionExpr

proc isAreaWalkmesh(this: Bwm_WalkmeshProperties): bool = 

  ##[
  True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)
  ]##
  if this.isAreaWalkmeshInstFlag:
    return this.isAreaWalkmeshInst
  let isAreaWalkmeshInstExpr = bool(this.walkmeshType == 1)
  this.isAreaWalkmeshInst = isAreaWalkmeshInstExpr
  this.isAreaWalkmeshInstFlag = true
  return this.isAreaWalkmeshInst

proc isPlaceableOrDoor(this: Bwm_WalkmeshProperties): bool = 

  ##[
  True if this is a placeable or door walkmesh (PWK/DWK)
  ]##
  if this.isPlaceableOrDoorInstFlag:
    return this.isPlaceableOrDoorInst
  let isPlaceableOrDoorInstExpr = bool(this.walkmeshType == 0)
  this.isPlaceableOrDoorInst = isPlaceableOrDoorInstExpr
  this.isPlaceableOrDoorInstFlag = true
  return this.isPlaceableOrDoorInst

proc fromFile*(_: typedesc[Bwm_WalkmeshProperties], filename: string): Bwm_WalkmeshProperties =
  Bwm_WalkmeshProperties.read(newKaitaiFileStream(filename), nil, nil)

