// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.ArrayList;


/**
 * RIM (Resource Information Manager) files are self-contained archives used for module templates.
 * RIM files are similar to ERF files but are read-only from the game's perspective. The game
 * loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
 * RIM files store all resources inline with metadata, making them self-contained archives.
 * 
 * Format Variants:
 * - Standard RIM: Basic module template files
 * - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
 * 
 * Binary Format (KotOR / PyKotor):
 * - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
 * - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
 * - Key / resource entry table (32 bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
 * - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
 * 
 * Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim">PyKotor wiki — RIM</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128">PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L35-L91">xoreos — `RIMFile::load` + `readResList`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unrim.cpp#L55-L85">xoreos-tools — `unrim` CLI (`main`)</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/rim.cpp#L43-L84">xoreos-tools — `rim` packer CLI (`main`)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html">xoreos-docs — Torlack mod.html (MOD/RIM family)</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/RIMObject.ts#L69-L93">KotOR.js — `RIMObject`</a>
 * @see <a href="https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs">NickHugi/Kotor.NET — `RIMBinaryStructure`</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/rimreader.cpp#L26-L58">reone — `RimReader`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394">xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py">PyKotor — `ResourceType` (tooling superset)</a>
 */
public class Rim extends KaitaiStruct {
    public static Rim fromFile(String fileName) throws IOException {
        return new Rim(new ByteBufferKaitaiStream(fileName));
    }

    public Rim(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Rim(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Rim(KaitaiStream _io, KaitaiStruct _parent, Rim _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new RimHeader(this._io, this, _root);
        if (header().offsetToResourceTable() == 0) {
            this.gapBeforeKeyTableImplicit = this._io.readBytes(96);
        }
        if (header().offsetToResourceTable() != 0) {
            this.gapBeforeKeyTableExplicit = this._io.readBytes(header().offsetToResourceTable() - 24);
        }
        if (header().resourceCount() > 0) {
            this.resourceEntryTable = new ResourceEntryTable(this._io, this, _root);
        }
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
        if (header().offsetToResourceTable() == 0) {
        }
        if (header().offsetToResourceTable() != 0) {
        }
        if (header().resourceCount() > 0) {
            this.resourceEntryTable._fetchInstances();
        }
    }
    public static class ResourceEntry extends KaitaiStruct {
        public static ResourceEntry fromFile(String fileName) throws IOException {
            return new ResourceEntry(new ByteBufferKaitaiStream(fileName));
        }

        public ResourceEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ResourceEntry(KaitaiStream _io, Rim.ResourceEntryTable _parent) {
            this(_io, _parent, null);
        }

        public ResourceEntry(KaitaiStream _io, Rim.ResourceEntryTable _parent, Rim _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.resref = new String(this._io.readBytes(16), StandardCharsets.US_ASCII);
            this.resourceType = BiowareTypeIds.XoreosFileTypeId.byId(this._io.readU4le());
            this.resourceId = this._io.readU4le();
            this.offsetToData = this._io.readU4le();
            this.numData = this._io.readU4le();
        }

        public void _fetchInstances() {
            data();
            if (this.data != null) {
                for (int i = 0; i < this.data.size(); i++) {
                }
            }
        }
        private List<Integer> data;

        /**
         * Raw binary data for this resource (read at specified offset)
         */
        public List<Integer> data() {
            if (this.data != null)
                return this.data;
            long _pos = this._io.pos();
            this._io.seek(offsetToData());
            this.data = new ArrayList<Integer>();
            for (int i = 0; i < numData(); i++) {
                this.data.add(this._io.readU1());
            }
            this._io.seek(_pos);
            return this.data;
        }
        private String resref;
        private BiowareTypeIds.XoreosFileTypeId resourceType;
        private long resourceId;
        private long offsetToData;
        private long numData;
        private Rim _root;
        private Rim.ResourceEntryTable _parent;

        /**
         * Resource filename (ResRef), null-padded to 16 bytes.
         * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
         * Resource names can be mixed case, though most are lowercase in practice.
         * The game engine typically lowercases ResRefs when loading.
         */
        public String resref() { return resref; }

        /**
         * Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
         * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
         */
        public BiowareTypeIds.XoreosFileTypeId resourceType() { return resourceType; }

        /**
         * Resource ID (index, usually sequential).
         * Typically matches the index of this entry in the resource_entry_table.
         * Used for internal reference, but not critical for parsing.
         */
        public long resourceId() { return resourceId; }

        /**
         * Byte offset to resource data from the beginning of the file.
         * Points to the actual binary data for this resource in resource_data_section.
         */
        public long offsetToData() { return offsetToData; }

        /**
         * Size of resource data in bytes (repeat count for raw `data` bytes).
         * Uncompressed size of the resource.
         */
        public long numData() { return numData; }
        public Rim _root() { return _root; }
        public Rim.ResourceEntryTable _parent() { return _parent; }
    }
    public static class ResourceEntryTable extends KaitaiStruct {
        public static ResourceEntryTable fromFile(String fileName) throws IOException {
            return new ResourceEntryTable(new ByteBufferKaitaiStream(fileName));
        }

        public ResourceEntryTable(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ResourceEntryTable(KaitaiStream _io, Rim _parent) {
            this(_io, _parent, null);
        }

        public ResourceEntryTable(KaitaiStream _io, Rim _parent, Rim _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<ResourceEntry>();
            for (int i = 0; i < _root().header().resourceCount(); i++) {
                this.entries.add(new ResourceEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<ResourceEntry> entries;
        private Rim _root;
        private Rim _parent;

        /**
         * Array of resource entries, one per resource in the archive
         */
        public List<ResourceEntry> entries() { return entries; }
        public Rim _root() { return _root; }
        public Rim _parent() { return _parent; }
    }
    public static class RimHeader extends KaitaiStruct {
        public static RimHeader fromFile(String fileName) throws IOException {
            return new RimHeader(new ByteBufferKaitaiStream(fileName));
        }

        public RimHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public RimHeader(KaitaiStream _io, Rim _parent) {
            this(_io, _parent, null);
        }

        public RimHeader(KaitaiStream _io, Rim _parent, Rim _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.fileType.equals("RIM "))) {
                throw new KaitaiStream.ValidationNotEqualError("RIM ", this.fileType, this._io, "/types/rim_header/seq/0");
            }
            this.fileVersion = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.fileVersion.equals("V1.0"))) {
                throw new KaitaiStream.ValidationNotEqualError("V1.0", this.fileVersion, this._io, "/types/rim_header/seq/1");
            }
            this.reserved = this._io.readU4le();
            this.resourceCount = this._io.readU4le();
            this.offsetToResourceTable = this._io.readU4le();
            this.offsetToResources = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private Boolean hasResources;

        /**
         * Whether the RIM file contains any resources
         */
        public Boolean hasResources() {
            if (this.hasResources != null)
                return this.hasResources;
            this.hasResources = resourceCount() > 0;
            return this.hasResources;
        }
        private String fileType;
        private String fileVersion;
        private long reserved;
        private long resourceCount;
        private long offsetToResourceTable;
        private long offsetToResources;
        private Rim _root;
        private Rim _parent;

        /**
         * File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
         * This identifies the file as a RIM archive.
         */
        public String fileType() { return fileType; }

        /**
         * File format version. Always "V1.0" for KotOR RIM files.
         * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
         */
        public String fileVersion() { return fileVersion; }

        /**
         * Reserved field (typically 0x00000000).
         * Unknown purpose, but always set to 0 in practice.
         */
        public long reserved() { return reserved; }

        /**
         * Number of resources in the archive. This determines:
         * - Number of entries in resource_entry_table
         * - Number of resources in resource_data_section
         */
        public long resourceCount() { return resourceCount; }

        /**
         * Byte offset to the key / resource entry table from the beginning of the file.
         * 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
         * When non-zero, this offset is used directly (commonly 120).
         */
        public long offsetToResourceTable() { return offsetToResourceTable; }

        /**
         * Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
         * taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
         */
        public long offsetToResources() { return offsetToResources; }
        public Rim _root() { return _root; }
        public Rim _parent() { return _parent; }
    }
    private RimHeader header;
    private byte[] gapBeforeKeyTableImplicit;
    private byte[] gapBeforeKeyTableExplicit;
    private ResourceEntryTable resourceEntryTable;
    private Rim _root;
    private KaitaiStruct _parent;

    /**
     * RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
     */
    public RimHeader header() { return header; }

    /**
     * When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
     * After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
     */
    public byte[] gapBeforeKeyTableImplicit() { return gapBeforeKeyTableImplicit; }

    /**
     * When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
     * Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
     */
    public byte[] gapBeforeKeyTableExplicit() { return gapBeforeKeyTableExplicit; }

    /**
     * Array of resource entries mapping ResRefs to resource data
     */
    public ResourceEntryTable resourceEntryTable() { return resourceEntryTable; }
    public Rim _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
