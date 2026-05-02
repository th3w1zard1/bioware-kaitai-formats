-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_common")
local str_decode = require("string_decode")

-- 
-- **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
-- `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
-- 
-- xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
-- See also: xoreos-tools — shipped CLI inventory (no LIP-specific tool) (https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43)
-- See also: PyKotor wiki — LIP (https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip)
-- See also: PyKotor — `io_lip` (Kaitai + legacy read/write) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116)
-- See also: PyKotor — `LIPShape` enum (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/lip_data.py#L47-L127)
-- See also: reone — `LipReader::load` (https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L41)
-- See also: KotOR.js — `LIPObject.readBinary` (https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LIPObject.ts#L99-L118)
-- See also: NickHugi/Kotor.NET — `LIP` (https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorLIP/LIP.cs)
-- See also: xoreos — `kFileTypeLIP` (numeric id; no standalone `lipfile.cpp`) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L180)
-- See also: xoreos-docs — BioWare specs tree (no dedicated LIP Torlack/PDF; wire from PyKotor/reone) (https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware)
Lip = class.class(KaitaiStruct)

function Lip:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Lip:_read()
  self.file_type = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.file_version = str_decode.decode(self._io:read_bytes(4), "ASCII")
  self.length = self._io:read_f4le()
  self.num_keyframes = self._io:read_u4le()
  self.keyframes = {}
  for i = 0, self.num_keyframes - 1 do
    self.keyframes[i + 1] = Lip.KeyframeEntry(self._io, self, self._root)
  end
end

-- 
-- File type signature. Must be "LIP " (space-padded) for LIP files.
-- 
-- File format version. Must be "V1.0" for LIP files.
-- 
-- Duration in seconds. Must equal the paired WAV file playback time for
-- glitch-free animation. This is the total length of the lip sync animation.
-- 
-- Number of keyframes immediately following. Each keyframe contains a timestamp
-- and a viseme shape index. Keyframes should be sorted ascending by timestamp.
-- 
-- Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
-- Entries must be stored in chronological order (ascending by timestamp).

-- 
-- A single keyframe entry mapping a timestamp to a viseme (mouth shape).
-- Keyframes are used by the engine to interpolate between mouth shapes during
-- audio playback to create lip sync animation.
Lip.KeyframeEntry = class.class(KaitaiStruct)

function Lip.KeyframeEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Lip.KeyframeEntry:_read()
  self.timestamp = self._io:read_f4le()
  self.shape = BiowareCommon.BiowareLipVisemeId(self._io:read_u1())
end

-- 
-- Seconds from animation start. Must be >= 0 and <= length.
-- Keyframes should be sorted ascending by timestamp.
-- 
-- Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
-- `bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).

