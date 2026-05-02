# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use Encode;

########################################################################
package Bwm;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root || $self;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{header} = Bwm::BwmHeader->new($self->{_io}, $self, $self->{_root});
    $self->{walkmesh_properties} = Bwm::WalkmeshProperties->new($self->{_io}, $self, $self->{_root});
    $self->{data_table_offsets} = Bwm::DataTableOffsets->new($self->{_io}, $self, $self->{_root});
}

sub aabb_nodes {
    my ($self) = @_;
    return $self->{aabb_nodes} if ($self->{aabb_nodes});
    if ( (($self->_root()->walkmesh_properties()->walkmesh_type() == 1) && ($self->_root()->data_table_offsets()->aabb_count() > 0)) ) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->data_table_offsets()->aabb_offset());
        $self->{aabb_nodes} = Bwm::AabbNodesArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{aabb_nodes};
}

sub adjacencies {
    my ($self) = @_;
    return $self->{adjacencies} if ($self->{adjacencies});
    if ( (($self->_root()->walkmesh_properties()->walkmesh_type() == 1) && ($self->_root()->data_table_offsets()->adjacency_count() > 0)) ) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->data_table_offsets()->adjacency_offset());
        $self->{adjacencies} = Bwm::AdjacenciesArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{adjacencies};
}

sub edges {
    my ($self) = @_;
    return $self->{edges} if ($self->{edges});
    if ( (($self->_root()->walkmesh_properties()->walkmesh_type() == 1) && ($self->_root()->data_table_offsets()->edge_count() > 0)) ) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->data_table_offsets()->edge_offset());
        $self->{edges} = Bwm::EdgesArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{edges};
}

sub face_indices {
    my ($self) = @_;
    return $self->{face_indices} if ($self->{face_indices});
    if ($self->_root()->data_table_offsets()->face_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->data_table_offsets()->face_indices_offset());
        $self->{face_indices} = Bwm::FaceIndicesArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{face_indices};
}

sub materials {
    my ($self) = @_;
    return $self->{materials} if ($self->{materials});
    if ($self->_root()->data_table_offsets()->face_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->data_table_offsets()->materials_offset());
        $self->{materials} = Bwm::MaterialsArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{materials};
}

sub normals {
    my ($self) = @_;
    return $self->{normals} if ($self->{normals});
    if ( (($self->_root()->walkmesh_properties()->walkmesh_type() == 1) && ($self->_root()->data_table_offsets()->face_count() > 0)) ) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->data_table_offsets()->normals_offset());
        $self->{normals} = Bwm::NormalsArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{normals};
}

sub perimeters {
    my ($self) = @_;
    return $self->{perimeters} if ($self->{perimeters});
    if ( (($self->_root()->walkmesh_properties()->walkmesh_type() == 1) && ($self->_root()->data_table_offsets()->perimeter_count() > 0)) ) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->data_table_offsets()->perimeter_offset());
        $self->{perimeters} = Bwm::PerimetersArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{perimeters};
}

sub planar_distances {
    my ($self) = @_;
    return $self->{planar_distances} if ($self->{planar_distances});
    if ( (($self->_root()->walkmesh_properties()->walkmesh_type() == 1) && ($self->_root()->data_table_offsets()->face_count() > 0)) ) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->data_table_offsets()->distances_offset());
        $self->{planar_distances} = Bwm::PlanarDistancesArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{planar_distances};
}

sub vertices {
    my ($self) = @_;
    return $self->{vertices} if ($self->{vertices});
    if ($self->_root()->data_table_offsets()->vertex_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->data_table_offsets()->vertex_offset());
        $self->{vertices} = Bwm::VerticesArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{vertices};
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

sub walkmesh_properties {
    my ($self) = @_;
    return $self->{walkmesh_properties};
}

sub data_table_offsets {
    my ($self) = @_;
    return $self->{data_table_offsets};
}

########################################################################
package Bwm::AabbNode;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{bounds_min} = Bwm::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{bounds_max} = Bwm::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{face_index} = $self->{_io}->read_s4le();
    $self->{unknown} = $self->{_io}->read_u4le();
    $self->{most_significant_plane} = $self->{_io}->read_u4le();
    $self->{left_child_index} = $self->{_io}->read_u4le();
    $self->{right_child_index} = $self->{_io}->read_u4le();
}

sub has_left_child {
    my ($self) = @_;
    return $self->{has_left_child} if ($self->{has_left_child});
    $self->{has_left_child} = $self->left_child_index() != 4294967295;
    return $self->{has_left_child};
}

sub has_right_child {
    my ($self) = @_;
    return $self->{has_right_child} if ($self->{has_right_child});
    $self->{has_right_child} = $self->right_child_index() != 4294967295;
    return $self->{has_right_child};
}

sub is_internal_node {
    my ($self) = @_;
    return $self->{is_internal_node} if ($self->{is_internal_node});
    $self->{is_internal_node} = $self->face_index() == -1;
    return $self->{is_internal_node};
}

sub is_leaf_node {
    my ($self) = @_;
    return $self->{is_leaf_node} if ($self->{is_leaf_node});
    $self->{is_leaf_node} = $self->face_index() != -1;
    return $self->{is_leaf_node};
}

sub bounds_min {
    my ($self) = @_;
    return $self->{bounds_min};
}

sub bounds_max {
    my ($self) = @_;
    return $self->{bounds_max};
}

sub face_index {
    my ($self) = @_;
    return $self->{face_index};
}

sub unknown {
    my ($self) = @_;
    return $self->{unknown};
}

sub most_significant_plane {
    my ($self) = @_;
    return $self->{most_significant_plane};
}

sub left_child_index {
    my ($self) = @_;
    return $self->{left_child_index};
}

sub right_child_index {
    my ($self) = @_;
    return $self->{right_child_index};
}

########################################################################
package Bwm::AabbNodesArray;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{nodes} = [];
    my $n_nodes = $self->_root()->data_table_offsets()->aabb_count();
    for (my $i = 0; $i < $n_nodes; $i++) {
        push @{$self->{nodes}}, Bwm::AabbNode->new($self->{_io}, $self, $self->{_root});
    }
}

sub nodes {
    my ($self) = @_;
    return $self->{nodes};
}

########################################################################
package Bwm::AdjacenciesArray;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{adjacencies} = [];
    my $n_adjacencies = $self->_root()->data_table_offsets()->adjacency_count();
    for (my $i = 0; $i < $n_adjacencies; $i++) {
        push @{$self->{adjacencies}}, Bwm::AdjacencyTriplet->new($self->{_io}, $self, $self->{_root});
    }
}

sub adjacencies {
    my ($self) = @_;
    return $self->{adjacencies};
}

########################################################################
package Bwm::AdjacencyTriplet;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{edge_0_adjacency} = $self->{_io}->read_s4le();
    $self->{edge_1_adjacency} = $self->{_io}->read_s4le();
    $self->{edge_2_adjacency} = $self->{_io}->read_s4le();
}

sub edge_0_face_index {
    my ($self) = @_;
    return $self->{edge_0_face_index} if ($self->{edge_0_face_index});
    $self->{edge_0_face_index} = ($self->edge_0_adjacency() != -1 ? int($self->edge_0_adjacency() / 3) : -1);
    return $self->{edge_0_face_index};
}

sub edge_0_has_neighbor {
    my ($self) = @_;
    return $self->{edge_0_has_neighbor} if ($self->{edge_0_has_neighbor});
    $self->{edge_0_has_neighbor} = $self->edge_0_adjacency() != -1;
    return $self->{edge_0_has_neighbor};
}

sub edge_0_local_edge {
    my ($self) = @_;
    return $self->{edge_0_local_edge} if ($self->{edge_0_local_edge});
    $self->{edge_0_local_edge} = ($self->edge_0_adjacency() != -1 ? $self->edge_0_adjacency() % 3 : -1);
    return $self->{edge_0_local_edge};
}

sub edge_1_face_index {
    my ($self) = @_;
    return $self->{edge_1_face_index} if ($self->{edge_1_face_index});
    $self->{edge_1_face_index} = ($self->edge_1_adjacency() != -1 ? int($self->edge_1_adjacency() / 3) : -1);
    return $self->{edge_1_face_index};
}

sub edge_1_has_neighbor {
    my ($self) = @_;
    return $self->{edge_1_has_neighbor} if ($self->{edge_1_has_neighbor});
    $self->{edge_1_has_neighbor} = $self->edge_1_adjacency() != -1;
    return $self->{edge_1_has_neighbor};
}

sub edge_1_local_edge {
    my ($self) = @_;
    return $self->{edge_1_local_edge} if ($self->{edge_1_local_edge});
    $self->{edge_1_local_edge} = ($self->edge_1_adjacency() != -1 ? $self->edge_1_adjacency() % 3 : -1);
    return $self->{edge_1_local_edge};
}

sub edge_2_face_index {
    my ($self) = @_;
    return $self->{edge_2_face_index} if ($self->{edge_2_face_index});
    $self->{edge_2_face_index} = ($self->edge_2_adjacency() != -1 ? int($self->edge_2_adjacency() / 3) : -1);
    return $self->{edge_2_face_index};
}

sub edge_2_has_neighbor {
    my ($self) = @_;
    return $self->{edge_2_has_neighbor} if ($self->{edge_2_has_neighbor});
    $self->{edge_2_has_neighbor} = $self->edge_2_adjacency() != -1;
    return $self->{edge_2_has_neighbor};
}

sub edge_2_local_edge {
    my ($self) = @_;
    return $self->{edge_2_local_edge} if ($self->{edge_2_local_edge});
    $self->{edge_2_local_edge} = ($self->edge_2_adjacency() != -1 ? $self->edge_2_adjacency() % 3 : -1);
    return $self->{edge_2_local_edge};
}

sub edge_0_adjacency {
    my ($self) = @_;
    return $self->{edge_0_adjacency};
}

sub edge_1_adjacency {
    my ($self) = @_;
    return $self->{edge_1_adjacency};
}

sub edge_2_adjacency {
    my ($self) = @_;
    return $self->{edge_2_adjacency};
}

########################################################################
package Bwm::BwmHeader;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{magic} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{version} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
}

sub is_valid_bwm {
    my ($self) = @_;
    return $self->{is_valid_bwm} if ($self->{is_valid_bwm});
    $self->{is_valid_bwm} =  (($self->magic() eq "BWM ") && ($self->version() eq "V1.0")) ;
    return $self->{is_valid_bwm};
}

sub magic {
    my ($self) = @_;
    return $self->{magic};
}

sub version {
    my ($self) = @_;
    return $self->{version};
}

########################################################################
package Bwm::DataTableOffsets;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{vertex_count} = $self->{_io}->read_u4le();
    $self->{vertex_offset} = $self->{_io}->read_u4le();
    $self->{face_count} = $self->{_io}->read_u4le();
    $self->{face_indices_offset} = $self->{_io}->read_u4le();
    $self->{materials_offset} = $self->{_io}->read_u4le();
    $self->{normals_offset} = $self->{_io}->read_u4le();
    $self->{distances_offset} = $self->{_io}->read_u4le();
    $self->{aabb_count} = $self->{_io}->read_u4le();
    $self->{aabb_offset} = $self->{_io}->read_u4le();
    $self->{unknown} = $self->{_io}->read_u4le();
    $self->{adjacency_count} = $self->{_io}->read_u4le();
    $self->{adjacency_offset} = $self->{_io}->read_u4le();
    $self->{edge_count} = $self->{_io}->read_u4le();
    $self->{edge_offset} = $self->{_io}->read_u4le();
    $self->{perimeter_count} = $self->{_io}->read_u4le();
    $self->{perimeter_offset} = $self->{_io}->read_u4le();
}

sub vertex_count {
    my ($self) = @_;
    return $self->{vertex_count};
}

sub vertex_offset {
    my ($self) = @_;
    return $self->{vertex_offset};
}

sub face_count {
    my ($self) = @_;
    return $self->{face_count};
}

sub face_indices_offset {
    my ($self) = @_;
    return $self->{face_indices_offset};
}

sub materials_offset {
    my ($self) = @_;
    return $self->{materials_offset};
}

sub normals_offset {
    my ($self) = @_;
    return $self->{normals_offset};
}

sub distances_offset {
    my ($self) = @_;
    return $self->{distances_offset};
}

sub aabb_count {
    my ($self) = @_;
    return $self->{aabb_count};
}

sub aabb_offset {
    my ($self) = @_;
    return $self->{aabb_offset};
}

sub unknown {
    my ($self) = @_;
    return $self->{unknown};
}

sub adjacency_count {
    my ($self) = @_;
    return $self->{adjacency_count};
}

sub adjacency_offset {
    my ($self) = @_;
    return $self->{adjacency_offset};
}

sub edge_count {
    my ($self) = @_;
    return $self->{edge_count};
}

sub edge_offset {
    my ($self) = @_;
    return $self->{edge_offset};
}

sub perimeter_count {
    my ($self) = @_;
    return $self->{perimeter_count};
}

sub perimeter_offset {
    my ($self) = @_;
    return $self->{perimeter_offset};
}

########################################################################
package Bwm::EdgeEntry;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{edge_index} = $self->{_io}->read_u4le();
    $self->{transition} = $self->{_io}->read_s4le();
}

sub face_index {
    my ($self) = @_;
    return $self->{face_index} if ($self->{face_index});
    $self->{face_index} = int($self->edge_index() / 3);
    return $self->{face_index};
}

sub has_transition {
    my ($self) = @_;
    return $self->{has_transition} if ($self->{has_transition});
    $self->{has_transition} = $self->transition() != -1;
    return $self->{has_transition};
}

sub local_edge_index {
    my ($self) = @_;
    return $self->{local_edge_index} if ($self->{local_edge_index});
    $self->{local_edge_index} = $self->edge_index() % 3;
    return $self->{local_edge_index};
}

sub edge_index {
    my ($self) = @_;
    return $self->{edge_index};
}

sub transition {
    my ($self) = @_;
    return $self->{transition};
}

########################################################################
package Bwm::EdgesArray;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{edges} = [];
    my $n_edges = $self->_root()->data_table_offsets()->edge_count();
    for (my $i = 0; $i < $n_edges; $i++) {
        push @{$self->{edges}}, Bwm::EdgeEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub edges {
    my ($self) = @_;
    return $self->{edges};
}

########################################################################
package Bwm::FaceIndices;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{v1_index} = $self->{_io}->read_u4le();
    $self->{v2_index} = $self->{_io}->read_u4le();
    $self->{v3_index} = $self->{_io}->read_u4le();
}

sub v1_index {
    my ($self) = @_;
    return $self->{v1_index};
}

sub v2_index {
    my ($self) = @_;
    return $self->{v2_index};
}

sub v3_index {
    my ($self) = @_;
    return $self->{v3_index};
}

########################################################################
package Bwm::FaceIndicesArray;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{faces} = [];
    my $n_faces = $self->_root()->data_table_offsets()->face_count();
    for (my $i = 0; $i < $n_faces; $i++) {
        push @{$self->{faces}}, Bwm::FaceIndices->new($self->{_io}, $self, $self->{_root});
    }
}

sub faces {
    my ($self) = @_;
    return $self->{faces};
}

########################################################################
package Bwm::MaterialsArray;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{materials} = [];
    my $n_materials = $self->_root()->data_table_offsets()->face_count();
    for (my $i = 0; $i < $n_materials; $i++) {
        push @{$self->{materials}}, $self->{_io}->read_u4le();
    }
}

sub materials {
    my ($self) = @_;
    return $self->{materials};
}

########################################################################
package Bwm::NormalsArray;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{normals} = [];
    my $n_normals = $self->_root()->data_table_offsets()->face_count();
    for (my $i = 0; $i < $n_normals; $i++) {
        push @{$self->{normals}}, Bwm::Vec3f->new($self->{_io}, $self, $self->{_root});
    }
}

sub normals {
    my ($self) = @_;
    return $self->{normals};
}

########################################################################
package Bwm::PerimetersArray;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{perimeters} = [];
    my $n_perimeters = $self->_root()->data_table_offsets()->perimeter_count();
    for (my $i = 0; $i < $n_perimeters; $i++) {
        push @{$self->{perimeters}}, $self->{_io}->read_u4le();
    }
}

sub perimeters {
    my ($self) = @_;
    return $self->{perimeters};
}

########################################################################
package Bwm::PlanarDistancesArray;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{distances} = [];
    my $n_distances = $self->_root()->data_table_offsets()->face_count();
    for (my $i = 0; $i < $n_distances; $i++) {
        push @{$self->{distances}}, $self->{_io}->read_f4le();
    }
}

sub distances {
    my ($self) = @_;
    return $self->{distances};
}

########################################################################
package Bwm::Vec3f;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{x} = $self->{_io}->read_f4le();
    $self->{y} = $self->{_io}->read_f4le();
    $self->{z} = $self->{_io}->read_f4le();
}

sub x {
    my ($self) = @_;
    return $self->{x};
}

sub y {
    my ($self) = @_;
    return $self->{y};
}

sub z {
    my ($self) = @_;
    return $self->{z};
}

########################################################################
package Bwm::VerticesArray;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{vertices} = [];
    my $n_vertices = $self->_root()->data_table_offsets()->vertex_count();
    for (my $i = 0; $i < $n_vertices; $i++) {
        push @{$self->{vertices}}, Bwm::Vec3f->new($self->{_io}, $self, $self->{_root});
    }
}

sub vertices {
    my ($self) = @_;
    return $self->{vertices};
}

########################################################################
package Bwm::WalkmeshProperties;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

sub new {
    my ($class, $_io, $_parent, $_root) = @_;
    my $self = IO::KaitaiStruct::Struct->new($_io);

    bless $self, $class;
    $self->{_parent} = $_parent;
    $self->{_root} = $_root;

    $self->_read();

    return $self;
}

sub _read {
    my ($self) = @_;

    $self->{walkmesh_type} = $self->{_io}->read_u4le();
    $self->{relative_use_position_1} = Bwm::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{relative_use_position_2} = Bwm::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{absolute_use_position_1} = Bwm::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{absolute_use_position_2} = Bwm::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{position} = Bwm::Vec3f->new($self->{_io}, $self, $self->{_root});
}

sub is_area_walkmesh {
    my ($self) = @_;
    return $self->{is_area_walkmesh} if ($self->{is_area_walkmesh});
    $self->{is_area_walkmesh} = $self->walkmesh_type() == 1;
    return $self->{is_area_walkmesh};
}

sub is_placeable_or_door {
    my ($self) = @_;
    return $self->{is_placeable_or_door} if ($self->{is_placeable_or_door});
    $self->{is_placeable_or_door} = $self->walkmesh_type() == 0;
    return $self->{is_placeable_or_door};
}

sub walkmesh_type {
    my ($self) = @_;
    return $self->{walkmesh_type};
}

sub relative_use_position_1 {
    my ($self) = @_;
    return $self->{relative_use_position_1};
}

sub relative_use_position_2 {
    my ($self) = @_;
    return $self->{relative_use_position_2};
}

sub absolute_use_position_1 {
    my ($self) = @_;
    return $self->{absolute_use_position_1};
}

sub absolute_use_position_2 {
    my ($self) = @_;
    return $self->{absolute_use_position_2};
}

sub position {
    my ($self) = @_;
    return $self->{position};
}

1;
