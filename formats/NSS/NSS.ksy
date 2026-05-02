meta:
  id: nss
  title: BioWare NSS (NWScript Source) File
  license: MIT
  endian: le
  file-extension: nss
  encoding: UTF-8
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (plaintext / tooling; submodule section 0).
      Binary bytecode wire: `formats/NSS/NCS.ksy`.
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/ncs/
    pykotor_wiki_nss: https://github.com/OpenKotOR/PyKotor/wiki/NSS-File-Format
    xoreos_tools_ncsfile: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/nwscript/ncsfile.cpp#L106-L137
    xoreos_types_kfiletype_nss_ncs: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L85-L86
    reone_nsswriter_save: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/tools/script/format/nsswriter.cpp#L33-L45
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    xoreos_docs_torlack_ncs_html: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/ncs.html
doc: |
  NSS (NWScript Source) files contain human-readable NWScript source code
  that compiles to NCS bytecode. NWScript is the scripting language used
  in KotOR, TSL, and Neverwinter Nights.
  
  NSS files are plain text files (typically Windows-1252 or UTF-8 encoding)
  containing NWScript source code. The nwscript.nss file defines all
  engine-exposed functions and constants available to scripts.
  
  Format:
  - Plain text source code
  - May include BOM (Byte Order Mark) for UTF-8 files
  - Lines are typically terminated with CRLF (\r\n) or LF (\n)
  - Comments: // for single-line, /* */ for multi-line
  - Preprocessor directives: #include, #define, etc.
  
  Authoritative links: `meta.doc-ref` (PyKotor wiki, xoreos `types.h` `kFileTypeNSS`, xoreos-tools `NCSFile`, reone `NssWriter`).

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/NSS-File-Format PyKotor wiki — NSS"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L85-L86 xoreos — `kFileTypeNSS` / `kFileTypeNCS` (Aurora `FileType` IDs; NSS plaintext, NCS bytecode)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/nwscript/ncsfile.cpp#L106-L137 xoreos-tools — `NCSFile`"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/tools/script/format/nsswriter.cpp#L33-L45 reone — `NssWriter::save`"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/ncs.html xoreos-docs — Torlack NCS (bytecode companion to plaintext NSS)"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs tree"

seq:
  - id: bom
    type: u2
    if: _io.pos == 0
    doc: |
      Optional UTF-8 BOM (Byte Order Mark) at the start of the file.
      If present, will be 0xFEFF (UTF-8 BOM).
      Most NSS files do not include a BOM.
    valid:
      any-of:
        - 0xFEFF
        - 0x0000
  
  - id: source_code
    type: str
    size-eos: true
    encoding: UTF-8
    doc: |
      Complete NWScript source code.
      Contains function definitions, variable declarations, control flow
      statements, and engine function calls.
      
      Common elements:
      - Function definitions: void function_name() { ... }
      - Variable declarations: int variable_name;
      - Control flow: if, while, for, switch
      - Engine function calls: GetFirstObject(), GetObjectByTag(), etc.
      - Constants: OBJECT_SELF, OBJECT_INVALID, etc.
      
      The source code is compiled to NCS bytecode by the NWScript compiler.

types:
  nss_source:
    doc: |
      NWScript source code structure.
      This is primarily a text format, so the main content is the source_code string.
      
      The source can be parsed into:
      - Tokens (keywords, identifiers, operators, literals)
      - Statements (declarations, assignments, control flow)
      - Functions (definitions with parameters and body)
      - Preprocessor directives (#include, #define)
    
    seq:
      - id: content
        type: str
        size-eos: true
        encoding: UTF-8
        doc: Complete source code content.


