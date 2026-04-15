# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_common'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
# tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).
# 
# **Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60 xoreos — `FileType` enum start (Aurora/BioWare family IDs; **PCC/Unreal packages are not in this table** — included only as canonical upstream anchor for “what this repo’s xoreos stack is”)
# @see https://github.com/ME3Tweaks/LegendaryExplorer/wiki/PCC-File-Format ME3Tweaks — PCC file format
# @see https://github.com/ME3Tweaks/LegendaryExplorer/wiki/Package-Handling ME3Tweaks — Package handling (export/import tables, UE3-era BioWare packages)
# @see https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/docs/XOREOS_FORMAT_COVERAGE.md In-tree — coverage matrix (PCC is out-of-xoreos Aurora scope; see table)
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (KotOR-era PDFs; PCC is Mass Effect / UE3 — use LegendaryExplorer wiki as wire authority)
class Pcc < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = FileHeader.new(@_io, self, @_root)
    self
  end
  class ExportEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @class_index = @_io.read_s4le
      @super_class_index = @_io.read_s4le
      @link = @_io.read_s4le
      @object_name_index = @_io.read_s4le
      @object_name_number = @_io.read_s4le
      @archetype_index = @_io.read_s4le
      @object_flags = @_io.read_u8le
      @data_size = @_io.read_u4le
      @data_offset = @_io.read_u4le
      @unknown1 = @_io.read_u4le
      @num_components = @_io.read_s4le
      @unknown2 = @_io.read_u4le
      @guid = Guid.new(@_io, self, @_root)
      if num_components > 0
        @components = []
        (num_components).times { |i|
          @components << @_io.read_s4le
        }
      end
      self
    end

    ##
    # Object index for the class.
    # Negative = import table index
    # Positive = export table index
    # Zero = no class
    attr_reader :class_index

    ##
    # Object index for the super class.
    # Negative = import table index
    # Positive = export table index
    # Zero = no super class
    attr_reader :super_class_index

    ##
    # Link to other objects (internal reference).
    attr_reader :link

    ##
    # Index into name table for the object name.
    attr_reader :object_name_index

    ##
    # Object name number (for duplicate names).
    attr_reader :object_name_number

    ##
    # Object index for the archetype.
    # Negative = import table index
    # Positive = export table index
    # Zero = no archetype
    attr_reader :archetype_index

    ##
    # Object flags bitfield (64-bit).
    attr_reader :object_flags

    ##
    # Size of the export data in bytes.
    attr_reader :data_size

    ##
    # Byte offset to the export data from the beginning of the file.
    attr_reader :data_offset

    ##
    # Unknown field.
    attr_reader :unknown1

    ##
    # Number of component entries (can be negative).
    attr_reader :num_components

    ##
    # Unknown field.
    attr_reader :unknown2

    ##
    # GUID for this export object.
    attr_reader :guid

    ##
    # Array of component indices.
    # Only present if num_components > 0.
    attr_reader :components
  end
  class ExportTable < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.export_count).times { |i|
        @entries << ExportEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of export entries.
    attr_reader :entries
  end
  class FileHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @magic = @_io.read_u4le
      raise Kaitai::Struct::ValidationNotEqualError.new(2653586369, @magic, @_io, "/types/file_header/seq/0") if not @magic == 2653586369
      @version = @_io.read_u4le
      @licensee_version = @_io.read_u4le
      @header_size = @_io.read_s4le
      @package_name = (@_io.read_bytes(10)).force_encoding("UTF-16LE").encode('UTF-8')
      @package_flags = @_io.read_u4le
      @package_type = Kaitai::Struct::Stream::resolve_enum(BiowareCommon::BIOWARE_PCC_PACKAGE_KIND, @_io.read_u4le)
      @name_count = @_io.read_u4le
      @name_table_offset = @_io.read_u4le
      @export_count = @_io.read_u4le
      @export_table_offset = @_io.read_u4le
      @import_count = @_io.read_u4le
      @import_table_offset = @_io.read_u4le
      @depend_offset = @_io.read_u4le
      @depend_count = @_io.read_u4le
      @guid_part1 = @_io.read_u4le
      @guid_part2 = @_io.read_u4le
      @guid_part3 = @_io.read_u4le
      @guid_part4 = @_io.read_u4le
      @generations = @_io.read_u4le
      @export_count_dup = @_io.read_u4le
      @name_count_dup = @_io.read_u4le
      @unknown1 = @_io.read_u4le
      @engine_version = @_io.read_u4le
      @cooker_version = @_io.read_u4le
      @compression_flags = @_io.read_u4le
      @package_source = @_io.read_u4le
      @compression_type = Kaitai::Struct::Stream::resolve_enum(BiowareCommon::BIOWARE_PCC_COMPRESSION_CODEC, @_io.read_u4le)
      @chunk_count = @_io.read_u4le
      self
    end

    ##
    # Magic number identifying PCC format. Must be 0x9E2A83C1.
    attr_reader :magic

    ##
    # File format version.
    # Encoded as: (major << 16) | (minor << 8) | patch
    # Example: 0xC202AC = 194/684 (major=194, minor=684)
    attr_reader :version

    ##
    # Licensee-specific version field (typically 0x67C).
    attr_reader :licensee_version

    ##
    # Header size field (typically -5 = 0xFFFFFFFB).
    attr_reader :header_size

    ##
    # Package name (typically "None" = 0x4E006F006E006500).
    attr_reader :package_name

    ##
    # Package flags bitfield.
    # Bit 25 (0x2000000): Compressed package
    # Bit 20 (0x100000): ME3Explorer edited format flag
    # Other bits: Various package attributes
    attr_reader :package_flags

    ##
    # Package type indicator (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_package_kind`
    # (LegendaryExplorer PCC wiki).
    attr_reader :package_type

    ##
    # Number of entries in the name table.
    attr_reader :name_count

    ##
    # Byte offset to the name table from the beginning of the file.
    attr_reader :name_table_offset

    ##
    # Number of entries in the export table.
    attr_reader :export_count

    ##
    # Byte offset to the export table from the beginning of the file.
    attr_reader :export_table_offset

    ##
    # Number of entries in the import table.
    attr_reader :import_count

    ##
    # Byte offset to the import table from the beginning of the file.
    attr_reader :import_table_offset

    ##
    # Offset to dependency table (typically 0x664).
    attr_reader :depend_offset

    ##
    # Number of dependencies (typically 0x67C).
    attr_reader :depend_count

    ##
    # First 32 bits of package GUID.
    attr_reader :guid_part1

    ##
    # Second 32 bits of package GUID.
    attr_reader :guid_part2

    ##
    # Third 32 bits of package GUID.
    attr_reader :guid_part3

    ##
    # Fourth 32 bits of package GUID.
    attr_reader :guid_part4

    ##
    # Number of generation entries.
    attr_reader :generations

    ##
    # Duplicate export count (should match export_count).
    attr_reader :export_count_dup

    ##
    # Duplicate name count (should match name_count).
    attr_reader :name_count_dup

    ##
    # Unknown field (typically 0x0).
    attr_reader :unknown1

    ##
    # Engine version (typically 0x18EF = 6383).
    attr_reader :engine_version

    ##
    # Cooker version (typically 0x3006B = 196715).
    attr_reader :cooker_version

    ##
    # Compression flags (typically 0x15330000).
    attr_reader :compression_flags

    ##
    # Package source identifier (typically 0x8AA0000).
    attr_reader :package_source

    ##
    # Compression codec when package is compressed (`u4`). Canonical: `formats/Common/bioware_common.ksy` → `bioware_pcc_compression_codec`
    # (LegendaryExplorer PCC wiki). Unused / undefined when uncompressed.
    attr_reader :compression_type

    ##
    # Number of compressed chunks (0 for uncompressed, 1 for compressed).
    # If > 0, file uses compressed structure with chunks.
    attr_reader :chunk_count
  end
  class Guid < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @part1 = @_io.read_u4le
      @part2 = @_io.read_u4le
      @part3 = @_io.read_u4le
      @part4 = @_io.read_u4le
      self
    end

    ##
    # First 32 bits of GUID.
    attr_reader :part1

    ##
    # Second 32 bits of GUID.
    attr_reader :part2

    ##
    # Third 32 bits of GUID.
    attr_reader :part3

    ##
    # Fourth 32 bits of GUID.
    attr_reader :part4
  end
  class ImportEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @package_name_index = @_io.read_s8le
      @class_name_index = @_io.read_s4le
      @link = @_io.read_s8le
      @import_name_index = @_io.read_s8le
      self
    end

    ##
    # Index into name table for package name.
    # Negative value indicates import from external package.
    # Positive value indicates import from this package.
    attr_reader :package_name_index

    ##
    # Index into name table for class name.
    attr_reader :class_name_index

    ##
    # Link to import/export table entry.
    # Used to resolve the actual object reference.
    attr_reader :link

    ##
    # Index into name table for the imported object name.
    attr_reader :import_name_index
  end
  class ImportTable < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.import_count).times { |i|
        @entries << ImportEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of import entries.
    attr_reader :entries
  end
  class NameEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @length = @_io.read_s4le
      @name = (@_io.read_bytes((length < 0 ? -(length) : length) * 2)).force_encoding("UTF-16LE").encode('UTF-8')
      self
    end

    ##
    # Absolute value of length for size calculation
    def abs_length
      return @abs_length unless @abs_length.nil?
      @abs_length = (length < 0 ? -(length) : length)
      @abs_length
    end

    ##
    # Size of name string in bytes (absolute length * 2 bytes per WCHAR)
    def name_size
      return @name_size unless @name_size.nil?
      @name_size = abs_length * 2
      @name_size
    end

    ##
    # Length of the name string in characters (signed).
    # Negative value indicates the number of WCHAR characters.
    # Positive value is also valid but less common.
    attr_reader :length

    ##
    # Name string encoded as UTF-16LE (WCHAR).
    # Size is absolute value of length * 2 bytes per character.
    # Negative length indicates WCHAR count (use absolute value).
    attr_reader :name
  end
  class NameTable < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.name_count).times { |i|
        @entries << NameEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of name entries.
    attr_reader :entries
  end

  ##
  # Compression algorithm used (0=None, 1=Zlib, 2=LZO).
  def compression_type
    return @compression_type unless @compression_type.nil?
    @compression_type = header.compression_type
    @compression_type
  end

  ##
  # Table containing all objects exported from this package.
  def export_table
    return @export_table unless @export_table.nil?
    if header.export_count > 0
      _pos = @_io.pos
      @_io.seek(header.export_table_offset)
      @export_table = ExportTable.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @export_table
  end

  ##
  # Table containing references to external packages and classes.
  def import_table
    return @import_table unless @import_table.nil?
    if header.import_count > 0
      _pos = @_io.pos
      @_io.seek(header.import_table_offset)
      @import_table = ImportTable.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @import_table
  end

  ##
  # True if package uses compressed chunks (bit 25 of package_flags).
  def is_compressed
    return @is_compressed unless @is_compressed.nil?
    @is_compressed = header.package_flags & 33554432 != 0
    @is_compressed
  end

  ##
  # Table containing all string names used in the package.
  def name_table
    return @name_table unless @name_table.nil?
    if header.name_count > 0
      _pos = @_io.pos
      @_io.seek(header.name_table_offset)
      @name_table = NameTable.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @name_table
  end

  ##
  # File header containing format metadata and table offsets.
  attr_reader :header
end
