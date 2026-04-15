# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareTypeIds;
use Encode;

########################################################################
package Key;

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
    $self->{bif_count} = $self->{_io}->read_u4le();
    $self->{key_count} = $self->{_io}->read_u4le();
    $self->{file_table_offset} = $self->{_io}->read_u4le();
    $self->{key_table_offset} = $self->{_io}->read_u4le();
    $self->{build_year} = $self->{_io}->read_u4le();
    $self->{build_day} = $self->{_io}->read_u4le();
    $self->{reserved} = $self->{_io}->read_bytes(32);
}

sub file_table {
    my ($self) = @_;
    return $self->{file_table} if ($self->{file_table});
    if ($self->bif_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->file_table_offset());
        $self->{file_table} = Key::FileTable->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{file_table};
}

sub key_table {
    my ($self) = @_;
    return $self->{key_table} if ($self->{key_table});
    if ($self->key_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->key_table_offset());
        $self->{key_table} = Key::KeyTable->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{key_table};
}

sub file_type {
    my ($self) = @_;
    return $self->{file_type};
}

sub file_version {
    my ($self) = @_;
    return $self->{file_version};
}

sub bif_count {
    my ($self) = @_;
    return $self->{bif_count};
}

sub key_count {
    my ($self) = @_;
    return $self->{key_count};
}

sub file_table_offset {
    my ($self) = @_;
    return $self->{file_table_offset};
}

sub key_table_offset {
    my ($self) = @_;
    return $self->{key_table_offset};
}

sub build_year {
    my ($self) = @_;
    return $self->{build_year};
}

sub build_day {
    my ($self) = @_;
    return $self->{build_day};
}

sub reserved {
    my ($self) = @_;
    return $self->{reserved};
}

########################################################################
package Key::FileEntry;

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

    $self->{file_size} = $self->{_io}->read_u4le();
    $self->{filename_offset} = $self->{_io}->read_u4le();
    $self->{filename_size} = $self->{_io}->read_u2le();
    $self->{drives} = $self->{_io}->read_u2le();
}

sub filename {
    my ($self) = @_;
    return $self->{filename} if ($self->{filename});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->filename_offset());
    $self->{filename} = Encode::decode("ASCII", $self->{_io}->read_bytes($self->filename_size()));
    $self->{_io}->seek($_pos);
    return $self->{filename};
}

sub file_size {
    my ($self) = @_;
    return $self->{file_size};
}

sub filename_offset {
    my ($self) = @_;
    return $self->{filename_offset};
}

sub filename_size {
    my ($self) = @_;
    return $self->{filename_size};
}

sub drives {
    my ($self) = @_;
    return $self->{drives};
}

########################################################################
package Key::FileTable;

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
    my $n_entries = $self->_root()->bif_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Key::FileEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

########################################################################
package Key::FilenameTable;

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

    $self->{filenames} = Encode::decode("ASCII", $self->{_io}->read_bytes_full());
}

sub filenames {
    my ($self) = @_;
    return $self->{filenames};
}

########################################################################
package Key::KeyEntry;

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
    $self->{resource_type} = $self->{_io}->read_u2le();
    $self->{resource_id} = $self->{_io}->read_u4le();
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

########################################################################
package Key::KeyTable;

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
    my $n_entries = $self->_root()->key_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Key::KeyEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

1;
