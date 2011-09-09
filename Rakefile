# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "static_fm"
  gem.homepage = "http://github.com/rossta/static_fm"
  gem.license = "MIT"
  gem.summary = "A static file manager: install and upgrade vendor assets (Javascript|CSS)"
  gem.description = <<-DESCRIPTION
It's time consuming to look up the URLs to your favorite javascript libraries and css
frameworks every time you start a new project or need to upgrade to a new version. Static
FM provides recipes and tasks to speed up the process so you can start using the latest now.
DESCRIPTION
  gem.email = "rosskaff@gmail.com"
  gem.authors = ["Ross Kaffenberger"]
  gem.executables << 'static'
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb'].exclude('spec/**/network_spec.rb')
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

RSpec::Core::RakeTask.new(:network) do |spec|
  # includes network_spec which requires network access to perform and check downloads
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

# require 'rake/task'
# Rake::RDocTask.new do |rdoc|
#   version = File.exist?('VERSION') ? File.read('VERSION') : ""
#
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "static_fm #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end

require 'static_fm/tasks'