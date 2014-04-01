require File.expand_path("../../capsum.rb", __FILE__)
require File.expand_path("../git.rb", __FILE__)
require File.expand_path("../shared.rb", __FILE__)
require "capistrano/rsync"

namespace :load do
  task :defaults do
    if spec = Gem.loaded_specs["capistrano-rsync"]
      raise "capsum don't compatible 'capistrano-rsync' gem, please remove capistrano-rsync depend. because it uses a modified version of capistrano-rsync script. "
    end

    fetch(:linked_files) { set :linked_files, [] }
    fetch(:linked_dirs) { set :linked_dirs, [] }

    set :scm, :rsync
    set :rsync_options, %w[--recursive --delete]

    default_env[:http_proxy] = ENV["http_proxy"] if ENV["http_proxy"]
    default_env[:https_proxy] = ENV["https_proxy"] if ENV["https_proxy"]
  end
end

module Capistrano
  module DSL
    def default_env
      fetch(:default_env)
    end
  end
end
