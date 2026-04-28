-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_common")
local str_decode = require("string_decode")

-- 
-- **KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
-- MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
-- 20-byte VO prefixes are application-level.
-- 
-- `wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.
-- 
-- The `xoreos-tools` tree does not ship a RIFF/WAVE wire parser on `master` (see `meta.xref.xoreos_tools_wav_note`); use xoreos `wave.cpp` / `sound.cpp` and PyKotor `io_wav.py` for chunk behavior.
-- See also: PyKotor wiki — WAV (https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav)
-- See also: PyKotor — `io_wav` (Kaitai RIFF parse + `WAVBinaryReader.load` + legacy) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L43-L187)
-- See also: reone — `WavReader` (fake header + chunk loop) (https://github.com/modawan/reone/blob/master/src/libs/audio/format/wavreader.cpp#L30-L72)
-- See also: xoreos — `makeWAVStream` / chunk scan (https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106)
-- See also: xoreos — `SoundManager::makeAudioStream` KotOR WAVE quirks (https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp#L256-L340)
-- See also: xoreos — `kFileTypeWAV` (numeric id) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L62)
-- See also: KotOR.js — `AudioFile` (prefix + MP3-in-WAV) (https://github.com/KobaltBlu/KotOR.js/blob/master/src/audio/AudioFile.ts#L10-L145)
-- See also: xoreos-docs — BioWare specs PDF tree (no dedicated WAV PDF; discoverability anchor) (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
Wav = class.class(KaitaiStruct)

function Wav:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Wav:_read()
  self.riff_header = Wav.RiffHeader(self._io, self, self._root)
  self.chunks = {}
  local i = 0
  while true do
    local _ = Wav.Chunk(self._io, self, self._root)
    self.chunks[i + 1] = _
    if self._io:is_eof() then
      break
    end
    i = i + 1
  end
end

-- 
-- RIFF container header.
-- 
-- RIFF chunks in sequence (fmt, fact, data, etc.)
-- Parsed until end of file
-- Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L46-L55

Wav.Chunk = class.class(KaitaiStruct)

function Wav.Chunk:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Wav.Chunk:_read()
  self.id = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.size = self._io:read_u4le()
  local _on = self.id
  if _on == "data" then
    self.body = Wav.DataChunkBody(self._io, self, self._root)
  elseif _on == "fact" then
    self.body = Wav.FactChunkBody(self._io, self, self._root)
  elseif _on == "fmt " then
    self.body = Wav.FormatChunkBody(self._io, self, self._root)
  else
    self.body = Wav.UnknownChunkBody(self._io, self, self._root)
  end
end

-- 
-- Chunk ID (4-character ASCII string)
-- Common values: "fmt ", "data", "fact", "LIST", etc.
-- Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L58-L72
-- 
-- Chunk size in bytes (chunk data only, excluding ID and size fields)
-- Chunks are word-aligned (even byte boundaries)
-- Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
-- 
-- Chunk body (content depends on chunk ID).

Wav.DataChunkBody = class.class(KaitaiStruct)

function Wav.DataChunkBody:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Wav.DataChunkBody:_read()
  self.data = self._io:read_bytes(self._parent.size)
end

-- 
-- Raw audio data (PCM samples or compressed audio)
-- Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L79-L80

Wav.FactChunkBody = class.class(KaitaiStruct)

function Wav.FactChunkBody:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Wav.FactChunkBody:_read()
  self.sample_count = self._io:read_u4le()
end

-- 
-- Sample count (number of samples in compressed audio)
-- Used for compressed formats like ADPCM
-- Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L234-L236 (`fact` chunk skip — sample count lives in chunk body)

Wav.FormatChunkBody = class.class(KaitaiStruct)

function Wav.FormatChunkBody:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Wav.FormatChunkBody:_read()
  self.audio_format = BiowareCommon.RiffWaveFormatTag(self._io:read_u2le())
  self.channels = self._io:read_u2le()
  self.sample_rate = self._io:read_u4le()
  self.bytes_per_sec = self._io:read_u4le()
  self.block_align = self._io:read_u2le()
  self.bits_per_sample = self._io:read_u2le()
  if self._parent.size > 16 then
    self.extra_format_bytes = self._io:read_bytes(self._parent.size - 16)
  end
end

-- 
-- True if audio format is IMA ADPCM (compressed).
Wav.FormatChunkBody.property.is_ima_adpcm = {}
function Wav.FormatChunkBody.property.is_ima_adpcm:get()
  if self._m_is_ima_adpcm ~= nil then
    return self._m_is_ima_adpcm
  end

  self._m_is_ima_adpcm = self.audio_format == BiowareCommon.RiffWaveFormatTag.dvi_ima_adpcm
  return self._m_is_ima_adpcm
end

-- 
-- True if audio format is MP3.
Wav.FormatChunkBody.property.is_mp3 = {}
function Wav.FormatChunkBody.property.is_mp3:get()
  if self._m_is_mp3 ~= nil then
    return self._m_is_mp3
  end

  self._m_is_mp3 = self.audio_format == BiowareCommon.RiffWaveFormatTag.mpeg_layer3
  return self._m_is_mp3
end

-- 
-- True if audio format is PCM (uncompressed).
Wav.FormatChunkBody.property.is_pcm = {}
function Wav.FormatChunkBody.property.is_pcm:get()
  if self._m_is_pcm ~= nil then
    return self._m_is_pcm
  end

  self._m_is_pcm = self.audio_format == BiowareCommon.RiffWaveFormatTag.pcm
  return self._m_is_pcm
end

-- 
-- RIFF `fmt ` / `WAVEFORMATEX.wFormatTag` (`u2` LE). Canonical: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`
-- (Microsoft `WAVEFORMATEX`; KotOR usage: PyKotor WAV wiki, xoreos `wave.cpp`).
-- 
-- Number of audio channels:
-- - 1 = mono
-- - 2 = stereo
-- Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
-- 
-- Sample rate in Hz
-- Typical values:
-- - 22050 Hz for SFX
-- - 44100 Hz for VO
-- Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
-- 
-- Byte rate (average bytes per second)
-- Formula: sample_rate × block_align
-- Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
-- 
-- Block alignment (bytes per sample frame)
-- Formula for PCM: channels × (bits_per_sample / 8)
-- Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
-- 
-- Bits per sample
-- Common values: 8, 16
-- For PCM: typically 16-bit
-- Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
-- 
-- Extra format bytes (present when fmt chunk size > 16)
-- For IMA ADPCM and other compressed formats, contains:
-- - Extra format size (u2)
-- - Format-specific data (e.g., ADPCM coefficients)
-- Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66

Wav.RiffHeader = class.class(KaitaiStruct)

function Wav.RiffHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Wav.RiffHeader:_read()
  self.riff_id = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.riff_id == "RIFF") then
    error("not equal, expected " .. "RIFF" .. ", but got " .. self.riff_id)
  end
  self.riff_size = self._io:read_u4le()
  self.wave_id = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.wave_id == "WAVE") then
    error("not equal, expected " .. "WAVE" .. ", but got " .. self.wave_id)
  end
end

-- 
-- MP3-in-WAV format detected when RIFF size = 50
-- Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)
Wav.RiffHeader.property.is_mp3_in_wav = {}
function Wav.RiffHeader.property.is_mp3_in_wav:get()
  if self._m_is_mp3_in_wav ~= nil then
    return self._m_is_mp3_in_wav
  end

  self._m_is_mp3_in_wav = self.riff_size == 50
  return self._m_is_mp3_in_wav
end

-- 
-- RIFF chunk ID: "RIFF".
-- 
-- File size minus 8 bytes (RIFF_ID + RIFF_SIZE itself)
-- For MP3-in-WAV format, this is 50
-- Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
-- 
-- Format tag: "WAVE".

Wav.UnknownChunkBody = class.class(KaitaiStruct)

function Wav.UnknownChunkBody:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Wav.UnknownChunkBody:_read()
  self.data = self._io:read_bytes(self._parent.size)
  if self._parent.size % 2 == 1 then
    self.padding = self._io:read_u1()
  end
end

-- 
-- Unknown chunk body (skip for compatibility)
-- Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L53-L54
-- 
-- Padding byte to align to word boundary (only if chunk size is odd)
-- RIFF chunks must be aligned to 2-byte boundaries
-- Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L243-L245 (unknown chunk skip + optional 1-byte word alignment)

