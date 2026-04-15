# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# Shared enums and small helper types used by TSLPatcher-style tooling.
# 
# Notes:
# - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
#   so string-valued enums are modeled here as small string wrapper types with `valid` constraints.
# 
# References:
# - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
# - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
# - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
# - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py
class BiowareTslpatcherCommon < Kaitai::Struct::Struct

  BIOWARE_TSLPATCHER_LOG_TYPE_ID = {
    0 => :bioware_tslpatcher_log_type_id_verbose,
    1 => :bioware_tslpatcher_log_type_id_note,
    2 => :bioware_tslpatcher_log_type_id_warning,
    3 => :bioware_tslpatcher_log_type_id_error,
  }
  I__BIOWARE_TSLPATCHER_LOG_TYPE_ID = BIOWARE_TSLPATCHER_LOG_TYPE_ID.invert

  BIOWARE_TSLPATCHER_TARGET_TYPE_ID = {
    0 => :bioware_tslpatcher_target_type_id_row_index,
    1 => :bioware_tslpatcher_target_type_id_row_label,
    2 => :bioware_tslpatcher_target_type_id_label_column,
  }
  I__BIOWARE_TSLPATCHER_TARGET_TYPE_ID = BIOWARE_TSLPATCHER_TARGET_TYPE_ID.invert
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    self
  end

  ##
  # String-valued enum equivalent for DiffFormat (null-terminated ASCII).
  class BiowareDiffFormatStr < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @value = (@_io.read_bytes_term(0, false, true, true)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotAnyOfError.new(@value, @_io, "/types/bioware_diff_format_str/seq/0") if not  ((@value == "default") || (@value == "unified") || (@value == "context") || (@value == "side_by_side")) 
      self
    end
    attr_reader :value
  end

  ##
  # String-valued enum equivalent for DiffResourceType (null-terminated ASCII).
  class BiowareDiffResourceTypeStr < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @value = (@_io.read_bytes_term(0, false, true, true)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotAnyOfError.new(@value, @_io, "/types/bioware_diff_resource_type_str/seq/0") if not  ((@value == "gff") || (@value == "2da") || (@value == "tlk") || (@value == "lip") || (@value == "bytes")) 
      self
    end
    attr_reader :value
  end

  ##
  # String-valued enum equivalent for DiffType (null-terminated ASCII).
  class BiowareDiffTypeStr < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @value = (@_io.read_bytes_term(0, false, true, true)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotAnyOfError.new(@value, @_io, "/types/bioware_diff_type_str/seq/0") if not  ((@value == "identical") || (@value == "modified") || (@value == "added") || (@value == "removed") || (@value == "error")) 
      self
    end
    attr_reader :value
  end

  ##
  # String-valued enum equivalent for NCSTokenType (null-terminated ASCII).
  class BiowareNcsTokenTypeStr < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @value = (@_io.read_bytes_term(0, false, true, true)).force_encoding("ASCII").encode('UTF-8')
      raise Kaitai::Struct::ValidationNotAnyOfError.new(@value, @_io, "/types/bioware_ncs_token_type_str/seq/0") if not  ((@value == "strref") || (@value == "strref32") || (@value == "2damemory") || (@value == "2damemory32") || (@value == "uint32") || (@value == "uint16") || (@value == "uint8")) 
      self
    end
    attr_reader :value
  end
end
