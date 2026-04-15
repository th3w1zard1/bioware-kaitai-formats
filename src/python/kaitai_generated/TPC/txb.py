# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Txb(KaitaiStruct):
    """**TXB** / **TXB2**: fixed **128-byte** header (`readHeader` in `txb.cpp`) followed by mip stacks and an optional
    trailing **TXI** text blob (not expanded here; see PyKotor wiki — `meta.xref`).
    
    Per-mip byte sizes depend on encoding and dimensions (`readData`); this spec keeps the tail as one opaque buffer.
    
    .. seealso::
       Source - https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Txb, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Txb.TxbHeader(self._io, self, self._root)
        self.pixel_and_optional_txi = self._io.read_bytes_full()


    def _fetch_instances(self):
        pass
        self.header._fetch_instances()

    class TxbHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Txb.TxbHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.data_size = self._io.read_u4le()
            self.unknown_float_a = self._io.read_f4le()
            self.width = self._io.read_u2le()
            self.height = self._io.read_u2le()
            self.encoding = self._io.read_u1()
            self.mip_map_count = self._io.read_u1()
            self.unknown_u2 = self._io.read_u2le()
            self.unknown_float_b = self._io.read_f4le()
            self.reserved = self._io.read_bytes(108)


        def _fetch_instances(self):
            pass



