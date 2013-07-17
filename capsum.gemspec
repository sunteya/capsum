# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "capsum"
  s.version     = File.read(File.expand_path("../VERSION", __FILE__)).chomp
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sunteya"]
  s.email       = ["Sunteya@gmail.com"]
  s.homepage    = "http://github.com/sunteya/capsum"
  s.summary     = %q{Collect gems and recipes related capistrano.}
  s.description = %q{Collect gems and recipes related capistrano.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.license       = 'MIT'
  
  # Dependency Gems
  s.add_dependency "capistrano", "~> 2.15.3"
  # s.add_dependency "capistrano-helpers", "~> 0.7.1"
  # s.add_dependency "cap-recipes", "~> 0.3.36"
  # https://github.com/rubaidh/rubaidhstrano
  # https://github.com/relevance/cap_gun
  # https://github.com/railsmachine/capistrano-cowboy
  # https://github.com/fnichol/capstrap
  # https://github.com/bokmann/dunce-cap
  
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "version"
end

