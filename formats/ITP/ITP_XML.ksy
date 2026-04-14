meta:
  id: itp_xml
  title: BioWare ITP XML Format
  license: MIT
  endian: le
  file-extension: itp.xml
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/XML for ITP (GFF family); binary GFF rules in GFF.ksy match k1_win_gog_swkotor.exe."
    pykotor_library_itp_binary: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/itp/itp.py
    pykotor_library_itp_xml: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py
    reone: https://github.com/seedhartha/reone/tree/master/src/libs/resource/parser/gff/itp.cpp
    pykotor_wiki_gff_format: https://github.com/OldRepublicDevs/PyKotor/wiki/GFF-File-Format.md
    pykotor_wiki_itp: https://github.com/OldRepublicDevs/PyKotor/wiki/ITP-File-Format.md
    xoreos: https://github.com/xoreos/xoreos/tree/master/src/aurora/gff3file.cpp
doc: |
  ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
  ITP files use GFF format (FileType "ITP " in GFF header).
  Uses GFF XML structure with root element <gff3> containing <struct> elements.
  Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).

  References:
  - https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/itp/itp.py
  - https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py
  - https://github.com/seedhartha/reone/tree/master/src/libs/resource/parser/gff/itp.cpp
  - https://github.com/OldRepublicDevs/PyKotor/wiki/GFF-File-Format.md
  - https://github.com/OldRepublicDevs/PyKotor/wiki/ITP-File-Format.md
  - https://github.com/xoreos/xoreos/tree/master/src/aurora/gff3file.cpp

seq:
  - id: xml_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: XML document content as UTF-8 text

