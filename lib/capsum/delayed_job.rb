require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  
  namespace :delayed_job do
    desc "Start delayed_job process" 
    task :start, :roles => :app do
      run "if [ -e #{current_path}/script/delayed_job ]; then cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start; fi" 
    end

    desc "Stop delayed_job process" 
    task :stop, :roles => :app do
      run "if [ -e #{current_path}/script/delayed_job ]; then cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop; fi" 
    end

    desc "Restart delayed_job process" 
    task :restart, :roles => :app do
      delayed_job.stop
      sleep(4)
      delayed_job.start
    end
  end

  after "deploy:start", "delayed_job:start" 
  after "deploy:stop", "delayed_job:stop" 
  after "deploy:restart", "delayed_job:restart"

end

