<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).
 * 
 * Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
 * (PyKotor / reone / wiki line anchors; `GFF.ksy` for per-field **observed behavior**.)
 * 
 * **GFF4** uses a different container/struct layout on disk (`GFF4File::Header::read` in `meta.xref.xoreos_gff4file_header_read`);
 * this enum remains the **GFF3** field-type table unless a future split spec proves wire-identical IDs across both.
 */

namespace {
    class BiowareGffCommon extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareGffCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
        }
    }
}

namespace BiowareGffCommon {
    class GffFieldType {

        /**
         * Numeric 0 — UINT8; value in `GFFFieldData.data_or_data_offset` (+8). **Observed behavior** on `k1_win_gog_swkotor.exe`:
         * `GFFFieldTypes` on `GFFFieldData.field_type` @ +0. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
         * PyKotor `GFFBinaryReader._load_field_value_by_id`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L244-L246
         */
        const UINT8 = 0;

        /**
         * Numeric 1 — INT8 in low byte of the 4-byte inline slot (+8).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L247-L251
         */
        const INT8 = 1;

        /**
         * Numeric 2 — UINT16 LE at +8.
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L252-L254
         */
        const UINT16 = 2;

        /**
         * Numeric 3 — INT16 LE at +8.
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L255-L259
         */
        const INT16 = 3;

        /**
         * Numeric 4 — UINT32; full inline DWORD at +8.
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L260-L262
         */
        const UINT32 = 4;

        /**
         * Numeric 5 — INT32 inline. Engine: `CResGFF::ReadFieldINT` @ `0x00411c90` (uses `GetField` @ `0x00410990`).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L263-L267
         */
        const INT32 = 5;

        /**
         * Numeric 6 — UINT64 payload in `field_data` at `field_data_offset` + relative offset from +8.
         * PyKotor (complex-field branch): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L215
         */
        const UINT64 = 6;

        /**
         * Numeric 7 — INT64 in `field_data`.
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L216-L217
         */
        const INT64 = 7;

        /**
         * Numeric 8 — 32-bit IEEE float inline at +8.
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L272
         */
        const SINGLE = 8;

        /**
         * Numeric 9 — 64-bit IEEE float in `field_data`.
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L218-L219
         */
        const DOUBLE = 9;

        /**
         * Numeric 10 — CExoString in `field_data` (`bioware_cexo_string` in this repo).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L222
         */
        const STRING = 10;

        /**
         * Numeric 11 — ResRef in `field_data` (`bioware_resref`).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L223-L226
         */
        const RESREF = 11;

        /**
         * Numeric 12 — CExoLocString in `field_data` (`bioware_locstring`).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L227-L229
         */
        const LOCALIZED_STRING = 12;

        /**
         * Numeric 13 — length-prefixed octets in `field_data` (`bioware_binary_data`).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L230-L232
         */
        const BINARY = 13;

        /**
         * Numeric 14 — nested struct; +8 word is index into `GFFStructData` table (`struct_offset` + index×12).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L237-L241
         */
        const STRUCT = 14;

        /**
         * Numeric 15 — list; +8 word is byte offset into list-indices arena (`list_indices_offset` + offset).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L242-L243
         */
        const LIST = 15;

        /**
         * Numeric 16 — four floats in `field_data` (`bioware_vector4`).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L235-L236
         */
        const VECTOR4 = 16;

        /**
         * Numeric 17 — three floats in `field_data` (`bioware_vector3`).
         * PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L233-L234
         */
        const VECTOR3 = 17;

        /**
         * Numeric 18 — TLK StrRef (**KotOR / this schema:** inline `u32` at `GFFFieldData.data_or_data_offset`, i.e. file offset `field_offset + row*12 + 8`).
         * KotOR extension; same width as type 5, distinct field kind in data.
         * **Observed behavior**: `GFFFieldTypes` on `/K1/k1_win_gog_swkotor.exe`.
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types — row “StrRef”; StrRef semantics: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
         * PyKotor `GFFFieldType` stops at `Vector3 = 17` (no enum member for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367; `GFFBinaryReader` documents missing branch: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
         * reone `Gff::FieldType::StrRef` + `readStrRefFieldData` (**`field_data` blob**, not inline +8): https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204
         * Community threads / mirrors (tool changelogs, VECTOR/ORIENTATION/StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
         */
        const STR_REF = 18;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 8 => true, 9 => true, 10 => true, 11 => true, 12 => true, 13 => true, 14 => true, 15 => true, 16 => true, 17 => true, 18 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}
