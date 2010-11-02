require File.expand_path("../../capsum.rb", __FILE__)

require File.expand_path("../typical.rb", __FILE__)
require "bundler/capistrano"

Capistrano::Configuration.instance(true).load do
  set :bundle_flags, "--quiet"
  set :bundle_dir, ""
end
