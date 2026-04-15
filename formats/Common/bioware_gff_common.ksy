meta:
  id: bioware_gff_common
  title: BioWare GFF (Generic File Format) shared enumerations
  license: MIT
  endian: le
  xref:
    pykotor_wiki_gff_data_types: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
    pykotor_gff_data_enum: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367
    pykotor_io_gff_field_dispatch: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L197-L273
    xoreos_gff3file_read_header: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63
    reone_gffreader: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225
doc: |
  Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).

  Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
  (Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).

enums:
  gff_field_type:
    0:
      id: uint8
      doc: |
        Numeric 0 — UINT8; value in `GFFFieldData.data_or_data_offset` (+8). Ghidra `/K1/k1_win_gog_swkotor.exe`:
        `GFFFieldTypes` on `GFFFieldData.field_type` @ +0. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
        PyKotor `GFFBinaryReader._load_field_value_by_id`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L244-L246
    1:
      id: int8
      doc: |
        Numeric 1 — INT8 in low byte of the 4-byte inline slot (+8).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L247-L251
    2:
      id: uint16
      doc: |
        Numeric 2 — UINT16 LE at +8.
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L252-L254
    3:
      id: int16
      doc: |
        Numeric 3 — INT16 LE at +8.
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L255-L259
    4:
      id: uint32
      doc: |
        Numeric 4 — UINT32; full inline DWORD at +8.
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L260-L262
    5:
      id: int32
      doc: |
        Numeric 5 — INT32 inline. Engine: `CResGFF::ReadFieldINT` @ `0x00411c90` (uses `GetField` @ `0x00410990`).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L263-L267
    6:
      id: uint64
      doc: |
        Numeric 6 — UINT64 payload in `field_data` at `field_data_offset` + relative offset from +8.
        PyKotor (complex-field branch): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L215
    7:
      id: int64
      doc: |
        Numeric 7 — INT64 in `field_data`.
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L216-L217
    8:
      id: single
      doc: |
        Numeric 8 — 32-bit IEEE float inline at +8.
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L272
    9:
      id: double
      doc: |
        Numeric 9 — 64-bit IEEE float in `field_data`.
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L218-L219
    10:
      id: string
      doc: |
        Numeric 10 — CExoString in `field_data` (`bioware_cexo_string` in this repo).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L222
    11:
      id: resref
      doc: |
        Numeric 11 — ResRef in `field_data` (`bioware_resref`).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L223-L226
    12:
      id: localized_string
      doc: |
        Numeric 12 — CExoLocString in `field_data` (`bioware_locstring`).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L227-L229
    13:
      id: binary
      doc: |
        Numeric 13 — length-prefixed octets in `field_data` (`bioware_binary_data`).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L230-L232
    14:
      id: struct
      doc: |
        Numeric 14 — nested struct; +8 word is index into `GFFStructData` table (`struct_offset` + index×12).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L237-L241
    15:
      id: list
      doc: |
        Numeric 15 — list; +8 word is byte offset into list-indices arena (`list_indices_offset` + offset).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L242-L243
    16:
      id: vector4
      doc: |
        Numeric 16 — four floats in `field_data` (`bioware_vector4`).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L235-L236
    17:
      id: vector3
      doc: |
        Numeric 17 — three floats in `field_data` (`bioware_vector3`).
        PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L233-L234
    18:
      id: str_ref
      doc: |
        Numeric 18 — TLK StrRef (**KotOR / this schema:** inline `u32` at `GFFFieldData.data_or_data_offset`, i.e. file offset `field_offset + row*12 + 8`).
        KotOR extension; same width as type 5, distinct field kind in data.
        Ghidra: `GFFFieldTypes` on `/K1/k1_win_gog_swkotor.exe`.
        Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types — row “StrRef”; StrRef semantics: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
        PyKotor `GFFFieldType` stops at `Vector3 = 17` (no enum member for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367; `GFFBinaryReader` documents missing branch: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
        reone `Gff::FieldType::StrRef` + `readStrRefFieldData` (**`field_data` blob**, not inline +8): https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204
        Community threads / mirrors (tool changelogs, VECTOR/ORIENTATION/StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
