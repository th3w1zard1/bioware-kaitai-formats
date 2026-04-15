// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './TgaCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./TgaCommon'));
  } else {
    factory(root.Tga || (root.Tga = {}), root.KaitaiStream, root.TgaCommon || (root.TgaCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Tga_, KaitaiStream, TgaCommon_) {
/**
 * **TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
 * converts authoring TGAs to **TPC** for shipping.
 * 
 * Shared header enums: `formats/Common/tga_common.ksy`.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc|PyKotor wiki — textures (TPC/TGA pipeline)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40|PyKotor — compact TGA reader (`tga.py`)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120|PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177|xoreos — `TGA::readHeader`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L241|xoreos-tools — `TGA::load` through `readRLE` (tooling reader)}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs PDF tree}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html|xoreos-docs — KotOR MDL overview (texture pipeline context)}
 * @see {@link https://github.com/lachjames/NorthernLights|lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)}
 */

var Tga = (function() {
  function Tga(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Tga.prototype._read = function() {
    this.idLength = this._io.readU1();
    this.colorMapType = this._io.readU1();
    this.imageType = this._io.readU1();
    if (this.colorMapType == TgaCommon_.TgaCommon.TgaColorMapType.PRESENT) {
      this.colorMapSpec = new ColorMapSpecification(this._io, this, this._root);
    }
    this.imageSpec = new ImageSpecification(this._io, this, this._root);
    if (this.idLength > 0) {
      this.imageId = KaitaiStream.bytesToStr(this._io.readBytes(this.idLength), "ASCII");
    }
    if (this.colorMapType == TgaCommon_.TgaCommon.TgaColorMapType.PRESENT) {
      this.colorMapData = [];
      for (var i = 0; i < this.colorMapSpec.length; i++) {
        this.colorMapData.push(this._io.readU1());
      }
    }
    this.imageData = [];
    var i = 0;
    while (!this._io.isEof()) {
      this.imageData.push(this._io.readU1());
      i++;
    }
  }

  var ColorMapSpecification = Tga.ColorMapSpecification = (function() {
    function ColorMapSpecification(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ColorMapSpecification.prototype._read = function() {
      this.firstEntryIndex = this._io.readU2le();
      this.length = this._io.readU2le();
      this.entrySize = this._io.readU1();
    }

    /**
     * Index of first color map entry
     */

    /**
     * Number of color map entries
     */

    /**
     * Size of each color map entry in bits (15, 16, 24, or 32)
     */

    return ColorMapSpecification;
  })();

  var ImageSpecification = Tga.ImageSpecification = (function() {
    function ImageSpecification(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ImageSpecification.prototype._read = function() {
      this.xOrigin = this._io.readU2le();
      this.yOrigin = this._io.readU2le();
      this.width = this._io.readU2le();
      this.height = this._io.readU2le();
      this.pixelDepth = this._io.readU1();
      this.imageDescriptor = this._io.readU1();
    }

    /**
     * X coordinate of lower-left corner of image
     */

    /**
     * Y coordinate of lower-left corner of image
     */

    /**
     * Image width in pixels
     */

    /**
     * Image height in pixels
     */

    /**
     * Bits per pixel:
     * - 8 = Greyscale or indexed
     * - 16 = RGB 5-5-5 or RGBA 1-5-5-5
     * - 24 = RGB
     * - 32 = RGBA
     */

    /**
     * Image descriptor byte:
     * - Bits 0-3: Number of attribute bits per pixel (alpha channel)
     * - Bit 4: Reserved
     * - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
     * - Bits 6-7: Interleaving (usually 0)
     */

    return ImageSpecification;
  })();

  /**
   * Length of image ID field (0-255 bytes)
   */

  /**
   * Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.
   */

  /**
   * Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.
   */

  /**
   * Color map specification (only present if color_map_type == present)
   */

  /**
   * Image specification (dimensions and pixel format)
   */

  /**
   * Image identification field (optional ASCII string)
   */

  /**
   * Color map data (palette entries)
   */

  /**
   * Image pixel data (raw or RLE-compressed).
   * Size depends on image dimensions, pixel format, and compression.
   * For uncompressed formats: width × height × bytes_per_pixel
   * For RLE formats: Variable size depending on compression ratio
   */

  return Tga;
})();
Tga_.Tga = Tga;
});
