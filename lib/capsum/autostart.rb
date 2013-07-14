require File.expand_path("../../capsum.rb", __FILE__)
require File.expand_path("../whenever.rb", __FILE__)

Capistrano::Configuration.instance(true).load do

  _cset(:autostart_server_commands, {})
  _cset(:autostart_schedule_file) { "schedule.daemons.rb" }
  _cset(:autostart_identifier) { "#{deploy_to}#daemons" }
  _cset(:autostart_whenever_update_command) { "#{whenever_command} --update-crontab #{autostart_identifier} --load-file #{autostart_schedule_file}" }
  _cset(:autostart_whenever_clear_command)  { "#{whenever_command} --clear-crontab  #{autostart_identifier} --load-file /dev/null; true" }
  _cset(:autostart_whenever_command) { "if [ -e #{autostart_schedule_file} ]; then #{autostart_whenever_update_command}; else #{autostart_whenever_clear_command}; fi" }

  namespace :autostart do
    task :update_crontab do
      on_rollback do
        if fetch(:previous_release)
          run "cd #{previous_release} && #{autostart_whenever_command}"
        else
          run "cd #{release_path} && #{autostart_whenever_clear_command}"
        end
      end

      autostart_server_commands.each_pair do |server, commands|
        next if commands.empty?
        schedule_content=<<-EOF
          every(:reboot) do
            #{commands.map{ |cmd| "  command #{cmd.inspect}" }.join("\n")}
          end
        EOF

        top.put schedule_content, File.join(release_path, autostart_schedule_file), hosts: server.host
      end
      run "cd #{release_path} && #{autostart_whenever_command}"
    end

    task :rollback do
      run "cd #{previous_release} && #{autostart_whenever_command}"
    end
  end

  before "deploy:finalize_update", "autostart:update_crontab"
  after "deploy:rollback", "autostart:rollback"
end

