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
 * NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
 * Scripts run inside a stack-based virtual machine shared across Aurora engine games.
 * 
 * Format Structure:
 * - Header (13 bytes): Signature "NCS ", version "V1.0", size marker (0x42), file size
 * - Instruction Stream: Sequence of bytecode instructions
 * 
 * All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format - Complete NCS format documentation
 * - NSS.ksy - NWScript source code that compiles to NCS
 */

#[derive(Default, Debug, Clone)]
pub struct Ncs {
    pub _root: SharedType<Ncs>,
    pub _parent: SharedType<Ncs>,
    pub _self: SharedType<Self>,
    file_type: RefCell<String>,
    file_version: RefCell<String>,
    size_marker: RefCell<u8>,
    file_size: RefCell<u32>,
    instructions: RefCell<Vec<OptRc<Ncs_Instruction>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Ncs {
    type Root = Ncs;
    type Parent = Ncs;

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
        if !(*self_rc.file_type() == "NCS ".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/0".to_string() }));
        }
        *self_rc.file_version.borrow_mut() = bytes_to_str(&_io.read_bytes(4 as usize)?.into(), "ASCII")?;
        if !(*self_rc.file_version() == "V1.0".to_string()) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/1".to_string() }));
        }
        *self_rc.size_marker.borrow_mut() = _io.read_u1()?.into();
        if !(((*self_rc.size_marker() as u8) == (66 as u8))) {
            return Err(KError::ValidationFailed(ValidationFailedError { kind: ValidationKind::NotEqual, src_path: "/seq/2".to_string() }));
        }
        *self_rc.file_size.borrow_mut() = _io.read_u4be()?.into();
        *self_rc.instructions.borrow_mut() = Vec::new();
        {
            let mut _i = 0;
            while {
                let t = Self::read_into::<_, Ncs_Instruction>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
                self_rc.instructions.borrow_mut().push(t);
                let _t_instructions = self_rc.instructions.borrow();
                let _tmpa = _t_instructions.last().unwrap();
                _i += 1;
                let x = !(((_io.pos() as i32) >= (*self_rc.file_size() as i32)));
                x
            } {}
        }
        Ok(())
    }
}
impl Ncs {
}

/**
 * File type signature. Must be "NCS " (0x4E 0x43 0x53 0x20).
 */
impl Ncs {
    pub fn file_type(&self) -> Ref<'_, String> {
        self.file_type.borrow()
    }
}

/**
 * File format version. Must be "V1.0" (0x56 0x31 0x2E 0x30).
 */
impl Ncs {
    pub fn file_version(&self) -> Ref<'_, String> {
        self.file_version.borrow()
    }
}

/**
 * Program size marker opcode. Must be 0x42.
 * This is not a real instruction but a metadata field containing the total file size.
 * All implementations validate this marker before parsing instructions.
 */
impl Ncs {
    pub fn size_marker(&self) -> Ref<'_, u8> {
        self.size_marker.borrow()
    }
}

/**
 * Total file size in bytes (big-endian).
 * This value should match the actual file size.
 */
impl Ncs {
    pub fn file_size(&self) -> Ref<'_, u32> {
        self.file_size.borrow()
    }
}

/**
 * Stream of bytecode instructions.
 * Execution begins at offset 13 (0x0D) after the header.
 * Instructions continue until end of file.
 */
impl Ncs {
    pub fn instructions(&self) -> Ref<'_, Vec<OptRc<Ncs_Instruction>>> {
        self.instructions.borrow()
    }
}
impl Ncs {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * NWScript bytecode instruction.
 * Format: <opcode: uint8> <qualifier: uint8> <arguments: variable>
 * 
 * Instruction size varies by opcode:
 * - Base: 2 bytes (opcode + qualifier)
 * - Arguments: 0 to variable bytes depending on instruction type
 * 
 * Common instruction types:
 * - Constants: CONSTI (6B), CONSTF (6B), CONSTS (2+N B), CONSTO (6B)
 * - Stack ops: CPDOWNSP, CPTOPSP, MOVSP (variable size)
 * - Arithmetic: ADDxx, SUBxx, MULxx, DIVxx (2B)
 * - Control flow: JMP, JSR, JZ, JNZ (6B), RETN (2B)
 * - Function calls: ACTION (5B)
 * - And many more (see NCS format documentation)
 */

#[derive(Default, Debug, Clone)]
pub struct Ncs_Instruction {
    pub _root: SharedType<Ncs>,
    pub _parent: SharedType<Ncs>,
    pub _self: SharedType<Self>,
    opcode: RefCell<u8>,
    qualifier: RefCell<u8>,
    arguments: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Ncs_Instruction {
    type Root = Ncs;
    type Parent = Ncs;

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
        *self_rc.opcode.borrow_mut() = _io.read_u1()?.into();
        *self_rc.qualifier.borrow_mut() = _io.read_u1()?.into();
        *self_rc.arguments.borrow_mut() = Vec::new();
        {
            let mut _i = 0;
            while {
                self_rc.arguments.borrow_mut().push(_io.read_u1()?.into());
                let _t_arguments = self_rc.arguments.borrow();
                let _tmpa = *_t_arguments.last().unwrap();
                _i += 1;
                let x = !(_io.pos() >= _io.size());
                x
            } {}
        }
        Ok(())
    }
}
impl Ncs_Instruction {
}

/**
 * Instruction opcode (0x01-0x2D, excluding 0x42 which is reserved for size marker).
 * Determines the instruction type and argument format.
 */
impl Ncs_Instruction {
    pub fn opcode(&self) -> Ref<'_, u8> {
        self.opcode.borrow()
    }
}

/**
 * Qualifier byte that refines the instruction to specific operand types.
 * Examples: 0x03=Int, 0x04=Float, 0x05=String, 0x06=Object, 0x24=Structure
 */
impl Ncs_Instruction {
    pub fn qualifier(&self) -> Ref<'_, u8> {
        self.qualifier.borrow()
    }
}

/**
 * Instruction arguments (variable size).
 * Format depends on opcode:
 * - No args: None (total 2B)
 * - Int/Float/Object: 4 bytes (total 6B)
 * - String: 2B length + data (total 2+N B)
 * - Jump: 4B signed offset (total 6B)
 * - Stack copy: 4B offset + 2B size (total 8B)
 * - ACTION: 2B routine + 1B argCount (total 5B)
 * - DESTRUCT: 2B size + 2B offset + 2B sizeNoDestroy (total 8B)
 * - STORE_STATE: 4B size + 4B sizeLocals (total 10B)
 * - And others (see documentation)
 */
impl Ncs_Instruction {
    pub fn arguments(&self) -> Ref<'_, Vec<u8>> {
        self.arguments.borrow()
    }
}
impl Ncs_Instruction {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
