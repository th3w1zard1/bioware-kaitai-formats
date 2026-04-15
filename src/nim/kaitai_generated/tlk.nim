import kaitai_struct_nim_runtime
import options

type
  Tlk* = ref object of KaitaiStruct
    `header`*: Tlk_TlkHeader
    `stringDataTable`*: Tlk_StringDataTable
    `parent`*: KaitaiStruct
  Tlk_StringDataEntry* = ref object of KaitaiStruct
    `flags`*: uint32
    `soundResref`*: string
    `volumeVariance`*: uint32
    `pitchVariance`*: uint32
    `textOffset`*: uint32
    `textLength`*: uint32
    `soundLength`*: float32
    `parent`*: Tlk_StringDataTable
    `entrySizeInst`: int8
    `entrySizeInstFlag`: bool
    `soundLengthPresentInst`: bool
    `soundLengthPresentInstFlag`: bool
    `soundPresentInst`: bool
    `soundPresentInstFlag`: bool
    `textDataInst`: string
    `textDataInstFlag`: bool
    `textFileOffsetInst`: int
    `textFileOffsetInstFlag`: bool
    `textPresentInst`: bool
    `textPresentInstFlag`: bool
  Tlk_StringDataTable* = ref object of KaitaiStruct
    `entries`*: seq[Tlk_StringDataEntry]
    `parent`*: Tlk
  Tlk_TlkHeader* = ref object of KaitaiStruct
    `fileType`*: string
    `fileVersion`*: string
    `languageId`*: uint32
    `stringCount`*: uint32
    `entriesOffset`*: uint32
    `parent`*: Tlk
    `expectedEntriesOffsetInst`: int
    `expectedEntriesOffsetInstFlag`: bool
    `headerSizeInst`: int8
    `headerSizeInstFlag`: bool

proc read*(_: typedesc[Tlk], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Tlk
proc read*(_: typedesc[Tlk_StringDataEntry], io: KaitaiStream, root: KaitaiStruct, parent: Tlk_StringDataTable): Tlk_StringDataEntry
proc read*(_: typedesc[Tlk_StringDataTable], io: KaitaiStream, root: KaitaiStruct, parent: Tlk): Tlk_StringDataTable
proc read*(_: typedesc[Tlk_TlkHeader], io: KaitaiStream, root: KaitaiStruct, parent: Tlk): Tlk_TlkHeader

proc entrySize*(this: Tlk_StringDataEntry): int8
proc soundLengthPresent*(this: Tlk_StringDataEntry): bool
proc soundPresent*(this: Tlk_StringDataEntry): bool
proc textData*(this: Tlk_StringDataEntry): string
proc textFileOffset*(this: Tlk_StringDataEntry): int
proc textPresent*(this: Tlk_StringDataEntry): bool
proc expectedEntriesOffset*(this: Tlk_TlkHeader): int
proc headerSize*(this: Tlk_TlkHeader): int8


##[
TLK (Talk Table) files contain all text strings used in the game, both written and spoken.
They enable easy localization by providing a lookup table from string reference numbers (StrRef)
to localized text and associated voice-over audio files.

Binary Format Structure:
- File Header (20 bytes): File type signature, version, language ID, string count, entries offset
- String Data Table (40 bytes per entry): Metadata for each string entry (flags, sound ResRef, offsets, lengths)
- String Entries (variable size): Sequential null-terminated text strings starting at entries_offset

The format uses a two-level structure:
1. String Data Table: Contains metadata (flags, sound filename, text offset/length) for each entry
2. String Entries: Actual text data stored sequentially, referenced by offsets in the data table

String references (StrRef) are 0-based indices into the string_data_table array. StrRef 0 refers to
the first entry, StrRef 1 to the second, etc. StrRef -1 indicates no string reference.

References:
- https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk
- https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/tlkreader.cpp:31-84
- https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp:42-176
- https://github.com/TSLPatcher/TSLPatcher/blob/master/lib/site/Bioware/TLK.pm:1-533
- https://github.com/KotOR-Community-Patches/Kotor.NET/blob/master/Kotor.NET/Formats/KotorTLK/TLKBinaryStructure.cs:11-132

]##
proc read*(_: typedesc[Tlk], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Tlk =
  template this: untyped = result
  this = new(Tlk)
  let root = if root == nil: cast[Tlk](this) else: cast[Tlk](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  TLK file header (20 bytes) - contains file signature, version, language, and counts
  ]##
  let headerExpr = Tlk_TlkHeader.read(this.io, this.root, this)
  this.header = headerExpr

  ##[
  Array of string data entries (metadata for each string) - 40 bytes per entry
  ]##
  let stringDataTableExpr = Tlk_StringDataTable.read(this.io, this.root, this)
  this.stringDataTable = stringDataTableExpr

proc fromFile*(_: typedesc[Tlk], filename: string): Tlk =
  Tlk.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Tlk_StringDataEntry], io: KaitaiStream, root: KaitaiStruct, parent: Tlk_StringDataTable): Tlk_StringDataEntry =
  template this: untyped = result
  this = new(Tlk_StringDataEntry)
  let root = if root == nil: cast[Tlk](this) else: cast[Tlk](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Bit flags indicating what data is present:
- bit 0 (0x0001): Text present - string has text content
- bit 1 (0x0002): Sound present - string has associated voice-over audio
- bit 2 (0x0004): Sound length present - sound length field is valid

Common flag combinations:
- 0x0001: Text only (menu options, item descriptions)
- 0x0003: Text + Sound (voiced dialog lines)
- 0x0007: Text + Sound + Length (fully voiced with duration)
- 0x0000: Empty entry (unused StrRef slots)

  ]##
  let flagsExpr = this.io.readU4le()
  this.flags = flagsExpr

  ##[
  Voice-over audio filename (ResRef), null-terminated ASCII, max 16 chars.
If the string is shorter than 16 bytes, it is null-padded.
Empty string (all nulls) indicates no voice-over audio.

  ]##
  let soundResrefExpr = encode(this.io.readBytes(int(16)), "ASCII")
  this.soundResref = soundResrefExpr

  ##[
  Volume variance (unused in KotOR, always 0).
Legacy field from Neverwinter Nights, not used by KotOR engine.

  ]##
  let volumeVarianceExpr = this.io.readU4le()
  this.volumeVariance = volumeVarianceExpr

  ##[
  Pitch variance (unused in KotOR, always 0).
Legacy field from Neverwinter Nights, not used by KotOR engine.

  ]##
  let pitchVarianceExpr = this.io.readU4le()
  this.pitchVariance = pitchVarianceExpr

  ##[
  Offset to string text relative to entries_offset.
The actual file offset is: header.entries_offset + text_offset.
First string starts at offset 0, subsequent strings follow sequentially.

  ]##
  let textOffsetExpr = this.io.readU4le()
  this.textOffset = textOffsetExpr

  ##[
  Length of string text in bytes (not characters).
For single-byte encodings (Windows-1252, etc.), byte length equals character count.
For multi-byte encodings (UTF-8, etc.), byte length may be greater than character count.

  ]##
  let textLengthExpr = this.io.readU4le()
  this.textLength = textLengthExpr

  ##[
  Duration of voice-over audio in seconds (float).
Only valid if sound_length_present flag (bit 2) is set.
Used by the engine to determine how long to wait before auto-advancing dialog.

  ]##
  let soundLengthExpr = this.io.readF4le()
  this.soundLength = soundLengthExpr

proc entrySize(this: Tlk_StringDataEntry): int8 = 

  ##[
  Size of each string_data_entry in bytes.
Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.

  ]##
  if this.entrySizeInstFlag:
    return this.entrySizeInst
  let entrySizeInstExpr = int8(40)
  this.entrySizeInst = entrySizeInstExpr
  this.entrySizeInstFlag = true
  return this.entrySizeInst

proc soundLengthPresent(this: Tlk_StringDataEntry): bool = 

  ##[
  Whether sound length is valid (bit 2 of flags)
  ]##
  if this.soundLengthPresentInstFlag:
    return this.soundLengthPresentInst
  let soundLengthPresentInstExpr = bool((this.flags and 4) != 0)
  this.soundLengthPresentInst = soundLengthPresentInstExpr
  this.soundLengthPresentInstFlag = true
  return this.soundLengthPresentInst

proc soundPresent(this: Tlk_StringDataEntry): bool = 

  ##[
  Whether voice-over audio exists (bit 1 of flags)
  ]##
  if this.soundPresentInstFlag:
    return this.soundPresentInst
  let soundPresentInstExpr = bool((this.flags and 2) != 0)
  this.soundPresentInst = soundPresentInstExpr
  this.soundPresentInstFlag = true
  return this.soundPresentInst

proc textData(this: Tlk_StringDataEntry): string = 

  ##[
  Text string data as raw bytes (read as ASCII for byte-level access).
The actual encoding depends on the language_id in the header.
Common encodings:
- English/French/German/Italian/Spanish: Windows-1252 (cp1252)
- Polish: Windows-1250 (cp1250)
- Korean: EUC-KR (cp949)
- Chinese Traditional: Big5 (cp950)
- Chinese Simplified: GB2312 (cp936)
- Japanese: Shift-JIS (cp932)

Note: This field reads the raw bytes as ASCII string for byte-level access.
The application layer should decode based on the language_id field in the header.
To get raw bytes, access the underlying byte representation of this string.

In practice, strings are stored sequentially starting at entries_offset,
so text_offset values are relative to entries_offset (0, len1, len1+len2, etc.).

Strings may be null-terminated, but text_length includes the null terminator.
Application code should trim null bytes when decoding.

If text_present flag (bit 0) is not set, this field may contain garbage data
or be empty. Always check text_present before using this data.

  ]##
  if this.textDataInstFlag:
    return this.textDataInst
  let pos = this.io.pos()
  this.io.seek(int(this.textFileOffset))
  let textDataInstExpr = encode(this.io.readBytes(int(this.textLength)), "ASCII")
  this.textDataInst = textDataInstExpr
  this.io.seek(pos)
  this.textDataInstFlag = true
  return this.textDataInst

proc textFileOffset(this: Tlk_StringDataEntry): int = 

  ##[
  Absolute file offset to the text string.
Calculated as entries_offset (from header) + text_offset (from entry).

  ]##
  if this.textFileOffsetInstFlag:
    return this.textFileOffsetInst
  let textFileOffsetInstExpr = int(Tlk(this.root).header.entriesOffset + this.textOffset)
  this.textFileOffsetInst = textFileOffsetInstExpr
  this.textFileOffsetInstFlag = true
  return this.textFileOffsetInst

proc textPresent(this: Tlk_StringDataEntry): bool = 

  ##[
  Whether text content exists (bit 0 of flags)
  ]##
  if this.textPresentInstFlag:
    return this.textPresentInst
  let textPresentInstExpr = bool((this.flags and 1) != 0)
  this.textPresentInst = textPresentInstExpr
  this.textPresentInstFlag = true
  return this.textPresentInst

proc fromFile*(_: typedesc[Tlk_StringDataEntry], filename: string): Tlk_StringDataEntry =
  Tlk_StringDataEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Tlk_StringDataTable], io: KaitaiStream, root: KaitaiStruct, parent: Tlk): Tlk_StringDataTable =
  template this: untyped = result
  this = new(Tlk_StringDataTable)
  let root = if root == nil: cast[Tlk](this) else: cast[Tlk](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of string data entries, one per string in the file
  ]##
  for i in 0 ..< int(Tlk(this.root).header.stringCount):
    let it = Tlk_StringDataEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Tlk_StringDataTable], filename: string): Tlk_StringDataTable =
  Tlk_StringDataTable.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Tlk_TlkHeader], io: KaitaiStream, root: KaitaiStruct, parent: Tlk): Tlk_TlkHeader =
  template this: untyped = result
  this = new(Tlk_TlkHeader)
  let root = if root == nil: cast[Tlk](this) else: cast[Tlk](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "TLK " (space-padded).
Validates that this is a TLK file.
Note: Validation removed temporarily due to Kaitai Struct parser issues.

  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. "V3.0" for KotOR, "V4.0" for Jade Empire.
KotOR games use V3.0. Jade Empire uses V4.0.
Note: Validation removed due to Kaitai Struct parser limitations with period in string.

  ]##
  let fileVersionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileVersion = fileVersionExpr

  ##[
  Language identifier:
- 0 = English
- 1 = French
- 2 = German
- 3 = Italian
- 4 = Spanish
- 5 = Polish
- 128 = Korean
- 129 = Chinese Traditional
- 130 = Chinese Simplified
- 131 = Japanese
See Language enum for complete list.

  ]##
  let languageIdExpr = this.io.readU4le()
  this.languageId = languageIdExpr

  ##[
  Number of string entries in the file.
Determines the number of entries in string_data_table.

  ]##
  let stringCountExpr = this.io.readU4le()
  this.stringCount = stringCountExpr

  ##[
  Byte offset to string entries array from the beginning of the file.
Typically 20 + (string_count * 40) = header size + string data table size.
Points to where the actual text strings begin.

  ]##
  let entriesOffsetExpr = this.io.readU4le()
  this.entriesOffset = entriesOffsetExpr

proc expectedEntriesOffset(this: Tlk_TlkHeader): int = 

  ##[
  Expected offset to string entries (header + string data table).
Used for validation.

  ]##
  if this.expectedEntriesOffsetInstFlag:
    return this.expectedEntriesOffsetInst
  let expectedEntriesOffsetInstExpr = int(20 + this.stringCount * 40)
  this.expectedEntriesOffsetInst = expectedEntriesOffsetInstExpr
  this.expectedEntriesOffsetInstFlag = true
  return this.expectedEntriesOffsetInst

proc headerSize(this: Tlk_TlkHeader): int8 = 

  ##[
  Size of the TLK header in bytes
  ]##
  if this.headerSizeInstFlag:
    return this.headerSizeInst
  let headerSizeInstExpr = int8(20)
  this.headerSizeInst = headerSizeInstExpr
  this.headerSizeInstFlag = true
  return this.headerSizeInst

proc fromFile*(_: typedesc[Tlk_TlkHeader], filename: string): Tlk_TlkHeader =
  Tlk_TlkHeader.read(newKaitaiFileStream(filename), nil, nil)

