# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use Encode;

########################################################################
package Twoda;

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

    $self->{header} = Twoda::TwodaHeader->new($self->{_io}, $self, $self->{_root});
    $self->{column_headers_raw} = Encode::decode("ASCII", $self->{_io}->read_bytes_term(0, 0, 1, 1));
    $self->{row_count} = $self->{_io}->read_u4le();
    $self->{row_labels_section} = Twoda::RowLabelsSection->new($self->{_io}, $self, $self->{_root});
    $self->{cell_offsets} = [];
    my $n_cell_offsets = $self->row_count() * $self->column_count();
    for (my $i = 0; $i < $n_cell_offsets; $i++) {
        push @{$self->{cell_offsets}}, $self->{_io}->read_u2le();
    }
    $self->{len_cell_values_section} = $self->{_io}->read_u2le();
    $self->{_raw_cell_values_section} = $self->{_io}->read_bytes($self->len_cell_values_section());
    my $io__raw_cell_values_section = IO::KaitaiStruct::Stream->new($self->{_raw_cell_values_section});
    $self->{cell_values_section} = Twoda::CellValuesSection->new($io__raw_cell_values_section, $self, $self->{_root});
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

sub column_headers_raw {
    my ($self) = @_;
    return $self->{column_headers_raw};
}

sub row_count {
    my ($self) = @_;
    return $self->{row_count};
}

sub row_labels_section {
    my ($self) = @_;
    return $self->{row_labels_section};
}

sub cell_offsets {
    my ($self) = @_;
    return $self->{cell_offsets};
}

sub len_cell_values_section {
    my ($self) = @_;
    return $self->{len_cell_values_section};
}

sub cell_values_section {
    my ($self) = @_;
    return $self->{cell_values_section};
}

sub column_count {
    my ($self) = @_;
    return $self->{column_count};
}

sub _raw_cell_values_section {
    my ($self) = @_;
    return $self->{_raw_cell_values_section};
}

########################################################################
package Twoda::CellValuesSection;

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

    $self->{raw_data} = Encode::decode("ASCII", $self->{_io}->read_bytes($self->_root()->len_cell_values_section()));
}

sub raw_data {
    my ($self) = @_;
    return $self->{raw_data};
}

########################################################################
package Twoda::RowLabelEntry;

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

    $self->{label_value} = Encode::decode("ASCII", $self->{_io}->read_bytes_term(9, 0, 1, 0));
}

sub label_value {
    my ($self) = @_;
    return $self->{label_value};
}

########################################################################
package Twoda::RowLabelsSection;

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

    $self->{labels} = [];
    my $n_labels = $self->_root()->row_count();
    for (my $i = 0; $i < $n_labels; $i++) {
        push @{$self->{labels}}, Twoda::RowLabelEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub labels {
    my ($self) = @_;
    return $self->{labels};
}

########################################################################
package Twoda::TwodaHeader;

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

    $self->{magic} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{version} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{newline} = $self->{_io}->read_u1();
}

sub is_valid_twoda {
    my ($self) = @_;
    return $self->{is_valid_twoda} if ($self->{is_valid_twoda});
    $self->{is_valid_twoda} =  (($self->magic() eq "2DA ") && ($self->version() eq "V2.b") && ($self->newline() == 10)) ;
    return $self->{is_valid_twoda};
}

sub magic {
    my ($self) = @_;
    return $self->{magic};
}

sub version {
    my ($self) = @_;
    return $self->{version};
}

sub newline {
    my ($self) = @_;
    return $self->{newline};
}

1;
