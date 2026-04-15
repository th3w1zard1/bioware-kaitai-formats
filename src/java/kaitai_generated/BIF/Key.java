// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


/**
 * **KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
 * Resource types use `bioware_type_ids`.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key">PyKotor wiki — KEY</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/key/io_key.py#L26-L183">PyKotor — `io_key` (Kaitai + legacy + header write)</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/keyreader.cpp#L26-L80">reone — `KeyReader`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp#L50-L88">xoreos — `KEYFile::load`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L192-L210">xoreos-tools — `openKEYs` / `openKEYDataFiles`</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf">xoreos-docs — KeyBIF_Format.pdf</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/key.html">xoreos-docs — Torlack key.html</a>
 */
public class Key extends KaitaiStruct {
    public static Key fromFile(String fileName) throws IOException {
        return new Key(new ByteBufferKaitaiStream(fileName));
    }

    public Key(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Key(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Key(KaitaiStream _io, KaitaiStruct _parent, Key _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!(this.fileType.equals("KEY "))) {
            throw new KaitaiStream.ValidationNotEqualError("KEY ", this.fileType, this._io, "/seq/0");
        }
        this.fileVersion = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
        if (!( ((this.fileVersion.equals("V1  ")) || (this.fileVersion.equals("V1.1"))) )) {
            throw new KaitaiStream.ValidationNotAnyOfError(this.fileVersion, this._io, "/seq/1");
        }
        this.bifCount = this._io.readU4le();
        this.keyCount = this._io.readU4le();
        this.fileTableOffset = this._io.readU4le();
        this.keyTableOffset = this._io.readU4le();
        this.buildYear = this._io.readU4le();
        this.buildDay = this._io.readU4le();
        this.reserved = this._io.readBytes(32);
    }

    public void _fetchInstances() {
        fileTable();
        if (this.fileTable != null) {
            this.fileTable._fetchInstances();
        }
        keyTable();
        if (this.keyTable != null) {
            this.keyTable._fetchInstances();
        }
    }
    public static class FileEntry extends KaitaiStruct {
        public static FileEntry fromFile(String fileName) throws IOException {
            return new FileEntry(new ByteBufferKaitaiStream(fileName));
        }

        public FileEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FileEntry(KaitaiStream _io, Key.FileTable _parent) {
            this(_io, _parent, null);
        }

        public FileEntry(KaitaiStream _io, Key.FileTable _parent, Key _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.fileSize = this._io.readU4le();
            this.filenameOffset = this._io.readU4le();
            this.filenameSize = this._io.readU2le();
            this.drives = this._io.readU2le();
        }

        public void _fetchInstances() {
            filename();
            if (this.filename != null) {
            }
        }
        private String filename;

        /**
         * BIF filename string at the absolute filename_offset in the KEY file.
         */
        public String filename() {
            if (this.filename != null)
                return this.filename;
            long _pos = this._io.pos();
            this._io.seek(filenameOffset());
            this.filename = new String(this._io.readBytes(filenameSize()), StandardCharsets.US_ASCII);
            this._io.seek(_pos);
            return this.filename;
        }
        private long fileSize;
        private long filenameOffset;
        private int filenameSize;
        private int drives;
        private Key _root;
        private Key.FileTable _parent;

        /**
         * Size of the BIF file on disk in bytes.
         */
        public long fileSize() { return fileSize; }

        /**
         * Absolute byte offset from the start of the KEY file where this BIF's filename is stored
         * (seek(filename_offset), then read filename_size bytes).
         * This is not relative to the file table or to the end of the BIF entry array.
         */
        public long filenameOffset() { return filenameOffset; }

        /**
         * Length of the filename in bytes (including null terminator).
         */
        public int filenameSize() { return filenameSize; }

        /**
         * Drive flags indicating which media contains the BIF file.
         * Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
         * Modern distributions typically use 0x0001 (HD) for all files.
         */
        public int drives() { return drives; }
        public Key _root() { return _root; }
        public Key.FileTable _parent() { return _parent; }
    }
    public static class FileTable extends KaitaiStruct {
        public static FileTable fromFile(String fileName) throws IOException {
            return new FileTable(new ByteBufferKaitaiStream(fileName));
        }

        public FileTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FileTable(KaitaiStream _io, Key _parent) {
            this(_io, _parent, null);
        }

        public FileTable(KaitaiStream _io, Key _parent, Key _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<FileEntry>();
            for (int i = 0; i < _root().bifCount(); i++) {
                this.entries.add(new FileEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<FileEntry> entries;
        private Key _root;
        private Key _parent;

        /**
         * Array of BIF file entries.
         */
        public List<FileEntry> entries() { return entries; }
        public Key _root() { return _root; }
        public Key _parent() { return _parent; }
    }
    public static class FilenameTable extends KaitaiStruct {
        public static FilenameTable fromFile(String fileName) throws IOException {
            return new FilenameTable(new ByteBufferKaitaiStream(fileName));
        }

        public FilenameTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FilenameTable(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public FilenameTable(KaitaiStream _io, KaitaiStruct _parent, Key _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.filenames = new String(this._io.readBytesFull(), StandardCharsets.US_ASCII);
        }

        public void _fetchInstances() {
        }
        private String filenames;
        private Key _root;
        private KaitaiStruct _parent;

        /**
         * Null-terminated BIF filenames concatenated together.
         * Each filename is read using the filename_offset and filename_size
         * from the corresponding file_entry.
         */
        public String filenames() { return filenames; }
        public Key _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }
    public static class KeyEntry extends KaitaiStruct {
        public static KeyEntry fromFile(String fileName) throws IOException {
            return new KeyEntry(new ByteBufferKaitaiStream(fileName));
        }

        public KeyEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public KeyEntry(KaitaiStream _io, Key.KeyTable _parent) {
            this(_io, _parent, null);
        }

        public KeyEntry(KaitaiStream _io, Key.KeyTable _parent, Key _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.resref = new String(this._io.readBytes(16), StandardCharsets.US_ASCII);
            this.resourceType = BiowareTypeIds.XoreosFileTypeId.byId(this._io.readU2le());
            this.resourceId = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private String resref;
        private BiowareTypeIds.XoreosFileTypeId resourceType;
        private long resourceId;
        private Key _root;
        private Key.KeyTable _parent;

        /**
         * Resource filename (ResRef) without extension.
         * Null-padded, maximum 16 characters.
         * The game uses this name to access the resource.
         */
        public String resref() { return resref; }

        /**
         * Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
         * `formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).
         */
        public BiowareTypeIds.XoreosFileTypeId resourceType() { return resourceType; }

        /**
         * Encoded resource location.
         * Bits 31-20: BIF index (top 12 bits) - index into file table
         * Bits 19-0: Resource index (bottom 20 bits) - index within the BIF file
         * 
         * Formula: resource_id = (bif_index << 20) | resource_index
         * 
         * Decoding:
         * - bif_index = (resource_id >> 20) & 0xFFF
         * - resource_index = resource_id & 0xFFFFF
         */
        public long resourceId() { return resourceId; }
        public Key _root() { return _root; }
        public Key.KeyTable _parent() { return _parent; }
    }
    public static class KeyTable extends KaitaiStruct {
        public static KeyTable fromFile(String fileName) throws IOException {
            return new KeyTable(new ByteBufferKaitaiStream(fileName));
        }

        public KeyTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public KeyTable(KaitaiStream _io, Key _parent) {
            this(_io, _parent, null);
        }

        public KeyTable(KaitaiStream _io, Key _parent, Key _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<KeyEntry>();
            for (int i = 0; i < _root().keyCount(); i++) {
                this.entries.add(new KeyEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<KeyEntry> entries;
        private Key _root;
        private Key _parent;

        /**
         * Array of resource entries.
         */
        public List<KeyEntry> entries() { return entries; }
        public Key _root() { return _root; }
        public Key _parent() { return _parent; }
    }
    private FileTable fileTable;

    /**
     * File table containing BIF file entries.
     */
    public FileTable fileTable() {
        if (this.fileTable != null)
            return this.fileTable;
        if (bifCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(fileTableOffset());
            this.fileTable = new FileTable(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.fileTable;
    }
    private KeyTable keyTable;

    /**
     * KEY table containing resource entries.
     */
    public KeyTable keyTable() {
        if (this.keyTable != null)
            return this.keyTable;
        if (keyCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(keyTableOffset());
            this.keyTable = new KeyTable(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.keyTable;
    }
    private String fileType;
    private String fileVersion;
    private long bifCount;
    private long keyCount;
    private long fileTableOffset;
    private long keyTableOffset;
    private long buildYear;
    private long buildDay;
    private byte[] reserved;
    private Key _root;
    private KaitaiStruct _parent;

    /**
     * File type signature. Must be "KEY " (space-padded).
     */
    public String fileType() { return fileType; }

    /**
     * File format version. Typically "V1  " or "V1.1".
     */
    public String fileVersion() { return fileVersion; }

    /**
     * Number of BIF files referenced by this KEY file.
     */
    public long bifCount() { return bifCount; }

    /**
     * Number of resource entries in the KEY table.
     */
    public long keyCount() { return keyCount; }

    /**
     * Byte offset to the file table from the beginning of the file.
     */
    public long fileTableOffset() { return fileTableOffset; }

    /**
     * Byte offset to the KEY table from the beginning of the file.
     */
    public long keyTableOffset() { return keyTableOffset; }

    /**
     * Build year (years since 1900).
     */
    public long buildYear() { return buildYear; }

    /**
     * Build day (days since January 1).
     */
    public long buildDay() { return buildDay; }

    /**
     * Reserved padding (usually zeros).
     */
    public byte[] reserved() { return reserved; }
    public Key _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
