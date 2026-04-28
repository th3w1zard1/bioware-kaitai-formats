-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- NSS (NWScript Source) files contain human-readable NWScript source code
-- that compiles to NCS bytecode. NWScript is the scripting language used
-- in KotOR, TSL, and Neverwinter Nights.
-- 
-- NSS files are plain text files (typically Windows-1252 or UTF-8 encoding)
-- containing NWScript source code. The nwscript.nss file defines all
-- engine-exposed functions and constants available to scripts.
-- 
-- Format:
-- - Plain text source code
-- - May include BOM (Byte Order Mark) for UTF-8 files
-- - Lines are typically terminated with CRLF (\r\n) or LF (\n)
-- - Comments: // for single-line, /* */ for multi-line
-- - Preprocessor directives: #include, #define, etc.
-- 
-- Authoritative links: `meta.doc-ref` (PyKotor wiki, xoreos `types.h` `kFileTypeNSS`, xoreos-tools `NCSFile`, reone `NssWriter`).
-- See also: PyKotor wiki — NSS (https://github.com/OpenKotOR/PyKotor/wiki/NSS-File-Format)
-- See also: xoreos — `kFileTypeNSS` / `kFileTypeNCS` (Aurora `FileType` IDs; NSS plaintext, NCS bytecode) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L85-L86)
-- See also: xoreos-tools — `NCSFile` (https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137)
-- See also: reone — `NssWriter::save` (https://github.com/modawan/reone/blob/master/src/libs/tools/script/format/nsswriter.cpp#L33-L45)
-- See also: xoreos-docs — Torlack NCS (bytecode companion to plaintext NSS) (https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html)
-- See also: xoreos-docs — BioWare specs tree (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
Nss = class.class(KaitaiStruct)

function Nss:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Nss:_read()
  if self._io:pos() == 0 then
    self.bom = self._io:read_u2le()
    if not( ((self.bom == 65279) or (self.bom == 0)) ) then
      error("ValidationNotAnyOfError")
    end
  end
  self.source_code = str_decode.decode(self._io:read_bytes_full(), "UTF-8")
end

-- 
-- Optional UTF-8 BOM (Byte Order Mark) at the start of the file.
-- If present, will be 0xFEFF (UTF-8 BOM).
-- Most NSS files do not include a BOM.
-- 
-- Complete NWScript source code.
-- Contains function definitions, variable declarations, control flow
-- statements, and engine function calls.
-- 
-- Common elements:
-- - Function definitions: void function_name() { ... }
-- - Variable declarations: int variable_name;
-- - Control flow: if, while, for, switch
-- - Engine function calls: GetFirstObject(), GetObjectByTag(), etc.
-- - Constants: OBJECT_SELF, OBJECT_INVALID, etc.
-- 
-- The source code is compiled to NCS bytecode by the NWScript compiler.

-- 
-- NWScript source code structure.
-- This is primarily a text format, so the main content is the source_code string.
-- 
-- The source can be parsed into:
-- - Tokens (keywords, identifiers, operators, literals)
-- - Statements (declarations, assignments, control flow)
-- - Functions (definitions with parameters and body)
-- - Preprocessor directives (#include, #define)
Nss.NssSource = class.class(KaitaiStruct)

function Nss.NssSource:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Nss.NssSource:_read()
  self.content = str_decode.decode(self._io:read_bytes_full(), "UTF-8")
end

-- 
-- Complete source code content.

