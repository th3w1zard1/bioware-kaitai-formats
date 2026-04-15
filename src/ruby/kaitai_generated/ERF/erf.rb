# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_type_ids'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
# texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
# ERF files store both resource names (ResRefs) and data in the same file. They also support
# localized strings for descriptions in multiple languages.
# 
# Format Variants:
# - ERF: Generic encapsulated resource file (texture packs, etc.)
# - HAK: Hak pak file (contains override resources). Used for mod content distribution
# - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
# - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`
# 
# All variants use the same binary format structure, differing only in the file type signature.
# 
# Archive `resource_type` values use the shared **`bioware_type_ids::xoreos_file_type_id`** enum (xoreos `FileType`); see `formats/Common/bioware_type_ids.ksy`.
# 
# Binary Format Structure:
# - Header (160 bytes): File type, version, entry counts, offsets, build date, description
# - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
#   include localized module names for the load screen. Each entry contains language_id (u4),
#   string_size (u4), and string_data (UTF-8 encoded text)
# - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
#   - resref (16 bytes, ASCII, null-padded): Resource filename
#   - resource_id (u4): Index into resource_list
#   - resource_type (u2): Resource type identifier (`bioware_type_ids::xoreos_file_type_id`, xoreos `FileType`)
#   - unused (u2): Padding/unused field (typically 0)
# - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
#   - offset_to_data (u4): Byte offset to resource data from beginning of file
#   - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
# - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
#   in resource_list
# 
# File Access Pattern:
# 1. Read header to get entry_count and offsets
# 2. Read key_list to map ResRefs to resource_ids
# 3. Use resource_id to index into resource_list
# 4. Read resource data from offset_to_data with byte length len_data
# 
# Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_erf` / `erf_data`, xoreos `ERFFile`, xoreos-tools `unerf` / `erf`, reone `ErfReader`, KotOR.js `ERFObject`, NickHugi `Kotor.NET/Formats/KotorERF`).
# @see https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf PyKotor wiki — ERF
# @see https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf PyKotor wiki — Aurora ERF notes
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py#L22-L316 PyKotor — `io_erf` (Kaitai + legacy + `ERFBinaryWriter.write`)
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L130 PyKotor — `ERFType` + `ERF` model (opening)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L50-L335 xoreos — ERF type tags + `ERFFile::load` + `readV10Header` start
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/unerf.cpp#L69-L106 xoreos-tools — `unerf` CLI (`main`)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/erf.cpp#L49-L96 xoreos-tools — `erf` packer CLI (`main`)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html xoreos-docs — Torlack mod.html
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/erfreader.cpp#L26-L92 reone — `ErfReader`
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/ERFObject.ts#L70-L115 KotOR.js — `ERFObject`
# @see https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorERF/ERFBinaryStructure.cs NickHugi/Kotor.NET — `ERFBinaryStructure`
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/ERF_Format.pdf xoreos-docs — ERF_Format.pdf
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394 xoreos — `enum FileType` (numeric IDs in KEY/ERF/RIM tables)
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py PyKotor — `ResourceType` (tooling superset; overlaps FileType for KotOR rows)
class Erf < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = ErfHeader.new(@_io, self, @_root)
    self
  end
  class ErfHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotAnyOfError.new(@file_type, @_io, "/types/erf_header/seq/0") if not  ((@file_type == "ERF ") || (@file_type == "MOD ") || (@file_type == "SAV ") || (@file_type == "HAK ")) 
      @file_version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotEqualError.new("V1.0", @file_version, @_io, "/types/erf_header/seq/1") if not @file_version == "V1.0"
      @language_count = @_io.read_u4le
      @localized_string_size = @_io.read_u4le
      @entry_count = @_io.read_u4le
      @offset_to_localized_string_list = @_io.read_u4le
      @offset_to_key_list = @_io.read_u4le
      @offset_to_resource_list = @_io.read_u4le
      @build_year = @_io.read_u4le
      @build_day = @_io.read_u4le
      @description_strref = @_io.read_s4le
      @reserved = @_io.read_bytes(116)
      self
    end

    ##
    # Heuristic to detect save game files.
    # Save games use MOD signature but typically have description_strref = 0.
    def is_save_file
      return @is_save_file unless @is_save_file.nil?
      @is_save_file =  ((file_type == "MOD ") && (description_strref == 0)) 
      @is_save_file
    end

    ##
    # File type signature. Must be one of:
    # - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
    # - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
    # - "SAV " (0x53 0x41 0x56 0x20) - Save game file
    # - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
    attr_reader :file_type

    ##
    # File format version. Always "V1.0" for KotOR ERF files.
    # Other versions may exist in Neverwinter Nights but are not supported in KotOR.
    attr_reader :file_version

    ##
    # Number of localized string entries. Typically 0 for most ERF files.
    # MOD files may include localized module names for the load screen.
    attr_reader :language_count

    ##
    # Total size of localized string data in bytes.
    # Includes all language entries (language_id + string_size + string_data for each).
    attr_reader :localized_string_size

    ##
    # Number of resources in the archive. This determines:
    # - Number of entries in key_list
    # - Number of entries in resource_list
    # - Number of resource data blocks stored at various offsets
    attr_reader :entry_count

    ##
    # Byte offset to the localized string list from the beginning of the file.
    # Typically 160 (right after header) if present, or 0 if not present.
    attr_reader :offset_to_localized_string_list

    ##
    # Byte offset to the key list from the beginning of the file.
    # Typically 160 (right after header) if no localized strings, or after localized strings.
    attr_reader :offset_to_key_list

    ##
    # Byte offset to the resource list from the beginning of the file.
    # Located after the key list.
    attr_reader :offset_to_resource_list

    ##
    # Build year (years since 1900).
    # Example: 103 = year 2003
    # Primarily informational, used by development tools to track module versions.
    attr_reader :build_year

    ##
    # Build day (days since January 1, with January 1 = day 1).
    # Example: 247 = September 4th (the 247th day of the year)
    # Primarily informational, used by development tools to track module versions.
    attr_reader :build_day

    ##
    # Description StrRef (TLK string reference) for the archive description.
    # Values vary by file type:
    # - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
    # - SAV files: 0 (typically no description)
    # - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)
    attr_reader :description_strref

    ##
    # Reserved padding (usually zeros).
    # Total header size is 160 bytes:
    # file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
    # entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
    # offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
    # reserved (116) = 160 bytes
    attr_reader :reserved
  end
  class KeyEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @resref = (@_io.read_bytes(16)).force_encoding("ASCII").encode('UTF-8')
      @resource_id = @_io.read_u4le
      @resource_type = Kaitai::Struct::Stream::resolve_enum(BiowareTypeIds::XOREOS_FILE_TYPE_ID, @_io.read_u2le)
      @unused = @_io.read_u2le
      self
    end

    ##
    # Resource filename (ResRef), null-padded to 16 bytes.
    # Maximum 16 characters. If exactly 16 characters, no null terminator exists.
    # Resource names can be mixed case, though most are lowercase in practice.
    attr_reader :resref

    ##
    # Resource ID (index into resource_list).
    # Maps this key entry to the corresponding resource entry.
    attr_reader :resource_id

    ##
    # Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
    # Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
    attr_reader :resource_type

    ##
    # Padding/unused field (typically 0)
    attr_reader :unused
  end
  class KeyList < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.entry_count).times { |i|
        @entries << KeyEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of key entries mapping ResRefs to resource indices
    attr_reader :entries
  end
  class LocalizedStringEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @language_id = @_io.read_u4le
      @string_size = @_io.read_u4le
      @string_data = (@_io.read_bytes(string_size)).force_encoding("UTF-8")
      self
    end

    ##
    # Language identifier:
    # - 0 = English
    # - 1 = French
    # - 2 = German
    # - 3 = Italian
    # - 4 = Spanish
    # - 5 = Polish
    # - Additional languages for Asian releases
    attr_reader :language_id

    ##
    # Length of string data in bytes
    attr_reader :string_size

    ##
    # UTF-8 encoded text string
    attr_reader :string_data
  end
  class LocalizedStringList < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.language_count).times { |i|
        @entries << LocalizedStringEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of localized string entries, one per language
    attr_reader :entries
  end
  class ResourceEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @offset_to_data = @_io.read_u4le
      @len_data = @_io.read_u4le
      self
    end

    ##
    # Raw binary data for this resource
    def data
      return @data unless @data.nil?
      _pos = @_io.pos
      @_io.seek(offset_to_data)
      @data = @_io.read_bytes(len_data)
      @_io.seek(_pos)
      @data
    end

    ##
    # Byte offset to resource data from the beginning of the file.
    # Points to the actual binary data for this resource.
    attr_reader :offset_to_data

    ##
    # Size of resource data in bytes.
    # Uncompressed size of the resource.
    attr_reader :len_data
  end
  class ResourceList < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.header.entry_count).times { |i|
        @entries << ResourceEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of resource entries containing offset and size information
    attr_reader :entries
  end

  ##
  # Array of key entries mapping ResRefs to resource indices
  def key_list
    return @key_list unless @key_list.nil?
    _pos = @_io.pos
    @_io.seek(header.offset_to_key_list)
    @key_list = KeyList.new(@_io, self, @_root)
    @_io.seek(_pos)
    @key_list
  end

  ##
  # Optional localized string entries for multi-language descriptions
  def localized_string_list
    return @localized_string_list unless @localized_string_list.nil?
    if header.language_count > 0
      _pos = @_io.pos
      @_io.seek(header.offset_to_localized_string_list)
      @localized_string_list = LocalizedStringList.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @localized_string_list
  end

  ##
  # Array of resource entries containing offset and size information
  def resource_list
    return @resource_list unless @resource_list.nil?
    _pos = @_io.pos
    @_io.seek(header.offset_to_resource_list)
    @resource_list = ResourceList.new(@_io, self, @_root)
    @_io.seek(_pos)
    @resource_list
  end

  ##
  # ERF file header (160 bytes)
  attr_reader :header
end
