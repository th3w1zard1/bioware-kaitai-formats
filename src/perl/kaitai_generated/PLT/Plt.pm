# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use Encode;

########################################################################
package Plt;

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

    $self->{header} = Plt::PltHeader->new($self->{_io}, $self, $self->{_root});
    $self->{pixel_data} = Plt::PixelDataSection->new($self->{_io}, $self, $self->{_root});
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

sub pixel_data {
    my ($self) = @_;
    return $self->{pixel_data};
}

########################################################################
package Plt::PixelDataSection;

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

    $self->{pixels} = [];
    my $n_pixels = $self->_root()->header()->width() * $self->_root()->header()->height();
    for (my $i = 0; $i < $n_pixels; $i++) {
        push @{$self->{pixels}}, Plt::PltPixel->new($self->{_io}, $self, $self->{_root});
    }
}

sub pixels {
    my ($self) = @_;
    return $self->{pixels};
}

########################################################################
package Plt::PltHeader;

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

    $self->{signature} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{version} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{unknown1} = $self->{_io}->read_u4le();
    $self->{unknown2} = $self->{_io}->read_u4le();
    $self->{width} = $self->{_io}->read_u4le();
    $self->{height} = $self->{_io}->read_u4le();
}

sub signature {
    my ($self) = @_;
    return $self->{signature};
}

sub version {
    my ($self) = @_;
    return $self->{version};
}

sub unknown1 {
    my ($self) = @_;
    return $self->{unknown1};
}

sub unknown2 {
    my ($self) = @_;
    return $self->{unknown2};
}

sub width {
    my ($self) = @_;
    return $self->{width};
}

sub height {
    my ($self) = @_;
    return $self->{height};
}

########################################################################
package Plt::PltPixel;

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

    $self->{color_index} = $self->{_io}->read_u1();
    $self->{palette_group_index} = $self->{_io}->read_u1();
}

sub color_index {
    my ($self) = @_;
    return $self->{color_index};
}

sub palette_group_index {
    my ($self) = @_;
    return $self->{palette_group_index};
}

1;
