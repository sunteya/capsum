require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  
  namespace :daemons do
    desc "Start daemons process" 
    task :start, :roles => :app do
      find_servers(:roles => :app).each do |server|
        matcher = server.options[:daemons]
        daemon_list.each do |daemon|
          run "cd #{current_path}; #{daemon[:start]}", :hosts => server.host if match(matcher, daemon)
        end
      end
    end
    
    desc "Stop daemons process" 
    task :stop, :roles => :app do
      daemon_list.each do |daemon|
        run "cd #{current_path}; #{daemon[:stop]}" 
      end
    end

    desc "Restart daemons process" 
    task :restart, :roles => :app do
      daemons.stop
      sleep(3)
      daemons.start
    end
    
    desc "install daemons to cron"
    task :update_cron, :roles => :app do
      find_servers(:roles => :app).each do |server|
        
        identifier = "#{deploy_to}#daemons"
        schedule_file_path = "%{schedule_dir}/schedule.daemons.rb"
        
        whenever_clear_command  = "if [ type whenever > /dev/null 2>&1 ]; then whenever --clear-crontab #{identifier} --load-file /dev/null; fi"
        whenever_update_command = "whenever --update-crontab #{identifier} --load-file #{schedule_file_path}"
        
        command = "if [ -e #{schedule_file_path} ]; then #{whenever_update_command}; else #{whenever_clear_command}; fi"
        
        # on_rollback do
        #   schedule_dir = fetch(:previous_release) || release_path
        #   run (command % { :schedule_dir => schedule_dir }), :hosts => server.host
        # end
        
        matcher = server.options[:daemons]
        daemon_commands = daemon_list.map do |daemon|
          "cd #{current_path}; #{daemon[:start]}" if match(matcher, daemon)
        end.compact
        
        if !daemon_commands.empty?
          schedule_content=<<-EOF
every(:reboot) do
#{daemon_commands.map{ |cmd| "  command #{cmd.inspect}" }.join("\n")}
end
EOF
          top.put schedule_content, (schedule_file_path % { :schedule_dir => release_path }), :hosts => server.host
        end
        
        run (command % { :schedule_dir => release_path }), :hosts => server.host
      end
    end
    
    after "deploy:create_symlink", "daemons:update_cron" 
    after "deploy:rollback", "daemons:update_cron"
    
    after "deploy:start", "daemons:start" 
    after "deploy:stop", "daemons:stop" 
    after "deploy:restart", "daemons:restart"
    
    def match(matcher, daemon)
      return matcher.call(daemon[:name]) if matcher.respond_to?(:call)
      return matcher.match(daemon[:name]) if matcher.respond_to?(:match)
      
      !!matcher # to boolean
    end
    
    def daemon_list
      settings = fetch(:daemons, [])
      
      case settings
      when Array
        settings.map { |setting| parse_daemon(setting) }
      when Hash
        settings.map { |pair| parse_daemon(pair[1], :name => pair[0] )}
      else
        [ parse_daemon(settings) ]
      end
    end
    
    def parse_daemon(source, options = {})
      daemon = {}
      
      case source
      when Array
        daemon[:start] = source.first
        daemon[:stop] = source.last
      when Hash
        daemon = options.merge(source)
      else
        command = source.to_s
        daemon[:start] = command.gsub("%{command}", "start")
        daemon[:stop] = command.gsub("%{command}", "stop")
      end
      
      daemon[:name] = daemon[:start] if daemon[:name].nil?
      daemon
    end
  end

end

