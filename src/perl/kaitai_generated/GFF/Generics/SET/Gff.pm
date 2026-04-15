# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

use strict;
use warnings;
use IO::KaitaiStruct 0.011_000;
use BiowareCommon;
use BiowareGffCommon;
use Encode;

########################################################################
package Gff;

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

    $self->{file} = Gff::GffUnionFile->new($self->{_io}, $self, $self->{_root});
}

sub file {
    my ($self) = @_;
    return $self->{file};
}

########################################################################
package Gff::FieldArray;

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
    my $n_entries = $self->_root()->file()->gff3()->header()->field_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Gff::FieldEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

########################################################################
package Gff::FieldData;

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

    $self->{raw_data} = $self->{_io}->read_bytes($self->_root()->file()->gff3()->header()->field_data_count());
}

sub raw_data {
    my ($self) = @_;
    return $self->{raw_data};
}

########################################################################
package Gff::FieldEntry;

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

    $self->{field_type} = $self->{_io}->read_u4le();
    $self->{label_index} = $self->{_io}->read_u4le();
    $self->{data_or_offset} = $self->{_io}->read_u4le();
}

sub field_data_offset_value {
    my ($self) = @_;
    return $self->{field_data_offset_value} if ($self->{field_data_offset_value});
    if ($self->is_complex_type()) {
        $self->{field_data_offset_value} = $self->_root()->file()->gff3()->header()->field_data_offset() + $self->data_or_offset();
    }
    return $self->{field_data_offset_value};
}

sub is_complex_type {
    my ($self) = @_;
    return $self->{is_complex_type} if ($self->{is_complex_type});
    $self->{is_complex_type} =  (($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_UINT64) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_INT64) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_DOUBLE) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_STRING) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_RESREF) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_LOCALIZED_STRING) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_BINARY) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_VECTOR4) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_VECTOR3)) ;
    return $self->{is_complex_type};
}

sub is_list_type {
    my ($self) = @_;
    return $self->{is_list_type} if ($self->{is_list_type});
    $self->{is_list_type} = $self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_LIST;
    return $self->{is_list_type};
}

sub is_simple_type {
    my ($self) = @_;
    return $self->{is_simple_type} if ($self->{is_simple_type});
    $self->{is_simple_type} =  (($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_UINT8) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_INT8) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_UINT16) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_INT16) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_UINT32) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_INT32) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_SINGLE) || ($self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_STR_REF)) ;
    return $self->{is_simple_type};
}

sub is_struct_type {
    my ($self) = @_;
    return $self->{is_struct_type} if ($self->{is_struct_type});
    $self->{is_struct_type} = $self->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_STRUCT;
    return $self->{is_struct_type};
}

sub list_indices_offset_value {
    my ($self) = @_;
    return $self->{list_indices_offset_value} if ($self->{list_indices_offset_value});
    if ($self->is_list_type()) {
        $self->{list_indices_offset_value} = $self->_root()->file()->gff3()->header()->list_indices_offset() + $self->data_or_offset();
    }
    return $self->{list_indices_offset_value};
}

sub struct_index_value {
    my ($self) = @_;
    return $self->{struct_index_value} if ($self->{struct_index_value});
    if ($self->is_struct_type()) {
        $self->{struct_index_value} = $self->data_or_offset();
    }
    return $self->{struct_index_value};
}

sub field_type {
    my ($self) = @_;
    return $self->{field_type};
}

sub label_index {
    my ($self) = @_;
    return $self->{label_index};
}

sub data_or_offset {
    my ($self) = @_;
    return $self->{data_or_offset};
}

########################################################################
package Gff::FieldIndicesArray;

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

    $self->{indices} = [];
    my $n_indices = $self->_root()->file()->gff3()->header()->field_indices_count();
    for (my $i = 0; $i < $n_indices; $i++) {
        push @{$self->{indices}}, $self->{_io}->read_u4le();
    }
}

sub indices {
    my ($self) = @_;
    return $self->{indices};
}

########################################################################
package Gff::Gff3AfterAurora;

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

    $self->{header} = Gff::GffHeaderTail->new($self->{_io}, $self, $self->{_root});
}

sub field_array {
    my ($self) = @_;
    return $self->{field_array} if ($self->{field_array});
    if ($self->header()->field_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->field_offset());
        $self->{field_array} = Gff::FieldArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{field_array};
}

sub field_data {
    my ($self) = @_;
    return $self->{field_data} if ($self->{field_data});
    if ($self->header()->field_data_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->field_data_offset());
        $self->{field_data} = Gff::FieldData->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{field_data};
}

sub field_indices_array {
    my ($self) = @_;
    return $self->{field_indices_array} if ($self->{field_indices_array});
    if ($self->header()->field_indices_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->field_indices_offset());
        $self->{field_indices_array} = Gff::FieldIndicesArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{field_indices_array};
}

sub label_array {
    my ($self) = @_;
    return $self->{label_array} if ($self->{label_array});
    if ($self->header()->label_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->label_offset());
        $self->{label_array} = Gff::LabelArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{label_array};
}

sub list_indices_array {
    my ($self) = @_;
    return $self->{list_indices_array} if ($self->{list_indices_array});
    if ($self->header()->list_indices_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->list_indices_offset());
        $self->{list_indices_array} = Gff::ListIndicesArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{list_indices_array};
}

sub root_struct_resolved {
    my ($self) = @_;
    return $self->{root_struct_resolved} if ($self->{root_struct_resolved});
    $self->{root_struct_resolved} = Gff::ResolvedStruct->new($self->{_io}, $self, $self->{_root});
    return $self->{root_struct_resolved};
}

sub struct_array {
    my ($self) = @_;
    return $self->{struct_array} if ($self->{struct_array});
    if ($self->header()->struct_count() > 0) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->header()->struct_offset());
        $self->{struct_array} = Gff::StructArray->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{struct_array};
}

sub header {
    my ($self) = @_;
    return $self->{header};
}

########################################################################
package Gff::Gff4AfterAurora;

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

    $self->{platform_id} = $self->{_io}->read_u4be();
    $self->{file_type} = $self->{_io}->read_u4be();
    $self->{type_version} = $self->{_io}->read_u4be();
    $self->{num_struct_templates} = $self->{_io}->read_u4le();
    if ($self->aurora_version() == 1446260273) {
        $self->{string_count} = $self->{_io}->read_u4le();
    }
    if ($self->aurora_version() == 1446260273) {
        $self->{string_offset} = $self->{_io}->read_u4le();
    }
    $self->{data_offset} = $self->{_io}->read_u4le();
    $self->{struct_templates} = [];
    my $n_struct_templates = $self->num_struct_templates();
    for (my $i = 0; $i < $n_struct_templates; $i++) {
        push @{$self->{struct_templates}}, Gff::Gff4StructTemplateHeader->new($self->{_io}, $self, $self->{_root});
    }
    $self->{tail} = $self->{_io}->read_bytes_full();
}

sub platform_id {
    my ($self) = @_;
    return $self->{platform_id};
}

sub file_type {
    my ($self) = @_;
    return $self->{file_type};
}

sub type_version {
    my ($self) = @_;
    return $self->{type_version};
}

sub num_struct_templates {
    my ($self) = @_;
    return $self->{num_struct_templates};
}

sub string_count {
    my ($self) = @_;
    return $self->{string_count};
}

sub string_offset {
    my ($self) = @_;
    return $self->{string_offset};
}

sub data_offset {
    my ($self) = @_;
    return $self->{data_offset};
}

sub struct_templates {
    my ($self) = @_;
    return $self->{struct_templates};
}

sub tail {
    my ($self) = @_;
    return $self->{tail};
}

sub aurora_version {
    my ($self) = @_;
    return $self->{aurora_version};
}

########################################################################
package Gff::Gff4File;

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

    $self->{aurora_magic} = $self->{_io}->read_u4be();
    $self->{aurora_version} = $self->{_io}->read_u4be();
    $self->{gff4} = Gff::Gff4AfterAurora->new($self->{_io}, $self, $self->{_root});
}

sub aurora_magic {
    my ($self) = @_;
    return $self->{aurora_magic};
}

sub aurora_version {
    my ($self) = @_;
    return $self->{aurora_version};
}

sub gff4 {
    my ($self) = @_;
    return $self->{gff4};
}

########################################################################
package Gff::Gff4StructTemplateHeader;

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

    $self->{struct_label} = $self->{_io}->read_u4be();
    $self->{field_count} = $self->{_io}->read_u4le();
    $self->{field_offset} = $self->{_io}->read_u4le();
    $self->{struct_size} = $self->{_io}->read_u4le();
}

sub struct_label {
    my ($self) = @_;
    return $self->{struct_label};
}

sub field_count {
    my ($self) = @_;
    return $self->{field_count};
}

sub field_offset {
    my ($self) = @_;
    return $self->{field_offset};
}

sub struct_size {
    my ($self) = @_;
    return $self->{struct_size};
}

########################################################################
package Gff::GffHeaderTail;

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

    $self->{struct_offset} = $self->{_io}->read_u4le();
    $self->{struct_count} = $self->{_io}->read_u4le();
    $self->{field_offset} = $self->{_io}->read_u4le();
    $self->{field_count} = $self->{_io}->read_u4le();
    $self->{label_offset} = $self->{_io}->read_u4le();
    $self->{label_count} = $self->{_io}->read_u4le();
    $self->{field_data_offset} = $self->{_io}->read_u4le();
    $self->{field_data_count} = $self->{_io}->read_u4le();
    $self->{field_indices_offset} = $self->{_io}->read_u4le();
    $self->{field_indices_count} = $self->{_io}->read_u4le();
    $self->{list_indices_offset} = $self->{_io}->read_u4le();
    $self->{list_indices_count} = $self->{_io}->read_u4le();
}

sub struct_offset {
    my ($self) = @_;
    return $self->{struct_offset};
}

sub struct_count {
    my ($self) = @_;
    return $self->{struct_count};
}

sub field_offset {
    my ($self) = @_;
    return $self->{field_offset};
}

sub field_count {
    my ($self) = @_;
    return $self->{field_count};
}

sub label_offset {
    my ($self) = @_;
    return $self->{label_offset};
}

sub label_count {
    my ($self) = @_;
    return $self->{label_count};
}

sub field_data_offset {
    my ($self) = @_;
    return $self->{field_data_offset};
}

sub field_data_count {
    my ($self) = @_;
    return $self->{field_data_count};
}

sub field_indices_offset {
    my ($self) = @_;
    return $self->{field_indices_offset};
}

sub field_indices_count {
    my ($self) = @_;
    return $self->{field_indices_count};
}

sub list_indices_offset {
    my ($self) = @_;
    return $self->{list_indices_offset};
}

sub list_indices_count {
    my ($self) = @_;
    return $self->{list_indices_count};
}

########################################################################
package Gff::GffUnionFile;

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

    $self->{aurora_magic} = $self->{_io}->read_u4be();
    $self->{aurora_version} = $self->{_io}->read_u4be();
    if ( (($self->aurora_version() != 1446260272) && ($self->aurora_version() != 1446260273)) ) {
        $self->{gff3} = Gff::Gff3AfterAurora->new($self->{_io}, $self, $self->{_root});
    }
    if ( (($self->aurora_version() == 1446260272) || ($self->aurora_version() == 1446260273)) ) {
        $self->{gff4} = Gff::Gff4AfterAurora->new($self->{_io}, $self, $self->{_root});
    }
}

sub aurora_magic {
    my ($self) = @_;
    return $self->{aurora_magic};
}

sub aurora_version {
    my ($self) = @_;
    return $self->{aurora_version};
}

sub gff3 {
    my ($self) = @_;
    return $self->{gff3};
}

sub gff4 {
    my ($self) = @_;
    return $self->{gff4};
}

########################################################################
package Gff::LabelArray;

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
    my $n_labels = $self->_root()->file()->gff3()->header()->label_count();
    for (my $i = 0; $i < $n_labels; $i++) {
        push @{$self->{labels}}, Gff::LabelEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub labels {
    my ($self) = @_;
    return $self->{labels};
}

########################################################################
package Gff::LabelEntry;

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

    $self->{name} = Encode::decode("ASCII", $self->{_io}->read_bytes(16));
}

sub name {
    my ($self) = @_;
    return $self->{name};
}

########################################################################
package Gff::LabelEntryTerminated;

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

    $self->{name} = Encode::decode("ASCII", IO::KaitaiStruct::Stream::bytes_terminate($self->{_io}->read_bytes(16), 0, 0));
}

sub name {
    my ($self) = @_;
    return $self->{name};
}

########################################################################
package Gff::ListEntry;

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

    $self->{num_struct_indices} = $self->{_io}->read_u4le();
    $self->{struct_indices} = [];
    my $n_struct_indices = $self->num_struct_indices();
    for (my $i = 0; $i < $n_struct_indices; $i++) {
        push @{$self->{struct_indices}}, $self->{_io}->read_u4le();
    }
}

sub num_struct_indices {
    my ($self) = @_;
    return $self->{num_struct_indices};
}

sub struct_indices {
    my ($self) = @_;
    return $self->{struct_indices};
}

########################################################################
package Gff::ListIndicesArray;

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

    $self->{raw_data} = $self->{_io}->read_bytes($self->_root()->file()->gff3()->header()->list_indices_count());
}

sub raw_data {
    my ($self) = @_;
    return $self->{raw_data};
}

########################################################################
package Gff::ResolvedField;

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

}

sub entry {
    my ($self) = @_;
    return $self->{entry} if ($self->{entry});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_offset() + $self->field_index() * 12);
    $self->{entry} = Gff::FieldEntry->new($self->{_io}, $self, $self->{_root});
    $self->{_io}->seek($_pos);
    return $self->{entry};
}

sub field_entry_pos {
    my ($self) = @_;
    return $self->{field_entry_pos} if ($self->{field_entry_pos});
    $self->{field_entry_pos} = $self->_root()->file()->gff3()->header()->field_offset() + $self->field_index() * 12;
    return $self->{field_entry_pos};
}

sub label {
    my ($self) = @_;
    return $self->{label} if ($self->{label});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->_root()->file()->gff3()->header()->label_offset() + $self->entry()->label_index() * 16);
    $self->{label} = Gff::LabelEntryTerminated->new($self->{_io}, $self, $self->{_root});
    $self->{_io}->seek($_pos);
    return $self->{label};
}

sub list_entry {
    my ($self) = @_;
    return $self->{list_entry} if ($self->{list_entry});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_LIST) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->list_indices_offset() + $self->entry()->data_or_offset());
        $self->{list_entry} = Gff::ListEntry->new($self->{_io}, $self, $self->{_root});
        $self->{_io}->seek($_pos);
    }
    return $self->{list_entry};
}

sub list_structs {
    my ($self) = @_;
    return $self->{list_structs} if ($self->{list_structs});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_LIST) {
        $self->{list_structs} = [];
        my $n_list_structs = $self->list_entry()->num_struct_indices();
        for (my $i = 0; $i < $n_list_structs; $i++) {
            push @{$self->{list_structs}}, Gff::ResolvedStruct->new($self->{_io}, $self, $self->{_root});
        }
    }
    return $self->{list_structs};
}

sub value_binary {
    my ($self) = @_;
    return $self->{value_binary} if ($self->{value_binary});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_BINARY) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_data_offset() + $self->entry()->data_or_offset());
        $self->{value_binary} = BiowareCommon::BiowareBinaryData->new($self->{_io});
        $self->{_io}->seek($_pos);
    }
    return $self->{value_binary};
}

sub value_double {
    my ($self) = @_;
    return $self->{value_double} if ($self->{value_double});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_DOUBLE) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_data_offset() + $self->entry()->data_or_offset());
        $self->{value_double} = $self->{_io}->read_f8le();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_double};
}

sub value_int16 {
    my ($self) = @_;
    return $self->{value_int16} if ($self->{value_int16});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_INT16) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->field_entry_pos() + 8);
        $self->{value_int16} = $self->{_io}->read_s2le();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_int16};
}

sub value_int32 {
    my ($self) = @_;
    return $self->{value_int32} if ($self->{value_int32});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_INT32) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->field_entry_pos() + 8);
        $self->{value_int32} = $self->{_io}->read_s4le();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_int32};
}

sub value_int64 {
    my ($self) = @_;
    return $self->{value_int64} if ($self->{value_int64});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_INT64) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_data_offset() + $self->entry()->data_or_offset());
        $self->{value_int64} = $self->{_io}->read_s8le();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_int64};
}

sub value_int8 {
    my ($self) = @_;
    return $self->{value_int8} if ($self->{value_int8});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_INT8) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->field_entry_pos() + 8);
        $self->{value_int8} = $self->{_io}->read_s1();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_int8};
}

sub value_localized_string {
    my ($self) = @_;
    return $self->{value_localized_string} if ($self->{value_localized_string});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_LOCALIZED_STRING) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_data_offset() + $self->entry()->data_or_offset());
        $self->{value_localized_string} = BiowareCommon::BiowareLocstring->new($self->{_io});
        $self->{_io}->seek($_pos);
    }
    return $self->{value_localized_string};
}

sub value_resref {
    my ($self) = @_;
    return $self->{value_resref} if ($self->{value_resref});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_RESREF) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_data_offset() + $self->entry()->data_or_offset());
        $self->{value_resref} = BiowareCommon::BiowareResref->new($self->{_io});
        $self->{_io}->seek($_pos);
    }
    return $self->{value_resref};
}

sub value_single {
    my ($self) = @_;
    return $self->{value_single} if ($self->{value_single});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_SINGLE) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->field_entry_pos() + 8);
        $self->{value_single} = $self->{_io}->read_f4le();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_single};
}

sub value_str_ref {
    my ($self) = @_;
    return $self->{value_str_ref} if ($self->{value_str_ref});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_STR_REF) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->field_entry_pos() + 8);
        $self->{value_str_ref} = $self->{_io}->read_u4le();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_str_ref};
}

sub value_string {
    my ($self) = @_;
    return $self->{value_string} if ($self->{value_string});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_STRING) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_data_offset() + $self->entry()->data_or_offset());
        $self->{value_string} = BiowareCommon::BiowareCexoString->new($self->{_io});
        $self->{_io}->seek($_pos);
    }
    return $self->{value_string};
}

sub value_struct {
    my ($self) = @_;
    return $self->{value_struct} if ($self->{value_struct});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_STRUCT) {
        $self->{value_struct} = Gff::ResolvedStruct->new($self->{_io}, $self, $self->{_root});
    }
    return $self->{value_struct};
}

sub value_uint16 {
    my ($self) = @_;
    return $self->{value_uint16} if ($self->{value_uint16});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_UINT16) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->field_entry_pos() + 8);
        $self->{value_uint16} = $self->{_io}->read_u2le();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_uint16};
}

sub value_uint32 {
    my ($self) = @_;
    return $self->{value_uint32} if ($self->{value_uint32});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_UINT32) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->field_entry_pos() + 8);
        $self->{value_uint32} = $self->{_io}->read_u4le();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_uint32};
}

sub value_uint64 {
    my ($self) = @_;
    return $self->{value_uint64} if ($self->{value_uint64});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_UINT64) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_data_offset() + $self->entry()->data_or_offset());
        $self->{value_uint64} = $self->{_io}->read_u8le();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_uint64};
}

sub value_uint8 {
    my ($self) = @_;
    return $self->{value_uint8} if ($self->{value_uint8});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_UINT8) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->field_entry_pos() + 8);
        $self->{value_uint8} = $self->{_io}->read_u1();
        $self->{_io}->seek($_pos);
    }
    return $self->{value_uint8};
}

sub value_vector3 {
    my ($self) = @_;
    return $self->{value_vector3} if ($self->{value_vector3});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_VECTOR3) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_data_offset() + $self->entry()->data_or_offset());
        $self->{value_vector3} = BiowareCommon::BiowareVector3->new($self->{_io});
        $self->{_io}->seek($_pos);
    }
    return $self->{value_vector3};
}

sub value_vector4 {
    my ($self) = @_;
    return $self->{value_vector4} if ($self->{value_vector4});
    if ($self->entry()->field_type() == $BiowareGffCommon::GFF_FIELD_TYPE_VECTOR4) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_data_offset() + $self->entry()->data_or_offset());
        $self->{value_vector4} = BiowareCommon::BiowareVector4->new($self->{_io});
        $self->{_io}->seek($_pos);
    }
    return $self->{value_vector4};
}

sub field_index {
    my ($self) = @_;
    return $self->{field_index};
}

########################################################################
package Gff::ResolvedStruct;

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

}

sub entry {
    my ($self) = @_;
    return $self->{entry} if ($self->{entry});
    my $_pos = $self->{_io}->pos();
    $self->{_io}->seek($self->_root()->file()->gff3()->header()->struct_offset() + $self->struct_index() * 12);
    $self->{entry} = Gff::StructEntry->new($self->{_io}, $self, $self->{_root});
    $self->{_io}->seek($_pos);
    return $self->{entry};
}

sub field_indices {
    my ($self) = @_;
    return $self->{field_indices} if ($self->{field_indices});
    if ($self->entry()->field_count() > 1) {
        my $_pos = $self->{_io}->pos();
        $self->{_io}->seek($self->_root()->file()->gff3()->header()->field_indices_offset() + $self->entry()->data_or_offset());
        $self->{field_indices} = [];
        my $n_field_indices = $self->entry()->field_count();
        for (my $i = 0; $i < $n_field_indices; $i++) {
            push @{$self->{field_indices}}, $self->{_io}->read_u4le();
        }
        $self->{_io}->seek($_pos);
    }
    return $self->{field_indices};
}

sub fields {
    my ($self) = @_;
    return $self->{fields} if ($self->{fields});
    if ($self->entry()->field_count() > 1) {
        $self->{fields} = [];
        my $n_fields = $self->entry()->field_count();
        for (my $i = 0; $i < $n_fields; $i++) {
            push @{$self->{fields}}, Gff::ResolvedField->new($self->{_io}, $self, $self->{_root});
        }
    }
    return $self->{fields};
}

sub single_field {
    my ($self) = @_;
    return $self->{single_field} if ($self->{single_field});
    if ($self->entry()->field_count() == 1) {
        $self->{single_field} = Gff::ResolvedField->new($self->{_io}, $self, $self->{_root});
    }
    return $self->{single_field};
}

sub struct_index {
    my ($self) = @_;
    return $self->{struct_index};
}

########################################################################
package Gff::StructArray;

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
    my $n_entries = $self->_root()->file()->gff3()->header()->struct_count();
    for (my $i = 0; $i < $n_entries; $i++) {
        push @{$self->{entries}}, Gff::StructEntry->new($self->{_io}, $self, $self->{_root});
    }
}

sub entries {
    my ($self) = @_;
    return $self->{entries};
}

########################################################################
package Gff::StructEntry;

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

    $self->{struct_id} = $self->{_io}->read_u4le();
    $self->{data_or_offset} = $self->{_io}->read_u4le();
    $self->{field_count} = $self->{_io}->read_u4le();
}

sub field_indices_offset {
    my ($self) = @_;
    return $self->{field_indices_offset} if ($self->{field_indices_offset});
    if ($self->has_multiple_fields()) {
        $self->{field_indices_offset} = $self->data_or_offset();
    }
    return $self->{field_indices_offset};
}

sub has_multiple_fields {
    my ($self) = @_;
    return $self->{has_multiple_fields} if ($self->{has_multiple_fields});
    $self->{has_multiple_fields} = $self->field_count() > 1;
    return $self->{has_multiple_fields};
}

sub has_single_field {
    my ($self) = @_;
    return $self->{has_single_field} if ($self->{has_single_field});
    $self->{has_single_field} = $self->field_count() == 1;
    return $self->{has_single_field};
}

sub single_field_index {
    my ($self) = @_;
    return $self->{single_field_index} if ($self->{single_field_index});
    if ($self->has_single_field()) {
        $self->{single_field_index} = $self->data_or_offset();
    }
    return $self->{single_field_index};
}

sub struct_id {
    my ($self) = @_;
    return $self->{struct_id};
}

sub data_or_offset {
    my ($self) = @_;
    return $self->{data_or_offset};
}

sub field_count {
    my ($self) = @_;
    return $self->{field_count};
}

1;
