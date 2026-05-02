// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "bioware_mdl_common.h"
std::set<bioware_mdl_common_t::controller_type_t> bioware_mdl_common_t::_build_values_controller_type_t() {
    std::set<bioware_mdl_common_t::controller_type_t> _t;
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_POSITION);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_ORIENTATION);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_SCALE);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_COLOR);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_ALPHA_END);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_ALPHA_START);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_RADIUS);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_BOUNCE_COEFFICIENT);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_SHADOW_RADIUS);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_VERTICAL_DISPLACEMENT_OR_DRAG_OR_SELFILLUMCOLOR);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_FPS);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_FRAME_END);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_FRAME_START);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_GRAVITY);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_LIFE_EXPECTANCY);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_MASS);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_ALPHA);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_PARTICLE_ROTATION);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_MULTIPLIER_OR_RANDVEL);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_SIZE_START);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_SIZE_END);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_SIZE_START_Y);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_SIZE_END_Y);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_SPREAD);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_THRESHOLD);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_VELOCITY);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_X_SIZE);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_Y_SIZE);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_BLUR_LENGTH);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_LIGHTNING_DELAY);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_LIGHTNING_RADIUS);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_LIGHTNING_SCALE);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_LIGHTNING_SUBDIVIDE);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_LIGHTNING_ZIG_ZAG);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_ALPHA_MID);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_PERCENT_START);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_PERCENT_MID);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_PERCENT_END);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_SIZE_MID);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_SIZE_MID_Y);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_RANDOM_BIRTH_RATE);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_TARGET_SIZE);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_NUM_CONTROL_POINTS);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_CONTROL_POINT_RADIUS);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_CONTROL_POINT_DELAY);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_TANGENT_SPREAD);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_TANGENT_LENGTH);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_COLOR_MID);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_COLOR_END);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_COLOR_START);
    _t.insert(bioware_mdl_common_t::CONTROLLER_TYPE_EMITTER_DETONATE);
    return _t;
}
const std::set<bioware_mdl_common_t::controller_type_t> bioware_mdl_common_t::_values_controller_type_t = bioware_mdl_common_t::_build_values_controller_type_t();
bool bioware_mdl_common_t::_is_defined_controller_type_t(bioware_mdl_common_t::controller_type_t v) {
    return bioware_mdl_common_t::_values_controller_type_t.find(v) != bioware_mdl_common_t::_values_controller_type_t.end();
}
std::set<bioware_mdl_common_t::model_classification_t> bioware_mdl_common_t::_build_values_model_classification_t() {
    std::set<bioware_mdl_common_t::model_classification_t> _t;
    _t.insert(bioware_mdl_common_t::MODEL_CLASSIFICATION_OTHER);
    _t.insert(bioware_mdl_common_t::MODEL_CLASSIFICATION_EFFECT);
    _t.insert(bioware_mdl_common_t::MODEL_CLASSIFICATION_TILE);
    _t.insert(bioware_mdl_common_t::MODEL_CLASSIFICATION_CHARACTER);
    _t.insert(bioware_mdl_common_t::MODEL_CLASSIFICATION_DOOR);
    _t.insert(bioware_mdl_common_t::MODEL_CLASSIFICATION_LIGHTSABER);
    _t.insert(bioware_mdl_common_t::MODEL_CLASSIFICATION_PLACEABLE);
    _t.insert(bioware_mdl_common_t::MODEL_CLASSIFICATION_FLYER);
    return _t;
}
const std::set<bioware_mdl_common_t::model_classification_t> bioware_mdl_common_t::_values_model_classification_t = bioware_mdl_common_t::_build_values_model_classification_t();
bool bioware_mdl_common_t::_is_defined_model_classification_t(bioware_mdl_common_t::model_classification_t v) {
    return bioware_mdl_common_t::_values_model_classification_t.find(v) != bioware_mdl_common_t::_values_model_classification_t.end();
}
std::set<bioware_mdl_common_t::node_type_value_t> bioware_mdl_common_t::_build_values_node_type_value_t() {
    std::set<bioware_mdl_common_t::node_type_value_t> _t;
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_DUMMY);
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_LIGHT);
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_EMITTER);
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_REFERENCE);
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_TRIMESH);
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_SKINMESH);
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_ANIMMESH);
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_DANGLYMESH);
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_AABB);
    _t.insert(bioware_mdl_common_t::NODE_TYPE_VALUE_LIGHTSABER);
    return _t;
}
const std::set<bioware_mdl_common_t::node_type_value_t> bioware_mdl_common_t::_values_node_type_value_t = bioware_mdl_common_t::_build_values_node_type_value_t();
bool bioware_mdl_common_t::_is_defined_node_type_value_t(bioware_mdl_common_t::node_type_value_t v) {
    return bioware_mdl_common_t::_values_node_type_value_t.find(v) != bioware_mdl_common_t::_values_node_type_value_t.end();
}

bioware_mdl_common_t::bioware_mdl_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, bioware_mdl_common_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void bioware_mdl_common_t::_read() {
}

bioware_mdl_common_t::~bioware_mdl_common_t() {
    _clean_up();
}

void bioware_mdl_common_t::_clean_up() {
}
