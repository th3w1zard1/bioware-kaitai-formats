// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


/**
 * **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
 * the paired **KEY** (`KEY.ksy`), not in the BIF.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif">PyKotor wiki — BIF</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L82">xoreos — BIFF::load</a>
 */
public class Bif extends KaitaiStruct {
    public static Bif fromFile(String fileName) throws IOException {
        return new Bif(new ByteBufferKaitaiStream(fileName));
    }

    public Bif(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Bif(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Bif(KaitaiStream _io, KaitaiStruct _parent, Bif _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!(this.fileType.equals("BIFF"))) {
            throw new KaitaiStream.ValidationNotEqualError("BIFF", this.fileType, this._io, "/seq/0");
        }
        this.version = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!( ((this.version.equals("V1  ")) || (this.version.equals("V1.1"))) )) {
            throw new KaitaiStream.ValidationNotAnyOfError(this.version, this._io, "/seq/1");
        }
        this.varResCount = this._io.readU4le();
        this.fixedResCount = this._io.readU4le();
        if (!(this.fixedResCount == 0)) {
            throw new KaitaiStream.ValidationNotEqualError(0, this.fixedResCount, this._io, "/seq/3");
        }
        this.varTableOffset = this._io.readU4le();
    }

    public void _fetchInstances() {
        varResourceTable();
        if (this.varResourceTable != null) {
            this.varResourceTable._fetchInstances();
        }
    }
    public static class VarResourceEntry extends KaitaiStruct {
        public static VarResourceEntry fromFile(String fileName) throws IOException {
            return new VarResourceEntry(new ByteBufferKaitaiStream(fileName));
        }

        public VarResourceEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public VarResourceEntry(KaitaiStream _io, Bif.VarResourceTable _parent) {
            this(_io, _parent, null);
        }

        public VarResourceEntry(KaitaiStream _io, Bif.VarResourceTable _parent, Bif _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.resourceId = this._io.readU4le();
            this.offset = this._io.readU4le();
            this.fileSize = this._io.readU4le();
            this.resourceType = BiowareTypeIds.XoreosFileTypeId.byId(this._io.readU4le());
        }

        public void _fetchInstances() {
        }
        private long resourceId;
        private long offset;
        private long fileSize;
        private BiowareTypeIds.XoreosFileTypeId resourceType;
        private Bif _root;
        private Bif.VarResourceTable _parent;

        /**
         * Resource ID (matches KEY file entry).
         * Encodes BIF index (bits 31-20) and resource index (bits 19-0).
         * Formula: resource_id = (bif_index << 20) | resource_index
         */
        public long resourceId() { return resourceId; }

        /**
         * Byte offset to resource data in file (absolute file offset).
         */
        public long offset() { return offset; }

        /**
         * Uncompressed size of resource data in bytes.
         */
        public long fileSize() { return fileSize; }

        /**
         * Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
         * read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
         * `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.
         */
        public BiowareTypeIds.XoreosFileTypeId resourceType() { return resourceType; }
        public Bif _root() { return _root; }
        public Bif.VarResourceTable _parent() { return _parent; }
    }
    public static class VarResourceTable extends KaitaiStruct {
        public static VarResourceTable fromFile(String fileName) throws IOException {
            return new VarResourceTable(new ByteBufferKaitaiStream(fileName));
        }

        public VarResourceTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public VarResourceTable(KaitaiStream _io, Bif _parent) {
            this(_io, _parent, null);
        }

        public VarResourceTable(KaitaiStream _io, Bif _parent, Bif _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<VarResourceEntry>();
            for (int i = 0; i < _root().varResCount(); i++) {
                this.entries.add(new VarResourceEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<VarResourceEntry> entries;
        private Bif _root;
        private Bif _parent;

        /**
         * Array of variable resource entries.
         */
        public List<VarResourceEntry> entries() { return entries; }
        public Bif _root() { return _root; }
        public Bif _parent() { return _parent; }
    }
    private VarResourceTable varResourceTable;

    /**
     * Variable resource table containing entries for each resource.
     */
    public VarResourceTable varResourceTable() {
        if (this.varResourceTable != null)
            return this.varResourceTable;
        if (varResCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(varTableOffset());
            this.varResourceTable = new VarResourceTable(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.varResourceTable;
    }
    private String fileType;
    private String version;
    private long varResCount;
    private long fixedResCount;
    private long varTableOffset;
    private Bif _root;
    private KaitaiStruct _parent;

    /**
     * File type signature. Must be "BIFF" for BIF files.
     */
    public String fileType() { return fileType; }

    /**
     * File format version. Typically "V1  " or "V1.1".
     */
    public String version() { return version; }

    /**
     * Number of variable-size resources in this file.
     */
    public long varResCount() { return varResCount; }

    /**
     * Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
     */
    public long fixedResCount() { return fixedResCount; }

    /**
     * Byte offset to the variable resource table from the beginning of the file.
     */
    public long varTableOffset() { return varTableOffset; }
    public Bif _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
