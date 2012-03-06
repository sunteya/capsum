require File.expand_path("../../capsum.rb", __FILE__)
require "capistrano-helpers/shared"

Capistrano::Configuration.instance(true).load do
  
  unafter "deploy:update_code", "deploy:symlink_shared"
  before 'deploy:finalize_update', 'deploy:symlink_shared'
end
