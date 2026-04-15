import kaitai_struct_nim_runtime
import options
import bioware_common
import bioware_gff_common

type
  Gff* = ref object of KaitaiStruct
    `file`*: Gff_GffUnionFile
    `parent`*: KaitaiStruct
  Gff_FieldArray* = ref object of KaitaiStruct
    `entries`*: seq[Gff_FieldEntry]
    `parent`*: Gff_Gff3AfterAurora
  Gff_FieldData* = ref object of KaitaiStruct
    `rawData`*: seq[byte]
    `parent`*: Gff_Gff3AfterAurora
  Gff_FieldEntry* = ref object of KaitaiStruct
    `fieldType`*: BiowareGffCommon_GffFieldType
    `labelIndex`*: uint32
    `dataOrOffset`*: uint32
    `parent`*: KaitaiStruct
    `fieldDataOffsetValueInst`: int
    `fieldDataOffsetValueInstFlag`: bool
    `isComplexTypeInst`: bool
    `isComplexTypeInstFlag`: bool
    `isListTypeInst`: bool
    `isListTypeInstFlag`: bool
    `isSimpleTypeInst`: bool
    `isSimpleTypeInstFlag`: bool
    `isStructTypeInst`: bool
    `isStructTypeInstFlag`: bool
    `listIndicesOffsetValueInst`: int
    `listIndicesOffsetValueInstFlag`: bool
    `structIndexValueInst`: uint32
    `structIndexValueInstFlag`: bool
  Gff_FieldIndicesArray* = ref object of KaitaiStruct
    `indices`*: seq[uint32]
    `parent`*: Gff_Gff3AfterAurora
  Gff_Gff3AfterAurora* = ref object of KaitaiStruct
    `header`*: Gff_GffHeaderTail
    `parent`*: Gff_GffUnionFile
    `fieldArrayInst`: Gff_FieldArray
    `fieldArrayInstFlag`: bool
    `fieldDataInst`: Gff_FieldData
    `fieldDataInstFlag`: bool
    `fieldIndicesArrayInst`: Gff_FieldIndicesArray
    `fieldIndicesArrayInstFlag`: bool
    `labelArrayInst`: Gff_LabelArray
    `labelArrayInstFlag`: bool
    `listIndicesArrayInst`: Gff_ListIndicesArray
    `listIndicesArrayInstFlag`: bool
    `rootStructResolvedInst`: Gff_ResolvedStruct
    `rootStructResolvedInstFlag`: bool
    `structArrayInst`: Gff_StructArray
    `structArrayInstFlag`: bool
  Gff_Gff4AfterAurora* = ref object of KaitaiStruct
    `platformId`*: uint32
    `fileType`*: uint32
    `typeVersion`*: uint32
    `numStructTemplates`*: uint32
    `stringCount`*: uint32
    `stringOffset`*: uint32
    `dataOffset`*: uint32
    `structTemplates`*: seq[Gff_Gff4StructTemplateHeader]
    `tail`*: seq[byte]
    `auroraVersion`*: uint32
    `parent`*: KaitaiStruct
  Gff_Gff4File* = ref object of KaitaiStruct
    `auroraMagic`*: uint32
    `auroraVersion`*: uint32
    `gff4`*: Gff_Gff4AfterAurora
    `parent`*: KaitaiStruct
  Gff_Gff4StructTemplateHeader* = ref object of KaitaiStruct
    `structLabel`*: uint32
    `fieldCount`*: uint32
    `fieldOffset`*: uint32
    `structSize`*: uint32
    `parent`*: Gff_Gff4AfterAurora
  Gff_GffHeaderTail* = ref object of KaitaiStruct
    `structOffset`*: uint32
    `structCount`*: uint32
    `fieldOffset`*: uint32
    `fieldCount`*: uint32
    `labelOffset`*: uint32
    `labelCount`*: uint32
    `fieldDataOffset`*: uint32
    `fieldDataCount`*: uint32
    `fieldIndicesOffset`*: uint32
    `fieldIndicesCount`*: uint32
    `listIndicesOffset`*: uint32
    `listIndicesCount`*: uint32
    `parent`*: Gff_Gff3AfterAurora
  Gff_GffUnionFile* = ref object of KaitaiStruct
    `auroraMagic`*: uint32
    `auroraVersion`*: uint32
    `gff3`*: Gff_Gff3AfterAurora
    `gff4`*: Gff_Gff4AfterAurora
    `parent`*: Gff
  Gff_LabelArray* = ref object of KaitaiStruct
    `labels`*: seq[Gff_LabelEntry]
    `parent`*: Gff_Gff3AfterAurora
  Gff_LabelEntry* = ref object of KaitaiStruct
    `name`*: string
    `parent`*: Gff_LabelArray
  Gff_LabelEntryTerminated* = ref object of KaitaiStruct
    `name`*: string
    `parent`*: Gff_ResolvedField
  Gff_ListEntry* = ref object of KaitaiStruct
    `numStructIndices`*: uint32
    `structIndices`*: seq[uint32]
    `parent`*: Gff_ResolvedField
  Gff_ListIndicesArray* = ref object of KaitaiStruct
    `rawData`*: seq[byte]
    `parent`*: Gff_Gff3AfterAurora
  Gff_ResolvedField* = ref object of KaitaiStruct
    `fieldIndex`*: uint32
    `parent`*: Gff_ResolvedStruct
    `entryInst`: Gff_FieldEntry
    `entryInstFlag`: bool
    `fieldEntryPosInst`: int
    `fieldEntryPosInstFlag`: bool
    `labelInst`: Gff_LabelEntryTerminated
    `labelInstFlag`: bool
    `listEntryInst`: Gff_ListEntry
    `listEntryInstFlag`: bool
    `listStructsInst`: seq[Gff_ResolvedStruct]
    `listStructsInstFlag`: bool
    `valueBinaryInst`: BiowareCommon_BiowareBinaryData
    `valueBinaryInstFlag`: bool
    `valueDoubleInst`: float64
    `valueDoubleInstFlag`: bool
    `valueInt16Inst`: int16
    `valueInt16InstFlag`: bool
    `valueInt32Inst`: int32
    `valueInt32InstFlag`: bool
    `valueInt64Inst`: int64
    `valueInt64InstFlag`: bool
    `valueInt8Inst`: int8
    `valueInt8InstFlag`: bool
    `valueLocalizedStringInst`: BiowareCommon_BiowareLocstring
    `valueLocalizedStringInstFlag`: bool
    `valueResrefInst`: BiowareCommon_BiowareResref
    `valueResrefInstFlag`: bool
    `valueSingleInst`: float32
    `valueSingleInstFlag`: bool
    `valueStrRefInst`: uint32
    `valueStrRefInstFlag`: bool
    `valueStringInst`: BiowareCommon_BiowareCexoString
    `valueStringInstFlag`: bool
    `valueStructInst`: Gff_ResolvedStruct
    `valueStructInstFlag`: bool
    `valueUint16Inst`: uint16
    `valueUint16InstFlag`: bool
    `valueUint32Inst`: uint32
    `valueUint32InstFlag`: bool
    `valueUint64Inst`: uint64
    `valueUint64InstFlag`: bool
    `valueUint8Inst`: uint8
    `valueUint8InstFlag`: bool
    `valueVector3Inst`: BiowareCommon_BiowareVector3
    `valueVector3InstFlag`: bool
    `valueVector4Inst`: BiowareCommon_BiowareVector4
    `valueVector4InstFlag`: bool
  Gff_ResolvedStruct* = ref object of KaitaiStruct
    `structIndex`*: uint32
    `parent`*: KaitaiStruct
    `entryInst`: Gff_StructEntry
    `entryInstFlag`: bool
    `fieldIndicesInst`: seq[uint32]
    `fieldIndicesInstFlag`: bool
    `fieldsInst`: seq[Gff_ResolvedField]
    `fieldsInstFlag`: bool
    `singleFieldInst`: Gff_ResolvedField
    `singleFieldInstFlag`: bool
  Gff_StructArray* = ref object of KaitaiStruct
    `entries`*: seq[Gff_StructEntry]
    `parent`*: Gff_Gff3AfterAurora
  Gff_StructEntry* = ref object of KaitaiStruct
    `structId`*: uint32
    `dataOrOffset`*: uint32
    `fieldCount`*: uint32
    `parent`*: KaitaiStruct
    `fieldIndicesOffsetInst`: uint32
    `fieldIndicesOffsetInstFlag`: bool
    `hasMultipleFieldsInst`: bool
    `hasMultipleFieldsInstFlag`: bool
    `hasSingleFieldInst`: bool
    `hasSingleFieldInstFlag`: bool
    `singleFieldIndexInst`: uint32
    `singleFieldIndexInstFlag`: bool

proc read*(_: typedesc[Gff], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gff
proc read*(_: typedesc[Gff_FieldArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_FieldArray
proc read*(_: typedesc[Gff_FieldData], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_FieldData
proc read*(_: typedesc[Gff_FieldEntry], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gff_FieldEntry
proc read*(_: typedesc[Gff_FieldIndicesArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_FieldIndicesArray
proc read*(_: typedesc[Gff_Gff3AfterAurora], io: KaitaiStream, root: KaitaiStruct, parent: Gff_GffUnionFile): Gff_Gff3AfterAurora
proc read*(_: typedesc[Gff_Gff4AfterAurora], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct, auroraVersion: any): Gff_Gff4AfterAurora
proc read*(_: typedesc[Gff_Gff4File], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gff_Gff4File
proc read*(_: typedesc[Gff_Gff4StructTemplateHeader], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff4AfterAurora): Gff_Gff4StructTemplateHeader
proc read*(_: typedesc[Gff_GffHeaderTail], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_GffHeaderTail
proc read*(_: typedesc[Gff_GffUnionFile], io: KaitaiStream, root: KaitaiStruct, parent: Gff): Gff_GffUnionFile
proc read*(_: typedesc[Gff_LabelArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_LabelArray
proc read*(_: typedesc[Gff_LabelEntry], io: KaitaiStream, root: KaitaiStruct, parent: Gff_LabelArray): Gff_LabelEntry
proc read*(_: typedesc[Gff_LabelEntryTerminated], io: KaitaiStream, root: KaitaiStruct, parent: Gff_ResolvedField): Gff_LabelEntryTerminated
proc read*(_: typedesc[Gff_ListEntry], io: KaitaiStream, root: KaitaiStruct, parent: Gff_ResolvedField): Gff_ListEntry
proc read*(_: typedesc[Gff_ListIndicesArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_ListIndicesArray
proc read*(_: typedesc[Gff_ResolvedField], io: KaitaiStream, root: KaitaiStruct, parent: Gff_ResolvedStruct, fieldIndex: any): Gff_ResolvedField
proc read*(_: typedesc[Gff_ResolvedStruct], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct, structIndex: any): Gff_ResolvedStruct
proc read*(_: typedesc[Gff_StructArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_StructArray
proc read*(_: typedesc[Gff_StructEntry], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gff_StructEntry

proc fieldDataOffsetValue*(this: Gff_FieldEntry): int
proc isComplexType*(this: Gff_FieldEntry): bool
proc isListType*(this: Gff_FieldEntry): bool
proc isSimpleType*(this: Gff_FieldEntry): bool
proc isStructType*(this: Gff_FieldEntry): bool
proc listIndicesOffsetValue*(this: Gff_FieldEntry): int
proc structIndexValue*(this: Gff_FieldEntry): uint32
proc fieldArray*(this: Gff_Gff3AfterAurora): Gff_FieldArray
proc fieldData*(this: Gff_Gff3AfterAurora): Gff_FieldData
proc fieldIndicesArray*(this: Gff_Gff3AfterAurora): Gff_FieldIndicesArray
proc labelArray*(this: Gff_Gff3AfterAurora): Gff_LabelArray
proc listIndicesArray*(this: Gff_Gff3AfterAurora): Gff_ListIndicesArray
proc rootStructResolved*(this: Gff_Gff3AfterAurora): Gff_ResolvedStruct
proc structArray*(this: Gff_Gff3AfterAurora): Gff_StructArray
proc entry*(this: Gff_ResolvedField): Gff_FieldEntry
proc fieldEntryPos*(this: Gff_ResolvedField): int
proc label*(this: Gff_ResolvedField): Gff_LabelEntryTerminated
proc listEntry*(this: Gff_ResolvedField): Gff_ListEntry
proc listStructs*(this: Gff_ResolvedField): seq[Gff_ResolvedStruct]
proc valueBinary*(this: Gff_ResolvedField): BiowareCommon_BiowareBinaryData
proc valueDouble*(this: Gff_ResolvedField): float64
proc valueInt16*(this: Gff_ResolvedField): int16
proc valueInt32*(this: Gff_ResolvedField): int32
proc valueInt64*(this: Gff_ResolvedField): int64
proc valueInt8*(this: Gff_ResolvedField): int8
proc valueLocalizedString*(this: Gff_ResolvedField): BiowareCommon_BiowareLocstring
proc valueResref*(this: Gff_ResolvedField): BiowareCommon_BiowareResref
proc valueSingle*(this: Gff_ResolvedField): float32
proc valueStrRef*(this: Gff_ResolvedField): uint32
proc valueString*(this: Gff_ResolvedField): BiowareCommon_BiowareCexoString
proc valueStruct*(this: Gff_ResolvedField): Gff_ResolvedStruct
proc valueUint16*(this: Gff_ResolvedField): uint16
proc valueUint32*(this: Gff_ResolvedField): uint32
proc valueUint64*(this: Gff_ResolvedField): uint64
proc valueUint8*(this: Gff_ResolvedField): uint8
proc valueVector3*(this: Gff_ResolvedField): BiowareCommon_BiowareVector3
proc valueVector4*(this: Gff_ResolvedField): BiowareCommon_BiowareVector4
proc entry*(this: Gff_ResolvedStruct): Gff_StructEntry
proc fieldIndices*(this: Gff_ResolvedStruct): seq[uint32]
proc fields*(this: Gff_ResolvedStruct): seq[Gff_ResolvedField]
proc singleField*(this: Gff_ResolvedStruct): Gff_ResolvedField
proc fieldIndicesOffset*(this: Gff_StructEntry): uint32
proc hasMultipleFields*(this: Gff_StructEntry): bool
proc hasSingleField*(this: Gff_StructEntry): bool
proc singleFieldIndex*(this: Gff_StructEntry): uint32


##[
BioWare **GFF** (Generic File Format): hierarchical binary game data (KotOR/TSL and Aurora lineage; GFF4 for
DA / Eclipse-class payloads in this `.ksy`). Human-readable tables and tutorials: PyKotor wiki (**Further
reading**). Wire `gff_field_type` enum: `formats/Common/bioware_gff_common.ksy`.

**Aurora prefix (8 bytes):** `u4be` FourCC + `u4be` version (`AuroraFile::readHeader` — `meta.xref`
`xoreos_aurorafile_read_header`).
**GFF3:** Twelve LE `u32` counts/offsets as `gff_header_tail` under `gff3_after_aurora`, then lazy arena
`instances`.
**GFF4:** When version is `V4.0` / `V4.1`, the next field is `platform_id` (`u4be`), not GFF3 `struct_offset`
(`gff4_after_aurora`; partial GFF4 graph — `tail` blob still opaque).

**GFF3 wire summary:**
- Root `file` → `gff_union_file`; arenas addressed via `gff3.header` offsets.
- 12-byte struct rows (`struct_entry`), 12-byte field rows (`field_entry`); root struct index **0**; single-field
  vs multi-field vs lists per wiki *Struct array* / *Field indices* / *List indices*.

**Ghidra / VMA:** engine record names and addresses live on the `seq` / `types` nodes they justify, not in this blurb.

**Pinned URLs and tool history:** `meta.xref` (alphabetical keys). Coverage matrix: `docs/XOREOS_FORMAT_COVERAGE.md`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format">PyKotor wiki — GFF binary format</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63">xoreos — GFF3File::Header::read</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181">xoreos — GFF3File load (post-header struct/field arena wiring)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72">xoreos — GFF4File::Header::read</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L151-L164">xoreos — GFF4File::load entry</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114">PyKotor — GFFBinaryReader.load</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225">reone — GffReader</a>
@see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts#L152-L221">KotOR.js — GFFObject.parse</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp#L86-L238">xoreos-tools — GFF3 load pipeline (shared with CLIs)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176">xoreos-tools — `gffdumper`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60">xoreos-tools — `gffcreator`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf">xoreos-docs — GFF_Format.pdf</a>
]##
proc read*(_: typedesc[Gff], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gff =
  template this: untyped = result
  this = new(Gff)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
(`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
downstream `pos:` / `_root.file.gff3.header` paths.

  ]##
  let fileExpr = Gff_GffUnionFile.read(this.io, this.root, this)
  this.file = fileExpr

proc fromFile*(_: typedesc[Gff], filename: string): Gff =
  Gff.read(newKaitaiFileStream(filename), nil, nil)


##[
Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72

]##
proc read*(_: typedesc[Gff_FieldArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_FieldArray =
  template this: untyped = result
  this = new(Gff_FieldArray)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).

  ]##
  for i in 0 ..< int(Gff(this.root).file.gff3.header.fieldCount):
    let it = Gff_FieldEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Gff_FieldArray], filename: string): Gff_FieldArray =
  Gff_FieldArray.read(newKaitaiFileStream(filename), nil, nil)


##[
Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).

]##
proc read*(_: typedesc[Gff_FieldData], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_FieldData =
  template this: untyped = result
  this = new(Gff_FieldData)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data

  ]##
  let rawDataExpr = this.io.readBytes(int(Gff(this.root).file.gff3.header.fieldDataCount))
  this.rawData = rawDataExpr

proc fromFile*(_: typedesc[Gff_FieldData], filename: string): Gff_FieldData =
  Gff_FieldData.read(newKaitaiFileStream(filename), nil, nil)


##[
One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
`CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146

]##
proc read*(_: typedesc[Gff_FieldEntry], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gff_FieldEntry =
  template this: untyped = result
  this = new(Gff_FieldEntry)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
(ID → storage: inline vs `field_data` vs struct/list indirection).
Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
Source: Ghidra `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273

  ]##
  let fieldTypeExpr = BiowareGffCommon_GffFieldType(this.io.readU4le())
  this.fieldType = fieldTypeExpr

  ##[
  Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
Source: Ghidra `GFFFieldData.label_index` @ +0x4 (ulong).

  ]##
  let labelIndexExpr = this.io.readU4le()
  this.labelIndex = labelIndexExpr

  ##[
  Inline data (simple types) or offset/index (complex types):
- Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
- Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
- Struct (14): Struct index (index into struct_array)
- List (15): Byte offset into list_indices_array (relative to list_indices_offset)
Source: Ghidra `GFFFieldData.data_or_data_offset` @ +0x8.
`resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types

  ]##
  let dataOrOffsetExpr = this.io.readU4le()
  this.dataOrOffset = dataOrOffsetExpr

proc fieldDataOffsetValue(this: Gff_FieldEntry): int = 

  ##[
  Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.

  ]##
  if this.fieldDataOffsetValueInstFlag:
    return this.fieldDataOffsetValueInst
  if this.isComplexType:
    let fieldDataOffsetValueInstExpr = int(Gff(this.root).file.gff3.header.fieldDataOffset + this.dataOrOffset)
    this.fieldDataOffsetValueInst = fieldDataOffsetValueInstExpr
  this.fieldDataOffsetValueInstFlag = true
  return this.fieldDataOffsetValueInst

proc isComplexType(this: Gff_FieldEntry): bool = 

  ##[
  Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).

  ]##
  if this.isComplexTypeInstFlag:
    return this.isComplexTypeInst
  let isComplexTypeInstExpr = bool( ((this.fieldType == bioware_gff_common.uint64) or (this.fieldType == bioware_gff_common.int64) or (this.fieldType == bioware_gff_common.double) or (this.fieldType == bioware_gff_common.string) or (this.fieldType == bioware_gff_common.resref) or (this.fieldType == bioware_gff_common.localized_string) or (this.fieldType == bioware_gff_common.binary) or (this.fieldType == bioware_gff_common.vector4) or (this.fieldType == bioware_gff_common.vector3)) )
  this.isComplexTypeInst = isComplexTypeInstExpr
  this.isComplexTypeInstFlag = true
  return this.isComplexTypeInst

proc isListType(this: Gff_FieldEntry): bool = 

  ##[
  Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).

  ]##
  if this.isListTypeInstFlag:
    return this.isListTypeInst
  let isListTypeInstExpr = bool(this.fieldType == bioware_gff_common.list)
  this.isListTypeInst = isListTypeInstExpr
  this.isListTypeInstFlag = true
  return this.isListTypeInst

proc isSimpleType(this: Gff_FieldEntry): bool = 

  ##[
  Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
**PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).

  ]##
  if this.isSimpleTypeInstFlag:
    return this.isSimpleTypeInst
  let isSimpleTypeInstExpr = bool( ((this.fieldType == bioware_gff_common.uint8) or (this.fieldType == bioware_gff_common.int8) or (this.fieldType == bioware_gff_common.uint16) or (this.fieldType == bioware_gff_common.int16) or (this.fieldType == bioware_gff_common.uint32) or (this.fieldType == bioware_gff_common.int32) or (this.fieldType == bioware_gff_common.single) or (this.fieldType == bioware_gff_common.str_ref)) )
  this.isSimpleTypeInst = isSimpleTypeInstExpr
  this.isSimpleTypeInstFlag = true
  return this.isSimpleTypeInst

proc isStructType(this: Gff_FieldEntry): bool = 

  ##[
  Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).

  ]##
  if this.isStructTypeInstFlag:
    return this.isStructTypeInst
  let isStructTypeInstExpr = bool(this.fieldType == bioware_gff_common.struct)
  this.isStructTypeInst = isStructTypeInstExpr
  this.isStructTypeInstFlag = true
  return this.isStructTypeInst

proc listIndicesOffsetValue(this: Gff_FieldEntry): int = 

  ##[
  Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.

  ]##
  if this.listIndicesOffsetValueInstFlag:
    return this.listIndicesOffsetValueInst
  if this.isListType:
    let listIndicesOffsetValueInstExpr = int(Gff(this.root).file.gff3.header.listIndicesOffset + this.dataOrOffset)
    this.listIndicesOffsetValueInst = listIndicesOffsetValueInstExpr
  this.listIndicesOffsetValueInstFlag = true
  return this.listIndicesOffsetValueInst

proc structIndexValue(this: Gff_FieldEntry): uint32 = 

  ##[
  Struct index (same numeric interpretation as `GFFStructData` row index).

  ]##
  if this.structIndexValueInstFlag:
    return this.structIndexValueInst
  if this.isStructType:
    let structIndexValueInstExpr = uint32(this.dataOrOffset)
    this.structIndexValueInst = structIndexValueInstExpr
  this.structIndexValueInstFlag = true
  return this.structIndexValueInst

proc fromFile*(_: typedesc[Gff_FieldEntry], filename: string): Gff_FieldEntry =
  Gff_FieldEntry.read(newKaitaiFileStream(filename), nil, nil)


##[
Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
“MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).

]##
proc read*(_: typedesc[Gff_FieldIndicesArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_FieldIndicesArray =
  template this: untyped = result
  this = new(Gff_FieldIndicesArray)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
`GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
Ghidra: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.

  ]##
  for i in 0 ..< int(Gff(this.root).file.gff3.header.fieldIndicesCount):
    let it = this.io.readU4le()
    this.indices.add(it)

proc fromFile*(_: typedesc[Gff_FieldIndicesArray], filename: string): Gff_FieldIndicesArray =
  Gff_FieldIndicesArray.read(newKaitaiFileStream(filename), nil, nil)


##[
GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.

]##
proc read*(_: typedesc[Gff_Gff3AfterAurora], io: KaitaiStream, root: KaitaiStruct, parent: Gff_GffUnionFile): Gff_Gff3AfterAurora =
  template this: untyped = result
  this = new(Gff_Gff3AfterAurora)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
rows from Struct Array Offset through List Indices Count. Ghidra: `GFFHeaderInfo` @ +0x8 … +0x34.

  ]##
  let headerExpr = Gff_GffHeaderTail.read(this.io, this.root, this)
  this.header = headerExpr

proc fieldArray(this: Gff_Gff3AfterAurora): Gff_FieldArray = 

  ##[
  Field dictionary: `header.field_count` × 12 B at `header.field_offset`. Ghidra: `GFFFieldData`.
`CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
    PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149

  ]##
  if this.fieldArrayInstFlag:
    return this.fieldArrayInst
  if this.header.fieldCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.fieldOffset))
    let fieldArrayInstExpr = Gff_FieldArray.read(this.io, this.root, this)
    this.fieldArrayInst = fieldArrayInstExpr
    this.io.seek(pos)
  this.fieldArrayInstFlag = true
  return this.fieldArrayInst

proc fieldData(this: Gff_Gff3AfterAurora): Gff_FieldData = 

  ##[
  Complex-type payload heap. Ghidra: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
    PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216

  ]##
  if this.fieldDataInstFlag:
    return this.fieldDataInst
  if this.header.fieldDataCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.fieldDataOffset))
    let fieldDataInstExpr = Gff_FieldData.read(this.io, this.root, this)
    this.fieldDataInst = fieldDataInstExpr
    this.io.seek(pos)
  this.fieldDataInstFlag = true
  return this.fieldDataInst

proc fieldIndicesArray(this: Gff_Gff3AfterAurora): Gff_FieldIndicesArray = 

  ##[
  Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
Ghidra: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
    PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49

  ]##
  if this.fieldIndicesArrayInstFlag:
    return this.fieldIndicesArrayInst
  if this.header.fieldIndicesCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.fieldIndicesOffset))
    let fieldIndicesArrayInstExpr = Gff_FieldIndicesArray.read(this.io, this.root, this)
    this.fieldIndicesArrayInst = fieldIndicesArrayInstExpr
    this.io.seek(pos)
  this.fieldIndicesArrayInstFlag = true
  return this.fieldIndicesArrayInst

proc labelArray(this: Gff_Gff3AfterAurora): Gff_LabelArray = 

  ##[
  Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
Ghidra: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
    PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154

  ]##
  if this.labelArrayInstFlag:
    return this.labelArrayInst
  if this.header.labelCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.labelOffset))
    let labelArrayInstExpr = Gff_LabelArray.read(this.io, this.root, this)
    this.labelArrayInst = labelArrayInstExpr
    this.io.seek(pos)
  this.labelArrayInstFlag = true
  return this.labelArrayInst

proc listIndicesArray(this: Gff_Gff3AfterAurora): Gff_ListIndicesArray = 

  ##[
  Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
Ghidra: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
    PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223

  ]##
  if this.listIndicesArrayInstFlag:
    return this.listIndicesArrayInst
  if this.header.listIndicesCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.listIndicesOffset))
    let listIndicesArrayInstExpr = Gff_ListIndicesArray.read(this.io, this.root, this)
    this.listIndicesArrayInst = listIndicesArrayInstExpr
    this.io.seek(pos)
  this.listIndicesArrayInstFlag = true
  return this.listIndicesArrayInst

proc rootStructResolved(this: Gff_Gff3AfterAurora): Gff_ResolvedStruct = 

  ##[
  Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
Implements the access pattern described in meta.doc (single-field vs multi-field structs).

  ]##
  if this.rootStructResolvedInstFlag:
    return this.rootStructResolvedInst
  let rootStructResolvedInstExpr = Gff_ResolvedStruct.read(this.io, this.root, this, 0)
  this.rootStructResolvedInst = rootStructResolvedInstExpr
  this.rootStructResolvedInstFlag = true
  return this.rootStructResolvedInst

proc structArray(this: Gff_Gff3AfterAurora): Gff_StructArray = 

  ##[
  Struct table: `header.struct_count` × 12 B at `header.struct_offset`. Ghidra: `GFFStructData` rows.
Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
    PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65

  ]##
  if this.structArrayInstFlag:
    return this.structArrayInst
  if this.header.structCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.structOffset))
    let structArrayInstExpr = Gff_StructArray.read(this.io, this.root, this)
    this.structArrayInst = structArrayInstExpr
    this.io.seek(pos)
  this.structArrayInstFlag = true
  return this.structArrayInst

proc fromFile*(_: typedesc[Gff_Gff3AfterAurora], filename: string): Gff_Gff3AfterAurora =
  Gff_Gff3AfterAurora.read(newKaitaiFileStream(filename), nil, nil)


##[
GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.

]##
proc read*(_: typedesc[Gff_Gff4AfterAurora], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct, auroraVersion: any): Gff_Gff4AfterAurora =
  template this: untyped = result
  this = new(Gff_Gff4AfterAurora)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent
  let auroraVersionExpr = uint32(auroraVersion)
  this.auroraVersion = auroraVersionExpr


  ##[
  Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
`PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).

  ]##
  let platformIdExpr = this.io.readU4be()
  this.platformId = platformIdExpr

  ##[
  GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
`readUint32BE` on the endian-aware substream (`gff4file.cpp`).

  ]##
  let fileTypeExpr = this.io.readU4be()
  this.fileType = fileTypeExpr

  ##[
  Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).
  ]##
  let typeVersionExpr = this.io.readU4be()
  this.typeVersion = typeVersionExpr

  ##[
  Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
in typical DA assets). xoreos: `_header.structCount`.

  ]##
  let numStructTemplatesExpr = this.io.readU4le()
  this.numStructTemplates = numStructTemplatesExpr

  ##[
  V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).
  ]##
  if this.auroraVersion == 1446260273:
    let stringCountExpr = this.io.readU4le()
    this.stringCount = stringCountExpr

  ##[
  V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).
  ]##
  if this.auroraVersion == 1446260273:
    let stringOffsetExpr = this.io.readU4le()
    this.stringOffset = stringOffsetExpr

  ##[
  Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
`readUint32` on the endian substream (`gff4file.cpp`).

  ]##
  let dataOffsetExpr = this.io.readU4le()
  this.dataOffset = dataOffsetExpr

  ##[
  Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).
  ]##
  for i in 0 ..< int(this.numStructTemplates):
    let it = Gff_Gff4StructTemplateHeader.read(this.io, this.root, this)
    this.structTemplates.add(it)

  ##[
  Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
GFF4 graph walker or defer to engine code.

  ]##
  let tailExpr = this.io.readBytesFull()
  this.tail = tailExpr

proc fromFile*(_: typedesc[Gff_Gff4AfterAurora], filename: string): Gff_Gff4AfterAurora =
  Gff_Gff4AfterAurora.read(newKaitaiFileStream(filename), nil, nil)


##[
Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
that expect a single user-type over the whole file.

]##
proc read*(_: typedesc[Gff_Gff4File], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gff_Gff4File =
  template this: untyped = result
  this = new(Gff_Gff4File)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Aurora container magic (`GFF ` as `u4be`).
  ]##
  let auroraMagicExpr = this.io.readU4be()
  this.auroraMagic = auroraMagicExpr

  ##[
  GFF4 `V4.0` / `V4.1` on-disk tags.
  ]##
  let auroraVersionExpr = this.io.readU4be()
  this.auroraVersion = auroraVersionExpr

  ##[
  GFF4 header tail + struct templates + opaque remainder.
  ]##
  let gff4Expr = Gff_Gff4AfterAurora.read(this.io, this.root, this, this.auroraVersion)
  this.gff4 = gff4Expr

proc fromFile*(_: typedesc[Gff_Gff4File], filename: string): Gff_Gff4File =
  Gff_Gff4File.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Gff_Gff4StructTemplateHeader], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff4AfterAurora): Gff_Gff4StructTemplateHeader =
  template this: untyped = result
  this = new(Gff_Gff4StructTemplateHeader)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Template label (fourCC style, read `readUint32BE` in `loadStructs`).
  ]##
  let structLabelExpr = this.io.readU4be()
  this.structLabel = structLabelExpr

  ##[
  Number of field declaration records for this template (may be 0).
  ]##
  let fieldCountExpr = this.io.readU4le()
  this.fieldCount = fieldCountExpr

  ##[
  Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
(xoreos `continue`s without reading declarations).

  ]##
  let fieldOffsetExpr = this.io.readU4le()
  this.fieldOffset = fieldOffsetExpr

  ##[
  Declared on-disk struct size for instances of this template (`strct.size`).
  ]##
  let structSizeExpr = this.io.readU4le()
  this.structSize = structSizeExpr

proc fromFile*(_: typedesc[Gff_Gff4StructTemplateHeader], filename: string): Gff_Gff4StructTemplateHeader =
  Gff_Gff4StructTemplateHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
**GFF3** header continuation: **48 bytes** (twelve LE `u32` dwords) at file offsets **0x08–0x37**, immediately
after the shared Aurora 8-byte prefix (`aurora_magic` / `aurora_version` on `gff_union_file`). Same layout as
wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) rows from “Struct Array
Offset” through “List Indices Count”. Ghidra `/K1/k1_win_gog_swkotor.exe`: `GFFHeaderInfo` @ +0x8 … +0x34.

Sources (same DWORD order on disk after the 8-byte signature):
- https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 (`file_type`/`file_version` L79–L80 then twelve header `u32`s L93–L106)
- https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L44 (`GffReader::load` — skips 8-byte signature, reads twelve header `u32`s L30–L41)
- https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
- https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 (Aurora/GFF-family background; MultiMap wording)

]##
proc read*(_: typedesc[Gff_GffHeaderTail], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_GffHeaderTail =
  template this: untyped = result
  this = new(Gff_GffHeaderTail)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
Source: Ghidra `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30

  ]##
  let structOffsetExpr = this.io.readU4le()
  this.structOffset = structOffsetExpr

  ##[
  Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
Source: Ghidra `GFFHeaderInfo.struct_count` @ +0xC (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31

  ]##
  let structCountExpr = this.io.readU4le()
  this.structCount = structCountExpr

  ##[
  Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
Source: Ghidra `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32

  ]##
  let fieldOffsetExpr = this.io.readU4le()
  this.fieldOffset = fieldOffsetExpr

  ##[
  Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
Source: Ghidra `GFFHeaderInfo.field_count` @ +0x14 (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33

  ]##
  let fieldCountExpr = this.io.readU4le()
  this.fieldCount = fieldCountExpr

  ##[
  Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
Source: Ghidra `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34

  ]##
  let labelOffsetExpr = this.io.readU4le()
  this.labelOffset = labelOffsetExpr

  ##[
  Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
Source: Ghidra `GFFHeaderInfo.label_count` @ +0x1C (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35

  ]##
  let labelCountExpr = this.io.readU4le()
  this.labelCount = labelCountExpr

  ##[
  Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
Source: Ghidra `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36

  ]##
  let fieldDataOffsetExpr = this.io.readU4le()
  this.fieldDataOffset = fieldDataOffsetExpr

  ##[
  Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
Source: Ghidra `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37

  ]##
  let fieldDataCountExpr = this.io.readU4le()
  this.fieldDataCount = fieldDataCountExpr

  ##[
  Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
Source: Ghidra `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38

  ]##
  let fieldIndicesOffsetExpr = this.io.readU4le()
  this.fieldIndicesOffset = fieldIndicesOffsetExpr

  ##[
  Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
Source: Ghidra `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)

  ]##
  let fieldIndicesCountExpr = this.io.readU4le()
  this.fieldIndicesCount = fieldIndicesCountExpr

  ##[
  Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
Source: Ghidra `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40

  ]##
  let listIndicesOffsetExpr = this.io.readU4le()
  this.listIndicesOffset = listIndicesOffsetExpr

  ##[
  List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
Source: Ghidra `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223

  ]##
  let listIndicesCountExpr = this.io.readU4le()
  this.listIndicesCount = listIndicesCountExpr

proc fromFile*(_: typedesc[Gff_GffHeaderTail], filename: string): Gff_GffHeaderTail =
  Gff_GffHeaderTail.read(newKaitaiFileStream(filename), nil, nil)


##[
Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
(`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.

]##
proc read*(_: typedesc[Gff_GffUnionFile], io: KaitaiStream, root: KaitaiStruct, parent: Gff): Gff_GffUnionFile =
  template this: untyped = result
  this = new(Gff_GffUnionFile)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.

  ]##
  let auroraMagicExpr = this.io.readU4be()
  this.auroraMagic = auroraMagicExpr

  ##[
  Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
`0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.

  ]##
  let auroraVersionExpr = this.io.readU4be()
  this.auroraVersion = auroraVersionExpr

  ##[
  **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.

  ]##
  if  ((this.auroraVersion != 1446260272) and (this.auroraVersion != 1446260273)) :
    let gff3Expr = Gff_Gff3AfterAurora.read(this.io, this.root, this)
    this.gff3 = gff3Expr

  ##[
  **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.

  ]##
  if  ((this.auroraVersion == 1446260272) or (this.auroraVersion == 1446260273)) :
    let gff4Expr = Gff_Gff4AfterAurora.read(this.io, this.root, this, this.auroraVersion)
    this.gff4 = gff4Expr

proc fromFile*(_: typedesc[Gff_GffUnionFile], filename: string): Gff_GffUnionFile =
  Gff_GffUnionFile.read(newKaitaiFileStream(filename), nil, nil)


##[
Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
Indexed by `GFFFieldData.label_index` (×16). Not a separate Ghidra struct — rows are `char[16]` in bulk.
Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/

]##
proc read*(_: typedesc[Gff_LabelArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_LabelArray =
  template this: untyped = result
  this = new(Gff_LabelArray)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
Index `i` is at file offset `label_offset + i*16`.

  ]##
  for i in 0 ..< int(Gff(this.root).file.gff3.header.labelCount):
    let it = Gff_LabelEntry.read(this.io, this.root, this)
    this.labels.add(it)

proc fromFile*(_: typedesc[Gff_LabelArray], filename: string): Gff_LabelArray =
  Gff_LabelArray.read(newKaitaiFileStream(filename), nil, nil)


##[
One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.

]##
proc read*(_: typedesc[Gff_LabelEntry], io: KaitaiStream, root: KaitaiStruct, parent: Gff_LabelArray): Gff_LabelEntry =
  template this: untyped = result
  this = new(Gff_LabelEntry)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array

  ]##
  let nameExpr = encode(this.io.readBytes(int(16)), "ASCII")
  this.name = nameExpr

proc fromFile*(_: typedesc[Gff_LabelEntry], filename: string): Gff_LabelEntry =
  Gff_LabelEntry.read(newKaitaiFileStream(filename), nil, nil)


##[
Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
Not a separate Ghidra datatype. Wire cite: `label_entry.name`.

]##
proc read*(_: typedesc[Gff_LabelEntryTerminated], io: KaitaiStream, root: KaitaiStruct, parent: Gff_ResolvedField): Gff_LabelEntryTerminated =
  template this: untyped = result
  this = new(Gff_LabelEntryTerminated)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.

  ]##
  let nameExpr = encode(this.io.readBytes(int(16)).bytesTerminate(0, false), "ASCII")
  this.name = nameExpr

proc fromFile*(_: typedesc[Gff_LabelEntryTerminated], filename: string): Gff_LabelEntryTerminated =
  Gff_LabelEntryTerminated.read(newKaitaiFileStream(filename), nil, nil)


##[
One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223

]##
proc read*(_: typedesc[Gff_ListEntry], io: KaitaiStream, root: KaitaiStruct, parent: Gff_ResolvedField): Gff_ListEntry =
  template this: untyped = result
  this = new(Gff_ListEntry)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Little-endian count of following struct indices (list cardinality).
Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices

  ]##
  let numStructIndicesExpr = this.io.readU4le()
  this.numStructIndices = numStructIndicesExpr

  ##[
  Each value indexes `struct_array.entries[index]` (`GFFStructData` row).

  ]##
  for i in 0 ..< int(this.numStructIndices):
    let it = this.io.readU4le()
    this.structIndices.add(it)

proc fromFile*(_: typedesc[Gff_ListEntry], filename: string): Gff_ListEntry =
  Gff_ListEntry.read(newKaitaiFileStream(filename), nil, nil)


##[
Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).

]##
proc read*(_: typedesc[Gff_ListIndicesArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_ListIndicesArray =
  template this: untyped = result
  this = new(Gff_ListIndicesArray)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.

  ]##
  let rawDataExpr = this.io.readBytes(int(Gff(this.root).file.gff3.header.listIndicesCount))
  this.rawData = rawDataExpr

proc fromFile*(_: typedesc[Gff_ListIndicesArray], filename: string): Gff_ListIndicesArray =
  Gff_ListIndicesArray.read(newKaitaiFileStream(filename), nil, nil)


##[
Kaitai composition: one `GFFFieldData` row + label + payload.
Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.

]##
proc read*(_: typedesc[Gff_ResolvedField], io: KaitaiStream, root: KaitaiStruct, parent: Gff_ResolvedStruct, fieldIndex: any): Gff_ResolvedField =
  template this: untyped = result
  this = new(Gff_ResolvedField)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent
  let fieldIndexExpr = uint32(fieldIndex)
  this.fieldIndex = fieldIndexExpr


proc entry(this: Gff_ResolvedField): Gff_FieldEntry = 

  ##[
  Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).

  ]##
  if this.entryInstFlag:
    return this.entryInst
  let pos = this.io.pos()
  this.io.seek(int(Gff(this.root).file.gff3.header.fieldOffset + this.fieldIndex * 12))
  let entryInstExpr = Gff_FieldEntry.read(this.io, this.root, this)
  this.entryInst = entryInstExpr
  this.io.seek(pos)
  this.entryInstFlag = true
  return this.entryInst

proc fieldEntryPos(this: Gff_ResolvedField): int = 

  ##[
  Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).

  ]##
  if this.fieldEntryPosInstFlag:
    return this.fieldEntryPosInst
  let fieldEntryPosInstExpr = int(Gff(this.root).file.gff3.header.fieldOffset + this.fieldIndex * 12)
  this.fieldEntryPosInst = fieldEntryPosInstExpr
  this.fieldEntryPosInstFlag = true
  return this.fieldEntryPosInst

proc label(this: Gff_ResolvedField): Gff_LabelEntryTerminated = 

  ##[
  Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.

  ]##
  if this.labelInstFlag:
    return this.labelInst
  let pos = this.io.pos()
  this.io.seek(int(Gff(this.root).file.gff3.header.labelOffset + this.entry.labelIndex * 16))
  let labelInstExpr = Gff_LabelEntryTerminated.read(this.io, this.root, this)
  this.labelInst = labelInstExpr
  this.io.seek(pos)
  this.labelInstFlag = true
  return this.labelInst

proc listEntry(this: Gff_ResolvedField): Gff_ListEntry = 

  ##[
  `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.

  ]##
  if this.listEntryInstFlag:
    return this.listEntryInst
  if this.entry.fieldType == bioware_gff_common.list:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.listIndicesOffset + this.entry.dataOrOffset))
    let listEntryInstExpr = Gff_ListEntry.read(this.io, this.root, this)
    this.listEntryInst = listEntryInstExpr
    this.io.seek(pos)
  this.listEntryInstFlag = true
  return this.listEntryInst

proc listStructs(this: Gff_ResolvedField): seq[Gff_ResolvedStruct] = 

  ##[
  Child structs for this list; indices from `list_entry.struct_indices`.

  ]##
  if this.listStructsInstFlag:
    return this.listStructsInst
  if this.entry.fieldType == bioware_gff_common.list:
    for i in 0 ..< int(this.listEntry.numStructIndices):
      let it = Gff_ResolvedStruct.read(this.io, this.root, this, this.listEntry.structIndices[i])
      this.listStructsInst.add(it)
  this.listStructsInstFlag = true
  return this.listStructsInst

proc valueBinary(this: Gff_ResolvedField): BiowareCommon_BiowareBinaryData = 

  ##[
  `GFFFieldTypes` 13 — binary (`bioware_binary_data`).

  ]##
  if this.valueBinaryInstFlag:
    return this.valueBinaryInst
  if this.entry.fieldType == bioware_gff_common.binary:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldDataOffset + this.entry.dataOrOffset))
    let valueBinaryInstExpr = BiowareCommon_BiowareBinaryData.read(this.io, nil, nil)
    this.valueBinaryInst = valueBinaryInstExpr
    this.io.seek(pos)
  this.valueBinaryInstFlag = true
  return this.valueBinaryInst

proc valueDouble(this: Gff_ResolvedField): float64 = 

  ##[
  `GFFFieldTypes` 9 (double).

  ]##
  if this.valueDoubleInstFlag:
    return this.valueDoubleInst
  if this.entry.fieldType == bioware_gff_common.double:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldDataOffset + this.entry.dataOrOffset))
    let valueDoubleInstExpr = this.io.readF8le()
    this.valueDoubleInst = valueDoubleInstExpr
    this.io.seek(pos)
  this.valueDoubleInstFlag = true
  return this.valueDoubleInst

proc valueInt16(this: Gff_ResolvedField): int16 = 

  ##[
  `GFFFieldTypes` 3 (INT16 LE at +8).

  ]##
  if this.valueInt16InstFlag:
    return this.valueInt16Inst
  if this.entry.fieldType == bioware_gff_common.int16:
    let pos = this.io.pos()
    this.io.seek(int(this.fieldEntryPos + 8))
    let valueInt16InstExpr = this.io.readS2le()
    this.valueInt16Inst = valueInt16InstExpr
    this.io.seek(pos)
  this.valueInt16InstFlag = true
  return this.valueInt16Inst

proc valueInt32(this: Gff_ResolvedField): int32 = 

  ##[
  `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.

  ]##
  if this.valueInt32InstFlag:
    return this.valueInt32Inst
  if this.entry.fieldType == bioware_gff_common.int32:
    let pos = this.io.pos()
    this.io.seek(int(this.fieldEntryPos + 8))
    let valueInt32InstExpr = this.io.readS4le()
    this.valueInt32Inst = valueInt32InstExpr
    this.io.seek(pos)
  this.valueInt32InstFlag = true
  return this.valueInt32Inst

proc valueInt64(this: Gff_ResolvedField): int64 = 

  ##[
  `GFFFieldTypes` 7 (INT64).

  ]##
  if this.valueInt64InstFlag:
    return this.valueInt64Inst
  if this.entry.fieldType == bioware_gff_common.int64:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldDataOffset + this.entry.dataOrOffset))
    let valueInt64InstExpr = this.io.readS8le()
    this.valueInt64Inst = valueInt64InstExpr
    this.io.seek(pos)
  this.valueInt64InstFlag = true
  return this.valueInt64Inst

proc valueInt8(this: Gff_ResolvedField): int8 = 

  ##[
  `GFFFieldTypes` 1 (INT8 in low byte of slot).

  ]##
  if this.valueInt8InstFlag:
    return this.valueInt8Inst
  if this.entry.fieldType == bioware_gff_common.int8:
    let pos = this.io.pos()
    this.io.seek(int(this.fieldEntryPos + 8))
    let valueInt8InstExpr = this.io.readS1()
    this.valueInt8Inst = valueInt8InstExpr
    this.io.seek(pos)
  this.valueInt8InstFlag = true
  return this.valueInt8Inst

proc valueLocalizedString(this: Gff_ResolvedField): BiowareCommon_BiowareLocstring = 

  ##[
  `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).

  ]##
  if this.valueLocalizedStringInstFlag:
    return this.valueLocalizedStringInst
  if this.entry.fieldType == bioware_gff_common.localized_string:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldDataOffset + this.entry.dataOrOffset))
    let valueLocalizedStringInstExpr = BiowareCommon_BiowareLocstring.read(this.io, nil, nil)
    this.valueLocalizedStringInst = valueLocalizedStringInstExpr
    this.io.seek(pos)
  this.valueLocalizedStringInstFlag = true
  return this.valueLocalizedStringInst

proc valueResref(this: Gff_ResolvedField): BiowareCommon_BiowareResref = 

  ##[
  `GFFFieldTypes` 11 — ResRef (`bioware_resref`).

  ]##
  if this.valueResrefInstFlag:
    return this.valueResrefInst
  if this.entry.fieldType == bioware_gff_common.resref:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldDataOffset + this.entry.dataOrOffset))
    let valueResrefInstExpr = BiowareCommon_BiowareResref.read(this.io, nil, nil)
    this.valueResrefInst = valueResrefInstExpr
    this.io.seek(pos)
  this.valueResrefInstFlag = true
  return this.valueResrefInst

proc valueSingle(this: Gff_ResolvedField): float32 = 

  ##[
  `GFFFieldTypes` 8 (32-bit float).

  ]##
  if this.valueSingleInstFlag:
    return this.valueSingleInst
  if this.entry.fieldType == bioware_gff_common.single:
    let pos = this.io.pos()
    this.io.seek(int(this.fieldEntryPos + 8))
    let valueSingleInstExpr = this.io.readF4le()
    this.valueSingleInst = valueSingleInstExpr
    this.io.seek(pos)
  this.valueSingleInstFlag = true
  return this.valueSingleInst

proc valueStrRef(this: Gff_ResolvedField): uint32 = 

  ##[
  `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
`0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
**reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273

  ]##
  if this.valueStrRefInstFlag:
    return this.valueStrRefInst
  if this.entry.fieldType == bioware_gff_common.str_ref:
    let pos = this.io.pos()
    this.io.seek(int(this.fieldEntryPos + 8))
    let valueStrRefInstExpr = this.io.readU4le()
    this.valueStrRefInst = valueStrRefInstExpr
    this.io.seek(pos)
  this.valueStrRefInstFlag = true
  return this.valueStrRefInst

proc valueString(this: Gff_ResolvedField): BiowareCommon_BiowareCexoString = 

  ##[
  `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).

  ]##
  if this.valueStringInstFlag:
    return this.valueStringInst
  if this.entry.fieldType == bioware_gff_common.string:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldDataOffset + this.entry.dataOrOffset))
    let valueStringInstExpr = BiowareCommon_BiowareCexoString.read(this.io, nil, nil)
    this.valueStringInst = valueStringInstExpr
    this.io.seek(pos)
  this.valueStringInstFlag = true
  return this.valueStringInst

proc valueStruct(this: Gff_ResolvedField): Gff_ResolvedStruct = 

  ##[
  `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.

  ]##
  if this.valueStructInstFlag:
    return this.valueStructInst
  if this.entry.fieldType == bioware_gff_common.struct:
    let valueStructInstExpr = Gff_ResolvedStruct.read(this.io, this.root, this, this.entry.dataOrOffset)
    this.valueStructInst = valueStructInstExpr
  this.valueStructInstFlag = true
  return this.valueStructInst

proc valueUint16(this: Gff_ResolvedField): uint16 = 

  ##[
  `GFFFieldTypes` 2 (UINT16 LE at +8).

  ]##
  if this.valueUint16InstFlag:
    return this.valueUint16Inst
  if this.entry.fieldType == bioware_gff_common.uint16:
    let pos = this.io.pos()
    this.io.seek(int(this.fieldEntryPos + 8))
    let valueUint16InstExpr = this.io.readU2le()
    this.valueUint16Inst = valueUint16InstExpr
    this.io.seek(pos)
  this.valueUint16InstFlag = true
  return this.valueUint16Inst

proc valueUint32(this: Gff_ResolvedField): uint32 = 

  ##[
  `GFFFieldTypes` 4 (full inline DWORD).

  ]##
  if this.valueUint32InstFlag:
    return this.valueUint32Inst
  if this.entry.fieldType == bioware_gff_common.uint32:
    let pos = this.io.pos()
    this.io.seek(int(this.fieldEntryPos + 8))
    let valueUint32InstExpr = this.io.readU4le()
    this.valueUint32Inst = valueUint32InstExpr
    this.io.seek(pos)
  this.valueUint32InstFlag = true
  return this.valueUint32Inst

proc valueUint64(this: Gff_ResolvedField): uint64 = 

  ##[
  `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).

  ]##
  if this.valueUint64InstFlag:
    return this.valueUint64Inst
  if this.entry.fieldType == bioware_gff_common.uint64:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldDataOffset + this.entry.dataOrOffset))
    let valueUint64InstExpr = this.io.readU8le()
    this.valueUint64Inst = valueUint64InstExpr
    this.io.seek(pos)
  this.valueUint64InstFlag = true
  return this.valueUint64Inst

proc valueUint8(this: Gff_ResolvedField): uint8 = 

  ##[
  `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.

  ]##
  if this.valueUint8InstFlag:
    return this.valueUint8Inst
  if this.entry.fieldType == bioware_gff_common.uint8:
    let pos = this.io.pos()
    this.io.seek(int(this.fieldEntryPos + 8))
    let valueUint8InstExpr = this.io.readU1()
    this.valueUint8Inst = valueUint8InstExpr
    this.io.seek(pos)
  this.valueUint8InstFlag = true
  return this.valueUint8Inst

proc valueVector3(this: Gff_ResolvedField): BiowareCommon_BiowareVector3 = 

  ##[
  `GFFFieldTypes` 17 — three floats (`bioware_vector3`).

  ]##
  if this.valueVector3InstFlag:
    return this.valueVector3Inst
  if this.entry.fieldType == bioware_gff_common.vector3:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldDataOffset + this.entry.dataOrOffset))
    let valueVector3InstExpr = BiowareCommon_BiowareVector3.read(this.io, nil, nil)
    this.valueVector3Inst = valueVector3InstExpr
    this.io.seek(pos)
  this.valueVector3InstFlag = true
  return this.valueVector3Inst

proc valueVector4(this: Gff_ResolvedField): BiowareCommon_BiowareVector4 = 

  ##[
  `GFFFieldTypes` 16 — four floats (`bioware_vector4`).

  ]##
  if this.valueVector4InstFlag:
    return this.valueVector4Inst
  if this.entry.fieldType == bioware_gff_common.vector4:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldDataOffset + this.entry.dataOrOffset))
    let valueVector4InstExpr = BiowareCommon_BiowareVector4.read(this.io, nil, nil)
    this.valueVector4Inst = valueVector4InstExpr
    this.io.seek(pos)
  this.valueVector4InstFlag = true
  return this.valueVector4Inst

proc fromFile*(_: typedesc[Gff_ResolvedField], filename: string): Gff_ResolvedField =
  Gff_ResolvedField.read(newKaitaiFileStream(filename), nil, nil)


##[
Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
On-disk row remains at `struct_offset + struct_index * 12`.

]##
proc read*(_: typedesc[Gff_ResolvedStruct], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct, structIndex: any): Gff_ResolvedStruct =
  template this: untyped = result
  this = new(Gff_ResolvedStruct)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent
  let structIndexExpr = uint32(structIndex)
  this.structIndex = structIndexExpr


proc entry(this: Gff_ResolvedStruct): Gff_StructEntry = 

  ##[
  Raw `GFFStructData` (Ghidra 12-byte layout).

  ]##
  if this.entryInstFlag:
    return this.entryInst
  let pos = this.io.pos()
  this.io.seek(int(Gff(this.root).file.gff3.header.structOffset + this.structIndex * 12))
  let entryInstExpr = Gff_StructEntry.read(this.io, this.root, this)
  this.entryInst = entryInstExpr
  this.io.seek(pos)
  this.entryInstFlag = true
  return this.entryInst

proc fieldIndices(this: Gff_ResolvedStruct): seq[uint32] = 

  ##[
  Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).

  ]##
  if this.fieldIndicesInstFlag:
    return this.fieldIndicesInst
  if this.entry.fieldCount > 1:
    let pos = this.io.pos()
    this.io.seek(int(Gff(this.root).file.gff3.header.fieldIndicesOffset + this.entry.dataOrOffset))
    for i in 0 ..< int(this.entry.fieldCount):
      let it = this.io.readU4le()
      this.fieldIndicesInst.add(it)
    this.io.seek(pos)
  this.fieldIndicesInstFlag = true
  return this.fieldIndicesInst

proc fields(this: Gff_ResolvedStruct): seq[Gff_ResolvedField] = 

  ##[
  One `resolved_field` per entry in `field_indices`.

  ]##
  if this.fieldsInstFlag:
    return this.fieldsInst
  if this.entry.fieldCount > 1:
    for i in 0 ..< int(this.entry.fieldCount):
      let it = Gff_ResolvedField.read(this.io, this.root, this, this.fieldIndices[i])
      this.fieldsInst.add(it)
  this.fieldsInstFlag = true
  return this.fieldsInst

proc singleField(this: Gff_ResolvedStruct): Gff_ResolvedField = 

  ##[
  `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).

  ]##
  if this.singleFieldInstFlag:
    return this.singleFieldInst
  if this.entry.fieldCount == 1:
    let singleFieldInstExpr = Gff_ResolvedField.read(this.io, this.root, this, this.entry.dataOrOffset)
    this.singleFieldInst = singleFieldInstExpr
  this.singleFieldInstFlag = true
  return this.singleFieldInst

proc fromFile*(_: typedesc[Gff_ResolvedStruct], filename: string): Gff_ResolvedStruct =
  Gff_ResolvedStruct.read(newKaitaiFileStream(filename), nil, nil)


##[
Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Ghidra name `GFFStructData`.
Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51

]##
proc read*(_: typedesc[Gff_StructArray], io: KaitaiStream, root: KaitaiStruct, parent: Gff_Gff3AfterAurora): Gff_StructArray =
  template this: untyped = result
  this = new(Gff_StructArray)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
Stride 12 bytes per struct (matches Ghidra component sizes).

  ]##
  for i in 0 ..< int(Gff(this.root).file.gff3.header.structCount):
    let it = Gff_StructEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Gff_StructArray], filename: string): Gff_StructArray =
  Gff_StructArray.read(newKaitaiFileStream(filename), nil, nil)


##[
One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.

]##
proc read*(_: typedesc[Gff_StructEntry], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Gff_StructEntry =
  template this: untyped = result
  this = new(Gff_StructEntry)
  let root = if root == nil: cast[Gff](this) else: cast[Gff](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Structure type identifier.
Source: Ghidra `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.

  ]##
  let structIdExpr = this.io.readU4le()
  this.structId = structIdExpr

  ##[
  Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
If field_count == 0, this value is unused.
Source: Ghidra `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).

  ]##
  let dataOrOffsetExpr = this.io.readU4le()
  this.dataOrOffset = dataOrOffsetExpr

  ##[
  Number of fields in this struct:
- 0: No fields
- 1: Single field, data_or_offset contains the field index directly
- >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
Source: Ghidra `GFFStructData.field_count` @ +0x8 (ulong).

  ]##
  let fieldCountExpr = this.io.readU4le()
  this.fieldCount = fieldCountExpr

proc fieldIndicesOffset(this: Gff_StructEntry): uint32 = 

  ##[
  Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.

  ]##
  if this.fieldIndicesOffsetInstFlag:
    return this.fieldIndicesOffsetInst
  if this.hasMultipleFields:
    let fieldIndicesOffsetInstExpr = uint32(this.dataOrOffset)
    this.fieldIndicesOffsetInst = fieldIndicesOffsetInstExpr
  this.fieldIndicesOffsetInstFlag = true
  return this.fieldIndicesOffsetInst

proc hasMultipleFields(this: Gff_StructEntry): bool = 

  ##[
  Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.

  ]##
  if this.hasMultipleFieldsInstFlag:
    return this.hasMultipleFieldsInst
  let hasMultipleFieldsInstExpr = bool(this.fieldCount > 1)
  this.hasMultipleFieldsInst = hasMultipleFieldsInstExpr
  this.hasMultipleFieldsInstFlag = true
  return this.hasMultipleFieldsInst

proc hasSingleField(this: Gff_StructEntry): bool = 

  ##[
  Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array

  ]##
  if this.hasSingleFieldInstFlag:
    return this.hasSingleFieldInst
  let hasSingleFieldInstExpr = bool(this.fieldCount == 1)
  this.hasSingleFieldInst = hasSingleFieldInstExpr
  this.hasSingleFieldInstFlag = true
  return this.hasSingleFieldInst

proc singleFieldIndex(this: Gff_StructEntry): uint32 = 

  ##[
  Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.

  ]##
  if this.singleFieldIndexInstFlag:
    return this.singleFieldIndexInst
  if this.hasSingleField:
    let singleFieldIndexInstExpr = uint32(this.dataOrOffset)
    this.singleFieldIndexInst = singleFieldIndexInstExpr
  this.singleFieldIndexInstFlag = true
  return this.singleFieldIndexInst

proc fromFile*(_: typedesc[Gff_StructEntry], filename: string): Gff_StructEntry =
  Gff_StructEntry.read(newKaitaiFileStream(filename), nil, nil)

