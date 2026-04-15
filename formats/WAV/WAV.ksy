meta:
  id: wav
  title: BioWare WAV (Waveform Audio) Format
  license: MIT
  endian: le
  file-extension: wav
  imports:
    - ../Common/bioware_common
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: WAV/VOX resources use KotOR RIFF + optional 470-byte SFX prefix per PyKotor wiki.
    ghidra_mcp_odyssey_program_paths: |
      Odyssey shared Ghidra (user-agdec-http): `sync-project` / `checkout-program` with `/K1/k1_win_gog_swkotor.exe` (and TSL build) when
      correlating `CResWAV` / RIFF wrappers — same MCP entry pattern as `formats/TPC/DDS.ksy` (`AGENTS.md`).
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/
    github_openkotor_pykotor_io_wav: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py`:
      **`_parse_riff_wave_from_kaitai`** **43–84**; **`WAVBinaryReader.load`** **118–158** (KotOR prefix / deobfuscation hooks **134–135**); legacy RIFF probe **175–187**.
    github_openkotor_pykotor_wav_obfuscation: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py`: MP3-in-WAV / SFX / VO helpers (see wiki + `WAV.ksy` `is_mp3_in_wav` instance).
    xoreos_wave_cpp: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106
    xoreos_types_kfiletype_wav: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L62
    xoreos_sound_make_audio_stream: https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp#L256-L340
    xoreos_wave_make_wav_stream: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106
    xoreos_tools_wav_note: |
      `xoreos-tools` `master` has no dedicated RIFF/WAVE chunk parser or `.wav` CLI (matches `docs/XOREOS_FORMAT_COVERAGE.md` tools cell for WAV).
      Numeric `kFileTypeWAV` lives in engine `types.h` (`meta.xref.xoreos_types_kfiletype_wav`); the tools repo does not mirror that enum header.
    pykotor_wiki_wav: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
    bioware_common_riff_fmt: |
      `fmt ` chunk `audio_format` / `wFormatTag`: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`.
    reone_wavreader: https://github.com/modawan/reone/blob/master/src/libs/audio/format/wavreader.cpp#L30-L56
    github_kobaltblu_kotor_js_audiofile: |
      https://github.com/KobaltBlu/KotOR.js — `src/audio/AudioFile.ts`: **`fakeHeaderTest`** **10**; **`ArrayMatch`** → **470**-byte strip **`slice(470, …)`** **117–120**; MP3-in-WAV **`riffSize == 50`** **114+** / branch **134+**; **`readWavHeader`** / **`fmt`** **214+**.
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
doc: |
  **KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
  MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
  20-byte VO prefixes are application-level.

  `wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.

  The `xoreos-tools` tree does not ship a RIFF/WAVE wire parser on `master` (see `meta.xref.xoreos_tools_wav_note`); use xoreos `wave.cpp` / `sound.cpp` and PyKotor `io_wav.py` for chunk behavior.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav PyKotor wiki — WAV"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L43-L187 PyKotor — `io_wav` (Kaitai RIFF parse + `WAVBinaryReader.load` + legacy)"
  - "https://github.com/modawan/reone/blob/master/src/libs/audio/format/wavreader.cpp#L30-L72 reone — `WavReader` (fake header + chunk loop)"
  - "https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106 xoreos — `makeWAVStream` / chunk scan"
  - "https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp#L256-L340 xoreos — `SoundManager::makeAudioStream` KotOR WAVE quirks"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L62 xoreos — `kFileTypeWAV` (numeric id)"
  - "https://github.com/KobaltBlu/KotOR.js/blob/master/src/audio/AudioFile.ts#L10-L145 KotOR.js — `AudioFile` (prefix + MP3-in-WAV)"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree (no dedicated WAV PDF; discoverability anchor)"

seq:
  - id: riff_header
    type: riff_header
    doc: RIFF container header

  - id: chunks
    type: chunk
    repeat: until
    repeat-until: _io.eof
    doc: |
      RIFF chunks in sequence (fmt, fact, data, etc.)
      Parsed until end of file
      Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L46-L55

types:
  riff_header:
    seq:
      - id: riff_id
        type: str
        encoding: ASCII
        size: 4
        doc: "RIFF chunk ID: \"RIFF\""
        valid: "'RIFF'"

      - id: riff_size
        type: u4
        doc: |
          File size minus 8 bytes (RIFF_ID + RIFF_SIZE itself)
          For MP3-in-WAV format, this is 50
          Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

      - id: wave_id
        type: str
        encoding: ASCII
        size: 4
        doc: "Format tag: \"WAVE\""
        valid: "'WAVE'"

    instances:
      is_mp3_in_wav:
        value: riff_size == 50
        doc: |
          MP3-in-WAV format detected when RIFF size = 50
          Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)

  chunk:
    seq:
      - id: id
        type: str
        encoding: ASCII
        size: 4
        doc: |
          Chunk ID (4-character ASCII string)
          Common values: "fmt ", "data", "fact", "LIST", etc.
          Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L58-L72

      - id: size
        type: u4
        doc: |
          Chunk size in bytes (chunk data only, excluding ID and size fields)
          Chunks are word-aligned (even byte boundaries)
          Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66

      - id: body
        type:
          switch-on: id
          cases:
            '"fmt "': format_chunk_body
            '"data"': data_chunk_body
            '"fact"': fact_chunk_body
            _: unknown_chunk_body
        doc: Chunk body (content depends on chunk ID)


  format_chunk_body:
    seq:
      - id: audio_format
        type: u2
        enum: bioware_common::riff_wave_format_tag
        doc: |
          RIFF `fmt ` / `WAVEFORMATEX.wFormatTag` (`u2` LE). Canonical: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`
          (Microsoft `WAVEFORMATEX`; KotOR usage: PyKotor WAV wiki, xoreos `wave.cpp`).

      - id: channels
        type: u2
        doc: |
          Number of audio channels:
          - 1 = mono
          - 2 = stereo
          Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

      - id: sample_rate
        type: u4
        doc: |
          Sample rate in Hz
          Typical values:
          - 22050 Hz for SFX
          - 44100 Hz for VO
          Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

      - id: bytes_per_sec
        type: u4
        doc: |
          Byte rate (average bytes per second)
          Formula: sample_rate × block_align
          Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

      - id: block_align
        type: u2
        doc: |
          Block alignment (bytes per sample frame)
          Formula for PCM: channels × (bits_per_sample / 8)
          Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

      - id: bits_per_sample
        type: u2
        doc: |
          Bits per sample
          Common values: 8, 16
          For PCM: typically 16-bit
          Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

      - id: extra_format_bytes
        size: _parent.size - 16
        if: _parent.size > 16
        doc: |
          Extra format bytes (present when fmt chunk size > 16)
          For IMA ADPCM and other compressed formats, contains:
          - Extra format size (u2)
          - Format-specific data (e.g., ADPCM coefficients)
          Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66

    instances:
      is_pcm:
        value: 'audio_format == bioware_common::riff_wave_format_tag::pcm'
        doc: True if audio format is PCM (uncompressed)

      is_ima_adpcm:
        value: 'audio_format == bioware_common::riff_wave_format_tag::dvi_ima_adpcm'
        doc: True if audio format is IMA ADPCM (compressed)

      is_mp3:
        value: 'audio_format == bioware_common::riff_wave_format_tag::mpeg_layer3'
        doc: True if audio format is MP3

  data_chunk_body:
    seq:
      - id: data
        size: _parent.size
        doc: |
          Raw audio data (PCM samples or compressed audio)
          Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L79-L80

  fact_chunk_body:
    seq:
      - id: sample_count
        type: u4
        doc: |
          Sample count (number of samples in compressed audio)
          Used for compressed formats like ADPCM
          Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L234-L236 (`fact` chunk skip — sample count lives in chunk body)

  unknown_chunk_body:
    seq:
      - id: data
        size: _parent.size
        doc: |
          Unknown chunk body (skip for compatibility)
          Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L53-L54

      - id: padding
        type: u1
        if: _parent.size % 2 == 1
        doc: |
          Padding byte to align to word boundary (only if chunk size is odd)
          RIFF chunks must be aligned to 2-byte boundaries
          Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L243-L245 (unknown chunk skip + optional 1-byte word alignment)
