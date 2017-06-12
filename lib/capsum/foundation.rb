require "capsum"
require "capsum/git"
require "capsum/shared"
require "capistrano/console"
require "capistrano/rsync"
require File.expand_path("../remote_env.rb", __FILE__)

namespace :load do
  task :defaults do
    if spec = Gem.loaded_specs["capistrano-rsync"]
      raise "capsum don't compatible 'capistrano-rsync' gem, please remove capistrano-rsync depend. because it uses a modified version of capistrano-rsync script. "
    end

    fetch(:linked_files) { set :linked_files, [] }
    fetch(:linked_dirs) { set :linked_dirs, [] }

    set :scm, :rsync

    remote_env[:https_proxy] = remote_env[:http_proxy] = ENV["proxy"] if ENV["proxy"]
  end
end

module Capistrano
  module DSL
    def default_env
      fetch(:default_env)
    end
  end
end
