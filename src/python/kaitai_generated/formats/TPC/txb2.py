# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import tpc


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Txb2(KaitaiStruct):
    """**TXB2** (`kFileTypeTXB2` **3017**): second-generation TXB id in `types.h`; treated like **TXB** / **TPC** by engine
    texture stacks. This capsule mirrors `TXB.ksy` (TPC header + opaque tail) until a divergent wire is proven.
    
    .. seealso::
       In-tree — `CResTPC::OnResourceServiced` (shared with TXB / TPC family; see `DDS.ksy` for K1/TSL **observed behavior** details) - https://github.com/OpenKotOR/bioware-kaitai-formats/blob/f4700f43f20337e01b8ef751a7c7d42e0acfb00a/formats/TPC/DDS.ksy
    
    
    .. seealso::
       xoreos — `kFileTypeTXB2` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L192
    
    
    .. seealso::
       xoreos — `TPC::load` (texture family) - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L52-L66
    
    
    .. seealso::
       xoreos-tools — `TPC::load` - https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L51-L68
    
    
    .. seealso::
       xoreos-tools — `TPC::readHeader` - https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L77-L224
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    
    
    .. seealso::
       xoreos-docs — KotOR MDL overview (texture pipeline context) - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html
    
    
    .. seealso::
       PyKotor wiki — texture family - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Txb2, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = tpc.Tpc.TpcHeader(self._io)
        self.body = self._io.read_bytes_full()


    def _fetch_instances(self):
        pass
        self.header._fetch_instances()


