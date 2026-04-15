# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use Encode;

########################################################################
package Bzf;

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

    $self->{file_type} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{version} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{compressed_data} = $self->{_io}->read_bytes_full();
}

sub file_type {
    my ($self) = @_;
    return $self->{file_type};
}

sub version {
    my ($self) = @_;
    return $self->{version};
}

sub compressed_data {
    my ($self) = @_;
    return $self->{compressed_data};
}

1;
