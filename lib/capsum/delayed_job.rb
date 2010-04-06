require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
 
  namespace :delayed_job do
    desc "Start delayed_job process" 
    task :start, :roles => :app do
      run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start" 
    end

    desc "Stop delayed_job process" 
    task :stop, :roles => :app do
      run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop" 
    end

    desc "Restart delayed_job process" 
    task :restart, :roles => :app do
      run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job restart" 
    end
  end

  after "deploy:start", "delayed_job:start" 
  after "deploy:stop", "delayed_job:stop" 
  after "deploy:restart", "delayed_job:restart"

end