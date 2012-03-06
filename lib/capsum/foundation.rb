require File.expand_path("../../capsum.rb", __FILE__)
require "capistrano/ext/multistage"
require File.expand_path("../git.rb", __FILE__)
require File.expand_path("../shared.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  set :use_sudo, false

  set :deploy_via, :copy
  set :copy_strategy, :export
  set :copy_compression, :bz2
  
  default_environment["http_proxy"] = fetch("http_proxy") if exists?("http_proxy")
  after "deploy:update", "deploy:cleanup"
end
