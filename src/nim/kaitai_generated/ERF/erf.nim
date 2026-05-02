import kaitai_struct_nim_runtime
import options
import bioware_type_ids

type
  Erf* = ref object of KaitaiStruct
    `header`*: Erf_ErfHeader
    `parent`*: KaitaiStruct
    `keyListInst`: Erf_KeyList
    `keyListInstFlag`: bool
    `localizedStringListInst`: Erf_LocalizedStringList
    `localizedStringListInstFlag`: bool
    `resourceListInst`: Erf_ResourceList
    `resourceListInstFlag`: bool
  Erf_ErfHeader* = ref object of KaitaiStruct
    `fileType`*: string
    `fileVersion`*: string
    `languageCount`*: uint32
    `localizedStringSize`*: uint32
    `entryCount`*: uint32
    `offsetToLocalizedStringList`*: uint32
    `offsetToKeyList`*: uint32
    `offsetToResourceList`*: uint32
    `buildYear`*: uint32
    `buildDay`*: uint32
    `descriptionStrref`*: int32
    `reserved`*: seq[byte]
    `parent`*: Erf
    `isSaveFileInst`: bool
    `isSaveFileInstFlag`: bool
  Erf_KeyEntry* = ref object of KaitaiStruct
    `resref`*: string
    `resourceId`*: uint32
    `resourceType`*: BiowareTypeIds_XoreosFileTypeId
    `unused`*: uint16
    `parent`*: Erf_KeyList
  Erf_KeyList* = ref object of KaitaiStruct
    `entries`*: seq[Erf_KeyEntry]
    `parent`*: Erf
  Erf_LocalizedStringEntry* = ref object of KaitaiStruct
    `languageId`*: uint32
    `stringSize`*: uint32
    `stringData`*: string
    `parent`*: Erf_LocalizedStringList
  Erf_LocalizedStringList* = ref object of KaitaiStruct
    `entries`*: seq[Erf_LocalizedStringEntry]
    `parent`*: Erf
  Erf_ResourceEntry* = ref object of KaitaiStruct
    `offsetToData`*: uint32
    `lenData`*: uint32
    `parent`*: Erf_ResourceList
    `dataInst`: seq[byte]
    `dataInstFlag`: bool
  Erf_ResourceList* = ref object of KaitaiStruct
    `entries`*: seq[Erf_ResourceEntry]
    `parent`*: Erf

proc read*(_: typedesc[Erf], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Erf
proc read*(_: typedesc[Erf_ErfHeader], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_ErfHeader
proc read*(_: typedesc[Erf_KeyEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_KeyList): Erf_KeyEntry
proc read*(_: typedesc[Erf_KeyList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_KeyList
proc read*(_: typedesc[Erf_LocalizedStringEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_LocalizedStringList): Erf_LocalizedStringEntry
proc read*(_: typedesc[Erf_LocalizedStringList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_LocalizedStringList
proc read*(_: typedesc[Erf_ResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_ResourceList): Erf_ResourceEntry
proc read*(_: typedesc[Erf_ResourceList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_ResourceList

proc keyList*(this: Erf): Erf_KeyList
proc localizedStringList*(this: Erf): Erf_LocalizedStringList
proc resourceList*(this: Erf): Erf_ResourceList
proc isSaveFile*(this: Erf_ErfHeader): bool
proc data*(this: Erf_ResourceEntry): seq[byte]


##[
ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
ERF files store both resource names (ResRefs) and data in the same file. They also support
localized strings for descriptions in multiple languages.

Format Variants:
- ERF: Generic encapsulated resource file (texture packs, etc.)
- HAK: Hak pak file (contains override resources). Used for mod content distribution
- MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
- SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`

All variants use the same binary format structure, differing only in the file type signature.

Archive `resource_type` values use the shared **`bioware_type_ids::xoreos_file_type_id`** enum (xoreos `FileType`); see `formats/Common/bioware_type_ids.ksy`.

Binary Format Structure:
- Header (160 bytes): File type, version, entry counts, offsets, build date, description
- Localized String List (optional, variable size): Multi-language descriptions. MOD files may
  include localized module names for the load screen. Each entry contains language_id (u4),
  string_size (u4), and string_data (UTF-8 encoded text)
- Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
  - resref (16 bytes, ASCII, null-padded): Resource filename
  - resource_id (u4): Index into resource_list
  - resource_type (u2): Resource type identifier (`bioware_type_ids::xoreos_file_type_id`, xoreos `FileType`)
  - unused (u2): Padding/unused field (typically 0)
- Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
  - offset_to_data (u4): Byte offset to resource data from beginning of file
  - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
- Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
  in resource_list

File Access Pattern:
1. Read header to get entry_count and offsets
2. Read key_list to map ResRefs to resource_ids
3. Use resource_id to index into resource_list
4. Read resource data from offset_to_data with byte length len_data

Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_erf` / `erf_data`, xoreos `ERFFile`, xoreos-tools `unerf` / `erf`, reone `ErfReader`, KotOR.js `ERFObject`, NickHugi `Kotor.NET/Formats/KotorERF`).

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf">PyKotor wiki — ERF</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf">PyKotor wiki — Aurora ERF notes</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py#L22-L316">PyKotor — `io_erf` (Kaitai + legacy + `ERFBinaryWriter.write`)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L130">PyKotor — `ERFType` + `ERF` model (opening)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L50-L335">xoreos — ERF type tags + `ERFFile::load` + `readV10Header` start</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unerf.cpp#L69-L106">xoreos-tools — `unerf` CLI (`main`)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/erf.cpp#L49-L96">xoreos-tools — `erf` packer CLI (`main`)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html">xoreos-docs — Torlack mod.html</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/erfreader.cpp#L26-L92">reone — `ErfReader`</a>
@see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/ERFObject.ts#L70-L115">KotOR.js — `ERFObject`</a>
@see <a href="https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorERF/ERFBinaryStructure.cs">NickHugi/Kotor.NET — `ERFBinaryStructure`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/ERF_Format.pdf">xoreos-docs — ERF_Format.pdf</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394">xoreos — `enum FileType` (numeric IDs in KEY/ERF/RIM tables)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py">PyKotor — `ResourceType` (tooling superset; overlaps FileType for KotOR rows)</a>
]##
proc read*(_: typedesc[Erf], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Erf =
  template this: untyped = result
  this = new(Erf)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  ERF file header (160 bytes)
  ]##
  let headerExpr = Erf_ErfHeader.read(this.io, this.root, this)
  this.header = headerExpr

proc keyList(this: Erf): Erf_KeyList = 

  ##[
  Array of key entries mapping ResRefs to resource indices
  ]##
  if this.keyListInstFlag:
    return this.keyListInst
  let pos = this.io.pos()
  this.io.seek(int(this.header.offsetToKeyList))
  let keyListInstExpr = Erf_KeyList.read(this.io, this.root, this)
  this.keyListInst = keyListInstExpr
  this.io.seek(pos)
  this.keyListInstFlag = true
  return this.keyListInst

proc localizedStringList(this: Erf): Erf_LocalizedStringList = 

  ##[
  Optional localized string entries for multi-language descriptions
  ]##
  if this.localizedStringListInstFlag:
    return this.localizedStringListInst
  if this.header.languageCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.header.offsetToLocalizedStringList))
    let localizedStringListInstExpr = Erf_LocalizedStringList.read(this.io, this.root, this)
    this.localizedStringListInst = localizedStringListInstExpr
    this.io.seek(pos)
  this.localizedStringListInstFlag = true
  return this.localizedStringListInst

proc resourceList(this: Erf): Erf_ResourceList = 

  ##[
  Array of resource entries containing offset and size information
  ]##
  if this.resourceListInstFlag:
    return this.resourceListInst
  let pos = this.io.pos()
  this.io.seek(int(this.header.offsetToResourceList))
  let resourceListInstExpr = Erf_ResourceList.read(this.io, this.root, this)
  this.resourceListInst = resourceListInstExpr
  this.io.seek(pos)
  this.resourceListInstFlag = true
  return this.resourceListInst

proc fromFile*(_: typedesc[Erf], filename: string): Erf =
  Erf.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_ErfHeader], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_ErfHeader =
  template this: untyped = result
  this = new(Erf_ErfHeader)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be one of:
- "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
- "MOD " (0x4D 0x4F 0x44 0x20) - Module file
- "SAV " (0x53 0x41 0x56 0x20) - Save game file
- "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file

  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Always "V1.0" for KotOR ERF files.
Other versions may exist in Neverwinter Nights but are not supported in KotOR.

  ]##
  let fileVersionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileVersion = fileVersionExpr

  ##[
  Number of localized string entries. Typically 0 for most ERF files.
MOD files may include localized module names for the load screen.

  ]##
  let languageCountExpr = this.io.readU4le()
  this.languageCount = languageCountExpr

  ##[
  Total size of localized string data in bytes.
Includes all language entries (language_id + string_size + string_data for each).

  ]##
  let localizedStringSizeExpr = this.io.readU4le()
  this.localizedStringSize = localizedStringSizeExpr

  ##[
  Number of resources in the archive. This determines:
- Number of entries in key_list
- Number of entries in resource_list
- Number of resource data blocks stored at various offsets

  ]##
  let entryCountExpr = this.io.readU4le()
  this.entryCount = entryCountExpr

  ##[
  Byte offset to the localized string list from the beginning of the file.
Typically 160 (right after header) if present, or 0 if not present.

  ]##
  let offsetToLocalizedStringListExpr = this.io.readU4le()
  this.offsetToLocalizedStringList = offsetToLocalizedStringListExpr

  ##[
  Byte offset to the key list from the beginning of the file.
Typically 160 (right after header) if no localized strings, or after localized strings.

  ]##
  let offsetToKeyListExpr = this.io.readU4le()
  this.offsetToKeyList = offsetToKeyListExpr

  ##[
  Byte offset to the resource list from the beginning of the file.
Located after the key list.

  ]##
  let offsetToResourceListExpr = this.io.readU4le()
  this.offsetToResourceList = offsetToResourceListExpr

  ##[
  Build year (years since 1900).
Example: 103 = year 2003
Primarily informational, used by development tools to track module versions.

  ]##
  let buildYearExpr = this.io.readU4le()
  this.buildYear = buildYearExpr

  ##[
  Build day (days since January 1, with January 1 = day 1).
Example: 247 = September 4th (the 247th day of the year)
Primarily informational, used by development tools to track module versions.

  ]##
  let buildDayExpr = this.io.readU4le()
  this.buildDay = buildDayExpr

  ##[
  Description StrRef (TLK string reference) for the archive description.
Values vary by file type:
- MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
- SAV files: 0 (typically no description)
- ERF/HAK files: Unpredictable (may contain valid StrRef or -1)

  ]##
  let descriptionStrrefExpr = this.io.readS4le()
  this.descriptionStrref = descriptionStrrefExpr

  ##[
  Reserved padding (usually zeros).
Total header size is 160 bytes:
file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
reserved (116) = 160 bytes

  ]##
  let reservedExpr = this.io.readBytes(int(116))
  this.reserved = reservedExpr

proc isSaveFile(this: Erf_ErfHeader): bool = 

  ##[
  Heuristic to detect save game files.
Save games use MOD signature but typically have description_strref = 0.

  ]##
  if this.isSaveFileInstFlag:
    return this.isSaveFileInst
  let isSaveFileInstExpr = bool( ((this.fileType == "MOD ") and (this.descriptionStrref == 0)) )
  this.isSaveFileInst = isSaveFileInstExpr
  this.isSaveFileInstFlag = true
  return this.isSaveFileInst

proc fromFile*(_: typedesc[Erf_ErfHeader], filename: string): Erf_ErfHeader =
  Erf_ErfHeader.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_KeyEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_KeyList): Erf_KeyEntry =
  template this: untyped = result
  this = new(Erf_KeyEntry)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Resource filename (ResRef), null-padded to 16 bytes.
Maximum 16 characters. If exactly 16 characters, no null terminator exists.
Resource names can be mixed case, though most are lowercase in practice.

  ]##
  let resrefExpr = encode(this.io.readBytes(int(16)), "ASCII")
  this.resref = resrefExpr

  ##[
  Resource ID (index into resource_list).
Maps this key entry to the corresponding resource entry.

  ]##
  let resourceIdExpr = this.io.readU4le()
  this.resourceId = resourceIdExpr

  ##[
  Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)

  ]##
  let resourceTypeExpr = BiowareTypeIds_XoreosFileTypeId(this.io.readU2le())
  this.resourceType = resourceTypeExpr

  ##[
  Padding/unused field (typically 0)
  ]##
  let unusedExpr = this.io.readU2le()
  this.unused = unusedExpr

proc fromFile*(_: typedesc[Erf_KeyEntry], filename: string): Erf_KeyEntry =
  Erf_KeyEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_KeyList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_KeyList =
  template this: untyped = result
  this = new(Erf_KeyList)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of key entries mapping ResRefs to resource indices
  ]##
  for i in 0 ..< int(Erf(this.root).header.entryCount):
    let it = Erf_KeyEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Erf_KeyList], filename: string): Erf_KeyList =
  Erf_KeyList.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_LocalizedStringEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_LocalizedStringList): Erf_LocalizedStringEntry =
  template this: untyped = result
  this = new(Erf_LocalizedStringEntry)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Language identifier:
- 0 = English
- 1 = French
- 2 = German
- 3 = Italian
- 4 = Spanish
- 5 = Polish
- Additional languages for Asian releases

  ]##
  let languageIdExpr = this.io.readU4le()
  this.languageId = languageIdExpr

  ##[
  Length of string data in bytes
  ]##
  let stringSizeExpr = this.io.readU4le()
  this.stringSize = stringSizeExpr

  ##[
  UTF-8 encoded text string
  ]##
  let stringDataExpr = encode(this.io.readBytes(int(this.stringSize)), "UTF-8")
  this.stringData = stringDataExpr

proc fromFile*(_: typedesc[Erf_LocalizedStringEntry], filename: string): Erf_LocalizedStringEntry =
  Erf_LocalizedStringEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_LocalizedStringList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_LocalizedStringList =
  template this: untyped = result
  this = new(Erf_LocalizedStringList)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of localized string entries, one per language
  ]##
  for i in 0 ..< int(Erf(this.root).header.languageCount):
    let it = Erf_LocalizedStringEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Erf_LocalizedStringList], filename: string): Erf_LocalizedStringList =
  Erf_LocalizedStringList.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_ResourceEntry], io: KaitaiStream, root: KaitaiStruct, parent: Erf_ResourceList): Erf_ResourceEntry =
  template this: untyped = result
  this = new(Erf_ResourceEntry)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Byte offset to resource data from the beginning of the file.
Points to the actual binary data for this resource.

  ]##
  let offsetToDataExpr = this.io.readU4le()
  this.offsetToData = offsetToDataExpr

  ##[
  Size of resource data in bytes.
Uncompressed size of the resource.

  ]##
  let lenDataExpr = this.io.readU4le()
  this.lenData = lenDataExpr

proc data(this: Erf_ResourceEntry): seq[byte] = 

  ##[
  Raw binary data for this resource
  ]##
  if this.dataInstFlag:
    return this.dataInst
  let pos = this.io.pos()
  this.io.seek(int(this.offsetToData))
  let dataInstExpr = this.io.readBytes(int(this.lenData))
  this.dataInst = dataInstExpr
  this.io.seek(pos)
  this.dataInstFlag = true
  return this.dataInst

proc fromFile*(_: typedesc[Erf_ResourceEntry], filename: string): Erf_ResourceEntry =
  Erf_ResourceEntry.read(newKaitaiFileStream(filename), nil, nil)

proc read*(_: typedesc[Erf_ResourceList], io: KaitaiStream, root: KaitaiStruct, parent: Erf): Erf_ResourceList =
  template this: untyped = result
  this = new(Erf_ResourceList)
  let root = if root == nil: cast[Erf](this) else: cast[Erf](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of resource entries containing offset and size information
  ]##
  for i in 0 ..< int(Erf(this.root).header.entryCount):
    let it = Erf_ResourceEntry.read(this.io, this.root, this)
    this.entries.add(it)

proc fromFile*(_: typedesc[Erf_ResourceList], filename: string): Erf_ResourceList =
  Erf_ResourceList.read(newKaitaiFileStream(filename), nil, nil)

