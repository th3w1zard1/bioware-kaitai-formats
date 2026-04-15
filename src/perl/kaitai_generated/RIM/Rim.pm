# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareTypeIds;
use Encode;

########################################################################
package Rim;

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

    $self->{header} = Rim::RimHeader->new($self->{_io}, $self, $self->{_root});
    if ($self->header()->offset_to_resource_table() == 0) {
        $self->{gap_before_key_table_implicit} = $self->{_io}->read_bytes(96);
    }
    if ($self->header()->offset_to_resource_table() != 0) {
        $self->{gap_before_key_table_explicit} = $self->{_io}->read_bytes($self->header()->offset_to_resource_table() - 24);
    }
    if ($self->header()->resource_count() > 0) {
        $self->{resource_entry_table} = Rim::ResourceEntryTable->new($self->{_io}, $self, $self->{_root});
    }
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

sub gap_before_key_table_implicit {
    my ($self) = @_;
    return $self->{gap_before_key_table_implicit};
}

sub gap_before_key_table_explicit {
    my ($self) = @_;
    return $self->{gap_before_key_table_explicit};
}

sub resource_entry_table {
    my ($self) = @_;
    return $self->{resource_entry_table};
}

########################################################################
package Rim::ResourceEntry;

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

    $self->{resref} = Encode::decode("ASCII", $self->{_io}->read_bytes(16));
    $self->{resource_type} = $self->{_io}->read_u4le();
    $self->{resource_id} = $self->{_io}->read_u4le();
    $self->{offset_to_data} = $self->{_io}->read_u4le();
    $self->{num_data} = $self->{_io}->read_u4le();
}

sub data {
    my ($self) = @_;
    return $self->{data} if ($self->{data});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->offset_to_data());
    $self->{data} = [];
    my $n_data = $self->num_data();
    for (my $i = 0; $i < $n_data; $i++) {
        push @{$self->{data}}, $self->{_io}->read_u1();
    }
    $self->{_io}->seek($_pos);
    return $self->{data};
}

sub resref {
    my ($self) = @_;
    return $self->{resref};
}

sub resource_type {
    my ($self) = @_;
    return $self->{resource_type};
}

sub resource_id {
    my ($self) = @_;
    return $self->{resource_id};
}

sub offset_to_data {
    my ($self) = @_;
    return $self->{offset_to_data};
}

sub num_data {
    my ($self) = @_;
    return $self->{num_data};
}

########################################################################
package Rim::ResourceEntryTable;

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
    my $n_entries = $self->_root()->header()->resource_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Rim::ResourceEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

########################################################################
package Rim::RimHeader;

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

    $self->{file_type} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{file_version} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{reserved} = $self->{_io}->read_u4le();
    $self->{resource_count} = $self->{_io}->read_u4le();
    $self->{offset_to_resource_table} = $self->{_io}->read_u4le();
    $self->{offset_to_resources} = $self->{_io}->read_u4le();
}

sub has_resources {
    my ($self) = @_;
    return $self->{has_resources} if ($self->{has_resources});
    $self->{has_resources} = $self->resource_count() > 0;
    return $self->{has_resources};
}

sub file_type {
    my ($self) = @_;
    return $self->{file_type};
}

sub file_version {
    my ($self) = @_;
    return $self->{file_version};
}

sub reserved {
    my ($self) = @_;
    return $self->{reserved};
}

sub resource_count {
    my ($self) = @_;
    return $self->{resource_count};
}

sub offset_to_resource_table {
    my ($self) = @_;
    return $self->{offset_to_resource_table};
}

sub offset_to_resources {
    my ($self) = @_;
    return $self->{offset_to_resources};
}

1;
