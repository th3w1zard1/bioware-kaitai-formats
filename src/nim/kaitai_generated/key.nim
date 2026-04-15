import kaitai_struct_nim_runtime
import options
import bioware_type_ids

type
  Key* = ref object of KaitaiStruct
    `fileType`*: string
    `fileVersion`*: string
    `bifCount`*: uint32
    `keyCount`*: uint32
    `fileTableOffset`*: uint32
    `keyTableOffset`*: uint32
    `buildYear`*: uint32
    `buildDay`*: uint32
    `reserved`*: seq[byte]
    `parent`*: KaitaiStruct
    `fileTableInst`: Key_FileTable
    `fileTableInstFlag`: bool
    `keyTableInst`: Key_KeyTable
    `keyTableInstFlag`: bool
  Key_FileEntry* = ref object of KaitaiStruct
    `fileSize`*: uint32
    `filenameOffset`*: uint32
    `filenameSize`*: uint16
    `drives`*: uint16
    `parent`*: Key_FileTable
    `filenameInst`: string
    `filenameInstFlag`: bool
  Key_FileTable* = ref object of KaitaiStruct
    `entries`*: seq[Key_FileEntry]
    `parent`*: Key
  Key_FilenameTable* = ref object of KaitaiStruct
    `filenames`*: string
    `parent`*: KaitaiStruct
  Key_KeyEntry* = ref object of KaitaiStruct
    `resref`*: string
    `resourceType`*: BiowareTypeIds_XoreosFileTypeId
    `resourceId`*: uint32
    `parent`*: Key_KeyTable
  Key_KeyTable* = ref object of KaitaiStruct
    `entries`*: seq[Key_KeyEntry]
    `parent`*: Key

proc read*(_: typedesc[Key], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Key
proc read*(_: typedesc[Key_FileEntry], io: KaitaiStream, root: KaitaiStruct, parent: Key_FileTable): Key_FileEntry
proc read*(_: typedesc[Key_FileTable], io: KaitaiStream, root: KaitaiStruct, parent: Key): Key_FileTable
proc read*(_: typedesc[Key_FilenameTable], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Key_FilenameTable
proc read*(_: typedesc[Key_KeyEntry], io: KaitaiStream, root: KaitaiStruct, parent: Key_KeyTable): Key_KeyEntry
proc read*(_: typedesc[Key_KeyTable], io: KaitaiStream, root: KaitaiStruct, parent: Key): Key_KeyTable

proc fileTable*(this: Key): Key_FileTable
proc keyTable*(this: Key): Key_KeyTable
proc filename*(this: Key_FileEntry): string


##[
**KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
Resource types use `bioware_type_ids`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key">PyKotor wiki — KEY</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp#L50-L88">xoreos — KEY::load</a>
]##
proc read*(_: typedesc[Key], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Key =
  template this: untyped = result
  this = new(Key)
  let root = if root == nil: cast[Key](this) else: cast[Key](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "KEY " (space-padded).
  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Typically "V1  " or "V1.1".
  ]##
  let fileVersionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileVersion = fileVersionExpr

  ##[
  Number of BIF files referenced by this KEY file.
  ]##
  let bifCountExpr = this.io.readU4le()
  this.bifCount = bifCountExpr

  ##[
  Number of resource entries in the KEY table.
  ]##
  let keyCountExpr = this.io.readU4le()
  this.keyCount = keyCountExpr

  ##[
  Byte offset to the file table from the beginning of the file.
  ]##
  let fileTableOffsetExpr = this.io.readU4le()
  this.fileTableOffset = fileTableOffsetExpr

  ##[
  Byte offset to the KEY table from the beginning of the file.
  ]##
  let keyTableOffsetExpr = this.io.readU4le()
  this.keyTableOffset = keyTableOffsetExpr

  ##[
  Build year (years since 1900).
  ]##
  let buildYearExpr = this.io.readU4le()
  this.buildYear = buildYearExpr

  ##[
  Build day (days since January 1).
  ]##
  let buildDayExpr = this.io.readU4le()
  this.buildDay = buildDayExpr

  ##[
  Reserved padding (usually zeros).
  ]##
  let reservedExpr = this.io.readBytes(int(32))
  this.reserved = reservedExpr

proc fileTable(this: Key): Key_FileTable = 

  ##[
  File table containing BIF file entries.
  ]##
  if this.fileTableInstFlag:
    return this.fileTableInst
  if this.bifCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.fileTableOffset))
    let fileTableInstExpr = Key_FileTable.read(this.io, this.root, this)
    this.fileTableInst = fileTableInstExpr
    this.io.seek(pos)
  this.fileTableInstFlag = true
  return this.fileTableInst

proc keyTable(this: Key): Key_KeyTable = 

  ##[
  KEY table containing resource entries.
  ]##
  if this.keyTableInstFlag:
    return this.keyTableInst
  if this.keyCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.keyTableOffset))
    let keyTableInstExpr = Key_KeyTable.read(this.io, this.root, this)
    this.keyTableInst = keyTableInstExpr
    this.io.seek(pos)
  this.keyTableInstFlag = true
  return this.keyTableInst

proc fromFile*(_: typedesc[Key], filename: string): Key =
  Key.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Key_FileEntry], io: KaitaiStream, root: KaitaiStruct, parent: Key_FileTable): Key_FileEntry =
  template this: untyped = result
  this = new(Key_FileEntry)
  let root = if root == nil: cast[Key](this) else: cast[Key](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Size of the BIF file on disk in bytes.
  ]##
  let fileSizeExpr = this.io.readU4le()
  this.fileSize = fileSizeExpr

  ##[
  Absolute byte offset from the start of the KEY file where this BIF's filename is stored
(seek(filename_offset), then read filename_size bytes).
This is not relative to the file table or to the end of the BIF entry array.

  ]##
  let filenameOffsetExpr = this.io.readU4le()
  this.filenameOffset = filenameOffsetExpr

  ##[
  Length of the filename in bytes (including null terminator).
  ]##
  let filenameSizeExpr = this.io.readU2le()
  this.filenameSize = filenameSizeExpr

  ##[
  Drive flags indicating which media contains the BIF file.
Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
Modern distributions typically use 0x0001 (HD) for all files.

  ]##
  let drivesExpr = this.io.readU2le()
  this.drives = drivesExpr

proc filename(this: Key_FileEntry): string = 

  ##[
  BIF filename string at the absolute filename_offset in the KEY file.
  ]##
  if this.filenameInstFlag:
    return this.filenameInst
  let pos = this.io.pos()
  this.io.seek(int(this.filenameOffset))
  let filenameInstExpr = encode(this.io.readBytes(int(this.filenameSize)), "ASCII")
  this.filenameInst = filenameInstExpr
  this.io.seek(pos)
  this.filenameInstFlag = true
  return this.filenameInst

proc fromFile*(_: typedesc[Key_FileEntry], filename: string): Key_FileEntry =
  Key_FileEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Key_FileTable], io: KaitaiStream, root: KaitaiStruct, parent: Key): Key_FileTable =
  template this: untyped = result
  this = new(Key_FileTable)
  let root = if root == nil: cast[Key](this) else: cast[Key](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of BIF file entries.
  ]##
  for i in 0 ..< int(Key(this.root).bifCount):
    let it = Key_FileEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Key_FileTable], filename: string): Key_FileTable =
  Key_FileTable.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Key_FilenameTable], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Key_FilenameTable =
  template this: untyped = result
  this = new(Key_FilenameTable)
  let root = if root == nil: cast[Key](this) else: cast[Key](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Null-terminated BIF filenames concatenated together.
Each filename is read using the filename_offset and filename_size
from the corresponding file_entry.

  ]##
  let filenamesExpr = encode(this.io.readBytesFull(), "ASCII")
  this.filenames = filenamesExpr

proc fromFile*(_: typedesc[Key_FilenameTable], filename: string): Key_FilenameTable =
  Key_FilenameTable.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Key_KeyEntry], io: KaitaiStream, root: KaitaiStruct, parent: Key_KeyTable): Key_KeyEntry =
  template this: untyped = result
  this = new(Key_KeyEntry)
  let root = if root == nil: cast[Key](this) else: cast[Key](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Resource filename (ResRef) without extension.
Null-padded, maximum 16 characters.
The game uses this name to access the resource.

  ]##
  let resrefExpr = encode(this.io.readBytes(int(16)), "ASCII")
  this.resref = resrefExpr

  ##[
  Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
`formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).

  ]##
  let resourceTypeExpr = BiowareTypeIds_XoreosFileTypeId(this.io.readU2le())
  this.resourceType = resourceTypeExpr

  ##[
  Encoded resource location.
Bits 31-20: BIF index (top 12 bits) - index into file table
Bits 19-0: Resource index (bottom 20 bits) - index within the BIF file

Formula: resource_id = (bif_index << 20) | resource_index

Decoding:
- bif_index = (resource_id >> 20) & 0xFFF
- resource_index = resource_id & 0xFFFFF

  ]##
  let resourceIdExpr = this.io.readU4le()
  this.resourceId = resourceIdExpr

proc fromFile*(_: typedesc[Key_KeyEntry], filename: string): Key_KeyEntry =
  Key_KeyEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Key_KeyTable], io: KaitaiStream, root: KaitaiStruct, parent: Key): Key_KeyTable =
  template this: untyped = result
  this = new(Key_KeyTable)
  let root = if root == nil: cast[Key](this) else: cast[Key](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of resource entries.
  ]##
  for i in 0 ..< int(Key(this.root).keyCount):
    let it = Key_KeyEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Key_KeyTable], filename: string): Key_KeyTable =
  Key_KeyTable.read(newKaitaiFileStream(filename), nil, nil)

