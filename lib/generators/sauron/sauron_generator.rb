class SauronGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  
  class_option :workers, :type => :numeric, :default => 4, 
    :desc => "Number of workers (threads/databases used during tests)"
  class_option :rspec, :type => :boolean, :default => false
  class_option :testunit, :type => :boolean, :default => true
  
  # TODO use hook_for :test_framework ?
  
  def manifest    
    copy_file 'sauron_watchr.rb', 'sauron_watchr.rb'
    copy_file 'script/sauron', 'script/sauron'

    copy_file 'config/hydra.yml', 'config/hydra.yml'
    template 'config/sauron.yml', 'config/sauron.yml'
    
    directory 'lib/sauron'
    
    directory 'lib/tasks'
  end
  
  protected
  
  def test_framework
    options.rspec ? 'rspec' : 'testunit'
  end
end