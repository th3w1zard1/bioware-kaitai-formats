<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
 * `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
 * 
 * xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
 */

namespace {
    class Lip extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Lip $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileType = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_fileVersion = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_length = $this->_io->readF4le();
            $this->_m_numKeyframes = $this->_io->readU4le();
            $this->_m_keyframes = [];
            $n = $this->numKeyframes();
            for ($i = 0; $i < $n; $i++) {
                $this->_m_keyframes[] = new \Lip\KeyframeEntry($this->_io, $this, $this->_root);
            }
        }
        protected $_m_fileType;
        protected $_m_fileVersion;
        protected $_m_length;
        protected $_m_numKeyframes;
        protected $_m_keyframes;

        /**
         * File type signature. Must be "LIP " (space-padded) for LIP files.
         */
        public function fileType() { return $this->_m_fileType; }

        /**
         * File format version. Must be "V1.0" for LIP files.
         */
        public function fileVersion() { return $this->_m_fileVersion; }

        /**
         * Duration in seconds. Must equal the paired WAV file playback time for
         * glitch-free animation. This is the total length of the lip sync animation.
         */
        public function length() { return $this->_m_length; }

        /**
         * Number of keyframes immediately following. Each keyframe contains a timestamp
         * and a viseme shape index. Keyframes should be sorted ascending by timestamp.
         */
        public function numKeyframes() { return $this->_m_numKeyframes; }

        /**
         * Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
         * Entries must be stored in chronological order (ascending by timestamp).
         */
        public function keyframes() { return $this->_m_keyframes; }
    }
}

/**
 * A single keyframe entry mapping a timestamp to a viseme (mouth shape).
 * Keyframes are used by the engine to interpolate between mouth shapes during
 * audio playback to create lip sync animation.
 */

namespace Lip {
    class KeyframeEntry extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Lip $_parent = null, ?\Lip $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_timestamp = $this->_io->readF4le();
            $this->_m_shape = $this->_io->readU1();
        }
        protected $_m_timestamp;
        protected $_m_shape;

        /**
         * Seconds from animation start. Must be >= 0 and <= length.
         * Keyframes should be sorted ascending by timestamp.
         */
        public function timestamp() { return $this->_m_timestamp; }

        /**
         * Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
         * `bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).
         */
        public function shape() { return $this->_m_shape; }
    }
}
