# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use TgaCommon;
use Encode;

########################################################################
package Tga;

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

    $self->{id_length} = $self->{_io}->read_u1();
    $self->{color_map_type} = $self->{_io}->read_u1();
    $self->{image_type} = $self->{_io}->read_u1();
    if ($self->color_map_type() == $TgaCommon::TGA_COLOR_MAP_TYPE_PRESENT) {
        $self->{color_map_spec} = Tga::ColorMapSpecification->new($self->{_io}, $self, $self->{_root});
    }
    $self->{image_spec} = Tga::ImageSpecification->new($self->{_io}, $self, $self->{_root});
    if ($self->id_length() > 0) {
        $self->{image_id} = Encode::decode("ASCII", $self->{_io}->read_bytes($self->id_length()));
    }
    if ($self->color_map_type() == $TgaCommon::TGA_COLOR_MAP_TYPE_PRESENT) {
        $self->{color_map_data} = [];
        my $n_color_map_data = $self->color_map_spec()->length();
        for (my $i = 0; $i < $n_color_map_data; $i++) {
            push @{$self->{color_map_data}}, $self->{_io}->read_u1();
        }
    }
    $self->{image_data} = [];
    while (!$self->{_io}->is_eof()) {
        push @{$self->{image_data}}, $self->{_io}->read_u1();
    }
}

sub id_length {
    my ($self) = @_;
    return $self->{id_length};
}

sub color_map_type {
    my ($self) = @_;
    return $self->{color_map_type};
}

sub image_type {
    my ($self) = @_;
    return $self->{image_type};
}

sub color_map_spec {
    my ($self) = @_;
    return $self->{color_map_spec};
}

sub image_spec {
    my ($self) = @_;
    return $self->{image_spec};
}

sub image_id {
    my ($self) = @_;
    return $self->{image_id};
}

sub color_map_data {
    my ($self) = @_;
    return $self->{color_map_data};
}

sub image_data {
    my ($self) = @_;
    return $self->{image_data};
}

########################################################################
package Tga::ColorMapSpecification;

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

    $self->{first_entry_index} = $self->{_io}->read_u2le();
    $self->{length} = $self->{_io}->read_u2le();
    $self->{entry_size} = $self->{_io}->read_u1();
}

sub first_entry_index {
    my ($self) = @_;
    return $self->{first_entry_index};
}

sub length {
    my ($self) = @_;
    return $self->{length};
}

sub entry_size {
    my ($self) = @_;
    return $self->{entry_size};
}

########################################################################
package Tga::ImageSpecification;

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

    $self->{x_origin} = $self->{_io}->read_u2le();
    $self->{y_origin} = $self->{_io}->read_u2le();
    $self->{width} = $self->{_io}->read_u2le();
    $self->{height} = $self->{_io}->read_u2le();
    $self->{pixel_depth} = $self->{_io}->read_u1();
    $self->{image_descriptor} = $self->{_io}->read_u1();
}

sub x_origin {
    my ($self) = @_;
    return $self->{x_origin};
}

sub y_origin {
    my ($self) = @_;
    return $self->{y_origin};
}

sub width {
    my ($self) = @_;
    return $self->{width};
}

sub height {
    my ($self) = @_;
    return $self->{height};
}

sub pixel_depth {
    my ($self) = @_;
    return $self->{pixel_depth};
}

sub image_descriptor {
    my ($self) = @_;
    return $self->{image_descriptor};
}

1;
