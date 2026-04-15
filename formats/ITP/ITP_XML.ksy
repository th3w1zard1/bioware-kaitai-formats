meta:
  id: itp_xml
  title: BioWare ITP XML Format
  license: MIT
  endian: le
  file-extension: itp.xml
  encoding: UTF-8
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (XML interchange; submodule section 0).
      Binary GFF / GFF3 wire: `formats/GFF/GFF.ksy`.
    ghidra_odyssey_k1: |
      - Tooling/XML for ITP (GFF family)
      - Binary GFF rules in GFF.ksy match k1_win_gog_swkotor.exe.
    pykotor_library_itp_binary: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/itp/itp.py
    pykotor_library_itp_xml: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py
    reone: https://github.com/seedhartha/reone/tree/master/src/libs/resource/parser/gff/itp.cpp
    pykotor_wiki_gff_format: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
    xoreos_gff3file_read_header: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63
doc: |
  ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
  ITP files use GFF format (FileType "ITP " in GFF header).
  Uses GFF XML structure with root element <gff3> containing <struct> elements.
  Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).

  Canonical links: `meta.doc-ref` and `meta.xref`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF (ITP is GFF-shaped)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — `GFF3File::readHeader`"
  - "https://github.com/seedhartha/reone/blob/master/src/libs/resource/parser/gff/itp.cpp reone — ITP parser (fork path; verify against modawan/reone if migrating)"

seq:
  - id: xml_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: XML document content as UTF-8 text

