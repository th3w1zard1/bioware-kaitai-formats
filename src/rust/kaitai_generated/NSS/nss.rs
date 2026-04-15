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
 * NSS (NWScript Source) files contain human-readable NWScript source code
 * that compiles to NCS bytecode. NWScript is the scripting language used
 * in KotOR, TSL, and Neverwinter Nights.
 * 
 * NSS files are plain text files (typically Windows-1252 or UTF-8 encoding)
 * containing NWScript source code. The nwscript.nss file defines all
 * engine-exposed functions and constants available to scripts.
 * 
 * Format:
 * - Plain text source code
 * - May include BOM (Byte Order Mark) for UTF-8 files
 * - Lines are typically terminated with CRLF (\r\n) or LF (\n)
 * - Comments: // for single-line, /* */ for multi-line
 * - Preprocessor directives: #include, #define, etc.
 * 
 * Authoritative links: `meta.doc-ref` (PyKotor wiki, xoreos `types.h` `kFileTypeNSS`, xoreos-tools `NCSFile`, reone `NssWriter`).
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/NSS-File-Format PyKotor wiki — NSS
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L85-L86 xoreos — `kFileTypeNSS` / `kFileTypeNCS` (Aurora `FileType` IDs; NSS plaintext, NCS bytecode)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137 xoreos-tools — `NCSFile`
 * \sa https://github.com/modawan/reone/blob/master/src/libs/tools/script/format/nsswriter.cpp#L33-L45 reone — `NssWriter::save`
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html xoreos-docs — Torlack NCS (bytecode companion to plaintext NSS)
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree
 */

#[derive(Default, Debug, Clone)]
pub struct Nss {
    pub _root: SharedType<Nss>,
    pub _parent: SharedType<Nss>,
    pub _self: SharedType<Self>,
    bom: RefCell<u16>,
    source_code: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Nss {
    type Root = Nss;
    type Parent = Nss;

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
        if ((_io.pos() as i32) == (0 as i32)) {
            *self_rc.bom.borrow_mut() = _io.read_u2le()?.into();
            if !( ((((*self_rc.bom() as i32) == (65279 as i32))) || (((*self_rc.bom() as u16) == (0 as u16)))) ) {
                return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotAnyOf, src_path: "/seq/0".to_string() }));
            }
        }
        *self_rc.source_code.borrow_mut() = bytes_to_str(&_io.read_bytes_full()?.into(), "UTF-8")?;
        Ok(())
    }
}
impl Nss {
}

/**
 * Optional UTF-8 BOM (Byte Order Mark) at the start of the file.
 * If present, will be 0xFEFF (UTF-8 BOM).
 * Most NSS files do not include a BOM.
 */
impl Nss {
    pub fn bom(&self) -> Ref<'_, u16> {
        self.bom.borrow()
    }
}

/**
 * Complete NWScript source code.
 * Contains function definitions, variable declarations, control flow
 * statements, and engine function calls.
 * 
 * Common elements:
 * - Function definitions: void function_name() { ... }
 * - Variable declarations: int variable_name;
 * - Control flow: if, while, for, switch
 * - Engine function calls: GetFirstObject(), GetObjectByTag(), etc.
 * - Constants: OBJECT_SELF, OBJECT_INVALID, etc.
 * 
 * The source code is compiled to NCS bytecode by the NWScript compiler.
 */
impl Nss {
    pub fn source_code(&self) -> Ref<'_, String> {
        self.source_code.borrow()
    }
}
impl Nss {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * NWScript source code structure.
 * This is primarily a text format, so the main content is the source_code string.
 * 
 * The source can be parsed into:
 * - Tokens (keywords, identifiers, operators, literals)
 * - Statements (declarations, assignments, control flow)
 * - Functions (definitions with parameters and body)
 * - Preprocessor directives (#include, #define)
 */

#[derive(Default, Debug, Clone)]
pub struct Nss_NssSource {
    pub _root: SharedType<Nss>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    content: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Nss_NssSource {
    type Root = Nss;
    type Parent = KStructUnit;

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
        *self_rc.content.borrow_mut() = bytes_to_str(&_io.read_bytes_full()?.into(), "UTF-8")?;
        Ok(())
    }
}
impl Nss_NssSource {
}

/**
 * Complete source code content.
 */
impl Nss_NssSource {
    pub fn content(&self) -> Ref<'_, String> {
        self.content.borrow()
    }
}
impl Nss_NssSource {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
