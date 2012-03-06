require File.expand_path("../../capsum.rb", __FILE__)
require "bundler/capistrano"

Capistrano::Configuration.instance(true).load do
  set :bundle_dir, nil
  set :bundle_flags, "--quiet"
end

