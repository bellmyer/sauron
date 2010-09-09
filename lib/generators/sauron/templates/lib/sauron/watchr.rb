require 'sauron'

Signal.trap('QUIT') do
  Sauron.run_all_tests
end

# Startup #
Sauron.startup
