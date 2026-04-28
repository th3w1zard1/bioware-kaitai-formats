# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareCommon;

########################################################################
package Tpc;

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

    $self->{header} = Tpc::TpcHeader->new($self->{_io}, $self, $self->{_root});
    $self->{body} = $self->{_io}->read_bytes_full();
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

sub body {
    my ($self) = @_;
    return $self->{body};
}

########################################################################
package Tpc::TpcHeader;

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

    $self->{data_size} = $self->{_io}->read_u4le();
    $self->{alpha_test} = $self->{_io}->read_f4le();
    $self->{width} = $self->{_io}->read_u2le();
    $self->{height} = $self->{_io}->read_u2le();
    $self->{pixel_encoding} = $self->{_io}->read_u1();
    $self->{mipmap_count} = $self->{_io}->read_u1();
    $self->{reserved} = [];
    my $n_reserved = 114;
    for (my $i = 0; $i < $n_reserved; $i++) {
        push @{$self->{reserved}}, $self->{_io}->read_u1();
    }
}

sub is_compressed {
    my ($self) = @_;
    return $self->{is_compressed} if ($self->{is_compressed});
    $self->{is_compressed} = $self->data_size() != 0;
    return $self->{is_compressed};
}

sub is_uncompressed {
    my ($self) = @_;
    return $self->{is_uncompressed} if ($self->{is_uncompressed});
    $self->{is_uncompressed} = $self->data_size() == 0;
    return $self->{is_uncompressed};
}

sub data_size {
    my ($self) = @_;
    return $self->{data_size};
}

sub alpha_test {
    my ($self) = @_;
    return $self->{alpha_test};
}

sub width {
    my ($self) = @_;
    return $self->{width};
}

sub height {
    my ($self) = @_;
    return $self->{height};
}

sub pixel_encoding {
    my ($self) = @_;
    return $self->{pixel_encoding};
}

sub mipmap_count {
    my ($self) = @_;
    return $self->{mipmap_count};
}

sub reserved {
    my ($self) = @_;
    return $self->{reserved};
}

1;
