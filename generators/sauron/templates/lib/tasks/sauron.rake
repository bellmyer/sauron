require 'hydra'
require 'hydra/tasks'

Hydra::TestTask.new('hydra:sauron') do |t|
  if ENV.has_key?('FILE_LIST')
    ENV['FILE_LIST'].split(/,/).each {|file| t.add_files file}
  else
    t.add_files 'test/**/*_test.rb'
  end
end
