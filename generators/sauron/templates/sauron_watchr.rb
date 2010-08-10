require 'lib/sauron/watchr'

case Sauron.framework
when 'testunit'
  # Unit tests #
  watch('test/unit/(.*)_test\.rb'){|f| Sauron.run_pattern_tests 'test/unit/', f[1], '_test.rb'}
  watch('app/models/(.*)\.rb') do |f|
    files = Dir.glob("test/unit/*_#{f[1]}_test.rb")
    
    if files.size == 1
      Sauron.run_single_test files.first
    else
      Sauron.run_multiple_tests files
    end
  end
  
  # Functional tests #
  watch('test/functional/(.*)_controller_test\.rb'){|f| Sauron.run_pattern_tests 'test/functional/', f[1], '_controller_test.rb'}

  watch('app/controllers/(.*)\.rb') do |f|
    files = Dir.glob("test/functional/*_#{f[1]}_test.rb")
    
    if files.size == 1
      Sauron.run_single_test files.first
    else
      Sauron.run_multiple_tests files
    end
  end

  watch('app/views/(.*)/.*\.html.erb'){|f| Sauron.run_single_test "test/functional/#{f[1]}_controller_test.rb"}

  # Routing tests #
  watch('config/routes.rb'){|f| Sauron.run_routing_tests }
  watch('test/unit/rout(ing|es)_test.rb'){|f| Sauron.run_routing_tests }

  # Multiple tests #
  watch('test/test_helper.rb'){|f| Sauron.run_all_tests }
  
when 'rspec'
  # Model tests #
  watch('spec/models/.*_spec\.rb'){|f| Sauron.run_single_test f[0]}
  watch('app/models/(.*)\.rb'){|f| Sauron.run_single_test "spec_models/#{f[1]}_spec.rb"}

  # Controller/View tests #
  watch('spec/controllers/.*_spec\.rb'){|f| Sauron.run_single_test f[0]}
  watch('app/controllers/(.*)\.rb'){|f| Sauron.run_multiple_tests ["spec/controllers/#{f[1]}_spec.rb"] + view_tests(f[1])}
  watch('app/views/(.*)/(.*)'){|f| Sauron.run_multiple_tests "spec/controllers/#{f[1]}_controller_spec.rb", "spec/views/#{f[1]}/#{f[2]}_spec.rb"}

  # Routing tests #
  watch('config/routes.rb'){|f| Sauron.run_routing_tests }

  # Multiple tests #
  watch('spec/spec_helper.rb'){|f| Sauron.run_all_tests }
end