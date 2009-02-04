module Elmer
  
  module NES
    
    # The iNES format (file name suffix .nes) is the de facto standard for distribution of NES binary programs. 
    # It consists of the following sections, in order:
    # Header (16 bytes)
    # Trainer, if present (0 or 512 bytes)
    # PRG ROM (16384 * x bytes)
    # CHR ROM, if present (8192 * y bytes)
    # PlayChoice hint screen, if present (0 or 8192 bytes)
    class Cart
      
      attr_accessor :rom, :header, :trainer, :program_rom, :character_rom, :play_choice
      
      def initialize(rom_path)
        @rom = Rom.new(rom_path)
        @header = @rom.header
        @program_rom   = @rom.program_rom_banks
        @character_rom = @rom.character_rom_banks
      end
      
      class << self
      
        def load(rom)
          new(rom)
        end
      
      end
      
      class Rom
        
        attr_accessor :header, :bytes, :program_rom_banks, :character_rom_banks
        
        def initialize(rom_path)
          @bytes ||= []
          open(rom_path, 'rb'){|f| f.each_byte{|b| @bytes << b}}
          @header = Header.new(self)
          @program_rom_banks ||= @bytes.slice!(0..(@header.program_rom_units-1))
          @character_rom_banks ||= @bytes.slice!(0..(@header.character_rom_units-1))
        end
        
        # ROM Header
        # The format of the header is as follows:
        # 0-3: Constant $4E $45 $53 $1A ("NES" followed by MS-DOS end-of-file)
        # 4: Size of PRG ROM in 16 KB units
        # 5: Size of CHR ROM in 8 KB units (Value 0 means the board uses CHR RAM)
        # 6: Flags 6
        # 7: Flags 7
        # 8: Size of PRG RAM in 8KB RAM (Value 0 infers 8KB for compatibility)
        # 9: Flags 9
        # 10: Flags 10 (unofficial)
        # 11-15: Zero filled
        class Header

          attr_accessor :data, :signature, :program_rom_units, :character_rom_units

          def initialize(rom)
            @data = extract_header(rom.bytes)
            ensure_nes(signature)
            @program_rom_units   ||= 0
            @character_rom_units ||= 0
          end

          private
          
          def extract_header(data)
            header                   = data.slice!(0..15)
            self.signature           = header[0..2].map{|c| c.chr}.join
            self.program_rom_units   = header[4] * 16384
            self.character_rom_units = header[5] * 8192
            header
          end

          def ensure_nes(signature)
            raise InvalidRom, "The ROM image is not in a valid NES format." unless signature == "NES"
          end

        end
        
      end
      
    end
  
  end
  
end