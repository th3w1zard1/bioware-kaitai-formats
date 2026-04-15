-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local enum = require("enum")
local str_decode = require("string_decode")

-- 
-- Shared enums and "common objects" used across the BioWare ecosystem that also appear
-- in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).
-- 
-- This file is intended to be imported by other `.ksy` files to avoid repeating:
-- - Language IDs (used in TLK headers and GFF LocalizedString substrings)
-- - Gender IDs (used in GFF LocalizedString substrings)
-- - The CExoLocString / LocalizedString binary layout
-- 
-- References:
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py
-- - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h
-- - https://github.com/seedhartha/reone/blob/master/include/reone/resource/types.h
BiowareCommon = class.class(KaitaiStruct)

BiowareCommon.BiowareDdsVariantBytesPerPixel = enum.Enum {
  dxt1 = 3,
  dxt5 = 4,
}

BiowareCommon.BiowareEquipmentSlotFlag = enum.Enum {
  invalid = 0,
  head = 1,
  armor = 2,
  gauntlet = 8,
  right_hand = 16,
  left_hand = 32,
  right_arm = 128,
  left_arm = 256,
  implant = 512,
  belt = 1024,
  claw1 = 16384,
  claw2 = 32768,
  claw3 = 65536,
  hide = 131072,
  right_hand_2 = 262144,
  left_hand_2 = 524288,
}

BiowareCommon.BiowareGameId = enum.Enum {
  k1 = 1,
  k2 = 2,
  k1_xbox = 3,
  k2_xbox = 4,
  k1_ios = 5,
  k2_ios = 6,
  k1_android = 7,
  k2_android = 8,
}

BiowareCommon.BiowareGenderId = enum.Enum {
  male = 0,
  female = 1,
}

BiowareCommon.BiowareLanguageId = enum.Enum {
  english = 0,
  french = 1,
  german = 2,
  italian = 3,
  spanish = 4,
  polish = 5,
  afrikaans = 6,
  basque = 7,
  breton = 9,
  catalan = 10,
  chamorro = 11,
  chichewa = 12,
  corsican = 13,
  danish = 14,
  dutch = 15,
  faroese = 16,
  filipino = 18,
  finnish = 19,
  flemish = 20,
  frisian = 21,
  galician = 22,
  ganda = 23,
  haitian_creole = 24,
  hausa_latin = 25,
  hawaiian = 26,
  icelandic = 27,
  ido = 28,
  indonesian = 29,
  igbo = 30,
  irish = 31,
  interlingua = 32,
  javanese_latin = 33,
  latin = 34,
  luxembourgish = 35,
  maltese = 36,
  norwegian = 37,
  occitan = 38,
  portuguese = 39,
  scots = 40,
  scottish_gaelic = 41,
  shona = 42,
  soto = 43,
  sundanese_latin = 44,
  swahili = 45,
  swedish = 46,
  tagalog = 47,
  tahitian = 48,
  tongan = 49,
  uzbek_latin = 50,
  walloon = 51,
  xhosa = 52,
  yoruba = 53,
  welsh = 54,
  zulu = 55,
  bulgarian = 58,
  belarisian = 59,
  macedonian = 60,
  russian = 61,
  serbian_cyrillic = 62,
  tajik = 63,
  tatar_cyrillic = 64,
  ukrainian = 66,
  uzbek = 67,
  albanian = 68,
  bosnian_latin = 69,
  czech = 70,
  slovak = 71,
  slovene = 72,
  croatian = 73,
  hungarian = 75,
  romanian = 76,
  greek = 77,
  esperanto = 78,
  azerbaijani_latin = 79,
  turkish = 81,
  turkmen_latin = 82,
  hebrew = 83,
  arabic = 84,
  estonian = 85,
  latvian = 86,
  lithuanian = 87,
  vietnamese = 88,
  thai = 89,
  aymara = 90,
  kinyarwanda = 91,
  kurdish_latin = 92,
  malagasy = 93,
  malay_latin = 94,
  maori = 95,
  moldovan_latin = 96,
  samoan = 97,
  somali = 98,
  korean = 128,
  chinese_traditional = 129,
  chinese_simplified = 130,
  japanese = 131,
  unknown = 2147483646,
}

BiowareCommon.BiowareLipVisemeId = enum.Enum {
  neutral = 0,
  ee = 1,
  eh = 2,
  ah = 3,
  oh = 4,
  ooh = 5,
  y = 6,
  sts = 7,
  fv = 8,
  ng = 9,
  th = 10,
  mpb = 11,
  td = 12,
  sh = 13,
  l = 14,
  kg = 15,
}

BiowareCommon.BiowareLtrAlphabetLength = enum.Enum {
  neverwinter_nights = 26,
  kotor = 28,
}

BiowareCommon.BiowareObjectTypeId = enum.Enum {
  invalid = 0,
  creature = 1,
  door = 2,
  item = 3,
  trigger = 4,
  placeable = 5,
  waypoint = 6,
  encounter = 7,
  store = 8,
  area = 9,
  sound = 10,
  camera = 11,
}

BiowareCommon.BiowarePccCompressionCodec = enum.Enum {
  none = 0,
  zlib = 1,
  lzo = 2,
}

BiowareCommon.BiowarePccPackageKind = enum.Enum {
  normal_package = 0,
  patch_package = 1,
}

BiowareCommon.BiowareTpcPixelFormatId = enum.Enum {
  greyscale = 1,
  rgb_or_dxt1 = 2,
  rgba_or_dxt5 = 4,
  bgra_xbox_swizzle = 12,
}

BiowareCommon.RiffWaveFormatTag = enum.Enum {
  pcm = 1,
  adpcm_ms = 2,
  ieee_float = 3,
  alaw = 6,
  mulaw = 7,
  dvi_ima_adpcm = 17,
  mpeg_layer3 = 85,
  wave_format_extensible = 65534,
}

function BiowareCommon:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function BiowareCommon:_read()
end


-- 
-- Variable-length binary data with 4-byte length prefix.
-- Used for Void/Binary fields in GFF files.
BiowareCommon.BiowareBinaryData = class.class(KaitaiStruct)

function BiowareCommon.BiowareBinaryData:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareCommon.BiowareBinaryData:_read()
  self.len_value = self._io:read_u4le()
  self.value = self._io:read_bytes(self.len_value)
end

-- 
-- Length of binary data in bytes.
-- 
-- Binary data.

-- 
-- BioWare CExoString - variable-length string with 4-byte length prefix.
-- Used for string fields in GFF files.
BiowareCommon.BiowareCexoString = class.class(KaitaiStruct)

function BiowareCommon.BiowareCexoString:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareCommon.BiowareCexoString:_read()
  self.len_string = self._io:read_u4le()
  self.value = str_decode.decode(self._io:read_bytes(self.len_string), "UTF-8")
end

-- 
-- Length of string in bytes.
-- 
-- String data (UTF-8).

-- 
-- BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
-- section for field type "LocalizedString".
BiowareCommon.BiowareLocstring = class.class(KaitaiStruct)

function BiowareCommon.BiowareLocstring:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareCommon.BiowareLocstring:_read()
  self.total_size = self._io:read_u4le()
  self.string_ref = self._io:read_u4le()
  self.num_substrings = self._io:read_u4le()
  self.substrings = {}
  for i = 0, self.num_substrings - 1 do
    self.substrings[i + 1] = BiowareCommon.Substring(self._io, self, self._root)
  end
end

-- 
-- True if this locstring references dialog.tlk.
BiowareCommon.BiowareLocstring.property.has_strref = {}
function BiowareCommon.BiowareLocstring.property.has_strref:get()
  if self._m_has_strref ~= nil then
    return self._m_has_strref
  end

  self._m_has_strref = self.string_ref ~= 4294967295
  return self._m_has_strref
end

-- 
-- Total size of the structure in bytes (excluding this field).
-- 
-- StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).
-- 
-- Number of substring entries that follow.
-- 
-- Language/gender-specific substring entries.

-- 
-- BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
-- Used throughout GFF files to reference game resources by name.
BiowareCommon.BiowareResref = class.class(KaitaiStruct)

function BiowareCommon.BiowareResref:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareCommon.BiowareResref:_read()
  self.len_resref = self._io:read_u1()
  if not(self.len_resref <= 16) then
    error("ValidationGreaterThanError")
  end
  self.value = str_decode.decode(self._io:read_bytes(self.len_resref), "ASCII")
end

-- 
-- Length of ResRef string (0-16 characters).
-- 
-- ResRef string data (ASCII, lowercase recommended).

-- 
-- 3D vector (X, Y, Z coordinates).
-- Used for positions, directions, etc. in game files.
BiowareCommon.BiowareVector3 = class.class(KaitaiStruct)

function BiowareCommon.BiowareVector3:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareCommon.BiowareVector3:_read()
  self.x = self._io:read_f4le()
  self.y = self._io:read_f4le()
  self.z = self._io:read_f4le()
end

-- 
-- X coordinate.
-- 
-- Y coordinate.
-- 
-- Z coordinate.

-- 
-- 4D vector / Quaternion (X, Y, Z, W components).
-- Used for orientations/rotations in game files.
BiowareCommon.BiowareVector4 = class.class(KaitaiStruct)

function BiowareCommon.BiowareVector4:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareCommon.BiowareVector4:_read()
  self.x = self._io:read_f4le()
  self.y = self._io:read_f4le()
  self.z = self._io:read_f4le()
  self.w = self._io:read_f4le()
end

-- 
-- X component.
-- 
-- Y component.
-- 
-- Z component.
-- 
-- W component.

BiowareCommon.Substring = class.class(KaitaiStruct)

function BiowareCommon.Substring:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function BiowareCommon.Substring:_read()
  self.substring_id = self._io:read_u4le()
  self.len_text = self._io:read_u4le()
  self.text = str_decode.decode(self._io:read_bytes(self.len_text), "UTF-8")
end

-- 
-- Gender as enum value.
BiowareCommon.Substring.property.gender = {}
function BiowareCommon.Substring.property.gender:get()
  if self._m_gender ~= nil then
    return self._m_gender
  end

  self._m_gender = BiowareCommon.BiowareGenderId(self.gender_raw)
  return self._m_gender
end

-- 
-- Raw gender ID (0..255).
BiowareCommon.Substring.property.gender_raw = {}
function BiowareCommon.Substring.property.gender_raw:get()
  if self._m_gender_raw ~= nil then
    return self._m_gender_raw
  end

  self._m_gender_raw = self.substring_id & 255
  return self._m_gender_raw
end

-- 
-- Language as enum value.
BiowareCommon.Substring.property.language = {}
function BiowareCommon.Substring.property.language:get()
  if self._m_language ~= nil then
    return self._m_language
  end

  self._m_language = BiowareCommon.BiowareLanguageId(self.language_raw)
  return self._m_language
end

-- 
-- Raw language ID (0..255).
BiowareCommon.Substring.property.language_raw = {}
function BiowareCommon.Substring.property.language_raw:get()
  if self._m_language_raw ~= nil then
    return self._m_language_raw
  end

  self._m_language_raw = self.substring_id >> 8 & 255
  return self._m_language_raw
end

-- 
-- Packed language+gender identifier:
-- - bits 0..7: gender
-- - bits 8..15: language
-- 
-- Length of text in bytes.
-- 
-- Substring text.

