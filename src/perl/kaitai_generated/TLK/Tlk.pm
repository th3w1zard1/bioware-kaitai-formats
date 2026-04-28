# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use Encode;

########################################################################
package Tlk;

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

    $self->{header} = Tlk::TlkHeader->new($self->{_io}, $self, $self->{_root});
    $self->{string_data_table} = Tlk::StringDataTable->new($self->{_io}, $self, $self->{_root});
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

sub string_data_table {
    my ($self) = @_;
    return $self->{string_data_table};
}

########################################################################
package Tlk::StringDataEntry;

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

    $self->{flags} = $self->{_io}->read_u4le();
    $self->{sound_resref} = Encode::decode("ASCII", $self->{_io}->read_bytes(16));
    $self->{volume_variance} = $self->{_io}->read_u4le();
    $self->{pitch_variance} = $self->{_io}->read_u4le();
    $self->{text_offset} = $self->{_io}->read_u4le();
    $self->{text_length} = $self->{_io}->read_u4le();
    $self->{sound_length} = $self->{_io}->read_f4le();
}

sub entry_size {
    my ($self) = @_;
    return $self->{entry_size} if ($self->{entry_size});
    $self->{entry_size} = 40;
    return $self->{entry_size};
}

sub sound_length_present {
    my ($self) = @_;
    return $self->{sound_length_present} if ($self->{sound_length_present});
    $self->{sound_length_present} = ($self->flags() & 4) != 0;
    return $self->{sound_length_present};
}

sub sound_present {
    my ($self) = @_;
    return $self->{sound_present} if ($self->{sound_present});
    $self->{sound_present} = ($self->flags() & 2) != 0;
    return $self->{sound_present};
}

sub text_data {
    my ($self) = @_;
    return $self->{text_data} if ($self->{text_data});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->text_file_offset());
    $self->{text_data} = Encode::decode("ASCII", $self->{_io}->read_bytes($self->text_length()));
    $self->{_io}->seek($_pos);
    return $self->{text_data};
}

sub text_file_offset {
    my ($self) = @_;
    return $self->{text_file_offset} if ($self->{text_file_offset});
    $self->{text_file_offset} = $self->_root()->header()->entries_offset() + $self->text_offset();
    return $self->{text_file_offset};
}

sub text_present {
    my ($self) = @_;
    return $self->{text_present} if ($self->{text_present});
    $self->{text_present} = ($self->flags() & 1) != 0;
    return $self->{text_present};
}

sub flags {
    my ($self) = @_;
    return $self->{flags};
}

sub sound_resref {
    my ($self) = @_;
    return $self->{sound_resref};
}

sub volume_variance {
    my ($self) = @_;
    return $self->{volume_variance};
}

sub pitch_variance {
    my ($self) = @_;
    return $self->{pitch_variance};
}

sub text_offset {
    my ($self) = @_;
    return $self->{text_offset};
}

sub text_length {
    my ($self) = @_;
    return $self->{text_length};
}

sub sound_length {
    my ($self) = @_;
    return $self->{sound_length};
}

########################################################################
package Tlk::StringDataTable;

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
    my $n_entries = $self->_root()->header()->string_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Tlk::StringDataEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

########################################################################
package Tlk::TlkHeader;

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
    $self->{language_id} = $self->{_io}->read_u4le();
    $self->{string_count} = $self->{_io}->read_u4le();
    $self->{entries_offset} = $self->{_io}->read_u4le();
}

sub expected_entries_offset {
    my ($self) = @_;
    return $self->{expected_entries_offset} if ($self->{expected_entries_offset});
    $self->{expected_entries_offset} = 20 + $self->string_count() * 40;
    return $self->{expected_entries_offset};
}

sub header_size {
    my ($self) = @_;
    return $self->{header_size} if ($self->{header_size});
    $self->{header_size} = 20;
    return $self->{header_size};
}

sub file_type {
    my ($self) = @_;
    return $self->{file_type};
}

sub file_version {
    my ($self) = @_;
    return $self->{file_version};
}

sub language_id {
    my ($self) = @_;
    return $self->{language_id};
}

sub string_count {
    my ($self) = @_;
    return $self->{string_count};
}

sub entries_offset {
    my ($self) = @_;
    return $self->{entries_offset};
}

1;
