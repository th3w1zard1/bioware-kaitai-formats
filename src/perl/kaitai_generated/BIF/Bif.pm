# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareTypeIds;
use Encode;

########################################################################
package Bif;

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
    $self->{var_res_count} = $self->{_io}->read_u4le();
    $self->{fixed_res_count} = $self->{_io}->read_u4le();
    $self->{var_table_offset} = $self->{_io}->read_u4le();
}

sub var_resource_table {
    my ($self) = @_;
    return $self->{var_resource_table} if ($self->{var_resource_table});
    if ($self->var_res_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->var_table_offset());
        $self->{var_resource_table} = Bif::VarResourceTable->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{var_resource_table};
}

sub file_type {
    my ($self) = @_;
    return $self->{file_type};
}

sub version {
    my ($self) = @_;
    return $self->{version};
}

sub var_res_count {
    my ($self) = @_;
    return $self->{var_res_count};
}

sub fixed_res_count {
    my ($self) = @_;
    return $self->{fixed_res_count};
}

sub var_table_offset {
    my ($self) = @_;
    return $self->{var_table_offset};
}

########################################################################
package Bif::VarResourceEntry;

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

    $self->{resource_id} = $self->{_io}->read_u4le();
    $self->{offset} = $self->{_io}->read_u4le();
    $self->{file_size} = $self->{_io}->read_u4le();
    $self->{resource_type} = $self->{_io}->read_u4le();
}

sub resource_id {
    my ($self) = @_;
    return $self->{resource_id};
}

sub offset {
    my ($self) = @_;
    return $self->{offset};
}

sub file_size {
    my ($self) = @_;
    return $self->{file_size};
}

sub resource_type {
    my ($self) = @_;
    return $self->{resource_type};
}

########################################################################
package Bif::VarResourceTable;

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

    $self->{entries} = [];
    my $n_entries = $self->_root()->var_res_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Bif::VarResourceEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

1;
