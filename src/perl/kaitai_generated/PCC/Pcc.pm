# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareCommon;
use Encode;

########################################################################
package Pcc;

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

    $self->{header} = Pcc::FileHeader->new($self->{_io}, $self, $self->{_root});
}

sub compression_type {
    my ($self) = @_;
    return $self->{compression_type} if ($self->{compression_type});
    $self->{compression_type} = $self->header()->compression_type();
    return $self->{compression_type};
}

sub export_table {
    my ($self) = @_;
    return $self->{export_table} if ($self->{export_table});
    if ($self->header()->export_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->export_table_offset());
        $self->{export_table} = Pcc::ExportTable->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{export_table};
}

sub import_table {
    my ($self) = @_;
    return $self->{import_table} if ($self->{import_table});
    if ($self->header()->import_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->import_table_offset());
        $self->{import_table} = Pcc::ImportTable->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{import_table};
}

sub is_compressed {
    my ($self) = @_;
    return $self->{is_compressed} if ($self->{is_compressed});
    $self->{is_compressed} = ($self->header()->package_flags() & 33554432) != 0;
    return $self->{is_compressed};
}

sub name_table {
    my ($self) = @_;
    return $self->{name_table} if ($self->{name_table});
    if ($self->header()->name_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->name_table_offset());
        $self->{name_table} = Pcc::NameTable->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{name_table};
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

########################################################################
package Pcc::ExportEntry;

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

    $self->{class_index} = $self->{_io}->read_s4le();
    $self->{super_class_index} = $self->{_io}->read_s4le();
    $self->{link} = $self->{_io}->read_s4le();
    $self->{object_name_index} = $self->{_io}->read_s4le();
    $self->{object_name_number} = $self->{_io}->read_s4le();
    $self->{archetype_index} = $self->{_io}->read_s4le();
    $self->{object_flags} = $self->{_io}->read_u8le();
    $self->{data_size} = $self->{_io}->read_u4le();
    $self->{data_offset} = $self->{_io}->read_u4le();
    $self->{unknown1} = $self->{_io}->read_u4le();
    $self->{num_components} = $self->{_io}->read_s4le();
    $self->{unknown2} = $self->{_io}->read_u4le();
    $self->{guid} = Pcc::Guid->new($self->{_io}, $self, $self->{_root});
    if ($self->num_components() > 0) {
        $self->{components} = [];
        my $n_components = $self->num_components();
        for (my $i = 0; $i < $n_components; $i++) {
            push @{$self->{components}}, $self->{_io}->read_s4le();
        }
    }
}

sub class_index {
    my ($self) = @_;
    return $self->{class_index};
}

sub super_class_index {
    my ($self) = @_;
    return $self->{super_class_index};
}

sub link {
    my ($self) = @_;
    return $self->{link};
}

sub object_name_index {
    my ($self) = @_;
    return $self->{object_name_index};
}

sub object_name_number {
    my ($self) = @_;
    return $self->{object_name_number};
}

sub archetype_index {
    my ($self) = @_;
    return $self->{archetype_index};
}

sub object_flags {
    my ($self) = @_;
    return $self->{object_flags};
}

sub data_size {
    my ($self) = @_;
    return $self->{data_size};
}

sub data_offset {
    my ($self) = @_;
    return $self->{data_offset};
}

sub unknown1 {
    my ($self) = @_;
    return $self->{unknown1};
}

sub num_components {
    my ($self) = @_;
    return $self->{num_components};
}

sub unknown2 {
    my ($self) = @_;
    return $self->{unknown2};
}

sub guid {
    my ($self) = @_;
    return $self->{guid};
}

sub components {
    my ($self) = @_;
    return $self->{components};
}

########################################################################
package Pcc::ExportTable;

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
    my $n_entries = $self->_root()->header()->export_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Pcc::ExportEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

########################################################################
package Pcc::FileHeader;

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

    $self->{magic} = $self->{_io}->read_u4le();
    $self->{version} = $self->{_io}->read_u4le();
    $self->{licensee_version} = $self->{_io}->read_u4le();
    $self->{header_size} = $self->{_io}->read_s4le();
    $self->{package_name} = Encode::decode("UTF-16LE", $self->{_io}->read_bytes(10));
    $self->{package_flags} = $self->{_io}->read_u4le();
    $self->{package_type} = $self->{_io}->read_u4le();
    $self->{name_count} = $self->{_io}->read_u4le();
    $self->{name_table_offset} = $self->{_io}->read_u4le();
    $self->{export_count} = $self->{_io}->read_u4le();
    $self->{export_table_offset} = $self->{_io}->read_u4le();
    $self->{import_count} = $self->{_io}->read_u4le();
    $self->{import_table_offset} = $self->{_io}->read_u4le();
    $self->{depend_offset} = $self->{_io}->read_u4le();
    $self->{depend_count} = $self->{_io}->read_u4le();
    $self->{guid_part1} = $self->{_io}->read_u4le();
    $self->{guid_part2} = $self->{_io}->read_u4le();
    $self->{guid_part3} = $self->{_io}->read_u4le();
    $self->{guid_part4} = $self->{_io}->read_u4le();
    $self->{generations} = $self->{_io}->read_u4le();
    $self->{export_count_dup} = $self->{_io}->read_u4le();
    $self->{name_count_dup} = $self->{_io}->read_u4le();
    $self->{unknown1} = $self->{_io}->read_u4le();
    $self->{engine_version} = $self->{_io}->read_u4le();
    $self->{cooker_version} = $self->{_io}->read_u4le();
    $self->{compression_flags} = $self->{_io}->read_u4le();
    $self->{package_source} = $self->{_io}->read_u4le();
    $self->{compression_type} = $self->{_io}->read_u4le();
    $self->{chunk_count} = $self->{_io}->read_u4le();
}

sub magic {
    my ($self) = @_;
    return $self->{magic};
}

sub version {
    my ($self) = @_;
    return $self->{version};
}

sub licensee_version {
    my ($self) = @_;
    return $self->{licensee_version};
}

sub header_size {
    my ($self) = @_;
    return $self->{header_size};
}

sub package_name {
    my ($self) = @_;
    return $self->{package_name};
}

sub package_flags {
    my ($self) = @_;
    return $self->{package_flags};
}

sub package_type {
    my ($self) = @_;
    return $self->{package_type};
}

sub name_count {
    my ($self) = @_;
    return $self->{name_count};
}

sub name_table_offset {
    my ($self) = @_;
    return $self->{name_table_offset};
}

sub export_count {
    my ($self) = @_;
    return $self->{export_count};
}

sub export_table_offset {
    my ($self) = @_;
    return $self->{export_table_offset};
}

sub import_count {
    my ($self) = @_;
    return $self->{import_count};
}

sub import_table_offset {
    my ($self) = @_;
    return $self->{import_table_offset};
}

sub depend_offset {
    my ($self) = @_;
    return $self->{depend_offset};
}

sub depend_count {
    my ($self) = @_;
    return $self->{depend_count};
}

sub guid_part1 {
    my ($self) = @_;
    return $self->{guid_part1};
}

sub guid_part2 {
    my ($self) = @_;
    return $self->{guid_part2};
}

sub guid_part3 {
    my ($self) = @_;
    return $self->{guid_part3};
}

sub guid_part4 {
    my ($self) = @_;
    return $self->{guid_part4};
}

sub generations {
    my ($self) = @_;
    return $self->{generations};
}

sub export_count_dup {
    my ($self) = @_;
    return $self->{export_count_dup};
}

sub name_count_dup {
    my ($self) = @_;
    return $self->{name_count_dup};
}

sub unknown1 {
    my ($self) = @_;
    return $self->{unknown1};
}

sub engine_version {
    my ($self) = @_;
    return $self->{engine_version};
}

sub cooker_version {
    my ($self) = @_;
    return $self->{cooker_version};
}

sub compression_flags {
    my ($self) = @_;
    return $self->{compression_flags};
}

sub package_source {
    my ($self) = @_;
    return $self->{package_source};
}

sub compression_type {
    my ($self) = @_;
    return $self->{compression_type};
}

sub chunk_count {
    my ($self) = @_;
    return $self->{chunk_count};
}

########################################################################
package Pcc::Guid;

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

    $self->{part1} = $self->{_io}->read_u4le();
    $self->{part2} = $self->{_io}->read_u4le();
    $self->{part3} = $self->{_io}->read_u4le();
    $self->{part4} = $self->{_io}->read_u4le();
}

sub part1 {
    my ($self) = @_;
    return $self->{part1};
}

sub part2 {
    my ($self) = @_;
    return $self->{part2};
}

sub part3 {
    my ($self) = @_;
    return $self->{part3};
}

sub part4 {
    my ($self) = @_;
    return $self->{part4};
}

########################################################################
package Pcc::ImportEntry;

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

    $self->{package_name_index} = $self->{_io}->read_s8le();
    $self->{class_name_index} = $self->{_io}->read_s4le();
    $self->{link} = $self->{_io}->read_s8le();
    $self->{import_name_index} = $self->{_io}->read_s8le();
}

sub package_name_index {
    my ($self) = @_;
    return $self->{package_name_index};
}

sub class_name_index {
    my ($self) = @_;
    return $self->{class_name_index};
}

sub link {
    my ($self) = @_;
    return $self->{link};
}

sub import_name_index {
    my ($self) = @_;
    return $self->{import_name_index};
}

########################################################################
package Pcc::ImportTable;

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
    my $n_entries = $self->_root()->header()->import_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Pcc::ImportEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

########################################################################
package Pcc::NameEntry;

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

    $self->{length} = $self->{_io}->read_s4le();
    $self->{name} = Encode::decode("UTF-16LE", $self->{_io}->read_bytes(($self->length() < 0 ? -($self->length()) : $self->length()) * 2));
}

sub abs_length {
    my ($self) = @_;
    return $self->{abs_length} if ($self->{abs_length});
    $self->{abs_length} = ($self->length() < 0 ? -($self->length()) : $self->length());
    return $self->{abs_length};
}

sub name_size {
    my ($self) = @_;
    return $self->{name_size} if ($self->{name_size});
    $self->{name_size} = $self->abs_length() * 2;
    return $self->{name_size};
}

sub length {
    my ($self) = @_;
    return $self->{length};
}

sub name {
    my ($self) = @_;
    return $self->{name};
}

########################################################################
package Pcc::NameTable;

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
    my $n_entries = $self->_root()->header()->name_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Pcc::NameEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

1;
