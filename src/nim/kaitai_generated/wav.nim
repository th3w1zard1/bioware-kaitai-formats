import kaitai_struct_nim_runtime
import options
import bioware_common

type
  Wav* = ref object of KaitaiStruct
    `riffHeader`*: Wav_RiffHeader
    `chunks`*: seq[Wav_Chunk]
    `parent`*: KaitaiStruct
  Wav_Chunk* = ref object of KaitaiStruct
    `id`*: string
    `size`*: uint32
    `body`*: KaitaiStruct
    `parent`*: Wav
  Wav_DataChunkBody* = ref object of KaitaiStruct
    `data`*: seq[byte]
    `parent`*: Wav_Chunk
  Wav_FactChunkBody* = ref object of KaitaiStruct
    `sampleCount`*: uint32
    `parent`*: Wav_Chunk
  Wav_FormatChunkBody* = ref object of KaitaiStruct
    `audioFormat`*: BiowareCommon_RiffWaveFormatTag
    `channels`*: uint16
    `sampleRate`*: uint32
    `bytesPerSec`*: uint32
    `blockAlign`*: uint16
    `bitsPerSample`*: uint16
    `extraFormatBytes`*: seq[byte]
    `parent`*: Wav_Chunk
    `isImaAdpcmInst`: bool
    `isImaAdpcmInstFlag`: bool
    `isMp3Inst`: bool
    `isMp3InstFlag`: bool
    `isPcmInst`: bool
    `isPcmInstFlag`: bool
  Wav_RiffHeader* = ref object of KaitaiStruct
    `riffId`*: string
    `riffSize`*: uint32
    `waveId`*: string
    `parent`*: Wav
    `isMp3InWavInst`: bool
    `isMp3InWavInstFlag`: bool
  Wav_UnknownChunkBody* = ref object of KaitaiStruct
    `data`*: seq[byte]
    `padding`*: uint8
    `parent`*: Wav_Chunk

proc read*(_: typedesc[Wav], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Wav
proc read*(_: typedesc[Wav_Chunk], io: KaitaiStream, root: KaitaiStruct, parent: Wav): Wav_Chunk
proc read*(_: typedesc[Wav_DataChunkBody], io: KaitaiStream, root: KaitaiStruct, parent: Wav_Chunk): Wav_DataChunkBody
proc read*(_: typedesc[Wav_FactChunkBody], io: KaitaiStream, root: KaitaiStruct, parent: Wav_Chunk): Wav_FactChunkBody
proc read*(_: typedesc[Wav_FormatChunkBody], io: KaitaiStream, root: KaitaiStruct, parent: Wav_Chunk): Wav_FormatChunkBody
proc read*(_: typedesc[Wav_RiffHeader], io: KaitaiStream, root: KaitaiStruct, parent: Wav): Wav_RiffHeader
proc read*(_: typedesc[Wav_UnknownChunkBody], io: KaitaiStream, root: KaitaiStruct, parent: Wav_Chunk): Wav_UnknownChunkBody

proc isImaAdpcm*(this: Wav_FormatChunkBody): bool
proc isMp3*(this: Wav_FormatChunkBody): bool
proc isPcm*(this: Wav_FormatChunkBody): bool
proc isMp3InWav*(this: Wav_RiffHeader): bool


##[
**KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
20-byte VO prefixes are application-level.

`wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav">PyKotor wiki — WAV</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106">xoreos — wave decoder</a>
]##
proc read*(_: typedesc[Wav], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Wav =
  template this: untyped = result
  this = new(Wav)
  let root = if root == nil: cast[Wav](this) else: cast[Wav](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  RIFF container header
  ]##
  let riffHeaderExpr = Wav_RiffHeader.read(this.io, this.root, this)
  this.riffHeader = riffHeaderExpr

  ##[
  RIFF chunks in sequence (fmt, fact, data, etc.)
Parsed until end of file
Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L46-L55

  ]##
  block:
    var i: int
    while true:
      let it = Wav_Chunk.read(this.io, this.root, this)
      this.chunks.add(it)
      if this.io.isEof:
        break
      inc i

proc fromFile*(_: typedesc[Wav], filename: string): Wav =
  Wav.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Wav_Chunk], io: KaitaiStream, root: KaitaiStruct, parent: Wav): Wav_Chunk =
  template this: untyped = result
  this = new(Wav_Chunk)
  let root = if root == nil: cast[Wav](this) else: cast[Wav](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Chunk ID (4-character ASCII string)
Common values: "fmt ", "data", "fact", "LIST", etc.
Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L58-L72

  ]##
  let idExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.id = idExpr

  ##[
  Chunk size in bytes (chunk data only, excluding ID and size fields)
Chunks are word-aligned (even byte boundaries)
Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66

  ]##
  let sizeExpr = this.io.readU4le()
  this.size = sizeExpr

  ##[
  Chunk body (content depends on chunk ID)
  ]##
  block:
    let on = this.id
    if on == "data":
      let bodyExpr = Wav_DataChunkBody.read(this.io, this.root, this)
      this.body = bodyExpr
    elif on == "fact":
      let bodyExpr = Wav_FactChunkBody.read(this.io, this.root, this)
      this.body = bodyExpr
    elif on == "fmt ":
      let bodyExpr = Wav_FormatChunkBody.read(this.io, this.root, this)
      this.body = bodyExpr
    else:
      let bodyExpr = Wav_UnknownChunkBody.read(this.io, this.root, this)
      this.body = bodyExpr

proc fromFile*(_: typedesc[Wav_Chunk], filename: string): Wav_Chunk =
  Wav_Chunk.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Wav_DataChunkBody], io: KaitaiStream, root: KaitaiStruct, parent: Wav_Chunk): Wav_DataChunkBody =
  template this: untyped = result
  this = new(Wav_DataChunkBody)
  let root = if root == nil: cast[Wav](this) else: cast[Wav](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Raw audio data (PCM samples or compressed audio)
Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L79-L80

  ]##
  let dataExpr = this.io.readBytes(int(this.parent.size))
  this.data = dataExpr

proc fromFile*(_: typedesc[Wav_DataChunkBody], filename: string): Wav_DataChunkBody =
  Wav_DataChunkBody.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Wav_FactChunkBody], io: KaitaiStream, root: KaitaiStruct, parent: Wav_Chunk): Wav_FactChunkBody =
  template this: untyped = result
  this = new(Wav_FactChunkBody)
  let root = if root == nil: cast[Wav](this) else: cast[Wav](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Sample count (number of samples in compressed audio)
Used for compressed formats like ADPCM
Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L234-L236 (`fact` chunk skip — sample count lives in chunk body)

  ]##
  let sampleCountExpr = this.io.readU4le()
  this.sampleCount = sampleCountExpr

proc fromFile*(_: typedesc[Wav_FactChunkBody], filename: string): Wav_FactChunkBody =
  Wav_FactChunkBody.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Wav_FormatChunkBody], io: KaitaiStream, root: KaitaiStruct, parent: Wav_Chunk): Wav_FormatChunkBody =
  template this: untyped = result
  this = new(Wav_FormatChunkBody)
  let root = if root == nil: cast[Wav](this) else: cast[Wav](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  RIFF `fmt ` / `WAVEFORMATEX.wFormatTag` (`u2` LE). Canonical: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`
(Microsoft `WAVEFORMATEX`; KotOR usage: PyKotor WAV wiki, xoreos `wave.cpp`).

  ]##
  let audioFormatExpr = BiowareCommon_RiffWaveFormatTag(this.io.readU2le())
  this.audioFormat = audioFormatExpr

  ##[
  Number of audio channels:
- 1 = mono
- 2 = stereo
Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

  ]##
  let channelsExpr = this.io.readU2le()
  this.channels = channelsExpr

  ##[
  Sample rate in Hz
Typical values:
- 22050 Hz for SFX
- 44100 Hz for VO
Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

  ]##
  let sampleRateExpr = this.io.readU4le()
  this.sampleRate = sampleRateExpr

  ##[
  Byte rate (average bytes per second)
Formula: sample_rate × block_align
Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

  ]##
  let bytesPerSecExpr = this.io.readU4le()
  this.bytesPerSec = bytesPerSecExpr

  ##[
  Block alignment (bytes per sample frame)
Formula for PCM: channels × (bits_per_sample / 8)
Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

  ]##
  let blockAlignExpr = this.io.readU2le()
  this.blockAlign = blockAlignExpr

  ##[
  Bits per sample
Common values: 8, 16
For PCM: typically 16-bit
Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

  ]##
  let bitsPerSampleExpr = this.io.readU2le()
  this.bitsPerSample = bitsPerSampleExpr

  ##[
  Extra format bytes (present when fmt chunk size > 16)
For IMA ADPCM and other compressed formats, contains:
- Extra format size (u2)
- Format-specific data (e.g., ADPCM coefficients)
Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66

  ]##
  if this.parent.size > 16:
    let extraFormatBytesExpr = this.io.readBytes(int(this.parent.size - 16))
    this.extraFormatBytes = extraFormatBytesExpr

proc isImaAdpcm(this: Wav_FormatChunkBody): bool = 

  ##[
  True if audio format is IMA ADPCM (compressed)
  ]##
  if this.isImaAdpcmInstFlag:
    return this.isImaAdpcmInst
  let isImaAdpcmInstExpr = bool(this.audioFormat == bioware_common.dvi_ima_adpcm)
  this.isImaAdpcmInst = isImaAdpcmInstExpr
  this.isImaAdpcmInstFlag = true
  return this.isImaAdpcmInst

proc isMp3(this: Wav_FormatChunkBody): bool = 

  ##[
  True if audio format is MP3
  ]##
  if this.isMp3InstFlag:
    return this.isMp3Inst
  let isMp3InstExpr = bool(this.audioFormat == bioware_common.mpeg_layer3)
  this.isMp3Inst = isMp3InstExpr
  this.isMp3InstFlag = true
  return this.isMp3Inst

proc isPcm(this: Wav_FormatChunkBody): bool = 

  ##[
  True if audio format is PCM (uncompressed)
  ]##
  if this.isPcmInstFlag:
    return this.isPcmInst
  let isPcmInstExpr = bool(this.audioFormat == bioware_common.pcm)
  this.isPcmInst = isPcmInstExpr
  this.isPcmInstFlag = true
  return this.isPcmInst

proc fromFile*(_: typedesc[Wav_FormatChunkBody], filename: string): Wav_FormatChunkBody =
  Wav_FormatChunkBody.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Wav_RiffHeader], io: KaitaiStream, root: KaitaiStruct, parent: Wav): Wav_RiffHeader =
  template this: untyped = result
  this = new(Wav_RiffHeader)
  let root = if root == nil: cast[Wav](this) else: cast[Wav](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  RIFF chunk ID: "RIFF"
  ]##
  let riffIdExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.riffId = riffIdExpr

  ##[
  File size minus 8 bytes (RIFF_ID + RIFF_SIZE itself)
For MP3-in-WAV format, this is 50
Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav

  ]##
  let riffSizeExpr = this.io.readU4le()
  this.riffSize = riffSizeExpr

  ##[
  Format tag: "WAVE"
  ]##
  let waveIdExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.waveId = waveIdExpr

proc isMp3InWav(this: Wav_RiffHeader): bool = 

  ##[
  MP3-in-WAV format detected when RIFF size = 50
Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)

  ]##
  if this.isMp3InWavInstFlag:
    return this.isMp3InWavInst
  let isMp3InWavInstExpr = bool(this.riffSize == 50)
  this.isMp3InWavInst = isMp3InWavInstExpr
  this.isMp3InWavInstFlag = true
  return this.isMp3InWavInst

proc fromFile*(_: typedesc[Wav_RiffHeader], filename: string): Wav_RiffHeader =
  Wav_RiffHeader.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Wav_UnknownChunkBody], io: KaitaiStream, root: KaitaiStruct, parent: Wav_Chunk): Wav_UnknownChunkBody =
  template this: untyped = result
  this = new(Wav_UnknownChunkBody)
  let root = if root == nil: cast[Wav](this) else: cast[Wav](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Unknown chunk body (skip for compatibility)
Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L53-L54

  ]##
  let dataExpr = this.io.readBytes(int(this.parent.size))
  this.data = dataExpr

  ##[
  Padding byte to align to word boundary (only if chunk size is odd)
RIFF chunks must be aligned to 2-byte boundaries
Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L243-L245 (unknown chunk skip + optional 1-byte word alignment)

  ]##
  if this.parent.size %%% 2 == 1:
    let paddingExpr = this.io.readU1()
    this.padding = paddingExpr

proc fromFile*(_: typedesc[Wav_UnknownChunkBody], filename: string): Wav_UnknownChunkBody =
  Wav_UnknownChunkBody.read(newKaitaiFileStream(filename), nil, nil)

