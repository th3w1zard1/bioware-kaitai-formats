# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareCommon;
use Encode;

########################################################################
package Dds;

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

    $self->{magic} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    if ($self->magic() eq "DDS ") {
        $self->{header} = Dds::DdsHeader->new($self->{_io}, $self, $self->{_root});
    }
    if ($self->magic() ne "DDS ") {
        $self->{bioware_header} = Dds::BiowareDdsHeader->new($self->{_io}, $self, $self->{_root});
    }
    $self->{pixel_data} = $self->{_io}->read_bytes_full();
}

sub magic {
    my ($self) = @_;
    return $self->{magic};
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

sub bioware_header {
    my ($self) = @_;
    return $self->{bioware_header};
}

sub pixel_data {
    my ($self) = @_;
    return $self->{pixel_data};
}

########################################################################
package Dds::BiowareDdsHeader;

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

    $self->{width} = $self->{_io}->read_u4le();
    $self->{height} = $self->{_io}->read_u4le();
    $self->{bytes_per_pixel} = $self->{_io}->read_u4le();
    $self->{data_size} = $self->{_io}->read_u4le();
    $self->{unused_float} = $self->{_io}->read_f4le();
}

sub width {
    my ($self) = @_;
    return $self->{width};
}

sub height {
    my ($self) = @_;
    return $self->{height};
}

sub bytes_per_pixel {
    my ($self) = @_;
    return $self->{bytes_per_pixel};
}

sub data_size {
    my ($self) = @_;
    return $self->{data_size};
}

sub unused_float {
    my ($self) = @_;
    return $self->{unused_float};
}

########################################################################
package Dds::Ddpixelformat;

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

    $self->{size} = $self->{_io}->read_u4le();
    $self->{flags} = $self->{_io}->read_u4le();
    $self->{fourcc} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{rgb_bit_count} = $self->{_io}->read_u4le();
    $self->{r_bit_mask} = $self->{_io}->read_u4le();
    $self->{g_bit_mask} = $self->{_io}->read_u4le();
    $self->{b_bit_mask} = $self->{_io}->read_u4le();
    $self->{a_bit_mask} = $self->{_io}->read_u4le();
}

sub size {
    my ($self) = @_;
    return $self->{size};
}

sub flags {
    my ($self) = @_;
    return $self->{flags};
}

sub fourcc {
    my ($self) = @_;
    return $self->{fourcc};
}

sub rgb_bit_count {
    my ($self) = @_;
    return $self->{rgb_bit_count};
}

sub r_bit_mask {
    my ($self) = @_;
    return $self->{r_bit_mask};
}

sub g_bit_mask {
    my ($self) = @_;
    return $self->{g_bit_mask};
}

sub b_bit_mask {
    my ($self) = @_;
    return $self->{b_bit_mask};
}

sub a_bit_mask {
    my ($self) = @_;
    return $self->{a_bit_mask};
}

########################################################################
package Dds::DdsHeader;

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

    $self->{size} = $self->{_io}->read_u4le();
    $self->{flags} = $self->{_io}->read_u4le();
    $self->{height} = $self->{_io}->read_u4le();
    $self->{width} = $self->{_io}->read_u4le();
    $self->{pitch_or_linear_size} = $self->{_io}->read_u4le();
    $self->{depth} = $self->{_io}->read_u4le();
    $self->{mipmap_count} = $self->{_io}->read_u4le();
    $self->{reserved1} = [];
    my $n_reserved1 = 11;
    for (my $i = 0; $i < $n_reserved1; $i++) {
        push @{$self->{reserved1}}, $self->{_io}->read_u4le();
    }
    $self->{pixel_format} = Dds::Ddpixelformat->new($self->{_io}, $self, $self->{_root});
    $self->{caps} = $self->{_io}->read_u4le();
    $self->{caps2} = $self->{_io}->read_u4le();
    $self->{caps3} = $self->{_io}->read_u4le();
    $self->{caps4} = $self->{_io}->read_u4le();
    $self->{reserved2} = $self->{_io}->read_u4le();
}

sub size {
    my ($self) = @_;
    return $self->{size};
}

sub flags {
    my ($self) = @_;
    return $self->{flags};
}

sub height {
    my ($self) = @_;
    return $self->{height};
}

sub width {
    my ($self) = @_;
    return $self->{width};
}

sub pitch_or_linear_size {
    my ($self) = @_;
    return $self->{pitch_or_linear_size};
}

sub depth {
    my ($self) = @_;
    return $self->{depth};
}

sub mipmap_count {
    my ($self) = @_;
    return $self->{mipmap_count};
}

sub reserved1 {
    my ($self) = @_;
    return $self->{reserved1};
}

sub pixel_format {
    my ($self) = @_;
    return $self->{pixel_format};
}

sub caps {
    my ($self) = @_;
    return $self->{caps};
}

sub caps2 {
    my ($self) = @_;
    return $self->{caps2};
}

sub caps3 {
    my ($self) = @_;
    return $self->{caps3};
}

sub caps4 {
    my ($self) = @_;
    return $self->{caps4};
}

sub reserved2 {
    my ($self) = @_;
    return $self->{reserved2};
}

1;
