# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use Encode;

########################################################################
package Da2s;

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

    $self->{signature} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{version} = $self->{_io}->read_s4le();
    $self->{save_name} = Da2s::LengthPrefixedString->new($self->{_io}, $self, $self->{_root});
    $self->{module_name} = Da2s::LengthPrefixedString->new($self->{_io}, $self, $self->{_root});
    $self->{area_name} = Da2s::LengthPrefixedString->new($self->{_io}, $self, $self->{_root});
    $self->{time_played_seconds} = $self->{_io}->read_s4le();
    $self->{timestamp_filetime} = $self->{_io}->read_s8le();
    $self->{num_screenshot_data} = $self->{_io}->read_s4le();
    if ($self->num_screenshot_data() > 0) {
        $self->{screenshot_data} = [];
        my $n_screenshot_data = $self->num_screenshot_data();
        for (my $i = 0; $i < $n_screenshot_data; $i++) {
            push @{$self->{screenshot_data}}, $self->{_io}->read_u1();
        }
    }
    $self->{num_portrait_data} = $self->{_io}->read_s4le();
    if ($self->num_portrait_data() > 0) {
        $self->{portrait_data} = [];
        my $n_portrait_data = $self->num_portrait_data();
        for (my $i = 0; $i < $n_portrait_data; $i++) {
            push @{$self->{portrait_data}}, $self->{_io}->read_u1();
        }
    }
    $self->{player_name} = Da2s::LengthPrefixedString->new($self->{_io}, $self, $self->{_root});
    $self->{party_member_count} = $self->{_io}->read_s4le();
    $self->{player_level} = $self->{_io}->read_s4le();
}

sub signature {
    my ($self) = @_;
    return $self->{signature};
}

sub version {
    my ($self) = @_;
    return $self->{version};
}

sub save_name {
    my ($self) = @_;
    return $self->{save_name};
}

sub module_name {
    my ($self) = @_;
    return $self->{module_name};
}

sub area_name {
    my ($self) = @_;
    return $self->{area_name};
}

sub time_played_seconds {
    my ($self) = @_;
    return $self->{time_played_seconds};
}

sub timestamp_filetime {
    my ($self) = @_;
    return $self->{timestamp_filetime};
}

sub num_screenshot_data {
    my ($self) = @_;
    return $self->{num_screenshot_data};
}

sub screenshot_data {
    my ($self) = @_;
    return $self->{screenshot_data};
}

sub num_portrait_data {
    my ($self) = @_;
    return $self->{num_portrait_data};
}

sub portrait_data {
    my ($self) = @_;
    return $self->{portrait_data};
}

sub player_name {
    my ($self) = @_;
    return $self->{player_name};
}

sub party_member_count {
    my ($self) = @_;
    return $self->{party_member_count};
}

sub player_level {
    my ($self) = @_;
    return $self->{player_level};
}

########################################################################
package Da2s::LengthPrefixedString;

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
    $self->{value} = Encode::decode("UTF-8", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes($self->length()), 0, 0));
}

sub value_trimmed {
    my ($self) = @_;
    return $self->{value_trimmed} if ($self->{value_trimmed});
    $self->{value_trimmed} = $self->value();
    return $self->{value_trimmed};
}

sub length {
    my ($self) = @_;
    return $self->{length};
}

sub value {
    my ($self) = @_;
    return $self->{value};
}

1;
