# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Txi(KaitaiStruct):
    """**Policy:** TXI is **plaintext** (line-oriented ASCII). This `.ksy` models only an opaque string span for tooling;
    authoritative command semantics live in PyKotor / reone parsers (`meta.xref`). xoreos consumes embedded TXI via **`TPC::readTXI`**
    (`meta.xref.xoreos_tpc_read_txi`), not a standalone `txifile.cpp`.
    
    TXI (Texture Info) files are compact ASCII descriptors that attach metadata to TPC textures.
    They control mipmap usage, filtering, flipbook animation, environment mapping, font atlases,
    and platform-specific downsampling. Every TXI file is parsed at runtime to configure how
    a TPC image is rendered.
    
    Format Structure:
    - Line-based ASCII text file (UTF-8 or Windows-1252)
    - Commands are case-insensitive but conventionally lowercase
    - Empty TXI files (0 (0x0) bytes) are valid and use default settings
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
    
    .. seealso::
       In-tree — `xoreos_file_type_id` / restype **2022** (`txi`) - https://github.com/OpenKotOR/bioware-kaitai-formats/blob/f4700f43f20337e01b8ef751a7c7d42e0acfb00a/formats/Common/bioware_type_ids.ksy
    
    
    .. seealso::
       PyKotor wiki — TXI - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi
    
    
    .. seealso::
       PyKotor — TXI reader (`TXIReaderMode`, `TXIBinaryReader.load` start) - https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/txi/io_txi.py#L20-L50
    
    
    .. seealso::
       PyKotor — `TXICommand` enum block - https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py#L619-L684
    
    
    .. seealso::
       reone — `TxiReader` ASCII parse (`load` + `processLine`) - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/txireader.cpp#L28-L125
    
    
    .. seealso::
       xoreos — `TPC::readTXI` (embedded TXI tail) - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L362-L373
    
    
    .. seealso::
       xoreos-tools — `TPC::readHeader` (texture tool stack; TXI pairs with TPC) - https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L77-L224
    
    
    .. seealso::
       xoreos — `kFileTypeTXI` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L88
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    
    
    .. seealso::
       xoreos-docs — KotOR MDL overview (TPC-attached TXI context) - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html
    
    
    .. seealso::
       KotOR.js — `TXI` + `ParseInfo` (ASCII command switch) - https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/TXI.ts#L16-L120
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Txi, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.content = (self._io.read_bytes_full()).decode(u"ASCII")


    def _fetch_instances(self):
        pass


