# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;

########################################################################
package TgaCommon;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

our $TGA_COLOR_MAP_TYPE_NONE = 0;
our $TGA_COLOR_MAP_TYPE_PRESENT = 1;

our $TGA_IMAGE_TYPE_NO_IMAGE_DATA = 0;
our $TGA_IMAGE_TYPE_UNCOMPRESSED_COLOR_MAPPED = 1;
our $TGA_IMAGE_TYPE_UNCOMPRESSED_RGB = 2;
our $TGA_IMAGE_TYPE_UNCOMPRESSED_GREYSCALE = 3;
our $TGA_IMAGE_TYPE_RLE_COLOR_MAPPED = 9;
our $TGA_IMAGE_TYPE_RLE_RGB = 10;
our $TGA_IMAGE_TYPE_RLE_GREYSCALE = 11;

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
