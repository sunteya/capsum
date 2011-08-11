require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  
  set :scm, "git"
  
  # use current branch
  set(:branch), { `git describe --contains --all HEAD` }
  
  set :scm_verbose, true
  
end
