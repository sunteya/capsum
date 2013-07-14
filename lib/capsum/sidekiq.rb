require File.expand_path("../../capsum.rb", __FILE__)
require File.expand_path("../autostart.rb", __FILE__)
require 'sidekiq/capistrano'


Capistrano::Configuration.instance(true).load do
  namespace :sidekiq do

    desc "setup sidekiq daemon to autostart"
    task :setup_autostart do
      autostart_server_commands = fetch(:autostart_server_commands)
      rails_env = fetch(:rails_env, "production")
      find_servers(roles: fetch(:sidekiq_role)).each do |server|
        autostart_server_commands[server] ||= []
        for_each_process do |pid_file, idx|
          autostart_server_commands[server] << "cd #{current_path} ; nohup #{fetch(:sidekiq_cmd)} -e #{rails_env} -C #{current_path}/config/sidekiq.yml -i #{idx} -P #{pid_file} >> #{current_path}/log/sidekiq.log 2>&1 &"
        end
      end
    end
  end

  before "autostart:update_crontab", "sidekiq:setup_autostart" 
end
