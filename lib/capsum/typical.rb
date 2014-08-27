require "capsum/foundation"
require "capsum/bundler"
require 'capistrano/rails'
require "capsum/passenger"
require "capsum/whenever"
require "capsum/daemons.rb"

# require File.expand_path("../cache.rb", __FILE__)

namespace :load do
  task :defaults do
    set :rails_env, "production"

    fetch(:linked_dirs).concat %w[
      log
      tmp/pids
      tmp/cache
    ]
  end
end
