# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareTypeIds;
use Encode;

########################################################################
package Erf;

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

    $self->{header} = Erf::ErfHeader->new($self->{_io}, $self, $self->{_root});
}

sub key_list {
    my ($self) = @_;
    return $self->{key_list} if ($self->{key_list});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->header()->offset_to_key_list());
    $self->{key_list} = Erf::KeyList->new($self->{_io}, $self, $self->{_root});
    $self->{_io}->seek($_pos);
    return $self->{key_list};
}

sub localized_string_list {
    my ($self) = @_;
    return $self->{localized_string_list} if ($self->{localized_string_list});
    if ($self->header()->language_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->offset_to_localized_string_list());
        $self->{localized_string_list} = Erf::LocalizedStringList->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{localized_string_list};
}

sub resource_list {
    my ($self) = @_;
    return $self->{resource_list} if ($self->{resource_list});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->header()->offset_to_resource_list());
    $self->{resource_list} = Erf::ResourceList->new($self->{_io}, $self, $self->{_root});
    $self->{_io}->seek($_pos);
    return $self->{resource_list};
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

########################################################################
package Erf::ErfHeader;

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
    $self->{language_count} = $self->{_io}->read_u4le();
    $self->{localized_string_size} = $self->{_io}->read_u4le();
    $self->{entry_count} = $self->{_io}->read_u4le();
    $self->{offset_to_localized_string_list} = $self->{_io}->read_u4le();
    $self->{offset_to_key_list} = $self->{_io}->read_u4le();
    $self->{offset_to_resource_list} = $self->{_io}->read_u4le();
    $self->{build_year} = $self->{_io}->read_u4le();
    $self->{build_day} = $self->{_io}->read_u4le();
    $self->{description_strref} = $self->{_io}->read_s4le();
    $self->{reserved} = $self->{_io}->read_bytes(116);
}

sub is_save_file {
    my ($self) = @_;
    return $self->{is_save_file} if ($self->{is_save_file});
    $self->{is_save_file} =  (($self->file_type() eq "MOD ") && ($self->description_strref() == 0)) ;
    return $self->{is_save_file};
}

sub file_type {
    my ($self) = @_;
    return $self->{file_type};
}

sub file_version {
    my ($self) = @_;
    return $self->{file_version};
}

sub language_count {
    my ($self) = @_;
    return $self->{language_count};
}

sub localized_string_size {
    my ($self) = @_;
    return $self->{localized_string_size};
}

sub entry_count {
    my ($self) = @_;
    return $self->{entry_count};
}

sub offset_to_localized_string_list {
    my ($self) = @_;
    return $self->{offset_to_localized_string_list};
}

sub offset_to_key_list {
    my ($self) = @_;
    return $self->{offset_to_key_list};
}

sub offset_to_resource_list {
    my ($self) = @_;
    return $self->{offset_to_resource_list};
}

sub build_year {
    my ($self) = @_;
    return $self->{build_year};
}

sub build_day {
    my ($self) = @_;
    return $self->{build_day};
}

sub description_strref {
    my ($self) = @_;
    return $self->{description_strref};
}

sub reserved {
    my ($self) = @_;
    return $self->{reserved};
}

########################################################################
package Erf::KeyEntry;

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
    $self->{resource_id} = $self->{_io}->read_u4le();
    $self->{resource_type} = $self->{_io}->read_u2le();
    $self->{unused} = $self->{_io}->read_u2le();
}

sub resref {
    my ($self) = @_;
    return $self->{resref};
}

sub resource_id {
    my ($self) = @_;
    return $self->{resource_id};
}

sub resource_type {
    my ($self) = @_;
    return $self->{resource_type};
}

sub unused {
    my ($self) = @_;
    return $self->{unused};
}

########################################################################
package Erf::KeyList;

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
    my $n_entries = $self->_root()->header()->entry_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Erf::KeyEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

########################################################################
package Erf::LocalizedStringEntry;

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

    $self->{language_id} = $self->{_io}->read_u4le();
    $self->{string_size} = $self->{_io}->read_u4le();
    $self->{string_data} = Encode::decode("UTF-8", $self->{_io}->read_bytes($self->string_size()));
}

sub language_id {
    my ($self) = @_;
    return $self->{language_id};
}

sub string_size {
    my ($self) = @_;
    return $self->{string_size};
}

sub string_data {
    my ($self) = @_;
    return $self->{string_data};
}

########################################################################
package Erf::LocalizedStringList;

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
    my $n_entries = $self->_root()->header()->language_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Erf::LocalizedStringEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

########################################################################
package Erf::ResourceEntry;

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

    $self->{offset_to_data} = $self->{_io}->read_u4le();
    $self->{len_data} = $self->{_io}->read_u4le();
}

sub data {
    my ($self) = @_;
    return $self->{data} if ($self->{data});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->offset_to_data());
    $self->{data} = $self->{_io}->read_bytes($self->len_data());
    $self->{_io}->seek($_pos);
    return $self->{data};
}

sub offset_to_data {
    my ($self) = @_;
    return $self->{offset_to_data};
}

sub len_data {
    my ($self) = @_;
    return $self->{len_data};
}

########################################################################
package Erf::ResourceList;

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
    my $n_entries = $self->_root()->header()->entry_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Erf::ResourceEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

1;
