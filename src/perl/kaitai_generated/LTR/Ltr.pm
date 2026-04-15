# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareCommon;
use Encode;

########################################################################
package Ltr;

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
    $self->{letter_count} = $self->{_io}->read_u1();
    $self->{single_letter_block} = Ltr::LetterBlock->new($self->{_io}, $self, $self->{_root});
    $self->{double_letter_blocks} = Ltr::DoubleLetterBlocksArray->new($self->{_io}, $self, $self->{_root});
    $self->{triple_letter_blocks} = Ltr::TripleLetterBlocksArray->new($self->{_io}, $self, $self->{_root});
}

sub file_type {
    my ($self) = @_;
    return $self->{file_type};
}

sub file_version {
    my ($self) = @_;
    return $self->{file_version};
}

sub letter_count {
    my ($self) = @_;
    return $self->{letter_count};
}

sub single_letter_block {
    my ($self) = @_;
    return $self->{single_letter_block};
}

sub double_letter_blocks {
    my ($self) = @_;
    return $self->{double_letter_blocks};
}

sub triple_letter_blocks {
    my ($self) = @_;
    return $self->{triple_letter_blocks};
}

########################################################################
package Ltr::DoubleLetterBlocksArray;

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

    $self->{blocks} = [];
    my $n_blocks = $self->_root()->letter_count();
    for (my $i = 0; $i < $n_blocks; $i++) {
        push @{$self->{blocks}}, Ltr::LetterBlock->new($self->{_io}, $self, $self->{_root});
    }
}

sub blocks {
    my ($self) = @_;
    return $self->{blocks};
}

########################################################################
package Ltr::LetterBlock;

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

    $self->{start_probabilities} = [];
    my $n_start_probabilities = $self->_root()->letter_count();
    for (my $i = 0; $i < $n_start_probabilities; $i++) {
        push @{$self->{start_probabilities}}, $self->{_io}->read_f4le();
    }
    $self->{middle_probabilities} = [];
    my $n_middle_probabilities = $self->_root()->letter_count();
    for (my $i = 0; $i < $n_middle_probabilities; $i++) {
        push @{$self->{middle_probabilities}}, $self->{_io}->read_f4le();
    }
    $self->{end_probabilities} = [];
    my $n_end_probabilities = $self->_root()->letter_count();
    for (my $i = 0; $i < $n_end_probabilities; $i++) {
        push @{$self->{end_probabilities}}, $self->{_io}->read_f4le();
    }
}

sub start_probabilities {
    my ($self) = @_;
    return $self->{start_probabilities};
}

sub middle_probabilities {
    my ($self) = @_;
    return $self->{middle_probabilities};
}

sub end_probabilities {
    my ($self) = @_;
    return $self->{end_probabilities};
}

########################################################################
package Ltr::TripleLetterBlocksArray;

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

    $self->{rows} = [];
    my $n_rows = $self->_root()->letter_count();
    for (my $i = 0; $i < $n_rows; $i++) {
        push @{$self->{rows}}, Ltr::TripleLetterRow->new($self->{_io}, $self, $self->{_root});
    }
}

sub rows {
    my ($self) = @_;
    return $self->{rows};
}

########################################################################
package Ltr::TripleLetterRow;

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

    $self->{blocks} = [];
    my $n_blocks = $self->_root()->letter_count();
    for (my $i = 0; $i < $n_blocks; $i++) {
        push @{$self->{blocks}}, Ltr::LetterBlock->new($self->{_io}, $self, $self->{_root});
    }
}

sub blocks {
    my ($self) = @_;
    return $self->{blocks};
}

1;
