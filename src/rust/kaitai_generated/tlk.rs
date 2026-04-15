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

/**
 * TLK (Talk Table) files contain all text strings used in the game, both written and spoken.
 * They enable easy localization by providing a lookup table from string reference numbers (StrRef)
 * to localized text and associated voice-over audio files.
 * 
 * Binary Format Structure:
 * - File Header (20 bytes): File type signature, version, language ID, string count, entries offset
 * - String Data Table (40 bytes per entry): Metadata for each string entry (flags, sound ResRef, offsets, lengths)
 * - String Entries (variable size): Sequential null-terminated text strings starting at entries_offset
 * 
 * The format uses a two-level structure:
 * 1. String Data Table: Contains metadata (flags, sound filename, text offset/length) for each entry
 * 2. String Entries: Actual text data stored sequentially, referenced by offsets in the data table
 * 
 * String references (StrRef) are 0-based indices into the string_data_table array. StrRef 0 refers to
 * the first entry, StrRef 1 to the second, etc. StrRef -1 indicates no string reference.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk
 * - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/tlkreader.cpp:31-84
 * - https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp:42-176
 * - https://github.com/TSLPatcher/TSLPatcher/blob/master/lib/site/Bioware/TLK.pm:1-533
 * - https://github.com/KotOR-Community-Patches/Kotor.NET/blob/master/Kotor.NET/Formats/KotorTLK/TLKBinaryStructure.cs:11-132
 */

#[derive(Default, Debug, Clone)]
pub struct Tlk {
    pub _root: SharedType<Tlk>,
    pub _parent: SharedType<Tlk>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Tlk_TlkHeader>>,
    string_data_table: RefCell<OptRc<Tlk_StringDataTable>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Tlk {
    type Root = Tlk;
    type Parent = Tlk;

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
        let t = Self::read_into::<_, Tlk_TlkHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        let t = Self::read_into::<_, Tlk_StringDataTable>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.string_data_table.borrow_mut() = t;
        Ok(())
    }
}
impl Tlk {
}

/**
 * TLK file header (20 bytes) - contains file signature, version, language, and counts
 */
impl Tlk {
    pub fn header(&self) -> Ref<'_, OptRc<Tlk_TlkHeader>> {
        self.header.borrow()
    }
}

/**
 * Array of string data entries (metadata for each string) - 40 bytes per entry
 */
impl Tlk {
    pub fn string_data_table(&self) -> Ref<'_, OptRc<Tlk_StringDataTable>> {
        self.string_data_table.borrow()
    }
}
impl Tlk {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Tlk_StringDataEntry {
    pub _root: SharedType<Tlk>,
    pub _parent: SharedType<Tlk_StringDataTable>,
    pub _self: SharedType<Self>,
    flags: RefCell<u32>,
    sound_resref: RefCell<String>,
    volume_variance: RefCell<u32>,
    pitch_variance: RefCell<u32>,
    text_offset: RefCell<u32>,
    text_length: RefCell<u32>,
    sound_length: RefCell<f32>,
    _io: RefCell<BytesReader>,
    f_entry_size: Cell<bool>,
    entry_size: RefCell<i8>,
    f_sound_length_present: Cell<bool>,
    sound_length_present: RefCell<bool>,
    f_sound_present: Cell<bool>,
    sound_present: RefCell<bool>,
    f_text_data: Cell<bool>,
    text_data: RefCell<String>,
    f_text_file_offset: Cell<bool>,
    text_file_offset: RefCell<i32>,
    f_text_present: Cell<bool>,
    text_present: RefCell<bool>,
}
impl KStruct for Tlk_StringDataEntry {
    type Root = Tlk;
    type Parent = Tlk_StringDataTable;

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
        *self_rc.flags.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.sound_resref.borrow_mut() = bytes_to_str(&_io.read_bytes(16 as usize)?.into(), "ASCII")?;
        *self_rc.volume_variance.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.pitch_variance.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.text_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.text_length.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.sound_length.borrow_mut() = _io.read_f4le()?.into();
        Ok(())
    }
}
impl Tlk_StringDataEntry {

    /**
     * Size of each string_data_entry in bytes.
     * Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
     * text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.
     */
    pub fn entry_size(
        &self
    ) -> KResult<Ref<'_, i8>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_entry_size.get() {
            return Ok(self.entry_size.borrow());
        }
        self.f_entry_size.set(true);
        *self.entry_size.borrow_mut() = (40) as i8;
        Ok(self.entry_size.borrow())
    }

    /**
     * Whether sound length is valid (bit 2 of flags)
     */
    pub fn sound_length_present(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_sound_length_present.get() {
            return Ok(self.sound_length_present.borrow());
        }
        self.f_sound_length_present.set(true);
        *self.sound_length_present.borrow_mut() = (((((*self.flags() as u32) & (4 as u32)) as i32) != (0 as i32))) as bool;
        Ok(self.sound_length_present.borrow())
    }

    /**
     * Whether voice-over audio exists (bit 1 of flags)
     */
    pub fn sound_present(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_sound_present.get() {
            return Ok(self.sound_present.borrow());
        }
        self.f_sound_present.set(true);
        *self.sound_present.borrow_mut() = (((((*self.flags() as u32) & (2 as u32)) as i32) != (0 as i32))) as bool;
        Ok(self.sound_present.borrow())
    }

    /**
     * Text string data as raw bytes (read as ASCII for byte-level access).
     * The actual encoding depends on the language_id in the header.
     * Common encodings:
     * - English/French/German/Italian/Spanish: Windows-1252 (cp1252)
     * - Polish: Windows-1250 (cp1250)
     * - Korean: EUC-KR (cp949)
     * - Chinese Traditional: Big5 (cp950)
     * - Chinese Simplified: GB2312 (cp936)
     * - Japanese: Shift-JIS (cp932)
     * 
     * Note: This field reads the raw bytes as ASCII string for byte-level access.
     * The application layer should decode based on the language_id field in the header.
     * To get raw bytes, access the underlying byte representation of this string.
     * 
     * In practice, strings are stored sequentially starting at entries_offset,
     * so text_offset values are relative to entries_offset (0, len1, len1+len2, etc.).
     * 
     * Strings may be null-terminated, but text_length includes the null terminator.
     * Application code should trim null bytes when decoding.
     * 
     * If text_present flag (bit 0) is not set, this field may contain garbage data
     * or be empty. Always check text_present before using this data.
     */
    pub fn text_data(
        &self
    ) -> KResult<Ref<'_, String>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_text_data.get() {
            return Ok(self.text_data.borrow());
        }
        self.f_text_data.set(true);
        let _pos = _io.pos();
        _io.seek(*self.text_file_offset()? as usize)?;
        *self.text_data.borrow_mut() = bytes_to_str(&_io.read_bytes(*self.text_length() as usize)?.into(), "ASCII")?;
        _io.seek(_pos)?;
        Ok(self.text_data.borrow())
    }

    /**
     * Absolute file offset to the text string.
     * Calculated as entries_offset (from header) + text_offset (from entry).
     */
    pub fn text_file_offset(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_text_file_offset.get() {
            return Ok(self.text_file_offset.borrow());
        }
        self.f_text_file_offset.set(true);
        *self.text_file_offset.borrow_mut() = (((*_r.header().entries_offset() as u32) + (*self.text_offset() as u32))) as i32;
        Ok(self.text_file_offset.borrow())
    }

    /**
     * Whether text content exists (bit 0 of flags)
     */
    pub fn text_present(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_text_present.get() {
            return Ok(self.text_present.borrow());
        }
        self.f_text_present.set(true);
        *self.text_present.borrow_mut() = (((((*self.flags() as u32) & (1 as u32)) as i32) != (0 as i32))) as bool;
        Ok(self.text_present.borrow())
    }
}

/**
 * Bit flags indicating what data is present:
 * - bit 0 (0x0001): Text present - string has text content
 * - bit 1 (0x0002): Sound present - string has associated voice-over audio
 * - bit 2 (0x0004): Sound length present - sound length field is valid
 * 
 * Common flag combinations:
 * - 0x0001: Text only (menu options, item descriptions)
 * - 0x0003: Text + Sound (voiced dialog lines)
 * - 0x0007: Text + Sound + Length (fully voiced with duration)
 * - 0x0000: Empty entry (unused StrRef slots)
 */
impl Tlk_StringDataEntry {
    pub fn flags(&self) -> Ref<'_, u32> {
        self.flags.borrow()
    }
}

/**
 * Voice-over audio filename (ResRef), null-terminated ASCII, max 16 chars.
 * If the string is shorter than 16 bytes, it is null-padded.
 * Empty string (all nulls) indicates no voice-over audio.
 */
impl Tlk_StringDataEntry {
    pub fn sound_resref(&self) -> Ref<'_, String> {
        self.sound_resref.borrow()
    }
}

/**
 * Volume variance (unused in KotOR, always 0).
 * Legacy field from Neverwinter Nights, not used by KotOR engine.
 */
impl Tlk_StringDataEntry {
    pub fn volume_variance(&self) -> Ref<'_, u32> {
        self.volume_variance.borrow()
    }
}

/**
 * Pitch variance (unused in KotOR, always 0).
 * Legacy field from Neverwinter Nights, not used by KotOR engine.
 */
impl Tlk_StringDataEntry {
    pub fn pitch_variance(&self) -> Ref<'_, u32> {
        self.pitch_variance.borrow()
    }
}

/**
 * Offset to string text relative to entries_offset.
 * The actual file offset is: header.entries_offset + text_offset.
 * First string starts at offset 0, subsequent strings follow sequentially.
 */
impl Tlk_StringDataEntry {
    pub fn text_offset(&self) -> Ref<'_, u32> {
        self.text_offset.borrow()
    }
}

/**
 * Length of string text in bytes (not characters).
 * For single-byte encodings (Windows-1252, etc.), byte length equals character count.
 * For multi-byte encodings (UTF-8, etc.), byte length may be greater than character count.
 */
impl Tlk_StringDataEntry {
    pub fn text_length(&self) -> Ref<'_, u32> {
        self.text_length.borrow()
    }
}

/**
 * Duration of voice-over audio in seconds (float).
 * Only valid if sound_length_present flag (bit 2) is set.
 * Used by the engine to determine how long to wait before auto-advancing dialog.
 */
impl Tlk_StringDataEntry {
    pub fn sound_length(&self) -> Ref<'_, f32> {
        self.sound_length.borrow()
    }
}
impl Tlk_StringDataEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Tlk_StringDataTable {
    pub _root: SharedType<Tlk>,
    pub _parent: SharedType<Tlk>,
    pub _self: SharedType<Self>,
    entries: RefCell<Vec<OptRc<Tlk_StringDataEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Tlk_StringDataTable {
    type Root = Tlk;
    type Parent = Tlk;

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
        *self_rc.entries.borrow_mut() = Vec::new();
        let l_entries = *_r.header().string_count();
        for _i in 0..l_entries {
            let t = Self::read_into::<_, Tlk_StringDataEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.entries.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Tlk_StringDataTable {
}

/**
 * Array of string data entries, one per string in the file
 */
impl Tlk_StringDataTable {
    pub fn entries(&self) -> Ref<'_, Vec<OptRc<Tlk_StringDataEntry>>> {
        self.entries.borrow()
    }
}
impl Tlk_StringDataTable {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Tlk_TlkHeader {
    pub _root: SharedType<Tlk>,
    pub _parent: SharedType<Tlk>,
    pub _self: SharedType<Self>,
    file_type: RefCell<String>,
    file_version: RefCell<String>,
    language_id: RefCell<u32>,
    string_count: RefCell<u32>,
    entries_offset: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_expected_entries_offset: Cell<bool>,
    expected_entries_offset: RefCell<i32>,
    f_header_size: Cell<bool>,
    header_size: RefCell<i8>,
}
impl KStruct for Tlk_TlkHeader {
    type Root = Tlk;
    type Parent = Tlk;

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
        *self_rc.file_type.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        *self_rc.file_version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        *self_rc.language_id.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.string_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.entries_offset.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Tlk_TlkHeader {

    /**
     * Expected offset to string entries (header + string data table).
     * Used for validation.
     */
    pub fn expected_entries_offset(
        &self
    ) -> KResult<Ref<'_, i32>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_expected_entries_offset.get() {
            return Ok(self.expected_entries_offset.borrow());
        }
        self.f_expected_entries_offset.set(true);
        *self.expected_entries_offset.borrow_mut() = (((20 as i32) + (((*self.string_count() as u32) * (40 as u32)) as i32))) as i32;
        Ok(self.expected_entries_offset.borrow())
    }

    /**
     * Size of the TLK header in bytes
     */
    pub fn header_size(
        &self
    ) -> KResult<Ref<'_, i8>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_header_size.get() {
            return Ok(self.header_size.borrow());
        }
        self.f_header_size.set(true);
        *self.header_size.borrow_mut() = (20) as i8;
        Ok(self.header_size.borrow())
    }
}

/**
 * File type signature. Must be "TLK " (space-padded).
 * Validates that this is a TLK file.
 * Note: Validation removed temporarily due to Kaitai Struct parser issues.
 */
impl Tlk_TlkHeader {
    pub fn file_type(&self) -> Ref<'_, String> {
        self.file_type.borrow()
    }
}

/**
 * File format version. "V3.0" for KotOR, "V4.0" for Jade Empire.
 * KotOR games use V3.0. Jade Empire uses V4.0.
 * Note: Validation removed due to Kaitai Struct parser limitations with period in string.
 */
impl Tlk_TlkHeader {
    pub fn file_version(&self) -> Ref<'_, String> {
        self.file_version.borrow()
    }
}

/**
 * Language identifier:
 * - 0 = English
 * - 1 = French
 * - 2 = German
 * - 3 = Italian
 * - 4 = Spanish
 * - 5 = Polish
 * - 128 = Korean
 * - 129 = Chinese Traditional
 * - 130 = Chinese Simplified
 * - 131 = Japanese
 * See Language enum for complete list.
 */
impl Tlk_TlkHeader {
    pub fn language_id(&self) -> Ref<'_, u32> {
        self.language_id.borrow()
    }
}

/**
 * Number of string entries in the file.
 * Determines the number of entries in string_data_table.
 */
impl Tlk_TlkHeader {
    pub fn string_count(&self) -> Ref<'_, u32> {
        self.string_count.borrow()
    }
}

/**
 * Byte offset to string entries array from the beginning of the file.
 * Typically 20 + (string_count * 40) = header size + string data table size.
 * Points to where the actual text strings begin.
 */
impl Tlk_TlkHeader {
    pub fn entries_offset(&self) -> Ref<'_, u32> {
        self.entries_offset.borrow()
    }
}
impl Tlk_TlkHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
