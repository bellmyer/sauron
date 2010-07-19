require 'hydra'
require 'hydra/tasks'
require 'yaml'

sauron = YAML.load_file('config/sauron.yml')

Hydra::TestTask.new('hydra:sauron') do |t|
  if ENV.has_key?('FILE_LIST')
    ENV['FILE_LIST'].split(/,/).each {|file| t.add_files file}
  else
    case sauron[:framework]
    when 'testunit'
      t.add_files 'test/**/*_test.rb'
    when 'rspec'
      t.add_files 'spec/**/*_spec.rb'
    end
  end
end
