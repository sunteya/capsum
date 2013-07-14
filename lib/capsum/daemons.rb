require File.expand_path("../../capsum.rb", __FILE__)
require File.expand_path("../autostart.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  
  namespace :daemons do
    desc "Start daemons process" 
    task :start, :roles => :app do
      find_servers(:roles => :app).each do |server|
        matcher = server.options[:daemons]
        daemon_list.each do |daemon|
          run "cd #{current_path}; #{daemon[:start]}", :pty => (daemon[:pty] || false), :hosts => server.host if match(matcher, daemon)
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
    
    desc "setup daemons to autostart"
    task :setup_autostart, :roles => :app do
      autostart_server_commands = fetch(:autostart_server_commands)

      find_servers(:roles => :app).each do |server|
        autostart_server_commands[server] ||= []
        
        daemon_list.each do |daemon|
          autostart_server_commands[server] << "cd #{current_path}; #{daemon[:start]}" if match(matcher, daemon)
        end
      end
    end
    
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

  before "autostart:update_crontab", "daemons:setup_autostart" 

  after "deploy:start", "daemons:start" 
  after "deploy:stop", "daemons:stop" 
  after "deploy:restart", "daemons:restart"
end

