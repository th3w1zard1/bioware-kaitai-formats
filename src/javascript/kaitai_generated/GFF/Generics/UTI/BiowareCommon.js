// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.BiowareCommon || (root.BiowareCommon = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (BiowareCommon_, KaitaiStream) {
/**
 * Shared enums and "common objects" used across the BioWare ecosystem that also appear
 * in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).
 * 
 * This file is intended to be imported by other `.ksy` files to avoid repeating:
 * - Language IDs (used in TLK headers and GFF LocalizedString substrings)
 * - Gender IDs (used in GFF LocalizedString substrings)
 * - The CExoLocString / LocalizedString binary layout
 * 
 * References:
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py
 * - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py
 * - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33
 * - https://github.com/modawan/reone/blob/master/include/reone/resource/types.h
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py|PyKotor — Language (substring language IDs)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py|PyKotor — Gender / Game / EquipmentSlot}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py|PyKotor — ObjectType}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L235|PyKotor — GFF field read path (LocalizedString via reader)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73|xoreos — `Language` / `LanguageGender` (Aurora runtime; compare TLK / substring packing)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L57-L92|xoreos — `TalkTable_TLK::load` (TLK header + language id field)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33|xoreos-tools — `byte` / `uint` typedefs}
 * @see {@link https://github.com/modawan/reone/blob/master/include/reone/resource/types.h|reone — resource type / engine constants}
 * @see {@link https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware|xoreos-docs — BioWare specs PDF tree (discoverability)}
 */

var BiowareCommon = (function() {
  BiowareCommon.BiowareDdsVariantBytesPerPixel = Object.freeze({
    DXT1: 3,
    DXT5: 4,

    3: "DXT1",
    4: "DXT5",
  });

  BiowareCommon.BiowareEquipmentSlotFlag = Object.freeze({
    INVALID: 0,
    HEAD: 1,
    ARMOR: 2,
    GAUNTLET: 8,
    RIGHT_HAND: 16,
    LEFT_HAND: 32,
    RIGHT_ARM: 128,
    LEFT_ARM: 256,
    IMPLANT: 512,
    BELT: 1024,
    CLAW1: 16384,
    CLAW2: 32768,
    CLAW3: 65536,
    HIDE: 131072,
    RIGHT_HAND_2: 262144,
    LEFT_HAND_2: 524288,

    0: "INVALID",
    1: "HEAD",
    2: "ARMOR",
    8: "GAUNTLET",
    16: "RIGHT_HAND",
    32: "LEFT_HAND",
    128: "RIGHT_ARM",
    256: "LEFT_ARM",
    512: "IMPLANT",
    1024: "BELT",
    16384: "CLAW1",
    32768: "CLAW2",
    65536: "CLAW3",
    131072: "HIDE",
    262144: "RIGHT_HAND_2",
    524288: "LEFT_HAND_2",
  });

  BiowareCommon.BiowareGameId = Object.freeze({
    K1: 1,
    K2: 2,
    K1_XBOX: 3,
    K2_XBOX: 4,
    K1_IOS: 5,
    K2_IOS: 6,
    K1_ANDROID: 7,
    K2_ANDROID: 8,

    1: "K1",
    2: "K2",
    3: "K1_XBOX",
    4: "K2_XBOX",
    5: "K1_IOS",
    6: "K2_IOS",
    7: "K1_ANDROID",
    8: "K2_ANDROID",
  });

  BiowareCommon.BiowareGenderId = Object.freeze({
    MALE: 0,
    FEMALE: 1,

    0: "MALE",
    1: "FEMALE",
  });

  BiowareCommon.BiowareLanguageId = Object.freeze({
    ENGLISH: 0,
    FRENCH: 1,
    GERMAN: 2,
    ITALIAN: 3,
    SPANISH: 4,
    POLISH: 5,
    AFRIKAANS: 6,
    BASQUE: 7,
    BRETON: 9,
    CATALAN: 10,
    CHAMORRO: 11,
    CHICHEWA: 12,
    CORSICAN: 13,
    DANISH: 14,
    DUTCH: 15,
    FAROESE: 16,
    FILIPINO: 18,
    FINNISH: 19,
    FLEMISH: 20,
    FRISIAN: 21,
    GALICIAN: 22,
    GANDA: 23,
    HAITIAN_CREOLE: 24,
    HAUSA_LATIN: 25,
    HAWAIIAN: 26,
    ICELANDIC: 27,
    IDO: 28,
    INDONESIAN: 29,
    IGBO: 30,
    IRISH: 31,
    INTERLINGUA: 32,
    JAVANESE_LATIN: 33,
    LATIN: 34,
    LUXEMBOURGISH: 35,
    MALTESE: 36,
    NORWEGIAN: 37,
    OCCITAN: 38,
    PORTUGUESE: 39,
    SCOTS: 40,
    SCOTTISH_GAELIC: 41,
    SHONA: 42,
    SOTO: 43,
    SUNDANESE_LATIN: 44,
    SWAHILI: 45,
    SWEDISH: 46,
    TAGALOG: 47,
    TAHITIAN: 48,
    TONGAN: 49,
    UZBEK_LATIN: 50,
    WALLOON: 51,
    XHOSA: 52,
    YORUBA: 53,
    WELSH: 54,
    ZULU: 55,
    BULGARIAN: 58,
    BELARISIAN: 59,
    MACEDONIAN: 60,
    RUSSIAN: 61,
    SERBIAN_CYRILLIC: 62,
    TAJIK: 63,
    TATAR_CYRILLIC: 64,
    UKRAINIAN: 66,
    UZBEK: 67,
    ALBANIAN: 68,
    BOSNIAN_LATIN: 69,
    CZECH: 70,
    SLOVAK: 71,
    SLOVENE: 72,
    CROATIAN: 73,
    HUNGARIAN: 75,
    ROMANIAN: 76,
    GREEK: 77,
    ESPERANTO: 78,
    AZERBAIJANI_LATIN: 79,
    TURKISH: 81,
    TURKMEN_LATIN: 82,
    HEBREW: 83,
    ARABIC: 84,
    ESTONIAN: 85,
    LATVIAN: 86,
    LITHUANIAN: 87,
    VIETNAMESE: 88,
    THAI: 89,
    AYMARA: 90,
    KINYARWANDA: 91,
    KURDISH_LATIN: 92,
    MALAGASY: 93,
    MALAY_LATIN: 94,
    MAORI: 95,
    MOLDOVAN_LATIN: 96,
    SAMOAN: 97,
    SOMALI: 98,
    KOREAN: 128,
    CHINESE_TRADITIONAL: 129,
    CHINESE_SIMPLIFIED: 130,
    JAPANESE: 131,
    UNKNOWN: 2147483646,

    0: "ENGLISH",
    1: "FRENCH",
    2: "GERMAN",
    3: "ITALIAN",
    4: "SPANISH",
    5: "POLISH",
    6: "AFRIKAANS",
    7: "BASQUE",
    9: "BRETON",
    10: "CATALAN",
    11: "CHAMORRO",
    12: "CHICHEWA",
    13: "CORSICAN",
    14: "DANISH",
    15: "DUTCH",
    16: "FAROESE",
    18: "FILIPINO",
    19: "FINNISH",
    20: "FLEMISH",
    21: "FRISIAN",
    22: "GALICIAN",
    23: "GANDA",
    24: "HAITIAN_CREOLE",
    25: "HAUSA_LATIN",
    26: "HAWAIIAN",
    27: "ICELANDIC",
    28: "IDO",
    29: "INDONESIAN",
    30: "IGBO",
    31: "IRISH",
    32: "INTERLINGUA",
    33: "JAVANESE_LATIN",
    34: "LATIN",
    35: "LUXEMBOURGISH",
    36: "MALTESE",
    37: "NORWEGIAN",
    38: "OCCITAN",
    39: "PORTUGUESE",
    40: "SCOTS",
    41: "SCOTTISH_GAELIC",
    42: "SHONA",
    43: "SOTO",
    44: "SUNDANESE_LATIN",
    45: "SWAHILI",
    46: "SWEDISH",
    47: "TAGALOG",
    48: "TAHITIAN",
    49: "TONGAN",
    50: "UZBEK_LATIN",
    51: "WALLOON",
    52: "XHOSA",
    53: "YORUBA",
    54: "WELSH",
    55: "ZULU",
    58: "BULGARIAN",
    59: "BELARISIAN",
    60: "MACEDONIAN",
    61: "RUSSIAN",
    62: "SERBIAN_CYRILLIC",
    63: "TAJIK",
    64: "TATAR_CYRILLIC",
    66: "UKRAINIAN",
    67: "UZBEK",
    68: "ALBANIAN",
    69: "BOSNIAN_LATIN",
    70: "CZECH",
    71: "SLOVAK",
    72: "SLOVENE",
    73: "CROATIAN",
    75: "HUNGARIAN",
    76: "ROMANIAN",
    77: "GREEK",
    78: "ESPERANTO",
    79: "AZERBAIJANI_LATIN",
    81: "TURKISH",
    82: "TURKMEN_LATIN",
    83: "HEBREW",
    84: "ARABIC",
    85: "ESTONIAN",
    86: "LATVIAN",
    87: "LITHUANIAN",
    88: "VIETNAMESE",
    89: "THAI",
    90: "AYMARA",
    91: "KINYARWANDA",
    92: "KURDISH_LATIN",
    93: "MALAGASY",
    94: "MALAY_LATIN",
    95: "MAORI",
    96: "MOLDOVAN_LATIN",
    97: "SAMOAN",
    98: "SOMALI",
    128: "KOREAN",
    129: "CHINESE_TRADITIONAL",
    130: "CHINESE_SIMPLIFIED",
    131: "JAPANESE",
    2147483646: "UNKNOWN",
  });

  BiowareCommon.BiowareLipVisemeId = Object.freeze({
    NEUTRAL: 0,
    EE: 1,
    EH: 2,
    AH: 3,
    OH: 4,
    OOH: 5,
    Y: 6,
    STS: 7,
    FV: 8,
    NG: 9,
    TH: 10,
    MPB: 11,
    TD: 12,
    SH: 13,
    L: 14,
    KG: 15,

    0: "NEUTRAL",
    1: "EE",
    2: "EH",
    3: "AH",
    4: "OH",
    5: "OOH",
    6: "Y",
    7: "STS",
    8: "FV",
    9: "NG",
    10: "TH",
    11: "MPB",
    12: "TD",
    13: "SH",
    14: "L",
    15: "KG",
  });

  BiowareCommon.BiowareLtrAlphabetLength = Object.freeze({
    NEVERWINTER_NIGHTS: 26,
    KOTOR: 28,

    26: "NEVERWINTER_NIGHTS",
    28: "KOTOR",
  });

  BiowareCommon.BiowareObjectTypeId = Object.freeze({
    INVALID: 0,
    CREATURE: 1,
    DOOR: 2,
    ITEM: 3,
    TRIGGER: 4,
    PLACEABLE: 5,
    WAYPOINT: 6,
    ENCOUNTER: 7,
    STORE: 8,
    AREA: 9,
    SOUND: 10,
    CAMERA: 11,

    0: "INVALID",
    1: "CREATURE",
    2: "DOOR",
    3: "ITEM",
    4: "TRIGGER",
    5: "PLACEABLE",
    6: "WAYPOINT",
    7: "ENCOUNTER",
    8: "STORE",
    9: "AREA",
    10: "SOUND",
    11: "CAMERA",
  });

  BiowareCommon.BiowarePccCompressionCodec = Object.freeze({
    NONE: 0,
    ZLIB: 1,
    LZO: 2,

    0: "NONE",
    1: "ZLIB",
    2: "LZO",
  });

  BiowareCommon.BiowarePccPackageKind = Object.freeze({
    NORMAL_PACKAGE: 0,
    PATCH_PACKAGE: 1,

    0: "NORMAL_PACKAGE",
    1: "PATCH_PACKAGE",
  });

  BiowareCommon.BiowareTpcPixelFormatId = Object.freeze({
    GREYSCALE: 1,
    RGB_OR_DXT1: 2,
    RGBA_OR_DXT5: 4,
    BGRA_XBOX_SWIZZLE: 12,

    1: "GREYSCALE",
    2: "RGB_OR_DXT1",
    4: "RGBA_OR_DXT5",
    12: "BGRA_XBOX_SWIZZLE",
  });

  BiowareCommon.RiffWaveFormatTag = Object.freeze({
    PCM: 1,
    ADPCM_MS: 2,
    IEEE_FLOAT: 3,
    ALAW: 6,
    MULAW: 7,
    DVI_IMA_ADPCM: 17,
    MPEG_LAYER3: 85,
    WAVE_FORMAT_EXTENSIBLE: 65534,

    1: "PCM",
    2: "ADPCM_MS",
    3: "IEEE_FLOAT",
    6: "ALAW",
    7: "MULAW",
    17: "DVI_IMA_ADPCM",
    85: "MPEG_LAYER3",
    65534: "WAVE_FORMAT_EXTENSIBLE",
  });

  function BiowareCommon(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  BiowareCommon.prototype._read = function() {
  }

  /**
   * Variable-length binary data with 4-byte length prefix.
   * Used for Void/Binary fields in GFF files.
   */

  var BiowareBinaryData = BiowareCommon.BiowareBinaryData = (function() {
    function BiowareBinaryData(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareBinaryData.prototype._read = function() {
      this.lenValue = this._io.readU4le();
      this.value = this._io.readBytes(this.lenValue);
    }

    /**
     * Length of binary data in bytes
     */

    /**
     * Binary data
     */

    return BiowareBinaryData;
  })();

  /**
   * BioWare CExoString - variable-length string with 4-byte length prefix.
   * Used for string fields in GFF files.
   */

  var BiowareCexoString = BiowareCommon.BiowareCexoString = (function() {
    function BiowareCexoString(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareCexoString.prototype._read = function() {
      this.lenString = this._io.readU4le();
      this.value = KaitaiStream.bytesToStr(this._io.readBytes(this.lenString), "UTF-8");
    }

    /**
     * Length of string in bytes
     */

    /**
     * String data (UTF-8)
     */

    return BiowareCexoString;
  })();

  /**
   * BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
   * section for field type "LocalizedString".
   */

  var BiowareLocstring = BiowareCommon.BiowareLocstring = (function() {
    function BiowareLocstring(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareLocstring.prototype._read = function() {
      this.totalSize = this._io.readU4le();
      this.stringRef = this._io.readU4le();
      this.numSubstrings = this._io.readU4le();
      this.substrings = [];
      for (var i = 0; i < this.numSubstrings; i++) {
        this.substrings.push(new Substring(this._io, this, this._root));
      }
    }

    /**
     * True if this locstring references dialog.tlk
     */
    Object.defineProperty(BiowareLocstring.prototype, 'hasStrref', {
      get: function() {
        if (this._m_hasStrref !== undefined)
          return this._m_hasStrref;
        this._m_hasStrref = this.stringRef != 4294967295;
        return this._m_hasStrref;
      }
    });

    /**
     * Total size of the structure in bytes (excluding this field).
     */

    /**
     * StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).
     */

    /**
     * Number of substring entries that follow.
     */

    /**
     * Language/gender-specific substring entries.
     */

    return BiowareLocstring;
  })();

  /**
   * BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
   * Used throughout GFF files to reference game resources by name.
   */

  var BiowareResref = BiowareCommon.BiowareResref = (function() {
    function BiowareResref(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareResref.prototype._read = function() {
      this.lenResref = this._io.readU1();
      if (!(this.lenResref <= 16)) {
        throw new KaitaiStream.ValidationGreaterThanError(16, this.lenResref, this._io, "/types/bioware_resref/seq/0");
      }
      this.value = KaitaiStream.bytesToStr(this._io.readBytes(this.lenResref), "ASCII");
    }

    /**
     * Length of ResRef string (0-16 characters)
     */

    /**
     * ResRef string data (ASCII, lowercase recommended)
     */

    return BiowareResref;
  })();

  /**
   * 3D vector (X, Y, Z coordinates).
   * Used for positions, directions, etc. in game files.
   */

  var BiowareVector3 = BiowareCommon.BiowareVector3 = (function() {
    function BiowareVector3(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareVector3.prototype._read = function() {
      this.x = this._io.readF4le();
      this.y = this._io.readF4le();
      this.z = this._io.readF4le();
    }

    /**
     * X coordinate
     */

    /**
     * Y coordinate
     */

    /**
     * Z coordinate
     */

    return BiowareVector3;
  })();

  /**
   * 4D vector / Quaternion (X, Y, Z, W components).
   * Used for orientations/rotations in game files.
   */

  var BiowareVector4 = BiowareCommon.BiowareVector4 = (function() {
    function BiowareVector4(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    BiowareVector4.prototype._read = function() {
      this.x = this._io.readF4le();
      this.y = this._io.readF4le();
      this.z = this._io.readF4le();
      this.w = this._io.readF4le();
    }

    /**
     * X component
     */

    /**
     * Y component
     */

    /**
     * Z component
     */

    /**
     * W component
     */

    return BiowareVector4;
  })();

  var Substring = BiowareCommon.Substring = (function() {
    function Substring(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Substring.prototype._read = function() {
      this.substringId = this._io.readU4le();
      this.lenText = this._io.readU4le();
      this.text = KaitaiStream.bytesToStr(this._io.readBytes(this.lenText), "UTF-8");
    }

    /**
     * Gender as enum value
     */
    Object.defineProperty(Substring.prototype, 'gender', {
      get: function() {
        if (this._m_gender !== undefined)
          return this._m_gender;
        this._m_gender = this.genderRaw;
        return this._m_gender;
      }
    });

    /**
     * Raw gender ID (0..255).
     */
    Object.defineProperty(Substring.prototype, 'genderRaw', {
      get: function() {
        if (this._m_genderRaw !== undefined)
          return this._m_genderRaw;
        this._m_genderRaw = this.substringId & 255;
        return this._m_genderRaw;
      }
    });

    /**
     * Language as enum value
     */
    Object.defineProperty(Substring.prototype, 'language', {
      get: function() {
        if (this._m_language !== undefined)
          return this._m_language;
        this._m_language = this.languageRaw;
        return this._m_language;
      }
    });

    /**
     * Raw language ID (0..255).
     */
    Object.defineProperty(Substring.prototype, 'languageRaw', {
      get: function() {
        if (this._m_languageRaw !== undefined)
          return this._m_languageRaw;
        this._m_languageRaw = this.substringId >>> 8 & 255;
        return this._m_languageRaw;
      }
    });

    /**
     * Packed language+gender identifier:
     * - bits 0..7: gender
     * - bits 8..15: language
     */

    /**
     * Length of text in bytes.
     */

    /**
     * Substring text.
     */

    return Substring;
  })();

  return BiowareCommon;
})();
BiowareCommon_.BiowareCommon = BiowareCommon;
});
