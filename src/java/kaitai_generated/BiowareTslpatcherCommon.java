// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;
import java.nio.charset.StandardCharsets;


/**
 * Shared enums and small helper types used by TSLPatcher-style tooling.
 * 
 * Notes:
 * - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
 *   so string-valued enums are modeled here as small string wrapper types with `valid` constraints.
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py
 */
public class BiowareTslpatcherCommon extends KaitaiStruct {
    public static BiowareTslpatcherCommon fromFile(String fileName) throws IOException {
        return new BiowareTslpatcherCommon(new ByteBufferKaitaiStream(fileName));
    }

    public enum BiowareTslpatcherLogTypeId {
        VERBOSE(0),
        NOTE(1),
        WARNING(2),
        ERROR(3);

        private final long id;
        BiowareTslpatcherLogTypeId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareTslpatcherLogTypeId> byId = new HashMap<Long, BiowareTslpatcherLogTypeId>(4);
        static {
            for (BiowareTslpatcherLogTypeId e : BiowareTslpatcherLogTypeId.values())
                byId.put(e.id(), e);
        }
        public static BiowareTslpatcherLogTypeId byId(long id) { return byId.get(id); }
    }

    public enum BiowareTslpatcherTargetTypeId {
        ROW_INDEX(0),
        ROW_LABEL(1),
        LABEL_COLUMN(2);

        private final long id;
        BiowareTslpatcherTargetTypeId(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, BiowareTslpatcherTargetTypeId> byId = new HashMap<Long, BiowareTslpatcherTargetTypeId>(3);
        static {
            for (BiowareTslpatcherTargetTypeId e : BiowareTslpatcherTargetTypeId.values())
                byId.put(e.id(), e);
        }
        public static BiowareTslpatcherTargetTypeId byId(long id) { return byId.get(id); }
    }

    public BiowareTslpatcherCommon(KaitaiStream _io) {
        this(_io, null, null);
    }

    public BiowareTslpatcherCommon(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public BiowareTslpatcherCommon(KaitaiStream _io, KaitaiStruct _parent, BiowareTslpatcherCommon _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
    }

    public void _fetchInstances() {
    }

    /**
     * String-valued enum equivalent for DiffFormat (null-terminated ASCII).
     */
    public static class BiowareDiffFormatStr extends KaitaiStruct {
        public static BiowareDiffFormatStr fromFile(String fileName) throws IOException {
            return new BiowareDiffFormatStr(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareDiffFormatStr(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareDiffFormatStr(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareDiffFormatStr(KaitaiStream _io, KaitaiStruct _parent, BiowareTslpatcherCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.value = new String(this._io.readBytesTerm((byte) 0, false, true, true), StandardCharsets.US_ASCII);
            if (!( ((this.value.equals("default")) || (this.value.equals("unified")) || (this.value.equals("context")) || (this.value.equals("side_by_side"))) )) {
                throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_diff_format_str/seq/0");
            }
        }

        public void _fetchInstances() {
        }
        private String value;
        private BiowareTslpatcherCommon _root;
        private KaitaiStruct _parent;
        public String value() { return value; }
        public BiowareTslpatcherCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
     */
    public static class BiowareDiffResourceTypeStr extends KaitaiStruct {
        public static BiowareDiffResourceTypeStr fromFile(String fileName) throws IOException {
            return new BiowareDiffResourceTypeStr(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareDiffResourceTypeStr(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareDiffResourceTypeStr(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareDiffResourceTypeStr(KaitaiStream _io, KaitaiStruct _parent, BiowareTslpatcherCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.value = new String(this._io.readBytesTerm((byte) 0, false, true, true), StandardCharsets.US_ASCII);
            if (!( ((this.value.equals("gff")) || (this.value.equals("2da")) || (this.value.equals("tlk")) || (this.value.equals("lip")) || (this.value.equals("bytes"))) )) {
                throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_diff_resource_type_str/seq/0");
            }
        }

        public void _fetchInstances() {
        }
        private String value;
        private BiowareTslpatcherCommon _root;
        private KaitaiStruct _parent;
        public String value() { return value; }
        public BiowareTslpatcherCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * String-valued enum equivalent for DiffType (null-terminated ASCII).
     */
    public static class BiowareDiffTypeStr extends KaitaiStruct {
        public static BiowareDiffTypeStr fromFile(String fileName) throws IOException {
            return new BiowareDiffTypeStr(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareDiffTypeStr(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareDiffTypeStr(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareDiffTypeStr(KaitaiStream _io, KaitaiStruct _parent, BiowareTslpatcherCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.value = new String(this._io.readBytesTerm((byte) 0, false, true, true), StandardCharsets.US_ASCII);
            if (!( ((this.value.equals("identical")) || (this.value.equals("modified")) || (this.value.equals("added")) || (this.value.equals("removed")) || (this.value.equals("error"))) )) {
                throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_diff_type_str/seq/0");
            }
        }

        public void _fetchInstances() {
        }
        private String value;
        private BiowareTslpatcherCommon _root;
        private KaitaiStruct _parent;
        public String value() { return value; }
        public BiowareTslpatcherCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
     */
    public static class BiowareNcsTokenTypeStr extends KaitaiStruct {
        public static BiowareNcsTokenTypeStr fromFile(String fileName) throws IOException {
            return new BiowareNcsTokenTypeStr(new ByteBufferKaitaiStream(fileName));
        }

        public BiowareNcsTokenTypeStr(KaitaiStream _io) {
            this(_io, null, null);
        }

        public BiowareNcsTokenTypeStr(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public BiowareNcsTokenTypeStr(KaitaiStream _io, KaitaiStruct _parent, BiowareTslpatcherCommon _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.value = new String(this._io.readBytesTerm((byte) 0, false, true, true), StandardCharsets.US_ASCII);
            if (!( ((this.value.equals("strref")) || (this.value.equals("strref32")) || (this.value.equals("2damemory")) || (this.value.equals("2damemory32")) || (this.value.equals("uint32")) || (this.value.equals("uint16")) || (this.value.equals("uint8"))) )) {
                throw new KaitaiStream.ValidationNotAnyOfError(this.value, this._io, "/types/bioware_ncs_token_type_str/seq/0");
            }
        }

        public void _fetchInstances() {
        }
        private String value;
        private BiowareTslpatcherCommon _root;
        private KaitaiStruct _parent;
        public String value() { return value; }
        public BiowareTslpatcherCommon _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }
    private BiowareTslpatcherCommon _root;
    private KaitaiStruct _parent;
    public BiowareTslpatcherCommon _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
