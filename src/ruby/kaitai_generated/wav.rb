# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_common'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
# MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
# 20-byte VO prefixes are application-level.
# 
# `wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.
# @see https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav PyKotor wiki — WAV
# @see https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106 xoreos — wave decoder
class Wav < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @riff_header = RiffHeader.new(@_io, self, @_root)
    @chunks = []
    i = 0
    begin
      _ = Chunk.new(@_io, self, @_root)
      @chunks << _
      i += 1
    end until _io.eof?
    self
  end
  class Chunk < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @id = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      @size = @_io.read_u4le
      case id
      when "data"
        @body = DataChunkBody.new(@_io, self, @_root)
      when "fact"
        @body = FactChunkBody.new(@_io, self, @_root)
      when "fmt "
        @body = FormatChunkBody.new(@_io, self, @_root)
      else
        @body = UnknownChunkBody.new(@_io, self, @_root)
      end
      self
    end

    ##
    # Chunk ID (4-character ASCII string)
    # Common values: "fmt ", "data", "fact", "LIST", etc.
    # Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L58-L72
    attr_reader :id

    ##
    # Chunk size in bytes (chunk data only, excluding ID and size fields)
    # Chunks are word-aligned (even byte boundaries)
    # Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
    attr_reader :size

    ##
    # Chunk body (content depends on chunk ID)
    attr_reader :body
  end
  class DataChunkBody < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @data = @_io.read_bytes(_parent.size)
      self
    end

    ##
    # Raw audio data (PCM samples or compressed audio)
    # Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L79-L80
    attr_reader :data
  end
  class FactChunkBody < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @sample_count = @_io.read_u4le
      self
    end

    ##
    # Sample count (number of samples in compressed audio)
    # Used for compressed formats like ADPCM
    # Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L234-L236 (`fact` chunk skip — sample count lives in chunk body)
    attr_reader :sample_count
  end
  class FormatChunkBody < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @audio_format = Kaitai::Struct::Stream::resolve_enum(BiowareCommon::RIFF_WAVE_FORMAT_TAG, @_io.read_u2le)
      @channels = @_io.read_u2le
      @sample_rate = @_io.read_u4le
      @bytes_per_sec = @_io.read_u4le
      @block_align = @_io.read_u2le
      @bits_per_sample = @_io.read_u2le
      if _parent.size > 16
        @extra_format_bytes = @_io.read_bytes(_parent.size - 16)
      end
      self
    end

    ##
    # True if audio format is IMA ADPCM (compressed)
    def is_ima_adpcm
      return @is_ima_adpcm unless @is_ima_adpcm.nil?
      @is_ima_adpcm = audio_format == :riff_wave_format_tag_dvi_ima_adpcm
      @is_ima_adpcm
    end

    ##
    # True if audio format is MP3
    def is_mp3
      return @is_mp3 unless @is_mp3.nil?
      @is_mp3 = audio_format == :riff_wave_format_tag_mpeg_layer3
      @is_mp3
    end

    ##
    # True if audio format is PCM (uncompressed)
    def is_pcm
      return @is_pcm unless @is_pcm.nil?
      @is_pcm = audio_format == :riff_wave_format_tag_pcm
      @is_pcm
    end

    ##
    # RIFF `fmt ` / `WAVEFORMATEX.wFormatTag` (`u2` LE). Canonical: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`
    # (Microsoft `WAVEFORMATEX`; KotOR usage: PyKotor WAV wiki, xoreos `wave.cpp`).
    attr_reader :audio_format

    ##
    # Number of audio channels:
    # - 1 = mono
    # - 2 = stereo
    # Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
    attr_reader :channels

    ##
    # Sample rate in Hz
    # Typical values:
    # - 22050 Hz for SFX
    # - 44100 Hz for VO
    # Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
    attr_reader :sample_rate

    ##
    # Byte rate (average bytes per second)
    # Formula: sample_rate × block_align
    # Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
    attr_reader :bytes_per_sec

    ##
    # Block alignment (bytes per sample frame)
    # Formula for PCM: channels × (bits_per_sample / 8)
    # Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
    attr_reader :block_align

    ##
    # Bits per sample
    # Common values: 8, 16
    # For PCM: typically 16-bit
    # Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
    attr_reader :bits_per_sample

    ##
    # Extra format bytes (present when fmt chunk size > 16)
    # For IMA ADPCM and other compressed formats, contains:
    # - Extra format size (u2)
    # - Format-specific data (e.g., ADPCM coefficients)
    # Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
    attr_reader :extra_format_bytes
  end
  class RiffHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @riff_id = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotEqualError.new("RIFF", @riff_id, @_io, "/types/riff_header/seq/0") if not @riff_id == "RIFF"
      @riff_size = @_io.read_u4le
      @wave_id = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotEqualError.new("WAVE", @wave_id, @_io, "/types/riff_header/seq/2") if not @wave_id == "WAVE"
      self
    end

    ##
    # MP3-in-WAV format detected when RIFF size = 50
    # Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)
    def is_mp3_in_wav
      return @is_mp3_in_wav unless @is_mp3_in_wav.nil?
      @is_mp3_in_wav = riff_size == 50
      @is_mp3_in_wav
    end

    ##
    # RIFF chunk ID: "RIFF"
    attr_reader :riff_id

    ##
    # File size minus 8 bytes (RIFF_ID + RIFF_SIZE itself)
    # For MP3-in-WAV format, this is 50
    # Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
    attr_reader :riff_size

    ##
    # Format tag: "WAVE"
    attr_reader :wave_id
  end
  class UnknownChunkBody < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @data = @_io.read_bytes(_parent.size)
      if _parent.size % 2 == 1
        @padding = @_io.read_u1
      end
      self
    end

    ##
    # Unknown chunk body (skip for compatibility)
    # Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L53-L54
    attr_reader :data

    ##
    # Padding byte to align to word boundary (only if chunk size is odd)
    # RIFF chunks must be aligned to 2-byte boundaries
    # Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L243-L245 (unknown chunk skip + optional 1-byte word alignment)
    attr_reader :padding
  end

  ##
  # RIFF container header
  attr_reader :riff_header

  ##
  # RIFF chunks in sequence (fmt, fact, data, etc.)
  # Parsed until end of file
  # Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L46-L55
  attr_reader :chunks
end
