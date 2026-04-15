-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- TXI (Texture Info) files are compact ASCII descriptors that attach metadata to TPC textures.
-- They control mipmap usage, filtering, flipbook animation, environment mapping, font atlases,
-- and platform-specific downsampling. Every TXI file is parsed at runtime to configure how
-- a TPC image is rendered.
-- 
-- Format Structure:
-- - Line-based ASCII text file (UTF-8 or Windows-1252)
-- - Commands are case-insensitive but conventionally lowercase
-- - Empty TXI files (0 bytes) are valid and use default settings
-- - A TXI can be embedded at the end of a .tpc file or exist as a separate .txi file
-- 
-- Command Formats (from PyKotor implementation):
-- 1. Simple commands: "command value" (e.g., "mipmap 0", "blending additive")
-- 2. Multi-value commands: "command v1 v2 v3" (e.g., "channelscale 1.0 0.5 0.5")
-- 3. Coordinate commands: "command count" followed by count coordinate lines
--    Coordinate format: "x y z" (normalized floats + int, typically z=0)
-- 
-- Parsing Behavior (matches PyKotor TXIReaderMode):
-- - Lines parsed sequentially, whitespace stripped
-- - Empty lines ignored
-- - Commands recognized by uppercase comparison against TXICommand enum
-- - Invalid commands logged but don't stop parsing
-- - Coordinate commands switch parser to coordinate mode until count reached
-- - Commands can interrupt coordinate parsing
-- 
-- All Supported Commands (from TXICommand enum in txi_data.py):
-- - alphamean, arturoheight, arturowidth, baselineheight, blending, bumpmapscaling, bumpmaptexture
-- - bumpyshinytexture, candownsample, caretindent, channelscale, channeltranslate, clamp, codepage
-- - cols, compresstexture, controllerscript, cube, decal, defaultbpp, defaultheight, defaultwidth
-- - distort, distortangle, distortionamplitude, downsamplefactor, downsamplemax, downsamplemin
-- - envmaptexture, filerange, filter, fontheight, fontwidth, fps, isbumpmap, isdiffusebumpmap
-- - islightmap, isspecularbumpmap, lowerrightcoords, maxsizehq, maxsizelq, minsizehq, minsizelq
-- - mipmap, numchars, numcharspersheet, numx, numy, ondemand, priority, proceduretype, rows
-- - spacingb, spacingr, speed, temporary, texturewidth, unique, upperleftcoords, wateralpha
-- - waterheight, waterwidth, xbox_downsample
-- 
-- References:
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/io_txi.py - Complete parser
-- - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py - Data structures
-- - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi - Format documentation
-- - https://github.com/seedhartha/reone/blob/master/src/libs/graphics/format/txireader.cpp - C++ reference implementation
Txi = class.class(KaitaiStruct)

function Txi:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Txi:_read()
  self.content = str_decode.decode(self._io:read_bytes_full(), "ASCII")
end

-- 
-- Complete TXI file content as raw ASCII text.
-- The PyKotor parser processes this line-by-line with special handling for:
-- - Coordinate commands (upperleftcoords, lowerrightcoords) followed by coordinate data
-- - Multi-value commands (channelscale, channeltranslate, filerange)
-- - Boolean/numeric/string single-value commands
-- - Empty files (valid, indicates default settings)

