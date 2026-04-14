meta:
  id: bioware_tslpatcher_common
  title: BioWare TSLPatcher Common Enums (reference-derived)
  license: MIT
  endian: le
  xref:
    ghidra_odyssey_k1:
      note: "TSLPatcher enums are community tooling metadata, not parsed from swkotor.exe game assets."
    pykotor_ref: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/tslpatcher/
doc: |
  Shared enums and small helper types used by TSLPatcher-style tooling.

  Notes:
  - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
    so string-valued enums are modeled here as small string wrapper types with `valid` constraints.

  References:
  - https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
  - https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
  - https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
  - https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py

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


