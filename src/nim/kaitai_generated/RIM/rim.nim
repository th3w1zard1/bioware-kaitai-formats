import kaitai_struct_nim_runtime
import options
import bioware_type_ids

type
  Rim* = ref object of KaitaiStruct
    `header`*: Rim_RimHeader
    `gapBeforeKeyTableImplicit`*: seq[byte]
    `gapBeforeKeyTableExplicit`*: seq[byte]
    `resourceEntryTable`*: Rim_ResourceEntryTable
    `parent`*: KaitaiStruct
  Rim_ResourceEntry* = ref object of KaitaiStruct
    `resref`*: string
    `resourceType`*: BiowareTypeIds_XoreosFileTypeId
    `resourceId`*: uint32
    `offsetToData`*: uint32
    `numData`*: uint32
    `parent`*: Rim_ResourceEntryTable
    `dataInst`: seq[uint8]
    `dataInstFlag`: bool
  Rim_ResourceEntryTable* = ref object of KaitaiStruct
    `entries`*: seq[Rim_ResourceEntry]
    `parent`*: Rim
  Rim_RimHeader* = ref object of KaitaiStruct
    `fileType`*: string
    `fileVersion`*: string
    `reserved`*: uint32
    `resourceCount`*: uint32
    `offsetToResourceTable`*: uint32
    `offsetToResources`*: uint32
    `parent`*: Rim
    `hasResourcesInst`: bool
    `hasResourcesInstFlag`: bool

proc read*(_: typedesc[Rim], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Rim
proc read*(_: typedesc[Rim_ResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Rim_ResourceEntryTable): Rim_ResourceEntry
proc read*(_: typedesc[Rim_ResourceEntryTable], io: KaitaiStream, root: KaitaiStruct, parent: Rim): Rim_ResourceEntryTable
proc read*(_: typedesc[Rim_RimHeader], io: KaitaiStream, root: KaitaiStruct, parent: Rim): Rim_RimHeader

proc data*(this: Rim_ResourceEntry): seq[uint8]
proc hasResources*(this: Rim_RimHeader): bool


##[
RIM (Resource Information Manager) files are self-contained archives used for module templates.
RIM files are similar to ERF files but are read-only from the game's perspective. The game
loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
RIM files store all resources inline with metadata, making them self-contained archives.

Format Variants:
- Standard RIM: Basic module template files
- Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs

Binary Format (KotOR / PyKotor):
- Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
- Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
- Key / resource entry table (32 bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
- Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)

Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim">PyKotor wiki — RIM</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128">PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L35-L91">xoreos — `RIMFile::load` + `readResList`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unrim.cpp#L55-L85">xoreos-tools — `unrim` CLI (`main`)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/rim.cpp#L43-L84">xoreos-tools — `rim` packer CLI (`main`)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html">xoreos-docs — Torlack mod.html (MOD/RIM family)</a>
@see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/RIMObject.ts#L69-L93">KotOR.js — `RIMObject`</a>
@see <a href="https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs">NickHugi/Kotor.NET — `RIMBinaryStructure`</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/rimreader.cpp#L26-L58">reone — `RimReader`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394">xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py">PyKotor — `ResourceType` (tooling superset)</a>
]##
proc read*(_: typedesc[Rim], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Rim =
  template this: untyped = result
  this = new(Rim)
  let root = if root == nil: cast[Rim](this) else: cast[Rim](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
  ]##
  let headerExpr = Rim_RimHeader.read(this.io, this.root, this)
  this.header = headerExpr

  ##[
  When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).

  ]##
  if this.header.offsetToResourceTable == 0:
    let gapBeforeKeyTableImplicitExpr = this.io.readBytes(int(96))
    this.gapBeforeKeyTableImplicit = gapBeforeKeyTableImplicitExpr

  ##[
  When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.

  ]##
  if this.header.offsetToResourceTable != 0:
    let gapBeforeKeyTableExplicitExpr = this.io.readBytes(int(this.header.offsetToResourceTable - 24))
    this.gapBeforeKeyTableExplicit = gapBeforeKeyTableExplicitExpr

  ##[
  Array of resource entries mapping ResRefs to resource data
  ]##
  if this.header.resourceCount > 0:
    let resourceEntryTableExpr = Rim_ResourceEntryTable.read(this.io, this.root, this)
    this.resourceEntryTable = resourceEntryTableExpr

proc fromFile*(_: typedesc[Rim], filename: string): Rim =
  Rim.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Rim_ResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Rim_ResourceEntryTable): Rim_ResourceEntry =
  template this: untyped = result
  this = new(Rim_ResourceEntry)
  let root = if root == nil: cast[Rim](this) else: cast[Rim](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Resource filename (ResRef), null-padded to 16 bytes.
Maximum 16 characters. If exactly 16 characters, no null terminator exists.
Resource names can be mixed case, though most are lowercase in practice.
The game engine typically lowercases ResRefs when loading.

  ]##
  let resrefExpr = encode(this.io.readBytes(int(16)), "ASCII")
  this.resref = resrefExpr

  ##[
  Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)

  ]##
  let resourceTypeExpr = BiowareTypeIds_XoreosFileTypeId(this.io.readU4le())
  this.resourceType = resourceTypeExpr

  ##[
  Resource ID (index, usually sequential).
Typically matches the index of this entry in the resource_entry_table.
Used for internal reference, but not critical for parsing.

  ]##
  let resourceIdExpr = this.io.readU4le()
  this.resourceId = resourceIdExpr

  ##[
  Byte offset to resource data from the beginning of the file.
Points to the actual binary data for this resource in resource_data_section.

  ]##
  let offsetToDataExpr = this.io.readU4le()
  this.offsetToData = offsetToDataExpr

  ##[
  Size of resource data in bytes (repeat count for raw `data` bytes).
Uncompressed size of the resource.

  ]##
  let numDataExpr = this.io.readU4le()
  this.numData = numDataExpr

proc data(this: Rim_ResourceEntry): seq[uint8] = 

  ##[
  Raw binary data for this resource (read at specified offset)
  ]##
  if this.dataInstFlag:
    return this.dataInst
  let pos = this.io.pos()
  this.io.seek(int(this.offsetToData))
  for i in 0 ..< int(this.numData):
    let it = this.io.readU1()
    this.dataInst.add(it)
  this.io.seek(pos)
  this.dataInstFlag = true
  return this.dataInst

proc fromFile*(_: typedesc[Rim_ResourceEntry], filename: string): Rim_ResourceEntry =
  Rim_ResourceEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Rim_ResourceEntryTable], io: KaitaiStream, root: KaitaiStruct, parent: Rim): Rim_ResourceEntryTable =
  template this: untyped = result
  this = new(Rim_ResourceEntryTable)
  let root = if root == nil: cast[Rim](this) else: cast[Rim](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of resource entries, one per resource in the archive
  ]##
  for i in 0 ..< int(Rim(this.root).header.resourceCount):
    let it = Rim_ResourceEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Rim_ResourceEntryTable], filename: string): Rim_ResourceEntryTable =
  Rim_ResourceEntryTable.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Rim_RimHeader], io: KaitaiStream, root: KaitaiStruct, parent: Rim): Rim_RimHeader =
  template this: untyped = result
  this = new(Rim_RimHeader)
  let root = if root == nil: cast[Rim](this) else: cast[Rim](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
This identifies the file as a RIM archive.

  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Always "V1.0" for KotOR RIM files.
Other versions may exist in Neverwinter Nights but are not supported in KotOR.

  ]##
  let fileVersionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileVersion = fileVersionExpr

  ##[
  Reserved field (typically 0x00000000).
Unknown purpose, but always set to 0 in practice.

  ]##
  let reservedExpr = this.io.readU4le()
  this.reserved = reservedExpr

  ##[
  Number of resources in the archive. This determines:
- Number of entries in resource_entry_table
- Number of resources in resource_data_section

  ]##
  let resourceCountExpr = this.io.readU4le()
  this.resourceCount = resourceCountExpr

  ##[
  Byte offset to the key / resource entry table from the beginning of the file.
0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
When non-zero, this offset is used directly (commonly 120).

  ]##
  let offsetToResourceTableExpr = this.io.readU4le()
  this.offsetToResourceTable = offsetToResourceTableExpr

  ##[
  Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.

  ]##
  let offsetToResourcesExpr = this.io.readU4le()
  this.offsetToResources = offsetToResourcesExpr

proc hasResources(this: Rim_RimHeader): bool = 

  ##[
  Whether the RIM file contains any resources
  ]##
  if this.hasResourcesInstFlag:
    return this.hasResourcesInst
  let hasResourcesInstExpr = bool(this.resourceCount > 0)
  this.hasResourcesInst = hasResourcesInstExpr
  this.hasResourcesInstFlag = true
  return this.hasResourcesInst

proc fromFile*(_: typedesc[Rim_RimHeader], filename: string): Rim_RimHeader =
  Rim_RimHeader.read(newKaitaiFileStream(filename), nil, nil)

