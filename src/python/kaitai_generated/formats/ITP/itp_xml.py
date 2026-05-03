# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class ItpXml(KaitaiStruct):
    """ITP XML format is a human-readable XML representation of ITP (Palette) binary files.
    ITP files use GFF format (FileType "ITP " in GFF header).
    Uses GFF XML structure with root element <gff3> containing <struct> elements.
    Each field has a label attribute and appropriate type element (byte, uint32, exostring, etc.).
    
    Canonical links: `meta.doc-ref` and `meta.xref`.
    
    .. seealso::
       PyKotor wiki — GFF (ITP is GFF-shaped) - https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
    
    
    .. seealso::
       xoreos — `GFF3File::readHeader` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/gff3file.cpp#L50-L63
    
    
    .. seealso::
       reone — `GffReader` (GFF3 / template ingestion; no standalone `itp.cpp` on `master`) - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/gffreader.cpp#L27-L225
    
    
    .. seealso::
       xoreos-docs — GFF_Format.pdf (binary GFF family behind ITP) - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/GFF_Format.pdf
    
    
    .. seealso::
       xoreos-docs — Torlack ITP / MultiMap (GFF-family context) - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/itp.html#L44-L49
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(ItpXml, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.xml_content = (self._io.read_bytes_full()).decode(u"UTF-8")


    def _fetch_instances(self):
        pass


