require "capistrano/bundler"

namespace :load do
  task :defaults do
    set :bundle_flags, '--quiet'
  end
end