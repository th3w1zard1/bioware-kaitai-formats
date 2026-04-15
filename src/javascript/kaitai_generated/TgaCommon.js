// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.TgaCommon || (root.TgaCommon = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (TgaCommon_, KaitaiStream) {
/**
 * Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
 * per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
 * 
 * Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
 */

var TgaCommon = (function() {
  TgaCommon.TgaColorMapType = Object.freeze({
    NONE: 0,
    PRESENT: 1,

    0: "NONE",
    1: "PRESENT",
  });

  TgaCommon.TgaImageType = Object.freeze({
    NO_IMAGE_DATA: 0,
    UNCOMPRESSED_COLOR_MAPPED: 1,
    UNCOMPRESSED_RGB: 2,
    UNCOMPRESSED_GREYSCALE: 3,
    RLE_COLOR_MAPPED: 9,
    RLE_RGB: 10,
    RLE_GREYSCALE: 11,

    0: "NO_IMAGE_DATA",
    1: "UNCOMPRESSED_COLOR_MAPPED",
    2: "UNCOMPRESSED_RGB",
    3: "UNCOMPRESSED_GREYSCALE",
    9: "RLE_COLOR_MAPPED",
    10: "RLE_RGB",
    11: "RLE_GREYSCALE",
  });

  function TgaCommon(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  TgaCommon.prototype._read = function() {
  }

  return TgaCommon;
})();
TgaCommon_.TgaCommon = TgaCommon;
});
