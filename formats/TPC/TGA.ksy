meta:
  id: tga
  title: Targa (TGA) Image Format
  license: MIT
  endian: le
  file-extension:
    - tga
    - targa
  xref:
    ghidra_odyssey_k1:
      note: "Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: TGA sources often converted to TPC for in-game use."
    pykotor_wiki_tpc: https://github.com/OldRepublicDevs/PyKotor/wiki/TPC-File-Format.md
doc: |
  TGA (Targa) is an uncompressed raster image format used in KotOR for textures.
  TGA files support RGB, RGBA, and greyscale formats with optional RLE compression.
  
  TGA files are commonly converted to TPC format for use in KotOR, but the game
  can also load TGA files directly in some contexts.
  
  Format Structure:
  - Header (18 bytes): Image metadata, dimensions, pixel format
  - Color Map (optional): Palette data for indexed color images
  - Image Data: Raw or RLE-compressed pixel data
  
  References:
  - https://github.com/OldRepublicDevs/PyKotor/wiki/TPC-File-Format.md - TGA conversion to TPC
  - Standard TGA format specification

seq:
  - id: id_length
    type: u1
    doc: Length of image ID field (0-255 bytes)
  
  - id: color_map_type
    type: u1
    doc: |
      Color map type:
      - 0 = No color map
      - 1 = Color map present
    enum: color_map_type
  
  - id: image_type
    type: u1
    doc: |
      Image type:
      - 0 = No image data
      - 1 = Uncompressed color-mapped
      - 2 = Uncompressed RGB
      - 3 = Uncompressed greyscale
      - 9 = RLE color-mapped
      - 10 = RLE RGB
      - 11 = RLE greyscale
    enum: image_type
  
  - id: color_map_spec
    type: color_map_specification
    if: color_map_type == color_map_type::present
    doc: Color map specification (only present if color_map_type == present)
  
  - id: image_spec
    type: image_specification
    doc: Image specification (dimensions and pixel format)
  
  - id: image_id
    type: str
    size: id_length
    encoding: ASCII
    if: id_length > 0
    doc: Image identification field (optional ASCII string)
  
  - id: color_map_data
    type: u1
    repeat: expr
    repeat-expr: color_map_spec.length
    if: color_map_type == color_map_type::present
    doc: Color map data (palette entries)
  
  - id: image_data
    type: u1
    repeat: eos
    doc: |
      Image pixel data (raw or RLE-compressed).
      Size depends on image dimensions, pixel format, and compression.
      For uncompressed formats: width × height × bytes_per_pixel
      For RLE formats: Variable size depending on compression ratio

types:
  color_map_specification:
    seq:
      - id: first_entry_index
        type: u2
        doc: Index of first color map entry
      
      - id: length
        type: u2
        doc: Number of color map entries
      
      - id: entry_size
        type: u1
        doc: Size of each color map entry in bits (15, 16, 24, or 32)
  
  image_specification:
    seq:
      - id: x_origin
        type: u2
        doc: X coordinate of lower-left corner of image
      
      - id: y_origin
        type: u2
        doc: Y coordinate of lower-left corner of image
      
      - id: width
        type: u2
        doc: Image width in pixels
      
      - id: height
        type: u2
        doc: Image height in pixels
      
      - id: pixel_depth
        type: u1
        doc: |
          Bits per pixel:
          - 8 = Greyscale or indexed
          - 16 = RGB 5-5-5 or RGBA 1-5-5-5
          - 24 = RGB
          - 32 = RGBA
      
      - id: image_descriptor
        type: u1
        doc: |
          Image descriptor byte:
          - Bits 0-3: Number of attribute bits per pixel (alpha channel)
          - Bit 4: Reserved
          - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
          - Bits 6-7: Interleaving (usually 0)

enums:
  color_map_type:
    0: none
    1: present
  
  image_type:
    0: no_image_data
    1: uncompressed_color_mapped
    2: uncompressed_rgb
    3: uncompressed_greyscale
    9: rle_color_mapped
    10: rle_rgb
    11: rle_greyscale
