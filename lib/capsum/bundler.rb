require File.expand_path("../../capsum.rb", __FILE__)
require "bundler/deployment"

Capistrano::Configuration.instance(true).load do
  
  set :bundle_flags, "--quiet #{fetch(:bundle, '')}"
  set :bundle_dir, ""
  set(:current_release) { fetch(:release_path) }
  
  Bundler::Deployment.define_task(self, :task, :except => { :no_release => true })

  after "deploy:symlink_shared", "bundle:install"
end

