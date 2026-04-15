// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareCommon'));
  } else {
    factory(root.Dds || (root.Dds = {}), root.KaitaiStream, root.BiowareCommon || (root.BiowareCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Dds_, KaitaiStream, BiowareCommon_) {
/**
 * **DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
 * (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.
 * 
 * BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds|PyKotor wiki — DDS}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130|PyKotor — `TPCDDSReader` / `io_dds`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L98|xoreos — `kFileTypeDDS`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L55-L67|xoreos — `dds.cpp` load entry}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L141-L210|xoreos — BioWare headerless / Microsoft DDS branches}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/images/dds.cpp#L69-L158|xoreos-tools — `dds.cpp` (image tooling)}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs PDF tree (texture-adjacent PDFs)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html|xoreos-docs — KotOR MDL overview (engine texture pipeline context)}
 * @see {@link https://github.com/lachjames/NorthernLights|lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)}
 * @see {@link https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L57|reone — `ResourceType::Dds` (type id; TPC path in `tpcreader.cpp`)}
 */

var Dds = (function() {
  function Dds(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Dds.prototype._read = function() {
    this.magic = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!( ((this.magic == "DDS ") || (this.magic == "    ")) )) {
      throw new KaitaiStream.ValidationNotAnyOfError(this.magic, this._io, "/seq/0");
    }
    if (this.magic == "DDS ") {
      this.header = new DdsHeader(this._io, this, this._root);
    }
    if (this.magic != "DDS ") {
      this.biowareHeader = new BiowareDdsHeader(this._io, this, this._root);
    }
    this.pixelData = this._io.readBytesFull();
  }

  var BiowareDdsHeader = Dds.BiowareDdsHeader = (function() {
    function BiowareDdsHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareDdsHeader.prototype._read = function() {
      this.width = this._io.readU4le();
      this.height = this._io.readU4le();
      this.bytesPerPixel = this._io.readU4le();
      this.dataSize = this._io.readU4le();
      this.unusedFloat = this._io.readF4le();
    }

    /**
     * Image width in pixels (must be power of two, < 0x8000)
     */

    /**
     * Image height in pixels (must be power of two, < 0x8000)
     */

    /**
     * BioWare variant "bytes per pixel" (`u4`): DXT1 vs DXT5 block stride hint. Canonical: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
     */

    /**
     * Total compressed data size.
     * Must match (width*height)/2 for DXT1 or width*height for DXT5
     */

    /**
     * Unused float field (typically 0.0)
     */

    return BiowareDdsHeader;
  })();

  var Ddpixelformat = Dds.Ddpixelformat = (function() {
    function Ddpixelformat(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Ddpixelformat.prototype._read = function() {
      this.size = this._io.readU4le();
      if (!(this.size == 32)) {
        throw new KaitaiStream.ValidationNotEqualError(32, this.size, this._io, "/types/ddpixelformat/seq/0");
      }
      this.flags = this._io.readU4le();
      this.fourcc = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      this.rgbBitCount = this._io.readU4le();
      this.rBitMask = this._io.readU4le();
      this.gBitMask = this._io.readU4le();
      this.bBitMask = this._io.readU4le();
      this.aBitMask = this._io.readU4le();
    }

    /**
     * Structure size (must be 32)
     */

    /**
     * Pixel format flags:
     * - 0x00000001 = DDPF_ALPHAPIXELS
     * - 0x00000002 = DDPF_ALPHA
     * - 0x00000004 = DDPF_FOURCC
     * - 0x00000040 = DDPF_RGB
     * - 0x00000200 = DDPF_YUV
     * - 0x00080000 = DDPF_LUMINANCE
     */

    /**
     * Four-character code for compressed formats:
     * - "DXT1" = DXT1 compression
     * - "DXT3" = DXT3 compression
     * - "DXT5" = DXT5 compression
     * - "    " = Uncompressed format
     */

    /**
     * Bits per pixel for uncompressed formats (16, 24, or 32)
     */

    /**
     * Red channel bit mask (for uncompressed formats)
     */

    /**
     * Green channel bit mask (for uncompressed formats)
     */

    /**
     * Blue channel bit mask (for uncompressed formats)
     */

    /**
     * Alpha channel bit mask (for uncompressed formats)
     */

    return Ddpixelformat;
  })();

  var DdsHeader = Dds.DdsHeader = (function() {
    function DdsHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    DdsHeader.prototype._read = function() {
      this.size = this._io.readU4le();
      if (!(this.size == 124)) {
        throw new KaitaiStream.ValidationNotEqualError(124, this.size, this._io, "/types/dds_header/seq/0");
      }
      this.flags = this._io.readU4le();
      this.height = this._io.readU4le();
      this.width = this._io.readU4le();
      this.pitchOrLinearSize = this._io.readU4le();
      this.depth = this._io.readU4le();
      this.mipmapCount = this._io.readU4le();
      this.reserved1 = [];
      for (var i = 0; i < 11; i++) {
        this.reserved1.push(this._io.readU4le());
      }
      this.pixelFormat = new Ddpixelformat(this._io, this, this._root);
      this.caps = this._io.readU4le();
      this.caps2 = this._io.readU4le();
      this.caps3 = this._io.readU4le();
      this.caps4 = this._io.readU4le();
      this.reserved2 = this._io.readU4le();
    }

    /**
     * Header size (must be 124)
     */

    /**
     * DDS flags bitfield:
     * - 0x00001007 = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT
     * - 0x00020000 = DDSD_MIPMAPCOUNT (if mipmaps present)
     */

    /**
     * Image height in pixels
     */

    /**
     * Image width in pixels
     */

    /**
     * Pitch (uncompressed) or linear size (compressed).
     * For compressed formats: total size of all mip levels
     */

    /**
     * Depth for volume textures (usually 0 for 2D textures)
     */

    /**
     * Number of mipmap levels (0 or 1 = no mipmaps)
     */

    /**
     * Reserved fields (unused)
     */

    /**
     * Pixel format structure
     */

    /**
     * Capability flags:
     * - 0x00001000 = DDSCAPS_TEXTURE
     * - 0x00000008 = DDSCAPS_MIPMAP
     * - 0x00000200 = DDSCAPS2_CUBEMAP
     */

    /**
     * Additional capability flags:
     * - 0x00000200 = DDSCAPS2_CUBEMAP
     * - 0x00000FC00 = Cube map face flags
     */

    /**
     * Reserved capability flags
     */

    /**
     * Reserved capability flags
     */

    /**
     * Reserved field
     */

    return DdsHeader;
  })();

  /**
   * File magic. Either "DDS " (0x44445320) for standard DDS,
   * or check for BioWare variant (no magic, starts with width/height).
   */

  /**
   * Standard DDS header (124 bytes) - only present if magic is "DDS "
   */

  /**
   * BioWare DDS variant header - only present if magic is not "DDS "
   */

  /**
   * Pixel data (compressed or uncompressed); single blob to EOF.
   * For standard DDS: format determined by DDPIXELFORMAT.
   * For BioWare DDS: DXT1 or DXT5 compressed data.
   */

  return Dds;
})();
Dds_.Dds = Dds;
});
