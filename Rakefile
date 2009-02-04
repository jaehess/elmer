require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

desc 'Run tests'
task :default => :test
Rake::TestTask.new('test') do |t|
  t.libs << 'test'
  t.pattern = 'test/*/*_test.rb'
end