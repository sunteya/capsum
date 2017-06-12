# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capsum/version'

Gem::Specification.new do |spec|
  spec.name          = "capsum"
  spec.version       = Capsum::VERSION
  spec.authors       = ["sunteya"]
  spec.email         = ["sunteya@gmail.com"]
  spec.summary       = %q{Collect gems and recipes related capistrano.}
  spec.description   = %q{Collect gems and recipes related capistrano.}
  spec.homepage      = "http://github.com/sunteya/capsum"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Dependency Gems
  spec.add_dependency "capistrano", "~> 3.7.1"
  # spec.add_dependency "capistrano-rsync", "~> 1.0.2" # broken, wait update
  spec.add_dependency "capistrano-rails", "~> 1.1.8"
  spec.add_development_dependency "capistrano-sidekiq", Capsum::CAPISTRANO_SIDEKIQ_REQUIREMENT # optional

  # spec.add_dependency "capistrano-helpers", "~> 0.7.1"
  # spec.add_dependency "cap-recipes", "~> 0.3.36"
  # https://github.com/rubaidh/rubaidhstrano
  # https://github.com/relevance/cap_gun
  # https://github.com/railsmachine/capistrano-cowboy
  # https://github.com/fnichol/capstrap
  # https://github.com/bokmann/dunce-cap

  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", ">= 1.6.1"
end
