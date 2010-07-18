require 'lib/sauron/watchr'

# Unit tests #
watch('test/unit/.*_test\.rb'){|f| run_single_test f[0]}
watch('app/models/(.*)\.rb'){|f| run_single_test "test/unit/#{f[1]}_test.rb"}

# Functional tests #
watch('test/functional/.*_test\.rb'){|f| run_single_test f[0]}
watch('app/controllers/(.*)\.rb'){|f| run_single_test "test/functional/#{f[1]}_test.rb"}
watch('app/views/(.*)/.*\.html.erb'){|f| run_single_test "test/functional/#{f[1]}_controller_test.rb"}

# Routing tests #
watch('config/routes.rb'){|f| run_routing_tests }

# Multiple tests #
watch('test/test_helper.rb'){|f| run_all_tests }