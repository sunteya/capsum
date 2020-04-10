require "capsum"

namespace :load do
  task :defaults do
    # use current branch
    set :branch, -> { `git rev-parse --abbrev-ref HEAD`.chomp }

    # use current remote repo url
    set :repo_url, -> {
      remote = `git config --get branch.#{fetch(:branch)}.remote | tr -d '\n'`
      `git config --get remote.#{remote}.url | tr -d '\n'`
    }

    set :repo_url, ENV['repo_url'] if ENV['repo_url']

    # TODO: set :scm_verbose, true
  end
end
