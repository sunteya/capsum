require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  
  set :scm, "git"
  
  # use current branch
  set(:branch) { `git describe --contains --all HEAD | tr -d '\n'` }

  # use current remote
  set(:repository) do
    remote = `git config --get branch.#{self.branch}.remote | tr -d '\n'`
    `git config --get remote.#{remote}.url | tr -d '\n'`
  end
  
  set :scm_verbose, true
  
end
