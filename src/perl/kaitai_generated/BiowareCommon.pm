# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use Encode;

########################################################################
package BiowareCommon;

our @ISA = 'IO::KaitaiStruct::Struct';

sub from_file {
    my ($class, $filename) = @_;
    my $fd;

    open($fd, '<', $filename) or return undef;
    binmode($fd);
    return new($class, IO::KaitaiStruct::Stream->new($fd));
}

our $BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL_DXT1 = 3;
our $BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL_DXT5 = 4;

our $BIOWARE_EQUIPMENT_SLOT_FLAG_INVALID = 0;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_HEAD = 1;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_ARMOR = 2;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_GAUNTLET = 8;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_RIGHT_HAND = 16;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_LEFT_HAND = 32;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_RIGHT_ARM = 128;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_LEFT_ARM = 256;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_IMPLANT = 512;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_BELT = 1024;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_CLAW1 = 16384;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_CLAW2 = 32768;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_CLAW3 = 65536;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_HIDE = 131072;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_RIGHT_HAND_2 = 262144;
our $BIOWARE_EQUIPMENT_SLOT_FLAG_LEFT_HAND_2 = 524288;

our $BIOWARE_GAME_ID_K1 = 1;
our $BIOWARE_GAME_ID_K2 = 2;
our $BIOWARE_GAME_ID_K1_XBOX = 3;
our $BIOWARE_GAME_ID_K2_XBOX = 4;
our $BIOWARE_GAME_ID_K1_IOS = 5;
our $BIOWARE_GAME_ID_K2_IOS = 6;
our $BIOWARE_GAME_ID_K1_ANDROID = 7;
our $BIOWARE_GAME_ID_K2_ANDROID = 8;

our $BIOWARE_GENDER_ID_MALE = 0;
our $BIOWARE_GENDER_ID_FEMALE = 1;

our $BIOWARE_LANGUAGE_ID_ENGLISH = 0;
our $BIOWARE_LANGUAGE_ID_FRENCH = 1;
our $BIOWARE_LANGUAGE_ID_GERMAN = 2;
our $BIOWARE_LANGUAGE_ID_ITALIAN = 3;
our $BIOWARE_LANGUAGE_ID_SPANISH = 4;
our $BIOWARE_LANGUAGE_ID_POLISH = 5;
our $BIOWARE_LANGUAGE_ID_AFRIKAANS = 6;
our $BIOWARE_LANGUAGE_ID_BASQUE = 7;
our $BIOWARE_LANGUAGE_ID_BRETON = 9;
our $BIOWARE_LANGUAGE_ID_CATALAN = 10;
our $BIOWARE_LANGUAGE_ID_CHAMORRO = 11;
our $BIOWARE_LANGUAGE_ID_CHICHEWA = 12;
our $BIOWARE_LANGUAGE_ID_CORSICAN = 13;
our $BIOWARE_LANGUAGE_ID_DANISH = 14;
our $BIOWARE_LANGUAGE_ID_DUTCH = 15;
our $BIOWARE_LANGUAGE_ID_FAROESE = 16;
our $BIOWARE_LANGUAGE_ID_FILIPINO = 18;
our $BIOWARE_LANGUAGE_ID_FINNISH = 19;
our $BIOWARE_LANGUAGE_ID_FLEMISH = 20;
our $BIOWARE_LANGUAGE_ID_FRISIAN = 21;
our $BIOWARE_LANGUAGE_ID_GALICIAN = 22;
our $BIOWARE_LANGUAGE_ID_GANDA = 23;
our $BIOWARE_LANGUAGE_ID_HAITIAN_CREOLE = 24;
our $BIOWARE_LANGUAGE_ID_HAUSA_LATIN = 25;
our $BIOWARE_LANGUAGE_ID_HAWAIIAN = 26;
our $BIOWARE_LANGUAGE_ID_ICELANDIC = 27;
our $BIOWARE_LANGUAGE_ID_IDO = 28;
our $BIOWARE_LANGUAGE_ID_INDONESIAN = 29;
our $BIOWARE_LANGUAGE_ID_IGBO = 30;
our $BIOWARE_LANGUAGE_ID_IRISH = 31;
our $BIOWARE_LANGUAGE_ID_INTERLINGUA = 32;
our $BIOWARE_LANGUAGE_ID_JAVANESE_LATIN = 33;
our $BIOWARE_LANGUAGE_ID_LATIN = 34;
our $BIOWARE_LANGUAGE_ID_LUXEMBOURGISH = 35;
our $BIOWARE_LANGUAGE_ID_MALTESE = 36;
our $BIOWARE_LANGUAGE_ID_NORWEGIAN = 37;
our $BIOWARE_LANGUAGE_ID_OCCITAN = 38;
our $BIOWARE_LANGUAGE_ID_PORTUGUESE = 39;
our $BIOWARE_LANGUAGE_ID_SCOTS = 40;
our $BIOWARE_LANGUAGE_ID_SCOTTISH_GAELIC = 41;
our $BIOWARE_LANGUAGE_ID_SHONA = 42;
our $BIOWARE_LANGUAGE_ID_SOTO = 43;
our $BIOWARE_LANGUAGE_ID_SUNDANESE_LATIN = 44;
our $BIOWARE_LANGUAGE_ID_SWAHILI = 45;
our $BIOWARE_LANGUAGE_ID_SWEDISH = 46;
our $BIOWARE_LANGUAGE_ID_TAGALOG = 47;
our $BIOWARE_LANGUAGE_ID_TAHITIAN = 48;
our $BIOWARE_LANGUAGE_ID_TONGAN = 49;
our $BIOWARE_LANGUAGE_ID_UZBEK_LATIN = 50;
our $BIOWARE_LANGUAGE_ID_WALLOON = 51;
our $BIOWARE_LANGUAGE_ID_XHOSA = 52;
our $BIOWARE_LANGUAGE_ID_YORUBA = 53;
our $BIOWARE_LANGUAGE_ID_WELSH = 54;
our $BIOWARE_LANGUAGE_ID_ZULU = 55;
our $BIOWARE_LANGUAGE_ID_BULGARIAN = 58;
our $BIOWARE_LANGUAGE_ID_BELARISIAN = 59;
our $BIOWARE_LANGUAGE_ID_MACEDONIAN = 60;
our $BIOWARE_LANGUAGE_ID_RUSSIAN = 61;
our $BIOWARE_LANGUAGE_ID_SERBIAN_CYRILLIC = 62;
our $BIOWARE_LANGUAGE_ID_TAJIK = 63;
our $BIOWARE_LANGUAGE_ID_TATAR_CYRILLIC = 64;
our $BIOWARE_LANGUAGE_ID_UKRAINIAN = 66;
our $BIOWARE_LANGUAGE_ID_UZBEK = 67;
our $BIOWARE_LANGUAGE_ID_ALBANIAN = 68;
our $BIOWARE_LANGUAGE_ID_BOSNIAN_LATIN = 69;
our $BIOWARE_LANGUAGE_ID_CZECH = 70;
our $BIOWARE_LANGUAGE_ID_SLOVAK = 71;
our $BIOWARE_LANGUAGE_ID_SLOVENE = 72;
our $BIOWARE_LANGUAGE_ID_CROATIAN = 73;
our $BIOWARE_LANGUAGE_ID_HUNGARIAN = 75;
our $BIOWARE_LANGUAGE_ID_ROMANIAN = 76;
our $BIOWARE_LANGUAGE_ID_GREEK = 77;
our $BIOWARE_LANGUAGE_ID_ESPERANTO = 78;
our $BIOWARE_LANGUAGE_ID_AZERBAIJANI_LATIN = 79;
our $BIOWARE_LANGUAGE_ID_TURKISH = 81;
our $BIOWARE_LANGUAGE_ID_TURKMEN_LATIN = 82;
our $BIOWARE_LANGUAGE_ID_HEBREW = 83;
our $BIOWARE_LANGUAGE_ID_ARABIC = 84;
our $BIOWARE_LANGUAGE_ID_ESTONIAN = 85;
our $BIOWARE_LANGUAGE_ID_LATVIAN = 86;
our $BIOWARE_LANGUAGE_ID_LITHUANIAN = 87;
our $BIOWARE_LANGUAGE_ID_VIETNAMESE = 88;
our $BIOWARE_LANGUAGE_ID_THAI = 89;
our $BIOWARE_LANGUAGE_ID_AYMARA = 90;
our $BIOWARE_LANGUAGE_ID_KINYARWANDA = 91;
our $BIOWARE_LANGUAGE_ID_KURDISH_LATIN = 92;
our $BIOWARE_LANGUAGE_ID_MALAGASY = 93;
our $BIOWARE_LANGUAGE_ID_MALAY_LATIN = 94;
our $BIOWARE_LANGUAGE_ID_MAORI = 95;
our $BIOWARE_LANGUAGE_ID_MOLDOVAN_LATIN = 96;
our $BIOWARE_LANGUAGE_ID_SAMOAN = 97;
our $BIOWARE_LANGUAGE_ID_SOMALI = 98;
our $BIOWARE_LANGUAGE_ID_KOREAN = 128;
our $BIOWARE_LANGUAGE_ID_CHINESE_TRADITIONAL = 129;
our $BIOWARE_LANGUAGE_ID_CHINESE_SIMPLIFIED = 130;
our $BIOWARE_LANGUAGE_ID_JAPANESE = 131;
our $BIOWARE_LANGUAGE_ID_UNKNOWN = 2147483646;

our $BIOWARE_LIP_VISEME_ID_NEUTRAL = 0;
our $BIOWARE_LIP_VISEME_ID_EE = 1;
our $BIOWARE_LIP_VISEME_ID_EH = 2;
our $BIOWARE_LIP_VISEME_ID_AH = 3;
our $BIOWARE_LIP_VISEME_ID_OH = 4;
our $BIOWARE_LIP_VISEME_ID_OOH = 5;
our $BIOWARE_LIP_VISEME_ID_Y = 6;
our $BIOWARE_LIP_VISEME_ID_STS = 7;
our $BIOWARE_LIP_VISEME_ID_FV = 8;
our $BIOWARE_LIP_VISEME_ID_NG = 9;
our $BIOWARE_LIP_VISEME_ID_TH = 10;
our $BIOWARE_LIP_VISEME_ID_MPB = 11;
our $BIOWARE_LIP_VISEME_ID_TD = 12;
our $BIOWARE_LIP_VISEME_ID_SH = 13;
our $BIOWARE_LIP_VISEME_ID_L = 14;
our $BIOWARE_LIP_VISEME_ID_KG = 15;

our $BIOWARE_LTR_ALPHABET_LENGTH_NEVERWINTER_NIGHTS = 26;
our $BIOWARE_LTR_ALPHABET_LENGTH_KOTOR = 28;

our $BIOWARE_OBJECT_TYPE_ID_INVALID = 0;
our $BIOWARE_OBJECT_TYPE_ID_CREATURE = 1;
our $BIOWARE_OBJECT_TYPE_ID_DOOR = 2;
our $BIOWARE_OBJECT_TYPE_ID_ITEM = 3;
our $BIOWARE_OBJECT_TYPE_ID_TRIGGER = 4;
our $BIOWARE_OBJECT_TYPE_ID_PLACEABLE = 5;
our $BIOWARE_OBJECT_TYPE_ID_WAYPOINT = 6;
our $BIOWARE_OBJECT_TYPE_ID_ENCOUNTER = 7;
our $BIOWARE_OBJECT_TYPE_ID_STORE = 8;
our $BIOWARE_OBJECT_TYPE_ID_AREA = 9;
our $BIOWARE_OBJECT_TYPE_ID_SOUND = 10;
our $BIOWARE_OBJECT_TYPE_ID_CAMERA = 11;

our $BIOWARE_PCC_COMPRESSION_CODEC_NONE = 0;
our $BIOWARE_PCC_COMPRESSION_CODEC_ZLIB = 1;
our $BIOWARE_PCC_COMPRESSION_CODEC_LZO = 2;

our $BIOWARE_PCC_PACKAGE_KIND_NORMAL_PACKAGE = 0;
our $BIOWARE_PCC_PACKAGE_KIND_PATCH_PACKAGE = 1;

our $BIOWARE_TPC_PIXEL_FORMAT_ID_GREYSCALE = 1;
our $BIOWARE_TPC_PIXEL_FORMAT_ID_RGB_OR_DXT1 = 2;
our $BIOWARE_TPC_PIXEL_FORMAT_ID_RGBA_OR_DXT5 = 4;
our $BIOWARE_TPC_PIXEL_FORMAT_ID_BGRA_XBOX_SWIZZLE = 12;

our $RIFF_WAVE_FORMAT_TAG_PCM = 1;
our $RIFF_WAVE_FORMAT_TAG_ADPCM_MS = 2;
our $RIFF_WAVE_FORMAT_TAG_IEEE_FLOAT = 3;
our $RIFF_WAVE_FORMAT_TAG_ALAW = 6;
our $RIFF_WAVE_FORMAT_TAG_MULAW = 7;
our $RIFF_WAVE_FORMAT_TAG_DVI_IMA_ADPCM = 17;
our $RIFF_WAVE_FORMAT_TAG_MPEG_LAYER3 = 85;
our $RIFF_WAVE_FORMAT_TAG_WAVE_FORMAT_EXTENSIBLE = 65534;

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

}

########################################################################
package BiowareCommon::BiowareBinaryData;

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

    $self->{len_value} = $self->{_io}->read_u4le();
    $self->{value} = $self->{_io}->read_bytes($self->len_value());
}

sub len_value {
    my ($self) = @_;
    return $self->{len_value};
}

sub value {
    my ($self) = @_;
    return $self->{value};
}

########################################################################
package BiowareCommon::BiowareCexoString;

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

    $self->{len_string} = $self->{_io}->read_u4le();
    $self->{value} = Encode::decode("UTF-8", $self->{_io}->read_bytes($self->len_string()));
}

sub len_string {
    my ($self) = @_;
    return $self->{len_string};
}

sub value {
    my ($self) = @_;
    return $self->{value};
}

########################################################################
package BiowareCommon::BiowareLocstring;

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

    $self->{total_size} = $self->{_io}->read_u4le();
    $self->{string_ref} = $self->{_io}->read_u4le();
    $self->{num_substrings} = $self->{_io}->read_u4le();
    $self->{substrings} = [];
    my $n_substrings = $self->num_substrings();
    for (my $i = 0; $i < $n_substrings; $i++) {
        push @{$self->{substrings}}, BiowareCommon::Substring->new($self->{_io}, $self, $self->{_root});
    }
}

sub has_strref {
    my ($self) = @_;
    return $self->{has_strref} if ($self->{has_strref});
    $self->{has_strref} = $self->string_ref() != 4294967295;
    return $self->{has_strref};
}

sub total_size {
    my ($self) = @_;
    return $self->{total_size};
}

sub string_ref {
    my ($self) = @_;
    return $self->{string_ref};
}

sub num_substrings {
    my ($self) = @_;
    return $self->{num_substrings};
}

sub substrings {
    my ($self) = @_;
    return $self->{substrings};
}

########################################################################
package BiowareCommon::BiowareResref;

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

    $self->{len_resref} = $self->{_io}->read_u1();
    $self->{value} = Encode::decode("ASCII", $self->{_io}->read_bytes($self->len_resref()));
}

sub len_resref {
    my ($self) = @_;
    return $self->{len_resref};
}

sub value {
    my ($self) = @_;
    return $self->{value};
}

########################################################################
package BiowareCommon::BiowareVector3;

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

    $self->{x} = $self->{_io}->read_f4le();
    $self->{y} = $self->{_io}->read_f4le();
    $self->{z} = $self->{_io}->read_f4le();
}

sub x {
    my ($self) = @_;
    return $self->{x};
}

sub y {
    my ($self) = @_;
    return $self->{y};
}

sub z {
    my ($self) = @_;
    return $self->{z};
}

########################################################################
package BiowareCommon::BiowareVector4;

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

    $self->{x} = $self->{_io}->read_f4le();
    $self->{y} = $self->{_io}->read_f4le();
    $self->{z} = $self->{_io}->read_f4le();
    $self->{w} = $self->{_io}->read_f4le();
}

sub x {
    my ($self) = @_;
    return $self->{x};
}

sub y {
    my ($self) = @_;
    return $self->{y};
}

sub z {
    my ($self) = @_;
    return $self->{z};
}

sub w {
    my ($self) = @_;
    return $self->{w};
}

########################################################################
package BiowareCommon::Substring;

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

    $self->{substring_id} = $self->{_io}->read_u4le();
    $self->{len_text} = $self->{_io}->read_u4le();
    $self->{text} = Encode::decode("UTF-8", $self->{_io}->read_bytes($self->len_text()));
}

sub gender {
    my ($self) = @_;
    return $self->{gender} if ($self->{gender});
    $self->{gender} = $self->gender_raw();
    return $self->{gender};
}

sub gender_raw {
    my ($self) = @_;
    return $self->{gender_raw} if ($self->{gender_raw});
    $self->{gender_raw} = $self->substring_id() & 255;
    return $self->{gender_raw};
}

sub language {
    my ($self) = @_;
    return $self->{language} if ($self->{language});
    $self->{language} = $self->language_raw();
    return $self->{language};
}

sub language_raw {
    my ($self) = @_;
    return $self->{language_raw} if ($self->{language_raw});
    $self->{language_raw} = $self->substring_id() >> 8 & 255;
    return $self->{language_raw};
}

sub substring_id {
    my ($self) = @_;
    return $self->{substring_id};
}

sub len_text {
    my ($self) = @_;
    return $self->{len_text};
}

sub text {
    my ($self) = @_;
    return $self->{text};
}

1;
