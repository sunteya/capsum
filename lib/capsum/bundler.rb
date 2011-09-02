require File.expand_path("../../capsum.rb", __FILE__)
require "bundler/deployment"

Capistrano::Configuration.instance(true).load do
  
  set :bundle_flags, "--quiet #{fetch(:bundle_opts, '')}"
  set :bundle_dir, ""
  set(:current_release) { fetch(:release_path) }
  
  set(:bundle_cmd) do
    gemfile = fetch(:bundle_gemfile, "Gemfile")
    "test -f #{File.join(current_release, gemfile)} && bundle"
  end

  Bundler::Deployment.define_task(self, :task, :except => { :no_release => true })
  after "deploy:symlink_shared", "bundle:install"
  
end

