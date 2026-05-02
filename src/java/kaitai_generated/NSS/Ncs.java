// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


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
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format">PyKotor wiki — NCS</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/io_ncs.py#L60-L90">PyKotor — compiled script load path</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355">xoreos — NCSFile::load</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137">xoreos-tools — NCSFile::load</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html">xoreos-docs — Torlack ncs.html</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40">reone — NcsReader::load</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L140">PyKotor — NCSByteCode / NCSInstructionQualifier (shared .ksy enums)</a>
 */
public class Ncs extends KaitaiStruct {
    public static Ncs fromFile(String fileName) throws IOException {
        return new Ncs(new ByteBufferKaitaiStream(fileName));
    }

    public Ncs(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Ncs(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Ncs(KaitaiStream _io, KaitaiStruct _parent, Ncs _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!(this.fileType.equals("NCS "))) {
            throw new KaitaiStream.ValidationNotEqualError("NCS ", this.fileType, this._io, "/seq/0");
        }
        this.fileVersion = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!(this.fileVersion.equals("V1.0"))) {
            throw new KaitaiStream.ValidationNotEqualError("V1.0", this.fileVersion, this._io, "/seq/1");
        }
        this.sizeMarker = this._io.readU1();
        if (!(this.sizeMarker == 66)) {
            throw new KaitaiStream.ValidationNotEqualError(66, this.sizeMarker, this._io, "/seq/2");
        }
        this.fileSize = this._io.readU4be();
        this.instructions = new ArrayList<Instruction>();
        {
            Instruction _it;
            int i = 0;
            do {
                _it = new Instruction(this._io, this, _root);
                this.instructions.add(_it);
                i++;
            } while (!(_io().pos() >= fileSize()));
        }
    }

    public void _fetchInstances() {
        for (int i = 0; i < this.instructions.size(); i++) {
            this.instructions.get(((Number) (i)).intValue())._fetchInstances();
        }
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
    public static class Instruction extends KaitaiStruct {
        public static Instruction fromFile(String fileName) throws IOException {
            return new Instruction(new ByteBufferKaitaiStream(fileName));
        }

        public Instruction(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Instruction(KaitaiStream _io, Ncs _parent) {
            this(_io, _parent, null);
        }

        public Instruction(KaitaiStream _io, Ncs _parent, Ncs _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.opcode = BiowareNcsCommon.NcsBytecode.byId(this._io.readU1());
            this.qualifier = BiowareNcsCommon.NcsInstructionQualifier.byId(this._io.readU1());
            this.arguments = new ArrayList<Integer>();
            {
                int _it;
                int i = 0;
                do {
                    _it = this._io.readU1();
                    this.arguments.add(_it);
                    i++;
                } while (!(_io().pos() >= _io().size()));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.arguments.size(); i++) {
            }
        }
        private BiowareNcsCommon.NcsBytecode opcode;
        private BiowareNcsCommon.NcsInstructionQualifier qualifier;
        private List<Integer> arguments;
        private Ncs _root;
        private Ncs _parent;

        /**
         * Instruction opcode (0x01-0x2D, excluding 0x42 which is reserved for size marker).
         * Determines the instruction type and argument format.
         */
        public BiowareNcsCommon.NcsBytecode opcode() { return opcode; }

        /**
         * Qualifier byte that refines the instruction to specific operand types.
         * Examples: 0x03=Int, 0x04=Float, 0x05=String, 0x06=Object, 0x24=Structure
         */
        public BiowareNcsCommon.NcsInstructionQualifier qualifier() { return qualifier; }

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
        public List<Integer> arguments() { return arguments; }
        public Ncs _root() { return _root; }
        public Ncs _parent() { return _parent; }
    }
    private String fileType;
    private String fileVersion;
    private int sizeMarker;
    private long fileSize;
    private List<Instruction> instructions;
    private Ncs _root;
    private KaitaiStruct _parent;

    /**
     * File type signature. Must be "NCS " (0x4E 0x43 0x53 0x20).
     */
    public String fileType() { return fileType; }

    /**
     * File format version. Must be "V1.0" (0x56 0x31 0x2E 0x30).
     */
    public String fileVersion() { return fileVersion; }

    /**
     * Program size marker opcode. Must be 0x42.
     * This is not a real instruction but a metadata field containing the total file size.
     * All implementations validate this marker before parsing instructions.
     */
    public int sizeMarker() { return sizeMarker; }

    /**
     * Total file size in bytes (big-endian).
     * This value should match the actual file size.
     */
    public long fileSize() { return fileSize; }

    /**
     * Stream of bytecode instructions.
     * Execution begins at offset 13 (0x0D) after the header.
     * Instructions continue until end of file.
     */
    public List<Instruction> instructions() { return instructions; }
    public Ncs _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
