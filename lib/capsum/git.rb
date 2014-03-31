# require File.expand_path("../../capsum.rb", __FILE__)

namespace :load do
  task :defaults do
    # use current branch
    set :branch, -> { `git describe --contains --all HEAD | tr -d '\n'` }

    # use current remote
    set :repo_url, -> {
      remote = `git config --get branch.#{fetch(:branch)}.remote | tr -d '\n'`
      `git config --get remote.#{remote}.url | tr -d '\n'`
    }

    set :repo_url, ENV['repo_url'] if ENV['repo_url']

    # # TODO: set :scm_verbose, true
  end
end