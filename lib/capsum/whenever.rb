require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  namespace :whenever do
    desc 'Update the crontab'
    task :update, :roles => :db do
      command = "if [ -e #{current_path}/config/schedule.rb ]; then cd #{current_path}; RAILS_ENV=#{rails_env} whenever --update-crontab #{application} --set primary=%s; fi"
      run (command % true), :only => { :primary => true }
      run (command % false), :except => { :primary => true }
    end
    
    desc 'Cleanup the crontab'
    task :cleanup, :roles => :db do
      run "if [ -e #{current_path}/config/schedule.rb ]; then cd #{current_path}; RAILS_ENV=#{rails_env} whenever --update-crontab #{application} --load-file /dev/null; fi"
    end
  end
  
  after "deploy:symlink", "whenever:update" 
end
