# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareMdlCommon;
use Encode;

########################################################################
package Mdl;

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

    $self->{file_header} = Mdl::FileHeader->new($self->{_io}, $self, $self->{_root});
    $self->{model_header} = Mdl::ModelHeader->new($self->{_io}, $self, $self->{_root});
}

sub animation_offsets {
    my ($self) = @_;
    return $self->{animation_offsets} if ($self->{animation_offsets});
    if ($self->model_header()->animation_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->data_start() + $self->model_header()->offset_to_animations());
        $self->{animation_offsets} = [];
        my $n_animation_offsets = $self->model_header()->animation_count();
        for (my $i = 0; $i < $n_animation_offsets; $i++) {
            push @{$self->{animation_offsets}}, $self->{_io}->read_u4le();
        }
        $self->{_io}->seek($_pos);
    }
    return $self->{animation_offsets};
}

sub animations {
    my ($self) = @_;
    return $self->{animations} if ($self->{animations});
    if ($self->model_header()->animation_count() > 0) {
        $self->{animations} = [];
        my $n_animations = $self->model_header()->animation_count();
        for (my $i = 0; $i < $n_animations; $i++) {
            push @{$self->{animations}}, Mdl::MdlAnimationEntry->new($self->{_io}, $self, $self->{_root});
        }
    }
    return $self->{animations};
}

sub data_start {
    my ($self) = @_;
    return $self->{data_start} if ($self->{data_start});
    $self->{data_start} = 12;
    return $self->{data_start};
}

sub name_offsets {
    my ($self) = @_;
    return $self->{name_offsets} if ($self->{name_offsets});
    if ($self->model_header()->name_offsets_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->data_start() + $self->model_header()->offset_to_name_offsets());
        $self->{name_offsets} = [];
        my $n_name_offsets = $self->model_header()->name_offsets_count();
        for (my $i = 0; $i < $n_name_offsets; $i++) {
            push @{$self->{name_offsets}}, $self->{_io}->read_u4le();
        }
        $self->{_io}->seek($_pos);
    }
    return $self->{name_offsets};
}

sub names_data {
    my ($self) = @_;
    return $self->{names_data} if ($self->{names_data});
    if ($self->model_header()->name_offsets_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek(($self->data_start() + $self->model_header()->offset_to_name_offsets()) + 4 * $self->model_header()->name_offsets_count());
        $self->{_raw_names_data} = $self->{_io}->read_bytes(($self->data_start() + $self->model_header()->offset_to_animations()) - (($self->data_start() + $self->model_header()->offset_to_name_offsets()) + 4 * $self->model_header()->name_offsets_count()));
        my $io__raw_names_data = IO::KaitaiStruct::Stream->new($self->{_raw_names_data});
        $self->{names_data} = Mdl::NameStrings->new($io__raw_names_data, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{names_data};
}

sub root_node {
    my ($self) = @_;
    return $self->{root_node} if ($self->{root_node});
    if ($self->model_header()->geometry()->root_node_offset() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->data_start() + $self->model_header()->geometry()->root_node_offset());
        $self->{root_node} = Mdl::Node->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{root_node};
}

sub file_header {
    my ($self) = @_;
    return $self->{file_header};
}

sub model_header {
    my ($self) = @_;
    return $self->{model_header};
}

sub _raw_names_data {
    my ($self) = @_;
    return $self->{_raw_names_data};
}

########################################################################
package Mdl::AabbHeader;

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

    $self->{trimesh_base} = Mdl::TrimeshHeader->new($self->{_io}, $self, $self->{_root});
    $self->{unknown} = $self->{_io}->read_u4le();
}

sub trimesh_base {
    my ($self) = @_;
    return $self->{trimesh_base};
}

sub unknown {
    my ($self) = @_;
    return $self->{unknown};
}

########################################################################
package Mdl::AnimationEvent;

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

    $self->{activation_time} = $self->{_io}->read_f4le();
    $self->{event_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
}

sub activation_time {
    my ($self) = @_;
    return $self->{activation_time};
}

sub event_name {
    my ($self) = @_;
    return $self->{event_name};
}

########################################################################
package Mdl::AnimationHeader;

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

    $self->{geo_header} = Mdl::GeometryHeader->new($self->{_io}, $self, $self->{_root});
    $self->{animation_length} = $self->{_io}->read_f4le();
    $self->{transition_time} = $self->{_io}->read_f4le();
    $self->{animation_root} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{event_array_offset} = $self->{_io}->read_u4le();
    $self->{event_count} = $self->{_io}->read_u4le();
    $self->{event_count_duplicate} = $self->{_io}->read_u4le();
    $self->{unknown} = $self->{_io}->read_u4le();
}

sub geo_header {
    my ($self) = @_;
    return $self->{geo_header};
}

sub animation_length {
    my ($self) = @_;
    return $self->{animation_length};
}

sub transition_time {
    my ($self) = @_;
    return $self->{transition_time};
}

sub animation_root {
    my ($self) = @_;
    return $self->{animation_root};
}

sub event_array_offset {
    my ($self) = @_;
    return $self->{event_array_offset};
}

sub event_count {
    my ($self) = @_;
    return $self->{event_count};
}

sub event_count_duplicate {
    my ($self) = @_;
    return $self->{event_count_duplicate};
}

sub unknown {
    my ($self) = @_;
    return $self->{unknown};
}

########################################################################
package Mdl::AnimmeshHeader;

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

    $self->{trimesh_base} = Mdl::TrimeshHeader->new($self->{_io}, $self, $self->{_root});
    $self->{unknown} = $self->{_io}->read_f4le();
    $self->{unknown_array} = Mdl::ArrayDefinition->new($self->{_io}, $self, $self->{_root});
    $self->{unknown_floats} = [];
    my $n_unknown_floats = 9;
    for (my $i = 0; $i < $n_unknown_floats; $i++) {
        push @{$self->{unknown_floats}}, $self->{_io}->read_f4le();
    }
}

sub trimesh_base {
    my ($self) = @_;
    return $self->{trimesh_base};
}

sub unknown {
    my ($self) = @_;
    return $self->{unknown};
}

sub unknown_array {
    my ($self) = @_;
    return $self->{unknown_array};
}

sub unknown_floats {
    my ($self) = @_;
    return $self->{unknown_floats};
}

########################################################################
package Mdl::ArrayDefinition;

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

    $self->{offset} = $self->{_io}->read_s4le();
    $self->{count} = $self->{_io}->read_u4le();
    $self->{count_duplicate} = $self->{_io}->read_u4le();
}

sub offset {
    my ($self) = @_;
    return $self->{offset};
}

sub count {
    my ($self) = @_;
    return $self->{count};
}

sub count_duplicate {
    my ($self) = @_;
    return $self->{count_duplicate};
}

########################################################################
package Mdl::Controller;

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

    $self->{type} = $self->{_io}->read_u4le();
    $self->{unknown} = $self->{_io}->read_u2le();
    $self->{row_count} = $self->{_io}->read_u2le();
    $self->{time_index} = $self->{_io}->read_u2le();
    $self->{data_index} = $self->{_io}->read_u2le();
    $self->{column_count} = $self->{_io}->read_u1();
    $self->{padding} = [];
    my $n_padding = 3;
    for (my $i = 0; $i < $n_padding; $i++) {
        push @{$self->{padding}}, $self->{_io}->read_u1();
    }
}

sub uses_bezier {
    my ($self) = @_;
    return $self->{uses_bezier} if ($self->{uses_bezier});
    $self->{uses_bezier} = ($self->column_count() & 16) != 0;
    return $self->{uses_bezier};
}

sub type {
    my ($self) = @_;
    return $self->{type};
}

sub unknown {
    my ($self) = @_;
    return $self->{unknown};
}

sub row_count {
    my ($self) = @_;
    return $self->{row_count};
}

sub time_index {
    my ($self) = @_;
    return $self->{time_index};
}

sub data_index {
    my ($self) = @_;
    return $self->{data_index};
}

sub column_count {
    my ($self) = @_;
    return $self->{column_count};
}

sub padding {
    my ($self) = @_;
    return $self->{padding};
}

########################################################################
package Mdl::DanglymeshHeader;

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

    $self->{trimesh_base} = Mdl::TrimeshHeader->new($self->{_io}, $self, $self->{_root});
    $self->{constraints_offset} = $self->{_io}->read_u4le();
    $self->{constraints_count} = $self->{_io}->read_u4le();
    $self->{constraints_count_duplicate} = $self->{_io}->read_u4le();
    $self->{displacement} = $self->{_io}->read_f4le();
    $self->{tightness} = $self->{_io}->read_f4le();
    $self->{period} = $self->{_io}->read_f4le();
    $self->{unknown} = $self->{_io}->read_u4le();
}

sub trimesh_base {
    my ($self) = @_;
    return $self->{trimesh_base};
}

sub constraints_offset {
    my ($self) = @_;
    return $self->{constraints_offset};
}

sub constraints_count {
    my ($self) = @_;
    return $self->{constraints_count};
}

sub constraints_count_duplicate {
    my ($self) = @_;
    return $self->{constraints_count_duplicate};
}

sub displacement {
    my ($self) = @_;
    return $self->{displacement};
}

sub tightness {
    my ($self) = @_;
    return $self->{tightness};
}

sub period {
    my ($self) = @_;
    return $self->{period};
}

sub unknown {
    my ($self) = @_;
    return $self->{unknown};
}

########################################################################
package Mdl::EmitterHeader;

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

    $self->{dead_space} = $self->{_io}->read_f4le();
    $self->{blast_radius} = $self->{_io}->read_f4le();
    $self->{blast_length} = $self->{_io}->read_f4le();
    $self->{branch_count} = $self->{_io}->read_u4le();
    $self->{control_point_smoothing} = $self->{_io}->read_f4le();
    $self->{x_grid} = $self->{_io}->read_u4le();
    $self->{y_grid} = $self->{_io}->read_u4le();
    $self->{padding_unknown} = $self->{_io}->read_u4le();
    $self->{update_script} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{render_script} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{blend_script} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{texture_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{chunk_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{two_sided_texture} = $self->{_io}->read_u4le();
    $self->{loop} = $self->{_io}->read_u4le();
    $self->{render_order} = $self->{_io}->read_u2le();
    $self->{frame_blending} = $self->{_io}->read_u1();
    $self->{depth_texture_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{padding} = $self->{_io}->read_u1();
    $self->{flags} = $self->{_io}->read_u4le();
}

sub dead_space {
    my ($self) = @_;
    return $self->{dead_space};
}

sub blast_radius {
    my ($self) = @_;
    return $self->{blast_radius};
}

sub blast_length {
    my ($self) = @_;
    return $self->{blast_length};
}

sub branch_count {
    my ($self) = @_;
    return $self->{branch_count};
}

sub control_point_smoothing {
    my ($self) = @_;
    return $self->{control_point_smoothing};
}

sub x_grid {
    my ($self) = @_;
    return $self->{x_grid};
}

sub y_grid {
    my ($self) = @_;
    return $self->{y_grid};
}

sub padding_unknown {
    my ($self) = @_;
    return $self->{padding_unknown};
}

sub update_script {
    my ($self) = @_;
    return $self->{update_script};
}

sub render_script {
    my ($self) = @_;
    return $self->{render_script};
}

sub blend_script {
    my ($self) = @_;
    return $self->{blend_script};
}

sub texture_name {
    my ($self) = @_;
    return $self->{texture_name};
}

sub chunk_name {
    my ($self) = @_;
    return $self->{chunk_name};
}

sub two_sided_texture {
    my ($self) = @_;
    return $self->{two_sided_texture};
}

sub loop {
    my ($self) = @_;
    return $self->{loop};
}

sub render_order {
    my ($self) = @_;
    return $self->{render_order};
}

sub frame_blending {
    my ($self) = @_;
    return $self->{frame_blending};
}

sub depth_texture_name {
    my ($self) = @_;
    return $self->{depth_texture_name};
}

sub padding {
    my ($self) = @_;
    return $self->{padding};
}

sub flags {
    my ($self) = @_;
    return $self->{flags};
}

########################################################################
package Mdl::FileHeader;

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

    $self->{unused} = $self->{_io}->read_u4le();
    $self->{mdl_size} = $self->{_io}->read_u4le();
    $self->{mdx_size} = $self->{_io}->read_u4le();
}

sub unused {
    my ($self) = @_;
    return $self->{unused};
}

sub mdl_size {
    my ($self) = @_;
    return $self->{mdl_size};
}

sub mdx_size {
    my ($self) = @_;
    return $self->{mdx_size};
}

########################################################################
package Mdl::GeometryHeader;

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

    $self->{function_pointer_0} = $self->{_io}->read_u4le();
    $self->{function_pointer_1} = $self->{_io}->read_u4le();
    $self->{model_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{root_node_offset} = $self->{_io}->read_u4le();
    $self->{node_count} = $self->{_io}->read_u4le();
    $self->{unknown_array_1} = Mdl::ArrayDefinition->new($self->{_io}, $self, $self->{_root});
    $self->{unknown_array_2} = Mdl::ArrayDefinition->new($self->{_io}, $self, $self->{_root});
    $self->{reference_count} = $self->{_io}->read_u4le();
    $self->{geometry_type} = $self->{_io}->read_u1();
    $self->{padding} = [];
    my $n_padding = 3;
    for (my $i = 0; $i < $n_padding; $i++) {
        push @{$self->{padding}}, $self->{_io}->read_u1();
    }
}

sub is_kotor2 {
    my ($self) = @_;
    return $self->{is_kotor2} if ($self->{is_kotor2});
    $self->{is_kotor2} =  (($self->function_pointer_0() == 4285200) || ($self->function_pointer_0() == 4285872)) ;
    return $self->{is_kotor2};
}

sub function_pointer_0 {
    my ($self) = @_;
    return $self->{function_pointer_0};
}

sub function_pointer_1 {
    my ($self) = @_;
    return $self->{function_pointer_1};
}

sub model_name {
    my ($self) = @_;
    return $self->{model_name};
}

sub root_node_offset {
    my ($self) = @_;
    return $self->{root_node_offset};
}

sub node_count {
    my ($self) = @_;
    return $self->{node_count};
}

sub unknown_array_1 {
    my ($self) = @_;
    return $self->{unknown_array_1};
}

sub unknown_array_2 {
    my ($self) = @_;
    return $self->{unknown_array_2};
}

sub reference_count {
    my ($self) = @_;
    return $self->{reference_count};
}

sub geometry_type {
    my ($self) = @_;
    return $self->{geometry_type};
}

sub padding {
    my ($self) = @_;
    return $self->{padding};
}

########################################################################
package Mdl::LightHeader;

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

    $self->{unknown} = [];
    my $n_unknown = 4;
    for (my $i = 0; $i < $n_unknown; $i++) {
        push @{$self->{unknown}}, $self->{_io}->read_f4le();
    }
    $self->{flare_sizes_offset} = $self->{_io}->read_u4le();
    $self->{flare_sizes_count} = $self->{_io}->read_u4le();
    $self->{flare_sizes_count_duplicate} = $self->{_io}->read_u4le();
    $self->{flare_positions_offset} = $self->{_io}->read_u4le();
    $self->{flare_positions_count} = $self->{_io}->read_u4le();
    $self->{flare_positions_count_duplicate} = $self->{_io}->read_u4le();
    $self->{flare_color_shifts_offset} = $self->{_io}->read_u4le();
    $self->{flare_color_shifts_count} = $self->{_io}->read_u4le();
    $self->{flare_color_shifts_count_duplicate} = $self->{_io}->read_u4le();
    $self->{flare_texture_names_offset} = $self->{_io}->read_u4le();
    $self->{flare_texture_names_count} = $self->{_io}->read_u4le();
    $self->{flare_texture_names_count_duplicate} = $self->{_io}->read_u4le();
    $self->{flare_radius} = $self->{_io}->read_f4le();
    $self->{light_priority} = $self->{_io}->read_u4le();
    $self->{ambient_only} = $self->{_io}->read_u4le();
    $self->{dynamic_type} = $self->{_io}->read_u4le();
    $self->{affect_dynamic} = $self->{_io}->read_u4le();
    $self->{shadow} = $self->{_io}->read_u4le();
    $self->{flare} = $self->{_io}->read_u4le();
    $self->{fading_light} = $self->{_io}->read_u4le();
}

sub unknown {
    my ($self) = @_;
    return $self->{unknown};
}

sub flare_sizes_offset {
    my ($self) = @_;
    return $self->{flare_sizes_offset};
}

sub flare_sizes_count {
    my ($self) = @_;
    return $self->{flare_sizes_count};
}

sub flare_sizes_count_duplicate {
    my ($self) = @_;
    return $self->{flare_sizes_count_duplicate};
}

sub flare_positions_offset {
    my ($self) = @_;
    return $self->{flare_positions_offset};
}

sub flare_positions_count {
    my ($self) = @_;
    return $self->{flare_positions_count};
}

sub flare_positions_count_duplicate {
    my ($self) = @_;
    return $self->{flare_positions_count_duplicate};
}

sub flare_color_shifts_offset {
    my ($self) = @_;
    return $self->{flare_color_shifts_offset};
}

sub flare_color_shifts_count {
    my ($self) = @_;
    return $self->{flare_color_shifts_count};
}

sub flare_color_shifts_count_duplicate {
    my ($self) = @_;
    return $self->{flare_color_shifts_count_duplicate};
}

sub flare_texture_names_offset {
    my ($self) = @_;
    return $self->{flare_texture_names_offset};
}

sub flare_texture_names_count {
    my ($self) = @_;
    return $self->{flare_texture_names_count};
}

sub flare_texture_names_count_duplicate {
    my ($self) = @_;
    return $self->{flare_texture_names_count_duplicate};
}

sub flare_radius {
    my ($self) = @_;
    return $self->{flare_radius};
}

sub light_priority {
    my ($self) = @_;
    return $self->{light_priority};
}

sub ambient_only {
    my ($self) = @_;
    return $self->{ambient_only};
}

sub dynamic_type {
    my ($self) = @_;
    return $self->{dynamic_type};
}

sub affect_dynamic {
    my ($self) = @_;
    return $self->{affect_dynamic};
}

sub shadow {
    my ($self) = @_;
    return $self->{shadow};
}

sub flare {
    my ($self) = @_;
    return $self->{flare};
}

sub fading_light {
    my ($self) = @_;
    return $self->{fading_light};
}

########################################################################
package Mdl::LightsaberHeader;

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

    $self->{trimesh_base} = Mdl::TrimeshHeader->new($self->{_io}, $self, $self->{_root});
    $self->{vertices_offset} = $self->{_io}->read_u4le();
    $self->{texcoords_offset} = $self->{_io}->read_u4le();
    $self->{normals_offset} = $self->{_io}->read_u4le();
    $self->{unknown1} = $self->{_io}->read_u4le();
    $self->{unknown2} = $self->{_io}->read_u4le();
}

sub trimesh_base {
    my ($self) = @_;
    return $self->{trimesh_base};
}

sub vertices_offset {
    my ($self) = @_;
    return $self->{vertices_offset};
}

sub texcoords_offset {
    my ($self) = @_;
    return $self->{texcoords_offset};
}

sub normals_offset {
    my ($self) = @_;
    return $self->{normals_offset};
}

sub unknown1 {
    my ($self) = @_;
    return $self->{unknown1};
}

sub unknown2 {
    my ($self) = @_;
    return $self->{unknown2};
}

########################################################################
package Mdl::MdlAnimationEntry;

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

}

sub header {
    my ($self) = @_;
    return $self->{header} if ($self->{header});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->_root()->data_start() + @{$self->_root()->animation_offsets()}[$self->anim_index()]);
    $self->{header} = Mdl::AnimationHeader->new($self->{_io}, $self, $self->{_root});
    $self->{_io}->seek($_pos);
    return $self->{header};
}

sub anim_index {
    my ($self) = @_;
    return $self->{anim_index};
}

########################################################################
package Mdl::ModelHeader;

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

    $self->{geometry} = Mdl::GeometryHeader->new($self->{_io}, $self, $self->{_root});
    $self->{model_type} = $self->{_io}->read_u1();
    $self->{unknown0} = $self->{_io}->read_u1();
    $self->{padding0} = $self->{_io}->read_u1();
    $self->{fog} = $self->{_io}->read_u1();
    $self->{unknown1} = $self->{_io}->read_u4le();
    $self->{offset_to_animations} = $self->{_io}->read_u4le();
    $self->{animation_count} = $self->{_io}->read_u4le();
    $self->{animation_count2} = $self->{_io}->read_u4le();
    $self->{unknown2} = $self->{_io}->read_u4le();
    $self->{bounding_box_min} = Mdl::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{bounding_box_max} = Mdl::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{radius} = $self->{_io}->read_f4le();
    $self->{animation_scale} = $self->{_io}->read_f4le();
    $self->{supermodel_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{offset_to_super_root} = $self->{_io}->read_u4le();
    $self->{unknown3} = $self->{_io}->read_u4le();
    $self->{mdx_data_size} = $self->{_io}->read_u4le();
    $self->{mdx_data_offset} = $self->{_io}->read_u4le();
    $self->{offset_to_name_offsets} = $self->{_io}->read_u4le();
    $self->{name_offsets_count} = $self->{_io}->read_u4le();
    $self->{name_offsets_count2} = $self->{_io}->read_u4le();
}

sub geometry {
    my ($self) = @_;
    return $self->{geometry};
}

sub model_type {
    my ($self) = @_;
    return $self->{model_type};
}

sub unknown0 {
    my ($self) = @_;
    return $self->{unknown0};
}

sub padding0 {
    my ($self) = @_;
    return $self->{padding0};
}

sub fog {
    my ($self) = @_;
    return $self->{fog};
}

sub unknown1 {
    my ($self) = @_;
    return $self->{unknown1};
}

sub offset_to_animations {
    my ($self) = @_;
    return $self->{offset_to_animations};
}

sub animation_count {
    my ($self) = @_;
    return $self->{animation_count};
}

sub animation_count2 {
    my ($self) = @_;
    return $self->{animation_count2};
}

sub unknown2 {
    my ($self) = @_;
    return $self->{unknown2};
}

sub bounding_box_min {
    my ($self) = @_;
    return $self->{bounding_box_min};
}

sub bounding_box_max {
    my ($self) = @_;
    return $self->{bounding_box_max};
}

sub radius {
    my ($self) = @_;
    return $self->{radius};
}

sub animation_scale {
    my ($self) = @_;
    return $self->{animation_scale};
}

sub supermodel_name {
    my ($self) = @_;
    return $self->{supermodel_name};
}

sub offset_to_super_root {
    my ($self) = @_;
    return $self->{offset_to_super_root};
}

sub unknown3 {
    my ($self) = @_;
    return $self->{unknown3};
}

sub mdx_data_size {
    my ($self) = @_;
    return $self->{mdx_data_size};
}

sub mdx_data_offset {
    my ($self) = @_;
    return $self->{mdx_data_offset};
}

sub offset_to_name_offsets {
    my ($self) = @_;
    return $self->{offset_to_name_offsets};
}

sub name_offsets_count {
    my ($self) = @_;
    return $self->{name_offsets_count};
}

sub name_offsets_count2 {
    my ($self) = @_;
    return $self->{name_offsets_count2};
}

########################################################################
package Mdl::NameStrings;

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

    $self->{strings} = [];
    while (!$self->{_io}->is_eof()) {
        push @{$self->{strings}}, Encode::decode("ASCII", $self->{_io}->read_bytes_term(0, 0, 1, 1));
    }
}

sub strings {
    my ($self) = @_;
    return $self->{strings};
}

########################################################################
package Mdl::Node;

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

    $self->{header} = Mdl::NodeHeader->new($self->{_io}, $self, $self->{_root});
    if ($self->header()->node_type() == 3) {
        $self->{light_sub_header} = Mdl::LightHeader->new($self->{_io}, $self, $self->{_root});
    }
    if ($self->header()->node_type() == 5) {
        $self->{emitter_sub_header} = Mdl::EmitterHeader->new($self->{_io}, $self, $self->{_root});
    }
    if ($self->header()->node_type() == 17) {
        $self->{reference_sub_header} = Mdl::ReferenceHeader->new($self->{_io}, $self, $self->{_root});
    }
    if ($self->header()->node_type() == 33) {
        $self->{trimesh_sub_header} = Mdl::TrimeshHeader->new($self->{_io}, $self, $self->{_root});
    }
    if ($self->header()->node_type() == 97) {
        $self->{skinmesh_sub_header} = Mdl::SkinmeshHeader->new($self->{_io}, $self, $self->{_root});
    }
    if ($self->header()->node_type() == 161) {
        $self->{animmesh_sub_header} = Mdl::AnimmeshHeader->new($self->{_io}, $self, $self->{_root});
    }
    if ($self->header()->node_type() == 289) {
        $self->{danglymesh_sub_header} = Mdl::DanglymeshHeader->new($self->{_io}, $self, $self->{_root});
    }
    if ($self->header()->node_type() == 545) {
        $self->{aabb_sub_header} = Mdl::AabbHeader->new($self->{_io}, $self, $self->{_root});
    }
    if ($self->header()->node_type() == 2081) {
        $self->{lightsaber_sub_header} = Mdl::LightsaberHeader->new($self->{_io}, $self, $self->{_root});
    }
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

sub light_sub_header {
    my ($self) = @_;
    return $self->{light_sub_header};
}

sub emitter_sub_header {
    my ($self) = @_;
    return $self->{emitter_sub_header};
}

sub reference_sub_header {
    my ($self) = @_;
    return $self->{reference_sub_header};
}

sub trimesh_sub_header {
    my ($self) = @_;
    return $self->{trimesh_sub_header};
}

sub skinmesh_sub_header {
    my ($self) = @_;
    return $self->{skinmesh_sub_header};
}

sub animmesh_sub_header {
    my ($self) = @_;
    return $self->{animmesh_sub_header};
}

sub danglymesh_sub_header {
    my ($self) = @_;
    return $self->{danglymesh_sub_header};
}

sub aabb_sub_header {
    my ($self) = @_;
    return $self->{aabb_sub_header};
}

sub lightsaber_sub_header {
    my ($self) = @_;
    return $self->{lightsaber_sub_header};
}

########################################################################
package Mdl::NodeHeader;

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

    $self->{node_type} = $self->{_io}->read_u2le();
    $self->{node_index} = $self->{_io}->read_u2le();
    $self->{node_name_index} = $self->{_io}->read_u2le();
    $self->{padding} = $self->{_io}->read_u2le();
    $self->{root_node_offset} = $self->{_io}->read_u4le();
    $self->{parent_node_offset} = $self->{_io}->read_u4le();
    $self->{position} = Mdl::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{orientation} = Mdl::Quaternion->new($self->{_io}, $self, $self->{_root});
    $self->{child_array_offset} = $self->{_io}->read_u4le();
    $self->{child_count} = $self->{_io}->read_u4le();
    $self->{child_count_duplicate} = $self->{_io}->read_u4le();
    $self->{controller_array_offset} = $self->{_io}->read_u4le();
    $self->{controller_count} = $self->{_io}->read_u4le();
    $self->{controller_count_duplicate} = $self->{_io}->read_u4le();
    $self->{controller_data_offset} = $self->{_io}->read_u4le();
    $self->{controller_data_count} = $self->{_io}->read_u4le();
    $self->{controller_data_count_duplicate} = $self->{_io}->read_u4le();
}

sub has_aabb {
    my ($self) = @_;
    return $self->{has_aabb} if ($self->{has_aabb});
    $self->{has_aabb} = ($self->node_type() & 512) != 0;
    return $self->{has_aabb};
}

sub has_anim {
    my ($self) = @_;
    return $self->{has_anim} if ($self->{has_anim});
    $self->{has_anim} = ($self->node_type() & 128) != 0;
    return $self->{has_anim};
}

sub has_dangly {
    my ($self) = @_;
    return $self->{has_dangly} if ($self->{has_dangly});
    $self->{has_dangly} = ($self->node_type() & 256) != 0;
    return $self->{has_dangly};
}

sub has_emitter {
    my ($self) = @_;
    return $self->{has_emitter} if ($self->{has_emitter});
    $self->{has_emitter} = ($self->node_type() & 4) != 0;
    return $self->{has_emitter};
}

sub has_light {
    my ($self) = @_;
    return $self->{has_light} if ($self->{has_light});
    $self->{has_light} = ($self->node_type() & 2) != 0;
    return $self->{has_light};
}

sub has_mesh {
    my ($self) = @_;
    return $self->{has_mesh} if ($self->{has_mesh});
    $self->{has_mesh} = ($self->node_type() & 32) != 0;
    return $self->{has_mesh};
}

sub has_reference {
    my ($self) = @_;
    return $self->{has_reference} if ($self->{has_reference});
    $self->{has_reference} = ($self->node_type() & 16) != 0;
    return $self->{has_reference};
}

sub has_saber {
    my ($self) = @_;
    return $self->{has_saber} if ($self->{has_saber});
    $self->{has_saber} = ($self->node_type() & 2048) != 0;
    return $self->{has_saber};
}

sub has_skin {
    my ($self) = @_;
    return $self->{has_skin} if ($self->{has_skin});
    $self->{has_skin} = ($self->node_type() & 64) != 0;
    return $self->{has_skin};
}

sub node_type {
    my ($self) = @_;
    return $self->{node_type};
}

sub node_index {
    my ($self) = @_;
    return $self->{node_index};
}

sub node_name_index {
    my ($self) = @_;
    return $self->{node_name_index};
}

sub padding {
    my ($self) = @_;
    return $self->{padding};
}

sub root_node_offset {
    my ($self) = @_;
    return $self->{root_node_offset};
}

sub parent_node_offset {
    my ($self) = @_;
    return $self->{parent_node_offset};
}

sub position {
    my ($self) = @_;
    return $self->{position};
}

sub orientation {
    my ($self) = @_;
    return $self->{orientation};
}

sub child_array_offset {
    my ($self) = @_;
    return $self->{child_array_offset};
}

sub child_count {
    my ($self) = @_;
    return $self->{child_count};
}

sub child_count_duplicate {
    my ($self) = @_;
    return $self->{child_count_duplicate};
}

sub controller_array_offset {
    my ($self) = @_;
    return $self->{controller_array_offset};
}

sub controller_count {
    my ($self) = @_;
    return $self->{controller_count};
}

sub controller_count_duplicate {
    my ($self) = @_;
    return $self->{controller_count_duplicate};
}

sub controller_data_offset {
    my ($self) = @_;
    return $self->{controller_data_offset};
}

sub controller_data_count {
    my ($self) = @_;
    return $self->{controller_data_count};
}

sub controller_data_count_duplicate {
    my ($self) = @_;
    return $self->{controller_data_count_duplicate};
}

########################################################################
package Mdl::Quaternion;

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

    $self->{w} = $self->{_io}->read_f4le();
    $self->{x} = $self->{_io}->read_f4le();
    $self->{y} = $self->{_io}->read_f4le();
    $self->{z} = $self->{_io}->read_f4le();
}

sub w {
    my ($self) = @_;
    return $self->{w};
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
package Mdl::ReferenceHeader;

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

    $self->{model_resref} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{reattachable} = $self->{_io}->read_u4le();
}

sub model_resref {
    my ($self) = @_;
    return $self->{model_resref};
}

sub reattachable {
    my ($self) = @_;
    return $self->{reattachable};
}

########################################################################
package Mdl::SkinmeshHeader;

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

    $self->{trimesh_base} = Mdl::TrimeshHeader->new($self->{_io}, $self, $self->{_root});
    $self->{unknown_weights} = $self->{_io}->read_s4le();
    $self->{padding1} = [];
    my $n_padding1 = 8;
    for (my $i = 0; $i < $n_padding1; $i++) {
        push @{$self->{padding1}}, $self->{_io}->read_u1();
    }
    $self->{mdx_bone_weights_offset} = $self->{_io}->read_u4le();
    $self->{mdx_bone_indices_offset} = $self->{_io}->read_u4le();
    $self->{bone_map_offset} = $self->{_io}->read_u4le();
    $self->{bone_map_count} = $self->{_io}->read_u4le();
    $self->{qbones_offset} = $self->{_io}->read_u4le();
    $self->{qbones_count} = $self->{_io}->read_u4le();
    $self->{qbones_count_duplicate} = $self->{_io}->read_u4le();
    $self->{tbones_offset} = $self->{_io}->read_u4le();
    $self->{tbones_count} = $self->{_io}->read_u4le();
    $self->{tbones_count_duplicate} = $self->{_io}->read_u4le();
    $self->{unknown_array} = $self->{_io}->read_u4le();
    $self->{bone_node_serial_numbers} = [];
    my $n_bone_node_serial_numbers = 16;
    for (my $i = 0; $i < $n_bone_node_serial_numbers; $i++) {
        push @{$self->{bone_node_serial_numbers}}, $self->{_io}->read_u2le();
    }
    $self->{padding2} = $self->{_io}->read_u2le();
}

sub trimesh_base {
    my ($self) = @_;
    return $self->{trimesh_base};
}

sub unknown_weights {
    my ($self) = @_;
    return $self->{unknown_weights};
}

sub padding1 {
    my ($self) = @_;
    return $self->{padding1};
}

sub mdx_bone_weights_offset {
    my ($self) = @_;
    return $self->{mdx_bone_weights_offset};
}

sub mdx_bone_indices_offset {
    my ($self) = @_;
    return $self->{mdx_bone_indices_offset};
}

sub bone_map_offset {
    my ($self) = @_;
    return $self->{bone_map_offset};
}

sub bone_map_count {
    my ($self) = @_;
    return $self->{bone_map_count};
}

sub qbones_offset {
    my ($self) = @_;
    return $self->{qbones_offset};
}

sub qbones_count {
    my ($self) = @_;
    return $self->{qbones_count};
}

sub qbones_count_duplicate {
    my ($self) = @_;
    return $self->{qbones_count_duplicate};
}

sub tbones_offset {
    my ($self) = @_;
    return $self->{tbones_offset};
}

sub tbones_count {
    my ($self) = @_;
    return $self->{tbones_count};
}

sub tbones_count_duplicate {
    my ($self) = @_;
    return $self->{tbones_count_duplicate};
}

sub unknown_array {
    my ($self) = @_;
    return $self->{unknown_array};
}

sub bone_node_serial_numbers {
    my ($self) = @_;
    return $self->{bone_node_serial_numbers};
}

sub padding2 {
    my ($self) = @_;
    return $self->{padding2};
}

########################################################################
package Mdl::TrimeshHeader;

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

    $self->{function_pointer_0} = $self->{_io}->read_u4le();
    $self->{function_pointer_1} = $self->{_io}->read_u4le();
    $self->{faces_array_offset} = $self->{_io}->read_u4le();
    $self->{faces_count} = $self->{_io}->read_u4le();
    $self->{faces_count_duplicate} = $self->{_io}->read_u4le();
    $self->{bounding_box_min} = Mdl::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{bounding_box_max} = Mdl::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{radius} = $self->{_io}->read_f4le();
    $self->{average_point} = Mdl::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{diffuse_color} = Mdl::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{ambient_color} = Mdl::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{transparency_hint} = $self->{_io}->read_u4le();
    $self->{texture_0_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{texture_1_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(32), 0, 0));
    $self->{texture_2_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(12), 0, 0));
    $self->{texture_3_name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(12), 0, 0));
    $self->{indices_count_array_offset} = $self->{_io}->read_u4le();
    $self->{indices_count_array_count} = $self->{_io}->read_u4le();
    $self->{indices_count_array_count_duplicate} = $self->{_io}->read_u4le();
    $self->{indices_offset_array_offset} = $self->{_io}->read_u4le();
    $self->{indices_offset_array_count} = $self->{_io}->read_u4le();
    $self->{indices_offset_array_count_duplicate} = $self->{_io}->read_u4le();
    $self->{inverted_counter_array_offset} = $self->{_io}->read_u4le();
    $self->{inverted_counter_array_count} = $self->{_io}->read_u4le();
    $self->{inverted_counter_array_count_duplicate} = $self->{_io}->read_u4le();
    $self->{unknown_values} = [];
    my $n_unknown_values = 3;
    for (my $i = 0; $i < $n_unknown_values; $i++) {
        push @{$self->{unknown_values}}, $self->{_io}->read_s4le();
    }
    $self->{saber_unknown_data} = [];
    my $n_saber_unknown_data = 8;
    for (my $i = 0; $i < $n_saber_unknown_data; $i++) {
        push @{$self->{saber_unknown_data}}, $self->{_io}->read_u1();
    }
    $self->{unknown} = $self->{_io}->read_u4le();
    $self->{uv_direction} = Mdl::Vec3f->new($self->{_io}, $self, $self->{_root});
    $self->{uv_jitter} = $self->{_io}->read_f4le();
    $self->{uv_jitter_speed} = $self->{_io}->read_f4le();
    $self->{mdx_vertex_size} = $self->{_io}->read_u4le();
    $self->{mdx_data_flags} = $self->{_io}->read_u4le();
    $self->{mdx_vertices_offset} = $self->{_io}->read_s4le();
    $self->{mdx_normals_offset} = $self->{_io}->read_s4le();
    $self->{mdx_vertex_colors_offset} = $self->{_io}->read_s4le();
    $self->{mdx_tex0_uvs_offset} = $self->{_io}->read_s4le();
    $self->{mdx_tex1_uvs_offset} = $self->{_io}->read_s4le();
    $self->{mdx_tex2_uvs_offset} = $self->{_io}->read_s4le();
    $self->{mdx_tex3_uvs_offset} = $self->{_io}->read_s4le();
    $self->{mdx_tangent_space_offset} = $self->{_io}->read_s4le();
    $self->{mdx_unknown_offset_1} = $self->{_io}->read_s4le();
    $self->{mdx_unknown_offset_2} = $self->{_io}->read_s4le();
    $self->{mdx_unknown_offset_3} = $self->{_io}->read_s4le();
    $self->{vertex_count} = $self->{_io}->read_u2le();
    $self->{texture_count} = $self->{_io}->read_u2le();
    $self->{lightmapped} = $self->{_io}->read_u1();
    $self->{rotate_texture} = $self->{_io}->read_u1();
    $self->{background_geometry} = $self->{_io}->read_u1();
    $self->{shadow} = $self->{_io}->read_u1();
    $self->{beaming} = $self->{_io}->read_u1();
    $self->{render} = $self->{_io}->read_u1();
    $self->{unknown_flag} = $self->{_io}->read_u1();
    $self->{padding} = $self->{_io}->read_u1();
    $self->{total_area} = $self->{_io}->read_f4le();
    $self->{unknown2} = $self->{_io}->read_u4le();
    if ($self->_root()->model_header()->geometry()->is_kotor2()) {
        $self->{k2_unknown_1} = $self->{_io}->read_u4le();
    }
    if ($self->_root()->model_header()->geometry()->is_kotor2()) {
        $self->{k2_unknown_2} = $self->{_io}->read_u4le();
    }
    $self->{mdx_data_offset} = $self->{_io}->read_u4le();
    $self->{mdl_vertices_offset} = $self->{_io}->read_u4le();
}

sub function_pointer_0 {
    my ($self) = @_;
    return $self->{function_pointer_0};
}

sub function_pointer_1 {
    my ($self) = @_;
    return $self->{function_pointer_1};
}

sub faces_array_offset {
    my ($self) = @_;
    return $self->{faces_array_offset};
}

sub faces_count {
    my ($self) = @_;
    return $self->{faces_count};
}

sub faces_count_duplicate {
    my ($self) = @_;
    return $self->{faces_count_duplicate};
}

sub bounding_box_min {
    my ($self) = @_;
    return $self->{bounding_box_min};
}

sub bounding_box_max {
    my ($self) = @_;
    return $self->{bounding_box_max};
}

sub radius {
    my ($self) = @_;
    return $self->{radius};
}

sub average_point {
    my ($self) = @_;
    return $self->{average_point};
}

sub diffuse_color {
    my ($self) = @_;
    return $self->{diffuse_color};
}

sub ambient_color {
    my ($self) = @_;
    return $self->{ambient_color};
}

sub transparency_hint {
    my ($self) = @_;
    return $self->{transparency_hint};
}

sub texture_0_name {
    my ($self) = @_;
    return $self->{texture_0_name};
}

sub texture_1_name {
    my ($self) = @_;
    return $self->{texture_1_name};
}

sub texture_2_name {
    my ($self) = @_;
    return $self->{texture_2_name};
}

sub texture_3_name {
    my ($self) = @_;
    return $self->{texture_3_name};
}

sub indices_count_array_offset {
    my ($self) = @_;
    return $self->{indices_count_array_offset};
}

sub indices_count_array_count {
    my ($self) = @_;
    return $self->{indices_count_array_count};
}

sub indices_count_array_count_duplicate {
    my ($self) = @_;
    return $self->{indices_count_array_count_duplicate};
}

sub indices_offset_array_offset {
    my ($self) = @_;
    return $self->{indices_offset_array_offset};
}

sub indices_offset_array_count {
    my ($self) = @_;
    return $self->{indices_offset_array_count};
}

sub indices_offset_array_count_duplicate {
    my ($self) = @_;
    return $self->{indices_offset_array_count_duplicate};
}

sub inverted_counter_array_offset {
    my ($self) = @_;
    return $self->{inverted_counter_array_offset};
}

sub inverted_counter_array_count {
    my ($self) = @_;
    return $self->{inverted_counter_array_count};
}

sub inverted_counter_array_count_duplicate {
    my ($self) = @_;
    return $self->{inverted_counter_array_count_duplicate};
}

sub unknown_values {
    my ($self) = @_;
    return $self->{unknown_values};
}

sub saber_unknown_data {
    my ($self) = @_;
    return $self->{saber_unknown_data};
}

sub unknown {
    my ($self) = @_;
    return $self->{unknown};
}

sub uv_direction {
    my ($self) = @_;
    return $self->{uv_direction};
}

sub uv_jitter {
    my ($self) = @_;
    return $self->{uv_jitter};
}

sub uv_jitter_speed {
    my ($self) = @_;
    return $self->{uv_jitter_speed};
}

sub mdx_vertex_size {
    my ($self) = @_;
    return $self->{mdx_vertex_size};
}

sub mdx_data_flags {
    my ($self) = @_;
    return $self->{mdx_data_flags};
}

sub mdx_vertices_offset {
    my ($self) = @_;
    return $self->{mdx_vertices_offset};
}

sub mdx_normals_offset {
    my ($self) = @_;
    return $self->{mdx_normals_offset};
}

sub mdx_vertex_colors_offset {
    my ($self) = @_;
    return $self->{mdx_vertex_colors_offset};
}

sub mdx_tex0_uvs_offset {
    my ($self) = @_;
    return $self->{mdx_tex0_uvs_offset};
}

sub mdx_tex1_uvs_offset {
    my ($self) = @_;
    return $self->{mdx_tex1_uvs_offset};
}

sub mdx_tex2_uvs_offset {
    my ($self) = @_;
    return $self->{mdx_tex2_uvs_offset};
}

sub mdx_tex3_uvs_offset {
    my ($self) = @_;
    return $self->{mdx_tex3_uvs_offset};
}

sub mdx_tangent_space_offset {
    my ($self) = @_;
    return $self->{mdx_tangent_space_offset};
}

sub mdx_unknown_offset_1 {
    my ($self) = @_;
    return $self->{mdx_unknown_offset_1};
}

sub mdx_unknown_offset_2 {
    my ($self) = @_;
    return $self->{mdx_unknown_offset_2};
}

sub mdx_unknown_offset_3 {
    my ($self) = @_;
    return $self->{mdx_unknown_offset_3};
}

sub vertex_count {
    my ($self) = @_;
    return $self->{vertex_count};
}

sub texture_count {
    my ($self) = @_;
    return $self->{texture_count};
}

sub lightmapped {
    my ($self) = @_;
    return $self->{lightmapped};
}

sub rotate_texture {
    my ($self) = @_;
    return $self->{rotate_texture};
}

sub background_geometry {
    my ($self) = @_;
    return $self->{background_geometry};
}

sub shadow {
    my ($self) = @_;
    return $self->{shadow};
}

sub beaming {
    my ($self) = @_;
    return $self->{beaming};
}

sub render {
    my ($self) = @_;
    return $self->{render};
}

sub unknown_flag {
    my ($self) = @_;
    return $self->{unknown_flag};
}

sub padding {
    my ($self) = @_;
    return $self->{padding};
}

sub total_area {
    my ($self) = @_;
    return $self->{total_area};
}

sub unknown2 {
    my ($self) = @_;
    return $self->{unknown2};
}

sub k2_unknown_1 {
    my ($self) = @_;
    return $self->{k2_unknown_1};
}

sub k2_unknown_2 {
    my ($self) = @_;
    return $self->{k2_unknown_2};
}

sub mdx_data_offset {
    my ($self) = @_;
    return $self->{mdx_data_offset};
}

sub mdl_vertices_offset {
    my ($self) = @_;
    return $self->{mdl_vertices_offset};
}

########################################################################
package Mdl::Vec3f;

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

1;
