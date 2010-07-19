require 'hydra'
require 'hydra/tasks'
require 'sauron'

Hydra::TestTask.new('hydra:sauron') do |t|
  if ENV.has_key?('FILE_LIST')
    ENV['FILE_LIST'].split(/,/).each {|file| t.add_files file}
  else
    Sauron.all_tests
  end
end
