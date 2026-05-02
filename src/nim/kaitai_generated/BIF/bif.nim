import kaitai_struct_nim_runtime
import options
import bioware_type_ids

type
  Bif* = ref object of KaitaiStruct
    `fileType`*: string
    `version`*: string
    `varResCount`*: uint32
    `fixedResCount`*: uint32
    `varTableOffset`*: uint32
    `parent`*: KaitaiStruct
    `varResourceTableInst`: Bif_VarResourceTable
    `varResourceTableInstFlag`: bool
  Bif_VarResourceEntry* = ref object of KaitaiStruct
    `resourceId`*: uint32
    `offset`*: uint32
    `fileSize`*: uint32
    `resourceType`*: BiowareTypeIds_XoreosFileTypeId
    `parent`*: Bif_VarResourceTable
  Bif_VarResourceTable* = ref object of KaitaiStruct
    `entries`*: seq[Bif_VarResourceEntry]
    `parent`*: Bif

proc read*(_: typedesc[Bif], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bif
proc read*(_: typedesc[Bif_VarResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Bif_VarResourceTable): Bif_VarResourceEntry
proc read*(_: typedesc[Bif_VarResourceTable], io: KaitaiStream, root: KaitaiStruct, parent: Bif): Bif_VarResourceTable

proc varResourceTable*(this: Bif): Bif_VarResourceTable


##[
**BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
the paired **KEY** (`KEY.ksy`), not in the BIF.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif">PyKotor wiki — BIF</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L57-L215">PyKotor — `io_bif` (Kaitai + legacy + reader)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py#L59-L71">PyKotor — `BIFType`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L97">xoreos — `BIFFile::load` + `readVarResTable`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L208">xoreos — `kFileTypeBIF`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L209">xoreos-tools — `unkeybif` (non-`.bzf` → `BIFFile`)</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/bifreader.cpp#L26-L63">reone — `BifReader`</a>
@see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/BIFObject.ts">KotOR.js — `BIFObject`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/bif.html">xoreos-docs — Torlack bif.html</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf">xoreos-docs — KeyBIF_Format.pdf</a>
]##
proc read*(_: typedesc[Bif], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Bif =
  template this: untyped = result
  this = new(Bif)
  let root = if root == nil: cast[Bif](this) else: cast[Bif](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "BIFF" for BIF files.
  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Typically "V1  " or "V1.1".
  ]##
  let versionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.version = versionExpr

  ##[
  Number of variable-size resources in this file.
  ]##
  let varResCountExpr = this.io.readU4le()
  this.varResCount = varResCountExpr

  ##[
  Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
  ]##
  let fixedResCountExpr = this.io.readU4le()
  this.fixedResCount = fixedResCountExpr

  ##[
  Byte offset to the variable resource table from the beginning of the file.
  ]##
  let varTableOffsetExpr = this.io.readU4le()
  this.varTableOffset = varTableOffsetExpr

proc varResourceTable(this: Bif): Bif_VarResourceTable = 

  ##[
  Variable resource table containing entries for each resource.
  ]##
  if this.varResourceTableInstFlag:
    return this.varResourceTableInst
  if this.varResCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.varTableOffset))
    let varResourceTableInstExpr = Bif_VarResourceTable.read(this.io, this.root, this)
    this.varResourceTableInst = varResourceTableInstExpr
    this.io.seek(pos)
  this.varResourceTableInstFlag = true
  return this.varResourceTableInst

proc fromFile*(_: typedesc[Bif], filename: string): Bif =
  Bif.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bif_VarResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Bif_VarResourceTable): Bif_VarResourceEntry =
  template this: untyped = result
  this = new(Bif_VarResourceEntry)
  let root = if root == nil: cast[Bif](this) else: cast[Bif](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Resource ID (matches KEY file entry).
Encodes BIF index (bits 31-20) and resource index (bits 19-0).
Formula: resource_id = (bif_index << 20) | resource_index

  ]##
  let resourceIdExpr = this.io.readU4le()
  this.resourceId = resourceIdExpr

  ##[
  Byte offset to resource data in file (absolute file offset).
  ]##
  let offsetExpr = this.io.readU4le()
  this.offset = offsetExpr

  ##[
  Uncompressed size of resource data in bytes.
  ]##
  let fileSizeExpr = this.io.readU4le()
  this.fileSize = fileSizeExpr

  ##[
  Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
`formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.

  ]##
  let resourceTypeExpr = BiowareTypeIds_XoreosFileTypeId(this.io.readU4le())
  this.resourceType = resourceTypeExpr

proc fromFile*(_: typedesc[Bif_VarResourceEntry], filename: string): Bif_VarResourceEntry =
  Bif_VarResourceEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Bif_VarResourceTable], io: KaitaiStream, root: KaitaiStruct, parent: Bif): Bif_VarResourceTable =
  template this: untyped = result
  this = new(Bif_VarResourceTable)
  let root = if root == nil: cast[Bif](this) else: cast[Bif](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of variable resource entries.
  ]##
  for i in 0 ..< int(Bif(this.root).varResCount):
    let it = Bif_VarResourceEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Bif_VarResourceTable], filename: string): Bif_VarResourceTable =
  Bif_VarResourceTable.read(newKaitaiFileStream(filename), nil, nil)

