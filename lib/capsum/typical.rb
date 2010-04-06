require File.expand_path("../../capsum.rb", __FILE__)
require "capistrano/ext/multistage"
require "capistrano-helpers/shared"
require "capistrano-helpers/git"
require "capsum/passenger"
require "capsum/delayed_job"

Capistrano::Configuration.instance(true).load do
  set :rails_env, "production"
  set :use_sudo, false
  
  # default for :deploy_via, :copy
  set :copy_strategy, :export
  set :copy_compression, :bz2
end