meta:
  id: lip_json
  title: BioWare LIP JSON Format
  license: MIT
  endian: le
  file-extension: lip.json
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/JSON interchange for LIP; game loads binary LIP (see LIP.ksy)."
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/
    pykotor_wiki_lip: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip
doc: |
  LIP JSON format is a human-readable JSON representation of LIP (Lipsync) binary files.
  Provides easier editing than binary LIP format.

  References:
  - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip_xml.py

seq:
  - id: json_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: JSON document content as UTF-8 text

