require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  namespace :deploy do
    desc 'Restart passenger'
    task :restart, :roles => :app do
      run "touch #{current_path}/tmp/restart.txt"
    end
  end
end
