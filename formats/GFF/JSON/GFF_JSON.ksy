meta:
  id: gff_json
  title: BioWare GFF JSON Format
  license: MIT
  endian: le
  file-extension: gff.json
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/JSON interchange for GFF; not the binary parser path in k1_win_gog_swkotor.exe."
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/
    pykotor_wiki_gff_format: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
doc: |
  GFF JSON format is a human-readable JSON representation of GFF (Generic File Format) binary files.
  Provides easier editing and interoperability with modern tools than binary GFF format.

  References:
  - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py

seq:
  - id: json_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: JSON document content as UTF-8 text

