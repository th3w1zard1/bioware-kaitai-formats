# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Bip(KaitaiStruct):
    """**BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
    framed wire lives in `LIP.ksy`.
    
    **TODO: VERIFY** full BIP layout against a KotOR PC build and PyKotor; until then this spec
    exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.
    
    .. seealso::
       xoreos — `kFileTypeBIP` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L197-L198
    
    
    .. seealso::
       PyKotor — `ResourceType.BIP` (3028; binary LIP comment) - https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/type.py#L1131-L1137
    
    
    .. seealso::
       reone — `ResType::Lip` (no separate BIP id in this enum) - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/include/reone/resource/types.h#L89-L96
    
    
    .. seealso::
       reone — `LipReader::load` (LIP wire; not BIP-specific) - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/lipreader.cpp#L27-L41
    
    
    .. seealso::
       xoreos-tools — shipped CLI inventory (no BIP-specific tool on `master`) - https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/README.md#L17-L43
    
    
    .. seealso::
       PyKotor wiki — LIP family - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip
    
    
    .. seealso::
       xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; verify wire with PyKotor / **observed behavior** on shipped builds when possible) - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Bip, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.payload = self._io.read_bytes_full()


    def _fetch_instances(self):
        pass


