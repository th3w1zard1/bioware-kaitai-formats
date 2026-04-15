<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * **KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
 * MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
 * 20-byte VO prefixes are application-level.
 * 
 * `wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.
 * 
 * The `xoreos-tools` tree does not ship a RIFF/WAVE wire parser on `master` (see `meta.xref.xoreos_tools_wav_note`); use xoreos `wave.cpp` / `sound.cpp` and PyKotor `io_wav.py` for chunk behavior.
 */

namespace {
    class Wav extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Wav $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_riffHeader = new \Wav\RiffHeader($this->_io, $this, $this->_root);
            $this->_m_chunks = [];
            $i = 0;
            do {
                $_ = new \Wav\Chunk($this->_io, $this, $this->_root);
                $this->_m_chunks[] = $_;
                $i++;
            } while (!($this->_io()->isEof()));
        }
        protected $_m_riffHeader;
        protected $_m_chunks;

        /**
         * RIFF container header
         */
        public function riffHeader() { return $this->_m_riffHeader; }

        /**
         * RIFF chunks in sequence (fmt, fact, data, etc.)
         * Parsed until end of file
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L46-L55
         */
        public function chunks() { return $this->_m_chunks; }
    }
}

namespace Wav {
    class Chunk extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Wav $_parent = null, ?\Wav $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_id = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            $this->_m_size = $this->_io->readU4le();
            switch ($this->id()) {
                case "data":
                    $this->_m_body = new \Wav\DataChunkBody($this->_io, $this, $this->_root);
                    break;
                case "fact":
                    $this->_m_body = new \Wav\FactChunkBody($this->_io, $this, $this->_root);
                    break;
                case "fmt ":
                    $this->_m_body = new \Wav\FormatChunkBody($this->_io, $this, $this->_root);
                    break;
                default:
                    $this->_m_body = new \Wav\UnknownChunkBody($this->_io, $this, $this->_root);
                    break;
            }
        }
        protected $_m_id;
        protected $_m_size;
        protected $_m_body;

        /**
         * Chunk ID (4-character ASCII string)
         * Common values: "fmt ", "data", "fact", "LIST", etc.
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L58-L72
         */
        public function id() { return $this->_m_id; }

        /**
         * Chunk size in bytes (chunk data only, excluding ID and size fields)
         * Chunks are word-aligned (even byte boundaries)
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
         */
        public function size() { return $this->_m_size; }

        /**
         * Chunk body (content depends on chunk ID)
         */
        public function body() { return $this->_m_body; }
    }
}

namespace Wav {
    class DataChunkBody extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Wav\Chunk $_parent = null, ?\Wav $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_data = $this->_io->readBytes($this->_parent()->size());
        }
        protected $_m_data;

        /**
         * Raw audio data (PCM samples or compressed audio)
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L79-L80
         */
        public function data() { return $this->_m_data; }
    }
}

namespace Wav {
    class FactChunkBody extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Wav\Chunk $_parent = null, ?\Wav $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_sampleCount = $this->_io->readU4le();
        }
        protected $_m_sampleCount;

        /**
         * Sample count (number of samples in compressed audio)
         * Used for compressed formats like ADPCM
         * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L234-L236 (`fact` chunk skip — sample count lives in chunk body)
         */
        public function sampleCount() { return $this->_m_sampleCount; }
    }
}

namespace Wav {
    class FormatChunkBody extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Wav\Chunk $_parent = null, ?\Wav $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_audioFormat = $this->_io->readU2le();
            $this->_m_channels = $this->_io->readU2le();
            $this->_m_sampleRate = $this->_io->readU4le();
            $this->_m_bytesPerSec = $this->_io->readU4le();
            $this->_m_blockAlign = $this->_io->readU2le();
            $this->_m_bitsPerSample = $this->_io->readU2le();
            if ($this->_parent()->size() > 16) {
                $this->_m_extraFormatBytes = $this->_io->readBytes($this->_parent()->size() - 16);
            }
        }
        protected $_m_isImaAdpcm;

        /**
         * True if audio format is IMA ADPCM (compressed)
         */
        public function isImaAdpcm() {
            if ($this->_m_isImaAdpcm !== null)
                return $this->_m_isImaAdpcm;
            $this->_m_isImaAdpcm = $this->audioFormat() == \BiowareCommon\RiffWaveFormatTag::DVI_IMA_ADPCM;
            return $this->_m_isImaAdpcm;
        }
        protected $_m_isMp3;

        /**
         * True if audio format is MP3
         */
        public function isMp3() {
            if ($this->_m_isMp3 !== null)
                return $this->_m_isMp3;
            $this->_m_isMp3 = $this->audioFormat() == \BiowareCommon\RiffWaveFormatTag::MPEG_LAYER3;
            return $this->_m_isMp3;
        }
        protected $_m_isPcm;

        /**
         * True if audio format is PCM (uncompressed)
         */
        public function isPcm() {
            if ($this->_m_isPcm !== null)
                return $this->_m_isPcm;
            $this->_m_isPcm = $this->audioFormat() == \BiowareCommon\RiffWaveFormatTag::PCM;
            return $this->_m_isPcm;
        }
        protected $_m_audioFormat;
        protected $_m_channels;
        protected $_m_sampleRate;
        protected $_m_bytesPerSec;
        protected $_m_blockAlign;
        protected $_m_bitsPerSample;
        protected $_m_extraFormatBytes;

        /**
         * RIFF `fmt ` / `WAVEFORMATEX.wFormatTag` (`u2` LE). Canonical: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`
         * (Microsoft `WAVEFORMATEX`; KotOR usage: PyKotor WAV wiki, xoreos `wave.cpp`).
         */
        public function audioFormat() { return $this->_m_audioFormat; }

        /**
         * Number of audio channels:
         * - 1 = mono
         * - 2 = stereo
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public function channels() { return $this->_m_channels; }

        /**
         * Sample rate in Hz
         * Typical values:
         * - 22050 Hz for SFX
         * - 44100 Hz for VO
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public function sampleRate() { return $this->_m_sampleRate; }

        /**
         * Byte rate (average bytes per second)
         * Formula: sample_rate × block_align
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public function bytesPerSec() { return $this->_m_bytesPerSec; }

        /**
         * Block alignment (bytes per sample frame)
         * Formula for PCM: channels × (bits_per_sample / 8)
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public function blockAlign() { return $this->_m_blockAlign; }

        /**
         * Bits per sample
         * Common values: 8, 16
         * For PCM: typically 16-bit
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public function bitsPerSample() { return $this->_m_bitsPerSample; }

        /**
         * Extra format bytes (present when fmt chunk size > 16)
         * For IMA ADPCM and other compressed formats, contains:
         * - Extra format size (u2)
         * - Format-specific data (e.g., ADPCM coefficients)
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
         */
        public function extraFormatBytes() { return $this->_m_extraFormatBytes; }
    }
}

namespace Wav {
    class RiffHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Wav $_parent = null, ?\Wav $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_riffId = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_riffId == "RIFF")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("RIFF", $this->_m_riffId, $this->_io, "/types/riff_header/seq/0");
            }
            $this->_m_riffSize = $this->_io->readU4le();
            $this->_m_waveId = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytes(4), "ASCII");
            if (!($this->_m_waveId == "WAVE")) {
                throw new \Kaitai\Struct\Error\ValidationNotEqualError("WAVE", $this->_m_waveId, $this->_io, "/types/riff_header/seq/2");
            }
        }
        protected $_m_isMp3InWav;

        /**
         * MP3-in-WAV format detected when RIFF size = 50
         * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)
         */
        public function isMp3InWav() {
            if ($this->_m_isMp3InWav !== null)
                return $this->_m_isMp3InWav;
            $this->_m_isMp3InWav = $this->riffSize() == 50;
            return $this->_m_isMp3InWav;
        }
        protected $_m_riffId;
        protected $_m_riffSize;
        protected $_m_waveId;

        /**
         * RIFF chunk ID: "RIFF"
         */
        public function riffId() { return $this->_m_riffId; }

        /**
         * File size minus 8 bytes (RIFF_ID + RIFF_SIZE itself)
         * For MP3-in-WAV format, this is 50
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
         */
        public function riffSize() { return $this->_m_riffSize; }

        /**
         * Format tag: "WAVE"
         */
        public function waveId() { return $this->_m_waveId; }
    }
}

namespace Wav {
    class UnknownChunkBody extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Wav\Chunk $_parent = null, ?\Wav $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_data = $this->_io->readBytes($this->_parent()->size());
            if (\Kaitai\Struct\Stream::mod($this->_parent()->size(), 2) == 1) {
                $this->_m_padding = $this->_io->readU1();
            }
        }
        protected $_m_data;
        protected $_m_padding;

        /**
         * Unknown chunk body (skip for compatibility)
         * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L53-L54
         */
        public function data() { return $this->_m_data; }

        /**
         * Padding byte to align to word boundary (only if chunk size is odd)
         * RIFF chunks must be aligned to 2-byte boundaries
         * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L243-L245 (unknown chunk skip + optional 1-byte word alignment)
         */
        public function padding() { return $this->_m_padding; }
    }
}
