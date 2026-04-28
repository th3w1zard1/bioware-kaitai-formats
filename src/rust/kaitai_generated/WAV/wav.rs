// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#![allow(unused_imports)]
#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(irrefutable_let_patterns)]
#![allow(unused_comparisons)]

extern crate kaitai;
use kaitai::*;
use std::convert::{TryFrom, TryInto};
use std::cell::{Ref, Cell, RefCell};
use std::rc::{Rc, Weak};
use super::bioware_common::BiowareCommon_RiffWaveFormatTag;

/**
 * **KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
 * MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
 * 20-byte VO prefixes are application-level.
 * 
 * `wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.
 * 
 * The `xoreos-tools` tree does not ship a RIFF/WAVE wire parser on `master` (see `meta.xref.xoreos_tools_wav_note`); use xoreos `wave.cpp` / `sound.cpp` and PyKotor `io_wav.py` for chunk behavior.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav PyKotor wiki — WAV
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L43-L187 PyKotor — `io_wav` (Kaitai RIFF parse + `WAVBinaryReader.load` + legacy)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/audio/format/wavreader.cpp#L30-L72 reone — `WavReader` (fake header + chunk loop)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106 xoreos — `makeWAVStream` / chunk scan
 * \sa https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp#L256-L340 xoreos — `SoundManager::makeAudioStream` KotOR WAVE quirks
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L62 xoreos — `kFileTypeWAV` (numeric id)
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/audio/AudioFile.ts#L10-L145 KotOR.js — `AudioFile` (prefix + MP3-in-WAV)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree (no dedicated WAV PDF; discoverability anchor)
 */

#[derive(Default, Debug, Clone)]
pub struct Wav {
    pub _root: SharedType<Wav>,
    pub _parent: SharedType<Wav>,
    pub _self: SharedType<Self>,
    riff_header: RefCell<OptRc<Wav_RiffHeader>>,
    chunks: RefCell<Vec<OptRc<Wav_Chunk>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Wav {
    type Root = Wav;
    type Parent = Wav;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        let t = Self::read_into::<_, Wav_RiffHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.riff_header.borrow_mut() = t;
        *self_rc.chunks.borrow_mut() = Vec::new();
        {
            let mut _i = 0;
            while {
                let t = Self::read_into::<_, Wav_Chunk>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
                self_rc.chunks.borrow_mut().push(t);
                let _t_chunks = self_rc.chunks.borrow();
                let _tmpa = _t_chunks.last().unwrap();
                _i += 1;
                let x = !(_io.is_eof());
                x
            } {}
        }
        Ok(())
    }
}
impl Wav {
}

/**
 * RIFF container header
 */
impl Wav {
    pub fn riff_header(&self) -> Ref<'_, OptRc<Wav_RiffHeader>> {
        self.riff_header.borrow()
    }
}

/**
 * RIFF chunks in sequence (fmt, fact, data, etc.)
 * Parsed until end of file
 * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L46-L55
 */
impl Wav {
    pub fn chunks(&self) -> Ref<'_, Vec<OptRc<Wav_Chunk>>> {
        self.chunks.borrow()
    }
}
impl Wav {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Wav_Chunk {
    pub _root: SharedType<Wav>,
    pub _parent: SharedType<Wav>,
    pub _self: SharedType<Self>,
    id: RefCell<String>,
    size: RefCell<u32>,
    body: RefCell<Option<Wav_Chunk_Body>>,
    _io: RefCell<BytesReader>,
}
#[derive(Debug, Clone)]
pub enum Wav_Chunk_Body {
    Wav_UnknownChunkBody(OptRc<Wav_UnknownChunkBody>),
    Wav_DataChunkBody(OptRc<Wav_DataChunkBody>),
    Wav_FactChunkBody(OptRc<Wav_FactChunkBody>),
    Wav_FormatChunkBody(OptRc<Wav_FormatChunkBody>),
}
impl From<&Wav_Chunk_Body> for OptRc<Wav_UnknownChunkBody> {
    fn from(v: &Wav_Chunk_Body) -> Self {
        if let Wav_Chunk_Body::Wav_UnknownChunkBody(x) = v {
            return x.clone();
        }
        panic!("expected Wav_Chunk_Body::Wav_UnknownChunkBody, got {:?}", v)
    }
}
impl From<OptRc<Wav_UnknownChunkBody>> for Wav_Chunk_Body {
    fn from(v: OptRc<Wav_UnknownChunkBody>) -> Self {
        Self::Wav_UnknownChunkBody(v)
    }
}
impl From<&Wav_Chunk_Body> for OptRc<Wav_DataChunkBody> {
    fn from(v: &Wav_Chunk_Body) -> Self {
        if let Wav_Chunk_Body::Wav_DataChunkBody(x) = v {
            return x.clone();
        }
        panic!("expected Wav_Chunk_Body::Wav_DataChunkBody, got {:?}", v)
    }
}
impl From<OptRc<Wav_DataChunkBody>> for Wav_Chunk_Body {
    fn from(v: OptRc<Wav_DataChunkBody>) -> Self {
        Self::Wav_DataChunkBody(v)
    }
}
impl From<&Wav_Chunk_Body> for OptRc<Wav_FactChunkBody> {
    fn from(v: &Wav_Chunk_Body) -> Self {
        if let Wav_Chunk_Body::Wav_FactChunkBody(x) = v {
            return x.clone();
        }
        panic!("expected Wav_Chunk_Body::Wav_FactChunkBody, got {:?}", v)
    }
}
impl From<OptRc<Wav_FactChunkBody>> for Wav_Chunk_Body {
    fn from(v: OptRc<Wav_FactChunkBody>) -> Self {
        Self::Wav_FactChunkBody(v)
    }
}
impl From<&Wav_Chunk_Body> for OptRc<Wav_FormatChunkBody> {
    fn from(v: &Wav_Chunk_Body) -> Self {
        if let Wav_Chunk_Body::Wav_FormatChunkBody(x) = v {
            return x.clone();
        }
        panic!("expected Wav_Chunk_Body::Wav_FormatChunkBody, got {:?}", v)
    }
}
impl From<OptRc<Wav_FormatChunkBody>> for Wav_Chunk_Body {
    fn from(v: OptRc<Wav_FormatChunkBody>) -> Self {
        Self::Wav_FormatChunkBody(v)
    }
}
impl KStruct for Wav_Chunk {
    type Root = Wav;
    type Parent = Wav;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.id.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        *self_rc.size.borrow_mut() = _io.read_u4le()?.into();
        {
            let on = self_rc.id();
            if *on == "data" {
                let t = Self::read_into::<_, Wav_DataChunkBody>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
                *self_rc.body.borrow_mut() = Some(t);
            }
            else if *on == "fact" {
                let t = Self::read_into::<_, Wav_FactChunkBody>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
                *self_rc.body.borrow_mut() = Some(t);
            }
            else if *on == "fmt " {
                let t = Self::read_into::<_, Wav_FormatChunkBody>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
                *self_rc.body.borrow_mut() = Some(t);
            }
            else {
                let t = Self::read_into::<_, Wav_UnknownChunkBody>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
                *self_rc.body.borrow_mut() = Some(t);
            }
        }
        Ok(())
    }
}
impl Wav_Chunk {
}

/**
 * Chunk ID (4-character ASCII string)
 * Common values: "fmt ", "data", "fact", "LIST", etc.
 * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L58-L72
 */
impl Wav_Chunk {
    pub fn id(&self) -> Ref<'_, String> {
        self.id.borrow()
    }
}

/**
 * Chunk size in bytes (chunk data only, excluding ID and size fields)
 * Chunks are word-aligned (even byte boundaries)
 * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
 */
impl Wav_Chunk {
    pub fn size(&self) -> Ref<'_, u32> {
        self.size.borrow()
    }
}

/**
 * Chunk body (content depends on chunk ID)
 */
impl Wav_Chunk {
    pub fn body(&self) -> Ref<'_, Option<Wav_Chunk_Body>> {
        self.body.borrow()
    }
}
impl Wav_Chunk {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Wav_DataChunkBody {
    pub _root: SharedType<Wav>,
    pub _parent: SharedType<Wav_Chunk>,
    pub _self: SharedType<Self>,
    data: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Wav_DataChunkBody {
    type Root = Wav;
    type Parent = Wav_Chunk;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.data.borrow_mut() = _io.read_bytes(*_prc.as_ref().unwrap().size() as usize)?.into();
        Ok(())
    }
}
impl Wav_DataChunkBody {
}

/**
 * Raw audio data (PCM samples or compressed audio)
 * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L79-L80
 */
impl Wav_DataChunkBody {
    pub fn data(&self) -> Ref<'_, Vec<u8>> {
        self.data.borrow()
    }
}
impl Wav_DataChunkBody {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Wav_FactChunkBody {
    pub _root: SharedType<Wav>,
    pub _parent: SharedType<Wav_Chunk>,
    pub _self: SharedType<Self>,
    sample_count: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Wav_FactChunkBody {
    type Root = Wav;
    type Parent = Wav_Chunk;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.sample_count.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Wav_FactChunkBody {
}

/**
 * Sample count (number of samples in compressed audio)
 * Used for compressed formats like ADPCM
 * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L234-L236 (`fact` chunk skip — sample count lives in chunk body)
 */
impl Wav_FactChunkBody {
    pub fn sample_count(&self) -> Ref<'_, u32> {
        self.sample_count.borrow()
    }
}
impl Wav_FactChunkBody {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Wav_FormatChunkBody {
    pub _root: SharedType<Wav>,
    pub _parent: SharedType<Wav_Chunk>,
    pub _self: SharedType<Self>,
    audio_format: RefCell<BiowareCommon_RiffWaveFormatTag>,
    channels: RefCell<u16>,
    sample_rate: RefCell<u32>,
    bytes_per_sec: RefCell<u32>,
    block_align: RefCell<u16>,
    bits_per_sample: RefCell<u16>,
    extra_format_bytes: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
    f_is_ima_adpcm: Cell<bool>,
    is_ima_adpcm: RefCell<bool>,
    f_is_mp3: Cell<bool>,
    is_mp3: RefCell<bool>,
    f_is_pcm: Cell<bool>,
    is_pcm: RefCell<bool>,
}
impl KStruct for Wav_FormatChunkBody {
    type Root = Wav;
    type Parent = Wav_Chunk;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.audio_format.borrow_mut() = (_io.read_u2le()? as i64).try_into()?;
        *self_rc.channels.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.sample_rate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.bytes_per_sec.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.block_align.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.bits_per_sample.borrow_mut() = _io.read_u2le()?.into();
        if ((*_prc.as_ref().unwrap().size() as u32) > (16 as u32)) {
            *self_rc.extra_format_bytes.borrow_mut() = _io.read_bytes(((*_prc.as_ref().unwrap().size() as u32) - (16 as u32)) as usize)?.into();
        }
        Ok(())
    }
}
impl Wav_FormatChunkBody {

    /**
     * True if audio format is IMA ADPCM (compressed)
     */
    pub fn is_ima_adpcm(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_ima_adpcm.get() {
            return Ok(self.is_ima_adpcm.borrow());
        }
        self.f_is_ima_adpcm.set(true);
        *self.is_ima_adpcm.borrow_mut() = (*self.audio_format() == BiowareCommon_RiffWaveFormatTag::DviImaAdpcm) as bool;
        Ok(self.is_ima_adpcm.borrow())
    }

    /**
     * True if audio format is MP3
     */
    pub fn is_mp3(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_mp3.get() {
            return Ok(self.is_mp3.borrow());
        }
        self.f_is_mp3.set(true);
        *self.is_mp3.borrow_mut() = (*self.audio_format() == BiowareCommon_RiffWaveFormatTag::MpegLayer3) as bool;
        Ok(self.is_mp3.borrow())
    }

    /**
     * True if audio format is PCM (uncompressed)
     */
    pub fn is_pcm(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_pcm.get() {
            return Ok(self.is_pcm.borrow());
        }
        self.f_is_pcm.set(true);
        *self.is_pcm.borrow_mut() = (*self.audio_format() == BiowareCommon_RiffWaveFormatTag::Pcm) as bool;
        Ok(self.is_pcm.borrow())
    }
}

/**
 * RIFF `fmt ` / `WAVEFORMATEX.wFormatTag` (`u2` LE). Canonical: `formats/Common/bioware_common.ksy` → `riff_wave_format_tag`
 * (Microsoft `WAVEFORMATEX`; KotOR usage: PyKotor WAV wiki, xoreos `wave.cpp`).
 */
impl Wav_FormatChunkBody {
    pub fn audio_format(&self) -> Ref<'_, BiowareCommon_RiffWaveFormatTag> {
        self.audio_format.borrow()
    }
}

/**
 * Number of audio channels:
 * - 1 = mono
 * - 2 = stereo
 * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
 */
impl Wav_FormatChunkBody {
    pub fn channels(&self) -> Ref<'_, u16> {
        self.channels.borrow()
    }
}

/**
 * Sample rate in Hz
 * Typical values:
 * - 22050 Hz for SFX
 * - 44100 Hz for VO
 * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
 */
impl Wav_FormatChunkBody {
    pub fn sample_rate(&self) -> Ref<'_, u32> {
        self.sample_rate.borrow()
    }
}

/**
 * Byte rate (average bytes per second)
 * Formula: sample_rate × block_align
 * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
 */
impl Wav_FormatChunkBody {
    pub fn bytes_per_sec(&self) -> Ref<'_, u32> {
        self.bytes_per_sec.borrow()
    }
}

/**
 * Block alignment (bytes per sample frame)
 * Formula for PCM: channels × (bits_per_sample / 8)
 * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
 */
impl Wav_FormatChunkBody {
    pub fn block_align(&self) -> Ref<'_, u16> {
        self.block_align.borrow()
    }
}

/**
 * Bits per sample
 * Common values: 8, 16
 * For PCM: typically 16-bit
 * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
 */
impl Wav_FormatChunkBody {
    pub fn bits_per_sample(&self) -> Ref<'_, u16> {
        self.bits_per_sample.borrow()
    }
}

/**
 * Extra format bytes (present when fmt chunk size > 16)
 * For IMA ADPCM and other compressed formats, contains:
 * - Extra format size (u2)
 * - Format-specific data (e.g., ADPCM coefficients)
 * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L66
 */
impl Wav_FormatChunkBody {
    pub fn extra_format_bytes(&self) -> Ref<'_, Vec<u8>> {
        self.extra_format_bytes.borrow()
    }
}
impl Wav_FormatChunkBody {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Wav_RiffHeader {
    pub _root: SharedType<Wav>,
    pub _parent: SharedType<Wav>,
    pub _self: SharedType<Self>,
    riff_id: RefCell<String>,
    riff_size: RefCell<u32>,
    wave_id: RefCell<String>,
    _io: RefCell<BytesReader>,
    f_is_mp3_in_wav: Cell<bool>,
    is_mp3_in_wav: RefCell<bool>,
}
impl KStruct for Wav_RiffHeader {
    type Root = Wav;
    type Parent = Wav;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.riff_id.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !(*self_rc.riff_id() == "RIFF".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/riff_header/seq/0".to_string() }));
        }
        *self_rc.riff_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.wave_id.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !(*self_rc.wave_id() == "WAVE".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/types/riff_header/seq/2".to_string() }));
        }
        Ok(())
    }
}
impl Wav_RiffHeader {

    /**
     * MP3-in-WAV format detected when RIFF size = 50
     * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)
     */
    pub fn is_mp3_in_wav(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_mp3_in_wav.get() {
            return Ok(self.is_mp3_in_wav.borrow());
        }
        self.f_is_mp3_in_wav.set(true);
        *self.is_mp3_in_wav.borrow_mut() = (((*self.riff_size() as u32) == (50 as u32))) as bool;
        Ok(self.is_mp3_in_wav.borrow())
    }
}

/**
 * RIFF chunk ID: "RIFF"
 */
impl Wav_RiffHeader {
    pub fn riff_id(&self) -> Ref<'_, String> {
        self.riff_id.borrow()
    }
}

/**
 * File size minus 8 bytes (RIFF_ID + RIFF_SIZE itself)
 * For MP3-in-WAV format, this is 50
 * Reference: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
 */
impl Wav_RiffHeader {
    pub fn riff_size(&self) -> Ref<'_, u32> {
        self.riff_size.borrow()
    }
}

/**
 * Format tag: "WAVE"
 */
impl Wav_RiffHeader {
    pub fn wave_id(&self) -> Ref<'_, String> {
        self.wave_id.borrow()
    }
}
impl Wav_RiffHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Wav_UnknownChunkBody {
    pub _root: SharedType<Wav>,
    pub _parent: SharedType<Wav_Chunk>,
    pub _self: SharedType<Self>,
    data: RefCell<Vec<u8>>,
    padding: RefCell<u8>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Wav_UnknownChunkBody {
    type Root = Wav;
    type Parent = Wav_Chunk;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        *self_rc.data.borrow_mut() = _io.read_bytes(*_prc.as_ref().unwrap().size() as usize)?.into();
        if ((((*_prc.as_ref().unwrap().size() as u32) % (2 as u32)) as i32) == (1 as i32)) {
            *self_rc.padding.borrow_mut() = _io.read_u1()?.into();
        }
        Ok(())
    }
}
impl Wav_UnknownChunkBody {
}

/**
 * Unknown chunk body (skip for compatibility)
 * Reference: https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L53-L54
 */
impl Wav_UnknownChunkBody {
    pub fn data(&self) -> Ref<'_, Vec<u8>> {
        self.data.borrow()
    }
}

/**
 * Padding byte to align to word boundary (only if chunk size is odd)
 * RIFF chunks must be aligned to 2-byte boundaries
 * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L243-L245 (unknown chunk skip + optional 1-byte word alignment)
 */
impl Wav_UnknownChunkBody {
    pub fn padding(&self) -> Ref<'_, u8> {
        self.padding.borrow()
    }
}
impl Wav_UnknownChunkBody {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
