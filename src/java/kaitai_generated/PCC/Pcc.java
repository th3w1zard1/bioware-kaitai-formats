// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.nio.charset.StandardCharsets;


/**
 * **PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
 * tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).
 * 
 * **Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60">xoreos — `FileType` enum start (Aurora/BioWare family IDs; **PCC/Unreal packages are not in this table** — included only as canonical upstream anchor for “what this repo’s xoreos stack is”)</a>
 * @see <a href="https://github.com/ME3Tweaks/LegendaryExplorer/wiki/PCC-File-Format">ME3Tweaks — PCC file format</a>
 * @see <a href="https://github.com/ME3Tweaks/LegendaryExplorer/wiki/Package-Handling">ME3Tweaks — Package handling (export/import tables, UE3-era BioWare packages)</a>
 * @see <a href="https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/docs/XOREOS_FORMAT_COVERAGE.md">In-tree — coverage matrix (PCC is out-of-xoreos Aurora scope; see table)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (KotOR-era PDFs; PCC is Mass Effect / UE3 — use LegendaryExplorer wiki as wire authority)</a>
 */
public class Pcc extends KaitaiStruct {
    public static Pcc fromFile(String fileName) throws IOException {
        return new Pcc(new ByteBufferKaitaiStream(fileName));
    }

    public Pcc(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Pcc(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Pcc(KaitaiStream _io, KaitaiStruct _parent, Pcc _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new FileHeader(this._io, this, _root);
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
        exportTable();
        if (this.exportTable != null) {
            this.exportTable._fetchInstances();
        }
        importTable();
        if (this.importTable != null) {
            this.importTable._fetchInstances();
        }
        nameTable();
        if (this.nameTable != null) {
            this.nameTable._fetchInstances();
        }
    }
    public static class ExportEntry extends KaitaiStruct {
        public static ExportEntry fromFile(String fileName) throws IOException {
            return new ExportEntry(new ByteBufferKaitaiStream(fileName));
        }

        public ExportEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ExportEntry(KaitaiStream _io, Pcc.ExportTable _parent) {
            this(_io, _parent, null);
        }

        public ExportEntry(KaitaiStream _io, Pcc.ExportTable _parent, Pcc _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.classIndex = this._io.readS4le();
            this.superClassIndex = this._io.readS4le();
            this.link = this._io.readS4le();
            this.objectNameIndex = this._io.readS4le();
            this.objectNameNumber = this._io.readS4le();
            this.archetypeIndex = this._io.readS4le();
            this.objectFlags = this._io.readU8le();
            this.dataSize = this._io.readU4le();
            this.dataOffset = this._io.readU4le();
            this.unknown1 = this._io.readU4le();
            this.numComponents = this._io.readS4le();
            this.unknown2 = this._io.readU4le();
            this.guid = new Guid(this._io, this, _root);
            if (numComponents() > 0) {
                this.components = new ArrayList<Integer>();
                for (int i = 0; i < numComponents(); i++) {
                    this.components.add(this._io.readS4le());
                }
            }
        }

        public void _fetchInstances() {
            this.guid._fetchInstances();
            if (numComponents() > 0) {
                for (int i = 0; i < this.components.size(); i++) {
                }
            }
        }
        private int classIndex;
        private int superClassIndex;
        private int link;
        private int objectNameIndex;
        private int objectNameNumber;
        private int archetypeIndex;
        private long objectFlags;
        private long dataSize;
        private long dataOffset;
        private long unknown1;
        private int numComponents;
        private long unknown2;
        private Guid guid;
        private List<Integer> components;
        private Pcc _root;
        private Pcc.ExportTable _parent;

        /**
         * Object index for the class.
         * Negative = import table index
         * Positive = export table index
         * Zero = no class
         */
        public int classIndex() { return classIndex; }

        /**
         * Object index for the super class.
         * Negative = import table index
         * Positive = export table index
         * Zero = no super class
         */
        public int superClassIndex() { return superClassIndex; }

        /**
         * Link to other objects (internal reference).
         */
        public int link() { return link; }

        /**
         * Index into name table for the object name.
         */
        public int objectNameIndex() { return objectNameIndex; }

        /**
         * Object name number (for duplicate names).
         */
        public int objectNameNumber() { return objectNameNumber; }

        /**
         * Object index for the archetype.
         * Negative = import table index
         * Positive = export table index
         * Zero = no archetype
         */
        public int archetypeIndex() { return archetypeIndex; }

        /**
         * Object flags bitfield (64-bit).
         */
        public long objectFlags() { return objectFlags; }

        /**
         * Size of the export data in bytes.
         */
        public long dataSize() { return dataSize; }

        /**
         * Byte offset to the export data from the beginning of the file.
         */
        public long dataOffset() { return dataOffset; }

        /**
         * Unknown field.
         */
        public long unknown1() { return unknown1; }

        /**
         * Number of component entries (can be negative).
         */
        public int numComponents() { return numComponents; }

        /**
         * Unknown field.
         */
        public long unknown2() { return unknown2; }

        /**
         * GUID for this export object.
         */
        public Guid guid() { return guid; }

        /**
         * Array of component indices.
         * Only present if num_components > 0.
         */
        public List<Integer> components() { return components; }
        public Pcc _root() { return _root; }
        public Pcc.ExportTable _parent() { return _parent; }
    }
    public static class ExportTable extends KaitaiStruct {
        public static ExportTable fromFile(String fileName) throws IOException {
            return new ExportTable(new ByteBufferKaitaiStream(fileName));
        }

        public ExportTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ExportTable(KaitaiStream _io, Pcc _parent) {
            this(_io, _parent, null);
        }

        public ExportTable(KaitaiStream _io, Pcc _parent, Pcc _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<ExportEntry>();
            for (int i = 0; i < _root().header().exportCount(); i++) {
                this.entries.add(new ExportEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<ExportEntry> entries;
        private Pcc _root;
        private Pcc _parent;

        /**
         * Array of export entries.
         */
        public List<ExportEntry> entries() { return entries; }
        public Pcc _root() { return _root; }
        public Pcc _parent() { return _parent; }
    }
    public static class FileHeader extends KaitaiStruct {
        public static FileHeader fromFile(String fileName) throws IOException {
            return new FileHeader(new ByteBufferKaitaiStream(fileName));
        }

        public FileHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FileHeader(KaitaiStream _io, Pcc _parent) {
            this(_io, _parent, null);
        }

        public FileHeader(KaitaiStream _io, Pcc _parent, Pcc _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.magic = this._io.readU4le();
            if (!(this.magic == 2653586369L)) {
                throw new KaitaiStream.ValidationNotEqualError(2653586369L, this.magic, this._io, "/types/file_header/seq/0");
            }
            this.version = this._io.readU4le();
            this.licenseeVersion = this._io.readU4le();
            this.headerSize = this._io.readS4le();
            this.packageName = new String(this._io.readBytes(10), StandardCharsets.UTF_16LE);
            this.packageFlags = this._io.readU4le();
            this.packageType = BiowareCommon.BiowarePccPackageKind.byId(this._io.readU4le());
            this.nameCount = this._io.readU4le();
            this.nameTableOffset = this._io.readU4le();
            this.exportCount = this._io.readU4le();
            this.exportTableOffset = this._io.readU4le();
            this.importCount = this._io.readU4le();
            this.importTableOffset = this._io.readU4le();
            this.dependOffset = this._io.readU4le();
            this.dependCount = this._io.readU4le();
            this.guidPart1 = this._io.readU4le();
            this.guidPart2 = this._io.readU4le();
            this.guidPart3 = this._io.readU4le();
            this.guidPart4 = this._io.readU4le();
            this.generations = this._io.readU4le();
            this.exportCountDup = this._io.readU4le();
            this.nameCountDup = this._io.readU4le();
            this.unknown1 = this._io.readU4le();
            this.engineVersion = this._io.readU4le();
            this.cookerVersion = this._io.readU4le();
            this.compressionFlags = this._io.readU4le();
            this.packageSource = this._io.readU4le();
            this.compressionType = BiowareCommon.BiowarePccCompressionCodec.byId(this._io.readU4le());
            this.chunkCount = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private long magic;
        private long version;
        private long licenseeVersion;
        private int headerSize;
        private String packageName;
        private long packageFlags;
        private BiowareCommon.BiowarePccPackageKind packageType;
        private long nameCount;
        private long nameTableOffset;
        private long exportCount;
        private long exportTableOffset;
        private long importCount;
        private long importTableOffset;
        private long dependOffset;
        private long dependCount;
        private long guidPart1;
        private long guidPart2;
        private long guidPart3;
        private long guidPart4;
        private long generations;
        private long exportCountDup;
        private long nameCountDup;
        private long unknown1;
        private long engineVersion;
        private long cookerVersion;
        private long compressionFlags;
        private long packageSource;
        private BiowareCommon.BiowarePccCompressionCodec compressionType;
        private long chunkCount;
        private Pcc _root;
        private Pcc _parent;

        /**
         * Magic number identifying PCC format. Must be 0x9E2A83C1.
         */
        public long magic() { return magic; }

        /**
         * File format version.
         * Encoded as: (major << 16) | (minor << 8) | patch
         * Example: 0xC202AC = 194/684 (major=194, minor=684)
         */
        public long version() { return version; }

        /**
         * Licensee-specific version field (typically 0x67C).
         */
        public long licenseeVersion() { return licenseeVersion; }

        /**
         * Header size field (typically -5 = 0xFFFFFFFB).
         */
        public int headerSize() { return headerSize; }

        /**
         * Package name (typically "None" = 0x4E006F006E006500).
         */
        public String packageName() { return packageName; }

        /**
         * Package flags bitfield.
         * Bit 25 (0x2000000): Compressed package
         * Bit 20 (0x100000): ME3Explorer edited format flag
         * Other bits: Various package attributes
         */
        public long packageFlags() { return packageFlags; }

        /**
         * Package type indicator (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_package_kind`
         * (LegendaryExplorer PCC wiki).
         */
        public BiowareCommon.BiowarePccPackageKind packageType() { return packageType; }

        /**
         * Number of entries in the name table.
         */
        public long nameCount() { return nameCount; }

        /**
         * Byte offset to the name table from the beginning of the file.
         */
        public long nameTableOffset() { return nameTableOffset; }

        /**
         * Number of entries in the export table.
         */
        public long exportCount() { return exportCount; }

        /**
         * Byte offset to the export table from the beginning of the file.
         */
        public long exportTableOffset() { return exportTableOffset; }

        /**
         * Number of entries in the import table.
         */
        public long importCount() { return importCount; }

        /**
         * Byte offset to the import table from the beginning of the file.
         */
        public long importTableOffset() { return importTableOffset; }

        /**
         * Offset to dependency table (typically 0x664).
         */
        public long dependOffset() { return dependOffset; }

        /**
         * Number of dependencies (typically 0x67C).
         */
        public long dependCount() { return dependCount; }

        /**
         * First 32 bits of package GUID.
         */
        public long guidPart1() { return guidPart1; }

        /**
         * Second 32 bits of package GUID.
         */
        public long guidPart2() { return guidPart2; }

        /**
         * Third 32 bits of package GUID.
         */
        public long guidPart3() { return guidPart3; }

        /**
         * Fourth 32 bits of package GUID.
         */
        public long guidPart4() { return guidPart4; }

        /**
         * Number of generation entries.
         */
        public long generations() { return generations; }

        /**
         * Duplicate export count (should match export_count).
         */
        public long exportCountDup() { return exportCountDup; }

        /**
         * Duplicate name count (should match name_count).
         */
        public long nameCountDup() { return nameCountDup; }

        /**
         * Unknown field (typically 0x0).
         */
        public long unknown1() { return unknown1; }

        /**
         * Engine version (typically 0x18EF = 6383).
         */
        public long engineVersion() { return engineVersion; }

        /**
         * Cooker version (typically 0x3006B = 196715).
         */
        public long cookerVersion() { return cookerVersion; }

        /**
         * Compression flags (typically 0x15330000).
         */
        public long compressionFlags() { return compressionFlags; }

        /**
         * Package source identifier (typically 0x8AA0000).
         */
        public long packageSource() { return packageSource; }

        /**
         * Compression codec when package is compressed (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_compression_codec`
         * (LegendaryExplorer PCC wiki). Unused / undefined when uncompressed.
         */
        public BiowareCommon.BiowarePccCompressionCodec compressionType() { return compressionType; }

        /**
         * Number of compressed chunks (0 for uncompressed, 1 for compressed).
         * If > 0, file uses compressed structure with chunks.
         */
        public long chunkCount() { return chunkCount; }
        public Pcc _root() { return _root; }
        public Pcc _parent() { return _parent; }
    }
    public static class Guid extends KaitaiStruct {
        public static Guid fromFile(String fileName) throws IOException {
            return new Guid(new ByteBufferKaitaiStream(fileName));
        }

        public Guid(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Guid(KaitaiStream _io, Pcc.ExportEntry _parent) {
            this(_io, _parent, null);
        }

        public Guid(KaitaiStream _io, Pcc.ExportEntry _parent, Pcc _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.part1 = this._io.readU4le();
            this.part2 = this._io.readU4le();
            this.part3 = this._io.readU4le();
            this.part4 = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private long part1;
        private long part2;
        private long part3;
        private long part4;
        private Pcc _root;
        private Pcc.ExportEntry _parent;

        /**
         * First 32 bits of GUID.
         */
        public long part1() { return part1; }

        /**
         * Second 32 bits of GUID.
         */
        public long part2() { return part2; }

        /**
         * Third 32 bits of GUID.
         */
        public long part3() { return part3; }

        /**
         * Fourth 32 bits of GUID.
         */
        public long part4() { return part4; }
        public Pcc _root() { return _root; }
        public Pcc.ExportEntry _parent() { return _parent; }
    }
    public static class ImportEntry extends KaitaiStruct {
        public static ImportEntry fromFile(String fileName) throws IOException {
            return new ImportEntry(new ByteBufferKaitaiStream(fileName));
        }

        public ImportEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ImportEntry(KaitaiStream _io, Pcc.ImportTable _parent) {
            this(_io, _parent, null);
        }

        public ImportEntry(KaitaiStream _io, Pcc.ImportTable _parent, Pcc _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.packageNameIndex = this._io.readS8le();
            this.classNameIndex = this._io.readS4le();
            this.link = this._io.readS8le();
            this.importNameIndex = this._io.readS8le();
        }

        public void _fetchInstances() {
        }
        private long packageNameIndex;
        private int classNameIndex;
        private long link;
        private long importNameIndex;
        private Pcc _root;
        private Pcc.ImportTable _parent;

        /**
         * Index into name table for package name.
         * Negative value indicates import from external package.
         * Positive value indicates import from this package.
         */
        public long packageNameIndex() { return packageNameIndex; }

        /**
         * Index into name table for class name.
         */
        public int classNameIndex() { return classNameIndex; }

        /**
         * Link to import/export table entry.
         * Used to resolve the actual object reference.
         */
        public long link() { return link; }

        /**
         * Index into name table for the imported object name.
         */
        public long importNameIndex() { return importNameIndex; }
        public Pcc _root() { return _root; }
        public Pcc.ImportTable _parent() { return _parent; }
    }
    public static class ImportTable extends KaitaiStruct {
        public static ImportTable fromFile(String fileName) throws IOException {
            return new ImportTable(new ByteBufferKaitaiStream(fileName));
        }

        public ImportTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ImportTable(KaitaiStream _io, Pcc _parent) {
            this(_io, _parent, null);
        }

        public ImportTable(KaitaiStream _io, Pcc _parent, Pcc _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<ImportEntry>();
            for (int i = 0; i < _root().header().importCount(); i++) {
                this.entries.add(new ImportEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<ImportEntry> entries;
        private Pcc _root;
        private Pcc _parent;

        /**
         * Array of import entries.
         */
        public List<ImportEntry> entries() { return entries; }
        public Pcc _root() { return _root; }
        public Pcc _parent() { return _parent; }
    }
    public static class NameEntry extends KaitaiStruct {
        public static NameEntry fromFile(String fileName) throws IOException {
            return new NameEntry(new ByteBufferKaitaiStream(fileName));
        }

        public NameEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public NameEntry(KaitaiStream _io, Pcc.NameTable _parent) {
            this(_io, _parent, null);
        }

        public NameEntry(KaitaiStream _io, Pcc.NameTable _parent, Pcc _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.length = this._io.readS4le();
            this.name = new String(this._io.readBytes((length() < 0 ? -(length()) : length()) * 2), StandardCharsets.UTF_16LE);
        }

        public void _fetchInstances() {
        }
        private Integer absLength;

        /**
         * Absolute value of length for size calculation
         */
        public Integer absLength() {
            if (this.absLength != null)
                return this.absLength;
            this.absLength = ((Number) ((length() < 0 ? -(length()) : length()))).intValue();
            return this.absLength;
        }
        private Integer nameSize;

        /**
         * Size of name string in bytes (absolute length * 2 bytes per WCHAR)
         */
        public Integer nameSize() {
            if (this.nameSize != null)
                return this.nameSize;
            this.nameSize = ((Number) (absLength() * 2)).intValue();
            return this.nameSize;
        }
        private int length;
        private String name;
        private Pcc _root;
        private Pcc.NameTable _parent;

        /**
         * Length of the name string in characters (signed).
         * Negative value indicates the number of WCHAR characters.
         * Positive value is also valid but less common.
         */
        public int length() { return length; }

        /**
         * Name string encoded as UTF-16LE (WCHAR).
         * Size is absolute value of length * 2 bytes per character.
         * Negative length indicates WCHAR count (use absolute value).
         */
        public String name() { return name; }
        public Pcc _root() { return _root; }
        public Pcc.NameTable _parent() { return _parent; }
    }
    public static class NameTable extends KaitaiStruct {
        public static NameTable fromFile(String fileName) throws IOException {
            return new NameTable(new ByteBufferKaitaiStream(fileName));
        }

        public NameTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public NameTable(KaitaiStream _io, Pcc _parent) {
            this(_io, _parent, null);
        }

        public NameTable(KaitaiStream _io, Pcc _parent, Pcc _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<NameEntry>();
            for (int i = 0; i < _root().header().nameCount(); i++) {
                this.entries.add(new NameEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<NameEntry> entries;
        private Pcc _root;
        private Pcc _parent;

        /**
         * Array of name entries.
         */
        public List<NameEntry> entries() { return entries; }
        public Pcc _root() { return _root; }
        public Pcc _parent() { return _parent; }
    }
    private BiowareCommon.BiowarePccCompressionCodec compressionType;

    /**
     * Compression algorithm used (0=None, 1=Zlib, 2=LZO).
     */
    public BiowareCommon.BiowarePccCompressionCodec compressionType() {
        if (this.compressionType != null)
            return this.compressionType;
        this.compressionType = header().compressionType();
        return this.compressionType;
    }
    private ExportTable exportTable;

    /**
     * Table containing all objects exported from this package.
     */
    public ExportTable exportTable() {
        if (this.exportTable != null)
            return this.exportTable;
        if (header().exportCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(header().exportTableOffset());
            this.exportTable = new ExportTable(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.exportTable;
    }
    private ImportTable importTable;

    /**
     * Table containing references to external packages and classes.
     */
    public ImportTable importTable() {
        if (this.importTable != null)
            return this.importTable;
        if (header().importCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(header().importTableOffset());
            this.importTable = new ImportTable(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.importTable;
    }
    private Boolean isCompressed;

    /**
     * True if package uses compressed chunks (bit 25 of package_flags).
     */
    public Boolean isCompressed() {
        if (this.isCompressed != null)
            return this.isCompressed;
        this.isCompressed = (header().packageFlags() & 33554432) != 0;
        return this.isCompressed;
    }
    private NameTable nameTable;

    /**
     * Table containing all string names used in the package.
     */
    public NameTable nameTable() {
        if (this.nameTable != null)
            return this.nameTable;
        if (header().nameCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(header().nameTableOffset());
            this.nameTable = new NameTable(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.nameTable;
    }
    private FileHeader header;
    private Pcc _root;
    private KaitaiStruct _parent;

    /**
     * File header containing format metadata and table offsets.
     */
    public FileHeader header() { return header; }
    public Pcc _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
