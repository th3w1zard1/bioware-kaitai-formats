<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * MDL ASCII format is a human-readable ASCII text representation of MDL (Model) binary files.
 * Used by modding tools for easier editing than binary MDL format.
 * 
 * The ASCII format represents the model structure using plain text with keyword-based syntax.
 * Lines are parsed sequentially, with keywords indicating sections, nodes, properties, and data arrays.
 * 
 * Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format - ASCII MDL Format section
 * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/vendor/MDLOps/MDLOpsM.pm:3916-4698 - readasciimdl function implementation
 */

namespace {
    class MdlAscii extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_lines = [];
            $i = 0;
            while (!$this->_io->isEof()) {
                $this->_m_lines[] = new \MdlAscii\AsciiLine($this->_io, $this, $this->_root);
                $i++;
            }
        }
        protected $_m_lines;
        public function lines() { return $this->_m_lines; }
    }
}

/**
 * Animation section keywords
 */

namespace MdlAscii {
    class AnimationSection extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_newanim = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_doneanim = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_length = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_transtime = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_animroot = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_event = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_eventlist = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_endlist = new \MdlAscii\LineText($this->_io, $this, $this->_root);
        }
        protected $_m_newanim;
        protected $_m_doneanim;
        protected $_m_length;
        protected $_m_transtime;
        protected $_m_animroot;
        protected $_m_event;
        protected $_m_eventlist;
        protected $_m_endlist;

        /**
         * newanim <animation_name> <model_name> - Start of animation definition
         */
        public function newanim() { return $this->_m_newanim; }

        /**
         * doneanim <animation_name> <model_name> - End of animation definition
         */
        public function doneanim() { return $this->_m_doneanim; }

        /**
         * length <duration> - Animation duration in seconds
         */
        public function length() { return $this->_m_length; }

        /**
         * transtime <transition_time> - Transition/blend time to this animation in seconds
         */
        public function transtime() { return $this->_m_transtime; }

        /**
         * animroot <root_node_name> - Root node name for animation
         */
        public function animroot() { return $this->_m_animroot; }

        /**
         * event <time> <event_name> - Animation event (triggers at specified time)
         */
        public function event() { return $this->_m_event; }

        /**
         * eventlist - Start of animation events list
         */
        public function eventlist() { return $this->_m_eventlist; }

        /**
         * endlist - End of list (controllers, events, etc.)
         */
        public function endlist() { return $this->_m_endlist; }
    }
}

/**
 * Single line in ASCII MDL file
 */

namespace MdlAscii {
    class AsciiLine extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\MdlAscii $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_content = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(10, false, true, false), "UTF-8");
        }
        protected $_m_content;
        public function content() { return $this->_m_content; }
    }
}

/**
 * Bezier (smooth animated) controller format
 */

namespace MdlAscii {
    class ControllerBezier extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_controllerName = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_keyframes = [];
            $i = 0;
            while (!$this->_io->isEof()) {
                $this->_m_keyframes[] = new \MdlAscii\ControllerBezierKeyframe($this->_io, $this, $this->_root);
                $i++;
            }
        }
        protected $_m_controllerName;
        protected $_m_keyframes;

        /**
         * Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey)
         */
        public function controllerName() { return $this->_m_controllerName; }

        /**
         * Keyframe entries until endlist keyword
         */
        public function keyframes() { return $this->_m_keyframes; }
    }
}

/**
 * Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)
 */

namespace MdlAscii {
    class ControllerBezierKeyframe extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\MdlAscii\ControllerBezier $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_time = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesFull(), "UTF-8");
            $this->_m_valueData = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesFull(), "UTF-8");
        }
        protected $_m_time;
        protected $_m_valueData;

        /**
         * Time value (float)
         */
        public function time() { return $this->_m_time; }

        /**
         * Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column)
         */
        public function valueData() { return $this->_m_valueData; }
    }
}

/**
 * Keyed (animated) controller format
 */

namespace MdlAscii {
    class ControllerKeyed extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_controllerName = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_keyframes = [];
            $i = 0;
            while (!$this->_io->isEof()) {
                $this->_m_keyframes[] = new \MdlAscii\ControllerKeyframe($this->_io, $this, $this->_root);
                $i++;
            }
        }
        protected $_m_controllerName;
        protected $_m_keyframes;

        /**
         * Controller name followed by 'key' (e.g., positionkey, orientationkey)
         */
        public function controllerName() { return $this->_m_controllerName; }

        /**
         * Keyframe entries until endlist keyword
         */
        public function keyframes() { return $this->_m_keyframes; }
    }
}

/**
 * Single keyframe in keyed controller
 */

namespace MdlAscii {
    class ControllerKeyframe extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\MdlAscii\ControllerKeyed $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_time = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesFull(), "UTF-8");
            $this->_m_values = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesFull(), "UTF-8");
        }
        protected $_m_time;
        protected $_m_values;

        /**
         * Time value (float)
         */
        public function time() { return $this->_m_time; }

        /**
         * Space-separated property values (number depends on controller type and column count)
         */
        public function values() { return $this->_m_values; }
    }
}

/**
 * Single (constant) controller format
 */

namespace MdlAscii {
    class ControllerSingle extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_controllerName = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_values = new \MdlAscii\LineText($this->_io, $this, $this->_root);
        }
        protected $_m_controllerName;
        protected $_m_values;

        /**
         * Controller name (position, orientation, scale, color, radius, etc.)
         */
        public function controllerName() { return $this->_m_controllerName; }

        /**
         * Space-separated controller values (number depends on controller type)
         */
        public function values() { return $this->_m_values; }
    }
}

/**
 * Danglymesh node properties
 */

namespace MdlAscii {
    class DanglymeshProperties extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_displacement = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_tightness = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_period = new \MdlAscii\LineText($this->_io, $this, $this->_root);
        }
        protected $_m_displacement;
        protected $_m_tightness;
        protected $_m_period;

        /**
         * displacement <value> - Maximum displacement distance for physics simulation
         */
        public function displacement() { return $this->_m_displacement; }

        /**
         * tightness <value> - Tightness/stiffness of spring simulation (0.0-1.0)
         */
        public function tightness() { return $this->_m_tightness; }

        /**
         * period <value> - Oscillation period in seconds
         */
        public function period() { return $this->_m_period; }
    }
}

/**
 * Data array keywords
 */

namespace MdlAscii {
    class DataArrays extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_verts = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_faces = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_tverts = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_tverts1 = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_lightmaptverts = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_tverts2 = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_tverts3 = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_texindices1 = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_texindices2 = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_texindices3 = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_colors = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_colorindices = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_weights = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_constraints = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_aabb = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_saberVerts = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_saberNorms = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_name = new \MdlAscii\LineText($this->_io, $this, $this->_root);
        }
        protected $_m_verts;
        protected $_m_faces;
        protected $_m_tverts;
        protected $_m_tverts1;
        protected $_m_lightmaptverts;
        protected $_m_tverts2;
        protected $_m_tverts3;
        protected $_m_texindices1;
        protected $_m_texindices2;
        protected $_m_texindices3;
        protected $_m_colors;
        protected $_m_colorindices;
        protected $_m_weights;
        protected $_m_constraints;
        protected $_m_aabb;
        protected $_m_saberVerts;
        protected $_m_saberNorms;
        protected $_m_name;

        /**
         * verts <count> - Start vertex positions array (count vertices, 3 floats each: X, Y, Z)
         */
        public function verts() { return $this->_m_verts; }

        /**
         * faces <count> - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3])
         */
        public function faces() { return $this->_m_faces; }

        /**
         * tverts <count> - Start primary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        public function tverts() { return $this->_m_tverts; }

        /**
         * tverts1 <count> - Start secondary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        public function tverts1() { return $this->_m_tverts1; }

        /**
         * lightmaptverts <count> - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1)
         */
        public function lightmaptverts() { return $this->_m_lightmaptverts; }

        /**
         * tverts2 <count> - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        public function tverts2() { return $this->_m_tverts2; }

        /**
         * tverts3 <count> - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        public function tverts3() { return $this->_m_tverts3; }

        /**
         * texindices1 <count> - Start texture indices array for 2nd texture (count face indices, 3 indices per face)
         */
        public function texindices1() { return $this->_m_texindices1; }

        /**
         * texindices2 <count> - Start texture indices array for 3rd texture (count face indices, 3 indices per face)
         */
        public function texindices2() { return $this->_m_texindices2; }

        /**
         * texindices3 <count> - Start texture indices array for 4th texture (count face indices, 3 indices per face)
         */
        public function texindices3() { return $this->_m_texindices3; }

        /**
         * colors <count> - Start vertex colors array (count colors, 3 floats each: R, G, B)
         */
        public function colors() { return $this->_m_colors; }

        /**
         * colorindices <count> - Start vertex color indices array (count face indices, 3 indices per face)
         */
        public function colorindices() { return $this->_m_colorindices; }

        /**
         * weights <count> - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]])
         */
        public function weights() { return $this->_m_weights; }

        /**
         * constraints <count> - Start vertex constraints array for danglymesh (count floats, one per vertex)
         */
        public function constraints() { return $this->_m_constraints; }

        /**
         * aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line)
         */
        public function aabb() { return $this->_m_aabb; }

        /**
         * saber_verts <count> - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z)
         */
        public function saberVerts() { return $this->_m_saberVerts; }

        /**
         * saber_norms <count> - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z)
         */
        public function saberNorms() { return $this->_m_saberNorms; }

        /**
         * name <node_name> - MDLedit-style name entry for walkmesh nodes (fakenodes)
         */
        public function name() { return $this->_m_name; }
    }
}

/**
 * Emitter behavior flags
 */

namespace MdlAscii {
    class EmitterFlags extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_p2p = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_p2pSel = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_affectedByWind = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_mIsTinted = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_bounce = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_random = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_inherit = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_inheritvel = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_inheritLocal = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_splat = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_inheritPart = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_depthTexture = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_emitterflag13 = new \MdlAscii\LineText($this->_io, $this, $this->_root);
        }
        protected $_m_p2p;
        protected $_m_p2pSel;
        protected $_m_affectedByWind;
        protected $_m_mIsTinted;
        protected $_m_bounce;
        protected $_m_random;
        protected $_m_inherit;
        protected $_m_inheritvel;
        protected $_m_inheritLocal;
        protected $_m_splat;
        protected $_m_inheritPart;
        protected $_m_depthTexture;
        protected $_m_emitterflag13;

        /**
         * p2p <0_or_1> - Point-to-point flag (bit 0x0001)
         */
        public function p2p() { return $this->_m_p2p; }

        /**
         * p2p_sel <0_or_1> - Point-to-point selection flag (bit 0x0002)
         */
        public function p2pSel() { return $this->_m_p2pSel; }

        /**
         * affectedByWind <0_or_1> - Affected by wind flag (bit 0x0004)
         */
        public function affectedByWind() { return $this->_m_affectedByWind; }

        /**
         * m_isTinted <0_or_1> - Is tinted flag (bit 0x0008)
         */
        public function mIsTinted() { return $this->_m_mIsTinted; }

        /**
         * bounce <0_or_1> - Bounce flag (bit 0x0010)
         */
        public function bounce() { return $this->_m_bounce; }

        /**
         * random <0_or_1> - Random flag (bit 0x0020)
         */
        public function random() { return $this->_m_random; }

        /**
         * inherit <0_or_1> - Inherit flag (bit 0x0040)
         */
        public function inherit() { return $this->_m_inherit; }

        /**
         * inheritvel <0_or_1> - Inherit velocity flag (bit 0x0080)
         */
        public function inheritvel() { return $this->_m_inheritvel; }

        /**
         * inherit_local <0_or_1> - Inherit local flag (bit 0x0100)
         */
        public function inheritLocal() { return $this->_m_inheritLocal; }

        /**
         * splat <0_or_1> - Splat flag (bit 0x0200)
         */
        public function splat() { return $this->_m_splat; }

        /**
         * inherit_part <0_or_1> - Inherit part flag (bit 0x0400)
         */
        public function inheritPart() { return $this->_m_inheritPart; }

        /**
         * depth_texture <0_or_1> - Depth texture flag (bit 0x0800)
         */
        public function depthTexture() { return $this->_m_depthTexture; }

        /**
         * emitterflag13 <0_or_1> - Emitter flag 13 (bit 0x1000)
         */
        public function emitterflag13() { return $this->_m_emitterflag13; }
    }
}

/**
 * Emitter node properties
 */

namespace MdlAscii {
    class EmitterProperties extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_deadspace = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_blastRadius = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_blastLength = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_numBranches = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_controlptsmoothing = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_xgrid = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_ygrid = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_spawntype = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_update = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_render = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_blend = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_texture = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_chunkname = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_twosidedtex = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_loop = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_renderorder = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_mBFrameBlending = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_mSDepthTextureName = new \MdlAscii\LineText($this->_io, $this, $this->_root);
        }
        protected $_m_deadspace;
        protected $_m_blastRadius;
        protected $_m_blastLength;
        protected $_m_numBranches;
        protected $_m_controlptsmoothing;
        protected $_m_xgrid;
        protected $_m_ygrid;
        protected $_m_spawntype;
        protected $_m_update;
        protected $_m_render;
        protected $_m_blend;
        protected $_m_texture;
        protected $_m_chunkname;
        protected $_m_twosidedtex;
        protected $_m_loop;
        protected $_m_renderorder;
        protected $_m_mBFrameBlending;
        protected $_m_mSDepthTextureName;

        /**
         * deadspace <value> - Minimum distance from emitter before particles become visible
         */
        public function deadspace() { return $this->_m_deadspace; }

        /**
         * blastRadius <value> - Radius of explosive/blast particle effects
         */
        public function blastRadius() { return $this->_m_blastRadius; }

        /**
         * blastLength <value> - Length/duration of blast effects
         */
        public function blastLength() { return $this->_m_blastLength; }

        /**
         * numBranches <value> - Number of branching paths for particle trails
         */
        public function numBranches() { return $this->_m_numBranches; }

        /**
         * controlptsmoothing <value> - Smoothing factor for particle path control points
         */
        public function controlptsmoothing() { return $this->_m_controlptsmoothing; }

        /**
         * xgrid <value> - Grid subdivisions along X axis for particle spawning
         */
        public function xgrid() { return $this->_m_xgrid; }

        /**
         * ygrid <value> - Grid subdivisions along Y axis for particle spawning
         */
        public function ygrid() { return $this->_m_ygrid; }

        /**
         * spawntype <value> - Particle spawn type
         */
        public function spawntype() { return $this->_m_spawntype; }

        /**
         * update <script_name> - Update behavior script name (e.g., single, fountain)
         */
        public function update() { return $this->_m_update; }

        /**
         * render <script_name> - Render mode script name (e.g., normal, billboard_to_local_z)
         */
        public function render() { return $this->_m_render; }

        /**
         * blend <script_name> - Blend mode script name (e.g., normal, lighten)
         */
        public function blend() { return $this->_m_blend; }

        /**
         * texture <texture_name> - Particle texture name
         */
        public function texture() { return $this->_m_texture; }

        /**
         * chunkname <chunk_name> - Associated model chunk name
         */
        public function chunkname() { return $this->_m_chunkname; }

        /**
         * twosidedtex <0_or_1> - Whether texture should render two-sided (1=two-sided, 0=single-sided)
         */
        public function twosidedtex() { return $this->_m_twosidedtex; }

        /**
         * loop <0_or_1> - Whether particle system loops (1=loops, 0=single playback)
         */
        public function loop() { return $this->_m_loop; }

        /**
         * renderorder <value> - Rendering priority/order for particle sorting
         */
        public function renderorder() { return $this->_m_renderorder; }

        /**
         * m_bFrameBlending <0_or_1> - Whether frame blending is enabled (1=enabled, 0=disabled)
         */
        public function mBFrameBlending() { return $this->_m_mBFrameBlending; }

        /**
         * m_sDepthTextureName <texture_name> - Depth/softparticle texture name
         */
        public function mSDepthTextureName() { return $this->_m_mSDepthTextureName; }
    }
}

/**
 * Light node properties
 */

namespace MdlAscii {
    class LightProperties extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_flareradius = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_flarepositions = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_flaresizes = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_flarecolorshifts = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_texturenames = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_ambientonly = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_ndynamictype = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_affectdynamic = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_flare = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_lightpriority = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_fadinglight = new \MdlAscii\LineText($this->_io, $this, $this->_root);
        }
        protected $_m_flareradius;
        protected $_m_flarepositions;
        protected $_m_flaresizes;
        protected $_m_flarecolorshifts;
        protected $_m_texturenames;
        protected $_m_ambientonly;
        protected $_m_ndynamictype;
        protected $_m_affectdynamic;
        protected $_m_flare;
        protected $_m_lightpriority;
        protected $_m_fadinglight;

        /**
         * flareradius <value> - Radius of lens flare effect
         */
        public function flareradius() { return $this->_m_flareradius; }

        /**
         * flarepositions <count> - Start flare positions array (count floats, 0.0-1.0 along light ray)
         */
        public function flarepositions() { return $this->_m_flarepositions; }

        /**
         * flaresizes <count> - Start flare sizes array (count floats)
         */
        public function flaresizes() { return $this->_m_flaresizes; }

        /**
         * flarecolorshifts <count> - Start flare color shifts array (count RGB floats)
         */
        public function flarecolorshifts() { return $this->_m_flarecolorshifts; }

        /**
         * texturenames <count> - Start flare texture names array (count strings)
         */
        public function texturenames() { return $this->_m_texturenames; }

        /**
         * ambientonly <0_or_1> - Whether light only affects ambient (1=ambient only, 0=full lighting)
         */
        public function ambientonly() { return $this->_m_ambientonly; }

        /**
         * ndynamictype <value> - Type of dynamic lighting behavior
         */
        public function ndynamictype() { return $this->_m_ndynamictype; }

        /**
         * affectdynamic <0_or_1> - Whether light affects dynamic objects (1=affects, 0=static only)
         */
        public function affectdynamic() { return $this->_m_affectdynamic; }

        /**
         * flare <0_or_1> - Whether lens flare effect is enabled (1=enabled, 0=disabled)
         */
        public function flare() { return $this->_m_flare; }

        /**
         * lightpriority <value> - Rendering priority for light culling/sorting
         */
        public function lightpriority() { return $this->_m_lightpriority; }

        /**
         * fadinglight <0_or_1> - Whether light intensity fades with distance (1=fades, 0=constant)
         */
        public function fadinglight() { return $this->_m_fadinglight; }
    }
}

/**
 * A single UTF-8 text line (without the trailing newline).
 * Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
 */

namespace MdlAscii {
    class LineText extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_value = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(10, false, true, false), "UTF-8");
        }
        protected $_m_value;
        public function value() { return $this->_m_value; }
    }
}

/**
 * Reference node properties
 */

namespace MdlAscii {
    class ReferenceProperties extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\MdlAscii $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_refmodel = new \MdlAscii\LineText($this->_io, $this, $this->_root);
            $this->_m_reattachable = new \MdlAscii\LineText($this->_io, $this, $this->_root);
        }
        protected $_m_refmodel;
        protected $_m_reattachable;

        /**
         * refmodel <model_resref> - Referenced model resource name without extension
         */
        public function refmodel() { return $this->_m_refmodel; }

        /**
         * reattachable <0_or_1> - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent)
         */
        public function reattachable() { return $this->_m_reattachable; }
    }
}

namespace MdlAscii {
    class ControllerTypeCommon {
        const POSITION = 8;
        const ORIENTATION = 20;
        const SCALE = 36;
        const ALPHA = 132;

        private const _VALUES = [8 => true, 20 => true, 36 => true, 132 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace MdlAscii {
    class ControllerTypeEmitter {
        const ALPHA_END = 80;
        const ALPHA_START = 84;
        const BIRTHRATE = 88;
        const BOUNCE_CO = 92;
        const COMBINETIME = 96;
        const DRAG = 100;
        const FPS = 104;
        const FRAME_END = 108;
        const FRAME_START = 112;
        const GRAV = 116;
        const LIFE_EXP = 120;
        const MASS = 124;
        const P2P_BEZIER2 = 128;
        const P2P_BEZIER3 = 132;
        const PARTICLE_ROT = 136;
        const RANDVEL = 140;
        const SIZE_START = 144;
        const SIZE_END = 148;
        const SIZE_START_Y = 152;
        const SIZE_END_Y = 156;
        const SPREAD = 160;
        const THRESHOLD = 164;
        const VELOCITY = 168;
        const XSIZE = 172;
        const YSIZE = 176;
        const BLURLENGTH = 180;
        const LIGHTNING_DELAY = 184;
        const LIGHTNING_RADIUS = 188;
        const LIGHTNING_SCALE = 192;
        const LIGHTNING_SUB_DIV = 196;
        const LIGHTNINGZIGZAG = 200;
        const ALPHA_MID = 216;
        const PERCENT_START = 220;
        const PERCENT_MID = 224;
        const PERCENT_END = 228;
        const SIZE_MID = 232;
        const SIZE_MID_Y = 236;
        const M_F_RANDOM_BIRTH_RATE = 240;
        const TARGETSIZE = 252;
        const NUMCONTROLPTS = 256;
        const CONTROLPTRADIUS = 260;
        const CONTROLPTDELAY = 264;
        const TANGENTSPREAD = 268;
        const TANGENTLENGTH = 272;
        const COLOR_MID = 284;
        const COLOR_END = 380;
        const COLOR_START = 392;
        const DETONATE = 502;

        private const _VALUES = [80 => true, 84 => true, 88 => true, 92 => true, 96 => true, 100 => true, 104 => true, 108 => true, 112 => true, 116 => true, 120 => true, 124 => true, 128 => true, 132 => true, 136 => true, 140 => true, 144 => true, 148 => true, 152 => true, 156 => true, 160 => true, 164 => true, 168 => true, 172 => true, 176 => true, 180 => true, 184 => true, 188 => true, 192 => true, 196 => true, 200 => true, 216 => true, 220 => true, 224 => true, 228 => true, 232 => true, 236 => true, 240 => true, 252 => true, 256 => true, 260 => true, 264 => true, 268 => true, 272 => true, 284 => true, 380 => true, 392 => true, 502 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace MdlAscii {
    class ControllerTypeLight {
        const COLOR = 76;
        const RADIUS = 88;
        const SHADOWRADIUS = 96;
        const VERTICALDISPLACEMENT = 100;
        const MULTIPLIER = 140;

        private const _VALUES = [76 => true, 88 => true, 96 => true, 100 => true, 140 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace MdlAscii {
    class ControllerTypeMesh {
        const SELFILLUMCOLOR = 100;

        private const _VALUES = [100 => true];

        public static function isDefined(int $v): bool {
            return isset(self::_VALUES[$v]);
        }
    }
}

namespace MdlAscii {
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

namespace MdlAscii {
    class NodeType {
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
