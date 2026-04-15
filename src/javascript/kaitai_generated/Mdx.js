// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Mdx || (root.Mdx = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Mdx_, KaitaiStream) {
/**
 * **MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
 * Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
 * opaque `size-eos` span — per-attribute layouts are MDL-driven.
 * 
 * xoreos interleaved MDX reads: `meta.xref.xoreos_model_kotor_mdx_reads`.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format|PyKotor wiki — MDL/MDX}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L885-L917|xoreos — Model_KotOR MDX reads}
 */

var Mdx = (function() {
  function Mdx(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Mdx.prototype._read = function() {
    this.vertexData = this._io.readBytesFull();
  }

  /**
   * Raw vertex data bytes; layout follows the trimesh header in the paired MDL (`mdx_data_offset`, `mdx_vertex_size`,
   * `mdx_data_flags`). Bit names for `mdx_data_flags`: `bioware_mdl_common::mdx_vertex_stream_flag` (bitmask on wire).
   * 
   * See `meta.xref.pykotor_wiki_mdl` and `meta.xref.xoreos_model_kotor_mdx_reads`. Skinned meshes add bone weights
   * and indices per vertex as described on the wiki.
   */

  return Mdx;
})();
Mdx_.Mdx = Mdx;
});
