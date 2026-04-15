# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
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

our $XOREOS_FILE_TYPE_ID_NONE = -1;
our $XOREOS_FILE_TYPE_ID_RES = 0;
our $XOREOS_FILE_TYPE_ID_BMP = 1;
our $XOREOS_FILE_TYPE_ID_MVE = 2;
our $XOREOS_FILE_TYPE_ID_TGA = 3;
our $XOREOS_FILE_TYPE_ID_WAV = 4;
our $XOREOS_FILE_TYPE_ID_PLT = 6;
our $XOREOS_FILE_TYPE_ID_INI = 7;
our $XOREOS_FILE_TYPE_ID_BMU = 8;
our $XOREOS_FILE_TYPE_ID_MPG = 9;
our $XOREOS_FILE_TYPE_ID_TXT = 10;
our $XOREOS_FILE_TYPE_ID_WMA = 11;
our $XOREOS_FILE_TYPE_ID_WMV = 12;
our $XOREOS_FILE_TYPE_ID_XMV = 13;
our $XOREOS_FILE_TYPE_ID_PLH = 2000;
our $XOREOS_FILE_TYPE_ID_TEX = 2001;
our $XOREOS_FILE_TYPE_ID_MDL = 2002;
our $XOREOS_FILE_TYPE_ID_THG = 2003;
our $XOREOS_FILE_TYPE_ID_FNT = 2005;
our $XOREOS_FILE_TYPE_ID_LUA = 2007;
our $XOREOS_FILE_TYPE_ID_SLT = 2008;
our $XOREOS_FILE_TYPE_ID_NSS = 2009;
our $XOREOS_FILE_TYPE_ID_NCS = 2010;
our $XOREOS_FILE_TYPE_ID_MOD = 2011;
our $XOREOS_FILE_TYPE_ID_ARE = 2012;
our $XOREOS_FILE_TYPE_ID_SET = 2013;
our $XOREOS_FILE_TYPE_ID_IFO = 2014;
our $XOREOS_FILE_TYPE_ID_BIC = 2015;
our $XOREOS_FILE_TYPE_ID_WOK = 2016;
our $XOREOS_FILE_TYPE_ID_TWO_DA = 2017;
our $XOREOS_FILE_TYPE_ID_TLK = 2018;
our $XOREOS_FILE_TYPE_ID_TXI = 2022;
our $XOREOS_FILE_TYPE_ID_GIT = 2023;
our $XOREOS_FILE_TYPE_ID_BTI = 2024;
our $XOREOS_FILE_TYPE_ID_UTI = 2025;
our $XOREOS_FILE_TYPE_ID_BTC = 2026;
our $XOREOS_FILE_TYPE_ID_UTC = 2027;
our $XOREOS_FILE_TYPE_ID_DLG = 2029;
our $XOREOS_FILE_TYPE_ID_ITP = 2030;
our $XOREOS_FILE_TYPE_ID_BTT = 2031;
our $XOREOS_FILE_TYPE_ID_UTT = 2032;
our $XOREOS_FILE_TYPE_ID_DDS = 2033;
our $XOREOS_FILE_TYPE_ID_BTS = 2034;
our $XOREOS_FILE_TYPE_ID_UTS = 2035;
our $XOREOS_FILE_TYPE_ID_LTR = 2036;
our $XOREOS_FILE_TYPE_ID_GFF = 2037;
our $XOREOS_FILE_TYPE_ID_FAC = 2038;
our $XOREOS_FILE_TYPE_ID_BTE = 2039;
our $XOREOS_FILE_TYPE_ID_UTE = 2040;
our $XOREOS_FILE_TYPE_ID_BTD = 2041;
our $XOREOS_FILE_TYPE_ID_UTD = 2042;
our $XOREOS_FILE_TYPE_ID_BTP = 2043;
our $XOREOS_FILE_TYPE_ID_UTP = 2044;
our $XOREOS_FILE_TYPE_ID_DFT = 2045;
our $XOREOS_FILE_TYPE_ID_GIC = 2046;
our $XOREOS_FILE_TYPE_ID_GUI = 2047;
our $XOREOS_FILE_TYPE_ID_CSS = 2048;
our $XOREOS_FILE_TYPE_ID_CCS = 2049;
our $XOREOS_FILE_TYPE_ID_BTM = 2050;
our $XOREOS_FILE_TYPE_ID_UTM = 2051;
our $XOREOS_FILE_TYPE_ID_DWK = 2052;
our $XOREOS_FILE_TYPE_ID_PWK = 2053;
our $XOREOS_FILE_TYPE_ID_BTG = 2054;
our $XOREOS_FILE_TYPE_ID_UTG = 2055;
our $XOREOS_FILE_TYPE_ID_JRL = 2056;
our $XOREOS_FILE_TYPE_ID_SAV = 2057;
our $XOREOS_FILE_TYPE_ID_UTW = 2058;
our $XOREOS_FILE_TYPE_ID_FOUR_PC = 2059;
our $XOREOS_FILE_TYPE_ID_SSF = 2060;
our $XOREOS_FILE_TYPE_ID_HAK = 2061;
our $XOREOS_FILE_TYPE_ID_NWM = 2062;
our $XOREOS_FILE_TYPE_ID_BIK = 2063;
our $XOREOS_FILE_TYPE_ID_NDB = 2064;
our $XOREOS_FILE_TYPE_ID_PTM = 2065;
our $XOREOS_FILE_TYPE_ID_PTT = 2066;
our $XOREOS_FILE_TYPE_ID_NCM = 2067;
our $XOREOS_FILE_TYPE_ID_MFX = 2068;
our $XOREOS_FILE_TYPE_ID_MAT = 2069;
our $XOREOS_FILE_TYPE_ID_MDB = 2070;
our $XOREOS_FILE_TYPE_ID_SAY = 2071;
our $XOREOS_FILE_TYPE_ID_TTF = 2072;
our $XOREOS_FILE_TYPE_ID_TTC = 2073;
our $XOREOS_FILE_TYPE_ID_CUT = 2074;
our $XOREOS_FILE_TYPE_ID_KA = 2075;
our $XOREOS_FILE_TYPE_ID_JPG = 2076;
our $XOREOS_FILE_TYPE_ID_ICO = 2077;
our $XOREOS_FILE_TYPE_ID_OGG = 2078;
our $XOREOS_FILE_TYPE_ID_SPT = 2079;
our $XOREOS_FILE_TYPE_ID_SPW = 2080;
our $XOREOS_FILE_TYPE_ID_WFX = 2081;
our $XOREOS_FILE_TYPE_ID_UGM = 2082;
our $XOREOS_FILE_TYPE_ID_QDB = 2083;
our $XOREOS_FILE_TYPE_ID_QST = 2084;
our $XOREOS_FILE_TYPE_ID_NPC = 2085;
our $XOREOS_FILE_TYPE_ID_SPN = 2086;
our $XOREOS_FILE_TYPE_ID_UTX = 2087;
our $XOREOS_FILE_TYPE_ID_MMD = 2088;
our $XOREOS_FILE_TYPE_ID_SMM = 2089;
our $XOREOS_FILE_TYPE_ID_UTA = 2090;
our $XOREOS_FILE_TYPE_ID_MDE = 2091;
our $XOREOS_FILE_TYPE_ID_MDV = 2092;
our $XOREOS_FILE_TYPE_ID_MDA = 2093;
our $XOREOS_FILE_TYPE_ID_MBA = 2094;
our $XOREOS_FILE_TYPE_ID_OCT = 2095;
our $XOREOS_FILE_TYPE_ID_BFX = 2096;
our $XOREOS_FILE_TYPE_ID_PDB = 2097;
our $XOREOS_FILE_TYPE_ID_THE_WITCHER_SAVE = 2098;
our $XOREOS_FILE_TYPE_ID_PVS = 2099;
our $XOREOS_FILE_TYPE_ID_CFX = 2100;
our $XOREOS_FILE_TYPE_ID_LUC = 2101;
our $XOREOS_FILE_TYPE_ID_PRB = 2103;
our $XOREOS_FILE_TYPE_ID_CAM = 2104;
our $XOREOS_FILE_TYPE_ID_VDS = 2105;
our $XOREOS_FILE_TYPE_ID_BIN = 2106;
our $XOREOS_FILE_TYPE_ID_WOB = 2107;
our $XOREOS_FILE_TYPE_ID_API = 2108;
our $XOREOS_FILE_TYPE_ID_PROPERTIES = 2109;
our $XOREOS_FILE_TYPE_ID_PNG = 2110;
our $XOREOS_FILE_TYPE_ID_LYT = 3000;
our $XOREOS_FILE_TYPE_ID_VIS = 3001;
our $XOREOS_FILE_TYPE_ID_RIM = 3002;
our $XOREOS_FILE_TYPE_ID_PTH = 3003;
our $XOREOS_FILE_TYPE_ID_LIP = 3004;
our $XOREOS_FILE_TYPE_ID_BWM = 3005;
our $XOREOS_FILE_TYPE_ID_TXB = 3006;
our $XOREOS_FILE_TYPE_ID_TPC = 3007;
our $XOREOS_FILE_TYPE_ID_MDX = 3008;
our $XOREOS_FILE_TYPE_ID_RSV = 3009;
our $XOREOS_FILE_TYPE_ID_SIG = 3010;
our $XOREOS_FILE_TYPE_ID_MAB = 3011;
our $XOREOS_FILE_TYPE_ID_QST2 = 3012;
our $XOREOS_FILE_TYPE_ID_STO = 3013;
our $XOREOS_FILE_TYPE_ID_HEX = 3015;
our $XOREOS_FILE_TYPE_ID_MDX2 = 3016;
our $XOREOS_FILE_TYPE_ID_TXB2 = 3017;
our $XOREOS_FILE_TYPE_ID_FSM = 3022;
our $XOREOS_FILE_TYPE_ID_ART = 3023;
our $XOREOS_FILE_TYPE_ID_AMP = 3024;
our $XOREOS_FILE_TYPE_ID_CWA = 3025;
our $XOREOS_FILE_TYPE_ID_BIP = 3028;
our $XOREOS_FILE_TYPE_ID_MDB2 = 4000;
our $XOREOS_FILE_TYPE_ID_MDA2 = 4001;
our $XOREOS_FILE_TYPE_ID_SPT2 = 4002;
our $XOREOS_FILE_TYPE_ID_GR2 = 4003;
our $XOREOS_FILE_TYPE_ID_FXA = 4004;
our $XOREOS_FILE_TYPE_ID_FXE = 4005;
our $XOREOS_FILE_TYPE_ID_JPG2 = 4007;
our $XOREOS_FILE_TYPE_ID_PWC = 4008;
our $XOREOS_FILE_TYPE_ID_ONE_DA = 9996;
our $XOREOS_FILE_TYPE_ID_ERF = 9997;
our $XOREOS_FILE_TYPE_ID_BIF = 9998;
our $XOREOS_FILE_TYPE_ID_KEY = 9999;
our $XOREOS_FILE_TYPE_ID_EXE = 19000;
our $XOREOS_FILE_TYPE_ID_DBF = 19001;
our $XOREOS_FILE_TYPE_ID_CDX = 19002;
our $XOREOS_FILE_TYPE_ID_FPT = 19003;
our $XOREOS_FILE_TYPE_ID_ZIP = 20000;
our $XOREOS_FILE_TYPE_ID_FXM = 20001;
our $XOREOS_FILE_TYPE_ID_FXS = 20002;
our $XOREOS_FILE_TYPE_ID_XML = 20003;
our $XOREOS_FILE_TYPE_ID_WLK = 20004;
our $XOREOS_FILE_TYPE_ID_UTR = 20005;
our $XOREOS_FILE_TYPE_ID_SEF = 20006;
our $XOREOS_FILE_TYPE_ID_PFX = 20007;
our $XOREOS_FILE_TYPE_ID_TFX = 20008;
our $XOREOS_FILE_TYPE_ID_IFX = 20009;
our $XOREOS_FILE_TYPE_ID_LFX = 20010;
our $XOREOS_FILE_TYPE_ID_BBX = 20011;
our $XOREOS_FILE_TYPE_ID_PFB = 20012;
our $XOREOS_FILE_TYPE_ID_UPE = 20013;
our $XOREOS_FILE_TYPE_ID_USC = 20014;
our $XOREOS_FILE_TYPE_ID_ULT = 20015;
our $XOREOS_FILE_TYPE_ID_FX = 20016;
our $XOREOS_FILE_TYPE_ID_MAX = 20017;
our $XOREOS_FILE_TYPE_ID_DOC = 20018;
our $XOREOS_FILE_TYPE_ID_SCC = 20019;
our $XOREOS_FILE_TYPE_ID_WMP = 20020;
our $XOREOS_FILE_TYPE_ID_OSC = 20021;
our $XOREOS_FILE_TYPE_ID_TRN = 20022;
our $XOREOS_FILE_TYPE_ID_UEN = 20023;
our $XOREOS_FILE_TYPE_ID_ROS = 20024;
our $XOREOS_FILE_TYPE_ID_RST = 20025;
our $XOREOS_FILE_TYPE_ID_PTX = 20026;
our $XOREOS_FILE_TYPE_ID_LTX = 20027;
our $XOREOS_FILE_TYPE_ID_TRX = 20028;
our $XOREOS_FILE_TYPE_ID_NDS = 21000;
our $XOREOS_FILE_TYPE_ID_HERF = 21001;
our $XOREOS_FILE_TYPE_ID_DICT = 21002;
our $XOREOS_FILE_TYPE_ID_SMALL = 21003;
our $XOREOS_FILE_TYPE_ID_CBGT = 21004;
our $XOREOS_FILE_TYPE_ID_CDPTH = 21005;
our $XOREOS_FILE_TYPE_ID_EMIT = 21006;
our $XOREOS_FILE_TYPE_ID_ITM = 21007;
our $XOREOS_FILE_TYPE_ID_NANR = 21008;
our $XOREOS_FILE_TYPE_ID_NBFP = 21009;
our $XOREOS_FILE_TYPE_ID_NBFS = 21010;
our $XOREOS_FILE_TYPE_ID_NCER = 21011;
our $XOREOS_FILE_TYPE_ID_NCGR = 21012;
our $XOREOS_FILE_TYPE_ID_NCLR = 21013;
our $XOREOS_FILE_TYPE_ID_NFTR = 21014;
our $XOREOS_FILE_TYPE_ID_NSBCA = 21015;
our $XOREOS_FILE_TYPE_ID_NSBMD = 21016;
our $XOREOS_FILE_TYPE_ID_NSBTA = 21017;
our $XOREOS_FILE_TYPE_ID_NSBTP = 21018;
our $XOREOS_FILE_TYPE_ID_NSBTX = 21019;
our $XOREOS_FILE_TYPE_ID_PAL = 21020;
our $XOREOS_FILE_TYPE_ID_RAW = 21021;
our $XOREOS_FILE_TYPE_ID_SADL = 21022;
our $XOREOS_FILE_TYPE_ID_SDAT = 21023;
our $XOREOS_FILE_TYPE_ID_SMP = 21024;
our $XOREOS_FILE_TYPE_ID_SPL = 21025;
our $XOREOS_FILE_TYPE_ID_VX = 21026;
our $XOREOS_FILE_TYPE_ID_ANB = 22000;
our $XOREOS_FILE_TYPE_ID_ANI = 22001;
our $XOREOS_FILE_TYPE_ID_CNS = 22002;
our $XOREOS_FILE_TYPE_ID_CUR = 22003;
our $XOREOS_FILE_TYPE_ID_EVT = 22004;
our $XOREOS_FILE_TYPE_ID_FDL = 22005;
our $XOREOS_FILE_TYPE_ID_FXO = 22006;
our $XOREOS_FILE_TYPE_ID_GAD = 22007;
our $XOREOS_FILE_TYPE_ID_GDA = 22008;
our $XOREOS_FILE_TYPE_ID_GFX = 22009;
our $XOREOS_FILE_TYPE_ID_LDF = 22010;
our $XOREOS_FILE_TYPE_ID_LST = 22011;
our $XOREOS_FILE_TYPE_ID_MAL = 22012;
our $XOREOS_FILE_TYPE_ID_MAO = 22013;
our $XOREOS_FILE_TYPE_ID_MMH = 22014;
our $XOREOS_FILE_TYPE_ID_MOP = 22015;
our $XOREOS_FILE_TYPE_ID_MOR = 22016;
our $XOREOS_FILE_TYPE_ID_MSH = 22017;
our $XOREOS_FILE_TYPE_ID_MTX = 22018;
our $XOREOS_FILE_TYPE_ID_NCC = 22019;
our $XOREOS_FILE_TYPE_ID_PHY = 22020;
our $XOREOS_FILE_TYPE_ID_PLO = 22021;
our $XOREOS_FILE_TYPE_ID_STG = 22022;
our $XOREOS_FILE_TYPE_ID_TBI = 22023;
our $XOREOS_FILE_TYPE_ID_TNT = 22024;
our $XOREOS_FILE_TYPE_ID_ARL = 22025;
our $XOREOS_FILE_TYPE_ID_FEV = 22026;
our $XOREOS_FILE_TYPE_ID_FSB = 22027;
our $XOREOS_FILE_TYPE_ID_OPF = 22028;
our $XOREOS_FILE_TYPE_ID_CRF = 22029;
our $XOREOS_FILE_TYPE_ID_RIMP = 22030;
our $XOREOS_FILE_TYPE_ID_MET = 22031;
our $XOREOS_FILE_TYPE_ID_META = 22032;
our $XOREOS_FILE_TYPE_ID_FXR = 22033;
our $XOREOS_FILE_TYPE_ID_CIF = 22034;
our $XOREOS_FILE_TYPE_ID_CUB = 22035;
our $XOREOS_FILE_TYPE_ID_DLB = 22036;
our $XOREOS_FILE_TYPE_ID_NSC = 22037;
our $XOREOS_FILE_TYPE_ID_MOV = 23000;
our $XOREOS_FILE_TYPE_ID_CURS = 23001;
our $XOREOS_FILE_TYPE_ID_PICT = 23002;
our $XOREOS_FILE_TYPE_ID_RSRC = 23003;
our $XOREOS_FILE_TYPE_ID_PLIST = 23004;
our $XOREOS_FILE_TYPE_ID_CRE = 24000;
our $XOREOS_FILE_TYPE_ID_PSO = 24001;
our $XOREOS_FILE_TYPE_ID_VSO = 24002;
our $XOREOS_FILE_TYPE_ID_ABC = 24003;
our $XOREOS_FILE_TYPE_ID_SBM = 24004;
our $XOREOS_FILE_TYPE_ID_PVD = 24005;
our $XOREOS_FILE_TYPE_ID_PLA = 24006;
our $XOREOS_FILE_TYPE_ID_TRG = 24007;
our $XOREOS_FILE_TYPE_ID_PK = 24008;
our $XOREOS_FILE_TYPE_ID_ALS = 25000;
our $XOREOS_FILE_TYPE_ID_APL = 25001;
our $XOREOS_FILE_TYPE_ID_ASSEMBLY = 25002;
our $XOREOS_FILE_TYPE_ID_BAK = 25003;
our $XOREOS_FILE_TYPE_ID_BNK = 25004;
our $XOREOS_FILE_TYPE_ID_CL = 25005;
our $XOREOS_FILE_TYPE_ID_CNV = 25006;
our $XOREOS_FILE_TYPE_ID_CON = 25007;
our $XOREOS_FILE_TYPE_ID_DAT = 25008;
our $XOREOS_FILE_TYPE_ID_DX11 = 25009;
our $XOREOS_FILE_TYPE_ID_IDS = 25010;
our $XOREOS_FILE_TYPE_ID_LOG = 25011;
our $XOREOS_FILE_TYPE_ID_MAP = 25012;
our $XOREOS_FILE_TYPE_ID_MML = 25013;
our $XOREOS_FILE_TYPE_ID_MP3 = 25014;
our $XOREOS_FILE_TYPE_ID_PCK = 25015;
our $XOREOS_FILE_TYPE_ID_RML = 25016;
our $XOREOS_FILE_TYPE_ID_S = 25017;
our $XOREOS_FILE_TYPE_ID_STA = 25018;
our $XOREOS_FILE_TYPE_ID_SVR = 25019;
our $XOREOS_FILE_TYPE_ID_VLM = 25020;
our $XOREOS_FILE_TYPE_ID_WBD = 25021;
our $XOREOS_FILE_TYPE_ID_XBX = 25022;
our $XOREOS_FILE_TYPE_ID_XLS = 25023;
our $XOREOS_FILE_TYPE_ID_BZF = 26000;
our $XOREOS_FILE_TYPE_ID_ADV = 27000;
our $XOREOS_FILE_TYPE_ID_JSON = 28000;
our $XOREOS_FILE_TYPE_ID_TLK_EXPERT = 28001;
our $XOREOS_FILE_TYPE_ID_TLK_MOBILE = 28002;
our $XOREOS_FILE_TYPE_ID_TLK_TOUCH = 28003;
our $XOREOS_FILE_TYPE_ID_OTF = 28004;
our $XOREOS_FILE_TYPE_ID_PAR = 28005;
our $XOREOS_FILE_TYPE_ID_XWB = 29000;
our $XOREOS_FILE_TYPE_ID_XSB = 29001;
our $XOREOS_FILE_TYPE_ID_XDS = 30000;
our $XOREOS_FILE_TYPE_ID_WND = 30001;
our $XOREOS_FILE_TYPE_ID_XEOSITEX = 40000;

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
