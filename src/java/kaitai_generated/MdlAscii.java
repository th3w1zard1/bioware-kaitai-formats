// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.nio.charset.StandardCharsets;
import java.util.List;


/**
 * MDL ASCII format is a human-readable ASCII text representation of MDL (Model) binary files.
 * Used by modding tools for easier editing than binary MDL format.
 * 
 * The ASCII format represents the model structure using plain text with keyword-based syntax.
 * Lines are parsed sequentially, with keywords indicating sections, nodes, properties, and data arrays.
 * 
 * Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format - ASCII MDL Format section
 * Reference: https://github.com/OpenKotOR/PyKotor/blob/master/vendor/MDLOps/MDLOpsM.pm:3916-4698 - readasciimdl function implementation
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format">Source</a>
 */
public class MdlAscii extends KaitaiStruct {
    public static MdlAscii fromFile(String fileName) throws IOException {
        return new MdlAscii(new ByteBufferKaitaiStream(fileName));
    }

    public enum ControllerTypeCommon {
        POSITION(8),
        ORIENTATION(20),
        SCALE(36),
        ALPHA(132);

        private final long id;
        ControllerTypeCommon(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, ControllerTypeCommon> byId = new HashMap<Long, ControllerTypeCommon>(4);
        static {
            for (ControllerTypeCommon e : ControllerTypeCommon.values())
                byId.put(e.id(), e);
        }
        public static ControllerTypeCommon byId(long id) { return byId.get(id); }
    }

    public enum ControllerTypeEmitter {
        ALPHA_END(80),
        ALPHA_START(84),
        BIRTHRATE(88),
        BOUNCE_CO(92),
        COMBINETIME(96),
        DRAG(100),
        FPS(104),
        FRAME_END(108),
        FRAME_START(112),
        GRAV(116),
        LIFE_EXP(120),
        MASS(124),
        P2P_BEZIER2(128),
        P2P_BEZIER3(132),
        PARTICLE_ROT(136),
        RANDVEL(140),
        SIZE_START(144),
        SIZE_END(148),
        SIZE_START_Y(152),
        SIZE_END_Y(156),
        SPREAD(160),
        THRESHOLD(164),
        VELOCITY(168),
        XSIZE(172),
        YSIZE(176),
        BLURLENGTH(180),
        LIGHTNING_DELAY(184),
        LIGHTNING_RADIUS(188),
        LIGHTNING_SCALE(192),
        LIGHTNING_SUB_DIV(196),
        LIGHTNINGZIGZAG(200),
        ALPHA_MID(216),
        PERCENT_START(220),
        PERCENT_MID(224),
        PERCENT_END(228),
        SIZE_MID(232),
        SIZE_MID_Y(236),
        M_F_RANDOM_BIRTH_RATE(240),
        TARGETSIZE(252),
        NUMCONTROLPTS(256),
        CONTROLPTRADIUS(260),
        CONTROLPTDELAY(264),
        TANGENTSPREAD(268),
        TANGENTLENGTH(272),
        COLOR_MID(284),
        COLOR_END(380),
        COLOR_START(392),
        DETONATE(502);

        private final long id;
        ControllerTypeEmitter(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, ControllerTypeEmitter> byId = new HashMap<Long, ControllerTypeEmitter>(48);
        static {
            for (ControllerTypeEmitter e : ControllerTypeEmitter.values())
                byId.put(e.id(), e);
        }
        public static ControllerTypeEmitter byId(long id) { return byId.get(id); }
    }

    public enum ControllerTypeLight {
        COLOR(76),
        RADIUS(88),
        SHADOWRADIUS(96),
        VERTICALDISPLACEMENT(100),
        MULTIPLIER(140);

        private final long id;
        ControllerTypeLight(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, ControllerTypeLight> byId = new HashMap<Long, ControllerTypeLight>(5);
        static {
            for (ControllerTypeLight e : ControllerTypeLight.values())
                byId.put(e.id(), e);
        }
        public static ControllerTypeLight byId(long id) { return byId.get(id); }
    }

    public enum ControllerTypeMesh {
        SELFILLUMCOLOR(100);

        private final long id;
        ControllerTypeMesh(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, ControllerTypeMesh> byId = new HashMap<Long, ControllerTypeMesh>(1);
        static {
            for (ControllerTypeMesh e : ControllerTypeMesh.values())
                byId.put(e.id(), e);
        }
        public static ControllerTypeMesh byId(long id) { return byId.get(id); }
    }

    public enum ModelClassification {
        OTHER(0),
        EFFECT(1),
        TILE(2),
        CHARACTER(4),
        DOOR(8),
        LIGHTSABER(16),
        PLACEABLE(32),
        FLYER(64);

        private final long id;
        ModelClassification(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, ModelClassification> byId = new HashMap<Long, ModelClassification>(8);
        static {
            for (ModelClassification e : ModelClassification.values())
                byId.put(e.id(), e);
        }
        public static ModelClassification byId(long id) { return byId.get(id); }
    }

    public enum NodeType {
        DUMMY(1),
        LIGHT(3),
        EMITTER(5),
        REFERENCE(17),
        TRIMESH(33),
        SKINMESH(97),
        ANIMMESH(161),
        DANGLYMESH(289),
        AABB(545),
        LIGHTSABER(2081);

        private final long id;
        NodeType(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, NodeType> byId = new HashMap<Long, NodeType>(10);
        static {
            for (NodeType e : NodeType.values())
                byId.put(e.id(), e);
        }
        public static NodeType byId(long id) { return byId.get(id); }
    }

    public MdlAscii(KaitaiStream _io) {
        this(_io, null, null);
    }

    public MdlAscii(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public MdlAscii(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.lines = new ArrayList<AsciiLine>();
        {
            int i = 0;
            while (!this._io.isEof()) {
                this.lines.add(new AsciiLine(this._io, this, _root));
                i++;
            }
        }
    }

    public void _fetchInstances() {
        for (int i = 0; i < this.lines.size(); i++) {
            this.lines.get(((Number) (i)).intValue())._fetchInstances();
        }
    }

    /**
     * Animation section keywords
     */
    public static class AnimationSection extends KaitaiStruct {
        public static AnimationSection fromFile(String fileName) throws IOException {
            return new AnimationSection(new ByteBufferKaitaiStream(fileName));
        }

        public AnimationSection(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AnimationSection(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public AnimationSection(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.newanim = new LineText(this._io, this, _root);
            this.doneanim = new LineText(this._io, this, _root);
            this.length = new LineText(this._io, this, _root);
            this.transtime = new LineText(this._io, this, _root);
            this.animroot = new LineText(this._io, this, _root);
            this.event = new LineText(this._io, this, _root);
            this.eventlist = new LineText(this._io, this, _root);
            this.endlist = new LineText(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.newanim._fetchInstances();
            this.doneanim._fetchInstances();
            this.length._fetchInstances();
            this.transtime._fetchInstances();
            this.animroot._fetchInstances();
            this.event._fetchInstances();
            this.eventlist._fetchInstances();
            this.endlist._fetchInstances();
        }
        private LineText newanim;
        private LineText doneanim;
        private LineText length;
        private LineText transtime;
        private LineText animroot;
        private LineText event;
        private LineText eventlist;
        private LineText endlist;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * newanim <animation_name> <model_name> - Start of animation definition
         */
        public LineText newanim() { return newanim; }

        /**
         * doneanim <animation_name> <model_name> - End of animation definition
         */
        public LineText doneanim() { return doneanim; }

        /**
         * length <duration> - Animation duration in seconds
         */
        public LineText length() { return length; }

        /**
         * transtime <transition_time> - Transition/blend time to this animation in seconds
         */
        public LineText transtime() { return transtime; }

        /**
         * animroot <root_node_name> - Root node name for animation
         */
        public LineText animroot() { return animroot; }

        /**
         * event <time> <event_name> - Animation event (triggers at specified time)
         */
        public LineText event() { return event; }

        /**
         * eventlist - Start of animation events list
         */
        public LineText eventlist() { return eventlist; }

        /**
         * endlist - End of list (controllers, events, etc.)
         */
        public LineText endlist() { return endlist; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Single line in ASCII MDL file
     */
    public static class AsciiLine extends KaitaiStruct {
        public static AsciiLine fromFile(String fileName) throws IOException {
            return new AsciiLine(new ByteBufferKaitaiStream(fileName));
        }

        public AsciiLine(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AsciiLine(KaitaiStream _io, MdlAscii _parent) {
            this(_io, _parent, null);
        }

        public AsciiLine(KaitaiStream _io, MdlAscii _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.content = new String(this._io.readBytesTerm((byte) 10, false, true, false), StandardCharsets.UTF_8);
        }

        public void _fetchInstances() {
        }
        private String content;
        private MdlAscii _root;
        private MdlAscii _parent;
        public String content() { return content; }
        public MdlAscii _root() { return _root; }
        public MdlAscii _parent() { return _parent; }
    }

    /**
     * Bezier (smooth animated) controller format
     */
    public static class ControllerBezier extends KaitaiStruct {
        public static ControllerBezier fromFile(String fileName) throws IOException {
            return new ControllerBezier(new ByteBufferKaitaiStream(fileName));
        }

        public ControllerBezier(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ControllerBezier(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public ControllerBezier(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.controllerName = new LineText(this._io, this, _root);
            this.keyframes = new ArrayList<ControllerBezierKeyframe>();
            {
                int i = 0;
                while (!this._io.isEof()) {
                    this.keyframes.add(new ControllerBezierKeyframe(this._io, this, _root));
                    i++;
                }
            }
        }

        public void _fetchInstances() {
            this.controllerName._fetchInstances();
            for (int i = 0; i < this.keyframes.size(); i++) {
                this.keyframes.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private LineText controllerName;
        private List<ControllerBezierKeyframe> keyframes;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey)
         */
        public LineText controllerName() { return controllerName; }

        /**
         * Keyframe entries until endlist keyword
         */
        public List<ControllerBezierKeyframe> keyframes() { return keyframes; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)
     */
    public static class ControllerBezierKeyframe extends KaitaiStruct {
        public static ControllerBezierKeyframe fromFile(String fileName) throws IOException {
            return new ControllerBezierKeyframe(new ByteBufferKaitaiStream(fileName));
        }

        public ControllerBezierKeyframe(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ControllerBezierKeyframe(KaitaiStream _io, MdlAscii.ControllerBezier _parent) {
            this(_io, _parent, null);
        }

        public ControllerBezierKeyframe(KaitaiStream _io, MdlAscii.ControllerBezier _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.time = new String(this._io.readBytesFull(), StandardCharsets.UTF_8);
            this.valueData = new String(this._io.readBytesFull(), StandardCharsets.UTF_8);
        }

        public void _fetchInstances() {
        }
        private String time;
        private String valueData;
        private MdlAscii _root;
        private MdlAscii.ControllerBezier _parent;

        /**
         * Time value (float)
         */
        public String time() { return time; }

        /**
         * Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column)
         */
        public String valueData() { return valueData; }
        public MdlAscii _root() { return _root; }
        public MdlAscii.ControllerBezier _parent() { return _parent; }
    }

    /**
     * Keyed (animated) controller format
     */
    public static class ControllerKeyed extends KaitaiStruct {
        public static ControllerKeyed fromFile(String fileName) throws IOException {
            return new ControllerKeyed(new ByteBufferKaitaiStream(fileName));
        }

        public ControllerKeyed(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ControllerKeyed(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public ControllerKeyed(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.controllerName = new LineText(this._io, this, _root);
            this.keyframes = new ArrayList<ControllerKeyframe>();
            {
                int i = 0;
                while (!this._io.isEof()) {
                    this.keyframes.add(new ControllerKeyframe(this._io, this, _root));
                    i++;
                }
            }
        }

        public void _fetchInstances() {
            this.controllerName._fetchInstances();
            for (int i = 0; i < this.keyframes.size(); i++) {
                this.keyframes.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        private LineText controllerName;
        private List<ControllerKeyframe> keyframes;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * Controller name followed by 'key' (e.g., positionkey, orientationkey)
         */
        public LineText controllerName() { return controllerName; }

        /**
         * Keyframe entries until endlist keyword
         */
        public List<ControllerKeyframe> keyframes() { return keyframes; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Single keyframe in keyed controller
     */
    public static class ControllerKeyframe extends KaitaiStruct {
        public static ControllerKeyframe fromFile(String fileName) throws IOException {
            return new ControllerKeyframe(new ByteBufferKaitaiStream(fileName));
        }

        public ControllerKeyframe(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ControllerKeyframe(KaitaiStream _io, MdlAscii.ControllerKeyed _parent) {
            this(_io, _parent, null);
        }

        public ControllerKeyframe(KaitaiStream _io, MdlAscii.ControllerKeyed _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.time = new String(this._io.readBytesFull(), StandardCharsets.UTF_8);
            this.values = new String(this._io.readBytesFull(), StandardCharsets.UTF_8);
        }

        public void _fetchInstances() {
        }
        private String time;
        private String values;
        private MdlAscii _root;
        private MdlAscii.ControllerKeyed _parent;

        /**
         * Time value (float)
         */
        public String time() { return time; }

        /**
         * Space-separated property values (number depends on controller type and column count)
         */
        public String values() { return values; }
        public MdlAscii _root() { return _root; }
        public MdlAscii.ControllerKeyed _parent() { return _parent; }
    }

    /**
     * Single (constant) controller format
     */
    public static class ControllerSingle extends KaitaiStruct {
        public static ControllerSingle fromFile(String fileName) throws IOException {
            return new ControllerSingle(new ByteBufferKaitaiStream(fileName));
        }

        public ControllerSingle(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ControllerSingle(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public ControllerSingle(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.controllerName = new LineText(this._io, this, _root);
            this.values = new LineText(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.controllerName._fetchInstances();
            this.values._fetchInstances();
        }
        private LineText controllerName;
        private LineText values;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * Controller name (position, orientation, scale, color, radius, etc.)
         */
        public LineText controllerName() { return controllerName; }

        /**
         * Space-separated controller values (number depends on controller type)
         */
        public LineText values() { return values; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Danglymesh node properties
     */
    public static class DanglymeshProperties extends KaitaiStruct {
        public static DanglymeshProperties fromFile(String fileName) throws IOException {
            return new DanglymeshProperties(new ByteBufferKaitaiStream(fileName));
        }

        public DanglymeshProperties(KaitaiStream _io) {
            this(_io, null, null);
        }

        public DanglymeshProperties(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public DanglymeshProperties(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.displacement = new LineText(this._io, this, _root);
            this.tightness = new LineText(this._io, this, _root);
            this.period = new LineText(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.displacement._fetchInstances();
            this.tightness._fetchInstances();
            this.period._fetchInstances();
        }
        private LineText displacement;
        private LineText tightness;
        private LineText period;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * displacement <value> - Maximum displacement distance for physics simulation
         */
        public LineText displacement() { return displacement; }

        /**
         * tightness <value> - Tightness/stiffness of spring simulation (0.0-1.0)
         */
        public LineText tightness() { return tightness; }

        /**
         * period <value> - Oscillation period in seconds
         */
        public LineText period() { return period; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Data array keywords
     */
    public static class DataArrays extends KaitaiStruct {
        public static DataArrays fromFile(String fileName) throws IOException {
            return new DataArrays(new ByteBufferKaitaiStream(fileName));
        }

        public DataArrays(KaitaiStream _io) {
            this(_io, null, null);
        }

        public DataArrays(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public DataArrays(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.verts = new LineText(this._io, this, _root);
            this.faces = new LineText(this._io, this, _root);
            this.tverts = new LineText(this._io, this, _root);
            this.tverts1 = new LineText(this._io, this, _root);
            this.lightmaptverts = new LineText(this._io, this, _root);
            this.tverts2 = new LineText(this._io, this, _root);
            this.tverts3 = new LineText(this._io, this, _root);
            this.texindices1 = new LineText(this._io, this, _root);
            this.texindices2 = new LineText(this._io, this, _root);
            this.texindices3 = new LineText(this._io, this, _root);
            this.colors = new LineText(this._io, this, _root);
            this.colorindices = new LineText(this._io, this, _root);
            this.weights = new LineText(this._io, this, _root);
            this.constraints = new LineText(this._io, this, _root);
            this.aabb = new LineText(this._io, this, _root);
            this.saberVerts = new LineText(this._io, this, _root);
            this.saberNorms = new LineText(this._io, this, _root);
            this.name = new LineText(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.verts._fetchInstances();
            this.faces._fetchInstances();
            this.tverts._fetchInstances();
            this.tverts1._fetchInstances();
            this.lightmaptverts._fetchInstances();
            this.tverts2._fetchInstances();
            this.tverts3._fetchInstances();
            this.texindices1._fetchInstances();
            this.texindices2._fetchInstances();
            this.texindices3._fetchInstances();
            this.colors._fetchInstances();
            this.colorindices._fetchInstances();
            this.weights._fetchInstances();
            this.constraints._fetchInstances();
            this.aabb._fetchInstances();
            this.saberVerts._fetchInstances();
            this.saberNorms._fetchInstances();
            this.name._fetchInstances();
        }
        private LineText verts;
        private LineText faces;
        private LineText tverts;
        private LineText tverts1;
        private LineText lightmaptverts;
        private LineText tverts2;
        private LineText tverts3;
        private LineText texindices1;
        private LineText texindices2;
        private LineText texindices3;
        private LineText colors;
        private LineText colorindices;
        private LineText weights;
        private LineText constraints;
        private LineText aabb;
        private LineText saberVerts;
        private LineText saberNorms;
        private LineText name;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * verts <count> - Start vertex positions array (count vertices, 3 floats each: X, Y, Z)
         */
        public LineText verts() { return verts; }

        /**
         * faces <count> - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3])
         */
        public LineText faces() { return faces; }

        /**
         * tverts <count> - Start primary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        public LineText tverts() { return tverts; }

        /**
         * tverts1 <count> - Start secondary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        public LineText tverts1() { return tverts1; }

        /**
         * lightmaptverts <count> - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1)
         */
        public LineText lightmaptverts() { return lightmaptverts; }

        /**
         * tverts2 <count> - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        public LineText tverts2() { return tverts2; }

        /**
         * tverts3 <count> - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        public LineText tverts3() { return tverts3; }

        /**
         * texindices1 <count> - Start texture indices array for 2nd texture (count face indices, 3 indices per face)
         */
        public LineText texindices1() { return texindices1; }

        /**
         * texindices2 <count> - Start texture indices array for 3rd texture (count face indices, 3 indices per face)
         */
        public LineText texindices2() { return texindices2; }

        /**
         * texindices3 <count> - Start texture indices array for 4th texture (count face indices, 3 indices per face)
         */
        public LineText texindices3() { return texindices3; }

        /**
         * colors <count> - Start vertex colors array (count colors, 3 floats each: R, G, B)
         */
        public LineText colors() { return colors; }

        /**
         * colorindices <count> - Start vertex color indices array (count face indices, 3 indices per face)
         */
        public LineText colorindices() { return colorindices; }

        /**
         * weights <count> - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]])
         */
        public LineText weights() { return weights; }

        /**
         * constraints <count> - Start vertex constraints array for danglymesh (count floats, one per vertex)
         */
        public LineText constraints() { return constraints; }

        /**
         * aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line)
         */
        public LineText aabb() { return aabb; }

        /**
         * saber_verts <count> - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z)
         */
        public LineText saberVerts() { return saberVerts; }

        /**
         * saber_norms <count> - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z)
         */
        public LineText saberNorms() { return saberNorms; }

        /**
         * name <node_name> - MDLedit-style name entry for walkmesh nodes (fakenodes)
         */
        public LineText name() { return name; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Emitter behavior flags
     */
    public static class EmitterFlags extends KaitaiStruct {
        public static EmitterFlags fromFile(String fileName) throws IOException {
            return new EmitterFlags(new ByteBufferKaitaiStream(fileName));
        }

        public EmitterFlags(KaitaiStream _io) {
            this(_io, null, null);
        }

        public EmitterFlags(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public EmitterFlags(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.p2p = new LineText(this._io, this, _root);
            this.p2pSel = new LineText(this._io, this, _root);
            this.affectedByWind = new LineText(this._io, this, _root);
            this.mIsTinted = new LineText(this._io, this, _root);
            this.bounce = new LineText(this._io, this, _root);
            this.random = new LineText(this._io, this, _root);
            this.inherit = new LineText(this._io, this, _root);
            this.inheritvel = new LineText(this._io, this, _root);
            this.inheritLocal = new LineText(this._io, this, _root);
            this.splat = new LineText(this._io, this, _root);
            this.inheritPart = new LineText(this._io, this, _root);
            this.depthTexture = new LineText(this._io, this, _root);
            this.emitterflag13 = new LineText(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.p2p._fetchInstances();
            this.p2pSel._fetchInstances();
            this.affectedByWind._fetchInstances();
            this.mIsTinted._fetchInstances();
            this.bounce._fetchInstances();
            this.random._fetchInstances();
            this.inherit._fetchInstances();
            this.inheritvel._fetchInstances();
            this.inheritLocal._fetchInstances();
            this.splat._fetchInstances();
            this.inheritPart._fetchInstances();
            this.depthTexture._fetchInstances();
            this.emitterflag13._fetchInstances();
        }
        private LineText p2p;
        private LineText p2pSel;
        private LineText affectedByWind;
        private LineText mIsTinted;
        private LineText bounce;
        private LineText random;
        private LineText inherit;
        private LineText inheritvel;
        private LineText inheritLocal;
        private LineText splat;
        private LineText inheritPart;
        private LineText depthTexture;
        private LineText emitterflag13;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * p2p <0_or_1> - Point-to-point flag (bit 0x0001)
         */
        public LineText p2p() { return p2p; }

        /**
         * p2p_sel <0_or_1> - Point-to-point selection flag (bit 0x0002)
         */
        public LineText p2pSel() { return p2pSel; }

        /**
         * affectedByWind <0_or_1> - Affected by wind flag (bit 0x0004)
         */
        public LineText affectedByWind() { return affectedByWind; }

        /**
         * m_isTinted <0_or_1> - Is tinted flag (bit 0x0008)
         */
        public LineText mIsTinted() { return mIsTinted; }

        /**
         * bounce <0_or_1> - Bounce flag (bit 0x0010)
         */
        public LineText bounce() { return bounce; }

        /**
         * random <0_or_1> - Random flag (bit 0x0020)
         */
        public LineText random() { return random; }

        /**
         * inherit <0_or_1> - Inherit flag (bit 0x0040)
         */
        public LineText inherit() { return inherit; }

        /**
         * inheritvel <0_or_1> - Inherit velocity flag (bit 0x0080)
         */
        public LineText inheritvel() { return inheritvel; }

        /**
         * inherit_local <0_or_1> - Inherit local flag (bit 0x0100)
         */
        public LineText inheritLocal() { return inheritLocal; }

        /**
         * splat <0_or_1> - Splat flag (bit 0x0200)
         */
        public LineText splat() { return splat; }

        /**
         * inherit_part <0_or_1> - Inherit part flag (bit 0x0400)
         */
        public LineText inheritPart() { return inheritPart; }

        /**
         * depth_texture <0_or_1> - Depth texture flag (bit 0x0800)
         */
        public LineText depthTexture() { return depthTexture; }

        /**
         * emitterflag13 <0_or_1> - Emitter flag 13 (bit 0x1000)
         */
        public LineText emitterflag13() { return emitterflag13; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Emitter node properties
     */
    public static class EmitterProperties extends KaitaiStruct {
        public static EmitterProperties fromFile(String fileName) throws IOException {
            return new EmitterProperties(new ByteBufferKaitaiStream(fileName));
        }

        public EmitterProperties(KaitaiStream _io) {
            this(_io, null, null);
        }

        public EmitterProperties(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public EmitterProperties(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.deadspace = new LineText(this._io, this, _root);
            this.blastRadius = new LineText(this._io, this, _root);
            this.blastLength = new LineText(this._io, this, _root);
            this.numBranches = new LineText(this._io, this, _root);
            this.controlptsmoothing = new LineText(this._io, this, _root);
            this.xgrid = new LineText(this._io, this, _root);
            this.ygrid = new LineText(this._io, this, _root);
            this.spawntype = new LineText(this._io, this, _root);
            this.update = new LineText(this._io, this, _root);
            this.render = new LineText(this._io, this, _root);
            this.blend = new LineText(this._io, this, _root);
            this.texture = new LineText(this._io, this, _root);
            this.chunkname = new LineText(this._io, this, _root);
            this.twosidedtex = new LineText(this._io, this, _root);
            this.loop = new LineText(this._io, this, _root);
            this.renderorder = new LineText(this._io, this, _root);
            this.mBFrameBlending = new LineText(this._io, this, _root);
            this.mSDepthTextureName = new LineText(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.deadspace._fetchInstances();
            this.blastRadius._fetchInstances();
            this.blastLength._fetchInstances();
            this.numBranches._fetchInstances();
            this.controlptsmoothing._fetchInstances();
            this.xgrid._fetchInstances();
            this.ygrid._fetchInstances();
            this.spawntype._fetchInstances();
            this.update._fetchInstances();
            this.render._fetchInstances();
            this.blend._fetchInstances();
            this.texture._fetchInstances();
            this.chunkname._fetchInstances();
            this.twosidedtex._fetchInstances();
            this.loop._fetchInstances();
            this.renderorder._fetchInstances();
            this.mBFrameBlending._fetchInstances();
            this.mSDepthTextureName._fetchInstances();
        }
        private LineText deadspace;
        private LineText blastRadius;
        private LineText blastLength;
        private LineText numBranches;
        private LineText controlptsmoothing;
        private LineText xgrid;
        private LineText ygrid;
        private LineText spawntype;
        private LineText update;
        private LineText render;
        private LineText blend;
        private LineText texture;
        private LineText chunkname;
        private LineText twosidedtex;
        private LineText loop;
        private LineText renderorder;
        private LineText mBFrameBlending;
        private LineText mSDepthTextureName;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * deadspace <value> - Minimum distance from emitter before particles become visible
         */
        public LineText deadspace() { return deadspace; }

        /**
         * blastRadius <value> - Radius of explosive/blast particle effects
         */
        public LineText blastRadius() { return blastRadius; }

        /**
         * blastLength <value> - Length/duration of blast effects
         */
        public LineText blastLength() { return blastLength; }

        /**
         * numBranches <value> - Number of branching paths for particle trails
         */
        public LineText numBranches() { return numBranches; }

        /**
         * controlptsmoothing <value> - Smoothing factor for particle path control points
         */
        public LineText controlptsmoothing() { return controlptsmoothing; }

        /**
         * xgrid <value> - Grid subdivisions along X axis for particle spawning
         */
        public LineText xgrid() { return xgrid; }

        /**
         * ygrid <value> - Grid subdivisions along Y axis for particle spawning
         */
        public LineText ygrid() { return ygrid; }

        /**
         * spawntype <value> - Particle spawn type
         */
        public LineText spawntype() { return spawntype; }

        /**
         * update <script_name> - Update behavior script name (e.g., single, fountain)
         */
        public LineText update() { return update; }

        /**
         * render <script_name> - Render mode script name (e.g., normal, billboard_to_local_z)
         */
        public LineText render() { return render; }

        /**
         * blend <script_name> - Blend mode script name (e.g., normal, lighten)
         */
        public LineText blend() { return blend; }

        /**
         * texture <texture_name> - Particle texture name
         */
        public LineText texture() { return texture; }

        /**
         * chunkname <chunk_name> - Associated model chunk name
         */
        public LineText chunkname() { return chunkname; }

        /**
         * twosidedtex <0_or_1> - Whether texture should render two-sided (1=two-sided, 0=single-sided)
         */
        public LineText twosidedtex() { return twosidedtex; }

        /**
         * loop <0_or_1> - Whether particle system loops (1=loops, 0=single playback)
         */
        public LineText loop() { return loop; }

        /**
         * renderorder <value> - Rendering priority/order for particle sorting
         */
        public LineText renderorder() { return renderorder; }

        /**
         * m_bFrameBlending <0_or_1> - Whether frame blending is enabled (1=enabled, 0=disabled)
         */
        public LineText mBFrameBlending() { return mBFrameBlending; }

        /**
         * m_sDepthTextureName <texture_name> - Depth/softparticle texture name
         */
        public LineText mSDepthTextureName() { return mSDepthTextureName; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Light node properties
     */
    public static class LightProperties extends KaitaiStruct {
        public static LightProperties fromFile(String fileName) throws IOException {
            return new LightProperties(new ByteBufferKaitaiStream(fileName));
        }

        public LightProperties(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LightProperties(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public LightProperties(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.flareradius = new LineText(this._io, this, _root);
            this.flarepositions = new LineText(this._io, this, _root);
            this.flaresizes = new LineText(this._io, this, _root);
            this.flarecolorshifts = new LineText(this._io, this, _root);
            this.texturenames = new LineText(this._io, this, _root);
            this.ambientonly = new LineText(this._io, this, _root);
            this.ndynamictype = new LineText(this._io, this, _root);
            this.affectdynamic = new LineText(this._io, this, _root);
            this.flare = new LineText(this._io, this, _root);
            this.lightpriority = new LineText(this._io, this, _root);
            this.fadinglight = new LineText(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.flareradius._fetchInstances();
            this.flarepositions._fetchInstances();
            this.flaresizes._fetchInstances();
            this.flarecolorshifts._fetchInstances();
            this.texturenames._fetchInstances();
            this.ambientonly._fetchInstances();
            this.ndynamictype._fetchInstances();
            this.affectdynamic._fetchInstances();
            this.flare._fetchInstances();
            this.lightpriority._fetchInstances();
            this.fadinglight._fetchInstances();
        }
        private LineText flareradius;
        private LineText flarepositions;
        private LineText flaresizes;
        private LineText flarecolorshifts;
        private LineText texturenames;
        private LineText ambientonly;
        private LineText ndynamictype;
        private LineText affectdynamic;
        private LineText flare;
        private LineText lightpriority;
        private LineText fadinglight;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * flareradius <value> - Radius of lens flare effect
         */
        public LineText flareradius() { return flareradius; }

        /**
         * flarepositions <count> - Start flare positions array (count floats, 0.0-1.0 along light ray)
         */
        public LineText flarepositions() { return flarepositions; }

        /**
         * flaresizes <count> - Start flare sizes array (count floats)
         */
        public LineText flaresizes() { return flaresizes; }

        /**
         * flarecolorshifts <count> - Start flare color shifts array (count RGB floats)
         */
        public LineText flarecolorshifts() { return flarecolorshifts; }

        /**
         * texturenames <count> - Start flare texture names array (count strings)
         */
        public LineText texturenames() { return texturenames; }

        /**
         * ambientonly <0_or_1> - Whether light only affects ambient (1=ambient only, 0=full lighting)
         */
        public LineText ambientonly() { return ambientonly; }

        /**
         * ndynamictype <value> - Type of dynamic lighting behavior
         */
        public LineText ndynamictype() { return ndynamictype; }

        /**
         * affectdynamic <0_or_1> - Whether light affects dynamic objects (1=affects, 0=static only)
         */
        public LineText affectdynamic() { return affectdynamic; }

        /**
         * flare <0_or_1> - Whether lens flare effect is enabled (1=enabled, 0=disabled)
         */
        public LineText flare() { return flare; }

        /**
         * lightpriority <value> - Rendering priority for light culling/sorting
         */
        public LineText lightpriority() { return lightpriority; }

        /**
         * fadinglight <0_or_1> - Whether light intensity fades with distance (1=fades, 0=constant)
         */
        public LineText fadinglight() { return fadinglight; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * A single UTF-8 text line (without the trailing newline).
     * Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
     */
    public static class LineText extends KaitaiStruct {
        public static LineText fromFile(String fileName) throws IOException {
            return new LineText(new ByteBufferKaitaiStream(fileName));
        }

        public LineText(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LineText(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public LineText(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.value = new String(this._io.readBytesTerm((byte) 10, false, true, false), StandardCharsets.UTF_8);
        }

        public void _fetchInstances() {
        }
        private String value;
        private MdlAscii _root;
        private KaitaiStruct _parent;
        public String value() { return value; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Reference node properties
     */
    public static class ReferenceProperties extends KaitaiStruct {
        public static ReferenceProperties fromFile(String fileName) throws IOException {
            return new ReferenceProperties(new ByteBufferKaitaiStream(fileName));
        }

        public ReferenceProperties(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ReferenceProperties(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public ReferenceProperties(KaitaiStream _io, KaitaiStruct _parent, MdlAscii _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.refmodel = new LineText(this._io, this, _root);
            this.reattachable = new LineText(this._io, this, _root);
        }

        public void _fetchInstances() {
            this.refmodel._fetchInstances();
            this.reattachable._fetchInstances();
        }
        private LineText refmodel;
        private LineText reattachable;
        private MdlAscii _root;
        private KaitaiStruct _parent;

        /**
         * refmodel <model_resref> - Referenced model resource name without extension
         */
        public LineText refmodel() { return refmodel; }

        /**
         * reattachable <0_or_1> - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent)
         */
        public LineText reattachable() { return reattachable; }
        public MdlAscii _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }
    private List<AsciiLine> lines;
    private MdlAscii _root;
    private KaitaiStruct _parent;
    public List<AsciiLine> lines() { return lines; }
    public MdlAscii _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}
