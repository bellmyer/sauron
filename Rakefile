require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the sauron plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the sauron plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Sauron'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "sauron"
    gem.summary = %Q{Multi-threaded, automated testing toolkit}
    gem.description = %Q{Speed up your automated tests with multiple databases and workers.}
    gem.email = "jaime@kconrails.com"
    gem.homepage = "http://github.com/bellmyer/sauron"
    gem.authors = ['Jaime Bellmyer']
    gem.add_development_dependency "bellmyer-hydra", ">= 0.20.9"
    gem.add_development_dependency "watchr", ">= 0.6"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
