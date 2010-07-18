require 'yaml'

def set_hydra
  $hydra = !!(`rake -T` =~ /rake hydra:sauron\s+/)
end

def run_routing_tests
  message "running routing tests"
  run_multiple_tests routing_tests
end

def run_single_test file
  message "running #{file}"
  system "time ruby -I.:lib:test -rubygems -e \"require '#{file}'\""  
end

def run_multiple_tests *files
  joined_files = files.join(',')

  message "running #{files.first.size} tests: #{joined_files}"
  
  if $hydra
    system "time rake hydra:sauron RAILS_ENV=test FILE_LIST=#{joined_files}"
  else
    system "time ruby -I.:lib:test -rubygems -e \"%w[#{files.join(' ')}].each {|f| require f}\""  
  end
end

def run_all_tests
  message "running all tests"
  run_multiple_tests all_tests
end

def unit_tests
  Dir.glob('test/unit/*_test.rb')
end

def helper_tests
  Dir.glob('test/unit/helpers/*_test.rb')
end

def functional_tests
  Dir.glob('test/functional/*_test.rb')
end

def routing_tests
  Dir.glob('test/unit/rout{es,ing}_test.rb')
end

def all_tests
  Dir.glob('test/**/*_test.rb')
end

def message body
  system 'clear'
  puts body
end

def setup_databases
  # Find the number of runners #
  runners = 0
  hydra_yaml = YAML.load_file('config/hydra.yml')
  hydra_yaml['workers'].each do |worker|
    runners = worker['runners'] if worker['runners'] > runners && worker['type'] == 'local'
  end
 
  print "setting up #{runners} databases"
  STDOUT.flush

  # setup each database #
  runners.times do |i|
    print '.'
    STDOUT.flush
    
    i = '' if i == 0
    `rake db:reset RAILS_ENV=test TEST_ENV_NUMBER=#{i}`
  end
end

def startup
  set_hydra
  setup_databases
  run_all_tests
end

Signal.trap('QUIT') do
  run_all_tests
end

# Startup #
startup
