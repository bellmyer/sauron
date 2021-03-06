require 'yaml'
require 'erb'

class SauronTemplate
  attr_accessor :framework, :workers, :hydra
  
  def initialize
    if File.exists? config_file
      config = YAML::load(ERB.new(IO.read(config_file)).result)
    
      self.framework = config[:framework]
      self.workers = config[:workers]
    end
  end
  
  def config_file
    'config/sauron.yml'
  end
  
  def set_hydra
    if self.hydra = !!(`rake -T hydra:sauron` =~ /hydra:sauron/)
      message "Using hydra to run multiple tests in parallel"
    else
      message "You don't have hydra properly setup.  All tests will be run in single-threaded mode."
    end
  end

  def run_routing_tests
    message "running routing tests"
    run_multiple_tests routing_tests
  end

  def run_single_test file
    message "running #{file}"

    case framework
    when 'testunit'
      system "time ruby -I.:lib:test -rubygems -e \"require '#{file}'\""
    when 'rspec'
      system "time ruby script/spec -O spec/spec.opts #{file}"
    end
  end
  
  def run_pattern_tests prefix, pattern, suffix
    files = []
    
    elements = pattern.split(/_/)
    begin
      files << Dir.glob("#{prefix}#{elements.join('_')}#{suffix}") unless elements.empty?
    end while elements.shift
    
    files.size == 1 ? run_single_test(files.first) : run_multiple_tests(files)
  end

  def run_multiple_tests *files
    joined_files = files.join(',')

    message "running #{files.first.size} tests: #{joined_files}"

    if hydra
      system "time rake hydra:sauron RAILS_ENV=test FILE_LIST=#{joined_files} SAURON_WORKERS=#{workers}"
    else
      case framework
      when 'testunit'
        system "time ruby -I.:lib:test -rubygems -e \"%w[#{files.join(' ')}].each {|f| require f}\""  
      when 'rspec'
        system "time ruby script/spec -O spec/spec.opts #{files.join(' ')}"
      end
    end
  end

  def run_all_tests
    message "running all tests"
    run_multiple_tests all_tests
  end

  def unit_tests
    case framework
    when 'testunit'
      Dir.glob('test/unit/*_test.rb')
    when 'rspec'
      Dir.glob('spec/models/*_spec.rb')
    end
  end

  def helper_tests
    case framework
    when 'testunit'
      Dir.glob('test/unit/helpers/*_test.rb')
    when 'rspec'
      Dir.glob('spec/helpers/*_spec.rb')
    end
  end

  def functional_tests
    case framework
    when 'testunit'
      Dir.glob('test/functional/*_test.rb')
    when 'rspec'
      Dir.glob('spec/controllers/*_spec.rb')
    end
  end

  def view_tests controller = :all
    case framework
    when 'testunit'
      []
    when 'rspec'
      if controller == :all
        Dir.glob('spec/views/**/*_spec.rb')
      else
        Dir.glob('spec/views/#{controller}/*_spec.rb')
      end
    end
  end

  def routing_tests
    case framework
    when 'testunit'
      Dir.glob('test/unit/rout{es,ing}_test.rb')
    when 'rspec'
      Dir.glob('spec/models/rout{es,ing}_spec.rb')
    end
  end

  def all_tests
    case framework
    when 'testunit'
      Dir.glob('test/**/*_test.rb')
    when 'rspec'
      Dir.glob('spec/**/*_spec.rb')
    end
  end

  def message body
    system 'clear'
    puts body
  end

  def setup_databases
    print "setting up #{workers} workers and their databases (you can change in config/sauron.yml)"
    STDOUT.flush

    # setup each database #
    workers.times do |i|
      print '.'
      STDOUT.flush

      hydra_worker_id = (i == 0 ? '' : i)
      test_env_number = (i == 0 ? '' : i + 1)
      
      `rake db:reset RAILS_ENV=test HYDRA_WORKER_ID=#{hydra_worker_id} TEST_ENV_NUMBER=#{test_env_number}`
    end
  end

  def startup
    set_hydra
    setup_databases
    run_all_tests
  end
end
