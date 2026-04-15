meta:
  id: tlk_xml
  title: BioWare TLK XML Format
  license: MIT
  endian: le
  file-extension: tlk.xml
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/XML interchange for TLK; k1_win_gog_swkotor.exe reads binary .tlk (see TLK.ksy)."
    pykotor_library_tlk_binary: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/tlk.py
    pykotor_library_tlk_xml: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk_xml.py
    reone: https://github.com/seedhartha/reone/tree/master/src/libs/resource/format/tlkreader.cpp
    pykotor_wiki_tlk: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk
    xoreos: https://github.com/xoreos/xoreos/tree/master/src/aurora/talktable.cpp
doc: |
  TLK XML format is a human-readable XML representation of TLK (Talk Table) binary files.
  Provides easier editing and translation than binary TLK format.

  References:
  - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/tlk.py
  - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk_xml.py
  - https://github.com/seedhartha/reone/tree/master/src/libs/resource/format/tlkreader.cpp
  - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk
  - https://github.com/xoreos/xoreos/tree/master/src/aurora/talktable.cpp

  - ../GFF/GFF
  - ../GFF/XML/GFF_XML
  - ../TLK/TLK

seq:
  - id: xml_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: XML document content as UTF-8 text

