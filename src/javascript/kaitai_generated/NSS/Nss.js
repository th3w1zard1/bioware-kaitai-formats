// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.Nss || (root.Nss = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (Nss_, KaitaiStream) {
/**
 * NSS (NWScript Source) files contain human-readable NWScript source code
 * that compiles to NCS bytecode. NWScript is the scripting language used
 * in KotOR, TSL, and Neverwinter Nights.
 * 
 * NSS files are plain text files (typically Windows-1252 or UTF-8 encoding)
 * containing NWScript source code. The nwscript.nss file defines all
 * engine-exposed functions and constants available to scripts.
 * 
 * Format:
 * - Plain text source code
 * - May include BOM (Byte Order Mark) for UTF-8 files
 * - Lines are typically terminated with CRLF (\r\n) or LF (\n)
 * - Comments: // for single-line, /* */ for multi-line
 * - Preprocessor directives: #include, #define, etc.
 * 
 * Authoritative links: `meta.doc-ref` (PyKotor wiki, xoreos `types.h` `kFileTypeNSS`, xoreos-tools `NCSFile`, reone `NssWriter`).
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/NSS-File-Format|PyKotor wiki — NSS}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L85-L86|xoreos — `kFileTypeNSS` / `kFileTypeNCS` (Aurora `FileType` IDs; NSS plaintext, NCS bytecode)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137|xoreos-tools — `NCSFile`}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/tools/script/format/nsswriter.cpp#L33-L45|reone — `NssWriter::save`}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html|xoreos-docs — Torlack NCS (bytecode companion to plaintext NSS)}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs tree}
 */

var Nss = (function() {
  function Nss(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Nss.prototype._read = function() {
    if (this._io.pos == 0) {
      this.bom = this._io.readU2le();
      if (!( ((this.bom == 65279) || (this.bom == 0)) )) {
        throw new KaitaiStream.ValidationNotAnyOfError(this.bom, this._io, "/seq/0");
      }
    }
    this.sourceCode = KaitaiStream.bytesToStr(this._io.readBytesFull(), "UTF-8");
  }

  /**
   * NWScript source code structure.
   * This is primarily a text format, so the main content is the source_code string.
   * 
   * The source can be parsed into:
   * - Tokens (keywords, identifiers, operators, literals)
   * - Statements (declarations, assignments, control flow)
   * - Functions (definitions with parameters and body)
   * - Preprocessor directives (#include, #define)
   */

  var NssSource = Nss.NssSource = (function() {
    function NssSource(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    NssSource.prototype._read = function() {
      this.content = KaitaiStream.bytesToStr(this._io.readBytesFull(), "UTF-8");
    }

    /**
     * Complete source code content.
     */

    return NssSource;
  })();

  /**
   * Optional UTF-8 BOM (Byte Order Mark) at the start of the file.
   * If present, will be 0xFEFF (UTF-8 BOM).
   * Most NSS files do not include a BOM.
   */

  /**
   * Complete NWScript source code.
   * Contains function definitions, variable declarations, control flow
   * statements, and engine function calls.
   * 
   * Common elements:
   * - Function definitions: void function_name() { ... }
   * - Variable declarations: int variable_name;
   * - Control flow: if, while, for, switch
   * - Engine function calls: GetFirstObject(), GetObjectByTag(), etc.
   * - Constants: OBJECT_SELF, OBJECT_INVALID, etc.
   * 
   * The source code is compiled to NCS bytecode by the NWScript compiler.
   */

  return Nss;
})();
Nss_.Nss = Nss;
});
