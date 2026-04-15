meta:
  id: bioware_tslpatcher_common
  title: BioWare TSLPatcher Common Enums (reference-derived)
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: "TSLPatcher enums are community tooling metadata, not parsed from swkotor.exe game assets."
    pykotor_ref: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/tslpatcher/
    pykotor_tslpatcher_mod_installer: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/patcher.py#L43-L120
    pykotor_tslpatcher_memory: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/memory.py#L1-L80
    xoreos_aurora_types_filetype_enum: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
doc: |
  Shared enums and small helper types used by TSLPatcher-style tooling.

  Notes:
  - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
    so string-valued enums are modeled here as small string wrapper types with `valid` constraints.

  References:
  - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
  - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
  - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
  - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py

doc-ref:
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60 xoreos — `FileType` enum start (engine archive IDs; TSLPatcher enums here are community patch metadata, not read from `swkotor.exe`)"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/patcher.py#L43-L120 PyKotor — `ModInstaller` (apply / backup entry band)"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/memory.py#L1-L80 PyKotor — `memory` (patch address space / token helpers)"
  - "https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/tslpatcher/ PyKotor — `tslpatcher/` package"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py PyKotor — TwoDA patch helpers"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py PyKotor — NCS patch helpers"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py PyKotor — TSLPatcher logging"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py PyKotor — diff resource objects"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (TSLPatcher metadata; no dedicated PDF)"

types:
  bioware_ncs_token_type_str:
    doc: String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
    seq:
      - id: value
        type: str
        encoding: ASCII
        terminator: 0
        valid:
          any-of:
            - "'strref'"
            - "'strref32'"
            - "'2damemory'"
            - "'2damemory32'"
            - "'uint32'"
            - "'uint16'"
            - "'uint8'"

  bioware_diff_type_str:
    doc: String-valued enum equivalent for DiffType (null-terminated ASCII).
    seq:
      - id: value
        type: str
        encoding: ASCII
        terminator: 0
        valid:
          any-of:
            - "'identical'"
            - "'modified'"
            - "'added'"
            - "'removed'"
            - "'error'"

  bioware_diff_format_str:
    doc: String-valued enum equivalent for DiffFormat (null-terminated ASCII).
    seq:
      - id: value
        type: str
        encoding: ASCII
        terminator: 0
        valid:
          any-of:
            - "'default'"
            - "'unified'"
            - "'context'"
            - "'side_by_side'"

  bioware_diff_resource_type_str:
    doc: String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
    seq:
      - id: value
        type: str
        encoding: ASCII
        terminator: 0
        valid:
          any-of:
            - "'gff'"
            - "'2da'"
            - "'tlk'"
            - "'lip'"
            - "'bytes'"

enums:
  # Extracted from `pykotor.tslpatcher.mods.twoda.TargetType` (IntEnum)
  bioware_tslpatcher_target_type_id:
    0: row_index
    1: row_label
    2: label_column

  # Extracted from `pykotor.tslpatcher.logger.LogType` (IntEnum)
  bioware_tslpatcher_log_type_id:
    0: verbose
    1: note
    2: warning
    3: error


