<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **DA2S** (Dragon Age 2 save): Eclipse binary save — `DA2S` signature, `version==1`, length-prefixed strings + tagged
 * blocks (party/inventory/journal/etc.). **Not KotOR** — Andastra serializers under `Game/Games/Eclipse/DragonAge2/Save/` (`meta.xref`).
 */

namespace {
    class Da2s extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Da2s $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_signature = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_signature == "DA2S")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("DA2S", $this->_m_signature, $this->_io, "/seq/0");
            }
            $this->_m_version = $this->_io->readS4le();
            if (!($this->_m_version == 1)) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError(1, $this->_m_version, $this->_io, "/seq/1");
            }
            $this->_m_saveName = new \Da2s\LengthPrefixedString($this->_io, $this, $this->_root);
            $this->_m_moduleName = new \Da2s\LengthPrefixedString($this->_io, $this, $this->_root);
            $this->_m_areaName = new \Da2s\LengthPrefixedString($this->_io, $this, $this->_root);
            $this->_m_timePlayedSeconds = $this->_io->readS4le();
            $this->_m_timestampFiletime = $this->_io->readS8le();
            $this->_m_numScreenshotData = $this->_io->readS4le();
            if ($this->numScreenshotData() > 0) {
                $this->_m_screenshotData = [];
                $n = $this->numScreenshotData();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_screenshotData[] = $this->_io->readU1();
                }
            }
            $this->_m_numPortraitData = $this->_io->readS4le();
            if ($this->numPortraitData() > 0) {
                $this->_m_portraitData = [];
                $n = $this->numPortraitData();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_portraitData[] = $this->_io->readU1();
                }
            }
            $this->_m_playerName = new \Da2s\LengthPrefixedString($this->_io, $this, $this->_root);
            $this->_m_partyMemberCount = $this->_io->readS4le();
            $this->_m_playerLevel = $this->_io->readS4le();
        }
        protected $_m_signature;
        protected $_m_version;
        protected $_m_saveName;
        protected $_m_moduleName;
        protected $_m_areaName;
        protected $_m_timePlayedSeconds;
        protected $_m_timestampFiletime;
        protected $_m_numScreenshotData;
        protected $_m_screenshotData;
        protected $_m_numPortraitData;
        protected $_m_portraitData;
        protected $_m_playerName;
        protected $_m_partyMemberCount;
        protected $_m_playerLevel;

        /**
         * File signature. Must be "DA2S" for Dragon Age 2 save files.
         */
        public function signature() { return $this->_m_signature; }

        /**
         * Save format version. Must be 1 for Dragon Age 2.
         */
        public function version() { return $this->_m_version; }

        /**
         * User-entered save name displayed in UI
         */
        public function saveName() { return $this->_m_saveName; }

        /**
         * Current module resource name
         */
        public function moduleName() { return $this->_m_moduleName; }

        /**
         * Current area name for display
         */
        public function areaName() { return $this->_m_areaName; }

        /**
         * Total play time in seconds
         */
        public function timePlayedSeconds() { return $this->_m_timePlayedSeconds; }

        /**
         * Save creation timestamp as Windows FILETIME (int64).
         * Convert using DateTime.FromFileTime().
         */
        public function timestampFiletime() { return $this->_m_timestampFiletime; }

        /**
         * Length of screenshot data in bytes (0 if no screenshot)
         */
        public function numScreenshotData() { return $this->_m_numScreenshotData; }

        /**
         * Screenshot image data (typically TGA or DDS format)
         */
        public function screenshotData() { return $this->_m_screenshotData; }

        /**
         * Length of portrait data in bytes (0 if no portrait)
         */
        public function numPortraitData() { return $this->_m_numPortraitData; }

        /**
         * Portrait image data (typically TGA or DDS format)
         */
        public function portraitData() { return $this->_m_portraitData; }

        /**
         * Player character name
         */
        public function playerName() { return $this->_m_playerName; }

        /**
         * Number of party members (from PartyState)
         */
        public function partyMemberCount() { return $this->_m_partyMemberCount; }

        /**
         * Player character level (from PartyState.PlayerCharacter)
         */
        public function playerLevel() { return $this->_m_playerLevel; }
    }
}

namespace Da2s {
    class LengthPrefixedString extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Da2s $_parent = null, ?\Da2s $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_length = $this->_io->readS4le();
            $this->_m_value = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes($this->length()), 0, false), "UTF-8");
        }
        protected $_m_valueTrimmed;

        /**
         * String value.
         * Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
         */
        public function valueTrimmed() {
            if ($this->_m_valueTrimmed !== null)
                return $this->_m_valueTrimmed;
            $this->_m_valueTrimmed = $this->value();
            return $this->_m_valueTrimmed;
        }
        protected $_m_length;
        protected $_m_value;

        /**
         * String length in bytes (UTF-8 encoding).
         * Must be >= 0 and <= 65536 (sanity check).
         */
        public function length() { return $this->_m_length; }

        /**
         * String value (UTF-8 encoded)
         */
        public function value() { return $this->_m_value; }
    }
}
