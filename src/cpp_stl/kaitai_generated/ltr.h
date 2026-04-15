#ifndef LTR_H_
#define LTR_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class ltr_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_common.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
 * `letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
 * `bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format PyKotor wiki — LTR
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L135-L168 xoreos — LTR::load
 */

class ltr_t : public kaitai::kstruct {

public:
    class double_letter_blocks_array_t;
    class letter_block_t;
    class triple_letter_blocks_array_t;
    class triple_letter_row_t;

    ltr_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, ltr_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~ltr_t();

    /**
     * Array of double-letter blocks. One block per character in the alphabet.
     * Each block is indexed by the previous character (context length 1).
     */

    class double_letter_blocks_array_t : public kaitai::kstruct {

    public:

        double_letter_blocks_array_t(kaitai::kstream* p__io, ltr_t* p__parent = 0, ltr_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~double_letter_blocks_array_t();

    private:
        std::vector<letter_block_t*>* m_blocks;
        ltr_t* m__root;
        ltr_t* m__parent;

    public:

        /**
         * Array of letter_count blocks, each containing start/middle/end probability arrays.
         * Block index corresponds to the previous character in the alphabet.
         */
        std::vector<letter_block_t*>* blocks() const { return m_blocks; }
        ltr_t* _root() const { return m__root; }
        ltr_t* _parent() const { return m__parent; }
    };

    /**
     * A probability block containing three arrays of probabilities (start, middle, end).
     * Each array has letter_count floats representing cumulative probabilities for each character
     * in the alphabet appearing at that position (start, middle, or end of name).
     * 
     * Blocks store cumulative probabilities (monotonically increasing floats) that are compared
     * against random roll values during name generation.
     */

    class letter_block_t : public kaitai::kstruct {

    public:

        letter_block_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, ltr_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~letter_block_t();

    private:
        std::vector<float>* m_start_probabilities;
        std::vector<float>* m_middle_probabilities;
        std::vector<float>* m_end_probabilities;
        ltr_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Array of start probabilities. One float per character in alphabet.
         * Probability of each letter starting a name (no context for singles,
         * after previous character for doubles, after previous two for triples).
         */
        std::vector<float>* start_probabilities() const { return m_start_probabilities; }

        /**
         * Array of middle probabilities. One float per character in alphabet.
         * Probability of each letter appearing in the middle of a name.
         */
        std::vector<float>* middle_probabilities() const { return m_middle_probabilities; }

        /**
         * Array of end probabilities. One float per character in alphabet.
         * Probability of each letter ending a name.
         */
        std::vector<float>* end_probabilities() const { return m_end_probabilities; }
        ltr_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
     * Each block is indexed by the previous two characters (context length 2).
     */

    class triple_letter_blocks_array_t : public kaitai::kstruct {

    public:

        triple_letter_blocks_array_t(kaitai::kstream* p__io, ltr_t* p__parent = 0, ltr_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~triple_letter_blocks_array_t();

    private:
        std::vector<triple_letter_row_t*>* m_rows;
        ltr_t* m__root;
        ltr_t* m__parent;

    public:

        /**
         * Array of letter_count rows, each containing letter_count blocks.
         * First index corresponds to the second-to-last character.
         * Second index corresponds to the last character.
         */
        std::vector<triple_letter_row_t*>* rows() const { return m_rows; }
        ltr_t* _root() const { return m__root; }
        ltr_t* _parent() const { return m__parent; }
    };

    /**
     * A row in the triple-letter blocks array. Contains letter_count blocks,
     * each indexed by the last character in the two-character context.
     */

    class triple_letter_row_t : public kaitai::kstruct {

    public:

        triple_letter_row_t(kaitai::kstream* p__io, ltr_t::triple_letter_blocks_array_t* p__parent = 0, ltr_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~triple_letter_row_t();

    private:
        std::vector<letter_block_t*>* m_blocks;
        ltr_t* m__root;
        ltr_t::triple_letter_blocks_array_t* m__parent;

    public:

        /**
         * Array of letter_count blocks, each containing start/middle/end probability arrays.
         * Block index corresponds to the last character in the two-character context.
         */
        std::vector<letter_block_t*>* blocks() const { return m_blocks; }
        ltr_t* _root() const { return m__root; }
        ltr_t::triple_letter_blocks_array_t* _parent() const { return m__parent; }
    };

private:
    std::string m_file_type;
    std::string m_file_version;
    bioware_common_t::bioware_ltr_alphabet_length_t m_letter_count;
    letter_block_t* m_single_letter_block;
    double_letter_blocks_array_t* m_double_letter_blocks;
    triple_letter_blocks_array_t* m_triple_letter_blocks;
    ltr_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * File type signature. Must be "LTR " (space-padded) for LTR files.
     */
    std::string file_type() const { return m_file_type; }

    /**
     * File format version. Must be "V1.0" for LTR files.
     */
    std::string file_version() const { return m_file_version; }

    /**
     * Alphabet size (`u1`). Canonical enum: `formats/Common/bioware_common.ksy` → `bioware_ltr_alphabet_length`
     * (26 = NWN `a-z`; 28 = KotOR `a-z` + `'` + `-`). For `repeat-expr` counts use `letter_count.to_i` (Kaitai: enum → int, user guide §6.4.5).
     */
    bioware_common_t::bioware_ltr_alphabet_length_t letter_count() const { return m_letter_count; }

    /**
     * Single-letter probability block (no context).
     * Used for generating the first character of names.
     * Contains start/middle/end probability arrays, each with letter_count floats.
     * Total size: letter_count × 3 × 4 bytes = 336 bytes for KotOR (28 chars).
     */
    letter_block_t* single_letter_block() const { return m_single_letter_block; }

    /**
     * Double-letter probability blocks (1-character context).
     * Array of letter_count blocks, each indexed by the previous character.
     * Used for generating the second character based on the first character.
     * Each block contains start/middle/end probability arrays.
     * Total size: letter_count × 3 × letter_count × 4 bytes = 9,408 bytes for KotOR.
     */
    double_letter_blocks_array_t* double_letter_blocks() const { return m_double_letter_blocks; }

    /**
     * Triple-letter probability blocks (2-character context).
     * Two-dimensional array of letter_count × letter_count blocks.
     * Each block is indexed by the previous two characters.
     * Used for generating third and subsequent characters.
     * Each block contains start/middle/end probability arrays.
     * Total size: letter_count × letter_count × 3 × letter_count × 4 bytes = 73,472 bytes for KotOR.
     */
    triple_letter_blocks_array_t* triple_letter_blocks() const { return m_triple_letter_blocks; }
    ltr_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // LTR_H_
