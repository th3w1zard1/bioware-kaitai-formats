meta:
  id: ncs_minimal
  title: BioWare NCS (Compiled Script) Minimal Format
  license: MIT
  endian: be
  file-extension: ncs
  xref:
    ghidra_odyssey_k1:
      note: "Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: same NCS VM bytecode as NCS.ksy; this file is a reduced schema."
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/
    pykotor_wiki_ncs: https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
  
  - id: file_version
    type: str
    encoding: ASCII
    size: 4
  
  - id: size_marker
    type: u1
  
  - id: total_file_size
    type: u4
  
  - id: instructions
    type: instruction
    repeat: until
    repeat-until: _io.pos >= _root.total_file_size

types:
  instruction:
    seq:
      - id: bytecode
        type: u1
      - id: qualifier
        type: u1

