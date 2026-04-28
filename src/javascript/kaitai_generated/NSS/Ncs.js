// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareNcsCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareNcsCommon'));
  } else {
    factory(root.Ncs || (root.Ncs = {}), root.KaitaiStream, root.BiowareNcsCommon || (root.BiowareNcsCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Ncs_, KaitaiStream, BiowareNcsCommon_) {
/**
 * NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
 * Scripts run inside a stack-based virtual machine shared across Aurora engine games.
 * 
 * Format Structure:
 * - Header (13 bytes): Signature "NCS ", version "V1.0", size marker (0x42), file size
 * - Instruction Stream: Sequence of bytecode instructions
 * 
 * All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).
 * 
 * NWScript **source** (`.nss`) is plaintext tooling; it is intentionally not modeled as Kaitai in this repository
 * (see `AGENTS.md`). This spec covers the **binary** `.ncs` wire format only.
 * 
 * Opcode / qualifier enumerations: imported from `formats/Common/bioware_ncs_common.ksy` (mirrors PyKotor `ncs_data.py`).
 * 
 * Authoritative parsers and notes: `meta.xref` and `doc-ref` (PyKotor, xoreos, xoreos-tools, xoreos-docs Torlack, reone).
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format|PyKotor wiki — NCS}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/io_ncs.py#L60-L90|PyKotor — compiled script load path}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355|xoreos — NCSFile::load}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137|xoreos-tools — NCSFile::load}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html|xoreos-docs — Torlack ncs.html}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40|reone — NcsReader::load}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L140|PyKotor — NCSByteCode / NCSInstructionQualifier (shared .ksy enums)}
 */

var Ncs = (function() {
  function Ncs(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Ncs.prototype._read = function() {
    this.fileType = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.fileType == "NCS ")) {
      throw new KaitaiStream.ValidationNotEqualError("NCS ", this.fileType, this._io, "/seq/0");
    }
    this.fileVersion = KaitaiStream.bytesToStr(this._io.readBytes(4), "ASCII");
    if (!(this.fileVersion == "V1.0")) {
      throw new KaitaiStream.ValidationNotEqualError("V1.0", this.fileVersion, this._io, "/seq/1");
    }
    this.sizeMarker = this._io.readU1();
    if (!(this.sizeMarker == 66)) {
      throw new KaitaiStream.ValidationNotEqualError(66, this.sizeMarker, this._io, "/seq/2");
    }
    this.fileSize = this._io.readU4be();
    this.instructions = [];
    var i = 0;
    do {
      var _ = new Instruction(this._io, this, this._root);
      this.instructions.push(_);
      i++;
    } while (!(this._io.pos >= this.fileSize));
  }

  /**
   * NWScript bytecode instruction.
   * Format: <opcode: uint8> <qualifier: uint8> <arguments: variable>
   * 
   * Instruction size varies by opcode:
   * - Base: 2 bytes (opcode + qualifier)
   * - Arguments: 0 to variable bytes depending on instruction type
   * 
   * Common instruction types:
   * - Constants: CONSTI (6B), CONSTF (6B), CONSTS (2+N B), CONSTO (6B)
   * - Stack ops: CPDOWNSP, CPTOPSP, MOVSP (variable size)
   * - Arithmetic: ADDxx, SUBxx, MULxx, DIVxx (2B)
   * - Control flow: JMP, JSR, JZ, JNZ (6B), RETN (2B)
   * - Function calls: ACTION (5B)
   * - And many more (see NCS format documentation)
   */

  var Instruction = Ncs.Instruction = (function() {
    function Instruction(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Instruction.prototype._read = function() {
      this.opcode = this._io.readU1();
      this.qualifier = this._io.readU1();
      this.arguments = [];
      var i = 0;
      do {
        var _ = this._io.readU1();
        this.arguments.push(_);
        i++;
      } while (!(this._io.pos >= this._io.size));
    }

    /**
     * Instruction opcode (0x01-0x2D, excluding 0x42 which is reserved for size marker).
     * Determines the instruction type and argument format.
     */

    /**
     * Qualifier byte that refines the instruction to specific operand types.
     * Examples: 0x03=Int, 0x04=Float, 0x05=String, 0x06=Object, 0x24=Structure
     */

    /**
     * Instruction arguments (variable size).
     * Format depends on opcode:
     * - No args: None (total 2B)
     * - Int/Float/Object: 4 bytes (total 6B)
     * - String: 2B length + data (total 2+N B)
     * - Jump: 4B signed offset (total 6B)
     * - Stack copy: 4B offset + 2B size (total 8B)
     * - ACTION: 2B routine + 1B argCount (total 5B)
     * - DESTRUCT: 2B size + 2B offset + 2B sizeNoDestroy (total 8B)
     * - STORE_STATE: 4B size + 4B sizeLocals (total 10B)
     * - And others (see documentation)
     */

    return Instruction;
  })();

  /**
   * File type signature. Must be "NCS " (0x4E 0x43 0x53 0x20).
   */

  /**
   * File format version. Must be "V1.0" (0x56 0x31 0x2E 0x30).
   */

  /**
   * Program size marker opcode. Must be 0x42.
   * This is not a real instruction but a metadata field containing the total file size.
   * All implementations validate this marker before parsing instructions.
   */

  /**
   * Total file size in bytes (big-endian).
   * This value should match the actual file size.
   */

  /**
   * Stream of bytecode instructions.
   * Execution begins at offset 13 (0x0D) after the header.
   * Instructions continue until end of file.
   */

  return Ncs;
})();
Ncs_.Ncs = Ncs;
});
