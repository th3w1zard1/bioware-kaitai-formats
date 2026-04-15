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
 * ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
 * ITP files use GFF format (FileType "ITP " in GFF header).
 * Uses GFF XML structure with root element <gff3> containing <struct> elements.
 * Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).
 * 
 * Canonical links: `meta.doc-ref` and `meta.xref`.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF (ITP is GFF-shaped)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — `GFF3File::readHeader`
 * \sa https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225 reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 xoreos-docs — Torlack ITP / MultiMap (GFF-family context)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
 */

#[derive(Default, Debug, Clone)]
pub struct ItpXml {
    pub _root: SharedType<ItpXml>,
    pub _parent: SharedType<ItpXml>,
    pub _self: SharedType<Self>,
    xml_content: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for ItpXml {
    type Root = ItpXml;
    type Parent = ItpXml;

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
        *self_rc.xml_content.borrow_mut() = bytes_to_str(&_io.read_bytes_full()?.into(), "UTF-8")?;
        Ok(())
    }
}
impl ItpXml {
}

/**
 * XML document content as UTF-8 text
 */
impl ItpXml {
    pub fn xml_content(&self) -> Ref<'_, String> {
        self.xml_content.borrow()
    }
}
impl ItpXml {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
