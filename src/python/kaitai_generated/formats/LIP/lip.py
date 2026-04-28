# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Lip(KaitaiStruct):
    """**LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
    `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
    
    xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
    
    .. seealso::
       xoreos-tools — shipped CLI inventory (no LIP-specific tool) - https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/README.md#L17-L43
    
    
    .. seealso::
       PyKotor wiki — LIP - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip
    
    
    .. seealso::
       PyKotor — `io_lip` (Kaitai + legacy read/write) - https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116
    
    
    .. seealso::
       PyKotor — `LIPShape` enum - https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/lip/lip_data.py#L47-L127
    
    
    .. seealso::
       reone — `LipReader::load` - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/lipreader.cpp#L27-L41
    
    
    .. seealso::
       KotOR.js — `LIPObject.readBinary` - https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/LIPObject.ts#L99-L118
    
    
    .. seealso::
       NickHugi/Kotor.NET — `LIP` / `MouthShape` (wire-oriented types) - https://github.com/NickHugi/Kotor.NET/blob/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2/Kotor.NET/Formats/KotorLIP/LIP.cs#L9-L39
    
    
    .. seealso::
       xoreos — `kFileTypeLIP` (numeric id; no standalone `lipfile.cpp`) - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L180
    
    
    .. seealso::
       xoreos-docs — BioWare specs tree (no dedicated LIP Torlack/PDF; wire from PyKotor/reone) - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Lip, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
        self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
        self.length = self._io.read_f4le()
        self.num_keyframes = self._io.read_u4le()
        self.keyframes = []
        for i in range(self.num_keyframes):
            self.keyframes.append(Lip.KeyframeEntry(self._io, self, self._root))



    def _fetch_instances(self):
        pass
        for i in range(len(self.keyframes)):
            pass
            self.keyframes[i]._fetch_instances()


    class KeyframeEntry(KaitaiStruct):
        """A single keyframe entry mapping a timestamp to a viseme (mouth shape).
        Keyframes are used by the engine to interpolate between mouth shapes during
        audio playback to create lip sync animation.
        """
        def __init__(self, _io, _parent=None, _root=None):
            super(Lip.KeyframeEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.timestamp = self._io.read_f4le()
            self.shape = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareLipVisemeId, self._io.read_u1())


        def _fetch_instances(self):
            pass



