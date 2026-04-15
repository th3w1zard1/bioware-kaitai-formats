meta:
  id: tga_common
  title: Truevision TGA shared enumerations
  license: MIT
  endian: le
  xref:
    xoreos_tga_read_header: https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177
    pykotor_wiki_tpc_tga_note: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
doc: |
  Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
  per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).

  Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.

enums:
  tga_color_map_type:
    0: none
    1: present

  tga_image_type:
    0: no_image_data
    1: uncompressed_color_mapped
    2: uncompressed_rgb
    3: uncompressed_greyscale
    9: rle_color_mapped
    10: rle_rgb
    11: rle_greyscale
