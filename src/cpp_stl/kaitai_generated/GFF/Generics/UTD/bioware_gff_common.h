#ifndef BIOWARE_GFF_COMMON_H_
#define BIOWARE_GFF_COMMON_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bioware_gff_common_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <set>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).
 * 
 * Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
 * (PyKotor / reone / wiki line anchors; `GFF.ksy` for per-field **observed behavior**.)
 * 
 * **GFF4** uses a different container/struct layout on disk (`GFF4File::Header::read` in `meta.xref.xoreos_gff4file_header_read`);
 * this enum remains the **GFF3** field-type table unless a future split spec proves wire-identical IDs across both.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types PyKotor wiki — GFF data types
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 PyKotor — `GFFFieldType` enum
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L197-L273 PyKotor — field read dispatch
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — `GFF3File::readHeader`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L59-L82 xoreos — `GFF4File::Header::read` (GFF4 container; distinct from GFF3 field tags above)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225 reone — `GffReader`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176 xoreos-tools — `gffdumper` (identify / dump)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60 xoreos-tools — `gffcreator` (create)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 */

class bioware_gff_common_t : public kaitai::kstruct {

public:

    enum gff_field_type_t {
        GFF_FIELD_TYPE_UINT8 = 0,
        GFF_FIELD_TYPE_INT8 = 1,
        GFF_FIELD_TYPE_UINT16 = 2,
        GFF_FIELD_TYPE_INT16 = 3,
        GFF_FIELD_TYPE_UINT32 = 4,
        GFF_FIELD_TYPE_INT32 = 5,
        GFF_FIELD_TYPE_UINT64 = 6,
        GFF_FIELD_TYPE_INT64 = 7,
        GFF_FIELD_TYPE_SINGLE = 8,
        GFF_FIELD_TYPE_DOUBLE = 9,
        GFF_FIELD_TYPE_STRING = 10,
        GFF_FIELD_TYPE_RESREF = 11,
        GFF_FIELD_TYPE_LOCALIZED_STRING = 12,
        GFF_FIELD_TYPE_BINARY = 13,
        GFF_FIELD_TYPE_STRUCT = 14,
        GFF_FIELD_TYPE_LIST = 15,
        GFF_FIELD_TYPE_VECTOR4 = 16,
        GFF_FIELD_TYPE_VECTOR3 = 17,
        GFF_FIELD_TYPE_STR_REF = 18
    };
    static bool _is_defined_gff_field_type_t(gff_field_type_t v);

private:
    static const std::set<gff_field_type_t> _values_gff_field_type_t;
    static std::set<gff_field_type_t> _build_values_gff_field_type_t();

public:

    bioware_gff_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_gff_common_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bioware_gff_common_t();

private:
    bioware_gff_common_t* m__root;
    kaitai::kstruct* m__parent;

public:
    bioware_gff_common_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BIOWARE_GFF_COMMON_H_
