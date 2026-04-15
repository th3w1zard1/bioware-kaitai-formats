meta:
  id: bioware_ncs_common
  title: BioWare NCS / NWScript bytecode shared enumerations
  license: MIT
  endian: be
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1:
      note: "Shared NCS opcode/qualifier enums — VM/Ghidra context on `formats/NSS/NCS.ksy`; `user-agdec-http` per AGENTS.md."
    pykotor_ncs_data_bytecode: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L115
    pykotor_ncs_data_qualifier: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L118-L140
    pykotor_wiki_ncs: https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format
    xoreos_ncs_load: https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355
    xoreos_tools_ncsfile_load: https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137
    reone_ncsreader_load: https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40
    xoreos_docs_torlack_ncs: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html
doc: |
  Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).

  - `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
    (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
  - `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
    decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
  - `ncs_program_size_marker` is the fixed header byte after `"V1.0"` in retail KotOR NCS blobs (`0x42`).

  **Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
  duplicating opcode lists.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L115 PyKotor — NCSByteCode"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L118-L140 PyKotor — NCSInstructionQualifier"
  - "https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format PyKotor wiki — NCS"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355 xoreos — NCSFile::load"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137 xoreos-tools — NCSFile::load"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html xoreos-docs — Torlack ncs.html"
  - "https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40 reone — NcsReader::load"

enums:
  # Fixed header byte (see PyKotor wiki “Header” / `NCS.ksy` `size_marker`).
  ncs_program_size_marker:
    0x42: program_size_prefix

  # PyKotor `NCSByteCode` — one name per opcode byte.
  ncs_bytecode:
    0x00: reserved_bc
    0x01: cpdownsp
    0x02: rsaddx
    0x03: cptopsp
    0x04: constx
    0x05: action
    0x06: logandxx
    0x07: logorxx
    0x08: incorxx
    0x09: excorxx
    0x0a: boolandxx
    0x0b: equalxx
    0x0c: nequalxx
    0x0d: geqxx
    0x0e: gtxx
    0x0f: ltxx
    0x10: leqxx
    0x11: shleftxx
    0x12: shrightxx
    0x13: ushrightxx
    0x14: addxx
    0x15: subxx
    0x16: mulxx
    0x17: divxx
    0x18: modxx
    0x19: negx
    0x1a: compx
    0x1b: movsp
    0x1c: unused_gap
    0x1d: jmp
    0x1e: jsr
    0x1f: jz
    0x20: retn
    0x21: destruct
    0x22: notx
    0x23: decxsp
    0x24: incxsp
    0x25: jnz
    0x26: cpdownbp
    0x27: cptopbp
    0x28: decxbp
    0x29: incxbp
    0x2a: savebp
    0x2b: restorebp
    0x2c: store_state
    0x2d: nop

  # PyKotor `NCSInstructionQualifier` — second byte of each instruction row.
  ncs_instruction_qualifier:
    0x00: none
    0x01: unary_operand_layout
    0x03: int_type
    0x04: float_type
    0x05: string_type
    0x06: object_type
    0x10: effect_type
    0x11: event_type
    0x12: location_type
    0x13: talent_type
    0x20: int_int
    0x21: float_float
    0x22: object_object
    0x23: string_string
    0x24: struct_struct
    0x25: int_float
    0x26: float_int
    0x30: effect_effect
    0x31: event_event
    0x32: location_location
    0x33: talent_talent
    0x3a: vector_vector
    0x3b: vector_float
    0x3c: float_vector
