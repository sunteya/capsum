# require File.expand_path("../../capsum.rb", __FILE__)
# require File.expand_path("../setup.rb", __FILE__)
require File.expand_path("../git.rb", __FILE__)
# require File.expand_path("../shared.rb", __FILE__)

# Capistrano::Configuration.instance.load do
# set :use_sudo, false

  # default_environment["http_proxy"] = fetch("http_proxy") if exists?("http_proxy")
  # default_environment["https_proxy"] = fetch("https_proxy") if exists?("https_proxy")
  # after "deploy:update", "deploy:cleanup"
# end
#

if spec = Gem.loaded_specs["capistrano-rsync"]
  raise "capsum don't compatible 'capistrano-rsync' gem, please remove capistrano-rsync depend. because it uses a modified version of capistrano-rsync script. "
end
set :scm, :rsync
set :rsync_options, %w[--recursive --delete]