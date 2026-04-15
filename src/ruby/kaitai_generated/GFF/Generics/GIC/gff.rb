# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_common'
require_relative 'bioware_gff_common'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# BioWare **GFF** (Generic File Format): hierarchical binary game data (KotOR/TSL and Aurora lineage; GFF4 for
# DA / Eclipse-class payloads in this `.ksy`). Human-readable tables and tutorials: PyKotor wiki (**Further
# reading**). Wire `gff_field_type` enum: `formats/Common/bioware_gff_common.ksy`.
# 
# **Aurora prefix (8 bytes):** `u4be` FourCC + `u4be` version (`AuroraFile::readHeader` — `meta.xref`
# `xoreos_aurorafile_read_header`).
# **GFF3:** Twelve LE `u32` counts/offsets as `gff_header_tail` under `gff3_after_aurora`, then lazy arena
# `instances`.
# **GFF4:** When version is `V4.0` / `V4.1`, the next field is `platform_id` (`u4be`), not GFF3 `struct_offset`
# (`gff4_after_aurora`; partial GFF4 graph — `tail` blob still opaque).
# 
# **GFF3 wire summary:**
# - Root `file` → `gff_union_file`; arenas addressed via `gff3.header` offsets.
# - 12-byte struct rows (`struct_entry`), 12-byte field rows (`field_entry`); root struct index **0**; single-field
#   vs multi-field vs lists per wiki *Struct array* / *Field indices* / *List indices*.
# 
# **Ghidra / VMA:** engine record names and addresses live on the `seq` / `types` nodes they justify, not in this blurb.
# 
# **Pinned URLs and tool history:** `meta.xref` (alphabetical keys). Coverage matrix: `docs/XOREOS_FORMAT_COVERAGE.md`.
# @see https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF binary format
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — GFF3File::Header::read
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181 xoreos — GFF3File load (post-header struct/field arena wiring)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72 xoreos — GFF4File::Header::read
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L151-L164 xoreos — GFF4File::load entry
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 PyKotor — GFFBinaryReader.load
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225 reone — GffReader
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts#L152-L221 KotOR.js — GFFObject.parse
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp#L86-L238 xoreos-tools — GFF3 load pipeline (shared with CLIs)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176 xoreos-tools — `gffdumper`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60 xoreos-tools — `gffcreator`
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf
class Gff < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @file = GffUnionFile.new(@_io, self, @_root)
    self
  end

  ##
  # Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
  # Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
  class FieldArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.file.gff3.header.field_count).times { |i|
        @entries << FieldEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
    # Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).
    attr_reader :entries
  end

  ##
  # Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
  class FieldData < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @raw_data = @_io.read_bytes(_root.file.gff3.header.field_data_count)
      self
    end

    ##
    # Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
    # Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
    # Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
    # Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
    attr_reader :raw_data
  end

  ##
  # One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
  # `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
  # Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
  class FieldEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @field_type = Kaitai::Struct::Stream::resolve_enum(BiowareGffCommon::GFF_FIELD_TYPE, @_io.read_u4le)
      @label_index = @_io.read_u4le
      @data_or_offset = @_io.read_u4le
      self
    end

    ##
    # Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
    def field_data_offset_value
      return @field_data_offset_value unless @field_data_offset_value.nil?
      if is_complex_type
        @field_data_offset_value = _root.file.gff3.header.field_data_offset + data_or_offset
      end
      @field_data_offset_value
    end

    ##
    # Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
    def is_complex_type
      return @is_complex_type unless @is_complex_type.nil?
      @is_complex_type =  ((field_type == :gff_field_type_uint64) || (field_type == :gff_field_type_int64) || (field_type == :gff_field_type_double) || (field_type == :gff_field_type_string) || (field_type == :gff_field_type_resref) || (field_type == :gff_field_type_localized_string) || (field_type == :gff_field_type_binary) || (field_type == :gff_field_type_vector4) || (field_type == :gff_field_type_vector3)) 
      @is_complex_type
    end

    ##
    # Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
    def is_list_type
      return @is_list_type unless @is_list_type.nil?
      @is_list_type = field_type == :gff_field_type_list
      @is_list_type
    end

    ##
    # Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
    # Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
    # **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
    def is_simple_type
      return @is_simple_type unless @is_simple_type.nil?
      @is_simple_type =  ((field_type == :gff_field_type_uint8) || (field_type == :gff_field_type_int8) || (field_type == :gff_field_type_uint16) || (field_type == :gff_field_type_int16) || (field_type == :gff_field_type_uint32) || (field_type == :gff_field_type_int32) || (field_type == :gff_field_type_single) || (field_type == :gff_field_type_str_ref)) 
      @is_simple_type
    end

    ##
    # Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
    def is_struct_type
      return @is_struct_type unless @is_struct_type.nil?
      @is_struct_type = field_type == :gff_field_type_struct
      @is_struct_type
    end

    ##
    # Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.
    def list_indices_offset_value
      return @list_indices_offset_value unless @list_indices_offset_value.nil?
      if is_list_type
        @list_indices_offset_value = _root.file.gff3.header.list_indices_offset + data_or_offset
      end
      @list_indices_offset_value
    end

    ##
    # Struct index (same numeric interpretation as `GFFStructData` row index).
    def struct_index_value
      return @struct_index_value unless @struct_index_value.nil?
      if is_struct_type
        @struct_index_value = data_or_offset
      end
      @struct_index_value
    end

    ##
    # Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
    # (ID → storage: inline vs `field_data` vs struct/list indirection).
    # Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
    # Source: Ghidra `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
    # Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
    # PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
    attr_reader :field_type

    ##
    # Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
    # Source: Ghidra `GFFFieldData.label_index` @ +0x4 (ulong).
    attr_reader :label_index

    ##
    # Inline data (simple types) or offset/index (complex types):
    # - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
    # - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
    # - Struct (14): Struct index (index into struct_array)
    # - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
    # Source: Ghidra `GFFFieldData.data_or_data_offset` @ +0x8.
    # `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
    attr_reader :data_or_offset
  end

  ##
  # Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
  # “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
  class FieldIndicesArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @indices = []
      (_root.file.gff3.header.field_indices_count).times { |i|
        @indices << @_io.read_u4le
      }
      self
    end

    ##
    # `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
    # `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
    # Ghidra: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.
    attr_reader :indices
  end

  ##
  # GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.
  class Gff3AfterAurora < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @header = GffHeaderTail.new(@_io, self, @_root)
      self
    end

    ##
    # Field dictionary: `header.field_count` × 12 B at `header.field_offset`. Ghidra: `GFFFieldData`.
    # `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
    # Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
    #     PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149
    def field_array
      return @field_array unless @field_array.nil?
      if header.field_count > 0
        _pos = @_io.pos
        @_io.seek(header.field_offset)
        @field_array = FieldArray.new(@_io, self, @_root)
        @_io.seek(_pos)
      end
      @field_array
    end

    ##
    # Complex-type payload heap. Ghidra: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
    # Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
    #     PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216
    def field_data
      return @field_data unless @field_data.nil?
      if header.field_data_count > 0
        _pos = @_io.pos
        @_io.seek(header.field_data_offset)
        @field_data = FieldData.new(@_io, self, @_root)
        @_io.seek(_pos)
      end
      @field_data
    end

    ##
    # Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
    # Ghidra: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
    # Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
    #     PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
    def field_indices_array
      return @field_indices_array unless @field_indices_array.nil?
      if header.field_indices_count > 0
        _pos = @_io.pos
        @_io.seek(header.field_indices_offset)
        @field_indices_array = FieldIndicesArray.new(@_io, self, @_root)
        @_io.seek(_pos)
      end
      @field_indices_array
    end

    ##
    # Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
    # Ghidra: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
    # Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
    #     PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154
    def label_array
      return @label_array unless @label_array.nil?
      if header.label_count > 0
        _pos = @_io.pos
        @_io.seek(header.label_offset)
        @label_array = LabelArray.new(@_io, self, @_root)
        @_io.seek(_pos)
      end
      @label_array
    end

    ##
    # Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
    # Ghidra: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
    # Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
    #     PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
    def list_indices_array
      return @list_indices_array unless @list_indices_array.nil?
      if header.list_indices_count > 0
        _pos = @_io.pos
        @_io.seek(header.list_indices_offset)
        @list_indices_array = ListIndicesArray.new(@_io, self, @_root)
        @_io.seek(_pos)
      end
      @list_indices_array
    end

    ##
    # Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
    # Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
    # Implements the access pattern described in meta.doc (single-field vs multi-field structs).
    def root_struct_resolved
      return @root_struct_resolved unless @root_struct_resolved.nil?
      @root_struct_resolved = ResolvedStruct.new(@_io, self, @_root, 0)
      @root_struct_resolved
    end

    ##
    # Struct table: `header.struct_count` × 12 B at `header.struct_offset`. Ghidra: `GFFStructData` rows.
    # Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
    #     PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65
    def struct_array
      return @struct_array unless @struct_array.nil?
      if header.struct_count > 0
        _pos = @_io.pos
        @_io.seek(header.struct_offset)
        @struct_array = StructArray.new(@_io, self, @_root)
        @_io.seek(_pos)
      end
      @struct_array
    end

    ##
    # Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
    # rows from Struct Array Offset through List Indices Count. Ghidra: `GFFHeaderInfo` @ +0x8 … +0x34.
    attr_reader :header
  end

  ##
  # GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
  # PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
  class Gff4AfterAurora < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil, aurora_version)
      super(_io, _parent, _root)
      @aurora_version = aurora_version
      _read
    end

    def _read
      @platform_id = @_io.read_u4be
      @file_type = @_io.read_u4be
      @type_version = @_io.read_u4be
      @num_struct_templates = @_io.read_u4le
      if aurora_version == 1446260273
        @string_count = @_io.read_u4le
      end
      if aurora_version == 1446260273
        @string_offset = @_io.read_u4le
      end
      @data_offset = @_io.read_u4le
      @struct_templates = []
      (num_struct_templates).times { |i|
        @struct_templates << Gff4StructTemplateHeader.new(@_io, self, @_root)
      }
      @tail = @_io.read_bytes_full
      self
    end

    ##
    # Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
    # `PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).
    attr_reader :platform_id

    ##
    # GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
    # `readUint32BE` on the endian-aware substream (`gff4file.cpp`).
    attr_reader :file_type

    ##
    # Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).
    attr_reader :type_version

    ##
    # Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
    # in typical DA assets). xoreos: `_header.structCount`.
    attr_reader :num_struct_templates

    ##
    # V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).
    attr_reader :string_count

    ##
    # V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).
    attr_reader :string_offset

    ##
    # Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
    # `readUint32` on the endian substream (`gff4file.cpp`).
    attr_reader :data_offset

    ##
    # Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).
    attr_reader :struct_templates

    ##
    # Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
    # optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
    # GFF4 graph walker or defer to engine code.
    attr_reader :tail

    ##
    # Aurora version tag from the enclosing stream’s first 8 bytes (read on disk as `u4be`;
    # passed as `u4` for Kaitai param typing). Same value as `gff_union_file.aurora_version` / `gff4_file.aurora_version`.
    attr_reader :aurora_version
  end

  ##
  # Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
  # that expect a single user-type over the whole file.
  class Gff4File < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @aurora_magic = @_io.read_u4be
      @aurora_version = @_io.read_u4be
      @gff4 = Gff4AfterAurora.new(@_io, self, @_root, aurora_version)
      self
    end

    ##
    # Aurora container magic (`GFF ` as `u4be`).
    attr_reader :aurora_magic

    ##
    # GFF4 `V4.0` / `V4.1` on-disk tags.
    attr_reader :aurora_version

    ##
    # GFF4 header tail + struct templates + opaque remainder.
    attr_reader :gff4
  end
  class Gff4StructTemplateHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @struct_label = @_io.read_u4be
      @field_count = @_io.read_u4le
      @field_offset = @_io.read_u4le
      @struct_size = @_io.read_u4le
      self
    end

    ##
    # Template label (fourCC style, read `readUint32BE` in `loadStructs`).
    attr_reader :struct_label

    ##
    # Number of field declaration records for this template (may be 0).
    attr_reader :field_count

    ##
    # Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
    # (xoreos `continue`s without reading declarations).
    attr_reader :field_offset

    ##
    # Declared on-disk struct size for instances of this template (`strct.size`).
    attr_reader :struct_size
  end

  ##
  # **GFF3** header continuation: **48 bytes** (twelve LE `u32` dwords) at file offsets **0x08–0x37**, immediately
  # after the shared Aurora 8-byte prefix (`aurora_magic` / `aurora_version` on `gff_union_file`). Same layout as
  # wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) rows from “Struct Array
  # Offset” through “List Indices Count”. Ghidra `/K1/k1_win_gog_swkotor.exe`: `GFFHeaderInfo` @ +0x8 … +0x34.
  # 
  # Sources (same DWORD order on disk after the 8-byte signature):
  # - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 (`file_type`/`file_version` L79–L80 then twelve header `u32`s L93–L106)
  # - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L44 (`GffReader::load` — skips 8-byte signature, reads twelve header `u32`s L30–L41)
  # - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
  # - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 (Aurora/GFF-family background; MultiMap wording)
  class GffHeaderTail < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @struct_offset = @_io.read_u4le
      @struct_count = @_io.read_u4le
      @field_offset = @_io.read_u4le
      @field_count = @_io.read_u4le
      @label_offset = @_io.read_u4le
      @label_count = @_io.read_u4le
      @field_data_offset = @_io.read_u4le
      @field_data_count = @_io.read_u4le
      @field_indices_offset = @_io.read_u4le
      @field_indices_count = @_io.read_u4le
      @list_indices_offset = @_io.read_u4le
      @list_indices_count = @_io.read_u4le
      self
    end

    ##
    # Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
    # Source: Ghidra `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L30
    attr_reader :struct_offset

    ##
    # Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
    # Source: Ghidra `GFFHeaderInfo.struct_count` @ +0xC (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L31
    attr_reader :struct_count

    ##
    # Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
    # Source: Ghidra `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L32
    attr_reader :field_offset

    ##
    # Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
    # Source: Ghidra `GFFHeaderInfo.field_count` @ +0x14 (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L33
    attr_reader :field_count

    ##
    # Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
    # Source: Ghidra `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L34
    attr_reader :label_offset

    ##
    # Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
    # Source: Ghidra `GFFHeaderInfo.label_count` @ +0x1C (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L35
    attr_reader :label_count

    ##
    # Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
    # Source: Ghidra `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L36
    attr_reader :field_data_offset

    ##
    # Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
    # Source: Ghidra `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L37
    attr_reader :field_data_count

    ##
    # Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
    # Source: Ghidra `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L38
    attr_reader :field_indices_offset

    ##
    # Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
    # Source: Ghidra `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)
    attr_reader :field_indices_count

    ##
    # Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
    # Source: Ghidra `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L40
    attr_reader :list_indices_offset

    ##
    # List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
    # Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
    # Source: Ghidra `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
    # PyKotor: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
    attr_reader :list_indices_count
  end

  ##
  # Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
  # (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
  class GffUnionFile < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @aurora_magic = @_io.read_u4be
      @aurora_version = @_io.read_u4be
      if  ((aurora_version != 1446260272) && (aurora_version != 1446260273)) 
        @gff3 = Gff3AfterAurora.new(@_io, self, @_root)
      end
      if  ((aurora_version == 1446260272) || (aurora_version == 1446260273)) 
        @gff4 = Gff4AfterAurora.new(@_io, self, @_root, aurora_version)
      end
      self
    end

    ##
    # File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
    # legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.
    attr_reader :aurora_magic

    ##
    # Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
    # `0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.
    attr_reader :aurora_version

    ##
    # **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.
    attr_reader :gff3

    ##
    # **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.
    attr_reader :gff4
  end

  ##
  # Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
  # Indexed by `GFFFieldData.label_index` (×16). Not a separate Ghidra struct — rows are `char[16]` in bulk.
  # Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
  class LabelArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @labels = []
      (_root.file.gff3.header.label_count).times { |i|
        @labels << LabelEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
    # Index `i` is at file offset `label_offset + i*16`.
    attr_reader :labels
  end

  ##
  # One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
  class LabelEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @name = (@_io.read_bytes(16)).force_encoding("ASCII").encode('UTF-8')
      self
    end

    ##
    # Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
    # Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
    # Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
    # Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
    attr_reader :name
  end

  ##
  # Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
  # Not a separate Ghidra datatype. Wire cite: `label_entry.name`.
  class LabelEntryTerminated < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(16), 0, false)).force_encoding("ASCII").encode('UTF-8')
      self
    end

    ##
    # Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.
    attr_reader :name
  end

  ##
  # One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
  # Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
  class ListEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @num_struct_indices = @_io.read_u4le
      @struct_indices = []
      (num_struct_indices).times { |i|
        @struct_indices << @_io.read_u4le
      }
      self
    end

    ##
    # Little-endian count of following struct indices (list cardinality).
    # Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
    attr_reader :num_struct_indices

    ##
    # Each value indexes `struct_array.entries[index]` (`GFFStructData` row).
    attr_reader :struct_indices
  end

  ##
  # Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
  class ListIndicesArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @raw_data = @_io.read_bytes(_root.file.gff3.header.list_indices_count)
      self
    end

    ##
    # Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
    # Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
    # This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.
    attr_reader :raw_data
  end

  ##
  # Kaitai composition: one `GFFFieldData` row + label + payload.
  # Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
  # Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
  # For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
  class ResolvedField < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil, field_index)
      super(_io, _parent, _root)
      @field_index = field_index
      _read
    end

    def _read
      self
    end

    ##
    # Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).
    def entry
      return @entry unless @entry.nil?
      _pos = @_io.pos
      @_io.seek(_root.file.gff3.header.field_offset + field_index * 12)
      @entry = FieldEntry.new(@_io, self, @_root)
      @_io.seek(_pos)
      @entry
    end

    ##
    # Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).
    def field_entry_pos
      return @field_entry_pos unless @field_entry_pos.nil?
      @field_entry_pos = _root.file.gff3.header.field_offset + field_index * 12
      @field_entry_pos
    end

    ##
    # Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.
    def label
      return @label unless @label.nil?
      _pos = @_io.pos
      @_io.seek(_root.file.gff3.header.label_offset + entry.label_index * 16)
      @label = LabelEntryTerminated.new(@_io, self, @_root)
      @_io.seek(_pos)
      @label
    end

    ##
    # `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.
    def list_entry
      return @list_entry unless @list_entry.nil?
      if entry.field_type == :gff_field_type_list
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.list_indices_offset + entry.data_or_offset)
        @list_entry = ListEntry.new(@_io, self, @_root)
        @_io.seek(_pos)
      end
      @list_entry
    end

    ##
    # Child structs for this list; indices from `list_entry.struct_indices`.
    def list_structs
      return @list_structs unless @list_structs.nil?
      if entry.field_type == :gff_field_type_list
        @list_structs = []
        (list_entry.num_struct_indices).times { |i|
          @list_structs << ResolvedStruct.new(@_io, self, @_root, list_entry.struct_indices[i])
        }
      end
      @list_structs
    end

    ##
    # `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
    def value_binary
      return @value_binary unless @value_binary.nil?
      if entry.field_type == :gff_field_type_binary
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_data_offset + entry.data_or_offset)
        @value_binary = BiowareCommon::BiowareBinaryData.new(@_io)
        @_io.seek(_pos)
      end
      @value_binary
    end

    ##
    # `GFFFieldTypes` 9 (double).
    def value_double
      return @value_double unless @value_double.nil?
      if entry.field_type == :gff_field_type_double
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_data_offset + entry.data_or_offset)
        @value_double = @_io.read_f8le
        @_io.seek(_pos)
      end
      @value_double
    end

    ##
    # `GFFFieldTypes` 3 (INT16 LE at +8).
    def value_int16
      return @value_int16 unless @value_int16.nil?
      if entry.field_type == :gff_field_type_int16
        _pos = @_io.pos
        @_io.seek(field_entry_pos + 8)
        @value_int16 = @_io.read_s2le
        @_io.seek(_pos)
      end
      @value_int16
    end

    ##
    # `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
    def value_int32
      return @value_int32 unless @value_int32.nil?
      if entry.field_type == :gff_field_type_int32
        _pos = @_io.pos
        @_io.seek(field_entry_pos + 8)
        @value_int32 = @_io.read_s4le
        @_io.seek(_pos)
      end
      @value_int32
    end

    ##
    # `GFFFieldTypes` 7 (INT64).
    def value_int64
      return @value_int64 unless @value_int64.nil?
      if entry.field_type == :gff_field_type_int64
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_data_offset + entry.data_or_offset)
        @value_int64 = @_io.read_s8le
        @_io.seek(_pos)
      end
      @value_int64
    end

    ##
    # `GFFFieldTypes` 1 (INT8 in low byte of slot).
    def value_int8
      return @value_int8 unless @value_int8.nil?
      if entry.field_type == :gff_field_type_int8
        _pos = @_io.pos
        @_io.seek(field_entry_pos + 8)
        @value_int8 = @_io.read_s1
        @_io.seek(_pos)
      end
      @value_int8
    end

    ##
    # `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
    def value_localized_string
      return @value_localized_string unless @value_localized_string.nil?
      if entry.field_type == :gff_field_type_localized_string
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_data_offset + entry.data_or_offset)
        @value_localized_string = BiowareCommon::BiowareLocstring.new(@_io)
        @_io.seek(_pos)
      end
      @value_localized_string
    end

    ##
    # `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
    def value_resref
      return @value_resref unless @value_resref.nil?
      if entry.field_type == :gff_field_type_resref
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_data_offset + entry.data_or_offset)
        @value_resref = BiowareCommon::BiowareResref.new(@_io)
        @_io.seek(_pos)
      end
      @value_resref
    end

    ##
    # `GFFFieldTypes` 8 (32-bit float).
    def value_single
      return @value_single unless @value_single.nil?
      if entry.field_type == :gff_field_type_single
        _pos = @_io.pos
        @_io.seek(field_entry_pos + 8)
        @value_single = @_io.read_f4le
        @_io.seek(_pos)
      end
      @value_single
    end

    ##
    # `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
    # `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
    # **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
    # Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
    # PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
    def value_str_ref
      return @value_str_ref unless @value_str_ref.nil?
      if entry.field_type == :gff_field_type_str_ref
        _pos = @_io.pos
        @_io.seek(field_entry_pos + 8)
        @value_str_ref = @_io.read_u4le
        @_io.seek(_pos)
      end
      @value_str_ref
    end

    ##
    # `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
    def value_string
      return @value_string unless @value_string.nil?
      if entry.field_type == :gff_field_type_string
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_data_offset + entry.data_or_offset)
        @value_string = BiowareCommon::BiowareCexoString.new(@_io)
        @_io.seek(_pos)
      end
      @value_string
    end

    ##
    # `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.
    def value_struct
      return @value_struct unless @value_struct.nil?
      if entry.field_type == :gff_field_type_struct
        @value_struct = ResolvedStruct.new(@_io, self, @_root, entry.data_or_offset)
      end
      @value_struct
    end

    ##
    # `GFFFieldTypes` 2 (UINT16 LE at +8).
    def value_uint16
      return @value_uint16 unless @value_uint16.nil?
      if entry.field_type == :gff_field_type_uint16
        _pos = @_io.pos
        @_io.seek(field_entry_pos + 8)
        @value_uint16 = @_io.read_u2le
        @_io.seek(_pos)
      end
      @value_uint16
    end

    ##
    # `GFFFieldTypes` 4 (full inline DWORD).
    def value_uint32
      return @value_uint32 unless @value_uint32.nil?
      if entry.field_type == :gff_field_type_uint32
        _pos = @_io.pos
        @_io.seek(field_entry_pos + 8)
        @value_uint32 = @_io.read_u4le
        @_io.seek(_pos)
      end
      @value_uint32
    end

    ##
    # `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
    def value_uint64
      return @value_uint64 unless @value_uint64.nil?
      if entry.field_type == :gff_field_type_uint64
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_data_offset + entry.data_or_offset)
        @value_uint64 = @_io.read_u8le
        @_io.seek(_pos)
      end
      @value_uint64
    end

    ##
    # `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
    def value_uint8
      return @value_uint8 unless @value_uint8.nil?
      if entry.field_type == :gff_field_type_uint8
        _pos = @_io.pos
        @_io.seek(field_entry_pos + 8)
        @value_uint8 = @_io.read_u1
        @_io.seek(_pos)
      end
      @value_uint8
    end

    ##
    # `GFFFieldTypes` 17 — three floats (`bioware_vector3`).
    def value_vector3
      return @value_vector3 unless @value_vector3.nil?
      if entry.field_type == :gff_field_type_vector3
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_data_offset + entry.data_or_offset)
        @value_vector3 = BiowareCommon::BiowareVector3.new(@_io)
        @_io.seek(_pos)
      end
      @value_vector3
    end

    ##
    # `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
    def value_vector4
      return @value_vector4 unless @value_vector4.nil?
      if entry.field_type == :gff_field_type_vector4
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_data_offset + entry.data_or_offset)
        @value_vector4 = BiowareCommon::BiowareVector4.new(@_io)
        @_io.seek(_pos)
      end
      @value_vector4
    end

    ##
    # Index into `field_array.entries`; require `field_index < field_count`.
    attr_reader :field_index
  end

  ##
  # Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
  # On-disk row remains at `struct_offset + struct_index * 12`.
  class ResolvedStruct < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil, struct_index)
      super(_io, _parent, _root)
      @struct_index = struct_index
      _read
    end

    def _read
      self
    end

    ##
    # Raw `GFFStructData` (Ghidra 12-byte layout).
    def entry
      return @entry unless @entry.nil?
      _pos = @_io.pos
      @_io.seek(_root.file.gff3.header.struct_offset + struct_index * 12)
      @entry = StructEntry.new(@_io, self, @_root)
      @_io.seek(_pos)
      @entry
    end

    ##
    # Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
    # Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
    def field_indices
      return @field_indices unless @field_indices.nil?
      if entry.field_count > 1
        _pos = @_io.pos
        @_io.seek(_root.file.gff3.header.field_indices_offset + entry.data_or_offset)
        @field_indices = []
        (entry.field_count).times { |i|
          @field_indices << @_io.read_u4le
        }
        @_io.seek(_pos)
      end
      @field_indices
    end

    ##
    # One `resolved_field` per entry in `field_indices`.
    def fields
      return @fields unless @fields.nil?
      if entry.field_count > 1
        @fields = []
        (entry.field_count).times { |i|
          @fields << ResolvedField.new(@_io, self, @_root, field_indices[i])
        }
      end
      @fields
    end

    ##
    # `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).
    def single_field
      return @single_field unless @single_field.nil?
      if entry.field_count == 1
        @single_field = ResolvedField.new(@_io, self, @_root, entry.data_or_offset)
      end
      @single_field
    end

    ##
    # Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.
    attr_reader :struct_index
  end

  ##
  # Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Ghidra name `GFFStructData`.
  # Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
  class StructArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.file.gff3.header.struct_count).times { |i|
        @entries << StructEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
    # Stride 12 bytes per struct (matches Ghidra component sizes).
    attr_reader :entries
  end

  ##
  # One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
  class StructEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @struct_id = @_io.read_u4le
      @data_or_offset = @_io.read_u4le
      @field_count = @_io.read_u4le
      self
    end

    ##
    # Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.
    def field_indices_offset
      return @field_indices_offset unless @field_indices_offset.nil?
      if has_multiple_fields
        @field_indices_offset = data_or_offset
      end
      @field_indices_offset
    end

    ##
    # Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
    def has_multiple_fields
      return @has_multiple_fields unless @has_multiple_fields.nil?
      @has_multiple_fields = field_count > 1
      @has_multiple_fields
    end

    ##
    # Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
    # Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
    def has_single_field
      return @has_single_field unless @has_single_field.nil?
      @has_single_field = field_count == 1
      @has_single_field
    end

    ##
    # Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
    def single_field_index
      return @single_field_index unless @single_field_index.nil?
      if has_single_field
        @single_field_index = data_or_offset
      end
      @single_field_index
    end

    ##
    # Structure type identifier.
    # Source: Ghidra `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
    # Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
    # 0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.
    attr_reader :struct_id

    ##
    # Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
    # If field_count == 0, this value is unused.
    # Source: Ghidra `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
    attr_reader :data_or_offset

    ##
    # Number of fields in this struct:
    # - 0: No fields
    # - 1: Single field, data_or_offset contains the field index directly
    # - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
    # Source: Ghidra `GFFStructData.field_count` @ +0x8 (ulong).
    attr_reader :field_count
  end

  ##
  # Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
  # (`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
  # Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
  # mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
  # downstream `pos:` / `_root.file.gff3.header` paths.
  attr_reader :file
end
