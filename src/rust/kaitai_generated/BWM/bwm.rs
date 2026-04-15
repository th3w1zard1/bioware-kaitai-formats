// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#![allow(unused_imports)]
#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(irrefutable_let_patterns)]
#![allow(unused_comparisons)]

extern crate kaitai;
use kaitai::*;
use std::convert::{TryFrom, TryInto};
use std::cell::{Ref, Cell, RefCell};
use std::rc::{Rc, Weak};

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

#[derive(Default, Debug, Clone)]
pub struct Bwm {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Bwm_BwmHeader>>,
    walkmesh_properties: RefCell<OptRc<Bwm_WalkmeshProperties>>,
    data_table_offsets: RefCell<OptRc<Bwm_DataTableOffsets>>,
    _io: RefCell<BytesReader>,
    f_aabb_nodes: Cell<bool>,
    aabb_nodes: RefCell<OptRc<Bwm_AabbNodesArray>>,
    f_adjacencies: Cell<bool>,
    adjacencies: RefCell<OptRc<Bwm_AdjacenciesArray>>,
    f_edges: Cell<bool>,
    edges: RefCell<OptRc<Bwm_EdgesArray>>,
    f_face_indices: Cell<bool>,
    face_indices: RefCell<OptRc<Bwm_FaceIndicesArray>>,
    f_materials: Cell<bool>,
    materials: RefCell<OptRc<Bwm_MaterialsArray>>,
    f_normals: Cell<bool>,
    normals: RefCell<OptRc<Bwm_NormalsArray>>,
    f_perimeters: Cell<bool>,
    perimeters: RefCell<OptRc<Bwm_PerimetersArray>>,
    f_planar_distances: Cell<bool>,
    planar_distances: RefCell<OptRc<Bwm_PlanarDistancesArray>>,
    f_vertices: Cell<bool>,
    vertices: RefCell<OptRc<Bwm_VerticesArray>>,
}
impl KStruct for Bwm {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        let t = Self::read_into::<_, Bwm_BwmHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        let t = Self::read_into::<_, Bwm_WalkmeshProperties>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.walkmesh_properties.borrow_mut() = t;
        let t = Self::read_into::<_, Bwm_DataTableOffsets>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.data_table_offsets.borrow_mut() = t;
        Ok(())
    }
}
impl Bwm {

    /**
     * Array of AABB tree nodes for spatial acceleration - WOK only
     */
    pub fn aabb_nodes(
        &self
    ) -> KResult<Ref<'_, OptRc<Bwm_AabbNodesArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_aabb_nodes.get() {
            return Ok(self.aabb_nodes.borrow());
        }
        if  ((((*_r.walkmesh_properties().walkmesh_type() as u32) == (1 as u32))) && (((*_r.data_table_offsets().aabb_count() as u32) > (0 as u32))))  {
            let _pos = _io.pos();
            _io.seek(*_r.data_table_offsets().aabb_offset() as usize)?;
            let t = Self::read_into::<_, Bwm_AabbNodesArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.aabb_nodes.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.aabb_nodes.borrow())
    }

    /**
     * Array of adjacency indices (int32 triplets per walkable face) - WOK only
     */
    pub fn adjacencies(
        &self
    ) -> KResult<Ref<'_, OptRc<Bwm_AdjacenciesArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_adjacencies.get() {
            return Ok(self.adjacencies.borrow());
        }
        if  ((((*_r.walkmesh_properties().walkmesh_type() as u32) == (1 as u32))) && (((*_r.data_table_offsets().adjacency_count() as u32) > (0 as u32))))  {
            let _pos = _io.pos();
            _io.seek(*_r.data_table_offsets().adjacency_offset() as usize)?;
            let t = Self::read_into::<_, Bwm_AdjacenciesArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.adjacencies.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.adjacencies.borrow())
    }

    /**
     * Array of perimeter edges (edge_index, transition pairs) - WOK only
     */
    pub fn edges(
        &self
    ) -> KResult<Ref<'_, OptRc<Bwm_EdgesArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edges.get() {
            return Ok(self.edges.borrow());
        }
        if  ((((*_r.walkmesh_properties().walkmesh_type() as u32) == (1 as u32))) && (((*_r.data_table_offsets().edge_count() as u32) > (0 as u32))))  {
            let _pos = _io.pos();
            _io.seek(*_r.data_table_offsets().edge_offset() as usize)?;
            let t = Self::read_into::<_, Bwm_EdgesArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.edges.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.edges.borrow())
    }

    /**
     * Array of face vertex indices (uint32 triplets)
     */
    pub fn face_indices(
        &self
    ) -> KResult<Ref<'_, OptRc<Bwm_FaceIndicesArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_face_indices.get() {
            return Ok(self.face_indices.borrow());
        }
        if ((*_r.data_table_offsets().face_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*_r.data_table_offsets().face_indices_offset() as usize)?;
            let t = Self::read_into::<_, Bwm_FaceIndicesArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.face_indices.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.face_indices.borrow())
    }

    /**
     * Array of surface material IDs per face
     */
    pub fn materials(
        &self
    ) -> KResult<Ref<'_, OptRc<Bwm_MaterialsArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_materials.get() {
            return Ok(self.materials.borrow());
        }
        if ((*_r.data_table_offsets().face_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*_r.data_table_offsets().materials_offset() as usize)?;
            let t = Self::read_into::<_, Bwm_MaterialsArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.materials.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.materials.borrow())
    }

    /**
     * Array of face normal vectors (float3 triplets) - WOK only
     */
    pub fn normals(
        &self
    ) -> KResult<Ref<'_, OptRc<Bwm_NormalsArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_normals.get() {
            return Ok(self.normals.borrow());
        }
        if  ((((*_r.walkmesh_properties().walkmesh_type() as u32) == (1 as u32))) && (((*_r.data_table_offsets().face_count() as u32) > (0 as u32))))  {
            let _pos = _io.pos();
            _io.seek(*_r.data_table_offsets().normals_offset() as usize)?;
            let t = Self::read_into::<_, Bwm_NormalsArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.normals.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.normals.borrow())
    }

    /**
     * Array of perimeter markers (edge indices marking end of loops) - WOK only
     */
    pub fn perimeters(
        &self
    ) -> KResult<Ref<'_, OptRc<Bwm_PerimetersArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_perimeters.get() {
            return Ok(self.perimeters.borrow());
        }
        if  ((((*_r.walkmesh_properties().walkmesh_type() as u32) == (1 as u32))) && (((*_r.data_table_offsets().perimeter_count() as u32) > (0 as u32))))  {
            let _pos = _io.pos();
            _io.seek(*_r.data_table_offsets().perimeter_offset() as usize)?;
            let t = Self::read_into::<_, Bwm_PerimetersArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.perimeters.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.perimeters.borrow())
    }

    /**
     * Array of planar distances (float32 per face) - WOK only
     */
    pub fn planar_distances(
        &self
    ) -> KResult<Ref<'_, OptRc<Bwm_PlanarDistancesArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_planar_distances.get() {
            return Ok(self.planar_distances.borrow());
        }
        if  ((((*_r.walkmesh_properties().walkmesh_type() as u32) == (1 as u32))) && (((*_r.data_table_offsets().face_count() as u32) > (0 as u32))))  {
            let _pos = _io.pos();
            _io.seek(*_r.data_table_offsets().distances_offset() as usize)?;
            let t = Self::read_into::<_, Bwm_PlanarDistancesArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.planar_distances.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.planar_distances.borrow())
    }

    /**
     * Array of vertex positions (float3 triplets)
     */
    pub fn vertices(
        &self
    ) -> KResult<Ref<'_, OptRc<Bwm_VerticesArray>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_vertices.get() {
            return Ok(self.vertices.borrow());
        }
        if ((*_r.data_table_offsets().vertex_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(*_r.data_table_offsets().vertex_offset() as usize)?;
            let t = Self::read_into::<_, Bwm_VerticesArray>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.vertices.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.vertices.borrow())
    }
}

/**
 * BWM file header (8 bytes) - magic and version signature
 */
impl Bwm {
    pub fn header(&self) -> Ref<'_, OptRc<Bwm_BwmHeader>> {
        self.header.borrow()
    }
}

/**
 * Walkmesh properties section (52 bytes) - type, hooks, position
 */
impl Bwm {
    pub fn walkmesh_properties(&self) -> Ref<'_, OptRc<Bwm_WalkmeshProperties>> {
        self.walkmesh_properties.borrow()
    }
}

/**
 * Data table offsets section (84 bytes) - counts and offsets for all data tables
 */
impl Bwm {
    pub fn data_table_offsets(&self) -> Ref<'_, OptRc<Bwm_DataTableOffsets>> {
        self.data_table_offsets.borrow()
    }
}
impl Bwm {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_AabbNode {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm_AabbNodesArray>,
    pub _self: SharedType<Self>,
    bounds_min: RefCell<OptRc<Bwm_Vec3f>>,
    bounds_max: RefCell<OptRc<Bwm_Vec3f>>,
    face_index: RefCell<i32>,
    unknown: RefCell<u32>,
    most_significant_plane: RefCell<u32>,
    left_child_index: RefCell<u32>,
    right_child_index: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_has_left_child: Cell<bool>,
    has_left_child: RefCell<bool>,
    f_has_right_child: Cell<bool>,
    has_right_child: RefCell<bool>,
    f_is_internal_node: Cell<bool>,
    is_internal_node: RefCell<bool>,
    f_is_leaf_node: Cell<bool>,
    is_leaf_node: RefCell<bool>,
}
impl KStruct for Bwm_AabbNode {
    type Root = Bwm;
    type Parent = Bwm_AabbNodesArray;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        let t = Self::read_into::<_, Bwm_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.bounds_min.borrow_mut() = t;
        let t = Self::read_into::<_, Bwm_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.bounds_max.borrow_mut() = t;
        *self_rc.face_index.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.unknown.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.most_significant_plane.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.left_child_index.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.right_child_index.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Bwm_AabbNode {

    /**
     * True if this node has a left child
     */
    pub fn has_left_child(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_left_child.get() {
            return Ok(self.has_left_child.borrow());
        }
        self.f_has_left_child.set(true);
        *self.has_left_child.borrow_mut() = (((*self.left_child_index() as i32) != (4294967295 as i32))) as bool;
        Ok(self.has_left_child.borrow())
    }

    /**
     * True if this node has a right child
     */
    pub fn has_right_child(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_right_child.get() {
            return Ok(self.has_right_child.borrow());
        }
        self.f_has_right_child.set(true);
        *self.has_right_child.borrow_mut() = (((*self.right_child_index() as i32) != (4294967295 as i32))) as bool;
        Ok(self.has_right_child.borrow())
    }

    /**
     * True if this is an internal node (has children), false if leaf node
     */
    pub fn is_internal_node(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_internal_node.get() {
            return Ok(self.is_internal_node.borrow());
        }
        self.f_is_internal_node.set(true);
        *self.is_internal_node.borrow_mut() = (((*self.face_index() as i32) == (-1 as i32))) as bool;
        Ok(self.is_internal_node.borrow())
    }

    /**
     * True if this is a leaf node (contains a face), false if internal node
     */
    pub fn is_leaf_node(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_leaf_node.get() {
            return Ok(self.is_leaf_node.borrow());
        }
        self.f_is_leaf_node.set(true);
        *self.is_leaf_node.borrow_mut() = (((*self.face_index() as i32) != (-1 as i32))) as bool;
        Ok(self.is_leaf_node.borrow())
    }
}

/**
 * Minimum bounding box coordinates (x, y, z).
 * Defines the lower corner of the axis-aligned bounding box.
 */
impl Bwm_AabbNode {
    pub fn bounds_min(&self) -> Ref<'_, OptRc<Bwm_Vec3f>> {
        self.bounds_min.borrow()
    }
}

/**
 * Maximum bounding box coordinates (x, y, z).
 * Defines the upper corner of the axis-aligned bounding box.
 */
impl Bwm_AabbNode {
    pub fn bounds_max(&self) -> Ref<'_, OptRc<Bwm_Vec3f>> {
        self.bounds_max.borrow()
    }
}

/**
 * Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
 * Leaf nodes contain a single face, internal nodes contain child nodes.
 */
impl Bwm_AabbNode {
    pub fn face_index(&self) -> Ref<'_, i32> {
        self.face_index.borrow()
    }
}

/**
 * Unknown field (typically 4).
 * Purpose is undocumented but appears in all AABB nodes.
 */
impl Bwm_AabbNode {
    pub fn unknown(&self) -> Ref<'_, u32> {
        self.unknown.borrow()
    }
}

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
impl Bwm_AabbNode {
    pub fn most_significant_plane(&self) -> Ref<'_, u32> {
        self.most_significant_plane.borrow()
    }
}

/**
 * Index to left child node (0-based array index).
 * 0xFFFFFFFF indicates no left child.
 * Child indices are 0-based indices into the AABB nodes array.
 */
impl Bwm_AabbNode {
    pub fn left_child_index(&self) -> Ref<'_, u32> {
        self.left_child_index.borrow()
    }
}

/**
 * Index to right child node (0-based array index).
 * 0xFFFFFFFF indicates no right child.
 * Child indices are 0-based indices into the AABB nodes array.
 */
impl Bwm_AabbNode {
    pub fn right_child_index(&self) -> Ref<'_, u32> {
        self.right_child_index.borrow()
    }
}
impl Bwm_AabbNode {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_AabbNodesArray {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    nodes: RefCell<Vec<OptRc<Bwm_AabbNode>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_AabbNodesArray {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.nodes.borrow_mut() = Vec::new();
        let l_nodes = *_r.data_table_offsets().aabb_count();
        for _i in 0..l_nodes {
            let t = Self::read_into::<_, Bwm_AabbNode>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.nodes.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Bwm_AabbNodesArray {
}

/**
 * Array of AABB tree nodes for spatial acceleration (WOK only).
 * AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).
 */
impl Bwm_AabbNodesArray {
    pub fn nodes(&self) -> Ref<'_, Vec<OptRc<Bwm_AabbNode>>> {
        self.nodes.borrow()
    }
}
impl Bwm_AabbNodesArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_AdjacenciesArray {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    adjacencies: RefCell<Vec<OptRc<Bwm_AdjacencyTriplet>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_AdjacenciesArray {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.adjacencies.borrow_mut() = Vec::new();
        let l_adjacencies = *_r.data_table_offsets().adjacency_count();
        for _i in 0..l_adjacencies {
            let t = Self::read_into::<_, Bwm_AdjacencyTriplet>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.adjacencies.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Bwm_AdjacenciesArray {
}

/**
 * Array of adjacency triplets, one per walkable face (WOK only).
 * Each walkable face has exactly three adjacency entries, one for each edge.
 * Adjacency count equals the number of walkable faces, not the total face count.
 */
impl Bwm_AdjacenciesArray {
    pub fn adjacencies(&self) -> Ref<'_, Vec<OptRc<Bwm_AdjacencyTriplet>>> {
        self.adjacencies.borrow()
    }
}
impl Bwm_AdjacenciesArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_AdjacencyTriplet {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm_AdjacenciesArray>,
    pub _self: SharedType<Self>,
    edge_0_adjacency: RefCell<i32>,
    edge_1_adjacency: RefCell<i32>,
    edge_2_adjacency: RefCell<i32>,
    _io: RefCell<BytesReader>,
    f_edge_0_face_index: Cell<bool>,
    edge_0_face_index: RefCell<i32>,
    f_edge_0_has_neighbor: Cell<bool>,
    edge_0_has_neighbor: RefCell<bool>,
    f_edge_0_local_edge: Cell<bool>,
    edge_0_local_edge: RefCell<i32>,
    f_edge_1_face_index: Cell<bool>,
    edge_1_face_index: RefCell<i32>,
    f_edge_1_has_neighbor: Cell<bool>,
    edge_1_has_neighbor: RefCell<bool>,
    f_edge_1_local_edge: Cell<bool>,
    edge_1_local_edge: RefCell<i32>,
    f_edge_2_face_index: Cell<bool>,
    edge_2_face_index: RefCell<i32>,
    f_edge_2_has_neighbor: Cell<bool>,
    edge_2_has_neighbor: RefCell<bool>,
    f_edge_2_local_edge: Cell<bool>,
    edge_2_local_edge: RefCell<i32>,
}
impl KStruct for Bwm_AdjacencyTriplet {
    type Root = Bwm;
    type Parent = Bwm_AdjacenciesArray;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.edge_0_adjacency.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.edge_1_adjacency.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.edge_2_adjacency.borrow_mut() = _io.read_s4le()?.into();
        Ok(())
    }
}
impl Bwm_AdjacencyTriplet {

    /**
     * Face index of adjacent face for edge 0 (decoded from adjacency index)
     */
    pub fn edge_0_face_index(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edge_0_face_index.get() {
            return Ok(self.edge_0_face_index.borrow());
        }
        self.f_edge_0_face_index.set(true);
        *self.edge_0_face_index.borrow_mut() = (if ((*self.edge_0_adjacency() as i32) != (-1 as i32)) { ((*self.edge_0_adjacency() as i32) / (3 as i32)) } else { -1 }) as i32;
        Ok(self.edge_0_face_index.borrow())
    }

    /**
     * True if edge 0 has an adjacent walkable face
     */
    pub fn edge_0_has_neighbor(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edge_0_has_neighbor.get() {
            return Ok(self.edge_0_has_neighbor.borrow());
        }
        self.f_edge_0_has_neighbor.set(true);
        *self.edge_0_has_neighbor.borrow_mut() = (((*self.edge_0_adjacency() as i32) != (-1 as i32))) as bool;
        Ok(self.edge_0_has_neighbor.borrow())
    }

    /**
     * Local edge index (0, 1, or 2) of adjacent face for edge 0
     */
    pub fn edge_0_local_edge(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edge_0_local_edge.get() {
            return Ok(self.edge_0_local_edge.borrow());
        }
        self.f_edge_0_local_edge.set(true);
        *self.edge_0_local_edge.borrow_mut() = (if ((*self.edge_0_adjacency() as i32) != (-1 as i32)) { modulo(*self.edge_0_adjacency() as i64, 3 as i64) } else { -1 }) as i32;
        Ok(self.edge_0_local_edge.borrow())
    }

    /**
     * Face index of adjacent face for edge 1 (decoded from adjacency index)
     */
    pub fn edge_1_face_index(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edge_1_face_index.get() {
            return Ok(self.edge_1_face_index.borrow());
        }
        self.f_edge_1_face_index.set(true);
        *self.edge_1_face_index.borrow_mut() = (if ((*self.edge_1_adjacency() as i32) != (-1 as i32)) { ((*self.edge_1_adjacency() as i32) / (3 as i32)) } else { -1 }) as i32;
        Ok(self.edge_1_face_index.borrow())
    }

    /**
     * True if edge 1 has an adjacent walkable face
     */
    pub fn edge_1_has_neighbor(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edge_1_has_neighbor.get() {
            return Ok(self.edge_1_has_neighbor.borrow());
        }
        self.f_edge_1_has_neighbor.set(true);
        *self.edge_1_has_neighbor.borrow_mut() = (((*self.edge_1_adjacency() as i32) != (-1 as i32))) as bool;
        Ok(self.edge_1_has_neighbor.borrow())
    }

    /**
     * Local edge index (0, 1, or 2) of adjacent face for edge 1
     */
    pub fn edge_1_local_edge(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edge_1_local_edge.get() {
            return Ok(self.edge_1_local_edge.borrow());
        }
        self.f_edge_1_local_edge.set(true);
        *self.edge_1_local_edge.borrow_mut() = (if ((*self.edge_1_adjacency() as i32) != (-1 as i32)) { modulo(*self.edge_1_adjacency() as i64, 3 as i64) } else { -1 }) as i32;
        Ok(self.edge_1_local_edge.borrow())
    }

    /**
     * Face index of adjacent face for edge 2 (decoded from adjacency index)
     */
    pub fn edge_2_face_index(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edge_2_face_index.get() {
            return Ok(self.edge_2_face_index.borrow());
        }
        self.f_edge_2_face_index.set(true);
        *self.edge_2_face_index.borrow_mut() = (if ((*self.edge_2_adjacency() as i32) != (-1 as i32)) { ((*self.edge_2_adjacency() as i32) / (3 as i32)) } else { -1 }) as i32;
        Ok(self.edge_2_face_index.borrow())
    }

    /**
     * True if edge 2 has an adjacent walkable face
     */
    pub fn edge_2_has_neighbor(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edge_2_has_neighbor.get() {
            return Ok(self.edge_2_has_neighbor.borrow());
        }
        self.f_edge_2_has_neighbor.set(true);
        *self.edge_2_has_neighbor.borrow_mut() = (((*self.edge_2_adjacency() as i32) != (-1 as i32))) as bool;
        Ok(self.edge_2_has_neighbor.borrow())
    }

    /**
     * Local edge index (0, 1, or 2) of adjacent face for edge 2
     */
    pub fn edge_2_local_edge(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_edge_2_local_edge.get() {
            return Ok(self.edge_2_local_edge.borrow());
        }
        self.f_edge_2_local_edge.set(true);
        *self.edge_2_local_edge.borrow_mut() = (if ((*self.edge_2_adjacency() as i32) != (-1 as i32)) { modulo(*self.edge_2_adjacency() as i64, 3 as i64) } else { -1 }) as i32;
        Ok(self.edge_2_local_edge.borrow())
    }
}

/**
 * Adjacency index for edge 0 (between v1 and v2).
 * Encoding: face_index * 3 + edge_index
 * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
 */
impl Bwm_AdjacencyTriplet {
    pub fn edge_0_adjacency(&self) -> Ref<'_, i32> {
        self.edge_0_adjacency.borrow()
    }
}

/**
 * Adjacency index for edge 1 (between v2 and v3).
 * Encoding: face_index * 3 + edge_index
 * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
 */
impl Bwm_AdjacencyTriplet {
    pub fn edge_1_adjacency(&self) -> Ref<'_, i32> {
        self.edge_1_adjacency.borrow()
    }
}

/**
 * Adjacency index for edge 2 (between v3 and v1).
 * Encoding: face_index * 3 + edge_index
 * -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
 */
impl Bwm_AdjacencyTriplet {
    pub fn edge_2_adjacency(&self) -> Ref<'_, i32> {
        self.edge_2_adjacency.borrow()
    }
}
impl Bwm_AdjacencyTriplet {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_BwmHeader {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    magic: RefCell<String>,
    version: RefCell<String>,
    _io: RefCell<BytesReader>,
    f_is_valid_bwm: Cell<bool>,
    is_valid_bwm: RefCell<bool>,
}
impl KStruct for Bwm_BwmHeader {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.magic.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        *self_rc.version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        Ok(())
    }
}
impl Bwm_BwmHeader {

    /**
     * Validation check that the file is a valid BWM file.
     * Both magic and version must match expected values.
     */
    pub fn is_valid_bwm(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_valid_bwm.get() {
            return Ok(self.is_valid_bwm.borrow());
        }
        self.f_is_valid_bwm.set(true);
        *self.is_valid_bwm.borrow_mut() = ( ((*self.magic() == "BWM ".to_string()) && (*self.version() == "V1.0".to_string())) ) as bool;
        Ok(self.is_valid_bwm.borrow())
    }
}

/**
 * File type signature. Must be "BWM " (space-padded).
 * The space after "BWM" is significant and must be present.
 */
impl Bwm_BwmHeader {
    pub fn magic(&self) -> Ref<'_, String> {
        self.magic.borrow()
    }
}

/**
 * File format version. Always "V1.0" for KotOR BWM files.
 * This is the first and only version of the BWM format used in KotOR games.
 */
impl Bwm_BwmHeader {
    pub fn version(&self) -> Ref<'_, String> {
        self.version.borrow()
    }
}
impl Bwm_BwmHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_DataTableOffsets {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    vertex_count: RefCell<u32>,
    vertex_offset: RefCell<u32>,
    face_count: RefCell<u32>,
    face_indices_offset: RefCell<u32>,
    materials_offset: RefCell<u32>,
    normals_offset: RefCell<u32>,
    distances_offset: RefCell<u32>,
    aabb_count: RefCell<u32>,
    aabb_offset: RefCell<u32>,
    unknown: RefCell<u32>,
    adjacency_count: RefCell<u32>,
    adjacency_offset: RefCell<u32>,
    edge_count: RefCell<u32>,
    edge_offset: RefCell<u32>,
    perimeter_count: RefCell<u32>,
    perimeter_offset: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_DataTableOffsets {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.vertex_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.vertex_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.face_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.face_indices_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.materials_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.normals_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.distances_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.aabb_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.aabb_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.adjacency_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.adjacency_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.edge_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.edge_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.perimeter_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.perimeter_offset.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Bwm_DataTableOffsets {
}

/**
 * Number of vertices in the walkmesh
 */
impl Bwm_DataTableOffsets {
    pub fn vertex_count(&self) -> Ref<'_, u32> {
        self.vertex_count.borrow()
    }
}

/**
 * Byte offset to vertex array from the beginning of the file
 */
impl Bwm_DataTableOffsets {
    pub fn vertex_offset(&self) -> Ref<'_, u32> {
        self.vertex_offset.borrow()
    }
}

/**
 * Number of faces (triangles) in the walkmesh
 */
impl Bwm_DataTableOffsets {
    pub fn face_count(&self) -> Ref<'_, u32> {
        self.face_count.borrow()
    }
}

/**
 * Byte offset to face indices array from the beginning of the file
 */
impl Bwm_DataTableOffsets {
    pub fn face_indices_offset(&self) -> Ref<'_, u32> {
        self.face_indices_offset.borrow()
    }
}

/**
 * Byte offset to materials array from the beginning of the file
 */
impl Bwm_DataTableOffsets {
    pub fn materials_offset(&self) -> Ref<'_, u32> {
        self.materials_offset.borrow()
    }
}

/**
 * Byte offset to face normals array from the beginning of the file.
 * Only used for WOK files (area walkmeshes).
 */
impl Bwm_DataTableOffsets {
    pub fn normals_offset(&self) -> Ref<'_, u32> {
        self.normals_offset.borrow()
    }
}

/**
 * Byte offset to planar distances array from the beginning of the file.
 * Only used for WOK files (area walkmeshes).
 */
impl Bwm_DataTableOffsets {
    pub fn distances_offset(&self) -> Ref<'_, u32> {
        self.distances_offset.borrow()
    }
}

/**
 * Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
 * AABB trees provide spatial acceleration for raycasting and point queries.
 */
impl Bwm_DataTableOffsets {
    pub fn aabb_count(&self) -> Ref<'_, u32> {
        self.aabb_count.borrow()
    }
}

/**
 * Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
 * Only present if aabb_count > 0.
 */
impl Bwm_DataTableOffsets {
    pub fn aabb_offset(&self) -> Ref<'_, u32> {
        self.aabb_offset.borrow()
    }
}

/**
 * Unknown field (typically 0 or 4).
 * Purpose is undocumented but appears in all BWM files.
 */
impl Bwm_DataTableOffsets {
    pub fn unknown(&self) -> Ref<'_, u32> {
        self.unknown.borrow()
    }
}

/**
 * Number of walkable faces for adjacency data (WOK only).
 * This equals the number of walkable faces, not the total face count.
 * Adjacencies are stored only for walkable faces.
 */
impl Bwm_DataTableOffsets {
    pub fn adjacency_count(&self) -> Ref<'_, u32> {
        self.adjacency_count.borrow()
    }
}

/**
 * Byte offset to adjacency array from the beginning of the file (WOK only).
 * Only present if adjacency_count > 0.
 */
impl Bwm_DataTableOffsets {
    pub fn adjacency_offset(&self) -> Ref<'_, u32> {
        self.adjacency_offset.borrow()
    }
}

/**
 * Number of perimeter edges (WOK only).
 * Perimeter edges are boundary edges with no walkable neighbor.
 */
impl Bwm_DataTableOffsets {
    pub fn edge_count(&self) -> Ref<'_, u32> {
        self.edge_count.borrow()
    }
}

/**
 * Byte offset to edges array from the beginning of the file (WOK only).
 * Only present if edge_count > 0.
 */
impl Bwm_DataTableOffsets {
    pub fn edge_offset(&self) -> Ref<'_, u32> {
        self.edge_offset.borrow()
    }
}

/**
 * Number of perimeter markers (WOK only).
 * Perimeter markers indicate the end of closed loops of perimeter edges.
 */
impl Bwm_DataTableOffsets {
    pub fn perimeter_count(&self) -> Ref<'_, u32> {
        self.perimeter_count.borrow()
    }
}

/**
 * Byte offset to perimeters array from the beginning of the file (WOK only).
 * Only present if perimeter_count > 0.
 */
impl Bwm_DataTableOffsets {
    pub fn perimeter_offset(&self) -> Ref<'_, u32> {
        self.perimeter_offset.borrow()
    }
}
impl Bwm_DataTableOffsets {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_EdgeEntry {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm_EdgesArray>,
    pub _self: SharedType<Self>,
    edge_index: RefCell<u32>,
    transition: RefCell<i32>,
    _io: RefCell<BytesReader>,
    f_face_index: Cell<bool>,
    face_index: RefCell<i32>,
    f_has_transition: Cell<bool>,
    has_transition: RefCell<bool>,
    f_local_edge_index: Cell<bool>,
    local_edge_index: RefCell<i32>,
}
impl KStruct for Bwm_EdgeEntry {
    type Root = Bwm;
    type Parent = Bwm_EdgesArray;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.edge_index.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.transition.borrow_mut() = _io.read_s4le()?.into();
        Ok(())
    }
}
impl Bwm_EdgeEntry {

    /**
     * Face index that this edge belongs to (decoded from edge_index)
     */
    pub fn face_index(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_face_index.get() {
            return Ok(self.face_index.borrow());
        }
        self.f_face_index.set(true);
        *self.face_index.borrow_mut() = (((*self.edge_index() as u32) / (3 as u32))) as i32;
        Ok(self.face_index.borrow())
    }

    /**
     * True if this edge has a transition ID (links to door/area connection)
     */
    pub fn has_transition(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_transition.get() {
            return Ok(self.has_transition.borrow());
        }
        self.f_has_transition.set(true);
        *self.has_transition.borrow_mut() = (((*self.transition() as i32) != (-1 as i32))) as bool;
        Ok(self.has_transition.borrow())
    }

    /**
     * Local edge index (0, 1, or 2) within the face (decoded from edge_index)
     */
    pub fn local_edge_index(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_local_edge_index.get() {
            return Ok(self.local_edge_index.borrow());
        }
        self.f_local_edge_index.set(true);
        *self.local_edge_index.borrow_mut() = (((*self.edge_index() as u32) % (3 as u32))) as i32;
        Ok(self.local_edge_index.borrow())
    }
}

/**
 * Encoded edge index: face_index * 3 + local_edge_index
 * Identifies which face and which edge (0, 1, or 2) of that face.
 * Edge 0: between v1 and v2
 * Edge 1: between v2 and v3
 * Edge 2: between v3 and v1
 */
impl Bwm_EdgeEntry {
    pub fn edge_index(&self) -> Ref<'_, u32> {
        self.edge_index.borrow()
    }
}

/**
 * Transition ID for room/area connections, -1 if no transition.
 * Non-negative values reference door connections or area boundaries.
 * -1 indicates this is just a boundary edge with no transition.
 */
impl Bwm_EdgeEntry {
    pub fn transition(&self) -> Ref<'_, i32> {
        self.transition.borrow()
    }
}
impl Bwm_EdgeEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_EdgesArray {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    edges: RefCell<Vec<OptRc<Bwm_EdgeEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_EdgesArray {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.edges.borrow_mut() = Vec::new();
        let l_edges = *_r.data_table_offsets().edge_count();
        for _i in 0..l_edges {
            let t = Self::read_into::<_, Bwm_EdgeEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.edges.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Bwm_EdgesArray {
}

/**
 * Array of perimeter edges (WOK only).
 * Perimeter edges are boundary edges with no walkable neighbor.
 * Each edge entry contains an edge index and optional transition ID.
 */
impl Bwm_EdgesArray {
    pub fn edges(&self) -> Ref<'_, Vec<OptRc<Bwm_EdgeEntry>>> {
        self.edges.borrow()
    }
}
impl Bwm_EdgesArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_FaceIndices {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm_FaceIndicesArray>,
    pub _self: SharedType<Self>,
    v1_index: RefCell<u32>,
    v2_index: RefCell<u32>,
    v3_index: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_FaceIndices {
    type Root = Bwm;
    type Parent = Bwm_FaceIndicesArray;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.v1_index.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.v2_index.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.v3_index.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Bwm_FaceIndices {
}

/**
 * Vertex index for first vertex of triangle (0-based index into vertices array).
 * Vertex indices define the triangle's vertices in counter-clockwise order
 * when viewed from the front (the side the normal points toward).
 */
impl Bwm_FaceIndices {
    pub fn v1_index(&self) -> Ref<'_, u32> {
        self.v1_index.borrow()
    }
}

/**
 * Vertex index for second vertex of triangle (0-based index into vertices array).
 */
impl Bwm_FaceIndices {
    pub fn v2_index(&self) -> Ref<'_, u32> {
        self.v2_index.borrow()
    }
}

/**
 * Vertex index for third vertex of triangle (0-based index into vertices array).
 */
impl Bwm_FaceIndices {
    pub fn v3_index(&self) -> Ref<'_, u32> {
        self.v3_index.borrow()
    }
}
impl Bwm_FaceIndices {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_FaceIndicesArray {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    faces: RefCell<Vec<OptRc<Bwm_FaceIndices>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_FaceIndicesArray {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.faces.borrow_mut() = Vec::new();
        let l_faces = *_r.data_table_offsets().face_count();
        for _i in 0..l_faces {
            let t = Self::read_into::<_, Bwm_FaceIndices>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.faces.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Bwm_FaceIndicesArray {
}

/**
 * Array of face vertex index triplets
 */
impl Bwm_FaceIndicesArray {
    pub fn faces(&self) -> Ref<'_, Vec<OptRc<Bwm_FaceIndices>>> {
        self.faces.borrow()
    }
}
impl Bwm_FaceIndicesArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_MaterialsArray {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    materials: RefCell<Vec<u32>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_MaterialsArray {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.materials.borrow_mut() = Vec::new();
        let l_materials = *_r.data_table_offsets().face_count();
        for _i in 0..l_materials {
            self_rc.materials.borrow_mut().push(_io.read_u4le()?.into());
        }
        Ok(())
    }
}
impl Bwm_MaterialsArray {
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
impl Bwm_MaterialsArray {
    pub fn materials(&self) -> Ref<'_, Vec<u32>> {
        self.materials.borrow()
    }
}
impl Bwm_MaterialsArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_NormalsArray {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    normals: RefCell<Vec<OptRc<Bwm_Vec3f>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_NormalsArray {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.normals.borrow_mut() = Vec::new();
        let l_normals = *_r.data_table_offsets().face_count();
        for _i in 0..l_normals {
            let t = Self::read_into::<_, Bwm_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
            self_rc.normals.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Bwm_NormalsArray {
}

/**
 * Array of face normal vectors, one per face (WOK only).
 * Normals are precomputed unit vectors perpendicular to each face.
 * Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
 * Normal direction follows right-hand rule based on vertex winding order.
 */
impl Bwm_NormalsArray {
    pub fn normals(&self) -> Ref<'_, Vec<OptRc<Bwm_Vec3f>>> {
        self.normals.borrow()
    }
}
impl Bwm_NormalsArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_PerimetersArray {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    perimeters: RefCell<Vec<u32>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_PerimetersArray {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.perimeters.borrow_mut() = Vec::new();
        let l_perimeters = *_r.data_table_offsets().perimeter_count();
        for _i in 0..l_perimeters {
            self_rc.perimeters.borrow_mut().push(_io.read_u4le()?.into());
        }
        Ok(())
    }
}
impl Bwm_PerimetersArray {
}

/**
 * Array of perimeter markers (WOK only).
 * Each value is an index into the edges array, marking the end of a perimeter loop.
 * Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
 * Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.
 */
impl Bwm_PerimetersArray {
    pub fn perimeters(&self) -> Ref<'_, Vec<u32>> {
        self.perimeters.borrow()
    }
}
impl Bwm_PerimetersArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_PlanarDistancesArray {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    distances: RefCell<Vec<f32>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_PlanarDistancesArray {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.distances.borrow_mut() = Vec::new();
        let l_distances = *_r.data_table_offsets().face_count();
        for _i in 0..l_distances {
            self_rc.distances.borrow_mut().push(_io.read_f4le()?.into());
        }
        Ok(())
    }
}
impl Bwm_PlanarDistancesArray {
}

/**
 * Array of planar distances, one per face (WOK only).
 * The D component of the plane equation ax + by + cz + d = 0.
 * Calculated as d = -normal · vertex1 for each face.
 * Precomputed to allow quick point-plane relationship tests.
 */
impl Bwm_PlanarDistancesArray {
    pub fn distances(&self) -> Ref<'_, Vec<f32>> {
        self.distances.borrow()
    }
}
impl Bwm_PlanarDistancesArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_Vec3f {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    x: RefCell<f32>,
    y: RefCell<f32>,
    z: RefCell<f32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_Vec3f {
    type Root = Bwm;
    type Parent = KStructUnit;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.x.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.y.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.z.borrow_mut() = _io.read_f4le()?.into();
        Ok(())
    }
}
impl Bwm_Vec3f {
}

/**
 * X coordinate (float32)
 */
impl Bwm_Vec3f {
    pub fn x(&self) -> Ref<'_, f32> {
        self.x.borrow()
    }
}

/**
 * Y coordinate (float32)
 */
impl Bwm_Vec3f {
    pub fn y(&self) -> Ref<'_, f32> {
        self.y.borrow()
    }
}

/**
 * Z coordinate (float32)
 */
impl Bwm_Vec3f {
    pub fn z(&self) -> Ref<'_, f32> {
        self.z.borrow()
    }
}
impl Bwm_Vec3f {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_VerticesArray {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    vertices: RefCell<Vec<OptRc<Bwm_Vec3f>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Bwm_VerticesArray {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.vertices.borrow_mut() = Vec::new();
        let l_vertices = *_r.data_table_offsets().vertex_count();
        for _i in 0..l_vertices {
            let t = Self::read_into::<_, Bwm_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
            self_rc.vertices.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Bwm_VerticesArray {
}

/**
 * Array of vertex positions, each vertex is a float3 (x, y, z)
 */
impl Bwm_VerticesArray {
    pub fn vertices(&self) -> Ref<'_, Vec<OptRc<Bwm_Vec3f>>> {
        self.vertices.borrow()
    }
}
impl Bwm_VerticesArray {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Bwm_WalkmeshProperties {
    pub _root: SharedType<Bwm>,
    pub _parent: SharedType<Bwm>,
    pub _self: SharedType<Self>,
    walkmesh_type: RefCell<u32>,
    relative_use_position_1: RefCell<OptRc<Bwm_Vec3f>>,
    relative_use_position_2: RefCell<OptRc<Bwm_Vec3f>>,
    absolute_use_position_1: RefCell<OptRc<Bwm_Vec3f>>,
    absolute_use_position_2: RefCell<OptRc<Bwm_Vec3f>>,
    position: RefCell<OptRc<Bwm_Vec3f>>,
    _io: RefCell<BytesReader>,
    f_is_area_walkmesh: Cell<bool>,
    is_area_walkmesh: RefCell<bool>,
    f_is_placeable_or_door: Cell<bool>,
    is_placeable_or_door: RefCell<bool>,
}
impl KStruct for Bwm_WalkmeshProperties {
    type Root = Bwm;
    type Parent = Bwm;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.walkmesh_type.borrow_mut() = _io.read_u4le()?.into();
        let t = Self::read_into::<_, Bwm_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.relative_use_position_1.borrow_mut() = t;
        let t = Self::read_into::<_, Bwm_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.relative_use_position_2.borrow_mut() = t;
        let t = Self::read_into::<_, Bwm_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.absolute_use_position_1.borrow_mut() = t;
        let t = Self::read_into::<_, Bwm_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.absolute_use_position_2.borrow_mut() = t;
        let t = Self::read_into::<_, Bwm_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.position.borrow_mut() = t;
        Ok(())
    }
}
impl Bwm_WalkmeshProperties {

    /**
     * True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)
     */
    pub fn is_area_walkmesh(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_area_walkmesh.get() {
            return Ok(self.is_area_walkmesh.borrow());
        }
        self.f_is_area_walkmesh.set(true);
        *self.is_area_walkmesh.borrow_mut() = (((*self.walkmesh_type() as u32) == (1 as u32))) as bool;
        Ok(self.is_area_walkmesh.borrow())
    }

    /**
     * True if this is a placeable or door walkmesh (PWK/DWK)
     */
    pub fn is_placeable_or_door(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_placeable_or_door.get() {
            return Ok(self.is_placeable_or_door.borrow());
        }
        self.f_is_placeable_or_door.set(true);
        *self.is_placeable_or_door.borrow_mut() = (((*self.walkmesh_type() as u32) == (0 as u32))) as bool;
        Ok(self.is_placeable_or_door.borrow())
    }
}

/**
 * Walkmesh type identifier:
 * - 0 = PWK/DWK (Placeable/Door walkmesh)
 * - 1 = WOK (Area walkmesh)
 */
impl Bwm_WalkmeshProperties {
    pub fn walkmesh_type(&self) -> Ref<'_, u32> {
        self.walkmesh_type.borrow()
    }
}

/**
 * Relative use hook position 1 (x, y, z).
 * Position relative to the walkmesh origin, used when the walkmesh may be transformed.
 * For doors: Defines where the player must stand to interact (relative to door model).
 * For placeables: Defines interaction points relative to the object's local coordinate system.
 */
impl Bwm_WalkmeshProperties {
    pub fn relative_use_position_1(&self) -> Ref<'_, OptRc<Bwm_Vec3f>> {
        self.relative_use_position_1.borrow()
    }
}

/**
 * Relative use hook position 2 (x, y, z).
 * Second interaction point relative to the walkmesh origin.
 */
impl Bwm_WalkmeshProperties {
    pub fn relative_use_position_2(&self) -> Ref<'_, OptRc<Bwm_Vec3f>> {
        self.relative_use_position_2.borrow()
    }
}

/**
 * Absolute use hook position 1 (x, y, z).
 * Position in world space, used when the walkmesh position is known.
 * For doors: Precomputed world-space interaction points (position + relative hook).
 * For placeables: World-space interaction points accounting for object placement.
 */
impl Bwm_WalkmeshProperties {
    pub fn absolute_use_position_1(&self) -> Ref<'_, OptRc<Bwm_Vec3f>> {
        self.absolute_use_position_1.borrow()
    }
}

/**
 * Absolute use hook position 2 (x, y, z).
 * Second absolute interaction point in world space.
 */
impl Bwm_WalkmeshProperties {
    pub fn absolute_use_position_2(&self) -> Ref<'_, OptRc<Bwm_Vec3f>> {
        self.absolute_use_position_2.borrow()
    }
}

/**
 * Walkmesh position offset (x, y, z) in world space.
 * For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
 * For placeable/door walkmeshes: The position where the object is placed in the area.
 * Used to transform vertices from local to world coordinates.
 */
impl Bwm_WalkmeshProperties {
    pub fn position(&self) -> Ref<'_, OptRc<Bwm_Vec3f>> {
        self.position.borrow()
    }
}
impl Bwm_WalkmeshProperties {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
