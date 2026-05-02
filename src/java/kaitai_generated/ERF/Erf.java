// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


/**
 * ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
 * texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
 * ERF files store both resource names (ResRefs) and data in the same file. They also support
 * localized strings for descriptions in multiple languages.
 * 
 * Format Variants:
 * - ERF: Generic encapsulated resource file (texture packs, etc.)
 * - HAK: Hak pak file (contains override resources). Used for mod content distribution
 * - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
 * - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`
 * 
 * All variants use the same binary format structure, differing only in the file type signature.
 * 
 * Archive `resource_type` values use the shared **`bioware_type_ids::xoreos_file_type_id`** enum (xoreos `FileType`); see `formats/Common/bioware_type_ids.ksy`.
 * 
 * Binary Format Structure:
 * - Header (160 bytes): File type, version, entry counts, offsets, build date, description
 * - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
 *   include localized module names for the load screen. Each entry contains language_id (u4),
 *   string_size (u4), and string_data (UTF-8 encoded text)
 * - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
 *   - resref (16 bytes, ASCII, null-padded): Resource filename
 *   - resource_id (u4): Index into resource_list
 *   - resource_type (u2): Resource type identifier (`bioware_type_ids::xoreos_file_type_id`, xoreos `FileType`)
 *   - unused (u2): Padding/unused field (typically 0)
 * - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
 *   - offset_to_data (u4): Byte offset to resource data from beginning of file
 *   - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
 * - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
 *   in resource_list
 * 
 * File Access Pattern:
 * 1. Read header to get entry_count and offsets
 * 2. Read key_list to map ResRefs to resource_ids
 * 3. Use resource_id to index into resource_list
 * 4. Read resource data from offset_to_data with byte length len_data
 * 
 * Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_erf` / `erf_data`, xoreos `ERFFile`, xoreos-tools `unerf` / `erf`, reone `ErfReader`, KotOR.js `ERFObject`, NickHugi `Kotor.NET/Formats/KotorERF`).
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf">PyKotor wiki — ERF</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf">PyKotor wiki — Aurora ERF notes</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py#L22-L316">PyKotor — `io_erf` (Kaitai + legacy + `ERFBinaryWriter.write`)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L130">PyKotor — `ERFType` + `ERF` model (opening)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L50-L335">xoreos — ERF type tags + `ERFFile::load` + `readV10Header` start</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/unerf.cpp#L69-L106">xoreos-tools — `unerf` CLI (`main`)</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/src/erf.cpp#L49-L96">xoreos-tools — `erf` packer CLI (`main`)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html">xoreos-docs — Torlack mod.html</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/erfreader.cpp#L26-L92">reone — `ErfReader`</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/ERFObject.ts#L70-L115">KotOR.js — `ERFObject`</a>
 * @see <a href="https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorERF/ERFBinaryStructure.cs">NickHugi/Kotor.NET — `ERFBinaryStructure`</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/ERF_Format.pdf">xoreos-docs — ERF_Format.pdf</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394">xoreos — `enum FileType` (numeric IDs in KEY/ERF/RIM tables)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py">PyKotor — `ResourceType` (tooling superset; overlaps FileType for KotOR rows)</a>
 */
public class Erf extends KaitaiStruct {
    public static Erf fromFile(String fileName) throws IOException {
        return new Erf(new ByteBufferKaitaiStream(fileName));
    }

    public Erf(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Erf(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Erf(KaitaiStream _io, KaitaiStruct _parent, Erf _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.header = new ErfHeader(this._io, this, _root);
    }

    public void _fetchInstances() {
        this.header._fetchInstances();
        keyList();
        if (this.keyList != null) {
            this.keyList._fetchInstances();
        }
        localizedStringList();
        if (this.localizedStringList != null) {
            this.localizedStringList._fetchInstances();
        }
        resourceList();
        if (this.resourceList != null) {
            this.resourceList._fetchInstances();
        }
    }
    public static class ErfHeader extends KaitaiStruct {
        public static ErfHeader fromFile(String fileName) throws IOException {
            return new ErfHeader(new ByteBufferKaitaiStream(fileName));
        }

        public ErfHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ErfHeader(KaitaiStream _io, Erf _parent) {
            this(_io, _parent, null);
        }

        public ErfHeader(KaitaiStream _io, Erf _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.fileType = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!( ((this.fileType.equals("ERF ")) || (this.fileType.equals("MOD ")) || (this.fileType.equals("SAV ")) || (this.fileType.equals("HAK "))) )) {
                throw new KaitaiStream.ValidationNotAnyOfError(this.fileType, this._io, "/types/erf_header/seq/0");
            }
            this.fileVersion = new String(this._io.readBytes(4), StandardCharsets.US_ASCII);
            if (!(this.fileVersion.equals("V1.0"))) {
                throw new KaitaiStream.ValidationNotEqualError("V1.0", this.fileVersion, this._io, "/types/erf_header/seq/1");
            }
            this.languageCount = this._io.readU4le();
            this.localizedStringSize = this._io.readU4le();
            this.entryCount = this._io.readU4le();
            this.offsetToLocalizedStringList = this._io.readU4le();
            this.offsetToKeyList = this._io.readU4le();
            this.offsetToResourceList = this._io.readU4le();
            this.buildYear = this._io.readU4le();
            this.buildDay = this._io.readU4le();
            this.descriptionStrref = this._io.readS4le();
            this.reserved = this._io.readBytes(116);
        }

        public void _fetchInstances() {
        }
        private Boolean isSaveFile;

        /**
         * Heuristic to detect save game files.
         * Save games use MOD signature but typically have description_strref = 0.
         */
        public Boolean isSaveFile() {
            if (this.isSaveFile != null)
                return this.isSaveFile;
            this.isSaveFile =  ((fileType().equals("MOD ")) && (descriptionStrref() == 0)) ;
            return this.isSaveFile;
        }
        private String fileType;
        private String fileVersion;
        private long languageCount;
        private long localizedStringSize;
        private long entryCount;
        private long offsetToLocalizedStringList;
        private long offsetToKeyList;
        private long offsetToResourceList;
        private long buildYear;
        private long buildDay;
        private int descriptionStrref;
        private byte[] reserved;
        private Erf _root;
        private Erf _parent;

        /**
         * File type signature. Must be one of:
         * - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
         * - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
         * - "SAV " (0x53 0x41 0x56 0x20) - Save game file
         * - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
         */
        public String fileType() { return fileType; }

        /**
         * File format version. Always "V1.0" for KotOR ERF files.
         * Other versions may exist in Neverwinter Nights but are not supported in KotOR.
         */
        public String fileVersion() { return fileVersion; }

        /**
         * Number of localized string entries. Typically 0 for most ERF files.
         * MOD files may include localized module names for the load screen.
         */
        public long languageCount() { return languageCount; }

        /**
         * Total size of localized string data in bytes.
         * Includes all language entries (language_id + string_size + string_data for each).
         */
        public long localizedStringSize() { return localizedStringSize; }

        /**
         * Number of resources in the archive. This determines:
         * - Number of entries in key_list
         * - Number of entries in resource_list
         * - Number of resource data blocks stored at various offsets
         */
        public long entryCount() { return entryCount; }

        /**
         * Byte offset to the localized string list from the beginning of the file.
         * Typically 160 (right after header) if present, or 0 if not present.
         */
        public long offsetToLocalizedStringList() { return offsetToLocalizedStringList; }

        /**
         * Byte offset to the key list from the beginning of the file.
         * Typically 160 (right after header) if no localized strings, or after localized strings.
         */
        public long offsetToKeyList() { return offsetToKeyList; }

        /**
         * Byte offset to the resource list from the beginning of the file.
         * Located after the key list.
         */
        public long offsetToResourceList() { return offsetToResourceList; }

        /**
         * Build year (years since 1900).
         * Example: 103 = year 2003
         * Primarily informational, used by development tools to track module versions.
         */
        public long buildYear() { return buildYear; }

        /**
         * Build day (days since January 1, with January 1 = day 1).
         * Example: 247 = September 4th (the 247th day of the year)
         * Primarily informational, used by development tools to track module versions.
         */
        public long buildDay() { return buildDay; }

        /**
         * Description StrRef (TLK string reference) for the archive description.
         * Values vary by file type:
         * - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
         * - SAV files: 0 (typically no description)
         * - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
         */
        public int descriptionStrref() { return descriptionStrref; }

        /**
         * Reserved padding (usually zeros).
         * Total header size is 160 bytes:
         * file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
         * entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
         * offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
         * reserved (116) = 160 bytes
         */
        public byte[] reserved() { return reserved; }
        public Erf _root() { return _root; }
        public Erf _parent() { return _parent; }
    }
    public static class KeyEntry extends KaitaiStruct {
        public static KeyEntry fromFile(String fileName) throws IOException {
            return new KeyEntry(new ByteBufferKaitaiStream(fileName));
        }

        public KeyEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public KeyEntry(KaitaiStream _io, Erf.KeyList _parent) {
            this(_io, _parent, null);
        }

        public KeyEntry(KaitaiStream _io, Erf.KeyList _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.resref = new String(this._io.readBytes(16), StandardCharsets.US_ASCII);
            this.resourceId = this._io.readU4le();
            this.resourceType = BiowareTypeIds.XoreosFileTypeId.byId(this._io.readU2le());
            this.unused = this._io.readU2le();
        }

        public void _fetchInstances() {
        }
        private String resref;
        private long resourceId;
        private BiowareTypeIds.XoreosFileTypeId resourceType;
        private int unused;
        private Erf _root;
        private Erf.KeyList _parent;

        /**
         * Resource filename (ResRef), null-padded to 16 bytes.
         * Maximum 16 characters. If exactly 16 characters, no null terminator exists.
         * Resource names can be mixed case, though most are lowercase in practice.
         */
        public String resref() { return resref; }

        /**
         * Resource ID (index into resource_list).
         * Maps this key entry to the corresponding resource entry.
         */
        public long resourceId() { return resourceId; }

        /**
         * Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
         * Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
         */
        public BiowareTypeIds.XoreosFileTypeId resourceType() { return resourceType; }

        /**
         * Padding/unused field (typically 0)
         */
        public int unused() { return unused; }
        public Erf _root() { return _root; }
        public Erf.KeyList _parent() { return _parent; }
    }
    public static class KeyList extends KaitaiStruct {
        public static KeyList fromFile(String fileName) throws IOException {
            return new KeyList(new ByteBufferKaitaiStream(fileName));
        }

        public KeyList(KaitaiStream _io) {
            this(_io, null, null);
        }

        public KeyList(KaitaiStream _io, Erf _parent) {
            this(_io, _parent, null);
        }

        public KeyList(KaitaiStream _io, Erf _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<KeyEntry>();
            for (int i = 0; i < _root().header().entryCount(); i++) {
                this.entries.add(new KeyEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<KeyEntry> entries;
        private Erf _root;
        private Erf _parent;

        /**
         * Array of key entries mapping ResRefs to resource indices
         */
        public List<KeyEntry> entries() { return entries; }
        public Erf _root() { return _root; }
        public Erf _parent() { return _parent; }
    }
    public static class LocalizedStringEntry extends KaitaiStruct {
        public static LocalizedStringEntry fromFile(String fileName) throws IOException {
            return new LocalizedStringEntry(new ByteBufferKaitaiStream(fileName));
        }

        public LocalizedStringEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LocalizedStringEntry(KaitaiStream _io, Erf.LocalizedStringList _parent) {
            this(_io, _parent, null);
        }

        public LocalizedStringEntry(KaitaiStream _io, Erf.LocalizedStringList _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.languageId = this._io.readU4le();
            this.stringSize = this._io.readU4le();
            this.stringData = new String(this._io.readBytes(stringSize()), StandardCharsets.UTF_8);
        }

        public void _fetchInstances() {
        }
        private long languageId;
        private long stringSize;
        private String stringData;
        private Erf _root;
        private Erf.LocalizedStringList _parent;

        /**
         * Language identifier:
         * - 0 = English
         * - 1 = French
         * - 2 = German
         * - 3 = Italian
         * - 4 = Spanish
         * - 5 = Polish
         * - Additional languages for Asian releases
         */
        public long languageId() { return languageId; }

        /**
         * Length of string data in bytes
         */
        public long stringSize() { return stringSize; }

        /**
         * UTF-8 encoded text string
         */
        public String stringData() { return stringData; }
        public Erf _root() { return _root; }
        public Erf.LocalizedStringList _parent() { return _parent; }
    }
    public static class LocalizedStringList extends KaitaiStruct {
        public static LocalizedStringList fromFile(String fileName) throws IOException {
            return new LocalizedStringList(new ByteBufferKaitaiStream(fileName));
        }

        public LocalizedStringList(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LocalizedStringList(KaitaiStream _io, Erf _parent) {
            this(_io, _parent, null);
        }

        public LocalizedStringList(KaitaiStream _io, Erf _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<LocalizedStringEntry>();
            for (int i = 0; i < _root().header().languageCount(); i++) {
                this.entries.add(new LocalizedStringEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<LocalizedStringEntry> entries;
        private Erf _root;
        private Erf _parent;

        /**
         * Array of localized string entries, one per language
         */
        public List<LocalizedStringEntry> entries() { return entries; }
        public Erf _root() { return _root; }
        public Erf _parent() { return _parent; }
    }
    public static class ResourceEntry extends KaitaiStruct {
        public static ResourceEntry fromFile(String fileName) throws IOException {
            return new ResourceEntry(new ByteBufferKaitaiStream(fileName));
        }

        public ResourceEntry(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ResourceEntry(KaitaiStream _io, Erf.ResourceList _parent) {
            this(_io, _parent, null);
        }

        public ResourceEntry(KaitaiStream _io, Erf.ResourceList _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.offsetToData = this._io.readU4le();
            this.lenData = this._io.readU4le();
        }

        public void _fetchInstances() {
            data();
            if (this.data != null) {
            }
        }
        private byte[] data;

        /**
         * Raw binary data for this resource
         */
        public byte[] data() {
            if (this.data != null)
                return this.data;
            long _pos = this._io.pos();
            this._io.seek(offsetToData());
            this.data = this._io.readBytes(lenData());
            this._io.seek(_pos);
            return this.data;
        }
        private long offsetToData;
        private long lenData;
        private Erf _root;
        private Erf.ResourceList _parent;

        /**
         * Byte offset to resource data from the beginning of the file.
         * Points to the actual binary data for this resource.
         */
        public long offsetToData() { return offsetToData; }

        /**
         * Size of resource data in bytes.
         * Uncompressed size of the resource.
         */
        public long lenData() { return lenData; }
        public Erf _root() { return _root; }
        public Erf.ResourceList _parent() { return _parent; }
    }
    public static class ResourceList extends KaitaiStruct {
        public static ResourceList fromFile(String fileName) throws IOException {
            return new ResourceList(new ByteBufferKaitaiStream(fileName));
        }

        public ResourceList(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ResourceList(KaitaiStream _io, Erf _parent) {
            this(_io, _parent, null);
        }

        public ResourceList(KaitaiStream _io, Erf _parent, Erf _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.entries = new ArrayList<ResourceEntry>();
            for (int i = 0; i < _root().header().entryCount(); i++) {
                this.entries.add(new ResourceEntry(this._io, this, _root));
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.entries.size(); i++) {
                this.entries.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private List<ResourceEntry> entries;
        private Erf _root;
        private Erf _parent;

        /**
         * Array of resource entries containing offset and size information
         */
        public List<ResourceEntry> entries() { return entries; }
        public Erf _root() { return _root; }
        public Erf _parent() { return _parent; }
    }
    private KeyList keyList;

    /**
     * Array of key entries mapping ResRefs to resource indices
     */
    public KeyList keyList() {
        if (this.keyList != null)
            return this.keyList;
        long _pos = this._io.pos();
        this._io.seek(header().offsetToKeyList());
        this.keyList = new KeyList(this._io, this, _root);
        this._io.seek(_pos);
        return this.keyList;
    }
    private LocalizedStringList localizedStringList;

    /**
     * Optional localized string entries for multi-language descriptions
     */
    public LocalizedStringList localizedStringList() {
        if (this.localizedStringList != null)
            return this.localizedStringList;
        if (header().languageCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(header().offsetToLocalizedStringList());
            this.localizedStringList = new LocalizedStringList(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.localizedStringList;
    }
    private ResourceList resourceList;

    /**
     * Array of resource entries containing offset and size information
     */
    public ResourceList resourceList() {
        if (this.resourceList != null)
            return this.resourceList;
        long _pos = this._io.pos();
        this._io.seek(header().offsetToResourceList());
        this.resourceList = new ResourceList(this._io, this, _root);
        this._io.seek(_pos);
        return this.resourceList;
    }
    private ErfHeader header;
    private Erf _root;
    private KaitaiStruct _parent;

    /**
     * ERF file header (160 bytes)
     */
    public ErfHeader header() { return header; }
    public Erf _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
