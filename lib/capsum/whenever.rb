require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  namespace :whenever do
    desc 'Update the crontab'
    task :update_crontab, :roles => :db do
      command = "if [ -e #{current_path}/config/schedule.rb ]; then cd #{current_path}; RAILS_ENV=#{rails_env} whenever --update-crontab #{application} --set primary=%s; fi"
      run (command % true), :only => { :primary => true }
      run (command % false), :except => { :primary => true }
    end
  end
end
