#ifndef TWODA_H_
#define TWODA_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class twoda_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * TwoDA (2D Array) files store tabular data in a binary format used by BioWare games
 * including Knights of the Old Republic (KotOR) and The Sith Lords (TSL).
 * 
 * TwoDA files are essentially two-dimensional arrays (tables) with:
 * - Column headers (first row defines column names)
 * - Row labels (first column defines row identifiers)
 * - Cell values (data at row/column intersections)
 * 
 * Binary Format Structure:
 * - File Header (9 bytes): Magic "2DA " (space-padded), version "V2.b", and newline
 * - Column Headers Section: Tab-separated column names, terminated by null byte
 * - Row Count (4 bytes): uint32 indicating number of data rows
 * - Row Labels Section: Tab-separated row labels (one per row)
 * - Cell Offsets Array: Array of uint16 offsets (rowCount * columnCount entries)
 * - Data Size (2 bytes): uint16 indicating total size of cell data section
 * - Cell Values Section: Null-terminated strings at offsets specified in offsets array
 * 
 * The format uses an offset-based string table for cell values, allowing efficient
 * storage of duplicate values (shared strings are stored once and referenced by offset).
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py
 * - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py
 */

class twoda_t : public kaitai::kstruct {

public:
    class cell_values_section_t;
    class row_label_entry_t;
    class row_labels_section_t;
    class twoda_header_t;

    twoda_t(uint32_t p_column_count, kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, twoda_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~twoda_t();

    class cell_values_section_t : public kaitai::kstruct {

    public:

        cell_values_section_t(kaitai::kstream* p__io, twoda_t* p__parent = 0, twoda_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~cell_values_section_t();

    private:
        std::string m_raw_data;
        twoda_t* m__root;
        twoda_t* m__parent;

    public:

        /**
         * Raw cell values data as a single string.
         * Contains all null-terminated cell value strings concatenated together.
         * Individual strings can be extracted using offsets from cell_offsets.
         * Note: To read a specific cell value, seek to (cell_values_section start + offset) and read a null-terminated string.
         */
        std::string raw_data() const { return m_raw_data; }
        twoda_t* _root() const { return m__root; }
        twoda_t* _parent() const { return m__parent; }
    };

    class row_label_entry_t : public kaitai::kstruct {

    public:

        row_label_entry_t(kaitai::kstream* p__io, twoda_t::row_labels_section_t* p__parent = 0, twoda_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~row_label_entry_t();

    private:
        std::string m_label_value;
        twoda_t* m__root;
        twoda_t::row_labels_section_t* m__parent;

    public:

        /**
         * Row label value (ASCII string terminated by tab character 0x09).
         * Tab terminator is consumed but not included in the string value.
         * Row labels uniquely identify each row in the table.
         * Often numeric (e.g., "0", "1", "2") but can be any string identifier.
         */
        std::string label_value() const { return m_label_value; }
        twoda_t* _root() const { return m__root; }
        twoda_t::row_labels_section_t* _parent() const { return m__parent; }
    };

    class row_labels_section_t : public kaitai::kstruct {

    public:

        row_labels_section_t(kaitai::kstream* p__io, twoda_t* p__parent = 0, twoda_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~row_labels_section_t();

    private:
        std::vector<row_label_entry_t*>* m_labels;
        twoda_t* m__root;
        twoda_t* m__parent;

    public:

        /**
         * Array of row label entries, one per row.
         * Each label is terminated by tab character (0x09).
         * Total count equals row_count from the header.
         * Row labels typically identify each data row (e.g., numeric IDs, names, etc.).
         */
        std::vector<row_label_entry_t*>* labels() const { return m_labels; }
        twoda_t* _root() const { return m__root; }
        twoda_t* _parent() const { return m__parent; }
    };

    class twoda_header_t : public kaitai::kstruct {

    public:

        twoda_header_t(kaitai::kstream* p__io, twoda_t* p__parent = 0, twoda_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~twoda_header_t();

    private:
        bool f_is_valid_twoda;
        bool m_is_valid_twoda;

    public:

        /**
         * Validation check that the file is a valid TwoDA file.
         * All header fields must match expected values.
         */
        bool is_valid_twoda();

    private:
        std::string m_magic;
        std::string m_version;
        uint8_t m_newline;
        twoda_t* m__root;
        twoda_t* m__parent;

    public:

        /**
         * File type signature. Must be "2DA " (space-padded).
         * Bytes: 0x32 0x44 0x41 0x20
         * The space after "2DA" is significant and must be present.
         */
        std::string magic() const { return m_magic; }

        /**
         * File format version. Always "V2.b" for KotOR/TSL TwoDA files.
         * Bytes: 0x56 0x32 0x2E 0x62
         * This is the binary version identifier (V2.b = Version 2 binary).
         */
        std::string version() const { return m_version; }

        /**
         * Newline character (0x0A = '\n').
         * Separates header from column headers section.
         */
        uint8_t newline() const { return m_newline; }
        twoda_t* _root() const { return m__root; }
        twoda_t* _parent() const { return m__parent; }
    };

private:
    twoda_header_t* m_header;
    std::string m_column_headers_raw;
    uint32_t m_row_count;
    row_labels_section_t* m_row_labels_section;
    std::vector<uint16_t>* m_cell_offsets;
    uint16_t m_len_cell_values_section;
    cell_values_section_t* m_cell_values_section;
    uint32_t m_column_count;
    twoda_t* m__root;
    kaitai::kstruct* m__parent;
    std::string m__raw_cell_values_section;
    kaitai::kstream* m__io__raw_cell_values_section;

public:

    /**
     * TwoDA file header (9 bytes) - magic "2DA ", version "V2.b", and newline character
     */
    twoda_header_t* header() const { return m_header; }

    /**
     * Column headers section as a single null-terminated string.
     * Contains tab-separated column names. The null terminator marks the end.
     * Column names can be extracted by splitting on tab characters (0x09).
     * Example: "col1\tcol2\tcol3\0" represents three columns: "col1", "col2", "col3"
     */
    std::string column_headers_raw() const { return m_column_headers_raw; }

    /**
     * Number of data rows in the TwoDA table.
     * This count determines how many row labels and how many cell entries per column.
     */
    uint32_t row_count() const { return m_row_count; }

    /**
     * Row labels section - tab-separated row labels (one per row)
     */
    row_labels_section_t* row_labels_section() const { return m_row_labels_section; }

    /**
     * Array of cell value offsets (uint16 per cell). There are exactly row_count * column_count
     * entries, in row-major order. Each offset is relative to the start of the cell values blob
     * and points to a null-terminated string.
     */
    std::vector<uint16_t>* cell_offsets() const { return m_cell_offsets; }

    /**
     * Total size in bytes of the cell values data section.
     * This is the size of all unique cell value strings combined (including null terminators).
     * Not used during reading but stored for format consistency.
     */
    uint16_t len_cell_values_section() const { return m_len_cell_values_section; }

    /**
     * Cell values data section containing all unique cell value strings.
     * Each string is null-terminated. Offsets from cell_offsets point into this section.
     * The section starts immediately after len_cell_values_section field and has size = len_cell_values_section bytes.
     */
    cell_values_section_t* cell_values_section() const { return m_cell_values_section; }

    /**
     * Number of tab-separated column headers in the file (excluding the trailing null terminator).
     * Kaitai expressions cannot derive this from the header blob, so callers must pre-scan the
     * column header section (same rule as PyKotor: count tab characters between the newline after
     * V2.b and the first 0x00) and pass it into the parser.
     */
    uint32_t column_count() const { return m_column_count; }
    twoda_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
    std::string _raw_cell_values_section() const { return m__raw_cell_values_section; }
    kaitai::kstream* _io__raw_cell_values_section() const { return m__io__raw_cell_values_section; }
};

#endif  // TWODA_H_
