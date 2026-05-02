[Skip to content](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#start-of-content)
  

You signed in with another tab or window. [Reload](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats)
 to refresh your session. You signed out in another tab or window. [Reload](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats)
 to refresh your session. You switched accounts on another tab or window. [Reload](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats)
 to refresh your session. Dismiss alert

[OpenKotOR](https://github.com/OpenKotOR) / **[PyKotor](https://github.com/OpenKotOR/PyKotor)** Public

*   ### Uh oh!
    
    There was an error while loading. [Please reload this page](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats)
    .
    
*   [Notifications](https://github.com/login?return_to=%2FOpenKotOR%2FPyKotor)
     You must be signed in to change notification settings
*   [Fork 3](https://github.com/login?return_to=%2FOpenKotOR%2FPyKotor)
    
*   [Star 6](https://github.com/login?return_to=%2FOpenKotOR%2FPyKotor)
    

Texture Formats
===============

[Jump to bottom](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#wiki-pages-box)

Benjamin Auquite edited this page Apr 15, 2026 · [5 revisions](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats/_history)

Texture Formats
===============

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#texture-formats)

The KotOR engine uses several texture formats, each serving a different purpose in the rendering pipeline. **TPC** (Texture Pack Container) is the primary compressed texture format shipped with the game — most visual assets the player sees are TPC files inside BIF archives ([`TPC` L494](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L494)
, [reone `TpcReader::load` L32](https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L32)
). **DDS** (DirectDraw Surface) textures appear in two variants: the standard DirectX format used by modding tools and ports, and a BioWare-specific headerless variant inherited from the Aurora engine ([`TPCDDSReader` L49](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L49)
, [xoreos `dds.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp)
). **PLT** (Palette Texture) is a Neverwinter Nights-only palette system (not used in KotOR — see [below](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#plt)
) that let an Aurora engine recolor armor and clothing at runtime without duplicating texture data ([xoreos-docs `specs/torlack/plt.html`](https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html)
, [Kaitai `PLT.ksy`](https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/PLT/PLT.ksy)
). **TXI** files are plain-text sidecar metadata that control rendering properties such as blending, animation frames, and environment mapping ([`TXI` L52](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py#L52)
, [`TXICommand` L613](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py#L613)
). For command-line tooling, xoreos-tools groups these BioWare image families under `xoreostex2tga`, which is a useful external reminder that KotOR texture work often involves converting among related engine-specific texture containers instead of treating each extension in isolation \[[Running xoreos-tools](https://wiki.xoreos.org/index.php/Running_xoreos-tools)\
\].

Contents
--------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#contents)

*   [DDS — DirectDraw Surface](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds)
    
*   [TPC — Texture Pack Container](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
    
*   [PLT — Palette Texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#plt)
    
*   [TXI — Texture Information](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
    

* * *

DDS — DirectDraw Surface
========================

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds--directdraw-surface)

DirectDraw Surface (DDS) textures appear in two variants across Odyssey engine content:

*   **Standard DirectX DDS** (header magic `0x44445320`, 124-byte header) — used by modding tools, ports, and external texture editors.
*   **BioWare DDS variant** (no magic; width/height/bpp/dataSize leading integers) — the headerless format used in KotOR and Neverwinter Nights game assets, inherited from the Aurora engine.

The engine resolves DDS textures through the standard [resource resolution order](https://github.com/OpenKotOR/PyKotor/wiki/Concepts#resource-resolution-order)
 (override → [MOD/ERF/SAV](https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf)
 → [KEY/BIF](https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key)
). Hex type ID **`0x07F1`** is listed under [Resource Type Identifiers](https://github.com/OpenKotOR/PyKotor/wiki/Resource-Formats-and-Resolution#resource-type-identifiers)
.

Table of Contents
-----------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#table-of-contents)

*   DDS — DirectDraw Surface
    *   Table of Contents
    *   [Standard DDS (DX7+ container)](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#standard-dds-dx7-container)
        
    *   [BioWare DDS variant](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#bioware-dds-variant)
        
    *   [Writer Behaviour (PyKotor)](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#writer-behaviour-pykotor)
        
    *   [Detection and Routing](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#detection-and-routing)
        
    *   [Testing coverage](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#testing-coverage)
        
    *   [Practical differences vs. TGA/TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#practical-differences-vs-tgatpc)
        
    *   [Notes and limits](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#notes-and-limits)
        
    *   [See also](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#see-also)
        

* * *

PyKotor reads both variants via [`TPCDDSReader.load` L191+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L191)
 (class [`TPCDDSReader` L49+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L49)
) and writes standard DDS via [`TPCDDSWriter` L351+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L351)
, routed through [`tpc_auto.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_auto.py)
 via `ResourceType.DDS` detection. The same structure is decoded by [xoreos `src/graphics/images/dds.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp)
 (engine, both variants) and [xoreos-tools `src/images/dds.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/images/dds.cpp)
 (command-line conversion). Reone has no standalone DDS reader \[[`src/libs/graphics/format/` contains no `ddsreader.cpp`](https://github.com/seedhartha/reone/tree/master/src/libs/graphics/format)\
\] and loads all textures through [TPC via `TpcReader::load` L32+](https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L32)
. KotOR.js follows the TPC path via [`TPCObject.ts`](https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts)
 and [`TextureLoader.ts`](https://github.com/KobaltBlu/KotOR.js/blob/master/src/loaders/TextureLoader.ts)
; Kotor.NET manages textures under [`Kotor.NET/Formats/KotorTPC/`](https://github.com/NickHugi/Kotor.NET/tree/master/Kotor.NET/Formats/KotorTPC)
 with no separate DDS project. DDS is primarily a tool interchange format — KotOR ships textures as [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 — but DDS files in the override folder are fully supported. For mod workflows see [HoloPatcher for mod developers](https://github.com/OpenKotOR/PyKotor/wiki/HoloPatcher#mod-developers)
; related formats: [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
, [TXI](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
.

### Standard DDS (DX7+ container)

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#standard-dds-dx7-container)

*   Magic: `DDS` followed by a 124-[byte](https://en.wikipedia.org/wiki/Byte)
     header.
*   Important header fields:
    *   `dwFlags` bit `0x00020000` signals mipmap count; otherwise one mipmap is assumed.
    *   `dwHeight`, `dwWidth` validated up to 0x8000.
    *   `DDPIXELFORMAT` describes layout:
        *   FourCC `DXT1` --> TPC `DXT1`
        *   FourCC `DXT3` --> TPC `DXT3`
        *   FourCC `DXT5` --> TPC `DXT5`
        *   Uncompressed 32-bit BGRA masks (`00FF0000/0000FF00/000000FF/FF000000`) --> TPC `BGRA`
        *   Uncompressed 24-bit BGR masks (`00FF0000/0000FF00/000000FF`) --> TPC `BGR`
        *   16-bit ARGB 1-5-5-5 (`7C00/03E0/001F/8000`) --> converted to RGBA
        *   16-bit ARGB 4-4-4-4 (`0F00/00F0/000F/F000`) --> converted to RGBA
        *   16-bit RGB 5-6-5 (`F800/07E0/001F/0`) --> converted to RGB
    *   Cubemap detection via `dwCaps2 & 0x00000200`; faces counted from `dwCaps2 & 0x0000FC00`.
*   Each mip size is computed with the format-aware block sizing from `TPCTextureFormat.get_size`.
*   Data layouts not directly usable (4444, 1555, 565) are expanded into RGBA/RGB before storing in the `TPC` object. PyKotor implements this in [`io_dds.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py)
     (standard DDS path and format mapping); [xoreos `dds.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp)
     and [xoreos-tools `dds.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/images/dds.cpp)
     implement the same [mask](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types)
     checks.

### BioWare DDS variant

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#bioware-dds-variant)

| Field | Type | Description |
| --- | --- | --- |
| width | UInt32 (LE) | Image width, must be a power of two and less than 0x8000 |
| height | UInt32 (LE) | Image height, must be a power of two and less than 0x8000 |
| bytesPerPixel | UInt32 (LE) | Pixel format: `3` = DXT1, `4` = DXT5 |
| dataSize | UInt32 (LE) | Size in bytes; must be `(width*height)/2` for DXT1, or `width*height` for DXT5 |
| unused float | Float32 (LE) | Ignored (unused float value follows header) |
| payload | Byte array | Compressed texture data, may include multiple mipmaps until all data consumed |
| mipmap count | Inferred | Determined by computing expected mip sizes until reading all data |
| palette/layout | n/a | Always compressed; no palettes or alternative pixel layouts supported |

No file magic is present in this format. Payload is always compressed data (DXT1 or DXT5); there is no support for palettes or uncompressed formats. PyKotor implements the BioWare header path in [`io_dds.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py)
; the same BioWare branch is available in [xoreos `dds.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp)
 for comparison.

### Writer Behaviour (PyKotor)

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#writer-behaviour-pykotor)

*   `TPCDDSWriter` emits only standard DDS headers:
    *   Supports _DXT1_, _DXT3_, _DXT5_, and uncompressed _BGR/BGRA_.
    *   Non-DDS-friendly formats are converted (_RGB_→_BGR_, _RGBA_→_BGRA_).
    *   Mipmap counts validated per layer; cubemaps set caps (_DDSCAPS2\_CUBEMAP_|_ALLFACES_).
*   Payloads are written in the already-compressed/uncompressed form stored in the [_TPC_](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     instance; no re-compression occurs.

### Detection and Routing

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#detection-and-routing)

*   `detect_tpc()` now returns `ResourceType.DDS` when:
    *   File extension is `.dds`, or
    *   Magic `DDS` is present, or
    *   BioWare header heuristics match width/height/bpp/dataSize.
*   `read_tpc()` dispatches to `TPCDDSReader` when `ResourceType.DDS` is detected.
*   `write_tpc(..., ResourceType.DDS)` routes to `TPCDDSWriter`.

### Testing coverage

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#testing-coverage)

*   [`Libraries/PyKotor/tests/resource/formats/test_dds.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/tests/resource/formats/test_dds.py)
    *   Standard DDS _DXT1_ load/write roundtrip
    *   _BioWare_ DDS multi-mip parsing
    *   Uncompressed _BGRA_ header parsing
    *   Writer roundtrip for _DXT1_ payloads

### Practical differences vs. TGA/TPC

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#practical-differences-vs-tgatpc)

*   **TGA**: uncompressed/RLE raster data; no block compression; single [face](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#face-structure)
     only; origin/alpha flags live in the header. DDS can be block-compressed (_DXT1/DXT5_) and include cubemap [faces](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#face-structure)
    /mip hierarchies in one container.
*   **TPC**: _KotOR_\-specific container with [TXI](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     embedded and different header layout
*   PyKotor maps DDS surfaces into [_TPC_](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     objects for unified downstream handling (conversion, [TXI](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     logic, cubemap normalization).

### Notes and limits

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#notes-and-limits)

*   Palette-based DDS (_DDPF\_INDEXED_) is rejected.
*   Dimensions beyond 0x8000 are rejected, matching xoreos limits.
*   _BioWare_ DDS may require **power-of-two** sizes; standard DDS does not enforce power-of-two beyond the existing dimension guard.

### See also

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#see-also)

*   [Resource formats and resolution](https://github.com/OpenKotOR/PyKotor/wiki/Resource-Formats-and-Resolution)
     - [Resource type identifiers](https://github.com/OpenKotOR/PyKotor/wiki/Resource-Formats-and-Resolution#resource-type-identifiers)
     (`DDS` / `0x07F1`)
*   [TPC File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     - _KotOR_'s primary texture format
*   PyKotor maps DDS into [_TPC_](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
    .
*   [TXI File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     - Texture metadata used with [_TPC_](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
    .
*   [KEY File Format](https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key)
     - Resource resolution order for DDS by [ResRef](https://github.com/OpenKotOR/PyKotor/wiki/Concepts#resref-resource-reference)
    .

* * *

KotOR TPC file format Documentation
===================================

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-tpc-file-format-documentation)

TPC (texture Pack Container) is KotOR's native texture format. It supports paletteless RGB/RGBA, greyscale, and block-compressed DXT1/DXT3/DXT5 data, optional mipmaps, cube maps, and [flipbook animations](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#animation-and-flipbooks)
 controlled by companion [TXI files](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
. TPC files are resolved using the same [resource resolution order](https://github.com/OpenKotOR/PyKotor/wiki/Concepts#resource-resolution-order)
 as other resources:

*   [override](https://github.com/OpenKotOR/PyKotor/wiki/Concepts#override-folder)
    
*   MOD/SAV (see [ERF](https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf)
    )
*   [KEY/BIF](https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key)
    

Table of Contents
-----------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#table-of-contents-1)

*   TPC — Texture Pack Container
    *   Table of Contents
    *   File Structure Overview
    *   [Header Layout](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#header-layout)
        
    *   [Pixel Formats](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#pixel-formats)
        
    *   [Mipmaps, Layers, and Animation](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#mipmaps-layers-and-animation)
        
    *   [Cube Maps](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#cube-maps)
        
    *   [TXI Metadata](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi-metadata)
        
    *   [Cross-reference: implementations](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#cross-reference-implementations)
        

* * *

File structure overview
-----------------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#file-structure-overview)

| Offset | Size | Description |
| --- | --- | --- |
| 0 (0x00) | 4   | data size (0 for uncompressed RGB; compressed textures store total bytes) |
| 4 (0x04) | 4   | Alpha test/threshold float |
| 8 (0x08) | 2   | Width ([uint16](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types)<br>) |
| 10 (0x0A) | 2   | Height ([uint16](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types)<br>) |
| 12 (0x0C) | 1   | Pixel encoding flag |
| 13 (0x0D) | 1   | Mipmap count |
| 14 (0x0E) | 114 (0x72) | Reserved / padding |
| 128 (0x80) | \-- | texture data (per layer, per mipmap) |
| ... | \-- | Optional ASCII [TXI](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)<br> footer |

This structure is parsed identically by [PyKotor](https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc)
, [reone](https://github.com/seedhartha/reone)
 ([`tpcreader.cpp`](https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/tpcreader.cpp)
), [xoreos](https://github.com/xoreos/xoreos)
 ([`tpc.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp)
), [KotOR.js](https://github.com/KobaltBlu/KotOR.js)
 ([`TPCObject.ts`](https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts)
), [KotOR-Unity](https://github.com/reubenduncan/KotOR-Unity)
 ([`TextureResource.cs`](https://github.com/reubenduncan/KotOR-Unity/blob/master/Assets/Scripts/FileObjects/TextureResource.cs)
), [NorthernLights](https://github.com/lachjames/NorthernLights)
 ([`TPC.cs`](https://github.com/lachjames/NorthernLights/blob/master/src/Graphics/Textures/TPC.cs)
), [xoreos-tools](https://github.com/xoreos/xoreos-tools)
 ([`tpc.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp)
), and the original BioWare tools. The standalone [tga2tpc](https://deadlystream.com/files/file/1152-tga2tpc/)
 converter ([upstream](https://github.com/ndixUR/tga2tpc/tree/758f3dbd155356408abc36508b1e10fa4a83f22a)
 / [mirror](https://github.com/th3w1zard1/tga2tpc/tree/758f3dbd155356408abc36508b1e10fa4a83f22a)
) also reads this header to produce TPC output.

For community discussion of TGA vs. TPC workflows, see [Mod installation order and TGA vs. TPC files on Deadly Stream](https://deadlystream.com/topic/11056-mod-installation-order-and-tga-vs-tpc-files/)
 (pair with [Concepts](https://github.com/OpenKotOR/PyKotor/wiki/Concepts#resource-resolution-order)
 for authoritative override/MOD order). The [tga2tpc tool](https://deadlystream.com/topic/5732-tooltga2pc/)
 ([file hub](https://deadlystream.com/files/file/1152-tga2tpc/)
) converts TGA to TPC; some animated frame aspect ratios are reported to misbehave when converting — verify in-game. For TPC-to-TGA or inspection, prefer Holocron/PyKotor, [xoreos-tools](https://github.com/xoreos/xoreos-tools)
, or other readers listed above.

### See also

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#see-also-1)

*   [TXI File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     - Metadata companion for TPC textures
*   [MDL/MDX File Format](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
     - [models](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
     that reference TPC textures
*   [GFF-GUI](https://github.com/OpenKotOR/PyKotor/wiki/GFF-GUI)
     - [GUI](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gui-graphical-user-interface)
     files that reference TPC textures for UI elements
*   [Resource formats and resolution](https://github.com/OpenKotOR/PyKotor/wiki/Resource-Formats-and-Resolution#resource-type-identifiers)
     - `TPC` / texture type IDs in archives

* * *

Header layout
-------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#header-layout)

| Field | Description |
| --- | --- |
| `data_size` | If non-zero, specifies total compressed payload size; uncompressed textures set this to 0 and derive size from format/width/height. |
| `alpha_test` | Float threshold used by punch-through rendering (commonly `0.0` or `0.5`). |
| `pixel_encoding` | Bitfield describing format (see next section). |
| `mipmap_count` | Number of mip levels per layer (minimum 1). |
| Reserved | 0x72 bytes reserved; KotOR stores platform hints here but all implementations skip them. |

*   [`io_tpc.py` L132-L186 (`TPCBinaryReader.load`)](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L132-L186)
     - header fields, compressed/uncompressed size handling, optional TXI footer string
*   [`io_tpc.py` L419-L427 (`TPCBinaryWriter.write`)](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L419-L427)
     - header serialization

* * *

Pixel formats
-------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#pixel-formats)

TPC supports the following encodings (documented in [`TPCTextureFormat` L54–L178](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L54-L178)
):

| Encoding | Description | Notes |
| --- | --- | --- |
| `0x01` (Greyscale) | 8-bit luminance | Stored as linear bytes |
| `0x02` (RGB) | 24-bit RGB | Linear bytes, may be swizzled on Xbox |
| `0x04` (RGBA) | 32-bit RGBA | Linear bytes |
| `0x0C` (BGRA) | 32-bit BGRA swizzled | Xbox-specific swizzle; PyKotor deswizzles on load |
| DXT1 | Block-compressed (4×4 blocks, 8 bytes) | Detected via `data_size` and encoding flags |
| DXT3/DXT5 | Block-compressed (4×4 blocks, 16 bytes) | Chosen based on `pixel_type` and compression flag |

* * *

Mipmaps, Layers, and [animation](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#animation-header)

-----------------------------------------------------------------------------------------------------------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#mipmaps-layers-and-animation)

*   Each texture can have multiple **layers** (used for cube maps or animated flipbooks).
*   Every layer stores `mipmap_count` levels. For uncompressed textures, each level’s size equals `width × height × bytes_per_pixel`; for DXT formats it equals the block size calculation.
*   Animated textures rely on [TXI](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     fields (`proceduretype cycle`, `numx`, `numy`, `fps`). PyKotor splits the sprite sheet into layers and recalculates mip counts per frame ([`io_tpc.py` L216-L285](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L216-L285)
    ).

* * *

Cube Maps
---------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#cube-maps)

*   Detected when the stored height is exactly six times the width for compressed textures (`DXT1/DXT5`).
*   PyKotor normalizes cube [faces](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#face-structure)
     after reading (deswizzle + rotation) so that [face](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#face-structure)
     ordering matches the high-level texture API.
*   Reone and KotOR.js use the same inference logic, so the cube-map detection below mirrors their behavior ([`io_tpc.py` L158–L304](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L158-L304)
     — cube-map detection, layer/mipmap read loop, BGRA deswizzle, `_normalize_cubemaps`).

* * *

[TXI](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
 Metadata
------------------------------------------------------------------------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi-metadata)

*   If bytes remain after the texture payload, they are treated as ASCII [TXI](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     content.
*   [TXI](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     commands drive [animations](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#animation-header)
    , environment mapping, font metrics, downsampling directives, etc. See the [TXI File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     document for exhaustive command descriptions.
*   PyKotor automatically parses the [TXI](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     footer and exposes `TPC.txi` plus convenience flags (`is_animated`, `is_cube_map`) via [`io_tpc.py` L179–L197](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L179-L197)
    .

* * *

Cross-reference: implementations
--------------------------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#cross-reference-implementations)

*   **Binary Reader/Writer:** [`Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py)
    
*   **data [model](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
     & Conversion Utilities:** [`Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py)
    
*   **Reference Implementations:**
    *   **[reone](https://github.com/seedhartha/reone)
        **: [`src/libs/graphics/format/tpcreader.cpp`](https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/tpcreader.cpp)
        
    *   **[xoreos-tools](https://github.com/xoreos/xoreos-tools)
        **: [`src/images/tpc.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp)
        
    *   **[tga2tpc](https://github.com/ndixUR/tga2tpc)
        **
    *   **[KotOR.js](https://github.com/KobaltBlu/KotOR.js)
        **: [`src/loaders/TextureLoader.ts`](https://github.com/KobaltBlu/KotOR.js/blob/master/src/loaders/TextureLoader.ts)
        

All of the engines listed above treat the header and mipmap data identically. The only notable difference is that KotOR.js converts TPC textures to WebGL-compatible textures internally via [`TextureLoader.ts`](https://github.com/KobaltBlu/KotOR.js/blob/master/src/loaders/TextureLoader.ts)
, but it imports/exports the same TPC binary format.

### See also

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#see-also-2)

*   [TXI File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     - Metadata companion for TPC textures
*   [MDL/MDX File Format](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
     - Models that reference TPC textures
*   [GFF-GUI](https://github.com/OpenKotOR/PyKotor/wiki/GFF-GUI)
     - GUI files that reference TPC textures for UI elements
*   [DDS File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds)
     - Alternative texture format (standard/BioWare variant)
*   [Resource formats and resolution](https://github.com/OpenKotOR/PyKotor/wiki/Resource-Formats-and-Resolution#resource-type-identifiers)
     - Resource type IDs

* * *

KotOR PLT file format Documentation (NWN legacy)
================================================

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy)

> **⚠️ NOT USED IN KOTOR**: This format is **Neverwinter Nights-specific** and is **NOT used in KotOR games** \[[`ResourceType.PLT` L247+](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L247)\
>  registers the legacy type id but no `plt/` reader/writer exists in PyKotor\]. While the PLT resource type (`0x0006`) exists in KotOR's resource system due to shared _Aurora_ engine heritage, **KotOR does not load, parse, or use PLT files**. KotOR uses standard [Textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
>  instead, including:
> 
> *   [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
>     
> *   TGA
> *   DDS
> 
> …for all surface work, including character [models](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
> . This documentation is provided for reference only, as NWN-derived tools may encounter PLT resource type identifiers when working with KotOR's resource system.

_PLT_ ([Texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 Palette File) is a variant [Texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 format used in **Neverwinter Nights** that allows runtime color palette selection. Instead of fixed colors, _PLT_ files store palette group indices and color indices that reference external palette files, enabling dynamic color customization for character [models](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
 (skin, hair, armor colors, etc.).

**Resource type SSOT:** KotOR's primary on-disk texture types (`TPC` `0x07D1`, `DDS` `0x07F1`, etc.) are tabulated on [Resource formats and resolution](https://github.com/OpenKotOR/PyKotor/wiki/Resource-Formats-and-Resolution#resource-type-identifiers)
. **`PLT` / `0x0006`** is an Aurora legacy id present in shared type tables; it is **not** a KotOR shipping format—see this page and [TPC File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 for what the games actually load. PyKotor registers the legacy type id in [`ResourceType.PLT` L247+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/type.py#L247)
 and provides a documentation-only Kaitai layout in [`kaitai_generated/plt.py` L11+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/kaitai_generated/plt.py#L11)
. Xoreos implements NWN PLT loading in [`src/graphics/aurora/pltfile.cpp` L1+](https://github.com/xoreos/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/aurora/pltfile.cpp#L1)
 with creature usage in [`creature.cpp` L573–L589](https://github.com/xoreos/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/engines/nwn/creature.cpp#L573-L589)
 (Torlack spec: [xoreos-docs `specs/torlack/plt.html`](https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html)
). Reone, KotOR.js, and Kotor.NET all use TPC for KotOR textures and have no PLT path.

Table of Contents
-----------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#table-of-contents-2)

*   PLT — Palette Texture (NWN legacy)
    *   Table of Contents
    *   [File Structure Overview](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#file-structure-overview)
        
    *   [Palette System](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#palette-system)
        *   [Palette Groups](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#palette-groups)
            
        *   [Color Resolution Process](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#color-resolution-process)
            
    *   [Binary Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#binary-format)
        *   [File Header](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#file-header)
            
        *   [Pixel Data](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#pixel-data)
            
    *   [Cross-reference: implementations](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#cross-reference-implementations)
        

* * *

File Structure Overview
-----------------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#file-structure-overview-1)

_PLT_ files work in conjunction with external palette files (`.PAL` files) that contain the actual color values. The _PLT_ file itself stores:

1.  **Palette Group index**: Which palette group (0-9) to use for each pixel
2.  **Color Index**: Which color (0-255) within the selected palette to use

At runtime, the game:

1.  Loads the appropriate palette file for the selected palette group
2.  Uses the palette index (supplied by the content creator) to select a row in the palette file
3.  Uses the color index from the _PLT_ file to retrieve the final color value

* * *

Palette System
--------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#palette-system)

### Palette Groups

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#palette-groups)

There are ten palette groups, each corresponding to a different [Material](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#trimesh-header)
 Type on character [Models](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
:

| Group index | Name | Description | Palette file Example |
| --- | --- | --- | --- |
| 0   | Skin | Character skin tones | `pal_skin01.jpg` |
| 1   | Hair | Hair colors | `pal_hair01.jpg` |
| 2   | Metal 1 | Primary metal/armor colors | `pal_armor01.jpg` |
| 3   | Metal 2 | Secondary metal/armor colors | `pal_armor02.jpg` |
| 4   | Cloth 1 | Primary fabric/clothing colors | `pal_cloth01.jpg` |
| 5   | Cloth 2 | Secondary fabric/clothing colors | `pal_cloth01.jpg` |
| 6   | Leather 1 | Primary leather [Material](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#trimesh-header)<br> colors | `pal_leath01.jpg` |
| 7   | Leather 2 | Secondary leather [Material](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#trimesh-header)<br> colors | `pal_leath01.jpg` |
| 8   | Tattoo 1 | Primary tattoo/body paint colors | `pal_tattoo01.jpg` |
| 9   | Tattoo 2 | Secondary tattoo/body paint colors | `pal_tattoo01.jpg` |

**Palette File Structure**: Each palette file contains 256 rows (one for each palette index `0-255`), with each row containing 256 color values (one for each color index `0-255`); the full table of group names and example palette files is specified in [xoreos-docs `specs/torlack/plt.html`](https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html)
.

### Color Resolution Process

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#color-resolution-process)

To determine the final color for a pixel in a _PLT_ [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
:

1.  **Get Palette Group**: Read the palette group index (0-9) from the _PLT_ pixel data
2.  **Get Palette index**: Retrieve the palette index (`0-255`) for that group from the content creator's settings (supplied at runtime, not stored in _PLT_)
3.  **Select Palette Row**: Use the palette index to select a row in the corresponding palette file
4.  **Get Color Index**: Read the color index (`0-255`) from the _PLT_ pixel data
5.  **Retrieve color**: Use the color index to get the final RGB color value from the selected palette row

**Example**: A pixel with palette group index `2` (_Metal 1_) and color index `128` (`128` being the color index within the selected palette):

*   If the content creator selected palette index `5` for _Metal 1_
*   The game loads `pal_armor01.jpg` and reads row 5, column 128
*   The RGB value at that position becomes the pixel's color

* * *

Binary Format
-------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#binary-format)

### File Header

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#file-header)

The _PLT_ file header is 24 bytes:

| Name | Type | Offset | Size | Description |
| --- | --- | --- | --- | --- |
| Signature | [Char](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types) | 0 (0x0000) | 4   | Always `"PLT "` (space-padded) |
| Version | [Char](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types) | 4 (0x0004) | 4   | Always `"V1 "` (space-padded) |
| Unknown | UInt32 | 8 (0x0008) | 4   | Unknown value |
| Unknown | UInt32 | 12 (0x000C) | 4   | Unknown value |
| Width | UInt32 | 16 (0x0010) | 4   | [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> width in pixels |
| Height | UInt32 | 20 (0x0014) | 4   | [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> height in pixels |

### Pixel Data

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#pixel-data)

Following the header, pixel data is stored as an array of 2-[Bytes](https://en.wikipedia.org/wiki/Byte)
 structures. There are `width × height` pixel entries.

Each pixel entry is 2 bytes:

| Name | Type | Offset | Size | Description |
| --- | --- | --- | --- | --- |
| Color Index | [UInt8](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types) | 0 (0x0000) | 1   | color index (`0-255`) within the selected palette |
| Palette Group Index | [UInt8](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types) | 1 (0x0001) | 1   | Palette group index (`0-9`) |

**Pixel Data Layout**: Pixels are stored row by row, left to right, top to bottom. The total pixel data size is `width × height × 2` bytes; the complete binary layout is specified in [xoreos-docs `specs/torlack/plt.html`](https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html)
.

* * *

Cross-reference: implementations
--------------------------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#cross-reference-implementations-1)

**KotOR vs Neverwinter Nights**:

*   **Neverwinter Nights**: _PLT_ files are actively used for character customization. The [xoreos](https://github.com/xoreos/xoreos)
     engine includes a complete _PLT_ implementation ([`pltfile.cpp` L1+](https://github.com/xoreos/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/aurora/pltfile.cpp#L1)
    ) that is used in _NWN_'s creature system ([`creature.cpp` L573-L589](https://github.com/xoreos/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/engines/nwn/creature.cpp#L573-L589)
    ).
    
*   **KotOR**: While the _PLT_ resource type (`0x0006`) is defined in _KotOR_'s resource type system, **_PLT_ files are not actually used in _KotOR_ games**. _KotOR_ uses standard [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     [Textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     for all [Textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
    , including character [Models](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
    . No _KotOR_\-specific implementations load or parse _PLT_ files.
    

**Why Document _PLT_ for KotOR?**: The format is documented here because:

1.  The resource type exists in _KotOR_'s resource system (shared _Aurora_ engine heritage)
2.  _NWN_\-derived tools may need to understand _PLT_ when working with _KotOR_ resources
3.  Many remaining _PLT_ files exist in both _K1_ and _TSL_'s data and installations, remnant of the prior games/engines.

### See also

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#see-also-3)

*   [Resource formats and resolution](https://github.com/OpenKotOR/PyKotor/wiki/Resource-Formats-and-Resolution)
     - [Resource type identifiers](https://github.com/OpenKotOR/PyKotor/wiki/Resource-Formats-and-Resolution#resource-type-identifiers)
     (context for `0x0006` vs KotOR `0x07xx` textures)
*   [TPC File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     - _KotOR_'s native texture format (used instead of _PLT_ in _KotOR_)
*   [TXI File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi)
     - Texture metadata used with _TPC_
*   [Bioware Aurora PaletteITP](https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Module-and-Area#paletteitp)
     - Related Palette/ITP specification

* * *

* * *

KotOR TXI file format Documentation
===================================

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-txi-file-format-documentation)

TXI ([texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 Info) files are compact ASCII descriptors that attach metadata to [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 [textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
. They control mipmap usage, filtering, [flipbook animation](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#animation-and-flipbooks)
, environment mapping, font atlases, and platform-specific downsampling. Every TXI file is parsed at runtime to configure how a [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 image is rendered. TXI files are resolved using the same [resource resolution order](https://github.com/OpenKotOR/PyKotor/wiki/Concepts#resource-resolution-order)
 as other resources (override, MOD/SAV, KEY/BIF). TXI is typically embedded in a [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 or shipped as a sibling `.txi` file alongside the texture (see [HoloPatcher: mod packaging](https://github.com/OpenKotOR/PyKotor/wiki/HoloPatcher#mod-developers)
); it accompanies [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 textures and is referenced from [MDL/MDX](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
 surface materials and [GFF-GUI](https://github.com/OpenKotOR/PyKotor/wiki/GFF-GUI)
 interface elements.

Table of Contents
-----------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#table-of-contents-3)

*   TXI — Texture Information
    *   Table of Contents
    *   [Format overview](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#format-overview)
        
    *   [Syntax](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#syntax)
        *   [Command Lines](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#command-lines)
            
        *   [Coordinate blocks](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#coordinate-blocks)
            
    *   [Command Reference](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#command-reference)
        *   [Rendering and Filtering](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#rendering-and-filtering)
            
        *   [Material and environment controls](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#material-and-environment-controls)
            
        *   [Animation and flipbooks](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#animation-and-flipbooks)
            
        *   [Font Atlas Layout](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#font-atlas-layout)
            
        *   [Streaming and Platform Hints](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#streaming-and-platform-hints)
            
    *   [Relationship to TPC textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#relationship-to-tpc-textures)
        *   [Empty TXI files](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#empty-txi-files)
            
    *   [Cross-reference: implementations](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#cross-reference-implementations-1)
        

* * *

Format overview
---------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#format-overview)

*   TXI files are plain-text key/value lists; each command modifies a field in the [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     runtime metadata.
*   Commands are case-insensitive but conventionally lowercase. values can be integers, floats, booleans (`0`/`1`), [ResRefs](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types)
    , or multi-line coordinate tables.
*   A single TXI can be appended to the end of a `.tpc` file (as Bioware does) or shipped as a sibling `.txi` file; the parser treats both identically.

**Implementation (PyKotor):**

*   ASCII/binary TXI parse loop [`TXIBinaryReader.load` L43+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/txi/io_txi.py#L43)
    
*   in-memory [`TXI` L94+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py#L94)
    
*   [`TXICommand` L721+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py#L721)
    

**Cross-reference:**

*   **[reone](https://github.com/seedhartha/reone)
    **:
    
    *   [`TxiReader::load` L28+](https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/txireader.cpp#L28)
        
    *   [`processLine` L55+](https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/txireader.cpp#L55)
        
*   **[xoreos](https://github.com/xoreos/xoreos)
    **
    
    *   [`src/graphics/images/txi.cpp` L1+](https://github.com/xoreos/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/txi.cpp#L1)
         (Aurora TXI)
*   **[KotOR.js](https://github.com/KobaltBlu/KotOR.js)
    **:
    
    *   [`TXI` L16+](https://github.com/KobaltBlu/KotOR.js/blob/ea9491d5c783364cf285f178434b84405bee3608/src/resource/TXI.ts#L16)
        
    *   [command enums `src/enums/graphics/txi/`](https://github.com/KobaltBlu/KotOR.js/tree/master/src/enums/graphics/txi)
        
*   **[KotOR-Unity](https://github.com/reubenduncan/KotOR-Unity)
    **
    
    *   [`TXI.cs` L1+](https://github.com/reubenduncan/KotOR-Unity/blob/da59c0e3b16e351479e543d455bb39b6811f7239/Assets/Scripts/Resource/TXI.cs#L1)
        
*   **[Kotor.NET](https://github.com/NickHugi/Kotor.NET)
    **:
    
    *   [`Kotor.NET/Formats/KotorTXI/TXI.cs` L8+ (modifier DTOs / `RawString()` helpers)](https://github.com/NickHugi/Kotor.NET/blob/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2/Kotor.NET/Formats/KotorTXI/TXI.cs#L8)
        
    *   [`TXIReader.cs` L13+ (reader scaffold; verify behavior on default branch before relying on `Read()`)](https://github.com/NickHugi/Kotor.NET/blob/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2/Kotor.NET/Formats/KotorTXI/TXIReader.cs#L13)
        

### See also

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#see-also-4)

*   [TPC File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     - texture format that TXI metadata describes
*   [MDL/MDX File Format](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
     - models that reference textures with TXI metadata

* * *

Syntax
------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#syntax)

### Command Lines

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#command-lines)

    <command> <value(s)>
    

*   Whitespace between command and value is ignored beyond the first separator.
*   Boolean toggles use `0` or `1`.
*   Multiple values (e.g., `channelscale 1.0 0.5 0.5`) are space-separated.
*   Comments are not supported; unknown commands are skipped.

### Coordinate blocks

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#coordinate-blocks)

Commands such as `upperleftcoords` and `lowerrightcoords` declare the number of rows, followed by that many lines of coordinates:

    upperleftcoords 96
    0.000000 0.000000 0
    0.031250 0.000000 0
    ...
    

Each line encodes a UV triplet; UV coordinates follow standard UV mapping conventions (normalized 0–1, `z` column unused).

* * *

Command Reference
-----------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#command-reference)

> The tables below summarize the commands implemented by PyKotor’s `TXICommand` enum. Values map directly to the fields described in [`txi_data.py`](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py)
> .

### Rendering and Filtering

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#rendering-and-filtering)

| Command | Accepted values | Description |
| --- | --- | --- |
| `mipmap` | `0`/`1` | Toggles engine mipmap usage (KotOR's sampler mishandles secondary mips; Bioware [textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> usually set `0`). |
| `filter` | `0`/`1` | Enables simple bilinear filtering of font atlases; `<1>` applies a blur. |
| `clamp` | `0`/`1` | Forces address mode clamp instead of wrap. |
| `candownsample`, `downsamplemin`, `downsamplemax`, `downsamplefactor` | ints/floats | Hints used by Xbox [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> reduction. |
| `priority` | integer | Streaming priority for on-demand textures (higher loads earlier). |
| `temporary` | `0`/`1` | Marks a [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> as discardable after use. |
| `ondemand` | `0`/`1` | Delays [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> loading until first reference. |

### [Material](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#trimesh-header)
 and environment controls

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#material-and-environment-controls)

| Command | Description |
| --- | --- |
| `blending` | Selects additive or punchthrough blending (see [`TXIBlending.ts`](https://github.com/KobaltBlu/KotOR.js/blob/master/src/enums/graphics/txi/TXIBlending.ts)<br>). |
| `decal` | Toggles decal rendering so polygons project onto [geometry](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#geometry-header)<br>. |
| `isbumpmap`, `isdiffusebumpmap`, `isspecularbumpmap` | flag the [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> as a bump/normal map; controls how [material](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#trimesh-header)<br> shaders sample it. |
| `bumpmaptexture`, `bumpyshinytexture`, `envmaptexture`, `bumpmapscaling` | Supply companion [textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> and scales for per-pixel lighting. |
| `cube` | Marks the [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> as a cube map; used with 6-[face](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#face-structure)<br> TPCs. |
| `unique` | Forces the renderer to keep a dedicated instance instead of sharing. |

### [Animation](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#animation-header)
 and flipbooks

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#animation-and-flipbooks)

[texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 flipbook animation relies on sprite sheets that tile frames across the atlas:

| Command | Description |
| --- | --- |
| `proceduretype` | Set to `cycle` to enable flipbook [animation](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#animation-header)<br>. |
| `numx`, `numy` | Horizontal/vertical frame counts. |
| `fps` | Frames per second for playback. |
| `speed` | Legacy alias for `fps` (still parsed for compatibility). |

When `proceduretype=cycle`, PyKotor splits the [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 into `numx × numy` layers and advances them at `fps` (see [`io_tpc.py:169-190`](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L169-L190)
).

### Font Atlas Layout

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#font-atlas-layout)

KotOR’s bitmap fonts use TXI commands to describe glyph boxes:

| Command | Description |
| --- | --- |
| `baselineheight`, `fontheight`, `fontwidth`, `caretindent`, `spacingB`, `spacingR` | Control glyph metrics for UI fonts. |
| `rows`, `cols`, `numchars`, `numcharspersheet` | Describe how many glyphs are stored per sheet. |
| `upperleftcoords`, `lowerrightcoords` | arrays of UV coordinates for each glyph corner. |
| `codepage`, `isdoublebyte`, `dbmapping` | Support multi-[byte](https://en.wikipedia.org/wiki/Byte)<br> font atlases (Asian locales). |

KotOR.js exposes identical structures in [`src/resource/TXI.ts`](https://github.com/KobaltBlu/KotOR.js/blob/ea9491d5c783364cf285f178434b84405bee3608/src/resource/TXI.ts#L16-L255)
, ensuring the coordinates here match the engine’s expectations.

### Streaming and Platform Hints

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#streaming-and-platform-hints)

| Command | Description |
| --- | --- |
| `defaultwidth`, `defaultheight`, `defaultbpp` | Provide fallback metadata for UI [textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> when resolution switching. |
| `xbox_downsample`, `maxSizeHQ`, `maxSizeLQ`, `minSizeHQ`, `minSizeLQ` | Limit [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)<br> resolution on Xbox hardware. |
| `filerange` | Declares a sequence of numbered files (used by some animated sprites). |
| `controllerscript` | Associates a scripted [controller](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#controllers)<br> for advanced animation (rare in KotOR). |

* * *

Relationship to [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 [textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)

----------------------------------------------------------------------------------------------------------------------------------------------------------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#relationship-to-tpc-textures)

*   A TXI modifies the rendering pipeline for its paired [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
    :
    
    *   Mipmap flags alter sampler state
    *   [Animation](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#animation-header)
         directives turn one [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
         into multiple layers
    *   [Material](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#trimesh-header)
         directives attach bump / shine maps
*   When embedded inside a `.tpc` file, the TXI text starts immediately after the binary payload
    
*   PyKotor reads it by seeking past the [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     data and consuming the remaining bytes as ASCII (`io_tpc.py:158-188`).
    
*   Exported `.txi` files are plain UTF-8 text and can be edited with any text editor; tools like `tga2tpc` and KotORBlender reserialize them alongside [TPC](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     assets.
    

### Empty TXI files

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#empty-txi-files)

Many TXI files in the game installation are **empty** (0 bytes). These empty TXI files serve as placeholders and indicate that the [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 should use default rendering settings. When a TXI file is empty or missing, the engine falls back to default [texture](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 parameters.

**Examples of [textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 with empty TXI files:**

*   `lda_bark04.txi` (0 bytes)
*   `lda_flr11.txi` (0 bytes)
*   `lda_grass07.txi` (0 bytes)
*   `lda_grate01.txi` (0 bytes)
*   `lda_ivy01.txi` (0 bytes)
*   `lda_leaf02.txi` (0 bytes)
*   `lda_lite01.txi` (0 bytes)
*   `lda_rock06.txi` (0 bytes)
*   `lda_sky0001.txi` through `lda_sky0005.txi` (0 bytes)
*   `lda_trim02.txi`, `lda_trim03.txi`, `lda_trim04.txi` (0 bytes)
*   `lda_unwal07.txi` (0 bytes)
*   `lda_wall02.txi`, `lda_wall03.txi`, `lda_wall04.txi` (0 bytes)

**Examples of [textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 with non-empty TXI files:**

*   `lda_ehawk01.txi` - Contains `envmaptexture CM_jedcom`
*   `lda_ehawk01a.txi` - Contains `envmaptexture CM_jedcom`
*   `lda_flr07.txi` - Contains `bumpyshinytexture CM_dantii` and `bumpmaptexture LDA_flr01B`

**Kit Generation Note:** When generating kits from module [RIM](https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim)
 archives, empty TXI files should still be created as placeholders even if they don't exist in the installation. This ensures kit completeness and matches the expected kit structure where many [textures](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
 have corresponding (empty) TXI files.

* * *

Cross-reference: implementations
--------------------------------

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#cross-reference-implementations-2)

*   **Parser:** [`io_txi.py` `TXIBinaryReader.load` L43+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/txi/io_txi.py#L43)
    
*   **Data model:** [`txi_data.py` `TXI` L94+](https://github.com/OpenKotOR/PyKotor/blob/a8daa4091b067e8424ae537793224e6b178ee9d8/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py#L94)
    
*   **Reference implementations:**
    *   [reone `txireader.cpp` L28+](https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/txireader.cpp#L28)
        
    *   [KotOR.js `TXI.ts` L16+](https://github.com/KobaltBlu/KotOR.js/blob/ea9491d5c783364cf285f178434b84405bee3608/src/resource/TXI.ts#L16)
        
    *   **tga2tpc** (texture conversion tooling)
        *   Upstream (ndixUR/tga2tpc): [https://github.com/ndixUR/tga2tpc/tree/758f3dbd155356408abc36508b1e10fa4a83f22a](https://github.com/ndixUR/tga2tpc/tree/758f3dbd155356408abc36508b1e10fa4a83f22a)
            
        *   Mirror (th3w1zard1/tga2tpc): [https://github.com/th3w1zard1/tga2tpc/tree/758f3dbd155356408abc36508b1e10fa4a83f22a](https://github.com/th3w1zard1/tga2tpc/tree/758f3dbd155356408abc36508b1e10fa4a83f22a)
            

These sources all interpret commands the same way, so the tables above map directly to the behavior you will observe in-game.

### See also

[](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#see-also-5)

*   [TPC File Format](https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc)
     - Texture format that TXI metadata describes
*   [MDL/MDX File Format](https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
     - Models that reference textures with TXI
*   [GFF-GUI](https://github.com/OpenKotOR/PyKotor/wiki/GFF-GUI)
     - GUI files that reference TPC/TXI for UI elements

* * *

* * *

### Clone this wiki locally

You can’t perform that action at this time.