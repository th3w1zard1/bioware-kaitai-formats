// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Plt || (root.Plt = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Plt_, KaitaiStream) {
/**
 * PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
 * palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
 * that reference external palette files, enabling dynamic color customization for character models
 * (skin, hair, armor colors, etc.).
 * 
 * **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
 * resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
 * does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
 * including character models. This documentation is provided for reference only.
 * 
 * Binary Format Structure:
 * - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
 * - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)
 * 
 * Palette System:
 * PLT files work in conjunction with external palette files (.pal files) that contain the actual
 * color values. The PLT file itself stores:
 * 1. Palette Group index (0-9): Which palette group to use for each pixel
 * 2. Color index (0-255): Which color within the selected palette to use
 * 
 * At runtime, the game:
 * 1. Loads the appropriate palette file for the selected palette group
 * 2. Uses the palette index (supplied by the content creator) to select a row in the palette file
 * 3. Uses the color index from the PLT file to retrieve the final color value
 * 
 * Palette Groups (10 total):
 * 0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
 * 6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
 * - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
 * - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp
 */

var Plt = (function() {
  function Plt(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Plt.prototype._read = function() {
    this.header = new PltHeader(this._io, this, this._root);
    this.pixelData = new PixelDataSection(this._io, this, this._root);
  }

  var PixelDataSection = Plt.PixelDataSection = (function() {
    function PixelDataSection(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    PixelDataSection.prototype._read = function() {
      this.pixels = [];
      for (var i = 0; i < this._root.header.width * this._root.header.height; i++) {
        this.pixels.push(new PltPixel(this._io, this, this._root));
      }
    }

    /**
     * Array of pixel entries, stored row by row, left to right, top to bottom.
     * Total size = width × height × 2 bytes.
     * Each pixel entry contains a color index and palette group index.
     */

    return PixelDataSection;
  })();

  var PltHeader = Plt.PltHeader = (function() {
    function PltHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    PltHeader.prototype._read = function() {
      this.signature = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.signature == "PLT ")) {
        throw new KaitaiStream.ValidationNotEqualError("PLT ", this.signature, this._io, "/types/plt_header/seq/0");
      }
      this.version = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
      if (!(this.version == "V1  ")) {
        throw new KaitaiStream.ValidationNotEqualError("V1  ", this.version, this._io, "/types/plt_header/seq/1");
      }
      this.unknown1 = this._io.readU4le();
      this.unknown2 = this._io.readU4le();
      this.width = this._io.readU4le();
      this.height = this._io.readU4le();
    }

    /**
     * File signature. Must be "PLT " (space-padded).
     * This identifies the file as a PLT palette texture.
     */

    /**
     * File format version. Must be "V1  " (space-padded).
     * This is the only known version of the PLT format.
     */

    /**
     * Unknown field (4 bytes).
     * Purpose is unknown, may be reserved for future use or internal engine flags.
     */

    /**
     * Unknown field (4 bytes).
     * Purpose is unknown, may be reserved for future use or internal engine flags.
     */

    /**
     * Texture width in pixels (uint32).
     * Used to calculate the number of pixel entries in the pixel data section.
     */

    /**
     * Texture height in pixels (uint32).
     * Used to calculate the number of pixel entries in the pixel data section.
     * Total pixel count = width × height
     */

    return PltHeader;
  })();

  var PltPixel = Plt.PltPixel = (function() {
    function PltPixel(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    PltPixel.prototype._read = function() {
      this.colorIndex = this._io.readU1();
      this.paletteGroupIndex = this._io.readU1();
    }

    /**
     * Color index (0-255) within the selected palette.
     * This value selects which color from the palette file row to use.
     * The palette file contains 256 rows (one for each palette index 0-255),
     * and each row contains 256 color values (one for each color index 0-255).
     */

    /**
     * Palette group index (0-9) that determines which palette file to use.
     * Palette groups:
     * 0 = Skin (pal_skin01.jpg)
     * 1 = Hair (pal_hair01.jpg)
     * 2 = Metal 1 (pal_armor01.jpg)
     * 3 = Metal 2 (pal_armor02.jpg)
     * 4 = Cloth 1 (pal_cloth01.jpg)
     * 5 = Cloth 2 (pal_cloth01.jpg)
     * 6 = Leather 1 (pal_leath01.jpg)
     * 7 = Leather 2 (pal_leath01.jpg)
     * 8 = Tattoo 1 (pal_tattoo01.jpg)
     * 9 = Tattoo 2 (pal_tattoo01.jpg)
     */

    return PltPixel;
  })();

  /**
   * PLT file header (24 bytes)
   */

  /**
   * Array of pixel entries (width × height entries, 2 bytes each)
   */

  return Plt;
})();
Plt_.Plt = Plt;
});
