require File.expand_path("../../capsum.rb", __FILE__)
require "bundler/deployment"

Capistrano::Configuration.instance(true).load do
  set :bundle_flags, "--quiet"
  set :bundle_dir, ""
  
  Bundler::Deployment.define_task(self, :task, :except => { :no_release => true })

  after "deploy:symlink_shared", "bundle:install"
end

