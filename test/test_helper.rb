require 'test/unit'
require 'rubygems'
require 'redgreen'

$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'elmer'

class Test::Unit::TestCase
  include Elmer
  
  def fixture_path
    File.join('test', 'fixtures')
  end
  
  def nestest_rom
    File.join(fixture_path, 'cpu', 'nestest.nes')
  end
  
  def megamanjet_rom
    File.join(fixture_path, 'MegaManJet.nes')
  end 
  
end