<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).
 * 
 * - `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
 *   (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
 * - `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
 *   decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
 * - `ncs_program_size_marker` is the fixed header byte after `"V1.0"` in retail KotOR NCS blobs (`0x42`).
 * 
 * **Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
 * duplicating opcode lists.
 */

namespace {
    class BiowareNcsCommon extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareNcsCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
        }
    }
}

namespace BiowareNcsCommon {
    class NcsBytecode {
        const RESERVED_BC = 0;
        const CPDOWNSP = 1;
        const RSADDX = 2;
        const CPTOPSP = 3;
        const CONSTX = 4;
        const ACTION = 5;
        const LOGANDXX = 6;
        const LOGORXX = 7;
        const INCORXX = 8;
        const EXCORXX = 9;
        const BOOLANDXX = 10;
        const EQUALXX = 11;
        const NEQUALXX = 12;
        const GEQXX = 13;
        const GTXX = 14;
        const LTXX = 15;
        const LEQXX = 16;
        const SHLEFTXX = 17;
        const SHRIGHTXX = 18;
        const USHRIGHTXX = 19;
        const ADDXX = 20;
        const SUBXX = 21;
        const MULXX = 22;
        const DIVXX = 23;
        const MODXX = 24;
        const NEGX = 25;
        const COMPX = 26;
        const MOVSP = 27;
        const UNUSED_GAP = 28;
        const JMP = 29;
        const JSR = 30;
        const JZ = 31;
        const RETN = 32;
        const DESTRUCT = 33;
        const NOTX = 34;
        const DECXSP = 35;
        const INCXSP = 36;
        const JNZ = 37;
        const CPDOWNBP = 38;
        const CPTOPBP = 39;
        const DECXBP = 40;
        const INCXBP = 41;
        const SAVEBP = 42;
        const RESTOREBP = 43;
        const STORE_STATE = 44;
        const NOP = 45;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 3 => true, 4 => true, 5 => true, 6 => true, 7 => true, 8 => true, 9 => true, 10 => true, 11 => true, 12 => true, 13 => true, 14 => true, 15 => true, 16 => true, 17 => true, 18 => true, 19 => true, 20 => true, 21 => true, 22 => true, 23 => true, 24 => true, 25 => true, 26 => true, 27 => true, 28 => true, 29 => true, 30 => true, 31 => true, 32 => true, 33 => true, 34 => true, 35 => true, 36 => true, 37 => true, 38 => true, 39 => true, 40 => true, 41 => true, 42 => true, 43 => true, 44 => true, 45 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareNcsCommon {
    class NcsInstructionQualifier {
        const NONE = 0;
        const UNARY_OPERAND_LAYOUT = 1;
        const INT_TYPE = 3;
        const FLOAT_TYPE = 4;
        const STRING_TYPE = 5;
        const OBJECT_TYPE = 6;
        const EFFECT_TYPE = 16;
        const EVENT_TYPE = 17;
        const LOCATION_TYPE = 18;
        const TALENT_TYPE = 19;
        const INT_INT = 32;
        const FLOAT_FLOAT = 33;
        const OBJECT_OBJECT = 34;
        const STRING_STRING = 35;
        const STRUCT_STRUCT = 36;
        const INT_FLOAT = 37;
        const FLOAT_INT = 38;
        const EFFECT_EFFECT = 48;
        const EVENT_EVENT = 49;
        const LOCATION_LOCATION = 50;
        const TALENT_TALENT = 51;
        const VECTOR_VECTOR = 58;
        const VECTOR_FLOAT = 59;
        const FLOAT_VECTOR = 60;

        private const _VALUES = [0 => true, 1 => true, 3 => true, 4 => true, 5 => true, 6 => true, 16 => true, 17 => true, 18 => true, 19 => true, 32 => true, 33 => true, 34 => true, 35 => true, 36 => true, 37 => true, 38 => true, 48 => true, 49 => true, 50 => true, 51 => true, 58 => true, 59 => true, 60 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareNcsCommon {
    class NcsProgramSizeMarker {
        const PROGRAM_SIZE_PREFIX = 66;

        private const _VALUES = [66 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}
