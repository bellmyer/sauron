class SauronGenerator < Rails::Generator::Base
  def manifest
    options[:workers] ||= 4

    options[:rspec] ||= false
    options[:testunit] ||= false
    
    options[:framework] = options[:rspec] ? 'rspec' : 'testunit'

    record do |m|
      m.file 'sauron_watchr.rb', 'sauron_watchr.rb'
      m.file 'test_helper.rb', 'test_helper.rb'
      m.file 'script/sauron', 'script/sauron', :chmod => 0755

      m.file 'config/hydra.yml', 'config/hydra.yml'
      m.template 'config/sauron.yml', 'config/sauron.yml'
      
      m.directory 'lib/sauron'
      m.file 'lib/sauron/watchr.rb', 'lib/sauron/watchr.rb' 
      
      m.directory 'lib/tasks'
      m.file 'lib/tasks/sauron.rake', 'lib/tasks/sauron.rake'
    end
  end
  
  protected
  
  def add_options!(opt)
    opt.on('--workers='){|v| options[:workers] = v}
    opt.on('--rspec'){|v| options[:rspec] = v}
    opt.on('--testunit'){|v| options[:testunit] = v}
  end
end