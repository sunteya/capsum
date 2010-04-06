# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{capsum}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sunteya"]
  s.date = %q{2010-04-06}
  s.email = %q{Sunteya@gmail.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "README",
     "Rakefile",
     "VERSION",
     "depends.rb",
     "lib/capsum.rb",
     "lib/capsum/delayed_job.rb",
     "lib/capsum/passenger.rb"
  ]
  s.homepage = %q{http://github.com/sunteya/capsum}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Collect gems and recipes related capistrano.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gem_loader>, [">= 0.2.0"])
      s.add_runtime_dependency(%q<capistrano>, [">= 2.5.14"])
      s.add_runtime_dependency(%q<capistrano_colors>, [">= 0.5.2"])
      s.add_runtime_dependency(%q<capistrano-ext>, [">= 1.2.1"])
      s.add_runtime_dependency(%q<capistrano-helpers>, [">= 0.3.2"])
    else
      s.add_dependency(%q<gem_loader>, [">= 0.2.0"])
      s.add_dependency(%q<capistrano>, [">= 2.5.14"])
      s.add_dependency(%q<capistrano_colors>, [">= 0.5.2"])
      s.add_dependency(%q<capistrano-ext>, [">= 1.2.1"])
      s.add_dependency(%q<capistrano-helpers>, [">= 0.3.2"])
    end
  else
    s.add_dependency(%q<gem_loader>, [">= 0.2.0"])
    s.add_dependency(%q<capistrano>, [">= 2.5.14"])
    s.add_dependency(%q<capistrano_colors>, [">= 0.5.2"])
    s.add_dependency(%q<capistrano-ext>, [">= 1.2.1"])
    s.add_dependency(%q<capistrano-helpers>, [">= 0.3.2"])
  end
end

