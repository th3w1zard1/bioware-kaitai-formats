# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use Encode;

########################################################################
package BiowareExtractCommon;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

our $BIOWARE_SEARCH_LOCATION_ID_OVERRIDE = 0;
our $BIOWARE_SEARCH_LOCATION_ID_MODULES = 1;
our $BIOWARE_SEARCH_LOCATION_ID_CHITIN = 2;
our $BIOWARE_SEARCH_LOCATION_ID_TEXTURES_TPA = 3;
our $BIOWARE_SEARCH_LOCATION_ID_TEXTURES_TPB = 4;
our $BIOWARE_SEARCH_LOCATION_ID_TEXTURES_TPC = 5;
our $BIOWARE_SEARCH_LOCATION_ID_TEXTURES_GUI = 6;
our $BIOWARE_SEARCH_LOCATION_ID_MUSIC = 7;
our $BIOWARE_SEARCH_LOCATION_ID_SOUND = 8;
our $BIOWARE_SEARCH_LOCATION_ID_VOICE = 9;
our $BIOWARE_SEARCH_LOCATION_ID_LIPS = 10;
our $BIOWARE_SEARCH_LOCATION_ID_RIMS = 11;
our $BIOWARE_SEARCH_LOCATION_ID_CUSTOM_MODULES = 12;
our $BIOWARE_SEARCH_LOCATION_ID_CUSTOM_FOLDERS = 13;

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

########################################################################
package BiowareExtractCommon::BiowareTexturePackNameStr;

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

    $self->{value} = Encode::decode("ASCII", $self->{_io}->read_bytes_term(0, 0, 1, 1));
}

sub value {
    my ($self) = @_;
    return $self->{value};
}

1;
