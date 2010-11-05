require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  
  namespace :daemons do
    desc "Start daemons process" 
    task :start, :roles => :app do
      daemons = fetch(:daemons, [])
      find_servers(:roles => :app).each do |server|
        daemons_settings = server.options[:daemons]
        
        daemons.each do |daemon|
          runnable = daemons_settings
          runnable = daemons_settings.match(daemon) if daemons_settings.respond_to?(:match)
          
          run("cd #{current_path}; if [ -e #{daemon} ]; then RAILS_ENV=#{rails_env} #{daemon} start; fi", :hosts => server.host) if runnable
        end
        
      end
    end

    desc "Stop daemons process" 
    task :stop, :roles => :app do
      daemons = fetch(:daemons, [])
      daemons.each do |daemon|
        run "cd #{current_path}; if [ -e #{daemon} ]; then RAILS_ENV=#{rails_env} #{daemon} stop; fi" 
      end
    end

    desc "Restart daemons process" 
    task :restart, :roles => :app do
      daemons.stop
      sleep(4)
      daemons.start
    end
  end

  after "deploy:start", "daemons:start" 
  after "deploy:stop", "daemons:stop" 
  after "deploy:restart", "daemons:restart"

end

