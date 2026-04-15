meta:
  id: da2s
  title: BioWare DA2S (Dragon Age 2 Save) File Format
  license: MIT
  endian: le
  file-extension: da2s
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: "Dragon Age 2 save format (DragonAge2.exe in Odyssey), not KotOR k1_win_gog_swkotor.exe."
    github_oldrepublicdevs_andastra_da2_save_serializer: |
      https://github.com/OldRepublicDevs/Andastra — `src/Andastra/Game/Games/Eclipse/DragonAge2/Save/DragonAge2SaveSerializer.cs`:
      **`SaveSignature = "DA2S"`** **24**; **`SerializeSaveNfo`** **30–67**; **`DeserializeSaveNfo`** **72–115**; **`SerializeSaveArchive`** **120+**; **`DeserializeSaveArchive`** **169+**.
    github_oldrepublicdevs_andastra_eclipse_save_base: |
      https://github.com/OldRepublicDevs/Andastra — `src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs`:
      shared UTF-8 length-prefixed strings + common metadata helpers **35–126** (same base as **DAS**).
    github_xoreos_types_game_id_dragon_age2: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
doc: |
  **DA2S** (Dragon Age 2 save): Eclipse binary save — `DA2S` signature, `version==1`, length-prefixed strings + tagged
  blocks (party/inventory/journal/etc.). **Not KotOR** — Andastra serializers under `Game/Games/Eclipse/DragonAge2/Save/` (`meta.xref`).

doc-ref:
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408 xoreos — `GameID` (`kGameIDDragonAge2` = 8)"
  - "https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAge2/Save/DragonAge2SaveSerializer.cs#L24-L180 Andastra — `DragonAge2SaveSerializer`"
  - "https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126 Andastra — `EclipseSaveSerializer` helpers"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (Dragon Age saves documented via Andastra + `GameID`; no DA2S-specific PDF here)"

seq:
  - id: signature
    type: str
    encoding: ASCII
    size: 4
    doc: |
      File signature. Must be "DA2S" for Dragon Age 2 save files.
    valid:
      eq: '"DA2S"'
  
  - id: version
    type: s4
    doc: |
      Save format version. Must be 1 for Dragon Age 2.
    valid: 1
  
  - id: save_name
    type: length_prefixed_string
    doc: User-entered save name displayed in UI
  
  - id: module_name
    type: length_prefixed_string
    doc: Current module resource name
  
  - id: area_name
    type: length_prefixed_string
    doc: Current area name for display
  
  - id: time_played_seconds
    type: s4
    doc: Total play time in seconds
  
  - id: timestamp_filetime
    type: s8
    doc: |
      Save creation timestamp as Windows FILETIME (int64).
      Convert using DateTime.FromFileTime().
  
  - id: num_screenshot_data
    type: s4
    doc: Length of screenshot data in bytes (0 if no screenshot)
  
  - id: screenshot_data
    type: u1
    repeat: expr
    repeat-expr: num_screenshot_data
    if: num_screenshot_data > 0
    doc: Screenshot image data (typically TGA or DDS format)
  
  - id: num_portrait_data
    type: s4
    doc: Length of portrait data in bytes (0 if no portrait)
  
  - id: portrait_data
    type: u1
    repeat: expr
    repeat-expr: num_portrait_data
    if: num_portrait_data > 0
    doc: Portrait image data (typically TGA or DDS format)
  
  - id: player_name
    type: length_prefixed_string
    doc: Player character name
  
  - id: party_member_count
    type: s4
    doc: Number of party members (from PartyState)
  
  - id: player_level
    type: s4
    doc: Player character level (from PartyState.PlayerCharacter)

types:
  length_prefixed_string:
    seq:
      - id: length
        type: s4
        doc: |
          String length in bytes (UTF-8 encoding).
          Must be >= 0 and <= 65536 (sanity check).
      
      - id: value
        type: str
        encoding: UTF-8
        size: length
        terminator: 0
        include: false
        doc: String value (UTF-8 encoded)
    instances:
      value_trimmed:
        value: value
        doc: |
          String value.
          Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.

