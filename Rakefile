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

desc 'Upload website files to rubyforge'
task :website do
  host = "jaehess@rubyforge.org"
  remote_dir = "/var/www/gforge-projects/elmer/"
  local_dir = '~/Sites/elmer.rubyforge.org/site'
  sh %{rsync -av #{local_dir}/ #{host}:#{remote_dir}}
end