# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sauron}
  s.version = "0.1.30"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jaime Bellmyer"]
  s.date = %q{2010-09-03}
  s.description = %q{Speed up your automated tests with multiple databases and workers.}
  s.email = %q{jaime@kconrails.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "generators/sauron/USAGE",
     "generators/sauron/sauron_generator.rb",
     "generators/sauron/templates/config/hydra.yml",
     "generators/sauron/templates/config/sauron.yml",
     "generators/sauron/templates/lib/sauron/watchr.rb",
     "generators/sauron/templates/lib/tasks/sauron.rake",
     "generators/sauron/templates/sauron_watchr.rb",
     "generators/sauron/templates/script/sauron",
     "generators/sauron/templates/test_helper.rb",
     "lib/sauron.rb",
     "lib/sauron/sauron_template.rb",
     "sauron.gemspec",
     "test/sauron_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/bellmyer/sauron}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Multi-threaded, automated testing toolkit}
  s.test_files = [
    "test/sauron_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bellmyer-hydra>, [">= 0.20.10"])
      s.add_runtime_dependency(%q<watchr>, [">= 0.6"])
    else
      s.add_dependency(%q<bellmyer-hydra>, [">= 0.20.10"])
      s.add_dependency(%q<watchr>, [">= 0.6"])
    end
  else
    s.add_dependency(%q<bellmyer-hydra>, [">= 0.20.10"])
    s.add_dependency(%q<watchr>, [">= 0.6"])
  end
end

