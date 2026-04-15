# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
# Scripts run inside a stack-based virtual machine shared across Aurora engine games.
# 
# Format Structure:
# - Header (13 bytes): Signature "NCS ", version "V1.0", size marker (0x42), file size
# - Instruction Stream: Sequence of bytecode instructions
# 
# All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).
# 
# References:
# - https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format - Complete NCS format documentation
# - NSS.ksy - NWScript source code that compiles to NCS
class Ncs < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotEqualError.new("NCS ", @file_type, @_io, "/seq/0") if not @file_type == "NCS "
    @file_version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotEqualError.new("V1.0", @file_version, @_io, "/seq/1") if not @file_version == "V1.0"
    @size_marker = @_io.read_u1
    raise Kaitai::Struct::ValidationNotEqualError.new(66, @size_marker, @_io, "/seq/2") if not @size_marker == 66
    @file_size = @_io.read_u4be
    @instructions = []
    i = 0
    begin
      _ = Instruction.new(@_io, self, @_root)
      @instructions << _
      i += 1
    end until _io.pos >= file_size
    self
  end

  ##
  # NWScript bytecode instruction.
  # Format: <opcode: uint8> <qualifier: uint8> <arguments: variable>
  # 
  # Instruction size varies by opcode:
  # - Base: 2 bytes (opcode + qualifier)
  # - Arguments: 0 to variable bytes depending on instruction type
  # 
  # Common instruction types:
  # - Constants: CONSTI (6B), CONSTF (6B), CONSTS (2+N B), CONSTO (6B)
  # - Stack ops: CPDOWNSP, CPTOPSP, MOVSP (variable size)
  # - Arithmetic: ADDxx, SUBxx, MULxx, DIVxx (2B)
  # - Control flow: JMP, JSR, JZ, JNZ (6B), RETN (2B)
  # - Function calls: ACTION (5B)
  # - And many more (see NCS format documentation)
  class Instruction < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @opcode = @_io.read_u1
      @qualifier = @_io.read_u1
      @arguments = []
      i = 0
      begin
        _ = @_io.read_u1
        @arguments << _
        i += 1
      end until _io.pos >= _io.size
      self
    end

    ##
    # Instruction opcode (0x01-0x2D, excluding 0x42 which is reserved for size marker).
    # Determines the instruction type and argument format.
    attr_reader :opcode

    ##
    # Qualifier byte that refines the instruction to specific operand types.
    # Examples: 0x03=Int, 0x04=Float, 0x05=String, 0x06=Object, 0x24=Structure
    attr_reader :qualifier

    ##
    # Instruction arguments (variable size).
    # Format depends on opcode:
    # - No args: None (total 2B)
    # - Int/Float/Object: 4 bytes (total 6B)
    # - String: 2B length + data (total 2+N B)
    # - Jump: 4B signed offset (total 6B)
    # - Stack copy: 4B offset + 2B size (total 8B)
    # - ACTION: 2B routine + 1B argCount (total 5B)
    # - DESTRUCT: 2B size + 2B offset + 2B sizeNoDestroy (total 8B)
    # - STORE_STATE: 4B size + 4B sizeLocals (total 10B)
    # - And others (see documentation)
    attr_reader :arguments
  end

  ##
  # File type signature. Must be "NCS " (0x4E 0x43 0x53 0x20).
  attr_reader :file_type

  ##
  # File format version. Must be "V1.0" (0x56 0x31 0x2E 0x30).
  attr_reader :file_version

  ##
  # Program size marker opcode. Must be 0x42.
  # This is not a real instruction but a metadata field containing the total file size.
  # All implementations validate this marker before parsing instructions.
  attr_reader :size_marker

  ##
  # Total file size in bytes (big-endian).
  # This value should match the actual file size.
  attr_reader :file_size

  ##
  # Stream of bytecode instructions.
  # Execution begins at offset 13 (0x0D) after the header.
  # Instructions continue until end of file.
  attr_reader :instructions
end
