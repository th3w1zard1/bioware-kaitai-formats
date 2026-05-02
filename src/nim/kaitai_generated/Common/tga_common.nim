import kaitai_struct_nim_runtime
import options

type
  TgaCommon* = ref object of KaitaiStruct
    `parent`*: KaitaiStruct
  TgaCommon_TgaColorMapType* = enum
    none = 0
    present = 1
  TgaCommon_TgaImageType* = enum
    no_image_data = 0
    uncompressed_color_mapped = 1
    uncompressed_rgb = 2
    uncompressed_greyscale = 3
    rle_color_mapped = 9
    rle_rgb = 10
    rle_greyscale = 11

proc read*(_: typedesc[TgaCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): TgaCommon



##[
Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).

Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc">PyKotor wiki — textures (TGA pipeline)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40">PyKotor — `tga.py` (reader core)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177">xoreos — `TGA::readHeader`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L61">xoreos — `kFileTypeTGA`</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L80">xoreos-tools — `TGA::load`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs PDF tree</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview (texture context)</a>
]##
proc read*(_: typedesc[TgaCommon], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): TgaCommon =
  template this: untyped = result
  this = new(TgaCommon)
  let root = if root == nil: cast[TgaCommon](this) else: cast[TgaCommon](root)
  this.io = io
  this.root = root
  this.parent = parent


proc fromFile*(_: typedesc[TgaCommon], filename: string): TgaCommon =
  TgaCommon.read(newKaitaiFileStream(filename), nil, nil)

