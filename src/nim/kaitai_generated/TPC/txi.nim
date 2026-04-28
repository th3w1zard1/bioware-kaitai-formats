import kaitai_struct_nim_runtime
import options

type
  Txi* = ref object of KaitaiStruct
    `content`*: string
    `parent`*: KaitaiStruct

proc read*(_: typedesc[Txi], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Txi



##[
**Policy:** TXI is **plaintext** (line-oriented ASCII). This `.ksy` models only an opaque string span for tooling;
authoritative command semantics live in PyKotor / reone parsers (`meta.xref`). xoreos consumes embedded TXI via **`TPC::readTXI`**
(`meta.xref.xoreos_tpc_read_txi`), not a standalone `txifile.cpp`.

TXI (Texture Info) files are compact ASCII descriptors that attach metadata to TPC textures.
They control mipmap usage, filtering, flipbook animation, environment mapping, font atlases,
and platform-specific downsampling. Every TXI file is parsed at runtime to configure how
a TPC image is rendered.

Format Structure:
- Line-based ASCII text file (UTF-8 or Windows-1252)
- Commands are case-insensitive but conventionally lowercase
- Empty TXI files (0 bytes) are valid and use default settings
- A TXI can be embedded at the end of a .tpc file or exist as a separate .txi file

Command Formats (from PyKotor implementation):
1. Simple commands: "command value" (e.g., "mipmap 0", "blending additive")
2. Multi-value commands: "command v1 v2 v3" (e.g., "channelscale 1.0 0.5 0.5")
3. Coordinate commands: "command count" followed by count coordinate lines
   Coordinate format: "x y z" (normalized floats + int, typically z=0)

Parsing Behavior (matches PyKotor TXIReaderMode):
- Lines parsed sequentially, whitespace stripped
- Empty lines ignored
- Commands recognized by uppercase comparison against TXICommand enum
- Invalid commands logged but don't stop parsing
- Coordinate commands switch parser to coordinate mode until count reached
- Commands can interrupt coordinate parsing

All Supported Commands (from TXICommand enum in txi_data.py):
- alphamean, arturoheight, arturowidth, baselineheight, blending, bumpmapscaling, bumpmaptexture
- bumpyshinytexture, candownsample, caretindent, channelscale, channeltranslate, clamp, codepage
- cols, compresstexture, controllerscript, cube, decal, defaultbpp, defaultheight, defaultwidth
- distort, distortangle, distortionamplitude, downsamplefactor, downsamplemax, downsamplemin
- envmaptexture, filerange, filter, fontheight, fontwidth, fps, isbumpmap, isdiffusebumpmap
- islightmap, isspecularbumpmap, lowerrightcoords, maxsizehq, maxsizelq, minsizehq, minsizelq
- mipmap, numchars, numcharspersheet, numx, numy, ondemand, priority, proceduretype, rows
- spacingb, spacingr, speed, temporary, texturewidth, unique, upperleftcoords, wateralpha
- waterheight, waterwidth, xbox_downsample

Index: `meta.xref` and `doc-ref`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi">PyKotor wiki — TXI</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/io_txi.py#L20-L50">PyKotor — TXI reader (`TXIReaderMode`, `TXIBinaryReader.load` start)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py#L619-L684">PyKotor — `TXICommand` enum block</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/txireader.cpp#L28-L125">reone — `TxiReader` ASCII parse (`load` + `processLine`)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L362-L373">xoreos — `TPC::readTXI` (embedded TXI tail)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224">xoreos-tools — `TPC::readHeader` (texture tool stack; TXI pairs with TPC)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L88">xoreos — `kFileTypeTXI`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (TPC-attached TXI context)</a>
]##
proc read*(_: typedesc[Txi], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Txi =
  template this: untyped = result
  this = new(Txi)
  let root = if root == nil: cast[Txi](this) else: cast[Txi](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Complete TXI file content as raw ASCII text.
The PyKotor parser processes this line-by-line with special handling for:
- Coordinate commands (upperleftcoords, lowerrightcoords) followed by coordinate data
- Multi-value commands (channelscale, channeltranslate, filerange)
- Boolean/numeric/string single-value commands
- Empty files (valid, indicates default settings)

  ]##
  let contentExpr = encode(this.io.readBytesFull(), "ASCII")
  this.content = contentExpr

proc fromFile*(_: typedesc[Txi], filename: string): Txi =
  Txi.read(newKaitaiFileStream(filename), nil, nil)

