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

