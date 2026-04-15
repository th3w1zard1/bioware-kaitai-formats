meta:
  id: gff
  title: BioWare GFF (Generic File Format) File
  license: MIT
  endian: le
  file-extension: gff
  imports:
    - ../Common/bioware_common
    - ../Common/bioware_gff_common
  xref:
    # Flat scalar map (ksy schema): line-anchored authorities; nested grouping lives in `meta.doc` prose.
    wiki_gff: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
    wiki_aurora_gff: https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#gff
    wiki_tslpatcher_gfflist: https://github.com/OpenKotOR/PyKotor/wiki/TSLPatcher-GFFList-Syntax
    wiki_strref_tlk: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
    wiki_audio_tlk: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk
    wiki_resource_resolution: https://github.com/OpenKotOR/PyKotor/wiki/Concepts#resource-resolution-order
    pykotor_gff_package: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff
    pykotor_io_gff: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py
    pykotor_io_gff_json: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_json.py
    pykotor_io_gff_xml: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py
    pykotor_gff_data: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py
    xoreos_docs_torlack_itp_html: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    xoreos_gff3file_cpp: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp
    # Header field order matches `GFF3File::Header::read()` (uint32 LE × 12).
    xoreos_gff3_header_read: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63
    xoreos_gff3_load: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L97-L108
    xoreos_gff3_load_header: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181
    xoreos_types_kfiletype_gff: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L101-L103
    xoreos_tools_gff3file_cpp: https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp
    xoreos_dlgfile_load_from_gff: https://github.com/xoreos/xoreos/blob/master/src/aurora/dlgfile.cpp#L169-L202
    xoreos_ifofile_load: https://github.com/xoreos/xoreos/blob/master/src/aurora/ifofile.cpp#L101-L139
    xoreos_nfofile_load: https://github.com/xoreos/xoreos/blob/master/src/aurora/nfofile.cpp#L72-L83
    xoreos_talktable_gff_load: https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_gff.cpp#L78-L99
    reone_gffreader_cpp: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp
    bioware_gff_common_field_types: |
      Canonical `gff_field_type` wire tags + per-ID documentation: `formats/Common/BioWare_GFF_Common.ksy`.
    legacy_k_gff_deadly_stream_listing: https://deadlystream.com/files/file/719-k-gff/
    legacy_k_gff_lucasforums_archive_thread: https://www.lucasforumsarchive.com/thread/149407
doc: |
  GFF (Generic File Format) is BioWare’s hierarchical binary container for structured game data (KotOR/TSL
  and other Aurora-family titles). **Normative community documentation:** OpenKotOR PyKotor wiki
  [GFF File Format](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format) (binary layout, field types,
  struct/field/list access). Related: [Bioware Aurora GFF](https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#gff),
  [TSLPatcher GFFList](https://github.com/OpenKotOR/PyKotor/wiki/TSLPatcher-GFFList-Syntax).

  **PyKotor reference implementation:** [resource/formats/gff/](https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff)
  ([io_gff.py](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py),
  [gff_data.py](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py)).

  **EXE/Ghidra (KotOR1):** On-disk record names and image addresses are **not** repeated here — they are cited
  on the specific `types` / `seq` nodes they justify (e.g. `GFFHeaderInfo` field offsets under `gff_header`,
  `CResGFF::GetField` @ `0x00410990` next to `field_entry`). Per-field-type prose lives in
  `formats/Common/BioWare_GFF_Common.ksy` → `gff_field_type`. This file describes wire bytes; the game builds in-memory `CResGFF` views from them.

  Summary (see wiki [Binary Format](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#binary-format)):
  - 56-byte header → offsets/counts for label, struct, field, field-data, field-indices, and list-indices arenas
  - 12-byte struct rows and 12-byte field rows; field types and inline vs field-data storage per [GFF Data Types](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types)
  - Root struct index 0; single-field vs multi-field indexing: [Field Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap), [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices)

  Bibliography (verify HTTP from your network; `HEAD` checks in CI may omit slow hosts):
  1. OpenKotOR PyKotor wiki — [GFF File Format](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format) (primary on-disk description).
  2. OpenKotOR PyKotor wiki — [Bioware Aurora Core Formats § GFF](https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#gff).
  3. OpenKotOR PyKotor wiki — [TSLPatcher GFF syntax / GFFList](https://github.com/OpenKotOR/PyKotor/wiki/TSLPatcher-GFFList-Syntax).
  4. OpenKotOR PyKotor — binary reader [`io_gff.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py) (`GFFBinaryReader.load` L70–L112: FourCC/version L79–L88; header DWORDs L92–L106; labels L108–L111; struct recursion L116+; field batch L145+; field value dispatch L197–L272; list L275–L294).
  5. OpenKotOR PyKotor — in-memory model [`gff_data.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py) (`GFFFieldType` enum L347–L367; **no `StrRef=18` member** — wire type 18 is still documented on the wiki and in historical tools below).
  6. Torlack / xoreos-docs — [ITP / GFF-family write-up (HTML)](https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html) (MultiMap / field-indices terminology echoed on the PyKotor wiki).
  7. xoreos — [`gff3file.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp) (`GFF3File::Header::read` L50–L63: same twelve `uint32` fields after type/version; comments on V3.3 L42–L43; premium-module repair notes L111+); xoreos-tools — [`gff3file.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp). Official-ish BioWare NWN-era dumps indexed under [xoreos-docs `specs/bioware`](https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware) (see file header comment L25–L27 in xoreos `gff3file.cpp`).
  8. reone — [`gffreader.cpp`](https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp) (header/struct/field/list decode; lines cited on matching `instances` below).
  9. LucasForums Archive — [K-GFF (GFF Editing Utility) thread](https://www.lucasforumsarchive.com/thread/149407) (tk102; VECTOR/ORIENTATION/StrRef field-type context for KotOR-era tooling).
  10. Deadly Stream — [K-GFF 1.3 file listing](https://deadlystream.com/files/file/719-k-gff/) (distribution mirror for the same editor; automated `HEAD` from some networks may time out).
  11. OpenKotOR PyKotor wiki — [StrRef / TLK](https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref) (dialogue string reference semantics adjacent to GFF type 18).
  12. OpenKotOR PyKotor wiki — [Resource resolution order](https://github.com/OpenKotOR/PyKotor/wiki/Concepts#resource-resolution-order) (how GFF assets override from `Override/` / modules / `KEY` data).
  13. LucasForums Archive — [K-GFF thread, post #1 (tk102, 2005-07-08)](https://www.lucasforumsarchive.com/thread/149407): KotOR/TSL **VECTOR** / **ORIENTATION** field support vs BioWare’s original **GFFEditor.exe**; warns **`.git` / `.ifo` corruption`** when those types are mishandled; **StrRef (field type 18)** added for *Jade Empire* modding from **v1.1.9**; **multi-substring `CExoLocString`** editing; **BINARY** fields via import/export for hex workflows; optional **TLK** integration; **v1.0.3** clipboard interchange as **XML** between editor instances.
  14. Deadly Stream — [K-GFF 1.3 listing](https://deadlystream.com/files/file/719-k-gff/) (mirrors LucasForums changelog text; **v1.3.0** adds STRREF / CExoLocString **search-by-text** and TLK-selection UX notes). Automated `HEAD` may **time out** from some networks — retry from a browser or VPN.
  15. OpenKotOR PyKotor — JSON interchange [`io_gff_json.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_json.py) (`GFFJSONReader.load` L51–L75: `GffJson` / `json.loads` → `_parse_struct`).
  16. OpenKotOR PyKotor — XML interchange [`io_gff_xml.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py) (`GFFXMLReader.load` L61–L75; `_load_field` tag dispatch L94–L166; `GFFXMLWriter.write` sets root tag `gff3` L181–L184).
  17. xoreos-tools — [`gffdumper.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp) (`identifyGFF` / `GFFDumper::identify` L119–L175: V3.2/V3.3 vs V4.x routing; `kGFFTypes` table L33–L98 includes KotOR FourCCs such as `GIT ` / `IFO ` / `UTC ` / `DLG `).
  18. **Ghidra / agdec-http:** when an Odyssey MCP server is available, cross-check `GFFHeaderInfo`, `GFFStructData`, `GFFFieldData`, and `GFFFieldTypes` on the loaded `k1_win_gog_swkotor.exe` image — this `.ksy` keeps **VMA** citations off `meta.doc` and on the specific `seq`/`enums` nodes they justify.

seq:
  - id: header
    type: gff_header
    doc: |
      Wire header (56 B). Ghidra: `GFFHeaderInfo` on `/K1/k1_win_gog_swkotor.exe`.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header — full offset/size table.

instances:
  label_array:
    type: label_array
    if: header.label_count > 0
    pos: header.label_offset
    doc: |
      Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
      Ghidra: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
      PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154

  struct_array:
    type: struct_array
    if: header.struct_count > 0
    pos: header.struct_offset
    doc: |
      Struct table: `header.struct_count` × 12 B at `header.struct_offset`. Ghidra: `GFFStructData` rows.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
      PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L64

  field_array:
    type: field_array
    if: header.field_count > 0
    pos: header.field_offset
    doc: |
      Field dictionary: `header.field_count` × 12 B at `header.field_offset`. Ghidra: `GFFFieldData`.
      `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
      PyKotor `_load_field` / `_load_fields_batch`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L148

  field_data:
    type: field_data
    if: header.field_data_count > 0
    pos: header.field_data_offset
    doc: |
      Complex-type payload heap. Ghidra: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
      PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216

  field_indices_array:
    type: field_indices_array
    if: header.field_indices_count > 0
    pos: header.field_indices_offset
    doc: |
      Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
      Ghidra: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
      PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html

  list_indices_array:
    type: list_indices_array
    if: header.list_indices_count > 0
    pos: header.list_indices_offset
    doc: |
      Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
      Ghidra: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
      PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L222

  root_struct_resolved:
    type: resolved_struct(0)
    doc: |
      Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
      Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
      Implements the access pattern described in meta.doc (single-field vs multi-field structs).

types:
  gff_header:
    doc: |
      56-byte header: wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) table.
      Ghidra `/K1/k1_win_gog_swkotor.exe`: datatype `GFFHeaderInfo` — each `seq` field below names the matching column + offset.

      Sources (same DWORD order on disk):
      - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L78-L106 (`file_type`/`file_version` L79–L80; offset/count pairs L92–L106)
      - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L41 (`load` skips 8-byte signature then reads the twelve `u32`s L30–L41)
      - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
      - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html (Aurora/GFF-family background; MultiMap wording)
    seq:
      - id: file_type
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File type signature (FourCC), e.g. `"UTC "`, `"DLG "`, `"ARE "`. Wiki `File Header` row “File Type”, offset 0x00.
          Source: Ghidra `GFFHeaderInfo.file_type` @ +0x0 (char[4]) on `/K1/k1_win_gog_swkotor.exe`.
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L79 (read 4 bytes); validated against `GFFContent` L82–L84.

      - id: file_version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          Format version; KotOR uses `"V3.2"`. Wiki `File Header` row “File Version”, offset 0x04.
          Source: Ghidra `GFFHeaderInfo.file_version` @ +0x4 (char[4]) on `/K1/k1_win_gog_swkotor.exe`.
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L80 (must equal `"V3.2"` L86–L88).

      - id: struct_offset
        type: u4
        doc: |
          Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
          Source: Ghidra `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30

      - id: struct_count
        type: u4
        doc: |
          Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
          Source: Ghidra `GFFHeaderInfo.struct_count` @ +0xC (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31

      - id: field_offset
        type: u4
        doc: |
          Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
          Source: Ghidra `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32

      - id: field_count
        type: u4
        doc: |
          Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
          Source: Ghidra `GFFHeaderInfo.field_count` @ +0x14 (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33

      - id: label_offset
        type: u4
        doc: |
          Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
          Source: Ghidra `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 (variable `label_offset` then seek L110) — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34

      - id: label_count
        type: u4
        doc: |
          Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
          Source: Ghidra `GFFHeaderInfo.label_count` @ +0x1C (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35

      - id: field_data_offset
        type: u4
        doc: |
          Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
          Source: Ghidra `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36

      - id: field_data_count
        type: u4
        doc: |
          Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
          Source: Ghidra `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37

      - id: field_indices_offset
        type: u4
        doc: |
          Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
          Source: Ghidra `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38

      - id: field_indices_count
        type: u4
        doc: |
          Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
          Source: Ghidra `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)

      - id: list_indices_offset
        type: u4
        doc: |
          Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
          Source: Ghidra `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40

      - id: list_indices_count
        type: u4
        doc: |
          List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
          Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
          Source: Ghidra `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
          PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L222

  label_array:
    doc: |
      Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
      Indexed by `GFFFieldData.label_index` (×16). Not a separate Ghidra struct — rows are `char[16]` in bulk.
      Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
    seq:
      - id: labels
        type: label_entry
        repeat: expr
        repeat-expr: _root.header.label_count
        doc: |
          Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
          Index `i` is at file offset `label_offset + i*16`.

  label_entry:
    doc: |
      One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
        doc: |
          Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
          Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
          Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array

  struct_array:
    doc: |
      Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Ghidra name `GFFStructData`.
      Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L121-L127 (three `u32` per row) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
    seq:
      - id: entries
        type: struct_entry
        repeat: expr
        repeat-expr: _root.header.struct_count
        doc: |
          Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
          Stride 12 bytes per struct (matches Ghidra component sizes).

  struct_entry:
    doc: |
      One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
    seq:
      - id: struct_id
        type: u4
        doc: |
          Structure type identifier.
          Source: Ghidra `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
          0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.

      - id: data_or_offset
        type: u4
        doc: |
          Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
          If field_count == 0, this value is unused.
          Source: Ghidra `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).

      - id: field_count
        type: u4
        doc: |
          Number of fields in this struct:
          - 0: No fields
          - 1: Single field, data_or_offset contains the field index directly
          - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
          Source: Ghidra `GFFStructData.field_count` @ +0x8 (ulong).
    instances:
      has_single_field:
        value: field_count == 1
        doc: |
          Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
          Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
      has_multiple_fields:
        value: field_count > 1
        doc: |
          Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
      single_field_index:
        value: data_or_offset
        if: has_single_field
        doc: |
          Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
      field_indices_offset:
        value: data_or_offset
        if: has_multiple_fields
        doc: |
          Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.

  field_array:
    doc: |
      Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
      Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L187-L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
    seq:
      - id: entries
        type: field_entry
        repeat: expr
        repeat-expr: _root.header.field_count
        doc: |
          Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
          Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).

  field_entry:
    doc: |
      One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
      `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
      Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
    seq:
      - id: field_type
        type: u4
        enum: bioware_gff_common::gff_field_type
        doc: |
          Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
          (ID → storage: inline vs `field_data` vs struct/list indirection).
          Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
          Source: Ghidra `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
          Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
          PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273

      - id: label_index
        type: u4
        doc: |
          Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
          Source: Ghidra `GFFFieldData.label_index` @ +0x4 (ulong).

      - id: data_or_offset
        type: u4
        doc: |
          Inline data (simple types) or offset/index (complex types):
          - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
          - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
          - Struct (14): Struct index (index into struct_array)
          - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
          Source: Ghidra `GFFFieldData.data_or_data_offset` @ +0x8.
          `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
    instances:
      is_simple_type:
        value: |
          field_type == bioware_gff_common::gff_field_type::uint8 or
          field_type == bioware_gff_common::gff_field_type::int8 or
          field_type == bioware_gff_common::gff_field_type::uint16 or
          field_type == bioware_gff_common::gff_field_type::int16 or
          field_type == bioware_gff_common::gff_field_type::uint32 or
          field_type == bioware_gff_common::gff_field_type::int32 or
          field_type == bioware_gff_common::gff_field_type::single or
          field_type == bioware_gff_common::gff_field_type::str_ref
        doc: |
          Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
          Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
          **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
      is_complex_type:
        value: |
          field_type == bioware_gff_common::gff_field_type::uint64 or
          field_type == bioware_gff_common::gff_field_type::int64 or
          field_type == bioware_gff_common::gff_field_type::double or
          field_type == bioware_gff_common::gff_field_type::string or
          field_type == bioware_gff_common::gff_field_type::resref or
          field_type == bioware_gff_common::gff_field_type::localized_string or
          field_type == bioware_gff_common::gff_field_type::binary or
          field_type == bioware_gff_common::gff_field_type::vector4 or
          field_type == bioware_gff_common::gff_field_type::vector3
        doc: |
          Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
      is_struct_type:
        value: field_type == bioware_gff_common::gff_field_type::struct
        doc: |
          Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
      is_list_type:
        value: field_type == bioware_gff_common::gff_field_type::list
        doc: |
          Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
      field_data_offset_value:
        value: _root.header.field_data_offset + data_or_offset
        if: is_complex_type
        doc: |
          Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
      struct_index_value:
        value: data_or_offset
        if: is_struct_type
        doc: |
          Struct index (same numeric interpretation as `GFFStructData` row index).
      list_indices_offset_value:
        value: _root.header.list_indices_offset + data_or_offset
        if: is_list_type
        doc: |
          Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.

  field_data:
    doc: |
      Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
    seq:
      - id: raw_data
        size: _root.header.field_data_count
        doc: |
          Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
          Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
          Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data

  field_indices_array:
    doc: |
      Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
      “MultiMap” naming: wiki + Torlack ITP HTML (linked in `meta.doc` bibliography).
    seq:
      - id: indices
        type: u4
        repeat: expr
        repeat-expr: _root.header.field_indices_count
        doc: |
          `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
          `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
          Ghidra: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.

  list_indices_array:
    doc: |
      Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
    seq:
      - id: raw_data
        size: _root.header.list_indices_count
        doc: |
          Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
          Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
          This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.

  list_entry:
    doc: |
      One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
      Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L222
    seq:
      - id: num_struct_indices
        type: u4
        doc: |
          Little-endian count of following struct indices (list cardinality).
          Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
      - id: struct_indices
        type: u4
        repeat: expr
        repeat-expr: num_struct_indices
        doc: |
          Each value indexes `struct_array.entries[index]` (`GFFStructData` row).

  # Complex payloads: formats/Common/BioWare_Common.ksy (bioware_cexo_string, bioware_resref,
  # bioware_locstring, bioware_vector3/4, bioware_binary_data). Cross-audit those .ksy files against
  # the same /K1/k1_win_gog_swkotor.exe when verifying full engine parity.

  # ----------------------------
  # Higher-level resolved views
  # ----------------------------

  label_entry_terminated:
    doc: |
      Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
      Not a separate Ghidra datatype. Wire cite: `label_entry.name`.
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
        terminator: 0
        include: false
        doc: |
          Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.

  resolved_struct:
    doc: |
      Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
      On-disk row remains at `struct_offset + struct_index * 12`.
    params:
      - id: struct_index
        type: u4
        doc: |
          Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.
    instances:
      entry:
        type: struct_entry
        pos: _root.header.struct_offset + struct_index * 12
        doc: |
          Raw `GFFStructData` (Ghidra 12-byte layout).

      field_indices:
        type: u4
        repeat: expr
        repeat-expr: entry.field_count
        if: entry.field_count > 1
        pos: _root.header.field_indices_offset + entry.data_or_offset
        doc: |
          Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
          Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).

      fields:
        type: resolved_field(field_indices[_index])
        repeat: expr
        repeat-expr: entry.field_count
        if: entry.field_count > 1
        doc: |
          One `resolved_field` per entry in `field_indices`.

      single_field:
        type: resolved_field(entry.data_or_offset)
        if: entry.field_count == 1
        doc: |
          `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).

  resolved_field:
    doc: |
      Kaitai composition: one `GFFFieldData` row + label + payload.
      Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
      Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
      For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
    params:
      - id: field_index
        type: u4
        doc: |
          Index into `field_array.entries`; require `field_index < field_count`.
    instances:
      entry:
        type: field_entry
        pos: _root.header.field_offset + field_index * 12
        doc: |
          Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).

      label:
        type: label_entry_terminated
        pos: _root.header.label_offset + entry.label_index * 16
        doc: |
          Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.

      field_entry_pos:
        value: _root.header.field_offset + field_index * 12
        doc: |
          Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).

      # Inline/simple types — payload in the DWORD at file offset field_entry_pos+8
      value_uint8:
        type: u1
        if: entry.field_type == bioware_gff_common::gff_field_type::uint8
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
      value_int8:
        type: s1
        if: entry.field_type == bioware_gff_common::gff_field_type::int8
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 1 (INT8 in low byte of slot).
      value_uint16:
        type: u2
        if: entry.field_type == bioware_gff_common::gff_field_type::uint16
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 2 (UINT16 LE at +8).
      value_int16:
        type: s2
        if: entry.field_type == bioware_gff_common::gff_field_type::int16
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 3 (INT16 LE at +8).
      value_uint32:
        type: u4
        if: entry.field_type == bioware_gff_common::gff_field_type::uint32
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 4 (full inline DWORD).
      value_int32:
        type: s4
        if: entry.field_type == bioware_gff_common::gff_field_type::int32
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
      value_single:
        type: f4
        if: entry.field_type == bioware_gff_common::gff_field_type::single
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 8 (32-bit float).
      value_str_ref:
        type: u4
        if: entry.field_type == bioware_gff_common::gff_field_type::str_ref
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
          `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
          **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
          Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
          PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273

      # Complex — payload in field_data blob
      value_uint64:
        type: u8
        if: entry.field_type == bioware_gff_common::gff_field_type::uint64
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
      value_int64:
        type: s8
        if: entry.field_type == bioware_gff_common::gff_field_type::int64
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 7 (INT64).
      value_double:
        type: f8
        if: entry.field_type == bioware_gff_common::gff_field_type::double
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 9 (double).
      value_string:
        type: bioware_common::bioware_cexo_string
        if: entry.field_type == bioware_gff_common::gff_field_type::string
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
      value_resref:
        type: bioware_common::bioware_resref
        if: entry.field_type == bioware_gff_common::gff_field_type::resref
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
      value_localized_string:
        type: bioware_common::bioware_locstring
        if: entry.field_type == bioware_gff_common::gff_field_type::localized_string
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
      value_binary:
        type: bioware_common::bioware_binary_data
        if: entry.field_type == bioware_gff_common::gff_field_type::binary
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
      value_vector4:
        type: bioware_common::bioware_vector4
        if: entry.field_type == bioware_gff_common::gff_field_type::vector4
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
      value_vector3:
        type: bioware_common::bioware_vector3
        if: entry.field_type == bioware_gff_common::gff_field_type::vector3
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 17 — three floats (`bioware_vector3`).

      # Struct / list — index or offset in data_or_offset (+8)
      value_struct:
        type: resolved_struct(entry.data_or_offset)
        if: entry.field_type == bioware_gff_common::gff_field_type::struct
        doc: |
          `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.

      list_entry:
        type: list_entry
        if: entry.field_type == bioware_gff_common::gff_field_type::list
        pos: _root.header.list_indices_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.

      list_structs:
        type: resolved_struct(list_entry.struct_indices[_index])
        repeat: expr
        repeat-expr: list_entry.num_struct_indices
        if: entry.field_type == bioware_gff_common::gff_field_type::list
        doc: |
          Child structs for this list; indices from `list_entry.struct_indices`.
