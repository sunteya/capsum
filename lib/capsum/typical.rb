require File.expand_path("../../capsum.rb", __FILE__)
require "capistrano/ext/multistage"
require "capistrano-helpers/shared"

require File.expand_path("../git.rb", __FILE__)
require File.expand_path("../bundler.rb", __FILE__)

require File.expand_path("../passenger.rb", __FILE__)
require File.expand_path("../whenever.rb", __FILE__)
require File.expand_path("../daemons.rb", __FILE__)
require File.expand_path("../cache.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  set :rails_env, "production"
  set :use_sudo, false

  set :deploy_via, :copy
  set :copy_strategy, :export
  set :copy_compression, :bz2
  
  default_environment["http_proxy"] = fetch("http_proxy") if exists?("http_proxy")
  
end