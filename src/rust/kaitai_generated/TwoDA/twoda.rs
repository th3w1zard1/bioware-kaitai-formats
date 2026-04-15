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
 * TwoDA (2D Array) files store tabular data in a binary format used by BioWare games
 * including Knights of the Old Republic (KotOR) and The Sith Lords (TSL).
 * 
 * TwoDA files are essentially two-dimensional arrays (tables) with:
 * - Column headers (first row defines column names)
 * - Row labels (first column defines row identifiers)
 * - Cell values (data at row/column intersections)
 * 
 * Binary Format Structure:
 * - File Header (9 bytes): Magic "2DA " (space-padded), version "V2.b", and newline
 * - Column Headers Section: Tab-separated column names, terminated by null byte
 * - Row Count (4 bytes): uint32 indicating number of data rows
 * - Row Labels Section: Tab-separated row labels (one per row)
 * - Cell Offsets Array: Array of uint16 offsets (rowCount * columnCount entries)
 * - Data Size (2 bytes): uint16 indicating total size of cell data section
 * - Cell Values Section: Null-terminated strings at offsets specified in offsets array
 * 
 * The format uses an offset-based string table for cell values, allowing efficient
 * storage of duplicate values (shared strings are stored once and referenced by offset).
 * 
 * Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_twoda` / `twoda_data`, xoreos `TwoDAFile`, xoreos-tools `convert2da`, reone `TwoDAReader`, KotOR.js `TwoDAObject`).
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/2DA-File-Format PyKotor wiki — TwoDA
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py#L25-L238 PyKotor — `io_twoda` (binary `V2.b` + writer)
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py#L8-L114 PyKotor — `twoda_data` (model + ASCII/binary notes)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L48-L51 xoreos — `k2DAID` / `k2DAIDTab` + version tags
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L145-L172 xoreos — `TwoDAFile::load`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L192-L336 xoreos — binary `V2.b` (`read2b` + `readHeaders2b` / `skipRowNames2b` / `readRows2b`)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L517-L611 xoreos — `TwoDAFile::writeBinary`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86 xoreos-tools — `convert2da` CLI (`main`)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159 xoreos-tools — `get2DAGDA` / `TwoDAFile` dispatch
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/2dareader.cpp#L29-L66 reone — `TwoDAReader`
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TwoDAObject.ts#L69-L155 KotOR.js — `TwoDAObject`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf xoreos-docs — 2DA_Format.pdf
 */

#[derive(Default, Debug, Clone)]
pub struct Twoda {
    pub _root: SharedType<Twoda>,
    pub _parent: SharedType<Twoda>,
    pub _self: SharedType<Self>,
    column_count: RefCell<u32>,
    header: RefCell<OptRc<Twoda_TwodaHeader>>,
    column_headers_raw: RefCell<String>,
    row_count: RefCell<u32>,
    row_labels_section: RefCell<OptRc<Twoda_RowLabelsSection>>,
    cell_offsets: RefCell<Vec<u16>>,
    len_cell_values_section: RefCell<u16>,
    cell_values_section: RefCell<OptRc<Twoda_CellValuesSection>>,
    _io: RefCell<BytesReader>,
    cell_values_section_raw: RefCell<Vec<u8>>,
}
impl KStruct for Twoda {
    type Root = Twoda;
    type Parent = Twoda;

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
        let t = Self::read_into::<_, Twoda_TwodaHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        *self_rc.column_headers_raw.borrow_mut() = bytes_to_str(&_io.read_bytes_term(0, false, true, true)?.into(), "ASCII")?;
        *self_rc.row_count.borrow_mut() = _io.read_u4le()?.into();
        let t = Self::read_into::<_, Twoda_RowLabelsSection>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.row_labels_section.borrow_mut() = t;
        *self_rc.cell_offsets.borrow_mut() = Vec::new();
        let l_cell_offsets = ((*self_rc.row_count() as i32) * (*self_rc.column_count() as i32));
        for _i in 0..l_cell_offsets {
            self_rc.cell_offsets.borrow_mut().push(_io.read_u2le()?.into());
        }
        *self_rc.len_cell_values_section.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.cell_values_section_raw.borrow_mut() = _io.read_bytes(*self_rc.len_cell_values_section() as usize)?.into();
        let cell_values_section_raw = self_rc.cell_values_section_raw.borrow();
        let _t_cell_values_section_raw_io = BytesReader::from(cell_values_section_raw.clone());
        let t = Self::read_into::<BytesReader, Twoda_CellValuesSection>(&_t_cell_values_section_raw_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.cell_values_section.borrow_mut() = t;
        Ok(())
    }
}
impl Twoda {
    pub fn column_count(&self) -> Ref<'_, u32> {
        self.column_count.borrow()
    }
}
impl Twoda {
    pub fn set_params(&mut self, column_count: u32) {
        *self.column_count.borrow_mut() = column_count;
    }
}
impl Twoda {
}

/**
 * TwoDA file header (9 bytes) - magic "2DA ", version "V2.b", and newline character
 */
impl Twoda {
    pub fn header(&self) -> Ref<'_, OptRc<Twoda_TwodaHeader>> {
        self.header.borrow()
    }
}

/**
 * Column headers section as a single null-terminated string.
 * Contains tab-separated column names. The null terminator marks the end.
 * Column names can be extracted by splitting on tab characters (0x09).
 * Example: "col1\tcol2\tcol3\0" represents three columns: "col1", "col2", "col3"
 */
impl Twoda {
    pub fn column_headers_raw(&self) -> Ref<'_, String> {
        self.column_headers_raw.borrow()
    }
}

/**
 * Number of data rows in the TwoDA table.
 * This count determines how many row labels and how many cell entries per column.
 */
impl Twoda {
    pub fn row_count(&self) -> Ref<'_, u32> {
        self.row_count.borrow()
    }
}

/**
 * Row labels section - tab-separated row labels (one per row)
 */
impl Twoda {
    pub fn row_labels_section(&self) -> Ref<'_, OptRc<Twoda_RowLabelsSection>> {
        self.row_labels_section.borrow()
    }
}

/**
 * Array of cell value offsets (uint16 per cell). There are exactly row_count * column_count
 * entries, in row-major order. Each offset is relative to the start of the cell values blob
 * and points to a null-terminated string.
 */
impl Twoda {
    pub fn cell_offsets(&self) -> Ref<'_, Vec<u16>> {
        self.cell_offsets.borrow()
    }
}

/**
 * Total size in bytes of the cell values data section.
 * This is the size of all unique cell value strings combined (including null terminators).
 * Not used during reading but stored for format consistency.
 */
impl Twoda {
    pub fn len_cell_values_section(&self) -> Ref<'_, u16> {
        self.len_cell_values_section.borrow()
    }
}

/**
 * Cell values data section containing all unique cell value strings.
 * Each string is null-terminated. Offsets from cell_offsets point into this section.
 * The section starts immediately after len_cell_values_section field and has size = len_cell_values_section bytes.
 */
impl Twoda {
    pub fn cell_values_section(&self) -> Ref<'_, OptRc<Twoda_CellValuesSection>> {
        self.cell_values_section.borrow()
    }
}
impl Twoda {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
impl Twoda {
    pub fn cell_values_section_raw(&self) -> Ref<'_, Vec<u8>> {
        self.cell_values_section_raw.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Twoda_CellValuesSection {
    pub _root: SharedType<Twoda>,
    pub _parent: SharedType<Twoda>,
    pub _self: SharedType<Self>,
    raw_data: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Twoda_CellValuesSection {
    type Root = Twoda;
    type Parent = Twoda;

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
        *self_rc.raw_data.borrow_mut() = bytes_to_str(&_io.read_bytes(*_r.len_cell_values_section() as usize)?.into(), "ASCII")?;
        Ok(())
    }
}
impl Twoda_CellValuesSection {
}

/**
 * Raw cell values data as a single string.
 * Contains all null-terminated cell value strings concatenated together.
 * Individual strings can be extracted using offsets from cell_offsets.
 * Note: To read a specific cell value, seek to (cell_values_section start + offset) and read a null-terminated string.
 */
impl Twoda_CellValuesSection {
    pub fn raw_data(&self) -> Ref<'_, String> {
        self.raw_data.borrow()
    }
}
impl Twoda_CellValuesSection {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Twoda_RowLabelEntry {
    pub _root: SharedType<Twoda>,
    pub _parent: SharedType<Twoda_RowLabelsSection>,
    pub _self: SharedType<Self>,
    label_value: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Twoda_RowLabelEntry {
    type Root = Twoda;
    type Parent = Twoda_RowLabelsSection;

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
        *self_rc.label_value.borrow_mut() = bytes_to_str(&_io.read_bytes_term(9, false, true, false)?.into(), "ASCII")?;
        Ok(())
    }
}
impl Twoda_RowLabelEntry {
}

/**
 * Row label value (ASCII string terminated by tab character 0x09).
 * Tab terminator is consumed but not included in the string value.
 * Row labels uniquely identify each row in the table.
 * Often numeric (e.g., "0", "1", "2") but can be any string identifier.
 */
impl Twoda_RowLabelEntry {
    pub fn label_value(&self) -> Ref<'_, String> {
        self.label_value.borrow()
    }
}
impl Twoda_RowLabelEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Twoda_RowLabelsSection {
    pub _root: SharedType<Twoda>,
    pub _parent: SharedType<Twoda>,
    pub _self: SharedType<Self>,
    labels: RefCell<Vec<OptRc<Twoda_RowLabelEntry>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Twoda_RowLabelsSection {
    type Root = Twoda;
    type Parent = Twoda;

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
        *self_rc.labels.borrow_mut() = Vec::new();
        let l_labels = *_r.row_count();
        for _i in 0..l_labels {
            let t = Self::read_into::<_, Twoda_RowLabelEntry>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            self_rc.labels.borrow_mut().push(t);
        }
        Ok(())
    }
}
impl Twoda_RowLabelsSection {
}

/**
 * Array of row label entries, one per row.
 * Each label is terminated by tab character (0x09).
 * Total count equals row_count from the header.
 * Row labels typically identify each data row (e.g., numeric IDs, names, etc.).
 */
impl Twoda_RowLabelsSection {
    pub fn labels(&self) -> Ref<'_, Vec<OptRc<Twoda_RowLabelEntry>>> {
        self.labels.borrow()
    }
}
impl Twoda_RowLabelsSection {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

#[derive(Default, Debug, Clone)]
pub struct Twoda_TwodaHeader {
    pub _root: SharedType<Twoda>,
    pub _parent: SharedType<Twoda>,
    pub _self: SharedType<Self>,
    magic: RefCell<String>,
    version: RefCell<String>,
    newline: RefCell<u8>,
    _io: RefCell<BytesReader>,
    f_is_valid_twoda: Cell<bool>,
    is_valid_twoda: RefCell<bool>,
}
impl KStruct for Twoda_TwodaHeader {
    type Root = Twoda;
    type Parent = Twoda;

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
        *self_rc.magic.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        *self_rc.version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        *self_rc.newline.borrow_mut() = _io.read_u1()?.into();
        Ok(())
    }
}
impl Twoda_TwodaHeader {

    /**
     * Validation check that the file is a valid TwoDA file.
     * All header fields must match expected values.
     */
    pub fn is_valid_twoda(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_valid_twoda.get() {
            return Ok(self.is_valid_twoda.borrow());
        }
        self.f_is_valid_twoda.set(true);
        *self.is_valid_twoda.borrow_mut() = ( ((*self.magic() == "2DA ".to_string()) && (*self.version() == "V2.b".to_string()) && (((*self.newline() as u8) == (10 as u8)))) ) as bool;
        Ok(self.is_valid_twoda.borrow())
    }
}

/**
 * File type signature. Must be "2DA " (space-padded).
 * Bytes: 0x32 0x44 0x41 0x20
 * The space after "2DA" is significant and must be present.
 */
impl Twoda_TwodaHeader {
    pub fn magic(&self) -> Ref<'_, String> {
        self.magic.borrow()
    }
}

/**
 * File format version. Always "V2.b" for KotOR/TSL TwoDA files.
 * Bytes: 0x56 0x32 0x2E 0x62
 * This is the binary version identifier (V2.b = Version 2 binary).
 */
impl Twoda_TwodaHeader {
    pub fn version(&self) -> Ref<'_, String> {
        self.version.borrow()
    }
}

/**
 * Newline character (0x0A = '\n').
 * Separates header from column headers section.
 */
impl Twoda_TwodaHeader {
    pub fn newline(&self) -> Ref<'_, u8> {
        self.newline.borrow()
    }
}
impl Twoda_TwodaHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
