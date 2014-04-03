require "capsum"
require "capistrano/bundler"

namespace :load do
  task :defaults do
    set :bundle_flags, '--quiet'
    set :bundle_env_variables, {}

    bundle_env_variables[:http_proxy] = ENV["bundle_http_proxy"] if ENV["bundle_http_proxy"]
    bundle_env_variables[:https_proxy] = ENV["bundle_https_proxy"] if ENV["bundle_https_proxy"]
  end
end

module Capistrano
  module DSL
    def bundle_env_variables
      fetch(:bundle_env_variables)
    end
  end
end
