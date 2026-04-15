# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareCommon;
use Encode;

########################################################################
package Lip;

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
    $self->{file_version} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{length} = $self->{_io}->read_f4le();
    $self->{num_keyframes} = $self->{_io}->read_u4le();
    $self->{keyframes} = [];
    my $n_keyframes = $self->num_keyframes();
    for (my $i = 0; $i < $n_keyframes; $i++) {
        push @{$self->{keyframes}}, Lip::KeyframeEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub file_type {
    my ($self) = @_;
    return $self->{file_type};
}

sub file_version {
    my ($self) = @_;
    return $self->{file_version};
}

sub length {
    my ($self) = @_;
    return $self->{length};
}

sub num_keyframes {
    my ($self) = @_;
    return $self->{num_keyframes};
}

sub keyframes {
    my ($self) = @_;
    return $self->{keyframes};
}

########################################################################
package Lip::KeyframeEntry;

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

    $self->{timestamp} = $self->{_io}->read_f4le();
    $self->{shape} = $self->{_io}->read_u1();
}

sub timestamp {
    my ($self) = @_;
    return $self->{timestamp};
}

sub shape {
    my ($self) = @_;
    return $self->{shape};
}

1;
