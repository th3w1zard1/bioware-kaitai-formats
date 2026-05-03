# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Tpc(KaitaiStruct):
    """**TPC** (KotOR native texture): 128 (0x80)-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
    (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
    (`meta.xref`).
    
    .. seealso::
       In-tree — `CResTPC::OnResourceServiced` (128 (0x80)-byte header; K1 + TSL **observed behavior** in `DDS.ksy` `meta.xref`) - https://github.com/OpenKotOR/bioware-kaitai-formats/blob/f4700f43f20337e01b8ef751a7c7d42e0acfb00a/formats/TPC/DDS.ksy
    
    
    .. seealso::
       PyKotor wiki — TPC - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
    
    
    .. seealso::
       PyKotor — `TPCBinaryReader` + `load` - https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303
    
    
    .. seealso::
       PyKotor — `TPCTextureFormat` (opening) - https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120
    
    
    .. seealso::
       PyKotor — `class TPC` (opening) - https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520
    
    
    .. seealso::
       reone — `TpcReader` (body + TXI features) - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/tpcreader.cpp#L29-L105
    
    
    .. seealso::
       xoreos — `kFileTypeTPC` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L183
    
    
    .. seealso::
       xoreos — `TPC::load` through `readTXI` entrypoints - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L52-L362
    
    
    .. seealso::
       xoreos-tools — `TPC::load` - https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L51-L68
    
    
    .. seealso::
       xoreos-tools — `TPC::readHeader` - https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L77-L224
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    
    
    .. seealso::
       xoreos-docs — KotOR MDL overview (texture pipeline context) - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html
    
    
    .. seealso::
       KotOR.js — `TPCObject.readHeader` - https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/TPCObject.ts#L290-L380
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Tpc, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Tpc.TpcHeader(self._io, self, self._root)
        self.body = self._io.read_bytes_full()


    def _fetch_instances(self):
        pass
        self.header._fetch_instances()

    class TpcHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Tpc.TpcHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.data_size = self._io.read_u4le()
            self.alpha_test = self._io.read_f4le()
            self.width = self._io.read_u2le()
            self.height = self._io.read_u2le()
            self.pixel_encoding = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareTpcPixelFormatId, self._io.read_u1())
            self.mipmap_count = self._io.read_u1()
            self.reserved = []
            for i in range(114):
                self.reserved.append(self._io.read_u1())



        def _fetch_instances(self):
            pass
            for i in range(len(self.reserved)):
                pass


        @property
        def is_compressed(self):
            """True if texture data is compressed (DXT format)."""
            if hasattr(self, '_m_is_compressed'):
                return self._m_is_compressed

            self._m_is_compressed = self.data_size != 0
            return getattr(self, '_m_is_compressed', None)

        @property
        def is_uncompressed(self):
            """True if texture data is uncompressed (raw pixels)."""
            if hasattr(self, '_m_is_uncompressed'):
                return self._m_is_uncompressed

            self._m_is_uncompressed = self.data_size == 0
            return getattr(self, '_m_is_uncompressed', None)



