-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
-- Scripts run inside a stack-based virtual machine shared across Aurora engine games.
-- 
-- Format Structure:
-- - Header (13 bytes): Signature "NCS ", version "V1.0", size marker (0x42), file size
-- - Instruction Stream: Sequence of bytecode instructions
-- 
-- All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).
-- 
-- References:
-- - https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format - Complete NCS format documentation
-- - NSS.ksy - NWScript source code that compiles to NCS
Ncs = class.class(KaitaiStruct)

function Ncs:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Ncs:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_type == "NCS ") then
    error("not equal, expected " .. "NCS " .. ", but got " .. self.file_type)
  end
  self.file_version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  if not(self.file_version == "V1.0") then
    error("not equal, expected " .. "V1.0" .. ", but got " .. self.file_version)
  end
  self.size_marker = self._io:read_u1()
  if not(self.size_marker == 66) then
    error("not equal, expected " .. 66 .. ", but got " .. self.size_marker)
  end
  self.file_size = self._io:read_u4be()
  self.instructions = {}
  local i = 0
  while true do
    local _ = Ncs.Instruction(self._io, self, self._root)
    self.instructions[i + 1] = _
    if self._io:pos() >= self.file_size then
      break
    end
    i = i + 1
  end
end

-- 
-- File type signature. Must be "NCS " (0x4E 0x43 0x53 0x20).
-- 
-- File format version. Must be "V1.0" (0x56 0x31 0x2E 0x30).
-- 
-- Program size marker opcode. Must be 0x42.
-- This is not a real instruction but a metadata field containing the total file size.
-- All implementations validate this marker before parsing instructions.
-- 
-- Total file size in bytes (big-endian).
-- This value should match the actual file size.
-- 
-- Stream of bytecode instructions.
-- Execution begins at offset 13 (0x0D) after the header.
-- Instructions continue until end of file.

-- 
-- NWScript bytecode instruction.
-- Format: <opcode: uint8> <qualifier: uint8> <arguments: variable>
-- 
-- Instruction size varies by opcode:
-- - Base: 2 bytes (opcode + qualifier)
-- - Arguments: 0 to variable bytes depending on instruction type
-- 
-- Common instruction types:
-- - Constants: CONSTI (6B), CONSTF (6B), CONSTS (2+N B), CONSTO (6B)
-- - Stack ops: CPDOWNSP, CPTOPSP, MOVSP (variable size)
-- - Arithmetic: ADDxx, SUBxx, MULxx, DIVxx (2B)
-- - Control flow: JMP, JSR, JZ, JNZ (6B), RETN (2B)
-- - Function calls: ACTION (5B)
-- - And many more (see NCS format documentation)
Ncs.Instruction = class.class(KaitaiStruct)

function Ncs.Instruction:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Ncs.Instruction:_read()
  self.opcode = self._io:read_u1()
  self.qualifier = self._io:read_u1()
  self.arguments = {}
  local i = 0
  while true do
    local _ = self._io:read_u1()
    self.arguments[i + 1] = _
    if self._io:pos() >= self._io:size() then
      break
    end
    i = i + 1
  end
end

-- 
-- Instruction opcode (0x01-0x2D, excluding 0x42 which is reserved for size marker).
-- Determines the instruction type and argument format.
-- 
-- Qualifier byte that refines the instruction to specific operand types.
-- Examples: 0x03=Int, 0x04=Float, 0x05=String, 0x06=Object, 0x24=Structure
-- 
-- Instruction arguments (variable size).
-- Format depends on opcode:
-- - No args: None (total 2B)
-- - Int/Float/Object: 4 bytes (total 6B)
-- - String: 2B length + data (total 2+N B)
-- - Jump: 4B signed offset (total 6B)
-- - Stack copy: 4B offset + 2B size (total 8B)
-- - ACTION: 2B routine + 1B argCount (total 5B)
-- - DESTRUCT: 2B size + 2B offset + 2B sizeNoDestroy (total 8B)
-- - STORE_STATE: 4B size + 4B sizeLocals (total 10B)
-- - And others (see documentation)

