meta:
  id: ssf_xml
  title: BioWare SSF XML Format
  license: MIT
  endian: le
  file-extension: ssf.xml
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/XML interchange for SSF; game loads binary SSF (see SSF.ksy)."
    pykotor_library_ssf_binary: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/ssf.py
    pykotor_library_ssf_xml: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf_xml.py
    reone: https://github.com/seedhartha/reone/tree/master/src/libs/resource/parser/ssf.cpp
    pykotor_wiki_ssf: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf
    xoreos: https://github.com/xoreos/xoreos/tree/master/src/aurora/ssffile.cpp
doc: |
  SSF XML format is a human-readable XML representation of SSF (Soundset) binary files.
  Provides easier editing than binary SSF format.

  References:
  - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/ssf.py
  - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf_xml.py
  - https://github.com/seedhartha/reone/tree/master/src/libs/resource/parser/ssf.cpp
  - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf
  - https://github.com/xoreos/xoreos/tree/master/src/aurora/ssffile.cpp

seq:
  - id: xml_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: XML document content as UTF-8 text

