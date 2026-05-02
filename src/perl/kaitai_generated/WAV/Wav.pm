# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareCommon;
use Encode;

########################################################################
package Wav;

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

    $self->{riff_header} = Wav::RiffHeader->new($self->{_io}, $self, $self->{_root});
    $self->{chunks} = [];
    {
        my $_it;
        do {
            $_it = Wav::Chunk->new($self->{_io}, $self, $self->{_root});
            push @{$self->{chunks}}, $_it;
        } until ($self->_io()->is_eof());
    }
}

sub riff_header {
    my ($self) = @_;
    return $self->{riff_header};
}

sub chunks {
    my ($self) = @_;
    return $self->{chunks};
}

########################################################################
package Wav::Chunk;

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

    $self->{id} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{size} = $self->{_io}->read_u4le();
    my $_on = $self->id();
    if ($_on eq "data") {
        $self->{body} = Wav::DataChunkBody->new($self->{_io}, $self, $self->{_root});
    }
    elsif ($_on eq "fact") {
        $self->{body} = Wav::FactChunkBody->new($self->{_io}, $self, $self->{_root});
    }
    elsif ($_on eq "fmt ") {
        $self->{body} = Wav::FormatChunkBody->new($self->{_io}, $self, $self->{_root});
    }
    else {
        $self->{body} = Wav::UnknownChunkBody->new($self->{_io}, $self, $self->{_root});
    }
}

sub id {
    my ($self) = @_;
    return $self->{id};
}

sub size {
    my ($self) = @_;
    return $self->{size};
}

sub body {
    my ($self) = @_;
    return $self->{body};
}

########################################################################
package Wav::DataChunkBody;

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

    $self->{data} = $self->{_io}->read_bytes($self->_parent()->size());
}

sub data {
    my ($self) = @_;
    return $self->{data};
}

########################################################################
package Wav::FactChunkBody;

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

    $self->{sample_count} = $self->{_io}->read_u4le();
}

sub sample_count {
    my ($self) = @_;
    return $self->{sample_count};
}

########################################################################
package Wav::FormatChunkBody;

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

    $self->{audio_format} = $self->{_io}->read_u2le();
    $self->{channels} = $self->{_io}->read_u2le();
    $self->{sample_rate} = $self->{_io}->read_u4le();
    $self->{bytes_per_sec} = $self->{_io}->read_u4le();
    $self->{block_align} = $self->{_io}->read_u2le();
    $self->{bits_per_sample} = $self->{_io}->read_u2le();
    if ($self->_parent()->size() > 16) {
        $self->{extra_format_bytes} = $self->{_io}->read_bytes($self->_parent()->size() - 16);
    }
}

sub is_ima_adpcm {
    my ($self) = @_;
    return $self->{is_ima_adpcm} if ($self->{is_ima_adpcm});
    $self->{is_ima_adpcm} = $self->audio_format() == $BiowareCommon::RIFF_WAVE_FORMAT_TAG_DVI_IMA_ADPCM;
    return $self->{is_ima_adpcm};
}

sub is_mp3 {
    my ($self) = @_;
    return $self->{is_mp3} if ($self->{is_mp3});
    $self->{is_mp3} = $self->audio_format() == $BiowareCommon::RIFF_WAVE_FORMAT_TAG_MPEG_LAYER3;
    return $self->{is_mp3};
}

sub is_pcm {
    my ($self) = @_;
    return $self->{is_pcm} if ($self->{is_pcm});
    $self->{is_pcm} = $self->audio_format() == $BiowareCommon::RIFF_WAVE_FORMAT_TAG_PCM;
    return $self->{is_pcm};
}

sub audio_format {
    my ($self) = @_;
    return $self->{audio_format};
}

sub channels {
    my ($self) = @_;
    return $self->{channels};
}

sub sample_rate {
    my ($self) = @_;
    return $self->{sample_rate};
}

sub bytes_per_sec {
    my ($self) = @_;
    return $self->{bytes_per_sec};
}

sub block_align {
    my ($self) = @_;
    return $self->{block_align};
}

sub bits_per_sample {
    my ($self) = @_;
    return $self->{bits_per_sample};
}

sub extra_format_bytes {
    my ($self) = @_;
    return $self->{extra_format_bytes};
}

########################################################################
package Wav::RiffHeader;

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

    $self->{riff_id} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
    $self->{riff_size} = $self->{_io}->read_u4le();
    $self->{wave_id} = Encode::decode("ASCII", $self->{_io}->read_bytes(4));
}

sub is_mp3_in_wav {
    my ($self) = @_;
    return $self->{is_mp3_in_wav} if ($self->{is_mp3_in_wav});
    $self->{is_mp3_in_wav} = $self->riff_size() == 50;
    return $self->{is_mp3_in_wav};
}

sub riff_id {
    my ($self) = @_;
    return $self->{riff_id};
}

sub riff_size {
    my ($self) = @_;
    return $self->{riff_size};
}

sub wave_id {
    my ($self) = @_;
    return $self->{wave_id};
}

########################################################################
package Wav::UnknownChunkBody;

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

    $self->{data} = $self->{_io}->read_bytes($self->_parent()->size());
    if ($self->_parent()->size() % 2 == 1) {
        $self->{padding} = $self->{_io}->read_u1();
    }
}

sub data {
    my ($self) = @_;
    return $self->{data};
}

sub padding {
    my ($self) = @_;
    return $self->{padding};
}

1;
