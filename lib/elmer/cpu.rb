module Elmer
  
  class CPU
    
    attr_accessor :program_counter, :stack_pointer, :status, :x, :y, :accumulator
    
    def initialize
    end
    
    # Reset the internal CPU Registers
    def reset_cpu
      # Correct CPU Cycles for Odd Games
      
      # Reset the CPU Registers
      accumulator, x, y = 0x00
      stack_pointer = 0x04
      status = 0xFF
      program_counter = 0#readWord(0xFFFC)
    end
    
    # Read value from a specified memory address
    def read_memory(address)
      # nes.memory.readWord(address)
      # Memory Manager readWord above
      # return read(address) | (read(address + 1) << 8);
    end
    
    class << self
      
      # Run the CPU
      def power_on
        active = true
        # active = true
        # running = true
        # Thread bob = new Thread(this)
        # bob.start()
      end
    
    end # /Eigenclass
    
  end # /CPU
  
end # /Elmer