meta:
  id: ncs
  title: BioWare NCS (NWScript Compiled) Format
  license: MIT
  endian: be
  file-extension: ncs
  imports:
    - ../Common/bioware_ncs_common
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe--NCS bytecode executed by NWScript VM; big-endian wire format per PyKotor wiki.
    pykotor_ncs_tree: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/
    pykotor_io_ncs_load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/io_ncs.py#L60-L90
    pykotor_ncs_data: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py
    pykotor_wiki_ncs: https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format
    xoreos_ncsfile_load: https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355
    xoreos_tools_ncsfile_load: https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137
    xoreos_docs_torlack_ncs: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html
    reone_ncsreader_load: https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40
doc: |
  NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
  Scripts run inside a stack-based virtual machine shared across Aurora engine games.
  
  Format Structure:
  - Header (13 bytes): Signature "NCS ", version "V1.0", size marker (0x42), file size
  - Instruction Stream: Sequence of bytecode instructions
  
  All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).

  NWScript **source** (`.nss`) is plaintext tooling; it is intentionally not modeled as Kaitai in this repository
  (see `AGENTS.md`). This spec covers the **binary** `.ncs` wire format only.

  Opcode / qualifier enumerations: imported from `formats/Common/bioware_ncs_common.ksy` (mirrors PyKotor `ncs_data.py`).

  Authoritative parsers and notes: `meta.xref` and `doc-ref` (PyKotor, xoreos, xoreos-tools, xoreos-docs Torlack, reone).
doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format PyKotor wiki — NCS"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/io_ncs.py#L60-L90 PyKotor — compiled script load path"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355 xoreos — NCSFile::load"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137 xoreos-tools — NCSFile::load"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html xoreos-docs — Torlack ncs.html"
  - "https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40 reone — NcsReader::load"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L140 PyKotor — NCSByteCode / NCSInstructionQualifier (shared .ksy enums)"

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
    doc: File type signature. Must be "NCS " (0x4E 0x43 0x53 0x20).
    valid: "'NCS '"
  
  - id: file_version
    type: str
    encoding: ASCII
    size: 4
    doc: File format version. Must be "V1.0" (0x56 0x31 0x2E 0x30).
    valid: "'V1.0'"
  
  - id: size_marker
    type: u1
    doc: |
      Program size marker opcode. Must be 0x42.
      This is not a real instruction but a metadata field containing the total file size.
      All implementations validate this marker before parsing instructions.
    valid: 0x42
  
  - id: file_size
    type: u4
    doc: |
      Total file size in bytes (big-endian).
      This value should match the actual file size.
  
  - id: instructions
    type: instruction
    repeat: until
    repeat-until: _io.pos >= file_size
    doc: |
      Stream of bytecode instructions.
      Execution begins at offset 13 (0x0D) after the header.
      Instructions continue until end of file.

types:
  instruction:
    doc: |
      NWScript bytecode instruction.
      Format: <opcode: uint8> <qualifier: uint8> <arguments: variable>
      
      Instruction size varies by opcode:
      - Base: 2 bytes (opcode + qualifier)
      - Arguments: 0 to variable bytes depending on instruction type
      
      Common instruction types:
      - Constants: CONSTI (6B), CONSTF (6B), CONSTS (2+N B), CONSTO (6B)
      - Stack ops: CPDOWNSP, CPTOPSP, MOVSP (variable size)
      - Arithmetic: ADDxx, SUBxx, MULxx, DIVxx (2B)
      - Control flow: JMP, JSR, JZ, JNZ (6B), RETN (2B)
      - Function calls: ACTION (5B)
      - And many more (see NCS format documentation)
    
    seq:
      - id: opcode
        type: u1
        enum: bioware_ncs_common::ncs_bytecode
        doc: |
          Instruction opcode (0x01-0x2D, excluding 0x42 which is reserved for size marker).
          Determines the instruction type and argument format.
      
      - id: qualifier
        type: u1
        enum: bioware_ncs_common::ncs_instruction_qualifier
        doc: |
          Qualifier byte that refines the instruction to specific operand types.
          Examples: 0x03=Int, 0x04=Float, 0x05=String, 0x06=Object, 0x24=Structure
      
      - id: arguments
        type: u1
        repeat: until
        repeat-until: _io.pos >= _io.size
        doc: |
          Instruction arguments (variable size).
          Format depends on opcode:
          - No args: None (total 2B)
          - Int/Float/Object: 4 bytes (total 6B)
          - String: 2B length + data (total 2+N B)
          - Jump: 4B signed offset (total 6B)
          - Stack copy: 4B offset + 2B size (total 8B)
          - ACTION: 2B routine + 1B argCount (total 5B)
          - DESTRUCT: 2B size + 2B offset + 2B sizeNoDestroy (total 8B)
          - STORE_STATE: 4B size + 4B sizeLocals (total 10B)
          - And others (see documentation)
