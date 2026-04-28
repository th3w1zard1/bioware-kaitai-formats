<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * Wire enums shared by `formats/MDL/MDL.ksy` (imported there as `bioware_mdl_common`; field-bound on `model_type` and
 * `controller.type`; `node_header.node_type` is a bitmask so MDL.ksy keeps it as raw `u2` and references this enum for docs).
 * Tooling alignment: PyKotor / MDLOps / xoreos.
 * 
 * - `model_classification` — `model_header.model_type` (`u1`).
 * - `node_type_value` — primary node discriminator in `node_header.node_type` (`u2`); bitmask flags on the same field are documented in MDL.ksy.
 * - `controller_type` — **partial** list of `controller.type` (`u4`) values (common KotOR / Aurora); many emitter-specific IDs exist — see PyKotor wiki + torlack `binmdl` for the full set. `formats/MDL/MDL.ksy` attaches this enum to `controller.type`; unknown numeric IDs may still appear in data and should be treated as vendor-defined extensions.
 */

namespace {
    class BiowareMdlCommon extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\BiowareMdlCommon $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
        }
    }
}

namespace BiowareMdlCommon {
    class ControllerType {
        const POSITION = 8;
        const ORIENTATION = 20;
        const SCALE = 36;
        const COLOR = 76;
        const EMITTER_ALPHA_END = 80;
        const EMITTER_ALPHA_START = 84;
        const RADIUS = 88;
        const EMITTER_BOUNCE_COEFFICIENT = 92;
        const SHADOW_RADIUS = 96;
        const VERTICAL_DISPLACEMENT_OR_DRAG_OR_SELFILLUMCOLOR = 100;
        const EMITTER_FPS = 104;
        const EMITTER_FRAME_END = 108;
        const EMITTER_FRAME_START = 112;
        const EMITTER_GRAVITY = 116;
        const EMITTER_LIFE_EXPECTANCY = 120;
        const EMITTER_MASS = 124;
        const ALPHA = 132;
        const EMITTER_PARTICLE_ROTATION = 136;
        const MULTIPLIER_OR_RANDVEL = 140;
        const EMITTER_SIZE_START = 144;
        const EMITTER_SIZE_END = 148;
        const EMITTER_SIZE_START_Y = 152;
        const EMITTER_SIZE_END_Y = 156;
        const EMITTER_SPREAD = 160;
        const EMITTER_THRESHOLD = 164;
        const EMITTER_VELOCITY = 168;
        const EMITTER_X_SIZE = 172;
        const EMITTER_Y_SIZE = 176;
        const EMITTER_BLUR_LENGTH = 180;
        const EMITTER_LIGHTNING_DELAY = 184;
        const EMITTER_LIGHTNING_RADIUS = 188;
        const EMITTER_LIGHTNING_SCALE = 192;
        const EMITTER_LIGHTNING_SUBDIVIDE = 196;
        const EMITTER_LIGHTNING_ZIG_ZAG = 200;
        const EMITTER_ALPHA_MID = 216;
        const EMITTER_PERCENT_START = 220;
        const EMITTER_PERCENT_MID = 224;
        const EMITTER_PERCENT_END = 228;
        const EMITTER_SIZE_MID = 232;
        const EMITTER_SIZE_MID_Y = 236;
        const EMITTER_RANDOM_BIRTH_RATE = 240;
        const EMITTER_TARGET_SIZE = 252;
        const EMITTER_NUM_CONTROL_POINTS = 256;
        const EMITTER_CONTROL_POINT_RADIUS = 260;
        const EMITTER_CONTROL_POINT_DELAY = 264;
        const EMITTER_TANGENT_SPREAD = 268;
        const EMITTER_TANGENT_LENGTH = 272;
        const EMITTER_COLOR_MID = 284;
        const EMITTER_COLOR_END = 380;
        const EMITTER_COLOR_START = 392;
        const EMITTER_DETONATE = 502;

        private const _VALUES = [8 => true, 20 => true, 36 => true, 76 => true, 80 => true, 84 => true, 88 => true, 92 => true, 96 => true, 100 => true, 104 => true, 108 => true, 112 => true, 116 => true, 120 => true, 124 => true, 132 => true, 136 => true, 140 => true, 144 => true, 148 => true, 152 => true, 156 => true, 160 => true, 164 => true, 168 => true, 172 => true, 176 => true, 180 => true, 184 => true, 188 => true, 192 => true, 196 => true, 200 => true, 216 => true, 220 => true, 224 => true, 228 => true, 232 => true, 236 => true, 240 => true, 252 => true, 256 => true, 260 => true, 264 => true, 268 => true, 272 => true, 284 => true, 380 => true, 392 => true, 502 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareMdlCommon {
    class ModelClassification {
        const OTHER = 0;
        const EFFECT = 1;
        const TILE = 2;
        const CHARACTER = 4;
        const DOOR = 8;
        const LIGHTSABER = 16;
        const PLACEABLE = 32;
        const FLYER = 64;

        private const _VALUES = [0 => true, 1 => true, 2 => true, 4 => true, 8 => true, 16 => true, 32 => true, 64 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace BiowareMdlCommon {
    class NodeTypeValue {
        const DUMMY = 1;
        const LIGHT = 3;
        const EMITTER = 5;
        const REFERENCE = 17;
        const TRIMESH = 33;
        const SKINMESH = 97;
        const ANIMMESH = 161;
        const DANGLYMESH = 289;
        const AABB = 545;
        const LIGHTSABER = 2081;

        private const _VALUES = [1 => true, 3 => true, 5 => true, 17 => true, 33 => true, 97 => true, 161 => true, 289 => true, 545 => true, 2081 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}
