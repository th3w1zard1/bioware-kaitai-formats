// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareCommon'));
  } else {
    factory(root.Tpc || (root.Tpc = {}), root.KaitaiStream, root.BiowareCommon || (root.BiowareCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Tpc_, KaitaiStream, BiowareCommon_) {
/**
 * **TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
 * (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
 * (`meta.xref`).
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc|PyKotor wiki — TPC}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303|PyKotor — `TPCBinaryReader` + `load`}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120|PyKotor — `TPCTextureFormat` (opening)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520|PyKotor — `class TPC` (opening)}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105|reone — `TpcReader` (body + TXI features)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L183|xoreos — `kFileTypeTPC`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L362|xoreos — `TPC::load` through `readTXI` entrypoints}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68|xoreos-tools — `TPC::load`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224|xoreos-tools — `TPC::readHeader`}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs PDF tree}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html|xoreos-docs — KotOR MDL overview (texture pipeline context)}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts#L290-L380|KotOR.js — `TPCObject.readHeader`}
 */

var Tpc = (function() {
  function Tpc(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Tpc.prototype._read = function() {
    this.header = new TpcHeader(this._io, this, this._root);
    this.body = this._io.readBytesFull();
  }

  var TpcHeader = Tpc.TpcHeader = (function() {
    function TpcHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    TpcHeader.prototype._read = function() {
      this.dataSize = this._io.readU4le();
      this.alphaTest = this._io.readF4le();
      this.width = this._io.readU2le();
      this.height = this._io.readU2le();
      this.pixelEncoding = this._io.readU1();
      this.mipmapCount = this._io.readU1();
      this.reserved = [];
      for (var i = 0; i < 114; i++) {
        this.reserved.push(this._io.readU1());
      }
    }

    /**
     * True if texture data is compressed (DXT format)
     */
    Object.defineProperty(TpcHeader.prototype, 'isCompressed', {
      get: function() {
        if (this._m_isCompressed !== undefined)
          return this._m_isCompressed;
        this._m_isCompressed = this.dataSize != 0;
        return this._m_isCompressed;
      }
    });

    /**
     * True if texture data is uncompressed (raw pixels)
     */
    Object.defineProperty(TpcHeader.prototype, 'isUncompressed', {
      get: function() {
        if (this._m_isUncompressed !== undefined)
          return this._m_isUncompressed;
        this._m_isUncompressed = this.dataSize == 0;
        return this._m_isUncompressed;
      }
    });

    /**
     * Total compressed payload size. If non-zero, texture is compressed (DXT).
     * If zero, texture is uncompressed and size is derived from format/width/height.
     */

    /**
     * Float threshold used by punch-through rendering.
     * Commonly 0.0 or 0.5.
     */

    /**
     * Texture width in pixels (uint16).
     * Must be power-of-two for compressed formats.
     */

    /**
     * Texture height in pixels (uint16).
     * For cube maps, this is 6x the face width.
     * Must be power-of-two for compressed formats.
     */

    /**
     * Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
     * `bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).
     */

    /**
     * Number of mip levels per layer (minimum 1).
     * Each mip level is half the size of the previous level.
     */

    /**
     * Reserved/padding bytes (0x72 = 114 bytes).
     * KotOR stores platform hints here but all implementations skip them.
     */

    return TpcHeader;
  })();

  /**
   * TPC file header (128 bytes total)
   */

  /**
   * Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).
   */

  return Tpc;
})();
Tpc_.Tpc = Tpc;
});
