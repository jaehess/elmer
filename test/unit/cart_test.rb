require File.dirname(__FILE__) + '/../test_helper'

class CartTest < Test::Unit::TestCase
  
  def setup
    @rom = NES::Cart.load(nestest_rom)
  end
  
  def test_load_cart
    assert_not_nil @rom.header
    assert_not_nil @rom.program_rom
    assert_not_nil @rom.character_rom
  end
  
  def test_cart_header_properties
    header = @rom.header
    assert_not_nil header
    assert_kind_of Elmer::NES::Cart::Rom::Header, header
    assert_equal 16, header.data.length
    assert_equal "NES", header.signature
    assert_equal header.data[4] * 16384, header.program_rom_units
    assert_equal header.data[5] * 8192, header.character_rom_units
  end
  
  def test_cart_rom_properties
    rom = @rom.rom
    assert_not_nil rom
    assert_kind_of Elmer::NES::Cart::Rom, rom
    assert_equal rom.header.data[4] * 16384, rom.program_rom_banks.length
    assert_equal rom.header.data[5] * 8192, rom.character_rom_banks.length
    assert_not_equal rom.character_rom_banks, rom.program_rom_banks
    assert_equal [], rom.bytes
  end
  
end