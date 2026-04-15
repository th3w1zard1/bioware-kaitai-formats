# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_type_ids'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# RIM (Resource Information Manager) files are self-contained archives used for module templates.
# RIM files are similar to ERF files but are read-only from the game's perspective. The game
# loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
# RIM files store all resources inline with metadata, making them self-contained archives.
# 
# Format Variants:
# - Standard RIM: Basic module template files
# - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
# 
# Binary Format (KotOR / PyKotor):
# - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
# - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
# - Key / resource entry table (32 bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
# - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
# 
# Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.
# @see https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim PyKotor wiki — RIM
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128 PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L35-L91 xoreos — `RIMFile::load` + `readResList`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/unrim.cpp#L55-L85 xoreos-tools — `unrim` CLI (`main`)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/rim.cpp#L43-L84 xoreos-tools — `rim` packer CLI (`main`)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html xoreos-docs — Torlack mod.html (MOD/RIM family)
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/RIMObject.ts#L69-L93 KotOR.js — `RIMObject`
# @see https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs NickHugi/Kotor.NET — `RIMBinaryStructure`
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/rimreader.cpp#L26-L58 reone — `RimReader`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394 xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables)
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py PyKotor — `ResourceType` (tooling superset)
class Rim < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = RimHeader.new(@_io, self, @_root)
    if header.offset_to_resource_table == 0
      @gap_before_key_table_implicit = @_io.read_bytes(96)
    end
    if header.offset_to_resource_table != 0
      @gap_before_key_table_explicit = @_io.read_bytes(header.offset_to_resource_table - 24)
    end
    if header.resource_count > 0
      @resource_entry_table = ResourceEntryTable.new(@_io, self, @_root)
    end
    self
  end
  class ResourceEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @resref = (@_io.read_bytes(16)).force_encoding("ASCII").encode('UTF-8')
      @resource_type = Kaitai::Struct::Stream::resolve_enum(BiowareTypeIds::XOREOS_FILE_TYPE_ID, @_io.read_u4le)
      @resource_id = @_io.read_u4le
      @offset_to_data = @_io.read_u4le
      @num_data = @_io.read_u4le
      self
    end

    ##
    # Raw binary data for this resource (read at specified offset)
    def data
      return @data unless @data.nil?
      _pos = @_io.pos
      @_io.seek(offset_to_data)
      @data = []
      (num_data).times { |i|
        @data << @_io.read_u1
      }
      @_io.seek(_pos)
      @data
    end

    ##
    # Resource filename (ResRef), null-padded to 16 bytes.
    # Maximum 16 characters. If exactly 16 characters, no null terminator exists.
    # Resource names can be mixed case, though most are lowercase in practice.
    # The game engine typically lowercases ResRefs when loading.
    attr_reader :resref

    ##
    # Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
    # Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
    attr_reader :resource_type

    ##
    # Resource ID (index, usually sequential).
    # Typically matches the index of this entry in the resource_entry_table.
    # Used for internal reference, but not critical for parsing.
    attr_reader :resource_id

    ##
    # Byte offset to resource data from the beginning of the file.
    # Points to the actual binary data for this resource in resource_data_section.
    attr_reader :offset_to_data

    ##
    # Size of resource data in bytes (repeat count for raw `data` bytes).
    # Uncompressed size of the resource.
    attr_reader :num_data
  end
  class ResourceEntryTable < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.resource_count).times { |i|
        @entries << ResourceEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of resource entries, one per resource in the archive
    attr_reader :entries
  end
  class RimHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotEqualError.new("RIM ", @file_type, @_io, "/types/rim_header/seq/0") if not @file_type == "RIM "
      @file_version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotEqualError.new("V1.0", @file_version, @_io, "/types/rim_header/seq/1") if not @file_version == "V1.0"
      @reserved = @_io.read_u4le
      @resource_count = @_io.read_u4le
      @offset_to_resource_table = @_io.read_u4le
      @offset_to_resources = @_io.read_u4le
      self
    end

    ##
    # Whether the RIM file contains any resources
    def has_resources
      return @has_resources unless @has_resources.nil?
      @has_resources = resource_count > 0
      @has_resources
    end

    ##
    # File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
    # This identifies the file as a RIM archive.
    attr_reader :file_type

    ##
    # File format version. Always "V1.0" for KotOR RIM files.
    # Other versions may exist in Neverwinter Nights but are not supported in KotOR.
    attr_reader :file_version

    ##
    # Reserved field (typically 0x00000000).
    # Unknown purpose, but always set to 0 in practice.
    attr_reader :reserved

    ##
    # Number of resources in the archive. This determines:
    # - Number of entries in resource_entry_table
    # - Number of resources in resource_data_section
    attr_reader :resource_count

    ##
    # Byte offset to the key / resource entry table from the beginning of the file.
    # 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
    # When non-zero, this offset is used directly (commonly 120).
    attr_reader :offset_to_resource_table

    ##
    # Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
    # taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
    attr_reader :offset_to_resources
  end

  ##
  # RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
  attr_reader :header

  ##
  # When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
  # After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
  attr_reader :gap_before_key_table_implicit

  ##
  # When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
  # Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
  attr_reader :gap_before_key_table_explicit

  ##
  # Array of resource entries mapping ResRefs to resource data
  attr_reader :resource_entry_table
end
