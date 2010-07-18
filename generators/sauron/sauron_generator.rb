class SauronGenerator < Rails::Generator::Base
  def manifest
    options[:runners] ||= 4

    record do |m|
      m.file 'sauron_watchr.rb', 'sauron_watchr.rb'
      m.file 'test_helper.rb', 'test_helper.rb'
      m.file 'sauron', 'sauron', :chmod => 0755

      m.template 'config/hydra.yml', 'config/hydra.yml'
      
      m.directory 'lib/sauron'
      m.file 'lib/sauron/watchr.rb', 'lib/sauron/watchr.rb' 
      
      m.directory 'lib/tasks'
      m.file 'lib/tasks/sauron.rake', 'lib/tasks/sauron.rake'
    end
  end
  
  protected
  
  def add_options!(opt)
    opt.on('--runners='){|v| options[:runners] = v}
  end
end