# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;

########################################################################
package BiowareGffCommon;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

our $GFF_FIELD_TYPE_UINT8 = 0;
our $GFF_FIELD_TYPE_INT8 = 1;
our $GFF_FIELD_TYPE_UINT16 = 2;
our $GFF_FIELD_TYPE_INT16 = 3;
our $GFF_FIELD_TYPE_UINT32 = 4;
our $GFF_FIELD_TYPE_INT32 = 5;
our $GFF_FIELD_TYPE_UINT64 = 6;
our $GFF_FIELD_TYPE_INT64 = 7;
our $GFF_FIELD_TYPE_SINGLE = 8;
our $GFF_FIELD_TYPE_DOUBLE = 9;
our $GFF_FIELD_TYPE_STRING = 10;
our $GFF_FIELD_TYPE_RESREF = 11;
our $GFF_FIELD_TYPE_LOCALIZED_STRING = 12;
our $GFF_FIELD_TYPE_BINARY = 13;
our $GFF_FIELD_TYPE_STRUCT = 14;
our $GFF_FIELD_TYPE_LIST = 15;
our $GFF_FIELD_TYPE_VECTOR4 = 16;
our $GFF_FIELD_TYPE_VECTOR3 = 17;
our $GFF_FIELD_TYPE_STR_REF = 18;

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

}

1;
