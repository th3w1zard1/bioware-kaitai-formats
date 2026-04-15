-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local utils = require("utils")
local str_decode = require("string_decode")

-- 
-- BWM (Binary WalkMesh) files define walkable surfaces for pathfinding and collision detection
-- in Knights of the Old Republic (KotOR) games. BWM files are stored on disk with different
-- extensions depending on their type:
-- 
-- - WOK: Area walkmesh files (walkmesh_type = 1) - defines walkable regions in game areas
-- - PWK: Placeable walkmesh files (walkmesh_type = 0) - collision geometry for containers, furniture
-- - DWK: Door walkmesh files (walkmesh_type = 0) - collision geometry for doors in various states
-- 
-- The format uses a header-based structure where offsets point to various data tables, allowing
-- efficient random access to vertices, faces, materials, and acceleration structures.
-- 
-- Binary Format Structure:
-- - File Header (8 bytes): Magic "BWM " and version "V1.0"
-- - Walkmesh Properties (52 bytes): Type, hook vectors, position
-- - Data Table Offsets (84 bytes): Counts and offsets for all data tables
-- - Vertices Array: Array of float3 (x, y, z) per vertex
-- - Face Indices Array: Array of uint32 triplets (vertex indices per face)
-- - Materials Array: Array of uint32 (SurfaceMaterial ID per face)
-- - Normals Array: Array of float3 (face normal per face) - WOK only
-- - Planar Distances Array: Array of float32 (per face) - WOK only
-- - AABB Nodes Array: Array of AABB structures (WOK only)
-- - Adjacencies Array: Array of int32 triplets (WOK only, -1 for no neighbor)
-- - Edges Array: Array of (edge_index, transition) pairs (WOK only)
-- - Perimeters Array: Array of edge indices (WOK only)
-- 
-- References:
-- - https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm
-- - https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/bwmreader.cpp:27-171
-- - https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp:73-248
-- - https://github.com/KotOR-Community-Patches/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts:452-473
Bwm = class.class(KaitaiStruct)

function Bwm:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Bwm:_read()
  self.header = Bwm.BwmHeader(self._io, self, self._root)
  self.walkmesh_properties = Bwm.WalkmeshProperties(self._io, self, self._root)
  self.data_table_offsets = Bwm.DataTableOffsets(self._io, self, self._root)
end

-- 
-- Array of AABB tree nodes for spatial acceleration - WOK only.
Bwm.property.aabb_nodes = {}
function Bwm.property.aabb_nodes:get()
  if self._m_aabb_nodes ~= nil then
    return self._m_aabb_nodes
  end

  if  ((self._root.walkmesh_properties.walkmesh_type == 1) and (self._root.data_table_offsets.aabb_count > 0))  then
    local _pos = self._io:pos()
    self._io:seek(self._root.data_table_offsets.aabb_offset)
    self._m_aabb_nodes = Bwm.AabbNodesArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_aabb_nodes
end

-- 
-- Array of adjacency indices (int32 triplets per walkable face) - WOK only.
Bwm.property.adjacencies = {}
function Bwm.property.adjacencies:get()
  if self._m_adjacencies ~= nil then
    return self._m_adjacencies
  end

  if  ((self._root.walkmesh_properties.walkmesh_type == 1) and (self._root.data_table_offsets.adjacency_count > 0))  then
    local _pos = self._io:pos()
    self._io:seek(self._root.data_table_offsets.adjacency_offset)
    self._m_adjacencies = Bwm.AdjacenciesArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_adjacencies
end

-- 
-- Array of perimeter edges (edge_index, transition pairs) - WOK only.
Bwm.property.edges = {}
function Bwm.property.edges:get()
  if self._m_edges ~= nil then
    return self._m_edges
  end

  if  ((self._root.walkmesh_properties.walkmesh_type == 1) and (self._root.data_table_offsets.edge_count > 0))  then
    local _pos = self._io:pos()
    self._io:seek(self._root.data_table_offsets.edge_offset)
    self._m_edges = Bwm.EdgesArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_edges
end

-- 
-- Array of face vertex indices (uint32 triplets).
Bwm.property.face_indices = {}
function Bwm.property.face_indices:get()
  if self._m_face_indices ~= nil then
    return self._m_face_indices
  end

  if self._root.data_table_offsets.face_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self._root.data_table_offsets.face_indices_offset)
    self._m_face_indices = Bwm.FaceIndicesArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_face_indices
end

-- 
-- Array of surface material IDs per face.
Bwm.property.materials = {}
function Bwm.property.materials:get()
  if self._m_materials ~= nil then
    return self._m_materials
  end

  if self._root.data_table_offsets.face_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self._root.data_table_offsets.materials_offset)
    self._m_materials = Bwm.MaterialsArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_materials
end

-- 
-- Array of face normal vectors (float3 triplets) - WOK only.
Bwm.property.normals = {}
function Bwm.property.normals:get()
  if self._m_normals ~= nil then
    return self._m_normals
  end

  if  ((self._root.walkmesh_properties.walkmesh_type == 1) and (self._root.data_table_offsets.face_count > 0))  then
    local _pos = self._io:pos()
    self._io:seek(self._root.data_table_offsets.normals_offset)
    self._m_normals = Bwm.NormalsArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_normals
end

-- 
-- Array of perimeter markers (edge indices marking end of loops) - WOK only.
Bwm.property.perimeters = {}
function Bwm.property.perimeters:get()
  if self._m_perimeters ~= nil then
    return self._m_perimeters
  end

  if  ((self._root.walkmesh_properties.walkmesh_type == 1) and (self._root.data_table_offsets.perimeter_count > 0))  then
    local _pos = self._io:pos()
    self._io:seek(self._root.data_table_offsets.perimeter_offset)
    self._m_perimeters = Bwm.PerimetersArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_perimeters
end

-- 
-- Array of planar distances (float32 per face) - WOK only.
Bwm.property.planar_distances = {}
function Bwm.property.planar_distances:get()
  if self._m_planar_distances ~= nil then
    return self._m_planar_distances
  end

  if  ((self._root.walkmesh_properties.walkmesh_type == 1) and (self._root.data_table_offsets.face_count > 0))  then
    local _pos = self._io:pos()
    self._io:seek(self._root.data_table_offsets.distances_offset)
    self._m_planar_distances = Bwm.PlanarDistancesArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_planar_distances
end

-- 
-- Array of vertex positions (float3 triplets).
Bwm.property.vertices = {}
function Bwm.property.vertices:get()
  if self._m_vertices ~= nil then
    return self._m_vertices
  end

  if self._root.data_table_offsets.vertex_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self._root.data_table_offsets.vertex_offset)
    self._m_vertices = Bwm.VerticesArray(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_vertices
end

-- 
-- BWM file header (8 bytes) - magic and version signature.
-- 
-- Walkmesh properties section (52 bytes) - type, hooks, position.
-- 
-- Data table offsets section (84 bytes) - counts and offsets for all data tables.

Bwm.AabbNode = class.class(KaitaiStruct)

function Bwm.AabbNode:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.AabbNode:_read()
  self.bounds_min = Bwm.Vec3f(self._io, self, self._root)
  self.bounds_max = Bwm.Vec3f(self._io, self, self._root)
  self.face_index = self._io:read_s4le()
  self.unknown = self._io:read_u4le()
  self.most_significant_plane = self._io:read_u4le()
  self.left_child_index = self._io:read_u4le()
  self.right_child_index = self._io:read_u4le()
end

-- 
-- True if this node has a left child.
Bwm.AabbNode.property.has_left_child = {}
function Bwm.AabbNode.property.has_left_child:get()
  if self._m_has_left_child ~= nil then
    return self._m_has_left_child
  end

  self._m_has_left_child = self.left_child_index ~= 4294967295
  return self._m_has_left_child
end

-- 
-- True if this node has a right child.
Bwm.AabbNode.property.has_right_child = {}
function Bwm.AabbNode.property.has_right_child:get()
  if self._m_has_right_child ~= nil then
    return self._m_has_right_child
  end

  self._m_has_right_child = self.right_child_index ~= 4294967295
  return self._m_has_right_child
end

-- 
-- True if this is an internal node (has children), false if leaf node.
Bwm.AabbNode.property.is_internal_node = {}
function Bwm.AabbNode.property.is_internal_node:get()
  if self._m_is_internal_node ~= nil then
    return self._m_is_internal_node
  end

  self._m_is_internal_node = self.face_index == -1
  return self._m_is_internal_node
end

-- 
-- True if this is a leaf node (contains a face), false if internal node.
Bwm.AabbNode.property.is_leaf_node = {}
function Bwm.AabbNode.property.is_leaf_node:get()
  if self._m_is_leaf_node ~= nil then
    return self._m_is_leaf_node
  end

  self._m_is_leaf_node = self.face_index ~= -1
  return self._m_is_leaf_node
end

-- 
-- Minimum bounding box coordinates (x, y, z).
-- Defines the lower corner of the axis-aligned bounding box.
-- 
-- Maximum bounding box coordinates (x, y, z).
-- Defines the upper corner of the axis-aligned bounding box.
-- 
-- Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
-- Leaf nodes contain a single face, internal nodes contain child nodes.
-- 
-- Unknown field (typically 4).
-- Purpose is undocumented but appears in all AABB nodes.
-- 
-- Split axis/plane identifier:
-- - 0x00 = No children (leaf node)
-- - 0x01 = Positive X axis split
-- - 0x02 = Positive Y axis split
-- - 0x03 = Positive Z axis split
-- - 0xFFFFFFFE (-2) = Negative X axis split
-- - 0xFFFFFFFD (-3) = Negative Y axis split
-- - 0xFFFFFFFC (-4) = Negative Z axis split
-- 
-- Index to left child node (0-based array index).
-- 0xFFFFFFFF indicates no left child.
-- Child indices are 0-based indices into the AABB nodes array.
-- 
-- Index to right child node (0-based array index).
-- 0xFFFFFFFF indicates no right child.
-- Child indices are 0-based indices into the AABB nodes array.

Bwm.AabbNodesArray = class.class(KaitaiStruct)

function Bwm.AabbNodesArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.AabbNodesArray:_read()
  self.nodes = {}
  for i = 0, self._root.data_table_offsets.aabb_count - 1 do
    self.nodes[i + 1] = Bwm.AabbNode(self._io, self, self._root)
  end
end

-- 
-- Array of AABB tree nodes for spatial acceleration (WOK only).
-- AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).

Bwm.AdjacenciesArray = class.class(KaitaiStruct)

function Bwm.AdjacenciesArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.AdjacenciesArray:_read()
  self.adjacencies = {}
  for i = 0, self._root.data_table_offsets.adjacency_count - 1 do
    self.adjacencies[i + 1] = Bwm.AdjacencyTriplet(self._io, self, self._root)
  end
end

-- 
-- Array of adjacency triplets, one per walkable face (WOK only).
-- Each walkable face has exactly three adjacency entries, one for each edge.
-- Adjacency count equals the number of walkable faces, not the total face count.

Bwm.AdjacencyTriplet = class.class(KaitaiStruct)

function Bwm.AdjacencyTriplet:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.AdjacencyTriplet:_read()
  self.edge_0_adjacency = self._io:read_s4le()
  self.edge_1_adjacency = self._io:read_s4le()
  self.edge_2_adjacency = self._io:read_s4le()
end

-- 
-- Face index of adjacent face for edge 0 (decoded from adjacency index).
Bwm.AdjacencyTriplet.property.edge_0_face_index = {}
function Bwm.AdjacencyTriplet.property.edge_0_face_index:get()
  if self._m_edge_0_face_index ~= nil then
    return self._m_edge_0_face_index
  end

  self._m_edge_0_face_index = utils.box_unwrap((self.edge_0_adjacency ~= -1) and utils.box_wrap(math.floor(self.edge_0_adjacency / 3)) or (-1))
  return self._m_edge_0_face_index
end

-- 
-- True if edge 0 has an adjacent walkable face.
Bwm.AdjacencyTriplet.property.edge_0_has_neighbor = {}
function Bwm.AdjacencyTriplet.property.edge_0_has_neighbor:get()
  if self._m_edge_0_has_neighbor ~= nil then
    return self._m_edge_0_has_neighbor
  end

  self._m_edge_0_has_neighbor = self.edge_0_adjacency ~= -1
  return self._m_edge_0_has_neighbor
end

-- 
-- Local edge index (0, 1, or 2) of adjacent face for edge 0.
Bwm.AdjacencyTriplet.property.edge_0_local_edge = {}
function Bwm.AdjacencyTriplet.property.edge_0_local_edge:get()
  if self._m_edge_0_local_edge ~= nil then
    return self._m_edge_0_local_edge
  end

  self._m_edge_0_local_edge = utils.box_unwrap((self.edge_0_adjacency ~= -1) and utils.box_wrap(self.edge_0_adjacency % 3) or (-1))
  return self._m_edge_0_local_edge
end

-- 
-- Face index of adjacent face for edge 1 (decoded from adjacency index).
Bwm.AdjacencyTriplet.property.edge_1_face_index = {}
function Bwm.AdjacencyTriplet.property.edge_1_face_index:get()
  if self._m_edge_1_face_index ~= nil then
    return self._m_edge_1_face_index
  end

  self._m_edge_1_face_index = utils.box_unwrap((self.edge_1_adjacency ~= -1) and utils.box_wrap(math.floor(self.edge_1_adjacency / 3)) or (-1))
  return self._m_edge_1_face_index
end

-- 
-- True if edge 1 has an adjacent walkable face.
Bwm.AdjacencyTriplet.property.edge_1_has_neighbor = {}
function Bwm.AdjacencyTriplet.property.edge_1_has_neighbor:get()
  if self._m_edge_1_has_neighbor ~= nil then
    return self._m_edge_1_has_neighbor
  end

  self._m_edge_1_has_neighbor = self.edge_1_adjacency ~= -1
  return self._m_edge_1_has_neighbor
end

-- 
-- Local edge index (0, 1, or 2) of adjacent face for edge 1.
Bwm.AdjacencyTriplet.property.edge_1_local_edge = {}
function Bwm.AdjacencyTriplet.property.edge_1_local_edge:get()
  if self._m_edge_1_local_edge ~= nil then
    return self._m_edge_1_local_edge
  end

  self._m_edge_1_local_edge = utils.box_unwrap((self.edge_1_adjacency ~= -1) and utils.box_wrap(self.edge_1_adjacency % 3) or (-1))
  return self._m_edge_1_local_edge
end

-- 
-- Face index of adjacent face for edge 2 (decoded from adjacency index).
Bwm.AdjacencyTriplet.property.edge_2_face_index = {}
function Bwm.AdjacencyTriplet.property.edge_2_face_index:get()
  if self._m_edge_2_face_index ~= nil then
    return self._m_edge_2_face_index
  end

  self._m_edge_2_face_index = utils.box_unwrap((self.edge_2_adjacency ~= -1) and utils.box_wrap(math.floor(self.edge_2_adjacency / 3)) or (-1))
  return self._m_edge_2_face_index
end

-- 
-- True if edge 2 has an adjacent walkable face.
Bwm.AdjacencyTriplet.property.edge_2_has_neighbor = {}
function Bwm.AdjacencyTriplet.property.edge_2_has_neighbor:get()
  if self._m_edge_2_has_neighbor ~= nil then
    return self._m_edge_2_has_neighbor
  end

  self._m_edge_2_has_neighbor = self.edge_2_adjacency ~= -1
  return self._m_edge_2_has_neighbor
end

-- 
-- Local edge index (0, 1, or 2) of adjacent face for edge 2.
Bwm.AdjacencyTriplet.property.edge_2_local_edge = {}
function Bwm.AdjacencyTriplet.property.edge_2_local_edge:get()
  if self._m_edge_2_local_edge ~= nil then
    return self._m_edge_2_local_edge
  end

  self._m_edge_2_local_edge = utils.box_unwrap((self.edge_2_adjacency ~= -1) and utils.box_wrap(self.edge_2_adjacency % 3) or (-1))
  return self._m_edge_2_local_edge
end

-- 
-- Adjacency index for edge 0 (between v1 and v2).
-- Encoding: face_index * 3 + edge_index
-- -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
-- 
-- Adjacency index for edge 1 (between v2 and v3).
-- Encoding: face_index * 3 + edge_index
-- -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
-- 
-- Adjacency index for edge 2 (between v3 and v1).
-- Encoding: face_index * 3 + edge_index
-- -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).

Bwm.BwmHeader = class.class(KaitaiStruct)

function Bwm.BwmHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.BwmHeader:_read()
  self.magic = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.version = str_decode.decode(self._io:read_bytes(4), "ASCII")
end

-- 
-- Validation check that the file is a valid BWM file.
-- Both magic and version must match expected values.
Bwm.BwmHeader.property.is_valid_bwm = {}
function Bwm.BwmHeader.property.is_valid_bwm:get()
  if self._m_is_valid_bwm ~= nil then
    return self._m_is_valid_bwm
  end

  self._m_is_valid_bwm =  ((self.magic == "BWM ") and (self.version == "V1.0")) 
  return self._m_is_valid_bwm
end

-- 
-- File type signature. Must be "BWM " (space-padded).
-- The space after "BWM" is significant and must be present.
-- 
-- File format version. Always "V1.0" for KotOR BWM files.
-- This is the first and only version of the BWM format used in KotOR games.

Bwm.DataTableOffsets = class.class(KaitaiStruct)

function Bwm.DataTableOffsets:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.DataTableOffsets:_read()
  self.vertex_count = self._io:read_u4le()
  self.vertex_offset = self._io:read_u4le()
  self.face_count = self._io:read_u4le()
  self.face_indices_offset = self._io:read_u4le()
  self.materials_offset = self._io:read_u4le()
  self.normals_offset = self._io:read_u4le()
  self.distances_offset = self._io:read_u4le()
  self.aabb_count = self._io:read_u4le()
  self.aabb_offset = self._io:read_u4le()
  self.unknown = self._io:read_u4le()
  self.adjacency_count = self._io:read_u4le()
  self.adjacency_offset = self._io:read_u4le()
  self.edge_count = self._io:read_u4le()
  self.edge_offset = self._io:read_u4le()
  self.perimeter_count = self._io:read_u4le()
  self.perimeter_offset = self._io:read_u4le()
end

-- 
-- Number of vertices in the walkmesh.
-- 
-- Byte offset to vertex array from the beginning of the file.
-- 
-- Number of faces (triangles) in the walkmesh.
-- 
-- Byte offset to face indices array from the beginning of the file.
-- 
-- Byte offset to materials array from the beginning of the file.
-- 
-- Byte offset to face normals array from the beginning of the file.
-- Only used for WOK files (area walkmeshes).
-- 
-- Byte offset to planar distances array from the beginning of the file.
-- Only used for WOK files (area walkmeshes).
-- 
-- Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
-- AABB trees provide spatial acceleration for raycasting and point queries.
-- 
-- Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
-- Only present if aabb_count > 0.
-- 
-- Unknown field (typically 0 or 4).
-- Purpose is undocumented but appears in all BWM files.
-- 
-- Number of walkable faces for adjacency data (WOK only).
-- This equals the number of walkable faces, not the total face count.
-- Adjacencies are stored only for walkable faces.
-- 
-- Byte offset to adjacency array from the beginning of the file (WOK only).
-- Only present if adjacency_count > 0.
-- 
-- Number of perimeter edges (WOK only).
-- Perimeter edges are boundary edges with no walkable neighbor.
-- 
-- Byte offset to edges array from the beginning of the file (WOK only).
-- Only present if edge_count > 0.
-- 
-- Number of perimeter markers (WOK only).
-- Perimeter markers indicate the end of closed loops of perimeter edges.
-- 
-- Byte offset to perimeters array from the beginning of the file (WOK only).
-- Only present if perimeter_count > 0.

Bwm.EdgeEntry = class.class(KaitaiStruct)

function Bwm.EdgeEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.EdgeEntry:_read()
  self.edge_index = self._io:read_u4le()
  self.transition = self._io:read_s4le()
end

-- 
-- Face index that this edge belongs to (decoded from edge_index).
Bwm.EdgeEntry.property.face_index = {}
function Bwm.EdgeEntry.property.face_index:get()
  if self._m_face_index ~= nil then
    return self._m_face_index
  end

  self._m_face_index = math.floor(self.edge_index / 3)
  return self._m_face_index
end

-- 
-- True if this edge has a transition ID (links to door/area connection).
Bwm.EdgeEntry.property.has_transition = {}
function Bwm.EdgeEntry.property.has_transition:get()
  if self._m_has_transition ~= nil then
    return self._m_has_transition
  end

  self._m_has_transition = self.transition ~= -1
  return self._m_has_transition
end

-- 
-- Local edge index (0, 1, or 2) within the face (decoded from edge_index).
Bwm.EdgeEntry.property.local_edge_index = {}
function Bwm.EdgeEntry.property.local_edge_index:get()
  if self._m_local_edge_index ~= nil then
    return self._m_local_edge_index
  end

  self._m_local_edge_index = self.edge_index % 3
  return self._m_local_edge_index
end

-- 
-- Encoded edge index: face_index * 3 + local_edge_index
-- Identifies which face and which edge (0, 1, or 2) of that face.
-- Edge 0: between v1 and v2
-- Edge 1: between v2 and v3
-- Edge 2: between v3 and v1
-- 
-- Transition ID for room/area connections, -1 if no transition.
-- Non-negative values reference door connections or area boundaries.
-- -1 indicates this is just a boundary edge with no transition.

Bwm.EdgesArray = class.class(KaitaiStruct)

function Bwm.EdgesArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.EdgesArray:_read()
  self.edges = {}
  for i = 0, self._root.data_table_offsets.edge_count - 1 do
    self.edges[i + 1] = Bwm.EdgeEntry(self._io, self, self._root)
  end
end

-- 
-- Array of perimeter edges (WOK only).
-- Perimeter edges are boundary edges with no walkable neighbor.
-- Each edge entry contains an edge index and optional transition ID.

Bwm.FaceIndices = class.class(KaitaiStruct)

function Bwm.FaceIndices:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.FaceIndices:_read()
  self.v1_index = self._io:read_u4le()
  self.v2_index = self._io:read_u4le()
  self.v3_index = self._io:read_u4le()
end

-- 
-- Vertex index for first vertex of triangle (0-based index into vertices array).
-- Vertex indices define the triangle's vertices in counter-clockwise order
-- when viewed from the front (the side the normal points toward).
-- 
-- Vertex index for second vertex of triangle (0-based index into vertices array).
-- 
-- Vertex index for third vertex of triangle (0-based index into vertices array).

Bwm.FaceIndicesArray = class.class(KaitaiStruct)

function Bwm.FaceIndicesArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.FaceIndicesArray:_read()
  self.faces = {}
  for i = 0, self._root.data_table_offsets.face_count - 1 do
    self.faces[i + 1] = Bwm.FaceIndices(self._io, self, self._root)
  end
end

-- 
-- Array of face vertex index triplets.

Bwm.MaterialsArray = class.class(KaitaiStruct)

function Bwm.MaterialsArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.MaterialsArray:_read()
  self.materials = {}
  for i = 0, self._root.data_table_offsets.face_count - 1 do
    self.materials[i + 1] = self._io:read_u4le()
  end
end

-- 
-- Array of surface material IDs, one per face.
-- Material IDs determine walkability and physical properties:
-- - 0 = NotDefined/UNDEFINED (non-walkable)
-- - 1 = Dirt (walkable)
-- - 2 = Obscuring (non-walkable, blocks line of sight)
-- - 3 = Grass (walkable)
-- - 4 = Stone (walkable)
-- - 5 = Wood (walkable)
-- - 6 = Water (walkable)
-- - 7 = Nonwalk/NON_WALK (non-walkable)
-- - 8 = Transparent (non-walkable)
-- - 9 = Carpet (walkable)
-- - 10 = Metal (walkable)
-- - 11 = Puddles (walkable)
-- - 12 = Swamp (walkable)
-- - 13 = Mud (walkable)
-- - 14 = Leaves (walkable)
-- - 15 = Lava (non-walkable, damage-dealing)
-- - 16 = BottomlessPit (walkable but dangerous)
-- - 17 = DeepWater (non-walkable)
-- - 18 = Door (walkable, special handling)
-- - 19 = Snow/NON_WALK_GRASS (non-walkable)
-- - 20+ = Additional materials (Sand, BareBones, StoneBridge, etc.)

Bwm.NormalsArray = class.class(KaitaiStruct)

function Bwm.NormalsArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.NormalsArray:_read()
  self.normals = {}
  for i = 0, self._root.data_table_offsets.face_count - 1 do
    self.normals[i + 1] = Bwm.Vec3f(self._io, self, self._root)
  end
end

-- 
-- Array of face normal vectors, one per face (WOK only).
-- Normals are precomputed unit vectors perpendicular to each face.
-- Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
-- Normal direction follows right-hand rule based on vertex winding order.

Bwm.PerimetersArray = class.class(KaitaiStruct)

function Bwm.PerimetersArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.PerimetersArray:_read()
  self.perimeters = {}
  for i = 0, self._root.data_table_offsets.perimeter_count - 1 do
    self.perimeters[i + 1] = self._io:read_u4le()
  end
end

-- 
-- Array of perimeter markers (WOK only).
-- Each value is an index into the edges array, marking the end of a perimeter loop.
-- Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
-- Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.

Bwm.PlanarDistancesArray = class.class(KaitaiStruct)

function Bwm.PlanarDistancesArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.PlanarDistancesArray:_read()
  self.distances = {}
  for i = 0, self._root.data_table_offsets.face_count - 1 do
    self.distances[i + 1] = self._io:read_f4le()
  end
end

-- 
-- Array of planar distances, one per face (WOK only).
-- The D component of the plane equation ax + by + cz + d = 0.
-- Calculated as d = -normal · vertex1 for each face.
-- Precomputed to allow quick point-plane relationship tests.

Bwm.Vec3f = class.class(KaitaiStruct)

function Bwm.Vec3f:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.Vec3f:_read()
  self.x = self._io:read_f4le()
  self.y = self._io:read_f4le()
  self.z = self._io:read_f4le()
end

-- 
-- X coordinate (float32).
-- 
-- Y coordinate (float32).
-- 
-- Z coordinate (float32).

Bwm.VerticesArray = class.class(KaitaiStruct)

function Bwm.VerticesArray:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.VerticesArray:_read()
  self.vertices = {}
  for i = 0, self._root.data_table_offsets.vertex_count - 1 do
    self.vertices[i + 1] = Bwm.Vec3f(self._io, self, self._root)
  end
end

-- 
-- Array of vertex positions, each vertex is a float3 (x, y, z).

Bwm.WalkmeshProperties = class.class(KaitaiStruct)

function Bwm.WalkmeshProperties:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Bwm.WalkmeshProperties:_read()
  self.walkmesh_type = self._io:read_u4le()
  self.relative_use_position_1 = Bwm.Vec3f(self._io, self, self._root)
  self.relative_use_position_2 = Bwm.Vec3f(self._io, self, self._root)
  self.absolute_use_position_1 = Bwm.Vec3f(self._io, self, self._root)
  self.absolute_use_position_2 = Bwm.Vec3f(self._io, self, self._root)
  self.position = Bwm.Vec3f(self._io, self, self._root)
end

-- 
-- True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK).
Bwm.WalkmeshProperties.property.is_area_walkmesh = {}
function Bwm.WalkmeshProperties.property.is_area_walkmesh:get()
  if self._m_is_area_walkmesh ~= nil then
    return self._m_is_area_walkmesh
  end

  self._m_is_area_walkmesh = self.walkmesh_type == 1
  return self._m_is_area_walkmesh
end

-- 
-- True if this is a placeable or door walkmesh (PWK/DWK).
Bwm.WalkmeshProperties.property.is_placeable_or_door = {}
function Bwm.WalkmeshProperties.property.is_placeable_or_door:get()
  if self._m_is_placeable_or_door ~= nil then
    return self._m_is_placeable_or_door
  end

  self._m_is_placeable_or_door = self.walkmesh_type == 0
  return self._m_is_placeable_or_door
end

-- 
-- Walkmesh type identifier:
-- - 0 = PWK/DWK (Placeable/Door walkmesh)
-- - 1 = WOK (Area walkmesh)
-- 
-- Relative use hook position 1 (x, y, z).
-- Position relative to the walkmesh origin, used when the walkmesh may be transformed.
-- For doors: Defines where the player must stand to interact (relative to door model).
-- For placeables: Defines interaction points relative to the object's local coordinate system.
-- 
-- Relative use hook position 2 (x, y, z).
-- Second interaction point relative to the walkmesh origin.
-- 
-- Absolute use hook position 1 (x, y, z).
-- Position in world space, used when the walkmesh position is known.
-- For doors: Precomputed world-space interaction points (position + relative hook).
-- For placeables: World-space interaction points accounting for object placement.
-- 
-- Absolute use hook position 2 (x, y, z).
-- Second absolute interaction point in world space.
-- 
-- Walkmesh position offset (x, y, z) in world space.
-- For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
-- For placeable/door walkmeshes: The position where the object is placed in the area.
-- Used to transform vertices from local to world coordinates.

