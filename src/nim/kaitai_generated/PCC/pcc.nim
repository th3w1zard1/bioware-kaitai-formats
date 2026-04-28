import kaitai_struct_nim_runtime
import options
import bioware_common

type
  Pcc* = ref object of KaitaiStruct
    `header`*: Pcc_FileHeader
    `parent`*: KaitaiStruct
    `compressionTypeInst`: BiowareCommon_BiowarePccCompressionCodec
    `compressionTypeInstFlag`: bool
    `exportTableInst`: Pcc_ExportTable
    `exportTableInstFlag`: bool
    `importTableInst`: Pcc_ImportTable
    `importTableInstFlag`: bool
    `isCompressedInst`: bool
    `isCompressedInstFlag`: bool
    `nameTableInst`: Pcc_NameTable
    `nameTableInstFlag`: bool
  Pcc_ExportEntry* = ref object of KaitaiStruct
    `classIndex`*: int32
    `superClassIndex`*: int32
    `link`*: int32
    `objectNameIndex`*: int32
    `objectNameNumber`*: int32
    `archetypeIndex`*: int32
    `objectFlags`*: uint64
    `dataSize`*: uint32
    `dataOffset`*: uint32
    `unknown1`*: uint32
    `numComponents`*: int32
    `unknown2`*: uint32
    `guid`*: Pcc_Guid
    `components`*: seq[int32]
    `parent`*: Pcc_ExportTable
  Pcc_ExportTable* = ref object of KaitaiStruct
    `entries`*: seq[Pcc_ExportEntry]
    `parent`*: Pcc
  Pcc_FileHeader* = ref object of KaitaiStruct
    `magic`*: uint32
    `version`*: uint32
    `licenseeVersion`*: uint32
    `headerSize`*: int32
    `packageName`*: string
    `packageFlags`*: uint32
    `packageType`*: BiowareCommon_BiowarePccPackageKind
    `nameCount`*: uint32
    `nameTableOffset`*: uint32
    `exportCount`*: uint32
    `exportTableOffset`*: uint32
    `importCount`*: uint32
    `importTableOffset`*: uint32
    `dependOffset`*: uint32
    `dependCount`*: uint32
    `guidPart1`*: uint32
    `guidPart2`*: uint32
    `guidPart3`*: uint32
    `guidPart4`*: uint32
    `generations`*: uint32
    `exportCountDup`*: uint32
    `nameCountDup`*: uint32
    `unknown1`*: uint32
    `engineVersion`*: uint32
    `cookerVersion`*: uint32
    `compressionFlags`*: uint32
    `packageSource`*: uint32
    `compressionType`*: BiowareCommon_BiowarePccCompressionCodec
    `chunkCount`*: uint32
    `parent`*: Pcc
  Pcc_Guid* = ref object of KaitaiStruct
    `part1`*: uint32
    `part2`*: uint32
    `part3`*: uint32
    `part4`*: uint32
    `parent`*: Pcc_ExportEntry
  Pcc_ImportEntry* = ref object of KaitaiStruct
    `packageNameIndex`*: int64
    `classNameIndex`*: int32
    `link`*: int64
    `importNameIndex`*: int64
    `parent`*: Pcc_ImportTable
  Pcc_ImportTable* = ref object of KaitaiStruct
    `entries`*: seq[Pcc_ImportEntry]
    `parent`*: Pcc
  Pcc_NameEntry* = ref object of KaitaiStruct
    `length`*: int32
    `name`*: string
    `parent`*: Pcc_NameTable
    `absLengthInst`: int
    `absLengthInstFlag`: bool
    `nameSizeInst`: int
    `nameSizeInstFlag`: bool
  Pcc_NameTable* = ref object of KaitaiStruct
    `entries`*: seq[Pcc_NameEntry]
    `parent`*: Pcc

proc read*(_: typedesc[Pcc], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Pcc
proc read*(_: typedesc[Pcc_ExportEntry], io: KaitaiStream, root: KaitaiStruct, parent: Pcc_ExportTable): Pcc_ExportEntry
proc read*(_: typedesc[Pcc_ExportTable], io: KaitaiStream, root: KaitaiStruct, parent: Pcc): Pcc_ExportTable
proc read*(_: typedesc[Pcc_FileHeader], io: KaitaiStream, root: KaitaiStruct, parent: Pcc): Pcc_FileHeader
proc read*(_: typedesc[Pcc_Guid], io: KaitaiStream, root: KaitaiStruct, parent: Pcc_ExportEntry): Pcc_Guid
proc read*(_: typedesc[Pcc_ImportEntry], io: KaitaiStream, root: KaitaiStruct, parent: Pcc_ImportTable): Pcc_ImportEntry
proc read*(_: typedesc[Pcc_ImportTable], io: KaitaiStream, root: KaitaiStruct, parent: Pcc): Pcc_ImportTable
proc read*(_: typedesc[Pcc_NameEntry], io: KaitaiStream, root: KaitaiStruct, parent: Pcc_NameTable): Pcc_NameEntry
proc read*(_: typedesc[Pcc_NameTable], io: KaitaiStream, root: KaitaiStruct, parent: Pcc): Pcc_NameTable

proc compressionType*(this: Pcc): BiowareCommon_BiowarePccCompressionCodec
proc exportTable*(this: Pcc): Pcc_ExportTable
proc importTable*(this: Pcc): Pcc_ImportTable
proc isCompressed*(this: Pcc): bool
proc nameTable*(this: Pcc): Pcc_NameTable
proc absLength*(this: Pcc_NameEntry): int
proc nameSize*(this: Pcc_NameEntry): int


##[
**PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).

**Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60">xoreos — `FileType` enum start (Aurora/BioWare family IDs; **PCC/Unreal packages are not in this table** — included only as canonical upstream anchor for “what this repo’s xoreos stack is”)</a>
@see <a href="https://github.com/ME3Tweaks/LegendaryExplorer/wiki/PCC-File-Format">ME3Tweaks — PCC file format</a>
@see <a href="https://github.com/ME3Tweaks/LegendaryExplorer/wiki/Package-Handling">ME3Tweaks — Package handling (export/import tables, UE3-era BioWare packages)</a>
@see <a href="https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/docs/XOREOS_FORMAT_COVERAGE.md">In-tree — coverage matrix (PCC is out-of-xoreos Aurora scope; see table)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (KotOR-era PDFs; PCC is Mass Effect / UE3 — use LegendaryExplorer wiki as wire authority)</a>
]##
proc read*(_: typedesc[Pcc], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Pcc =
  template this: untyped = result
  this = new(Pcc)
  let root = if root == nil: cast[Pcc](this) else: cast[Pcc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File header containing format metadata and table offsets.
  ]##
  let headerExpr = Pcc_FileHeader.read(this.io, this.root, this)
  this.header = headerExpr

proc compressionType(this: Pcc): BiowareCommon_BiowarePccCompressionCodec = 

  ##[
  Compression algorithm used (0=None, 1=Zlib, 2=LZO).
  ]##
  if this.compressionTypeInstFlag:
    return this.compressionTypeInst
  let compressionTypeInstExpr = BiowareCommon_BiowarePccCompressionCodec(this.header.compressionType)
  this.compressionTypeInst = compressionTypeInstExpr
  this.compressionTypeInstFlag = true
  return this.compressionTypeInst

proc exportTable(this: Pcc): Pcc_ExportTable = 

  ##[
  Table containing all objects exported from this package.
  ]##
  if this.exportTableInstFlag:
    return this.exportTableInst
  if this.header.exportCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.exportTableOffset))
    let exportTableInstExpr = Pcc_ExportTable.read(this.io, this.root, this)
    this.exportTableInst = exportTableInstExpr
    this.io.seek(pos)
  this.exportTableInstFlag = true
  return this.exportTableInst

proc importTable(this: Pcc): Pcc_ImportTable = 

  ##[
  Table containing references to external packages and classes.
  ]##
  if this.importTableInstFlag:
    return this.importTableInst
  if this.header.importCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.importTableOffset))
    let importTableInstExpr = Pcc_ImportTable.read(this.io, this.root, this)
    this.importTableInst = importTableInstExpr
    this.io.seek(pos)
  this.importTableInstFlag = true
  return this.importTableInst

proc isCompressed(this: Pcc): bool = 

  ##[
  True if package uses compressed chunks (bit 25 of package_flags).
  ]##
  if this.isCompressedInstFlag:
    return this.isCompressedInst
  let isCompressedInstExpr = bool((this.header.packageFlags and 33554432) != 0)
  this.isCompressedInst = isCompressedInstExpr
  this.isCompressedInstFlag = true
  return this.isCompressedInst

proc nameTable(this: Pcc): Pcc_NameTable = 

  ##[
  Table containing all string names used in the package.
  ]##
  if this.nameTableInstFlag:
    return this.nameTableInst
  if this.header.nameCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.nameTableOffset))
    let nameTableInstExpr = Pcc_NameTable.read(this.io, this.root, this)
    this.nameTableInst = nameTableInstExpr
    this.io.seek(pos)
  this.nameTableInstFlag = true
  return this.nameTableInst

proc fromFile*(_: typedesc[Pcc], filename: string): Pcc =
  Pcc.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Pcc_ExportEntry], io: KaitaiStream, root: KaitaiStruct, parent: Pcc_ExportTable): Pcc_ExportEntry =
  template this: untyped = result
  this = new(Pcc_ExportEntry)
  let root = if root == nil: cast[Pcc](this) else: cast[Pcc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Object index for the class.
Negative = import table index
Positive = export table index
Zero = no class

  ]##
  let classIndexExpr = this.io.readS4le()
  this.classIndex = classIndexExpr

  ##[
  Object index for the super class.
Negative = import table index
Positive = export table index
Zero = no super class

  ]##
  let superClassIndexExpr = this.io.readS4le()
  this.superClassIndex = superClassIndexExpr

  ##[
  Link to other objects (internal reference).
  ]##
  let linkExpr = this.io.readS4le()
  this.link = linkExpr

  ##[
  Index into name table for the object name.
  ]##
  let objectNameIndexExpr = this.io.readS4le()
  this.objectNameIndex = objectNameIndexExpr

  ##[
  Object name number (for duplicate names).
  ]##
  let objectNameNumberExpr = this.io.readS4le()
  this.objectNameNumber = objectNameNumberExpr

  ##[
  Object index for the archetype.
Negative = import table index
Positive = export table index
Zero = no archetype

  ]##
  let archetypeIndexExpr = this.io.readS4le()
  this.archetypeIndex = archetypeIndexExpr

  ##[
  Object flags bitfield (64-bit).
  ]##
  let objectFlagsExpr = this.io.readU8le()
  this.objectFlags = objectFlagsExpr

  ##[
  Size of the export data in bytes.
  ]##
  let dataSizeExpr = this.io.readU4le()
  this.dataSize = dataSizeExpr

  ##[
  Byte offset to the export data from the beginning of the file.
  ]##
  let dataOffsetExpr = this.io.readU4le()
  this.dataOffset = dataOffsetExpr

  ##[
  Unknown field.
  ]##
  let unknown1Expr = this.io.readU4le()
  this.unknown1 = unknown1Expr

  ##[
  Number of component entries (can be negative).
  ]##
  let numComponentsExpr = this.io.readS4le()
  this.numComponents = numComponentsExpr

  ##[
  Unknown field.
  ]##
  let unknown2Expr = this.io.readU4le()
  this.unknown2 = unknown2Expr

  ##[
  GUID for this export object.
  ]##
  let guidExpr = Pcc_Guid.read(this.io, this.root, this)
  this.guid = guidExpr

  ##[
  Array of component indices.
Only present if num_components > 0.

  ]##
  if this.numComponents > 0:
    for i in 0 ..< int(this.numComponents):
      let it = this.io.readS4le()
      this.components.add(it)

proc fromFile*(_: typedesc[Pcc_ExportEntry], filename: string): Pcc_ExportEntry =
  Pcc_ExportEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Pcc_ExportTable], io: KaitaiStream, root: KaitaiStruct, parent: Pcc): Pcc_ExportTable =
  template this: untyped = result
  this = new(Pcc_ExportTable)
  let root = if root == nil: cast[Pcc](this) else: cast[Pcc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of export entries.
  ]##
  for i in 0 ..< int(Pcc(this.root).header.exportCount):
    let it = Pcc_ExportEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Pcc_ExportTable], filename: string): Pcc_ExportTable =
  Pcc_ExportTable.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Pcc_FileHeader], io: KaitaiStream, root: KaitaiStruct, parent: Pcc): Pcc_FileHeader =
  template this: untyped = result
  this = new(Pcc_FileHeader)
  let root = if root == nil: cast[Pcc](this) else: cast[Pcc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Magic number identifying PCC format. Must be 0x9E2A83C1.
  ]##
  let magicExpr = this.io.readU4le()
  this.magic = magicExpr

  ##[
  File format version.
Encoded as: (major << 16) | (minor << 8) | patch
Example: 0xC202AC = 194/684 (major=194, minor=684)

  ]##
  let versionExpr = this.io.readU4le()
  this.version = versionExpr

  ##[
  Licensee-specific version field (typically 0x67C).
  ]##
  let licenseeVersionExpr = this.io.readU4le()
  this.licenseeVersion = licenseeVersionExpr

  ##[
  Header size field (typically -5 = 0xFFFFFFFB).
  ]##
  let headerSizeExpr = this.io.readS4le()
  this.headerSize = headerSizeExpr

  ##[
  Package name (typically "None" = 0x4E006F006E006500).
  ]##
  let packageNameExpr = encode(this.io.readBytes(int(10)), "UTF-16LE")
  this.packageName = packageNameExpr

  ##[
  Package flags bitfield.
Bit 25 (0x2000000): Compressed package
Bit 20 (0x100000): ME3Explorer edited format flag
Other bits: Various package attributes

  ]##
  let packageFlagsExpr = this.io.readU4le()
  this.packageFlags = packageFlagsExpr

  ##[
  Package type indicator (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_package_kind`
(LegendaryExplorer PCC wiki).

  ]##
  let packageTypeExpr = BiowareCommon_BiowarePccPackageKind(this.io.readU4le())
  this.packageType = packageTypeExpr

  ##[
  Number of entries in the name table.
  ]##
  let nameCountExpr = this.io.readU4le()
  this.nameCount = nameCountExpr

  ##[
  Byte offset to the name table from the beginning of the file.
  ]##
  let nameTableOffsetExpr = this.io.readU4le()
  this.nameTableOffset = nameTableOffsetExpr

  ##[
  Number of entries in the export table.
  ]##
  let exportCountExpr = this.io.readU4le()
  this.exportCount = exportCountExpr

  ##[
  Byte offset to the export table from the beginning of the file.
  ]##
  let exportTableOffsetExpr = this.io.readU4le()
  this.exportTableOffset = exportTableOffsetExpr

  ##[
  Number of entries in the import table.
  ]##
  let importCountExpr = this.io.readU4le()
  this.importCount = importCountExpr

  ##[
  Byte offset to the import table from the beginning of the file.
  ]##
  let importTableOffsetExpr = this.io.readU4le()
  this.importTableOffset = importTableOffsetExpr

  ##[
  Offset to dependency table (typically 0x664).
  ]##
  let dependOffsetExpr = this.io.readU4le()
  this.dependOffset = dependOffsetExpr

  ##[
  Number of dependencies (typically 0x67C).
  ]##
  let dependCountExpr = this.io.readU4le()
  this.dependCount = dependCountExpr

  ##[
  First 32 bits of package GUID.
  ]##
  let guidPart1Expr = this.io.readU4le()
  this.guidPart1 = guidPart1Expr

  ##[
  Second 32 bits of package GUID.
  ]##
  let guidPart2Expr = this.io.readU4le()
  this.guidPart2 = guidPart2Expr

  ##[
  Third 32 bits of package GUID.
  ]##
  let guidPart3Expr = this.io.readU4le()
  this.guidPart3 = guidPart3Expr

  ##[
  Fourth 32 bits of package GUID.
  ]##
  let guidPart4Expr = this.io.readU4le()
  this.guidPart4 = guidPart4Expr

  ##[
  Number of generation entries.
  ]##
  let generationsExpr = this.io.readU4le()
  this.generations = generationsExpr

  ##[
  Duplicate export count (should match export_count).
  ]##
  let exportCountDupExpr = this.io.readU4le()
  this.exportCountDup = exportCountDupExpr

  ##[
  Duplicate name count (should match name_count).
  ]##
  let nameCountDupExpr = this.io.readU4le()
  this.nameCountDup = nameCountDupExpr

  ##[
  Unknown field (typically 0x0).
  ]##
  let unknown1Expr = this.io.readU4le()
  this.unknown1 = unknown1Expr

  ##[
  Engine version (typically 0x18EF = 6383).
  ]##
  let engineVersionExpr = this.io.readU4le()
  this.engineVersion = engineVersionExpr

  ##[
  Cooker version (typically 0x3006B = 196715).
  ]##
  let cookerVersionExpr = this.io.readU4le()
  this.cookerVersion = cookerVersionExpr

  ##[
  Compression flags (typically 0x15330000).
  ]##
  let compressionFlagsExpr = this.io.readU4le()
  this.compressionFlags = compressionFlagsExpr

  ##[
  Package source identifier (typically 0x8AA0000).
  ]##
  let packageSourceExpr = this.io.readU4le()
  this.packageSource = packageSourceExpr

  ##[
  Compression codec when package is compressed (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_compression_codec`
(LegendaryExplorer PCC wiki). Unused / undefined when uncompressed.

  ]##
  let compressionTypeExpr = BiowareCommon_BiowarePccCompressionCodec(this.io.readU4le())
  this.compressionType = compressionTypeExpr

  ##[
  Number of compressed chunks (0 for uncompressed, 1 for compressed).
If > 0, file uses compressed structure with chunks.

  ]##
  let chunkCountExpr = this.io.readU4le()
  this.chunkCount = chunkCountExpr

proc fromFile*(_: typedesc[Pcc_FileHeader], filename: string): Pcc_FileHeader =
  Pcc_FileHeader.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Pcc_Guid], io: KaitaiStream, root: KaitaiStruct, parent: Pcc_ExportEntry): Pcc_Guid =
  template this: untyped = result
  this = new(Pcc_Guid)
  let root = if root == nil: cast[Pcc](this) else: cast[Pcc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  First 32 bits of GUID.
  ]##
  let part1Expr = this.io.readU4le()
  this.part1 = part1Expr

  ##[
  Second 32 bits of GUID.
  ]##
  let part2Expr = this.io.readU4le()
  this.part2 = part2Expr

  ##[
  Third 32 bits of GUID.
  ]##
  let part3Expr = this.io.readU4le()
  this.part3 = part3Expr

  ##[
  Fourth 32 bits of GUID.
  ]##
  let part4Expr = this.io.readU4le()
  this.part4 = part4Expr

proc fromFile*(_: typedesc[Pcc_Guid], filename: string): Pcc_Guid =
  Pcc_Guid.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Pcc_ImportEntry], io: KaitaiStream, root: KaitaiStruct, parent: Pcc_ImportTable): Pcc_ImportEntry =
  template this: untyped = result
  this = new(Pcc_ImportEntry)
  let root = if root == nil: cast[Pcc](this) else: cast[Pcc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Index into name table for package name.
Negative value indicates import from external package.
Positive value indicates import from this package.

  ]##
  let packageNameIndexExpr = this.io.readS8le()
  this.packageNameIndex = packageNameIndexExpr

  ##[
  Index into name table for class name.
  ]##
  let classNameIndexExpr = this.io.readS4le()
  this.classNameIndex = classNameIndexExpr

  ##[
  Link to import/export table entry.
Used to resolve the actual object reference.

  ]##
  let linkExpr = this.io.readS8le()
  this.link = linkExpr

  ##[
  Index into name table for the imported object name.
  ]##
  let importNameIndexExpr = this.io.readS8le()
  this.importNameIndex = importNameIndexExpr

proc fromFile*(_: typedesc[Pcc_ImportEntry], filename: string): Pcc_ImportEntry =
  Pcc_ImportEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Pcc_ImportTable], io: KaitaiStream, root: KaitaiStruct, parent: Pcc): Pcc_ImportTable =
  template this: untyped = result
  this = new(Pcc_ImportTable)
  let root = if root == nil: cast[Pcc](this) else: cast[Pcc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of import entries.
  ]##
  for i in 0 ..< int(Pcc(this.root).header.importCount):
    let it = Pcc_ImportEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Pcc_ImportTable], filename: string): Pcc_ImportTable =
  Pcc_ImportTable.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Pcc_NameEntry], io: KaitaiStream, root: KaitaiStruct, parent: Pcc_NameTable): Pcc_NameEntry =
  template this: untyped = result
  this = new(Pcc_NameEntry)
  let root = if root == nil: cast[Pcc](this) else: cast[Pcc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Length of the name string in characters (signed).
Negative value indicates the number of WCHAR characters.
Positive value is also valid but less common.

  ]##
  let lengthExpr = this.io.readS4le()
  this.length = lengthExpr

  ##[
  Name string encoded as UTF-16LE (WCHAR).
Size is absolute value of length * 2 bytes per character.
Negative length indicates WCHAR count (use absolute value).

  ]##
  let nameExpr = encode(this.io.readBytes(int((if this.length < 0: -(this.length) else: this.length) * 2)), "UTF-16LE")
  this.name = nameExpr

proc absLength(this: Pcc_NameEntry): int = 

  ##[
  Absolute value of length for size calculation
  ]##
  if this.absLengthInstFlag:
    return this.absLengthInst
  let absLengthInstExpr = int((if this.length < 0: -(this.length) else: this.length))
  this.absLengthInst = absLengthInstExpr
  this.absLengthInstFlag = true
  return this.absLengthInst

proc nameSize(this: Pcc_NameEntry): int = 

  ##[
  Size of name string in bytes (absolute length * 2 bytes per WCHAR)
  ]##
  if this.nameSizeInstFlag:
    return this.nameSizeInst
  let nameSizeInstExpr = int(this.absLength * 2)
  this.nameSizeInst = nameSizeInstExpr
  this.nameSizeInstFlag = true
  return this.nameSizeInst

proc fromFile*(_: typedesc[Pcc_NameEntry], filename: string): Pcc_NameEntry =
  Pcc_NameEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Pcc_NameTable], io: KaitaiStream, root: KaitaiStruct, parent: Pcc): Pcc_NameTable =
  template this: untyped = result
  this = new(Pcc_NameTable)
  let root = if root == nil: cast[Pcc](this) else: cast[Pcc](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of name entries.
  ]##
  for i in 0 ..< int(Pcc(this.root).header.nameCount):
    let it = Pcc_NameEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Pcc_NameTable], filename: string): Pcc_NameTable =
  Pcc_NameTable.read(newKaitaiFileStream(filename), nil, nil)

