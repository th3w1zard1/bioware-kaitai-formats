meta:
  id: bioware_extract_common
  title: BioWare Extraction/Search Enums (reference-derived)
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    pykotor_ref: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/extract/installation.py
    pykotor_installation_search_location: https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/extract/installation.py#L67-L122
    kotor_net_installation_paths: https://github.com/NickHugi/Kotor.NET/blob/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2/Kotor.NET/Common/Installation.cs#L11-L79
    xoreos_aurora_types_filetype_enum: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L53-L60
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  Enums and small helper types used by installation/extraction tooling.

  Canonical links: `meta.doc-ref` and `meta.xref` (PyKotor `installation.py`; NickHugi `Installation.cs` for parallel .NET layout).

doc-ref:
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L53-L60 xoreos — `FileType` enum start (Aurora resource type IDs; no dedicated extraction-layout parser — this `.ksy` is tooling-side)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/extract/installation.py#L67-L122 PyKotor — `SearchLocation` / `TexturePackNames` (maps to enums in this `.ksy`)"
  - "https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/extract/ PyKotor — `extract/` package"
  - "https://github.com/NickHugi/Kotor.NET/blob/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2/Kotor.NET/Common/Installation.cs#L11-L79 NickHugi/Kotor.NET — `Installation` ctor (texture packs / capsules / folders)"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs tree (tooling enums; no extraction-specific PDF)"

types:
  bioware_texture_pack_name_str:
    doc: String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename).
    seq:
      - id: value
        type: str
        encoding: ASCII
        terminator: 0
        valid:
          any-of: 
            - "'swpc_tex_tpa.erf'"
            - "'swpc_tex_tpb.erf'"
            - "'swpc_tex_tpc.erf'"
            - "'swpc_tex_gui.erf'"

enums:
  # Extracted from `pykotor.extract.installation.SearchLocation` (IntEnum)
  bioware_search_location_id:
    0: override
    1: modules
    2: chitin
    3: textures_tpa
    4: textures_tpb
    5: textures_tpc
    6: textures_gui
    7: music
    8: sound
    9: voice
    10: lips
    11: rims
    12: custom_modules
    13: custom_folders
