#ifndef BIOWARE_TSLPATCHER_COMMON_H_
#define BIOWARE_TSLPATCHER_COMMON_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bioware_tslpatcher_common_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <set>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * Shared enums and small helper types used by TSLPatcher-style tooling.
 * 
 * Notes:
 * - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
 *   so string-valued enums are modeled here as small string wrapper types with `valid` constraints.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60 xoreos — `FileType` enum start (engine archive IDs; TSLPatcher enums here are community patch metadata, not read from `swkotor.exe`)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/patcher.py#L43-L120 PyKotor — `ModInstaller` (apply / backup entry band)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/memory.py#L1-L80 PyKotor — `memory` (patch address space / token helpers)
 * \sa https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/tslpatcher/ PyKotor — `tslpatcher/` package
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py PyKotor — TwoDA patch helpers
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py PyKotor — NCS patch helpers
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py PyKotor — TSLPatcher logging
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py PyKotor — diff resource objects
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (TSLPatcher metadata; no dedicated PDF)
 */

class bioware_tslpatcher_common_t : public kaitai::kstruct {

public:
    class bioware_diff_format_str_t;
    class bioware_diff_resource_type_str_t;
    class bioware_diff_type_str_t;
    class bioware_ncs_token_type_str_t;

    enum bioware_tslpatcher_log_type_id_t {
        BIOWARE_TSLPATCHER_LOG_TYPE_ID_VERBOSE = 0,
        BIOWARE_TSLPATCHER_LOG_TYPE_ID_NOTE = 1,
        BIOWARE_TSLPATCHER_LOG_TYPE_ID_WARNING = 2,
        BIOWARE_TSLPATCHER_LOG_TYPE_ID_ERROR = 3
    };
    static bool _is_defined_bioware_tslpatcher_log_type_id_t(bioware_tslpatcher_log_type_id_t v);

private:
    static const std::set<bioware_tslpatcher_log_type_id_t> _values_bioware_tslpatcher_log_type_id_t;
    static std::set<bioware_tslpatcher_log_type_id_t> _build_values_bioware_tslpatcher_log_type_id_t();

public:

    enum bioware_tslpatcher_target_type_id_t {
        BIOWARE_TSLPATCHER_TARGET_TYPE_ID_ROW_INDEX = 0,
        BIOWARE_TSLPATCHER_TARGET_TYPE_ID_ROW_LABEL = 1,
        BIOWARE_TSLPATCHER_TARGET_TYPE_ID_LABEL_COLUMN = 2
    };
    static bool _is_defined_bioware_tslpatcher_target_type_id_t(bioware_tslpatcher_target_type_id_t v);

private:
    static const std::set<bioware_tslpatcher_target_type_id_t> _values_bioware_tslpatcher_target_type_id_t;
    static std::set<bioware_tslpatcher_target_type_id_t> _build_values_bioware_tslpatcher_target_type_id_t();

public:

    bioware_tslpatcher_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_tslpatcher_common_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bioware_tslpatcher_common_t();

    /**
     * String-valued enum equivalent for DiffFormat (null-terminated ASCII).
     */

    class bioware_diff_format_str_t : public kaitai::kstruct {

    public:

        bioware_diff_format_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_tslpatcher_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_diff_format_str_t();

    private:
        std::string m_value;
        bioware_tslpatcher_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:
        std::string value() const { return m_value; }
        bioware_tslpatcher_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
     */

    class bioware_diff_resource_type_str_t : public kaitai::kstruct {

    public:

        bioware_diff_resource_type_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_tslpatcher_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_diff_resource_type_str_t();

    private:
        std::string m_value;
        bioware_tslpatcher_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:
        std::string value() const { return m_value; }
        bioware_tslpatcher_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * String-valued enum equivalent for DiffType (null-terminated ASCII).
     */

    class bioware_diff_type_str_t : public kaitai::kstruct {

    public:

        bioware_diff_type_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_tslpatcher_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_diff_type_str_t();

    private:
        std::string m_value;
        bioware_tslpatcher_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:
        std::string value() const { return m_value; }
        bioware_tslpatcher_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
     */

    class bioware_ncs_token_type_str_t : public kaitai::kstruct {

    public:

        bioware_ncs_token_type_str_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_tslpatcher_common_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bioware_ncs_token_type_str_t();

    private:
        std::string m_value;
        bioware_tslpatcher_common_t* m__root;
        kaitai::kstruct* m__parent;

    public:
        std::string value() const { return m_value; }
        bioware_tslpatcher_common_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

private:
    bioware_tslpatcher_common_t* m__root;
    kaitai::kstruct* m__parent;

public:
    bioware_tslpatcher_common_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BIOWARE_TSLPATCHER_COMMON_H_
