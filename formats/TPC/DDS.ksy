meta:
  id: dds
  title: DirectDraw Surface (DDS) Texture Format
  license: MIT
  endian: le
  file-extension: dds
  xref:
    ghidra_odyssey_k1:
      note: "Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: DDS payloads embedded or standalone per DirectX / PyKotor wiki."
    pykotor: https://github.com/OldRepublicDevs/PyKotor/wiki/DDS-File-Format.md
doc: |
  DDS (DirectDraw Surface) files appear in two variants in KotOR:
  
  1. Standard DirectX DDS: Header magic "DDS " (0x44445320), 124-byte header
  2. BioWare DDS variant: No magic; width/height/bpp/dataSize leading integers
  
  DDS files support DXT1/DXT3/DXT5 block compression, uncompressed RGB/RGBA,
  and various other pixel formats. They can include mipmaps and cube maps.
  
  References:
  - https://github.com/OldRepublicDevs/PyKotor/wiki/DDS-File-Format.md - Complete DDS format documentation
  - Standard DirectX DDS format specification

seq:
  - id: magic
    type: str
    encoding: ASCII
    size: 4
    doc: |
      File magic. Either "DDS " (0x44445320) for standard DDS,
      or check for BioWare variant (no magic, starts with width/height).
    valid:
      any-of:
        - "'DDS '"
        - "'    '"  # BioWare variant has no magic (allows empty check)
  
  - id: header
    type: dds_header
    if: magic == "DDS "
    doc: Standard DDS header (124 bytes) - only present if magic is "DDS "
  
  - id: bioware_header
    type: bioware_dds_header
    if: magic != "DDS "
    doc: BioWare DDS variant header - only present if magic is not "DDS "
  
  - id: pixel_data
    type: u1
    repeat: eos
    doc: |
      Pixel data (compressed or uncompressed).
      For standard DDS: Format determined by DDPIXELFORMAT
      For BioWare DDS: DXT1 or DXT5 compressed data

types:
  dds_header:
    seq:
      - id: size
        type: u4
        doc: Header size (must be 124)
        valid: 124
      
      - id: flags
        type: u4
        doc: |
          DDS flags bitfield:
          - 0x00001007 = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT
          - 0x00020000 = DDSD_MIPMAPCOUNT (if mipmaps present)
      
      - id: height
        type: u4
        doc: Image height in pixels
      
      - id: width
        type: u4
        doc: Image width in pixels
      
      - id: pitch_or_linear_size
        type: u4
        doc: |
          Pitch (uncompressed) or linear size (compressed).
          For compressed formats: total size of all mip levels
      
      - id: depth
        type: u4
        doc: Depth for volume textures (usually 0 for 2D textures)
      
      - id: mipmap_count
        type: u4
        doc: Number of mipmap levels (0 or 1 = no mipmaps)
      
      - id: reserved1
        type: u4
        repeat: expr
        repeat-expr: 11
        doc: Reserved fields (unused)
      
      - id: pixel_format
        type: ddpixelformat
        doc: Pixel format structure
      
      - id: caps
        type: u4
        doc: |
          Capability flags:
          - 0x00001000 = DDSCAPS_TEXTURE
          - 0x00000008 = DDSCAPS_MIPMAP
          - 0x00000200 = DDSCAPS2_CUBEMAP
      
      - id: caps2
        type: u4
        doc: |
          Additional capability flags:
          - 0x00000200 = DDSCAPS2_CUBEMAP
          - 0x00000FC00 = Cube map face flags
      
      - id: caps3
        type: u4
        doc: Reserved capability flags
      
      - id: caps4
        type: u4
        doc: Reserved capability flags
      
      - id: reserved2
        type: u4
        doc: Reserved field
  
  ddpixelformat:
    seq:
      - id: size
        type: u4
        doc: Structure size (must be 32)
        valid: 32
      
      - id: flags
        type: u4
        doc: |
          Pixel format flags:
          - 0x00000001 = DDPF_ALPHAPIXELS
          - 0x00000002 = DDPF_ALPHA
          - 0x00000004 = DDPF_FOURCC
          - 0x00000040 = DDPF_RGB
          - 0x00000200 = DDPF_YUV
          - 0x00080000 = DDPF_LUMINANCE
      
      - id: fourcc
        type: str
        encoding: ASCII
        size: 4
        doc: |
          Four-character code for compressed formats:
          - "DXT1" = DXT1 compression
          - "DXT3" = DXT3 compression
          - "DXT5" = DXT5 compression
          - "    " = Uncompressed format
      
      - id: rgb_bit_count
        type: u4
        doc: Bits per pixel for uncompressed formats (16, 24, or 32)
      
      - id: r_bit_mask
        type: u4
        doc: Red channel bit mask (for uncompressed formats)
      
      - id: g_bit_mask
        type: u4
        doc: Green channel bit mask (for uncompressed formats)
      
      - id: b_bit_mask
        type: u4
        doc: Blue channel bit mask (for uncompressed formats)
      
      - id: a_bit_mask
        type: u4
        doc: Alpha channel bit mask (for uncompressed formats)
  
  bioware_dds_header:
    seq:
      - id: width
        type: u4
        doc: Image width in pixels (must be power of two, < 0x8000)
      
      - id: height
        type: u4
        doc: Image height in pixels (must be power of two, < 0x8000)
      
      - id: bytes_per_pixel
        type: u4
        doc: |
          Bytes per pixel:
          - 3 = DXT1 compression
          - 4 = DXT5 compression
      
      - id: data_size
        type: u4
        doc: |
          Total compressed data size.
          Must match (width*height)/2 for DXT1 or width*height for DXT5
      
      - id: unused_float
        type: f4
        doc: Unused float field (typically 0.0)
