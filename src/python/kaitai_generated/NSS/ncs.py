# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Ncs(KaitaiStruct):
    """NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
    Scripts run inside a stack-based virtual machine shared across Aurora engine games.
    
    Format Structure:
    - Header (13 bytes): Signature "NCS ", version "V1.0", size marker (0x42), file size
    - Instruction Stream: Sequence of bytecode instructions
    
    All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).
    
    References:
    - https://github.com/OldRepublicDevs/PyKotor/wiki/NCS-File-Format.md - Complete NCS format documentation
    - NSS.ksy - NWScript source code that compiles to NCS
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Ncs, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
        if not self.file_type == u"NCS ":
            raise kaitaistruct.ValidationNotEqualError(u"NCS ", self.file_type, self._io, u"/seq/0")
        self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
        if not self.file_version == u"V1.0":
            raise kaitaistruct.ValidationNotEqualError(u"V1.0", self.file_version, self._io, u"/seq/1")
        self.size_marker = self._io.read_u1()
        if not self.size_marker == 66:
            raise kaitaistruct.ValidationNotEqualError(66, self.size_marker, self._io, u"/seq/2")
        self.file_size = self._io.read_u4be()
        self.bytecode = self._io.read_bytes(self.bytecode_size)


    def _fetch_instances(self):
        pass

    @property
    def bytecode_size(self):
        """Byte length of bytecode (total file size minus 13-byte header)."""
        if hasattr(self, '_m_bytecode_size'):
            return self._m_bytecode_size

        self._m_bytecode_size = (self.file_size - 13 if self.file_size >= 13 else 0)
        return getattr(self, '_m_bytecode_size', None)


